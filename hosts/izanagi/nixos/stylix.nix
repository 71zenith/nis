{
  pkgs,
  inputs,
  ...
}: {
  stylix = {
    polarity = "dark";
    image = "${pkgs.my-walls}/share/wallpapers/oxocarbon.png";
    base16Scheme = inputs.nix-colors.colorSchemes.oxocarbon-dark;
    fonts = rec {
      serif = {
        package = pkgs.my-fonts;
        name = "Kollektif";
      };
      sansSerif = {
        package = pkgs.my-fonts;
        inherit (serif) name;
      };
      monospace = {
        package = pkgs.my-fonts;
        name = "Comic Shanns Mono";
      };
      emoji = {
        package = pkgs.noto-fonts-emoji;
        name = "Noto Color Emoji";
      };
      sizes = {
        applications = 14;
        desktop = 14;
        popups = 14;
        terminal = 15;
      };
    };
    opacity = {
      terminal = 0.80;
      popups = 0.90;
      desktop = 0.90;
    };
    cursor = {
      package = pkgs.phinger-cursors;
      name = "phinger-cursors-light";
      size = 32;
    };
  };
  fonts = {
    fontconfig.defaultFonts = rec {
      sansSerif = ["Kollektif" "irohamaru"];
      serif = sansSerif;
      emoji = ["Noto Color Emoji"];
      monospace = ["Comic Shanns Mono"];
    };

    packages = with pkgs; [
      my-fonts
      (nerdfonts.override {fonts = ["NerdFontsSymbolsOnly"];})
    ];
  };
}
