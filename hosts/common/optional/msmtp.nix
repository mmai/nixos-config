{ config, ... }:
{

  # copié de base_terminal.nix
  environment.etc =
  let msmtprc = pkgs.writeText "msmtprc"
    ''
    account mailtrap
    from henri@bourcereau.fr
    host smtp.mailtrap.io
    port 2525
    user 7d0baad1433da6
    password c59e56e197f524
    tls on
    auth plain

    account default : mailtrap
    '';
  in {
    "msmtprc".source = msmtprc;
  };

  # TODO
  # sops.secrets = {
  #   "msmtp-password" = {
  #     owner = config.users.users.ta.name;
  #     inherit (config.users.users.ta) group;
  #   };
  #   "msmtp-host" = {
  #     owner = config.users.users.ta.name;
  #     inherit (config.users.users.ta) group;
  #   };
  #   "msmtp-address" = {
  #     owner = config.users.users.ta.name;
  #     inherit (config.users.users.ta) group;
  #   };
  # };
  #
  # programs.msmtp = {
  #   enable = true;
  #   setSendmail = true; # set the system sendmail to msmtp's
  #
  #   accounts = {
  #     "default" = {
  #       host = "cat ${config.sops.secrets."msmtp-host".path}";
  #       port = 587;
  #       auth = true;
  #       tls = true;
  #       tls_starttls = true;
  #       from = "cat ${config.sops.secrets."msmtp-address".path}";
  #       user = "cat ${config.sops.secrets."msmtp-address".path}";
  #       passwordeval = "cat ${config.sops.secrets."msmtp-password".path}";
  #       logfile = "~/.msmtp.log";
  #     };
  #   };
  # };
}
