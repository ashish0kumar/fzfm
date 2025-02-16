# fzfm

**fzfm** is a **minimal and fast terminal-based file manager** powered by `fzf`,
written in **Bash**. It showcases how **powerful** `fzf` can be, demonstrating
its potential beyond simple fuzzy finding. It allows you to **navigate
directories**, **preview files and directories**, and **open them** using your
preferred applications directly from the **command line**.

![demo](assets/demo2.gif)

## Features

- **Navigate directories** seamlessly using only your keyboard
- **Blazing-fast fuzzy search** powered by `fzf`
- **File preview** using `bat` (fallback to `cat`)
- **Directory preview** using `eza` (fallback to `ls`)
- **Customizable multimedia file opener** (`wslview`, `xdg-open`, etc.)
- **Fully configurable** via environment variables

## Dependencies

Ensure you have the following installed:

- [`fzf`](https://github.com/junegunn/fzf) - Core dependency, the entire file
  manager is built around it
- [`eza`](https://github.com/eza-community/eza) - For enhanced directory listing
  (fallback to `ls`)
- [`bat`](https://github.com/sharkdp/bat) - For file previewing (fallback to
  `cat`)
- [`nvim`](https://github.com/neovim/neovim) - For text editing (fallback to
  `nano`)
- A media opener like `wslview`, `xdg-open`, or `open`
- [Nerd Fonts](https://www.nerdfonts.com/) - For proper icon rendering in the
  terminal

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/ashish0kumar/fzfm.git
   cd fzfm
   ```
2. Make the script executable:
   ```bash
   chmod +x fzfm.sh
   ```
3. Optionally, move it to a directory in your `$PATH`:
   ```bash
   mv fzfm.sh ~/.local/bin/fzfm
   ```

## Usage

Run the script:

```bash
./fzfm.sh  # or just `fzfm` if added to PATH
```

### Key Bindings

| **Key**               | **Action**             |
| --------------------- | ---------------------- |
| `Up/Down Arrow`       | Move selection up/down |
| `Enter / Right Arrow` | Open file/folder       |
| `Shift + Up/Down`     | Scroll preview         |
| `Ctrl + R`            | Refresh file list      |

### Environment Variables

Customize behavior according to your system by setting the following:

```bash
export FZFM_MEDIA_OPENER="xdg-open"  # Set preferred media opener
export FZFM_TEXT_EDITOR="nvim"       # Set preferred text editor
export FZFM_LIST_COMMAND="eza"       # Set directory listing command
export FZFM_PREVIEW_COMMAND="bat"    # Set preview command
```

## License

This project is open-source and licensed under the MIT License.

## Contributions

Feel free to fork the repository, submit issues, or contribute improvements!
