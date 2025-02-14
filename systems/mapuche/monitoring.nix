{ config, pkgs, ... }:

let 
  # TODO: If have more DNS server control, can register subdomain
  #       specific to service and add it to nginx proxy
  #grafana_domain = "dashboard.${config.networking.hostName}.lan";
  grafana_domain = "${config.networking.hostName}.lan";
  grafana_port = 2342;
in 
{
  ### Prometheus ###
  services.prometheus.exporters.node = {
    enable = true;
    enabledCollectors = [ "systemd" ];
    port = 9002;
  };
  networking.firewall.allowedTCPPorts = [ 9002 ];
}
