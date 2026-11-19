# dotfiles

Мой повседневный сетап: **niri + DankMaterialShell** (Wayland, Material You),
терминал **fish + starship + tmux**, редактор **neovim** (NvChad starter),
плюс мелочи вроде btop и yazi.

Репозиторий — источник правды: файлы живут здесь, а в `~/.config` лежат симлинки.

## Что внутри

| каталог | куда ставится | что это |
|---|---|---|
| `config/fish` | `~/.config/fish` | шелл: автозапуск tmux, starship, zoxide, обёртки `ls`→eza, `cat`→bat, сокращения git |
| `config/tmux` | `~/.config/tmux` | сплиты в текущей папке, статус-бар на палитре DMS |
| `config/dank-term` | `~/.config/dank-term` | шаблоны цветов + `dank-term-theme` (генератор) |
| `config/ghostty` | `~/.config/ghostty` | терминал |
| `config/niri` | `~/.config/niri` | раскладки, бинды, инпут; `dms/*.kdl` — бинды из DMS |
| `config/dms` | `~/.config/dms/{settings,plugin_settings}.json` | настройки DankMaterialShell |
| `config/nvim` | `~/.config/nvim` | конфиг neovim (NvChad starter + правки) |
| `config/opencode` | `~/.config/opencode/{cli.json,AGENTS.md,commands,themes}` | настройки и свои команды OpenCode |
| `config/btop`, `config/yazi` | одноимённо | мелкие TUI |
| `config/environment.d` | `~/.config/environment.d` | `EDITOR`, `TERMINAL` для systemd-сессии |
| `config/autostart` | `~/.config/autostart` | Telegram, v2rayN |
| `config/mimeapps.list`, `config/xdg-terminals.list` | одноимённо | приложения по умолчанию |
| `local/bin/dank-term-theme` | `~/.local/bin/` | генератор цветов |
| `home/gitconfig` | `~/.gitconfig` | имя и noreply-почта GitHub |

## Установка

```bash
git clone git@github.com:Slitock/dotfiles.git ~/dotfiles
cd ~/dotfiles
./install.sh --dry-run   # посмотреть план
./install.sh             # применить
chsh -s /usr/bin/fish
```

`install.sh` не удаляет ничего: существующие файлы переносит в
`~/.dotfiles-backup/<дата>/`, затем создаёт симлинки. Повторный запуск безопасен.

Зависимости (ставятся вручную, скрипт их не тянет): `fish`, `tmux`, `starship`,
`nvim`, `eza`, `fzf`, `zoxide`, `bat`, `wl-clipboard`, шрифт JetBrainsMono Nerd Font.
`starship` лучше ставить статическим бинарём в `~/.local/bin` — в репозиториях
Fedora версия отстаёт.

## Как живут цвета

Никаких захардкоженных hex-ов. Источник — палитра, которую DMS/matugen
перегенерирует при смене обоев:

```
~/.config/kitty/dank-theme.conf   (fallback: ~/.config/alacritty/dank-theme.toml)
        │
        ▼  dank-term-theme
        ├── ~/.config/tmux/theme.conf
        ├── ~/.config/starship.toml
        └── ~/.config/fish/conf.d/dank-palette.fish
```

Генератор вызывается при старте fish, сравнивает sha256 палитры и переписывает
файлы только при изменении. Если палитра изменилась, а tmux запущен — статус-бар
подхватывает цвета сразу (`--reload-tmux`). Демонов и systemd-юнитов нет.

Править оформление нужно в шаблонах `config/dank-term/templates/*` (плейсхолдеры
`{{accent}}`, `{{surface}}`, `{{muted}}`, …), затем:

```fish
dank-term-theme --force
```

## tmux

| клавиши | действие |
|---|---|
| `C-b` | префикс (`C-a` включается в `tmux.conf`) |
| `C-b /`, `C-b \` | сплит вправо в текущей папке |
| `C-b -` | сплит вниз |
| `C-b c` | новое окно в текущей папке |
| `M-h/j/k/l` | переход между панелями |
| `M-H/J/K/L` | ресайз |
| `C-b r` | перечитать конфиг и цвета |
| `C-b [` → `v`/`V`/`y` | выделить и скопировать в системный буфер |

Один терминал = одна сессия `main`. Отключить автозапуск разово:

```fish
env FISH_NO_TMUX=1 fish
```

`$NVIM` проверяется отдельно, чтобы `:terminal` не поднимал вложенный tmux.

## Чего в репозитории нет

- **Секреты.** `~/.config/opencode/service-prod.json` содержит пароль и в git не
  попадает. Токены rclone, Discord/Vencord, qBittorrent, AmneziaVPN, профили
  браузеров — тоже локальные.
- **Сгенерированное.** `tmux/theme.conf`, `starship.toml`,
  `fish/conf.d/dank-palette.fish`, `ghostty/themes/`, `niri/dms/colors.kdl`,
  `nvim/colors/dms.lua`, `yazi/plugins/` — см. `.gitignore`.
- **Состояние.** `fish_variables`, история, `dms/monitors.json`, css-темы
  браузеров.

Один нюанс: `config/autostart/v2rayN.desktop` содержит абсолютный путь
`/home/slitock/opt/vrayn/v2rayN`. На другой машине его нужно поправить.

## Старое

`hypr/` — конфиги Hyprland (декабрь 2025), оставлены в истории для справки,
сейчас не используются. Актуальный сетап живёт в `config/` и работает на
niri + DankMaterialShell.

## Благодарности

Структура и идеи по tmux/fish подсмотрены в [l-m-n-d-k/dotfiles](https://github.com/l-m-n-d-k/dotfiles),
цветовая схема — сгенерированная Material You палитра DMS вместо статичной темы.
