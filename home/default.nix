{
  config,
  pkgs,
  ...
}: {
  imports = [
    ./shell.nix
    ./apps.nix
    ./editors/vscode.nix
  ];

  home.username = "hxuwks";
  home.homeDirectory = "/home/hxuwks";

  home.stateVersion = "26.05";
  programs.home-manager.enable = true;
}
