sleep 3

# Запускаем Telegram на workspace 3
hyprctl dispatch exec "[workspace 3] org\.telegram\.desktop -- %u"
