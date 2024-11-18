{
  # keyboard remapping
  services.kanata = {
    enable = true;

    keyboards = {
      thinkpad = {
        devices = [ "/dev/input/by-path/platform-i8042-serio-0-event-kbd" ];
        # config = builtins.readFile (./atomic + "/kanata.kbd"); # includes don't work
        config = builtins.readFile (./kanata.kbd);
      };
      msCurve = {
        devices = [ "/dev/input/by-id/usb-Microsoft_Comfort_Curve_Keyboard_2000-event-kbd" ];
        config = builtins.readFile (./kanata.kbd);
      };
    };
  };
}
