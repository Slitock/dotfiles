function cat --description 'bat без номеров строк и пагинации' --wraps=bat
    bat --style=plain --paging=never $argv
end
