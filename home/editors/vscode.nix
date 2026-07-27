{ config, pkgs, ... }:

{
  # Ставим форматер и LSP для Nix в систему, чтобы VS Code мог к ним обращаться
  home.packages = with pkgs; [
    nil # Отличный Language Server для Nix
    alejandra # Быстрый и строгий автоформаттер Nix-кода
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    # Декларативный список плагинов из nixpkgs
    extensions = with pkgs.vscode-extensions; [
      # --- C / C++ / CMake / GDB ---
      ms-vscode.cpptools # Исполняемый движок C/C++ и отладчик (GDB/LLDB)
      ms-vscode.cmake-tools # Полная интеграция CMake (сборка, таски, выбор компилятора)
      twxs.cmake # Подсветка синтаксиса CMakeLists.txt и автодополнение

      # --- Containerlab / Network Labs ---
      # Синтаксис и валидация YAML для топологий Containerlab
      redhat.vscode-yaml
      

      # --- Python ---
      ms-python.python # Основное расширение Python
      ms-python.vscode-pylance # Быстрый и мощный LSP сервер (автодополнение, типы)
      ms-python.debugpy # Официальный отладчик Python

      # --- Nix / NixOS ---
      jnoortheen.nix-ide # Интеграция Nix LSP, подсветка и форматирование
      kamadorueda.alejandra # Поддержка автоформатирования через Alejandra

      # --- Git и Интерфейс ---
      eamodio.gitlens
      pkief.material-icon-theme
      catppuccin.catppuccin-vsc
    ];

    # Декларативные настройки (settings.json)
    userSettings = {
      # Внешний вид
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', monospace";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;

      # Настройка Nix-IDE (используем nil + alejandra)
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "alejandra";
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };

      # Настройка C / C++ / CMake
      "cmake.configureOnOpen" = true;
      "C_Cpp.intelliSenseEngine" = "default";
      "C_Cpp.default.cppStandard" = "c++20";
      "C_Cpp.default.cStandard" = "c11";

      # Настройка Containerlab / YAML
      "yaml.schemas" = {
        # Включаем валидацию и подсказки для топологий Containerlab по ключу topology
        "https://raw.githubusercontent.com/srl-labs/containerlab/main/schemas/clab.schema.json" = "*.clab.yml";
      };

      # Отключение телеметрии
      "telemetry.telemetryLevel" = "off";
    };
  };
}
