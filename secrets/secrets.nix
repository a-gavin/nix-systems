let
  alex_arrendajo = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHN0etOw0cQcTny9JoqKlrLmAMmz5zJmaft5Z4Az8KJt";
  alex_keys = [ alex_arrendajo ];
in
{
  "ssh_hosts.age".publicKeys = alex_keys;
  "git_config.age".publicKeys = alex_keys;
}
