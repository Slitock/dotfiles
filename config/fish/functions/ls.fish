function ls --description 'eza: список с иконками' --wraps=eza
    if not set -q argv[1]
        eza --icons=auto --group-directories-first .
    else
        eza --icons=auto --group-directories-first $argv
    end
end
