function ls --description='Alias for ls' --wraps=ls
  command ls -C \
    --color=auto \
    --classify \
    --group-directories-first \
    --sort=extension $argv
end
