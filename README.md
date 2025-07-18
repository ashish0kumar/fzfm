<h1 align="center">fzfm</h1>

<p align="center">fuzzy finder file manager</p>

<div align="center">

  ![demo](assets/demo2.gif)
  
</div>

---

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

2. Optionally, move it to a directory in your `$PATH`:
   ```bash
   mv fzfm ~/.local/bin/fzfm
   ```

## Usage

Run the script:

```bash
./fzfm  # or just `fzfm` if added to PATH
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

## Contributions

Feel free to fork the repository, submit issues, or contribute improvements!

<br>

<p align="center">
	<img src="https://raw.githubusercontent.com/catppuccin/catppuccin/main/assets/footers/gray0_ctp_on_line.svg?sanitize=true" />
</p>

<p align="center">
        <i><code>&copy 2025-present <a href="https://github.com/ashish0kumar">Ashish Kumar</a></code></i>
</p>

<div align="center">
<a href="https://github.com/ashish0kumar/fzfm/blob/main/LICENSE"><img src="https://img.shields.io/github/license/ashish0kumar/fzfm?style=for-the-badge&color=CBA6F7&logoColor=cdd6f4&labelColor=302D41" alt="LICENSE"></a>&nbsp;&nbsp;
</div>
