let
  arrendajo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN0etOw0cQcTny9JoqKlrLmAMmz5zJmaft5Z4Az8KJt";
  caracara  = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINYiw0R6flZI0N/WF5U0PO4yJZ0bUtdR0G0Tulx2/mvg";
  keys = [ arrendajo caracara ];
in
{
  ### Agenix Secrets ###
  #
  # To edit, install agenix CLI utility and run with '-e' command,
  # e.g. 'agenix -e ssh_hosts.age'
  #
  # Easiest to install with 'nix shell github:ryantm/agenix'
  #
  "ssh_hosts.age".publicKeys = keys;
  "git_config.age".publicKeys = keys;
}
