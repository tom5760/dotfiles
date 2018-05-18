function ls -d 'Alias for ls'
  command ls -C \
    --color=auto \
    --classify \
    --group-directories-first \
    --sort=extension $argv
end
