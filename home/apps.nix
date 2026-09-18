{pkgs, ...}: {
  programs.firefox.enable = true;

  home.packages = with pkgs; [
    amberol
    planify
    telegram-desktop
    libreoffice

    powertop
    mermaid-cli
    ptyxis
    resources
    imhex
    typesetter
    typst
    # for university
    arduino
  ];
}
