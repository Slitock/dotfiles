# ~/.config/fish/config.fish

# ~/.local/bin нет в PATH из environment.d — добавляем один раз (универсальная переменная).
fish_add_path ~/.local/bin

set -gx EDITOR nvim
set -gx VISUAL nvim

if not status is-interactive
    return
end

set -g fish_greeting ""

# ── tmux: один сервер, одна сессия "main" на все терминалы ───
# Отключить разово: env FISH_NO_TMUX=1 fish
# NVIM — чтобы `:terminal` в neovim не запускал вложенный tmux.
if not set -q TMUX; and not set -q FISH_NO_TMUX; and not set -q NVIM
    and test "$TERM" != dumb
    exec tmux new-session -A -s main
end

# ── Палитра DMS: синхронизация tmux/starship/fish ────────────
# Перегенерирует цвета только если DMS сменил тему (хеш палитры).
type -q dank-term-theme; and dank-term-theme --quiet --reload-tmux

# ── Приглашение ──────────────────────────────────────────────
type -q starship; and starship init fish | source

# ── Умный cd ─────────────────────────────────────────────────
type -q zoxide; and zoxide init fish | source

# ── Обёртки над eza/bat/fzf ──────────────────────────────────
# Живут в functions/*.fish: ввод остаётся коротким (`ls`), подмена — при
# выполнении. Аббревиатуры для этого не годятся: они раскрываются в строке.
# Файлы: ls.fish, ll.fish, la.fish, lt.fish, cat.fish, ff.fish

abbr -a gs 'git status --short --branch'
abbr -a gd 'git diff'
abbr -a gl 'git log --oneline --graph --decorate -20'
abbr -a ga 'git add'
abbr -a gc 'git commit'
abbr -a gp 'git push'

abbr -a ts 'tmux new-session -A -s main'
abbr -a tn 'tmux new-window -c "$PWD"'
