{
  config,
  pkgs,
  ...
}: {

  programs.firefox.enable = true;

  home.packages = with pkgs; [
    obsidian
    amberol
    planify
    telegram-desktop
    libreoffice

    powertop
    mermaid-cli
    ptyxis
    resources
    spotify
    imhex
    typesetter
    typst

    # for university
    arduino
  ];
}
