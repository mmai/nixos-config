''
  @define-color color8 #111111;

  @define-color backgroundlight @color8;
  @define-color backgrounddark #FFFFFF;
  @define-color workspacesbackground1 @color8;
  @define-color workspacesbackground2 #FFFFFF;
  @define-color bordercolor @color8;
  @define-color textcolor1 @color8;
  @define-color textcolor2 #FFFFFF;
  @define-color textcolor3 #FFFFFF;
  @define-color iconcolor @color8;
    /* -----------------------------------------------------
     * General 
     * ----------------------------------------------------- */

    * {
        font-family: "Fira Sans Semibold", FontAwesome, Roboto, Helvetica, Arial, sans-serif;
        border: none;
        border-radius: 0px;
    }

    window#waybar {
        background-color: rgba(0,0,0,0.8);
        border-bottom: 0px solid #ffffff;
        /* color: #FFFFFF; */
        background: transparent;
        transition-property: background-color;
        transition-duration: .5s;
    }

    /* -----------------------------------------------------
     * Workspaces 
     * ----------------------------------------------------- */

    #workspaces {
        background: @workspacesbackground1;
        margin: 2px 1px 3px 1px;
        padding: 0px 1px;
        border-radius: 15px;
        border: 0px;
        font-weight: bold;
        font-style: normal;
        opacity: 0.8;
        font-size: 16px;
        color: @textcolor1;
    }

    #workspaces button {
        padding: 0px 5px;
        margin: 4px 3px;
        border-radius: 15px;
        border: 0px;
        color: @textcolor1;
        background-color: @workspacesbackground2;
        transition: all 0.3s ease-in-out;
        opacity: 0.4;
    }

    #workspaces button.active {
        color: @textcolor1;
        background: @workspacesbackground2;
        border-radius: 15px;
        min-width: 40px;
        transition: all 0.3s ease-in-out;
        opacity:1.0;
    }

    #workspaces button:hover {
        color: @textcolor1;
        background: @workspacesbackground2;
        border-radius: 15px;
        opacity:0.7;
    }

    /* -----------------------------------------------------
     * Tooltips
     * ----------------------------------------------------- */

    tooltip {
        border-radius: 10px;
        background-color: @backgroundlight;
        opacity:0.8;
        padding:20px;
        margin:0px;
    }

    tooltip label {
        color: @textcolor2;
    }

    /* -----------------------------------------------------
     * Window
     * ----------------------------------------------------- */

    #window {
        background: @backgroundlight;
        margin: 5px 15px 5px 0px;
        padding: 2px 10px 0px 10px;
        border-radius: 12px;
        color:@textcolor2;
        font-size:16px;
        font-weight:normal;
        opacity:0.8;
    }

    window#waybar.empty #window {
        background-color:transparent;
    }

    /* -----------------------------------------------------
     * Taskbar
     * ----------------------------------------------------- */

    #taskbar {
        background: @backgroundlight;
        margin: 3px 15px 3px 0px;
        padding:0px;
        border-radius: 15px;
        font-weight: normal;
        font-style: normal;
        opacity:0.8;
        border: 3px solid @backgroundlight;
    }

    #taskbar button {
        margin:0;
        border-radius: 15px;
        padding: 0px 5px 0px 5px;
    }

    /* -----------------------------------------------------
     * Modules
     * ----------------------------------------------------- */

    .modules-left > widget:first-child > #workspaces {
        margin-left: 0;
    }

    .modules-right > widget:last-child > #workspaces {
        margin-right: 0;
    }

    /* -----------------------------------------------------
     * Custom Quicklinks
     * ----------------------------------------------------- */

    #custom-brave, 
    #custom-browser, 
    #custom-keybindings, 
    #custom-outlook, 
    #custom-filemanager, 
    #custom-teams, 
    #custom-chatgpt, 
    #custom-calculator, 
    #custom-windowsvm, 
    #custom-cliphist, 
    #custom-wallpaper, 
    #custom-settings, 
    #custom-wallpaper, 
    #custom-system,
    #custom-waybarthemes {
        margin-right: 23px;
        font-size: 20px;
        font-weight: bold;
        opacity: 0.8;
        color: @iconcolor;
    }

    #custom-system {
        margin-right:15px;
    }

    #custom-wallpaper {
        margin-right:25px;
    }

    #custom-waybarthemes, #custom-settings {
        margin-right:20px;
    }

    #custom-chatgpt {
        margin-right: 15px;
        background-image: url("../assets/ai-icon.png");
        background-repeat: no-repeat;
        background-position: center;
        padding-right: 24px;
    }

    #custom-ml4w-welcome {
        margin-right: 15px;
        background-image: url("../assets/ml4w-icon.png");
        background-repeat: no-repeat;
        background-position: center;
        padding-right: 24px;
    }

    /* -----------------------------------------------------
     * Idle Inhibator
     * ----------------------------------------------------- */

    #idle_inhibitor {
        margin-right: 15px;
        font-size: 22px;
        font-weight: bold;
        opacity: 0.8;
        color: @iconcolor;
    }

    #idle_inhibitor.activated {
        margin-right: 15px;
        font-size: 20px;
        font-weight: bold;
        opacity: 0.8;
        color: #dc2f2f;
    }

    /* -----------------------------------------------------
     * Custom Modules
     * ----------------------------------------------------- */

    #custom-appmenu, #custom-appmenuwlr {
        background-color: @backgrounddark;
        font-size: 16px;
        color: @textcolor1;
        border-radius: 15px;
        padding: 0px 10px 0px 10px;
        margin: 3px 15px 3px 14px;
        opacity:0.8;
        border:3px solid @bordercolor;
    }

    /* -----------------------------------------------------
     * Custom Exit
     * ----------------------------------------------------- */

    #custom-exit {
        margin: 0px 20px 0px 0px;
        padding:0px;
        font-size:20px;
        color: @iconcolor;
    }

    /* -----------------------------------------------------
     * Custom Updates
     * ----------------------------------------------------- */

    #custom-updates {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 10px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    #custom-updates.green {
        background-color: @backgroundlight;
    }

    #custom-updates.yellow {
        background-color: #ff9a3c;
        color: #FFFFFF;
    }

    #custom-updates.red {
        background-color: #dc2f2f;
        color: #FFFFFF;
    }

    /* -----------------------------------------------------
     * Custom Youtube
     * ----------------------------------------------------- */

    #custom-youtube {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 10px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    /* -----------------------------------------------------
     * Hardware Group
     * ----------------------------------------------------- */

    /* #disk,#memory,#cpu,#language {
         background-color: @backgrounddark;
         margin:0px;
         padding:0px;
         font-size:16px;
         color:@iconcolor;
     }
     */

    #language {
        margin-right:10px;
    }

    /* -----------------------------------------------------
     * Clock
     * ----------------------------------------------------- */

    #clock {
        background-color: @backgrounddark;
        font-size: 16px;
        color: @textcolor1;
        border-radius: 15px;
        padding: 1px 10px 0px 10px;
        margin: 3px 15px 3px 0px;
        opacity:0.8;
        border:3px solid @bordercolor;   
    }

    /* -----------------------------------------------------
     * Pulseaudio
     * ----------------------------------------------------- */

    #disk,#memory,#cpu,#language, #pulseaudio {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 10px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    #pulseaudio.muted {
        background-color: @backgrounddark;
        color: @textcolor1;
    }

    /* -----------------------------------------------------
     * Network
     * ----------------------------------------------------- */

    #network {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 10px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    #network.ethernet {
        background-color: @backgroundlight;
        color: @textcolor2;
    }

    #network.wifi {
        background-color: @backgroundlight;
        color: @textcolor2;
    }

    /* -----------------------------------------------------
     * Bluetooth
     * ----------------------------------------------------- */

    #bluetooth, #bluetooth.on, #bluetooth.connected {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 10px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    #bluetooth.off {
        background-color: transparent;
        padding: 0px;
        margin: 0px;
    }

    /* -----------------------------------------------------
     * Battery
     * ----------------------------------------------------- */

    #battery {
        background-color: @backgroundlight;
        font-size: 16px;
        color: @textcolor2;
        border-radius: 15px;
        padding: 2px 15px 0px 10px;
        margin: 5px 15px 5px 0px;
        opacity:0.8;
    }

    #battery.charging, #battery.plugged {
        color: @textcolor2;
        background-color: @backgroundlight;
    }

    @keyframes blink {
        to {
            background-color: @backgroundlight;
            color: @textcolor2;
        }
    }

    #battery.critical:not(.charging) {
        background-color: #f53c3c;
        color: @textcolor3;
        animation-name: blink;
        animation-duration: 0.5s;
        animation-timing-function: linear;
        animation-iteration-count: infinite;
        animation-direction: alternate;
    }

    /* -----------------------------------------------------
     * Tray
     * ----------------------------------------------------- */

    #tray {
        padding: 0px 15px 0px 0px;
    }

    #tray > .passive {
        -gtk-icon-effect: dim;
    }

    #tray > .needs-attention {
        -gtk-icon-effect: highlight;
    }

''
