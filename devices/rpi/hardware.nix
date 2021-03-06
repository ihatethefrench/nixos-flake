{
  lib,
  modulesPath,
  ...
}: {
  imports = [(modulesPath + "/installer/scan/not-detected.nix")];

  boot = {
    initrd = {
      availableKernelModules = ["usb_storage" "usbhid" "uas"];
      kernelModules = [];
    };
    kernelModules = [];
    extraModulePackages = [];
  };

  networking = {
    useDHCP = lib.mkDefault false;
    interfaces = {
      eth0.useDHCP = lib.mkDefault true;
      wlan0.useDHCP = lib.mkDefault true;
    };
  };
}
