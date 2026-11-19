function la --description 'eza: подробный список со скрытыми файлами' --wraps=eza
    if not set -q argv[1]
        eza -lah --icons=auto --group-directories-first --git .
    else
        eza -lah --icons=auto --group-directories-first --git $argv
    end
end
