{ pkgs, ... }:

{
  programs = { 
    sway = {
      enable = true;
      wrapperFeatures.gtk = true;
      extraPackages = with pkgs; [
	swaylock
	swayidle
	wl-clipboard
	mako
	alacritty
	wofi
      ];
    };
    qt5ct.enable = true;
    xwayland.enable = true;
  };

  environment = {
    systemPackages = with pkgs; [ 
      polkit_gnome
      gtk-engine-murrine
      gtk_engines
      gsettings-desktop-schemas
      lxappearance
    ];
    pathsToLink = [ "/libexec" ];
  };

}
