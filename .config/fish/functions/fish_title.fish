function fish_title -d 'Write out the window title'
  # This function only gets run if the terminal supports setting the window
  # title.  Set a global variable if we do, so that other functions can take
  # this into account.  The prompt will not show the user@hostname if we have
  # it in the title.
  if not set -q __fish_title
    set -g __fish_title true
  end

  echo $USER@$__fish_prompt_hostname">" (pwd | sed "s:$HOME:~:")
end
