{ pkgs, ... }:

{

  sound.enable = false;
  services.pipewire = {
    enable = true;
    alsa = {
      enable = true;
      support32Bit = true;
    };
    pulse.enable = true;
    jack.enable = true;
  };

  programs = {
    steam.enable = true;
    kdeconnect.enable = true;
  };
  hardware.opengl = {
    enable = true;
    driSupport32Bit = true;
  };

  # temp disabled, pycurl39 build issue
  services.printing.enable = false;

  environment.systemPackages = with pkgs; [
    gamemode
    kdenlive
    krita
    lutris
    obs-studio
    polymc
    skypeforlinux
    spotify
    wine
    wine64
  ];

}
