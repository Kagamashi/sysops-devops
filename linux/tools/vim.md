
### Switch Between Modes:
- `i`: Enter **insert mode** (to edit text).
- `Esc`: Return to **command mode** (to execute commands).

### Basic Commands:
- `o`: Open a new line below the current position and enter insert mode.
- `O`: Open a new line above the current position and enter insert mode.
- `:wq`: Save changes and quit.
- `:q!`: Quit without saving changes.
- `:w!`: Force save.
- `u`: Undo the last change.
- `Ctrl + r`: Redo the last undone change.
- `gg`: Go to the beginning of the file.
- `G`: Go to the last line of the file.
- `dd`: Delete the current line.
- `x`: Delete the current character.
- `d$`: Delete from the current cursor position to the end of the line.


### Find Text:
- `:/texttosearch`: Search for "texttosearch" in the file.
- `n`: Jump to the next occurrence.
- `N`: Jump to the previous occurrence.
- `:300`: Jump to line 300.


### Replace Text:
- `:%s/one/ONE/g`: Replace all occurrences of "one" with "ONE".
- `:%s/one/ONE`: Replace the first occurrence of "one" on each line with "ONE".


### Cut/Copy/Paste:
- `v`: Start visual selection mode.
- `y`: Copy (yank) the selected text.
- `p`: Paste the copied text.
- `d`: Delete the selected text (cuts it).
