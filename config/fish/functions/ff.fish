function ff --description 'fzf с превью через bat' --wraps=fzf
    fzf --height=60% --preview 'bat --color=always --style=numbers --line-range=:200 {}'
end
