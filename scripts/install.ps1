# Windows 开发环境一键安装脚本
# 使用 winget 安装所有 CLI 工具
# 运行: powershell -ExecutionPolicy Bypass -File install.ps1

param(
    [switch]$SkipTools,
    [switch]$SkipConfig
)

$ErrorActionPreference = "Stop"

Write-Host "`n=== Windows 开发环境安装 ===" -ForegroundColor Cyan
Write-Host "PowerShell: $($PSVersionTable.PSVersion)`n" -ForegroundColor Gray

# ============================================
# 1. 安装 CLI 工具
# ============================================
if (-not $SkipTools) {
    Write-Host "[1/3] 安装 CLI 工具..." -ForegroundColor Yellow

    $tools = @(
        # 终端 / Shell
        "Microsoft.PowerShell",
        "Wez.Fetch",
        "Starship.Starship",

        # 文件操作
        "eza-community.eza",
        "sharkdp.bat",
        "sharkdp.fd",
        "BurntSushi.ripgrep.MSVC",
        "dandavison.delta",

        # 导航 / 搜索
        "ajeetdsouza.zoxide",
        "junegunn.fzf",
        "tldr-pages.tldr",

        # Git
        "Git.Git",
        "JesseDuffield.lazygit",

        # 开发工具
        "jqlang.jq",
        "casey.just",
        "tstack.lnav",
        "aristocratos.btop",
        "bootandy.dust",
        "dalance.procs",
        "sharkdp.hyperfine",
        "chmln.sd",
        "ducaale.xh",
        "mikefarah.yq",

        # 环境管理
        "jdx.mise",
        "direnv.direnv",

        # Docker
        "JesseDuffield.lazydocker",

        # 编辑器
        "Neovim.Neovim",

        # 终端复用
        "zellij-org.zellij",

        # GitHub CLI
        "GitHub.cli",

        # 字体
        "JetBrains.JetBrainsMono.NerdFont"
    )

    foreach ($tool in $tools) {
        Write-Host "  安装 $tool ..." -ForegroundColor Gray
        try {
            winget install --id $tool --accept-source-agreements --accept-package-agreements --silent | Out-Null
            Write-Host "  ✓ $tool" -ForegroundColor Green
        } catch {
            Write-Host "  ⚠️  跳过: $tool ($($_.Exception.Message))" -ForegroundColor Yellow
        }
    }

    Write-Host "`n✓ CLI 工具安装完成`n" -ForegroundColor Green
}

# ============================================
# 2. 配置 mise
# ============================================
if (-not $SkipConfig) {
    Write-Host "[2/3] 配置 mise..." -ForegroundColor Yellow

    $miseConfigDir = "$env:USERPROFILE\.config\mise"
    $miseConfigFile = "$miseConfigDir\config.toml"

    if (-not (Test-Path $miseConfigFile)) {
        New-Item -ItemType Directory -Path $miseConfigDir -Force | Out-Null
        @"
[tools]
bun = "latest"
go = "1.24"
java = "21"
node = "22"
python = "3.13"
"@ | Out-File -FilePath $miseConfigFile -Encoding utf8
        Write-Host "  ✓ mise 配置已创建" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  mise 配置已存在，跳过" -ForegroundColor Gray
    }

    # 安装 mise 管理的版本
    Write-Host "  安装语言版本（这可能需要几分钟）..." -ForegroundColor Gray
    try {
        & mise install | Out-Null
        Write-Host "  ✓ 语言版本安装完成" -ForegroundColor Green
    } catch {
        Write-Host "  ⚠️  mise install 失败: $($_.Exception.Message)" -ForegroundColor Yellow
    }

    Write-Host "`n✓ mise 配置完成`n" -ForegroundColor Green
}

# ============================================
# 3. 配置 starship
# ============================================
if (-not $SkipConfig) {
    Write-Host "[3/3] 配置 starship..." -ForegroundColor Yellow

    $starshipConfigDir = "$env:USERPROFILE\.config\starship"
    $starshipConfigFile = "$starshipConfigDir\starship.toml"

    if (-not (Test-Path $starshipConfigFile)) {
        New-Item -ItemType Directory -Path $starshipConfigDir -Force | Out-Null
        Copy-Item "$PSScriptRoot\..\config\starship\starship.toml" -Destination $starshipConfigFile -Force
        Write-Host "  ✓ starship 配置已复制" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  starship 配置已存在，跳过" -ForegroundColor Gray
    }

    Write-Host "`n✓ starship 配置完成`n" -ForegroundColor Green
}

# ============================================
# 完成
# ============================================
Write-Host "=== 安装完成 ===" -ForegroundColor Cyan
Write-Host "`n下一步:" -ForegroundColor Yellow
Write-Host "  1. 重启 PowerShell 或运行 ````. `$PROFILE```` 加载配置"
Write-Host "  2. 安装 WezTerm: https://wezfurlong.org/wezterm/installation.html"
Write-Host "  3. 复制 wezterm.lua 到 WezTerm 配置目录"
Write-Host "  4. 运行 ````mise install```` 安装所有语言版本`n"
