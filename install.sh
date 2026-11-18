#!/usr/bin/env bash
# Ставит конфиги из этого репозитория симлинками в $HOME.
#
#   ./install.sh              # применить
#   ./install.sh --dry-run    # только показать план
#
# Существующие файлы и каталоги не удаляются: они переносятся в
# ~/.dotfiles-backup/<дата>/. Повторный запуск безопасен.
set -euo pipefail

REPO="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
BACKUP="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
DRY_RUN=0

usage() {
    sed -n '2,8p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

for arg in "$@"; do
    case "$arg" in
        -n|--dry-run) DRY_RUN=1 ;;
        -h|--help) usage; exit 0 ;;
        *) echo "неизвестный аргумент: $arg" >&2; usage >&2; exit 2 ;;
    esac
done

# источник в репозитории | цель относительно $HOME
ENTRIES=(
    "config/fish|.config/fish"
    "config/tmux|.config/tmux"
    "config/ghostty|.config/ghostty"
    "config/niri|.config/niri"
    "config/btop|.config/btop"
    "config/yazi|.config/yazi"
    "config/nvim|.config/nvim"
    "config/dank-term|.config/dank-term"
    "config/environment.d|.config/environment.d"
    "config/autostart|.config/autostart"
    "config/opencode/commands|.config/opencode/commands"
    "config/opencode/themes|.config/opencode/themes"
    "config/opencode/cli.json|.config/opencode/cli.json"
    "config/opencode/AGENTS.md|.config/opencode/AGENTS.md"
    "config/dms/settings.json|.config/dms/settings.json"
    "config/dms/plugin_settings.json|.config/dms/plugin_settings.json"
    "config/mimeapps.list|.config/mimeapps.list"
    "config/xdg-terminals.list|.config/xdg-terminals.list"
    "local/bin/dank-term-theme|.local/bin/dank-term-theme"
    "home/gitconfig|.gitconfig"
)

linked=0
skipped=0

link_entry() {
    local rel_src="$1" rel_dst="$2"
    local src="$REPO/$rel_src" dst="$HOME/$rel_dst"

    if [ ! -e "$src" ] && [ ! -L "$src" ]; then
        echo "пропуск: нет $rel_src" >&2
        skipped=$((skipped + 1))
        return
    fi

    if [ -L "$dst" ] && [ "$(readlink -f "$dst")" = "$(readlink -f "$src")" ]; then
        echo "уже стоит: $rel_dst"
        skipped=$((skipped + 1))
        return
    fi

    if [ "$DRY_RUN" -eq 1 ]; then
        if [ -e "$dst" ] || [ -L "$dst" ]; then
            echo "[dry] backup $rel_dst -> $BACKUP/$rel_dst"
        fi
        echo "[dry] ln -s $rel_src -> $rel_dst"
        linked=$((linked + 1))
        return
    fi

    if [ -e "$dst" ] || [ -L "$dst" ]; then
        mkdir -p "$BACKUP/$(dirname "$rel_dst")"
        mv "$dst" "$BACKUP/$rel_dst"
        echo "backup: $rel_dst"
    fi

    mkdir -p "$(dirname "$dst")"
    ln -s "$src" "$dst"
    echo "link:   $rel_dst"
    linked=$((linked + 1))
}

for entry in "${ENTRIES[@]}"; do
    link_entry "${entry%%|*}" "${entry##*|}"
done

echo
echo "ссылок обработано: $linked, пропущено: $skipped"
if [ -d "$BACKUP" ]; then
    echo "бэкап старых файлов: $BACKUP"
fi

if [ "$DRY_RUN" -eq 1 ]; then
    exit 0
fi

# Проверка зависимостей: ничего не ставим, только подсказываем.
missing=()
for cmd in fish tmux starship nvim; do
    command -v "$cmd" >/dev/null 2>&1 || missing+=("$cmd")
done
if [ "${#missing[@]}" -gt 0 ]; then
    echo "не найдены команды: ${missing[*]} — поставь их и перезайди в шелл"
fi

echo
echo "дальше:"
echo "  1. chsh -s $(command -v fish || echo /usr/bin/fish)"
echo "  2. новый терминал: fish поднимет tmux и сгенерирует цвета из палитры DMS"
echo "  3. если tmux уже запущен: tmux kill-server"
