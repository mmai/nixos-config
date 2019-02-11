# Lenovo thinkpad 470s

Add missing resolutions with :
```
xrandr # Shows displays -> note identifier (here: eDP-1)
cvt 1280 720 # Shows Modeline parameters for 1280x720
sudo xrandr --newmode "1280x720_60.00"   74.50  1280 1344 1472 1664  720 723 728 748 -hsync +vsync # Use parameters from previous command
sudo xrandr --addmode eDP-1 "1280x720_60.00"
```
