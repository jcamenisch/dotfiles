-- SuperMaven is an LLM-powered code completion assistant that is fast and uses the codebase as context.
-- See https://supermaven.com/
return {
  'supermaven-inc/supermaven-nvim', -- AI coding autocomplete (Altenative to Github Copilot autocomplete)
  config = function()
    require('supermaven-nvim').setup {
      keymaps = {
        accept_suggestion = '<tab>',
      },
    }
  end,
}
