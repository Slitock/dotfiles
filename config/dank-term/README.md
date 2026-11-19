# dank-term — терминал fish + starship + tmux на палитре DMS

Окружение: niri + DankMaterialShell (Material You). Цвета не захардкожены —
источник правды один: палитра, которую DMS генерирует при смене обоев.

## Как устроено

```
~/.config/kitty/dank-theme.conf        ← DMS/matugen пишет при смене темы
        │  (fallback: ~/.config/alacritty/dank-theme.toml)
        ▼
~/.local/bin/dank-term-theme           ← читает палитру, достраивает роли
        │                                  (surface, surface_alt, border, muted)
        ▼
~/.config/dank-term/templates/*        ← шаблоны с плейсхолдерами {{accent}}
        │
        ├── ~/.config/tmux/theme.conf
        ├── ~/.config/starship.toml
        └── ~/.config/fish/conf.d/dank-palette.fish
```

Запускается из `~/.config/fish/config.fish` при старте интерактивного шелла.
Если хеш палитры не изменился — ничего не перезаписывается (быстро, без демона).
При реальном изменении и активном tmux (`--reload-tmux`) статус-бар tmux
подхватывает цвета сразу.

## Правка оформления

Править нужно **шаблоны**, а не сгенерированные файлы:

| что меняем | файл |
|---|---|
| статус-бар, границы, окна tmux | `templates/tmux-theme.conf` |
| приглашение starship | `templates/starship.toml` |
| подсветка синтаксиса fish | `templates/fish-colors.fish` |
| горячие клавиши, поведение tmux | `~/.config/tmux/tmux.conf` |
| автозапуск tmux, сокращения | `~/.config/fish/config.fish` |

Доступные плейсхолдеры: `bg`, `fg`, `surface`, `surface_alt`, `border`, `muted`,
`faint` (серый для автодополнения), `accent` (= cyan), `accent2` (= blue),
`on_accent`, `selection`, `cursor`, `red`, `green`, `yellow`, `blue`, `magenta`,
`cyan`, `white`, `grey` и `*_bright`-варианты.

После правки шаблона:

```fish
dank-term-theme --force            # применить
dank-term-theme --force --quiet    # без вывода
```

Проверить, что скрипт видит палитру верно:

```fish
dank-term-theme                    # отчёт: источник палитры + изменённые файлы
```

## tmux

| клавиши | действие |
|---|---|
| `C-b` (по умолчанию) | префикс; `C-a` включается в `tmux.conf` |
| `C-b /` или `C-b \` | сплит вправо в текущей директории |
| `C-b -` | сплит вниз в текущей директории |
| `C-b c` | новое окно в текущей директории |
| `M-h/j/k/l` | переход между панелями |
| `M-H/J/K/L` | ресайз панелей |
| `C-b r` | перечитать конфиг и цвета |
| `C-b [` → `v`/`V`/`y` | выделение и копирование в системный буфер (wl-copy) |

Автозапуск: `exec tmux new-session -A -s main` в `config.fish`.
Одна сессия `main` на все терминалы. Разово отключить:

```fish
env FISH_NO_TMUX=1 fish
```

## Зависимости

- `starship` 1.27.0 — статический бинарь в `~/.local/bin` (Fedora-репозиторий
  отстаёт). `~/.local/bin` добавляется в `PATH` в `config.fish`.
- `wl-clipboard` (есть), `eza`, `fzf`, `zoxide`, `bat` — для сокращений.
- Шрифт: JetBrainsMono Nerd Font (уже установлен) — нужен для глифов `❯`

## Откат

```fish
set -l backup (ls -t ~/.config/fish/config.fish.bak-* | head -1)
cp $backup ~/.config/fish/config.fish
rm ~/.config/tmux/tmux.conf ~/.config/tmux/theme.conf ~/.config/starship.toml \
   ~/.config/fish/conf.d/dank-palette.fish ~/.local/bin/dank-term-theme
```
