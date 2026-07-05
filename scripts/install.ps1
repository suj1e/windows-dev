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
    Write-Host "[1/4] 安装 CLI 工具..." -ForegroundColor Yellow

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
    Write-Host "[2/4] 配置 mise..." -ForegroundColor Yellow

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
    Write-Host "[3/4] 配置 starship..." -ForegroundColor Yellow

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
# 4. 配置 Git、SSH、PowerShell Profile、Claude
# ============================================
if (-not $SkipConfig) {
    Write-Host "[4/4] 配置 Git、SSH、PowerShell Profile、Claude..." -ForegroundColor Yellow

    # Git 配置
    $gitConfigSource = "$PSScriptRoot\..\config\git\gitconfig"
    $gitConfigTarget = "$env:USERPROFILE\.gitconfig"
    if (-not (Test-Path $gitConfigTarget)) {
        Copy-Item $gitConfigSource -Destination $gitConfigTarget -Force
        Write-Host "  ✓ .gitconfig 已复制" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  .gitconfig 已存在，跳过" -ForegroundColor Gray
    }

    # SSH 配置
    $sshDir = "$env:USERPROFILE\.ssh"
    $sshConfigSource = "$PSScriptRoot\..\config\ssh\config"
    $sshConfigTarget = "$sshDir\config"
    if (-not (Test-Path $sshConfigTarget)) {
        if (-not (Test-Path $sshDir)) {
            New-Item -ItemType Directory -Path $sshDir -Force | Out-Null
            $acl = Get-Acl $sshDir
            $acl.SetAccessRuleProtection($true, $false)
            $rule = New-Object System.Security.AccessControl.FileSystemAccessRule("$env:USERNAME", "FullControl", "ContainerInherit,ObjectInherit", "None", "Allow")
            $acl.AddAccessRule($rule)
            Set-Acl $sshDir $acl
        }
        Copy-Item $sshConfigSource -Destination $sshConfigTarget -Force
        Write-Host "  ✓ .ssh/config 已复制" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  .ssh/config 已存在，跳过" -ForegroundColor Gray
    }

    # PowerShell Profile
    $profileDir = Split-Path -Parent $PROFILE.CurrentUserAllHosts
    $profileSource = "$PSScriptRoot\..\config\powershell\Microsoft.PowerShell_profile.ps1"
    $profileTarget = $PROFILE.CurrentUserAllHosts
    if (-not (Test-Path $profileTarget)) {
        if (-not (Test-Path $profileDir)) {
            New-Item -ItemType Directory -Path $profileDir -Force | Out-Null
        }
        Copy-Item $profileSource -Destination $profileTarget -Force
        Write-Host "  ✓ PowerShell Profile 已复制" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  PowerShell Profile 已存在，跳过" -ForegroundColor Gray
    }

    # Claude Code 配置
    $claudeConfigSource = "$PSScriptRoot\..\config\claude\settings.json"
    $claudeConfigTarget = "$env:USERPROFILE\.claude\settings.json"
    if (-not (Test-Path $claudeConfigTarget)) {
        if (-not (Test-Path "$env:USERPROFILE\.claude")) {
            New-Item -ItemType Directory -Path "$env:USERPROFILE\.claude" -Force | Out-Null
        }
        Copy-Item $claudeConfigSource -Destination $claudeConfigTarget -Force
        Write-Host "  ✓ Claude settings.json 已复制" -ForegroundColor Green
    } else {
        Write-Host "  ℹ️  Claude settings.json 已存在，跳过" -ForegroundColor Gray
    }

    Write-Host "`n✓ 配置复制完成`n" -ForegroundColor Green
}

# ============================================
# 完成
# ============================================
Write-Host "=== 安装完成 ===" -ForegroundColor Cyan
Write-Host "`n下一步:" -ForegroundColor Yellow
Write-Host "  1. 重启 PowerShell 或运行 `. `$PROFILE` 加载配置"
Write-Host "  2. 安装 WezTerm: https://wezfurlong.org/wezterm/installation.html"
Write-Host "  3. 运行 `mise install` 安装所有语言版本`n"
