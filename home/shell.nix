{ config, pkgs, ... }:

{
  programs.bash = {
    enable = true;
    initExtra = ''
      PS1='\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ '
    '';
    shellAliases = {
      rebuild = "sudo nixos-rebuild switch --flake .#thinkpad";
      up = "nix flake update";
    };
  };
}
