function append_path \
  --description='Append to PATH if directory exists' \
  --argument-names=path
  if [ -d $path ]
    set --universal fish_user_paths $fish_user_paths $path
    return 0
  end
  return 1
end

