## Set Color in Vim

```bash
colorscheme THEME_NAME
```

The theme can be cloned into the `bundle` folder of vim config folder.

### Color of airline in Vim

Add or change the following line in .vimrc

```bash
let g:airline_theme='THEME_NAME'
```

## Share the same color scheme in tmux

The [tmuxline](https://github.com/edkolev/tmuxline.vim) vim plugin set the tmux info bar with the same theme scheme
which is currently being used in vim after run:

```bash
Tmuxline
```


A config file for tmux info bar theme can be generated and further used in tmux conf after run

```bash
TmuxlinePreview FILE_NAME
```

The following parameter should be set if custom theme is set to the tmux line to avoid that vim overwrites the theme
during start

```bash
let g:airline#extensions#tmuxline#enabled = 0
```
