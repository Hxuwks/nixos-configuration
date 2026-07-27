{ config, pkgs, lib, ... }:

with lib;
let cfg = config.modules.virt.virtualization;
in {
  options.modules.virt.virtualization = {
    enable = mkEnableOption "Hypervisors & Virtual Machines (Libvirt/KVM, VMware)";
  };

  config = mkIf cfg.enable {
    virtualisation.libvirtd = {
      enable = true;
      qemu.package = pkgs.qemu_kvm;
    };

    virtualisation.vmware.host.enable = true;

    environment.systemPackages = with pkgs; [
      virt-manager
      qemu
    ];
  };
}
