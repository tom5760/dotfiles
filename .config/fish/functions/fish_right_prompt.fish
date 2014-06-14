function fish_right_prompt -d 'Write out the right side prompt'
  # Save our status
  set -l last_status $status

  # Print out the exit status of the last command if it failed.
  if [ $last_status -ne 0 ]
    printf "%s[%d]%s " (set_color red --bold) $last_status (set_color normal)
  end

  # Print out the number of background jobs we have running.
  set -l jobs_count (jobs -p | wc -l)
  if [ $jobs_count -ne 0 ]
    printf "%s{%d}%s " (set_color yellow) $jobs_count (set_color normal)
  end

  # Print out a timestamp
  echo "<"
  date "+%-I:%m:%S"
end
