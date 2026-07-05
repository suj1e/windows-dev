# Windows 开发环境 CLI 工具参考

> 本机配置：PowerShell 7 + WezTerm + mise + starship
> 仓库：https://github.com/suj1e/windows-dev

---

## 目录

1. [工具清单](#1-工具清单)
2. [PowerShell Profile](#2-powershell-profile)
3. [WezTerm 配置](#3-wezterm-配置)
4. [starship 配置](#4-starship-配置)
5. [mise 配置](#5-mise-配置)
6. [Git 配置](#6-git-配置)
7. [工具用法速查](#7-工具用法速查)
8. [常见组合](#8-常见组合)
9. [配置文件位置一览](#9-配置文件位置一览)
10. [换机器恢复](#10-换机器恢复)

---

## 1. 工具清单

### 已安装工具（winget）

| 工具 | 版本 | 用途 | winget ID |
|------|------|------|----------|
| **PowerShell 7** | 最新 | Shell | Microsoft.PowerShell |
| **WezTerm** | 最新 | 终端 | Wez.Fetch |
| **starship** | 最新 | Prompt | Starship.Starship |
| **eza** | 最新 | 现代 ls | eza-community.eza |
| **bat** | 最新 | 语法高亮 cat | sharkdp.bat |
| **fd** | 最新 | 现代 find | sharkdp.fd |
| **ripgrep** | 最新 | 现代 grep | BurntSushi.ripgrep.MSVC |
| **delta** | 最新 | Git diff 美化 | dandavison.delta |
| **zoxide** | 最新 | 智能目录跳转 | ajeetdsouza.zoxide |
| **fzf** | 最新 | 模糊搜索 | junegunn.fzf |
| **lazygit** | 最新 | Git TUI | JesseDuffield.lazygit |
| **just** | 最新 | 命令 runner | casey.just |
| **jq** | 最新 | JSON 处理 | jqlang.jq |
| **lnav** | 最新 | 日志查看器 | tstack.lnav |
| **btop** | 最新 | 系统监控 | aristocratos.btop |
| **dust** | 最新 | 磁盘占用分析 | bootandy.dust |
| **procs** | 最新 | 进程列表 | dalance.procs |
| **tldr** | 最新 | 简化版手册 | tldr-pages.tldr |
| **yq** | 最新 | YAML 处理 | mikefarah.yq |
| **direnv** | 最新 | 目录级环境变量 | direnv.direnv |
| **lazydocker** | 最新 | Docker TUI | JesseDuffield.lazydocker |
| **hyperfine** | 最新 | 命令性能对比 | sharkdp.hyperfine |
| **sd** | 最新 | sed 替代 | chmln.sd |
| **xh** | 最新 | curl 替代 | ducaale.xh |
| **mise** | 最新 | 多语言版本管理 | jdx.mise |
| **neovim** | 最新 | 编辑器 | Neovim.Neovim |
| **zellij** | 最新 | 终端复用器 | zellij-org.zellij |
| **gh** | 最新 | GitHub CLI | GitHub.cli |
| **Git** | 最新 | 版本控制 | Git.Git |
| **JetBrainsMono Nerd Font** | 最新 | 字体 | JetBrains.JetBrainsMono.NerdFont |

### 一键安装

```powershell
# 克隆仓库
git clone https://github.com/suj1e/windows-dev.git ~/windows-dev

# 运行安装脚本
powershell -ExecutionPolicy Bypass -File ~/windows-dev/scripts/install.ps1
```

---

## 2. PowerShell Profile

**路径**: `$PROFILE.CurrentUserAllHosts`
**来源**: `~/windows-dev/config/powershell/Microsoft.PowerShell_profile.ps1`

### 别名（对齐 macOS zshrc）

| 别名 | 命令 | 说明 |
|------|------|------|
| `ls` | `eza` | 现代 ls |
| `ll` | `eza -l --icons --git --group-directories-first` | 详细列表 |
| `la` | `eza -la --icons --git --group-directories-first` | 显示隐藏文件 |
| `lt` | `eza -T --icons` | 树形视图 |
| `cat` | `bat --paging=never` | 语法高亮 |
| `less` | `bat --paging=always` | 语法高亮分页 |
| `find` | `fd` | 现代 find |
| `grep` | `rg` | 现代 grep |
| `lg` | `lazygit` | Git TUI |
| `vim` | `nvim` | Neovim |

### 函数

| 函数 | 说明 |
|------|------|
| `..` | 返回上级目录 |
| `...` | 返回上两级目录 |
| `du` | 目录大小分析（类似 dust） |
| `psg <pattern>` | 进程搜索（类似 procs） |

### 模块

| 模块 | 说明 |
|------|------|
| `zoxide` | 智能目录跳转（`z <dir>`） |
| `direnv` | 进入目录自动加载 `.envrc` |
| `starship` | Prompt 美化 |
| `PSReadLine` | 命令行增强（预测、高亮） |

---

## 3. WezTerm 配置

**路径**: `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\wezterm.lua`
**来源**: `~/windows-dev/config/wezterm/wezterm.lua`

### 配置项（对齐 Ghostty）

| 配置 | 值 | 说明 |
|------|------|------|
| 字体 | JetBrainsMono Nerd Font Mono | 和 macOS 一致 |
| 字体大小 | 14 | 和 macOS 一致 |
| 主题 | Catppuccin Mocha | 和 macOS 一致 |
| 窗口内边距 | 10px | 和 macOS 一致 |
| 光标样式 | SteadyBlock | 块状光标 |
| 光标闪烁 | 开启 | 和 macOS 一致 |
| 复制选择 | 自动复制到剪贴板 | 和 macOS 一致 |

### 快捷键

| 快捷键 | 功能 |
|------|------|
| `Ctrl+Shift+T` | 新建标签页 |
| `Ctrl+Shift+W` | 关闭标签页 |
| `Ctrl+Shift+\|` | 水平分屏 |
| `Ctrl+Shift+-` | 垂直分屏 |
| `Ctrl+Shift+H/J/K/L` | Pane 导航 |
| `Ctrl+Tab` | 下一个标签页 |
| `Ctrl+Shift+Tab` | 上一个标签页 |
| `Ctrl+Shift+C` | 复制 |
| `Ctrl+Shift+V` | 粘贴 |
| `Ctrl+Shift+R` | 搜索 |

---

## 4. starship 配置

**路径**: `$env:USERPROFILE\.config\starship\starship.toml`
**来源**: `~/windows-dev/config/starship/starship.toml`

### 配置项（对齐 macOS）

| 模块 | 说明 |
|------|------|
| `directory` | 目录路径，最多 3 层，git 仓库截断到根 |
| `git_branch` | Git 分支（紫色） |
| `git_status` | Git 状态（红色，!+ staged+ untracked?） |
| `python` | Python 版本（黄色 🐍） |
| `nodejs` | Node.js 版本（绿色 ⬢） |
| `rust` | Rust 版本（红色 🦀） |
| `java` | Java 版本（红色 ☕） |
| `cmd_duration` | 命令耗时（≥2 秒显示） |
| `character` | 提示符（❯ 绿色成功，红色失败） |

---

## 5. mise 配置

**路径**: `$env:USERPROFILE\.config\mise\config.toml`

```toml
[tools]
bun = "latest"
go = "1.24"
java = "21"
node = "22"
python = "3.13"
```

### 常用命令

```powershell
mise ls                    # 查看已激活版本
mise use --global node@22  # 设置全局默认版本
mise use node@20           # 项目级锁版本（生成 .tool-versions）
mise up                    # 升级所有到最新
```

---

## 6. Git 配置

**路径**: `$env:USERPROFILE\.gitconfig`

```ini
[core]
    pager = delta

[interactive]
    diffFilter = delta --color-only

[delta]
    navigate = true
    line-numbers = true
    theme = Catppuccin Mocha

[merge]
    conflictstyle = diff3

[diff]
    colorMoved = default
```

---

## 7. 工具用法速查

### 文件操作

| 命令 | 说明 | 示例 |
|------|------|------|
| `eza` | 现代 ls | `eza -la --icons --git` |
| `bat` | 语法高亮 cat | `bat file.py` |
| `fd` | 现代 find | `fd '*.js'` |
| `dust` | 磁盘占用分析 | `dust` |

### 搜索

| 命令 | 说明 | 示例 |
|------|------|------|
| `rg` | 现代 grep | `rg 'TODO' -t py` |
| `fzf` | 模糊搜索 | `Ctrl+R` 历史搜索 |
| `tldr` | 简化版手册 | `tldr tar` |

### Git

| 命令 | 说明 |
|------|------|
| `lazygit` | Git TUI（`lg` 别名） |
| `delta` | Git diff 美化（自动通过 git pager） |

### 系统

| 命令 | 说明 | 示例 |
|------|------|------|
| `btop` | 系统监控 | `btop` |
| `procs` | 进程列表 | `procs` |
| `psg <pattern>` | 进程搜索 | `psg node` |
| `hyperfine` | 命令性能对比 | `hyperfine "ls" "eza"` |

### 开发

| 命令 | 说明 |
|------|------|
| `mise` | 版本管理（Node/Java/Python/Go/Bun） |
| `direnv` | 目录级环境变量 |
| `just` | 命令 runner（类似 make） |
| `jq` | JSON 处理 |
| `yq` | YAML 处理 |
| `xh` | HTTP 客户端（curl 替代） |
| `sd` | sed 替代 |
| `nvim` | 编辑器（`vim` 别名） |
| `zellij` | 终端复用器 |
| `lazydocker` | Docker TUI |
| `gh` | GitHub CLI |

---

## 8. 常见组合

```powershell
# 搜索并打开文件
fd '*.ts' | fzf | xargs nvim

# Git 工作流
lg                    # 打开 lazygit
rg 'TODO' -t py       # 搜索 TODO
dust                  # 看哪个目录占空间

# 项目开发
cd myproject          # zoxide 智能跳转
direnv allow          # 加载项目环境变量
mise use node@20      # 项目级 Node 版本
nvim .                # 打开编辑器
```

---

## 9. 配置文件位置一览

| 配置 | 路径 | 来源 |
|------|------|------|
| PowerShell Profile | `$PROFILE.CurrentUserAllHosts` | `config/powershell/` |
| WezTerm | `%LOCALAPPDATA%\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\wezterm.lua` | `config/wezterm/` |
| starship | `$env:USERPROFILE\.config\starship\starship.toml` | `config/starship/` |
| mise | `$env:USERPROFILE\.config\mise\config.toml` | `config/mise/` |
| Git | `$env:USERPROFILE\.gitconfig` | `config/git/` |
| Neovim | `$env:USERPROFILE\.config\nvim\` | `config/nvim/` |
| zellij | `$env:USERPROFILE\.config\zellij\` | `config/zellij/` |

---

## 10. 换机器恢复

```powershell
# 1. 克隆仓库
git clone https://github.com/suj1e/windows-dev.git ~/windows-dev

# 2. 运行安装脚本
powershell -ExecutionPolicy Bypass -File ~/windows-dev/scripts/install.ps1

# 3. 手动配置 WezTerm
# 复制 wezterm.lua 到 WezTerm 配置目录

# 4. 重启 PowerShell
```

---

## 11. 注意事项

### Windows 特有

| 问题 | 解决方案 |
|------|------|
| 执行策略阻止脚本 | `Set-ExecutionPolicy RemoteSigned -Scope CurrentUser` |
| 中文路径问题 | 工具链已支持 UTF-8，`$env:PYTHONIOENCODING = "utf-8"` |
| 权限问题 | 以管理员身份运行 PowerShell |

### 工具差异

| macOS | Windows | 说明 |
|------|------|------|
| Ghostty | WezTerm | 终端不同 |
| zsh | PowerShell 7 | Shell 不同 |
| brew | winget | 包管理不同 |
| starship | starship | 一致 |
| mise | mise | 一致 |
| 其他工具 | 一致 | 跨平台工具版本一致 |
