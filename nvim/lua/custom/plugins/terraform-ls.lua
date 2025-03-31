-- Prerequisites:
--   - Install the `terraform` binary
--   - Install the `tflint` binary
--   - Install the `terraform-ls` binary

require('lspconfig').terraformls.setup {}
require('lspconfig').tflint.setup {}

return {}
