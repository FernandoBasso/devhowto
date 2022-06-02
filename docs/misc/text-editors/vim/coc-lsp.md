---
title: CoC and LSP — Conquer of Completion and Language Server Protocol | vim, neovim
description: Some tips for using CoC and Language Server Protocol and other related stuff with Vim and Neovim.
---

# CoC and LSP

## Copy contents of popup window

[F.A.Q · neoclide/coc.nvim Wiki](https://github.com/neoclide/coc.nvim/wiki/F.A.Q#how-to-open-link-in-float-window)

```
C-w w :% yank +
```

## CoC ESLint

```jsx
:CocInstall coc-eslint
:CocLocalConfig
```

Then add this to `./.vim/coc-settings.json`:

```json
{
  "eslint.options": {
    "configFile": ".eslintrc"
  },
  "eslint.validate": ["javascript", "javascriptreact"],
  "eslint.autoFixOnSave": false
}
```

I don't like auto-fixable stuff. I like to see the message about smelly stuff, and then fix them myself because that is an opportunity to learn. If it auto-fixes for me, I learn nothing.

Then, on something with squiggles indicating something wrong, run `:CocAction`. Or set a key biding. A few suggestions:

```json
:nmap <Leader>ca <Plug>(coc-codeaction)
:nmap <Leader>\ <Plug>(coc-codeaction)
```

"ca" is a mnemonic for "code action". `<Leader>\` is easy to type (and not yet used on my vim setup). My leader key is ``\``, so the key binding ends up being `\\`.

## Prettier

```json
Plug 'prettier/vim-prettier', {
  \ 'do': 'npm install --production',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'svelte', 'yaml', 'html'] }
```

I don't like auto-fixable stuff. I like to see the message about smelly stuff, and then fix them myself because that is an opportunity to learn. If it auto-fixes for me, I learn nothing.

Run manually with `:Prettier` or create a key binding:

```json
:nmap <Leader>py <Plug>(Prettier)
:nmap <Leader>\p <Plug>(Prettier)
```

`<Leader>py` is suggested in coc-prettier docs. `<Leader>\p` is `\\p` on my setup, which is quick and easy to type as well.

See [docs here to set autoformat on save](https://github.com/prettier/vim-prettier#configuration):

[GitHub - prettier/vim-prettier: A Vim plugin for Prettier](https://github.com/prettier/vim-prettier#configuration)

Basically add this to `.vimrc` or `~/.config/nvim/init.vim`:

```jsx
let g:prettier#autoformat = 1
let g:prettier#autoformat_require_pragma = 0
```

```jsx
echo g:prettier#config#print_width 
let g:prettier#config#print_width=68
```

## CoC PureScript, purty

```jsx
$ npm install --global purescript-language-server purty
```

Run `:CocConfig` or `CocLocalConfig` and add:

```jsx
{
  "coc.preferences.formatOnSaveFiletypes": [
    "purescript"
  ],
  "languageserver": {
    "purescript": {
      "command": "purescript-language-server",
      "args": ["--stdio"],
      "filetypes": ["purescript"],
      "trace.server": "off",
      "rootPatterns": ["bower.json", "psc-package.json", "spago.dhall"],
      "settings": {
        "purescript": {
          "addSpagoSources": true,

					//
					// Set to true if using a local purty install for formatting.
					//
          "addNpmPath": false
          // etc.
        }
      }
    }
  }
}
```
