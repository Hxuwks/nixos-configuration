{pkgs, ...}: {
  home.packages = with pkgs; [
    obsidian

    # LSP, линтеры и форматировщики
    nil # Nix LSP (которого просит Zed)
    nixd # Альтернативный Nix LSP
    statix # Nix linter
    alejandra # Nix formatter
    pyright # Python LSP
    clang-tools # C/C++ (clangd)
  ];

  programs.zed-editor = {
    enable = true;

    userSettings = {
      theme = "Catppuccin Latte";

      # Пробрасываем системные LSP в Zed
      lsp = {
        nil = {binary = {path = "nil";};};
        pyright = {binary = {path = "pyright";};};
        clangd = {binary = {path = "clangd";};};
      };

      # Настройки для языка Nix
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
