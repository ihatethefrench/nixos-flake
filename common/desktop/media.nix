{pkgs, ...}: {
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

  programs.kdeconnect.enable = true;

  services = {
    printing = {
      enable = true;
      drivers = with pkgs; [epson-escpr epson-escpr2];
    };
    avahi = {
      enable = true;
      nssmdns = true;
    };
  };

  hardware.bluetooth.enable = true;

  fonts.fonts = with pkgs; [
    (nerdfonts.override {fonts = ["Hack"];})
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
  ];
}
