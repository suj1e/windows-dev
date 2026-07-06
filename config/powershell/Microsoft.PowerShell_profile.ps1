# PowerShell Profile — Windows / WezTerm
# 加载 mise、starship、zoxide 等工具

# direnv / 部分 Unix 工具依赖 HOME，Windows 默认未设置
$env:HOME = $env:USERPROFILE

# 确保 mise 的 shims 在 PATH 最前面
$env:PATH = "$env:LOCALAPPDATA\mise\shims;$env:PATH"

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
