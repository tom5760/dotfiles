function setup_keychain --description 'Set up ssh-agent keychain'
  # Exported univeral variables get exported in the login shell.  We need to
  # remove them from the global scope in child shells to use the universal
  # versions.
  set --erase --global SSH_AGENT_PID
  set --erase --global SSH_AUTH_SOCK

  if verify_agent_vars
    return 0
  end

  # Otherwise, start it
  eval (ssh-agent -c | sed 's/setenv/set --export --universal/')

  verify_agent_vars
end
