function ll --description 'eza: подробный список с git-статусом' --wraps=eza
    if not set -q argv[1]
        eza -lh --icons=auto --group-directories-first --git .
    else
        eza -lh --icons=auto --group-directories-first --git $argv
    end
end
