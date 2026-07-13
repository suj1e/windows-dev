# ============================================================
#  pyenv-win
# ============================================================
export PYENV="$HOME/.pyenv/pyenv-win"
export PYENV_ROOT="$HOME/.pyenv/pyenv-win"
export PYENV_HOME="$HOME/.pyenv/pyenv-win"
export PATH="$PYENV/bin:$PYENV/shims:$PATH"

# ============================================================
#  eza — modern ls (replaces ls)
# ============================================================
alias ls='eza --icons --group-directories-first'
alias ll='eza -l --icons --git --group-directories-first'
alias la='eza -la --icons --git --group-directories-first'
alias lt='eza -T --icons'
alias ltree='eza -T --icons --level=3'
alias l2='eza -T --icons --level=2'
alias l1='eza -T --icons --level=1'

# ============================================================
#  7-Zip — compression / extraction
# ============================================================
export PATH="/d/opt/7-Zip:$PATH"

# ============================================================
#  bat — cat with syntax highlighting
# ============================================================
export BAT_THEME="Catppuccin Mocha"
alias cat='bat --paging=never'
alias less='bat --paging=always'

# ============================================================
#  fd — modern find
# ============================================================
alias find='fd'
alias fname='fd --glob'              # fname '*.js'
alias ffull='fd --fixed-strings'     # ffull 'exact-match'

# ============================================================
#  ripgrep — modern grep
# ============================================================
alias grep='rg'
alias igrep='rg -i'                  # 忽略大小写
alias fgrep='rg -F'                  # 固定字符串

# ============================================================
#  lazygit — git TUI
# ============================================================
alias lg='lazygit'

# ============================================================
#  zoxide — smarter cd
# ============================================================
eval "$(zoxide init bash)"

# ============================================================
#  just — command runner
#    项目级: just <命令>   (在项目目录下创建 justfile)
#    全局级: j <命令>      (任意目录可用, ~/.justfile)
# ============================================================
alias j='just --justfile ~/.justfile --working-directory .'
eval "$(JUST_COMPLETE=bash just)"

# ============================================================
#  fzf — fuzzy finder (Ctrl+T 搜文件, Ctrl+R 搜历史, Alt+C 搜目录)
# ============================================================
export FZF_DEFAULT_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_CTRL_T_COMMAND='fd --type f --strip-cwd-prefix'
export FZF_ALT_C_COMMAND='fd --type d --strip-cwd-prefix'
eval "$(fzf --bash)"

# ============================================================
#  npm auto reshim — 全局安装后自动 mise reshim
# ============================================================
npm() {
  command npm "$@"
  local ret=$?
  case " $* " in
    *" -g "*|*" --global "*) mise reshim 2>/dev/null ;;
  esac
  return $ret
}

# ============================================================
#  starship — pretty prompt (keep last, sets PROMPT_COMMAND)
# ============================================================
eval "$(starship init bash)"

# ============================================================
#  atuin — shell history with sync & search
# ============================================================
