# Windows 开发环境冗余清理脚本
# 清理手动安装的、与 WinGet 管理的工具冲突的文件和目录
#
# 使用方式:
#   powershell -ExecutionPolicy Bypass -File scripts/cleanup.ps1        # 实际执行
#   powershell -ExecutionPolicy Bypass -File scripts/cleanup.ps1 -DryRun # 预览模式

param(
    [switch]$DryRun
)

$ErrorActionPreference = "Stop"

function Write-Step($msg) {
    Write-Host ""
    Write-Host "[STEP] $msg" -ForegroundColor Cyan
}

function Write-Ok($msg) {
    Write-Host "  ✓ $msg" -ForegroundColor Green
}

function Write-Skip($msg) {
    Write-Host "  ⊘ $msg" -ForegroundColor Gray
}

function Write-Warn($msg) {
    Write-Host "  ⚠️ $msg" -ForegroundColor Yellow
}

function Remove-IfExists($path, $label) {
    if (-not (Test-Path $path)) {
        Write-Skip "$label 不存在，跳过"
        return $false
    }

    if ($DryRun) {
        Write-Warn "[DryRun] 将删除: $path"
        return $true
    }

    try {
        if ((Get-Item $path) -is [System.IO.DirectoryInfo]) {
            Remove-Item $path -Recurse -Force
        } else {
            Remove-Item $path -Force
        }
        Write-Ok "已删除: $label ($path)"
        return $true
    } catch {
        Write-Warn "删除失败: $path ($($_.Exception.Message))"
        return $false
    }
}

function Invoke-WingetUninstall($id, $label) {
    if ($DryRun) {
        Write-Warn "[DryRun] 将卸载: $label ($id)"
        return $true
    }

    Write-Host "  卸载 $label ..." -ForegroundColor Gray
    try {
        winget uninstall --id $id --silent | Out-Null
        Write-Ok "已卸载: $label"
        return $true
    } catch {
        Write-Warn "卸载失败: $label ($($_.Exception.Message))"
        return $false
    }
}

# ============================================
# 开始
# ============================================
Write-Host ""
Write-Host "=== Windows 开发环境清理 ===" -ForegroundColor Cyan
if ($DryRun) {
    Write-Host "模式: 预览（不会实际删除）" -ForegroundColor Yellow
    Write-Host ""
}

$deleted = 0
$skipped = 0
$failed = 0

# ============================================
# 1. C:\Users\13156\bin\ 中被 WinGet links 覆盖的文件
# ============================================
Write-Step "清理 C:\Users\13156\bin\ 冗余文件"

$binItems = @(
    @{ Path = "$env:USERPROFILE\bin\jq.exe";      Label = "jq.exe" },
    @{ Path = "$env:USERPROFILE\bin\zellij.exe";  Label = "zellij.exe" }
)

foreach ($item in $binItems) {
    $result = Remove-IfExists $item.Path $item.Label
    if ($result) { $deleted++ } else { $skipped++ }
}

# ============================================
# 2. D:\opt\maven\ — 旧版手动安装
# ============================================
Write-Step "清理 D:\opt\maven\ 旧版 Maven"

$mavenResult = Remove-IfExists "D:\opt\maven\apache-maven-3.6.3" "Maven 3.6.3"
if ($mavenResult) { $deleted++ } else { $skipped++ }

# ============================================
# 3. Eclipse Adoptium JDK 11（winget 管理）
# ============================================
Write-Step "卸载 Eclipse Adoptium JDK 11（mise 将管理 JDK 8）"

$jdknResult = Invoke-WingetUninstall "EclipseAdoptium.Temurin.11.JDK" "Eclipse Adoptium JDK 11"
if ($jdknResult) { $deleted++ } else { $failed++ }

# ============================================
# 完成
# ============================================
Write-Host ""
Write-Host "=== 清理完成 ===" -ForegroundColor Cyan
Write-Host "  删除/卸载: $deleted" -ForegroundColor Green
Write-Host "  跳过: $skipped" -ForegroundColor Gray
Write-Host "  失败: $failed" -ForegroundColor Yellow

if (-not $DryRun) {
    Write-Host ""
    Write-Host "下一步:" -ForegroundColor Yellow
    Write-Host "  1. 运行 install.ps1 安装缺失工具: powershell -ExecutionPolicy Bypass -File scripts/install.ps1"
    Write-Host "  2. 重启 PowerShell 或运行 `. `$PROFILE` 加载配置"
    Write-Host ""
} else {
    Write-Host ""
    Write-Host "这是预览模式，没有任何实际删除。去掉 -DryRun 参数执行实际清理。" -ForegroundColor Yellow
    Write-Host ""
}
