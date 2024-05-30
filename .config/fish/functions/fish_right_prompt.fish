function fish_right_prompt -d 'Write out the right side prompt'
  # Save our status
  set --local last_status $status

  # Prompt status only if it's not 0
  set --local prompt_status
  if test $last_status -ne 0
    set prompt_status (set_color red)"[$last_status]"(set_color normal)
  end

  # Print out the number of background jobs we have running.
  set --local jobs_count (jobs -p | wc -l)
  set --local prompt_jobs
  if test $jobs_count -ne 0
    set prompt_jobs (set_color yellow)"[$jobs_count]"(set_color normal)
  end

  set --local vcs (set_color --dim green)(fish_vcs_prompt '(%s)' 2>/dev/null)(set_color normal)
  set --local ts (set_color brgrey)(date "+%-I:%M:%S")(set_color normal)

  string join " " -- $prompt_jobs $prompt_status $vcs $ts
end
