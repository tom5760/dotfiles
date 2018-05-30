function export_dir \
    --description='Export variable if directory exists' \
    --argument-names=var \
    --argument-names=dir
  if [ -d "$dir" ]
    set --export --global $var $dir
  end
end
