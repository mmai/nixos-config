{
  # keyboard remapping
  services.kanata = {
    enable = true;

    keyboards.msCurve = {
      devices = [ "/dev/input/by-id/usb-Microsoft_Comfort_Curve_Keyboard_2000-event-kbd" ];
      config = builtins.readFile (./atomic + "/kanata_merged.kbd");
    };
  };
}
