# windows-dev

Windows 开发环境配置（PowerShell 7 + WezTerm + mise + starship）。

和 macOS 工具链全面对齐：eza/bat/fd/rg/delta/zoxide/fzf/lazygit/just/jq/btop/dust/procs/tldr/yq/direnv/lazydocker/hyperfine/sd/xh/pnpm/maven/gradle。

## 快速开始

```powershell
# 1. 克隆仓库
git clone https://github.com/suj1e/windows-dev.git ~/windows-dev

# 2. 运行安装脚本
powershell -ExecutionPolicy Bypass -File ~/windows-dev/scripts/install.ps1

# 3. 手动配置 WezTerm
# 复制 config/wezterm/wezterm.lua 到 WezTerm 配置目录

# 4. 重启 PowerShell
```

## 仓库结构

```
windows-dev/
├── README.md                          # 本文件
├── scripts/
│   └── install.ps1                    # 一键安装脚本
├── config/
│   ├── powershell/
│   │   └── Microsoft.PowerShell_profile.ps1  # PowerShell Profile
│   ├── wezterm/
│   │   └── wezterm.lua                # WezTerm 配置
│   ├── starship/
│   │   └── starship.toml              # starship Prompt
│   ├── mise/
│   │   └── config.toml                # 版本管理
│   └── git/
│       └── gitconfig                  # Git 配置
└── docs/
    └── CLI-Tools-Reference-Windows.md # 完整工具参考
```

## 核心配置

| 组件 | 配置 | 说明 |
|------|------|------|
| Shell | PowerShell 7 | 原生 Windows Shell |
| 终端 | WezTerm | 跨平台终端 |
| Prompt | starship | 和 macOS 一致 |
| 包管理 | winget | Windows 11 内置 |
| 版本管理 | mise | 和 macOS 一致 |

## 和 macOS 的区别

| 组件 | macOS | Windows |
|------|-------|---------|
| 终端 | Ghostty | WezTerm |
| Shell | zsh | PowerShell 7 |
| 包管理 | brew | winget |
| 其他 | 完全一致 | 完全一致 |

## 文档

- [CLI 工具完整参考](docs/CLI-Tools-Reference-Windows.md)

## License

MIT

## 国内镜像配置

| 工具 | 配置 | 镜像源 |
|------|------|--------|
| npm/pnpm | ~/.npmrc | 阿里云 npm |
| Maven | ~/.m2/settings.xml | 阿里云 Maven |
| Gradle | ~/.gradle/gradle.properties | 阿里云 Maven |

## 私有仓库配置

| 工具 | 配置 | 仓库 |
|------|------|------|
| npm/pnpm | ~/.npmrc | 阿里云 npm 私有 |
| Maven | ~/.m2/settings.xml | 阿里云 Maven 私有 |
| Gradle | ~/.gradle/gradle.properties | 阿里云 Maven 私有 |

## 加密与备份

敏感文件加密和 age 私钥备份见 [dotfiles](https://github.com/suj1e/dotfiles) 仓库。
