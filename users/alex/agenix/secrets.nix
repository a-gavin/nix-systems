let
  alex_arrendajo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN0etOw0cQcTny9JoqKlrLmAMmz5zJmaft5Z4Az8KJt";
  alex_keys = [ alex_arrendajo ];
in
{
  ### Agenix Secrets ###
  #
  # To edit, install agenix CLI utility and run with '-e' command,
  # e.g. 'agenix -e ssh_hosts.age'
  #
  # Easiest to install with 'nix shell github:ryantm/agenix'
  #
  "ssh_hosts.age".publicKeys = alex_keys;
  "git_config.age".publicKeys = alex_keys;
}
