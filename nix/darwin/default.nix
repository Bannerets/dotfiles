{ config, pkgs, lib, ... }:
{
  nix.package = pkgs.lix.overrideAttrs {
    doCheck = false;
    doInstallCheck = false;
  };

  services.nix-daemon.enable = true;

  programs.bash.enable = false;

  system.defaults.dock.autohide = true;
  system.defaults.dock.show-recents = false;
  system.defaults.dock.tilesize = 60;
  system.defaults.dock.mineffect = "scale";
  system.defaults.dock.wvous-br-corner = 1;

  system.defaults.NSGlobalDomain.AppleFontSmoothing = 0;

  system.defaults.NSGlobalDomain.InitialKeyRepeat = 15;
  system.defaults.NSGlobalDomain.KeyRepeat = 2;

  system.defaults.NSGlobalDomain.NSAutomaticCapitalizationEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticDashSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticPeriodSubstitutionEnabled = false;
  system.defaults.NSGlobalDomain.NSAutomaticQuoteSubstitutionEnabled = false;

  system.defaults.finder.AppleShowAllExtensions = true;
  system.defaults.finder.ShowPathbar = true;

  environment.shells =
    if pkgs.stdenv.isAarch64
    then ["/opt/homebrew/bin/fish"]
    else ["/usr/local/bin/fish"];

  time.timeZone = lib.mkDefault "GMT";

  networking.knownNetworkServices = [ "Wi-Fi" ];
  networking.dns = lib.mkDefault [
    "1.1.1.1"
    "1.0.0.1"
    "2606:4700:4700::1111"
    "2606:4700:4700::1001"
  ];

  security.sudo.extraConfig = ''
    Defaults env_keep += "TERM TERMINFO"
    Defaults env_keep += "SSH_TTY"
  '';

  environment.etc."npmrc".text = ''
    prefix = ''${HOME}/.npm
  '';
  environment.variables.NPM_CONFIG_GLOBALCONFIG = "/etc/npmrc";

  nixpkgs.hostPlatform = "x86_64-darwin";

  # Used for backwards compatibility, please read the changelog before changing.
  # $ darwin-rebuild changelog
  system.stateVersion = 4;
}
