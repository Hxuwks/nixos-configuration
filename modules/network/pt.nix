{
  config,
  pkgs,
  lib,
  ...
}:
with lib; let
  cfg = config.modules.netwiork.pt;
in {
  options.modules.network.analysis = {
    enable = mkEnableOption "Cisco packet tracer integraion into Nix";
  };

  config = mkIf cfg.enable {
    nixpkgs.config.allowUnfree = true;

    environment.systemPackages = with pkgs; [
      cisco-packet-tracer_9
    ];
  };
}
