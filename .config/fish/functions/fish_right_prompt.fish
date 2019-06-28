function fish_right_prompt -d 'Write out the right side prompt'
  # Save our status
  set --local last_status $status

  # Print out the exit status of the last command if it failed.
  if test $last_status -ne 0
    printf "%s[%d]%s " (set_color red --bold) $last_status (set_color normal)
  end

  # Print out the number of background jobs we have running.
  set -l jobs_count (jobs -p | wc -l)
  if test $jobs_count -ne 0
    printf "%s{%d}%s " (set_color yellow) $jobs_count (set_color normal)
  end

  # Print out our current git status if we are in a repository.
  set --local in_worktree (git rev-parse --is-inside-work-tree 2> /dev/null)

  if test "$in_worktree" = "true"
    echo (set_color --dim green)'('

    if not git symbolic-ref --short HEAD 2> /dev/null
      # If detached, print the short ref name.
      git rev-parse --short HEAD
    end

    set --local git_status (git status --porcelain)
    if test -n "$git_status"
      echo '*'
    end

    echo ')' (set_color normal)
  end

  # Print out a timestamp
  echo "<"
  date "+%-I:%M:%S"
end
