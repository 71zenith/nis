{
  pkgs,
  config,
  inputs,
  myUserName,
  ...
}: let
  inherit (config.stylix.base16Scheme) palette;
  scripts = pkgs.callPackage ../../../pkgs/scripts.nix {};
in {
  imports = [
    ./tools.nix
    ./mpv.nix
    ./zsh.nix
    ./waybar.nix
    ./nvim.nix
    ./git.nix
    ./rofi.nix
    ./xdg.nix
    ./firefox.nix
    ./spotify-player.nix
    ./hyprland.nix
  ];

  # NOTE: virt-manager fix
  dconf = {
    enable = true;
    settings = {
      "org/virt-manager/virt-manager/connections" = {
        autoconnect = ["qemu:///system"];
        uris = ["qemu:///system"];
      };
    };
  };

  home = {
    username = "${myUserName}";
    homeDirectory = "/home/${myUserName}";

    stateVersion = "24.05";

    pointerCursor = {
      x11.enable = true;
      gtk.enable = true;
    };
  };

  nixpkgs.config = import ./nixpkgs.nix;
  nixpkgs.overlays = [inputs.neorg-overlay.overlays.default];
  xdg.configFile."nixpkgs/config.nix".source = ./nixpkgs.nix;

  qt = {
    enable = true;
    platformTheme.name = "gtk3";
  };

  gtk = {
    enable = true;
    iconTheme = {
      name = "Zafiro-icons-Dark";
      package = pkgs.zafiro-icons;
    };
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
    config = {
      hyprland.default = ["gtk" "hyprland"];
    };
  };

  xresources.properties = with palette; {
    "bar.background" = "#${base02}";
    "bar.foreground" = "#${base0B}";
    "bar.font" = "${config.stylix.fonts.serif.name} ${toString config.stylix.fonts.sizes.desktop}";
    "window.foreground" = "#${base04}";
    "window.background" = "#${base02}";
    "mark.background" = "#${base0A}";
  };
}
