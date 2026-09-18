{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian

    nil
    nixd
    statix
    alejandra
    pyright
    clang-tools
  ];

  programs.zed-editor = {
    enable = true;

    userSettings = {
      theme = "Catppuccin Latte";

      lsp = {
        nil = {binary = {path = "nil";};};
        pyright = {binary = {path = "pyright";};};
        clangd = {binary = {path = "clangd";};};
      };

      languages = {
        Nix = {
          language_servers = ["nil"];
          formatter = {
            external = {
              command = "alejandra";
              args = ["-"];
            };
          };
        };
      };

      format_on_save = "on";
    };
  };
}
