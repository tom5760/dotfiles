function prepend_path \
    --description='Append to PATH if directory exists' \
    --argument-names=path
  if [ -d $path ]
    set --universal fish_user_paths $path $fish_user_paths
    return 0
  end
  return 1
end
