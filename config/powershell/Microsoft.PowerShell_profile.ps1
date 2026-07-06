# PowerShell Profile — Windows / WezTerm
# 加载 mise、starship、zoxide 等工具

# direnv / 部分 Unix 工具依赖 HOME，Windows 默认未设置
$env:HOME = $env:USERPROFILE

# UTF-8（中文路径、Python 输出）
$env:PYTHONIOENCODING = "utf-8"
$utf8 = [System.Text.UTF8Encoding]::new($false)
[Console]::InputEncoding = $utf8
[Console]::OutputEncoding = $utf8
$OutputEncoding = $utf8

# 确保 mise 的 shims 在 PATH 最前面
$env:PATH = "$env:LOCALAPPDATA\mise\shims;$env:PATH"

# npm 全局命令（claude 等）— Windows 不会自动加入 PATH
if (Get-Command npm -ErrorAction SilentlyContinue) {
    $npmGlobal = npm prefix -g 2>$null
    if ($npmGlobal -and (Test-Path $npmGlobal)) {
        $env:PATH = "$npmGlobal;$env:PATH"
    }
}

# 别名 / 函数（对齐 macOS zshrc）
if (Get-Command eza -ErrorAction SilentlyContinue) {
    function ls { eza @args }
    function ll { eza -l --icons --git --group-directories-first @args }
    function la { eza -la --icons --git --group-directories-first @args }
    function lt { eza -T --icons @args }
}
if (Get-Command bat -ErrorAction SilentlyContinue) {
    function cat { bat --paging=never @args }
    function less { bat --paging=always @args }
}
if (Get-Command fd -ErrorAction SilentlyContinue) {
    function find { fd @args }
}
if (Get-Command rg -ErrorAction SilentlyContinue) {
    function grep { rg @args }
}
if (Get-Command lazygit -ErrorAction SilentlyContinue) {
    Set-Alias -Name lg -Value lazygit -Force
}
if (Get-Command nvim -ErrorAction SilentlyContinue) {
    Set-Alias -Name vim -Value nvim -Force
}

function global:.. { Set-Location .. }
function global:... { Set-Location ..\.. }
if (Get-Command dust -ErrorAction SilentlyContinue) {
    function du { dust @args }
}
if (Get-Command procs -ErrorAction SilentlyContinue) {
    function psg { procs @args }
}

# PSReadLine + fzf 历史搜索
if (Get-Module -ListAvailable PSReadLine) {
    Import-Module PSReadLine
    Set-PSReadLineOption -EditMode Emacs -ErrorAction SilentlyContinue
    if ($env:TERM -ne 'dumb' -and -not [Console]::IsOutputRedirected) {
        try {
            Set-PSReadLineOption -PredictionSource History
            Set-PSReadLineOption -PredictionViewStyle ListView
        } catch { }
    }

    if (Get-Command fzf -ErrorAction SilentlyContinue) {
        Set-PSReadLineKeyHandler -Key Ctrl+r -BriefDescription 'Search history with fzf' -ScriptBlock {
            $history = (Get-History).CommandLine |
                Where-Object { $_ } |
                Select-Object -Unique
            $selected = $history | fzf --height 40% --reverse --inline-info
            if ($selected) {
                [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
                [Microsoft.PowerShell.PSConsoleReadLine]::Insert($selected)
            }
        }
    }
}

# 初始化 starship
if (Get-Command starship -ErrorAction SilentlyContinue) {
    Invoke-Expression (&starship init powershell --print-full-init | Out-String)
}

# 初始化 zoxide
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (&zoxide init powershell | Out-String)
}

# 初始化 direnv（Windows 上 shell 名是 pwsh，不是 powershell）
if (Get-Command direnv -ErrorAction SilentlyContinue) {
    $direnvHook = & direnv hook pwsh 2>$null | Out-String
    if ($direnvHook) {
        Invoke-Expression $direnvHook
    }
}

# 设置编辑器和分页器
$env:EDITOR = "nvim"
$env:PAGER = "bat"
