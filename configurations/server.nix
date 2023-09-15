{ config, lib, pkgs, stdenv, ... }:
  let 
    wwwUser = "www-data";
    wwwGroup = "www-data";
    fcgiSocket = "/run/phpfpm/nginx";
  in 
{
  imports = [
    ../cfg/base-minimal.nix
  ];

  users.extraUsers.henri = {
    isNormalUser = true;
    extraGroups = [ "wheel" "networkmanager" "plugdev" ];
    # shell = pkgs.zsh;
    shell = pkgs.nushell;
  };

  nix.trustedUsers = [ "henri" "root" ];

   security.acme = {
     email = "henri.bourcereau@gmail.com";
     acceptTerms = true;
     };

  environment.systemPackages =
  with pkgs; [
    ddclient # dyndns client. conf dans /etc/ddclient/ddclient.conf . identifiant défini dans manager OVH section dynhost
    nodejs # pour plugins nvim
    eza # parmis les aliases zsh
  ];


  networking.firewall.allowedTCPPorts = [ 80 443 ];

  # Need a www-data user for our services.
  users.extraUsers."${wwwUser}" = {
    uid = 33;
    group = wwwGroup;
    home = "/var/www";
    createHome = true;
    useDefaultShell = true;
  };
  users.extraGroups."${wwwGroup}".gid = 33;

  services.ddclient = {
    enable = true;
    domains = [ "home.rhumbs.fr" ];
    configFile = "/etc/ddclient/ddclient.conf"; # contains credentials and other confs
  };
  # /etc/ddclient/ddclient.conf :
  #
  # protocol=dyndns2
  # use=web, web=checkip.dyndns.com
  # server=www.ovh.com
  # login=rhumbs.fr-home
  # password='xxxxxxxxx'
  # home.rhumbs.fr
  # cache=/var/lib/ddclient/ddclient.cache

  services.nginx = {
    enable = true;
    user = wwwUser;
    group = wwwGroup;
    recommendedTlsSettings = true;
    recommendedOptimisation = true;
    recommendedGzipSettings = true;
    recommendedProxySettings = true;

    virtualHosts = {

      "misc.rhumbs.fr"  = {
        enableACME = true; #Ask Let's Encrypt to sign a certificate for this vhost
        forceSSL = true;
        root = "/var/www/public/";
        default = true;
        locations = {
          "/" = {
            index = "index.html";
          };
        };
      };

    };

  };

}
