const filecopy = require("filecopy");

filecopy("~/.config/nvim/init.vim", "init.vim", {
  mkdirp: true,
});
