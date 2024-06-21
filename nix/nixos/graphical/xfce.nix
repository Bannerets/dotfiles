{ config, pkgs, lib, ... }:

{
  services.xserver.enable = true;
  services.xserver.desktopManager.xfce.enable = true;
  services.xserver.layout = "us";
}
