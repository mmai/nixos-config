# Mail stack:
#   Display maildirs and read emails          -> neomutt
#   Write emails                              -> vim (should already be there)
#   Receive emails & synchronize maildir      -> mbsync (isync)
#   Submit emails to send                     -> msmtp
#   Deal with MIME encoded email packages     -> ripmime
#   Display HTML emails                       -> w3m
#   Search maildirs                           -> mu
#   Send encrypted email                      -> gpupg1orig
# and various automation provided by systemd
{ config, lib, pkgs, ... }:
{
  # -------------  packages ---------------
  environment.systemPackages = with pkgs; [
    mu # utilties for indexing and searching Maildirs
    neomutt # mail client
    isync # (mbsync) IMAP and MailDir mailbox synchronizer
    msmtp
    ripmime
    w3m
    gnupg1orig
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

  systemd.user.services = {
    sync-mails = {
      description = "Synchronize mails with mbsync";
      path = [ pkgs.pass ]; # the `pass` command is used in mbsyncrc config file, so it must be in the path
      script = "${pkgs.isync}/bin/mbsync -a";
      serviceConfig.Type = "oneshot";
    };
    mu = {
      description = "Updating mail database";
      path = [ pkgs.mu ];
      script = "mu index --quiet -m ~/.mail";
      startAt = "daily";
      wantedBy = [ "timers.target" ];
    };
  };

    # msmtp-runqueue = {
    #   description = "Flushing mail queue";
    #   script = builtins.readFile "/home/henri/prefix/bin/msmtp-runqueue";
    #   preStart = "mkdir -p /home/henri/.msmtpqueue";
    #   postStop = "rm -f /home/henri/.msmtpqueue/.lock";
    #   startAt = "*:0/10";
    #   serviceConfig = {
    #     TimeoutStartSec = "2min";
    #   };
    #   path = [ pkgs.msmtp ];
    # };
}
