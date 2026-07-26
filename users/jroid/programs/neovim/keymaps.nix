{
  programs.nvf.settings.vim.keymaps = [
    {
      mode = "i";
      key = "jf";
      action = "<ESC>";
      desc = "";
      silent = false;
    }
    {
      mode = "i";
      key = "<S-CR>";
      action = "<ESC>O";
      desc = "";
      silent = false;
    }
    {
      mode = "n";
      key = "<leader>q";
      action = ":try | quit | catch /E37:/ | wq | endtry<CR><CR>";
      desc = "save and quit";
    }
    {
      mode = "n";
      key = "<leader>jh";
      action = ":setlocal hlsearch!<CR>";
      desc = "toggle search highlights";
    }
    {
      mode = "n";
      key = "<leader>jr";
      action = ":setlocal rnu!<CR>";
      desc = "toggle relative number line";
    }
    {
      mode = "n";
      key = "<leader>js";
      action = ":setlocal spell!<CR>";
      desc = "toggle spell checking";
    }
    {
      mode = "n";
      key = "<leader>jf";
      action = ":filetype detect<CR>";
      desc = "detect filetype";
    }
    {
      mode = "n";
      key = "<leader>jl";
      action = ":Lazy<CR>";
      desc = "show lazy";
    }
    {
      mode = "n";
      key = "<leader>c";
      action = ":bd<CR>";
      desc = "delete buffer";
    }
    {
      mode = "v";
      key = "/r";
      action = "\"hy:%s/<C-r>h//g<left><left>";
      desc = "replace selected";
      silent = false;
    }
    {
      mode = "v";
      key = "/m";
      action = "\"hy:%s/<C-r>h/<C-r>h/g<left><left>";
      desc = "modify selected";
      silent = false;
    }
    {
      mode = "v";
      key = "<A-h>";
      action = "<gv";
    }
    {
      mode = "v";
      key = "<A-l>";
      action = ">gv";
    }
    {
      mode = "x";
      key = "<A-j>";
      action = ":move '>+1<CR>gv-gv";
    }
    {
      mode = "x";
      key = "<A-k>";
      action = ":move '<-2<CR>gv-gv";
    }
    {
      mode = "n";
      key = "\"\"";
      action = ":registers<CR>";
      desc = "list registers";
    }
    {
      mode = [
        "i"
        "c"
        "t"
      ];
      key = "<C-h>";
      action = "<Left>";
      desc = "";
      silent = false;
    }
    {
      mode = [
        "i"
        "c"
        "t"
      ];
      key = "<C-j>";
      action = "<Down>";
      desc = "";
      silent = false;
    }
    {
      mode = [
        "i"
        "c"
        "t"
      ];
      key = "<C-k>";
      action = "<Up>";
      desc = "";
      silent = false;
    }
    {
      mode = [
        "i"
        "c"
        "t"
      ];
      key = "<C-l>";
      action = "<Right>";
      desc = "";
      silent = false;
    }
    {
      mode = "n";
      key = "<A-,>";
      action = "<C-w><";
    }
    {
      mode = "n";
      key = "<A-=>";
      action = "<C-w>+";
    }
    {
      mode = "n";
      key = "<A-->";
      action = "<C-w>-";
    }
    {
      mode = "n";
      key = "<A-.>";
      action = "<C-w>>";
    }
    # Quickfix list window toggle
    {
      mode = "n";
      key = "<leader>jq";
      lua = true;
      desc = "toggle quickfix list window";
      action = /* lua */ ''
        function()
        	for _, win in pairs(vim.api.nvim_tabpage_list_wins(0)) do
        		if vim.bo[vim.api.nvim_win_get_buf(win)].filetype == "qf" then
        			vim.cmd("cclose")
        			return
        		end
        	end
        	vim.cmd("copen")
        end
      '';
    }
    # TermBuf
    {
      mode = "n";
      key = "<leader>tb";
      action = ":enew | TermBuf<CR>";
      desc = "new terminal buffer";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = ":vnew | TermBuf<CR>";
      desc = "new vertial buffer";
    }
  ]
	/*nixfmt:disable*/
  ++ (builtins.map
    (key: {
      key = "<A-${key}>";
      action = "<Cmd>wincmd ${key}<CR>";
      mode = [ "i" "n" "t" ];
    })
    [ "h" "j" "k" "l" ]
  );
	/*nixfmt:enable*/
}
