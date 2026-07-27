{ config, pkgs, ... }:

{
  
  home.packages = with pkgs; [
    nil 
    alejandra 
  ];

  programs.vscode = {
    enable = true;
    package = pkgs.vscode;

    
    extensions = with pkgs.vscode-extensions; [
      # --- C / C++ / CMake / GDB ---
      ms-vscode.cpptools 
      ms-vscode.cmake-tools 
      twxs.cmake 
     
      # --- Containerlab / Network Labs ---
      redhat.vscode-yaml
      

      # --- Python ---
      ms-python.python 
      ms-python.vscode-pylance 
      ms-python.debugpy 

      # --- Nix / NixOS ---
      jnoortheen.nix-ide 
      kamadorueda.alejandra 

      # --- Git и Интерфейс ---
      eamodio.gitlens
      pkief.material-icon-theme
      catppuccin.catppuccin-vsc
    ];

    
    userSettings = {
      
      "workbench.colorTheme" = "Catppuccin Mocha";
      "workbench.iconTheme" = "material-icon-theme";
      "editor.fontSize" = 14;
      "editor.fontFamily" = "'JetBrains Mono', 'Fira Code', monospace";
      "editor.fontLigatures" = true;
      "editor.formatOnSave" = true;

      
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil";
      "nix.formatterPath" = "alejandra";
      "[nix]" = {
        "editor.defaultFormatter" = "kamadorueda.alejandra";
      };

      
      "cmake.configureOnOpen" = true;
      "C_Cpp.intelliSenseEngine" = "default";
      "C_Cpp.default.cppStandard" = "c++20";
      "C_Cpp.default.cStandard" = "c11";

      
      "yaml.schemas" = {
    "https://raw.githubusercontent.com/srl-labs/containerlab/main/schemas/clab.schema.json" = "*.clab.yml";

      };

      
      "telemetry.telemetryLevel" = "off";
    };
  };
}
