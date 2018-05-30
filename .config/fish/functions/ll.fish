function ll --description='Alias for ls' --wraps=ls
  ls -l --human-readable $argv
end
