# PowerShell Profile — Windows / WezTerm
# 加载 mise、starship、zoxide 等工具

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

# 初始化 direnv
if (Get-Command direnv -ErrorAction SilentlyContinue) {
    Invoke-Expression (&direnv hook powershell | Out-String)
}

# 启用 corepack（管理 pnpm/yarn）
if (Get-Command corepack -ErrorAction SilentlyContinue) {
    corepack enable | Out-Null
}

# 设置编辑器和分页器
$env:EDITOR = "nvim"
$env:PAGER = "bat"
