{ inputs, ... }: {

  # local network
  networking.extraHosts =
    ''
    192.168.1.10 home.rhumbs.fr
    '';

  fileSystems."/mnt/diskstation/videos" = {
    device = "diskstation:/volume1/video";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  fileSystems."/mnt/diskstation/music" = {
    device = "diskstation:/volume1/music";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };

  fileSystems."/mnt/diskstation/data" = {
    device = "diskstation:/volume1/data";
    fsType = "nfs";
    options = ["x-systemd.automount" "noauto"];
  };
}
