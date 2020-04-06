{ config, lib, pkgs, ... }:
{
  # -------------  packages ---------------
  environment.systemPackages = with pkgs; [
    mu # utilties for indexing and searching Maildirs
    neomutt # mail client
    isync # (mbsync) IMAP and MailDir mailbox synchronizer
  ];

  # -----------  services -----------
  systemd.user.timers.sync-mails = {
    description = "run mbsync every 10 minutes";
    wantedBy = [ "timers.target" ]; # enable it & auto start it

    timerConfig = {
      OnBootSec = "1m"; # first run 1min after boot up
      OnUnitInactiveSec = "10m"; # run 15min after sync-notes has finished
    };
  };

  systemd.user.services.sync-mails = {
    description = "Synchronize mails with mbsync";
    path = [ pkgs.pass ]; # the `pass` command is used in mbsyncrc config file, so it must be in the path
    script = "${pkgs.isync}/bin/mbsync -a";
    serviceConfig.Type = "oneshot";
  };
}
