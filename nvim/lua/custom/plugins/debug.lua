-- debug.lua
--
-- Shows how to use the DAP plugin to debug your code.
--
-- Primarily focused on configuring the debugger for Go, but can
-- be extended to other languages as well. That's why it's called
-- kickstart.nvim and not kitchen-sink.nvim ;)

local js_based_languages = {
  'javascript',
  'javascriptreact',
  'typescript',
  'typescriptreact',
}

return {
  'mfussenegger/nvim-dap',
  dependencies = {
    -- Creates a beautiful debugger UI
    {
      'rcarriga/nvim-dap-ui',
      dependencies = {
        'nvim-neotest/nvim-nio',
      },
      config = function()
        local dap = require 'dap'
        local dapui = require 'dapui'

        -- Dap UI setup
        -- For more information, see |:help nvim-dap-ui|
        dapui.setup {
          icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
          controls = {
            element = 'repl',
            enabled = true,
            icons = {
              jdisconnect = '',
              pause = '⏸',
              play = '▶',
              step_into = '⏎',
              step_over = '⏭',
              step_out = '⏮',
              step_back = 'b',
              run_last = '▶▶',
              terminate = '⏹',
              disconnect = '⏏',
            },
          },
          element_mappings = {},
          expand_lines = true,
          floating = {
            border = 'single',
            mappings = {
              close = { 'q', '<Esc>' },
            },
          },
          force_buffers = true,
          layouts = {
            {
              elements = {
                { id = 'scopes', size = 0.25 },
                { id = 'breakpoints', size = 0.25 },
                { id = 'stacks', size = 0.25 },
                { id = 'watches', size = 0.25 },
              },
              position = 'left',
              size = 40,
            },
            {
              elements = {
                { id = 'repl', size = 0.5 },
                { id = 'console', size = 0.5 },
              },
              position = 'bottom',
              size = 10,
            },
          },
          mappings = {
            edit = 'e',
            expand = { '<CR>', '<2-LeftMouse>' },
            open = 'o',
            remove = 'd',
            repl = 'r',
            toggle = 't',
          },
          render = {
            indent = 1,
            max_value_lines = 100,
          },
        }
        --
        -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
        vim.keymap.set('n', '<F7>', dapui.toggle, { desc = 'Debug: See last session result.' })

        dap.listeners.after.event_initialized['dapui_config'] = dapui.open
        dap.listeners.before.event_terminated['dapui_config'] = dapui.close
        dap.listeners.before.event_exited['dapui_config'] = dapui.close
      end,
    },

    -- Installs the debug adapters for you
    'williamboman/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',

    -- Add your own debuggers here
    {
      'leoluz/nvim-dap-go',
      config = function()
        local dapgo = require 'dap-go'

        require('mason-nvim-dap').setup {
          -- Makes a best effort to setup the various debuggers with
          -- reasonable debug configurations
          automatic_installation = true,

          -- You can provide additional configuration to the handlers,
          -- see mason-nvim-dap README for more information
          handlers = {},

          -- You'll need to check that you have the required things installed
          -- online, please don't ask me how to install them :)
          ensure_installed = {
            -- Update this to ensure that you have the debuggers for the langs you want
            'delve',
          },
        }

        vim.keymap.set('n', '<F6>', dapgo.debug_test, { desc = 'Debug: Test' })

        -- Install golang specific config
        require('dap-go').setup {
          delve = {
            -- On Windows delve must be run attached or it crashes.
            -- See https://github.com/leoluz/nvim-dap-go/blob/main/README.md#configuring
            detached = vim.fn.has 'win32' == 0,
          },
        }
      end,
    },

    {
      'microsoft/vscode-js-debug',
      -- After install, build it and rename the dist director to out
      build = 'npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out',
    },
    {
      'mxsdev/nvim-dap-vscode-js',
      config = function()
        ---@diagnostic disable-next-line: missing-fields
        require('dap-vscode-js').setup {
          -- Path of node executable. Defaults to $NODE_PATH, and then "node"
          -- node_path = "node",

          -- Path to vscode-js-debug installation.
          debugger_path = vim.fn.resolve(vim.fn.stdpath 'data' .. '/lazy/vscode-js-debug'),

          -- Command to use to launch the debug server. Takes precedence over "node_path" and "debugger_path".
          -- debugger_cmd = { "js-debug-adapter" },

          -- which adapters to register in nvim-dap
          adapters = {
            'node-terminal',
            'pwa-node',
            'pwa-chrome',
            'pwa-msedge',
            'pwa-extensionHost',
          },
        }
      end,
    },
  },
  config = function()
    local dap = require 'dap'

    -- Basic debugging keymaps, feel free to change to your liking!
    vim.keymap.set('n', '<F5>', dap.continue, { desc = 'Debug: Start/Continue' })
    vim.keymap.set('n', '<F1>', dap.step_into, { desc = 'Debug: Step Into' })
    vim.keymap.set('n', '<F2>', dap.step_over, { desc = 'Debug: Step Over' })
    vim.keymap.set('n', '<F3>', dap.step_out, { desc = 'Debug: Step Out' })
    vim.keymap.set('n', '<leader>b', dap.toggle_breakpoint, { desc = 'Debug: Toggle Breakpoint' })
    vim.keymap.set('n', '<leader>B', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint' })

    vim.fn.sign_define('DapBreakpoint', { text = '󰏃', texthl = 'NotifyWARNIcon', linehl = '', numhl = '' })
    vim.fn.sign_define('DapBreakpointCondition', { text = '', texthl = 'NotifyWARNIcon', linehl = '', numhl = '' })
    vim.fn.sign_define('DapLogPoint', { text = '', texthl = 'NotifyINFOIcon', linehl = '', numhl = '' })

    for _, lang in ipairs(js_based_languages) do
      dap.configurations[lang] = {
        -- Debug single nodejs files
        {
          type = 'pwa-node',
          request = 'launch',
          name = 'Launch file',
          program = '${file}',
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Debug nodejs processes (make sure to add --inspect when you run the process)
        {
          type = 'pwa-node',
          request = 'attach',
          name = 'Attach',
          processId = require('dap.utils').pick_process,
          cwd = '${workspaceFolder}',
          sourceMaps = true,
        },
        -- Debug web applications
        {
          type = 'pwa-chrome',
          request = 'launch',
          name = 'Launch & Debug Chrome',
          url = 'http://localhost:3000',
          webRoot = '${workspaceFolder}',
          skipFiles = {
            '<node_internals>/**/*.js',
          },
          protocol = 'inspector',
          sourceMaps = true,
          userDataDir = false,
        },
        -- Divider for the launch.json derived configurations
        {
          name = '———————— launch.json configs ————————',
          type = '',
          request = 'launch',
        },
      }
    end
  end,
  keys = {
    {
      '<leader>da',
      function()
        if vim.fn.filereadable '.vscode/launch.json' then
          local dap_vscode = require 'dap.ext.vscode'
          dap_vscode.load_launchjs(nil, {
            ['pwa-node'] = js_based_languages,
            ['node'] = js_based_languages,
            ['pwa-chrome'] = js_based_languages,
            ['chrome'] = js_based_languages,
          })
        end
        require('dap').continue()
      end,
      desc = 'Run with Args',
    },
  },
}
