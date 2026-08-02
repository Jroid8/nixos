{
  programs.nvf.settings.vim.keymaps = [
    {
      mode = "i";
      key = "jf";
      action = "<ESC>";
      silent = false;
    }
    {
      mode = "i";
      key = "<S-CR>";
      action = "<ESC>O";
      silent = false;
    }
    {
      mode = "n";
      key = "<leader>q";
      action = ":try | quit | catch /E37:/ | wq | endtry<CR><CR>";
      desc = "Save and quit";
    }
    {
      mode = "n";
      key = "<leader>jh";
      action = ":setlocal hlsearch!<CR>";
      desc = "Toggle search highlights";
    }
    {
      mode = "n";
      key = "<leader>jr";
      action = ":setlocal rnu!<CR>";
      desc = "Toggle relative number line";
    }
    {
      mode = "n";
      key = "<leader>js";
      action = ":setlocal spell!<CR>";
      desc = "Toggle spell checking";
    }
    {
      mode = "n";
      key = "<leader>jf";
      action = ":filetype detect<CR>";
      desc = "Detect filetype";
    }
    {
      mode = "n";
      key = "<leader>jl";
      action = ":Lazy<CR>";
      desc = "Show lazy";
    }
    {
      mode = "n";
      key = "<leader>c";
      action = ":bd<CR>";
      desc = "Delete buffer";
    }
    {
      mode = "v";
      key = "/r";
      action = "\"hy:%s/<C-r>h//g<left><left>";
      desc = "Replace selected";
      silent = false;
    }
    {
      mode = "v";
      key = "/m";
      action = "\"hy:%s/<C-r>h/<C-r>h/g<left><left>";
      desc = "Modify selected";
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
      desc = "List registers";
    }
    {
      mode = [
        "i"
        "c"
        "t"
      ];
      key = "<C-h>";
      action = "<Left>";
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
      desc = "Toggle quickfix list window";
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
      desc = "New terminal buffer";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = ":vnew | TermBuf<CR>";
      desc = "New vertial buffer";
    }
    # Neotree
    {
      mode = "n";
      key = "<leader>e";
      action = ":Neotree toggle %<CR>";
      desc = "Toggle neotree";
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
