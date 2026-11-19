function lt --description 'eza: дерево на два уровня' --wraps=eza
    if not set -q argv[1]
        eza --tree --level=2 --icons=auto --group-directories-first .
    else
        eza --tree --level=2 --icons=auto --group-directories-first $argv
    end
end
