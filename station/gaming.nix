{ pkgs, ... }:

{

  programs.steam.enable = true;
  hardware = {
    xpadneo.enable = true;
    xone.enable = true;
    opengl = {
      enable = true;
      driSupport32Bit = true;
    };
  };

  environment.systemPackages = with pkgs; [
    microsoft-edge-dev
    gamemode
    lutris
    polymc
    vulkan-tools
  ];

}
