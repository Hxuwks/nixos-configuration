{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      smartindent = true;
      termguicolors = true;
    };

    # Подключаем плагины
    plugins = {
      # Дерево файлов
      neo-tree = {
        enable = true;
        closeIfLastWindow = true;
      };

      # Красивый Live-Preview прямо в терминале (без браузера)
      render-markdown = {
        enable = true;
        settings = {
          heading.enabled = true;
          code.style = "full";
        };
      };

      # Браузерный предпросмотр по хоткею (опционально)
      markdown-preview = {
        enable = true;
        settings = {
          auto_start = 0;
          theme = "dark";
        };
      };
    };

    # Настройка горячих клавиш
    keymaps = [
      {
        mode = "n";
        key = "<F2>";
        action = "<cmd>Neotree toggle<CR>";
        options.desc = "Toggle Neo-tree";
      }
      {
        mode = "n";
        key = "<leader>mp";
        action = "<cmd>MarkdownPreviewToggle<CR>";
        options.desc = "Toggle Markdown Preview in Browser";
      }
    ];
  };
}
