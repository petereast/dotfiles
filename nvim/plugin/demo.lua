vim.lsp.start({
  name = 'rust-analyzer',
  cmd = { '/Users/petereast/.cargo/bin/rust-analyzer'},
  root_dir = vim.fs.dirname(vim.fs.find({'Cargo.toml'}, { upward = true })[1]),
})
