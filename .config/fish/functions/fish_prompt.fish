# Most of this is from the default fish prompt, with slight tweaks
function fish_prompt --description 'Write out the prompt'

  # Just calculate these once, to save a few cycles when displaying the prompt
  if not set --query __fish_prompt_hostname
    set --universal __fish_prompt_hostname (hostname|cut -d . -f 1)
  end

  if not set --query __fish_prompt_normal
    set --universal __fish_prompt_normal (set_color normal)
  end

  set --local user_prompt '>'
  switch $USER
    # Set our root colors, if we're root
    case root
      set user_prompt '#'
      if not set --query __fish_prompt_cwd
        if set --query fish_color_cwd_root
          set --universal __fish_prompt_cwd (set_color $fish_color_cwd_root)
        else
          set --universal __fish_prompt_cwd (set_color $fish_color_cwd)
        end
      end

    case '*'
      if not set --query __fish_prompt_cwd
        set --universal __fish_prompt_cwd (set_color $fish_color_cwd)
      end
  end

  set --local pwd (basename (echo $PWD | sed "s:$HOME:~:"))

  # If our title bar function ran, don't need to repeat the user@hostname in
  # the prompt.
  if set --query __fish_title; and [ -z "$SSH_CLIENT" ]
    printf '%s%s%s%s%s' "$__fish_prompt_cwd" "$pwd" "$__fish_prompt_normal" $user_prompt
  else
    printf '%s@%s %s%s%s%s%s' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" "$pwd" "$__fish_prompt_normal" $user_prompt
  end

end
