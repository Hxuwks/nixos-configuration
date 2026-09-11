{ config, pkgs, inputs, ... }: {

  imports = [
      inputs.nixvim.homeManagerModules.nixvim
      ./nixvim.nix
  ];

  home.packages = with pkgs; [
    zed-editor
    vim

  ];
}
