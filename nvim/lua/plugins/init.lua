return {
  {
    "stevearc/conform.nvim",
    -- event = 'BufWritePre', -- uncomment for format on save
    config = function()
      require "configs.conform"
    end,
  },
  {
    "williamboman/mason.nvim",
    opts = {
      ensure_installed = {
        "lua-language-server",
        "stylua",
        "gopls",
   			"html-lsp",
        "css-lsp" ,
        "prettier"
      }
    },
    {
      "mfussenegger/nvim-dap",
    },
    {
      "leoluz/nvim-dap-go",
      ft = "go",
      dependencies = "mfussenegger/nvim-dap",
      config = function(_, opts)
        require("dap-go").setup(opts)
      end,
    },
    {
      "neovim/nvim-lspconfig",
      config = function()
        require("nvchad.configs.lspconfig").defaults()
        require "configs.lspconfig"
      end,
    },
    {
      "jose-elias-alvarez/null-ls.nvim",
      ft = "go",
      opts = function()
        return require "configs.null-ls"
      end,
    },
    {
      "olexsmir/gopher.nvim",
      ft = "go",
      requires = {
        "nvim-lua/plenary.nvim",
        "nvim-treesitter/nvim-treesitter",
      },
      config = function(_, opts)
        require("gopher").setup(opts)
      end,
      build = function()
        vim.cmd [[silent! GoInstallDeps]]
      end,
    },
  },

  -- These are some examples, uncomment them if you want to see them work!
  --
  -- {
  -- 	"nvim-treesitter/nvim-treesitter",
  -- 	opts = {
  -- 		ensure_installed = {
  -- 			"vim", "lua", "vimdoc",
  --      "html", "css"
  -- 		},
  -- 	},
  -- },
}
