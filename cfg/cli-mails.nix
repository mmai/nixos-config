# Mail stack:
#   Display maildirs and read emails          -> neomutt
#   Write emails                              -> vim (should already be there)
#   Receive emails & synchronize maildir      -> mbsync (isync)
#   Submit emails to send                     -> msmtp
#   Deal with MIME encoded email packages     -> ripmime
#   Display HTML emails                       -> w3m
#   Open urls                                 -> urlscan
#   Search maildirs, manage tags              -> notmuch
#   Send encrypted email                      -> gpupg1orig
# Contacts & Calendar stack:
#   Synchronize contacts & calendars          -> vdirsyncer
#   Manage contacts                           -> khard
#   Manage calendars                          -> khal
# and various automation provided by systemd
{ config, lib, pkgs, ... }:
let
  unstable = import <unstable> {};
in
{
  # -------------  packages ---------------
  environment.systemPackages = with pkgs; [
    # mu # utilties for indexing and searching Maildirs
    notmuch # utilties for indexing and searching Maildirs
    unstable.neomutt # mail client, needs version > 20191025 to get named-mailboxes command
    isync # (mbsync) IMAP and MailDir mailbox synchronizer
    msmtp
    ripmime
    urlscan # search, display and open urls in emails (better than urlview)
    vdirsyncer # Calendar & Contacts synchronizer
    khard # Contacts cli viewer
    khal  # Calendar cli viewer
    w3m
    gnupg1orig
  ];

  # -----------  services -----------
  # XXX sync-mail doesn't work :  "gpg: échec du déchiffrement : Pas de clef secrète"
  # systemd.timers.sync-mails = {
  #   description = "run mbsync every 10 minutes";
  #   wantedBy = [ "timers.target" ]; # enable it & auto start it
  #
  #   timerConfig = {
  #     OnBootSec = "1m"; # first run 1min after boot up
  #     OnUnitInactiveSec = "10m"; # run 15min after sync-notes has finished
  #   };
  # };
  systemd.services = {
    # sync-mails = {
    #   description = "Synchronize mails with mbsync";
    #   path = [ pkgs.pass ]; # the `pass` command is used in mbsyncrc config file, so it must be in the path
    #   script = "${pkgs.isync}/bin/mbsync -a";
    #   serviceConfig.Type = "oneshot";
    #   serviceConfig.User = "henri";
    # };
    mu = {
      description = "Updating mail database";
      path = [ pkgs.mu ];
      script = "mu index --quiet -m ~/.mail";
      startAt = "daily";
      wantedBy = [ "timers.target" ];
      serviceConfig.User = "henri";
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
