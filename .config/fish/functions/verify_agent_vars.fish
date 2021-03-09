function verify_agent_vars --description 'Check if ssh-agent is running'
  if [ -z "$SSH_AGENT_PID" -o ! -O /proc/"$SSH_AGENT_PID" ]
    return 1
  end

  if [ -z "$SSH_AUTH_SOCK" -o ! -O "$SSH_AUTH_SOCK" -o ! -S "$SSH_AUTH_SOCK" ]
    return 1
  end

  ssh-add -l > /dev/null 2>&1

  if [ $status -eq 2 ]
    return 1
  end

  return 0
end
