{ pkgs, ... }:

{

  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        graceful = true;
      };
      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot/efi";
      };
    };
    kernelPackages = pkgs.linuxPackages-xanmod_latest;
  };

  networking = {
    hostName = "nixos-station";
    networkmanager.enable = true;
    useDHCP = false;
    hosts = {
      "10.0.0.16" = [ "git.tar.black" ];
      "10.0.0.12" = [ "EPSON69B65D.local" ];
    };
    interfaces = {
      eno1.useDHCP = true;
      wlp4s0.useDHCP = true;
    };
  };

  time.timeZone = "Europe/London";

  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.modesetting.enable = true;

  system.stateVersion = "21.11";

}
