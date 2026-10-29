# 🎥 VHS Tape Generator

A shell utility designed to automate the generation of Charm [VHS](https://github.com/charmbracelet/vhs) `.tape` scenario files and export animated GIF demonstrations for CLI tools.

Part of the **[Dev-Tools](https://github.com/JTissDev/dev-tools)** ecosystem.

---

## 🚀 Features

- **Automated `.tape` Generation**: Generates clean, ready-to-render VHS scenario files with pre-configured styles and themes.
- **Interactive Argument Injection**: Seamlessly passes custom keystrokes, responses, and menu choices to simulate user interaction.
- **Centralized Output Management**: Stores `.tape` source files in a central directory (`~/dev-tools/demo-tape`) while outputting generated `.gif` assets directly to your desired target folder.
- **Pre-Configured Aesthetics**: Built-in defaults using the *Monokai Pro* theme, optimal font size, and natural typing delays.

---

## 📋 Prerequisites

Before using this script, ensure you have installed:
1. **[VHS by Charm](https://github.com/charmbracelet/vhs)**:
   ```bash
   # via ttyd / ffmpeg dependency requirements
   winget install Charmbracelet.VHS
   ```
2. **Git Bash** (or any Unix-like shell environment).

---

## 📂 Installation & Integration

### As a standalone script or within `dev-tools`

This repository is maintained as a submodule inside the `dev-tools` environment.

1. Clone or load inside `dev-tools`:
   ```bash
   git submodule add https://github.com/JTissDev/vhs-tape-generator.git vhs-tape-generator
   ```

2. Add a convenient alias in your `~/.bash_aliases`:
   ```bash
   alias vhs-gen="bash ~/dev-tools/vhs-tape-generator/tape-generator.sh"
   ```

3. Reload your environment:
   ```bash
   source ~/.bashrc
   ```

---

## 🛠️ Usage

```bash
vhs-gen -p <project_directory> -c <command_to_run> [-o <output_gif_dir>] [response_1 response_2 ...]
```

### Options

| Option | Long Flag | Description | Mandatory | Default |
| :--- | :--- | :--- | :---: | :--- |
| `-p` | `--project` | Target working directory where the CLI tool should run. | **Yes** | — |
| `-c` | `--command` | Main CLI command or script name to execute. | **Yes** | — |
| `-o` | `--output` | Destination directory for the generated `.gif` file. | No | `.` (Current directory) |
| `*` | *Positional* | Additional responses/keystrokes sent sequentially to the command. | No | `()` |

---

## 💡 Example

To generate a GIF demonstration for the `sitemap_manager` tool with interactive inputs (`n`, `n`, `o`, `o`):

```bash
vhs-gen -p /c/Users/Jtiss/dev-tools/sitemap_manager \
        -c sitemap_manager \
        -o ./assets \
        n n o o
```

### Generated Artifacts
1. **Scenario file**: `~/dev-tools/demo-tape/sitemap_manager-demo.tape`
2. **Animated GIF**: `./assets/sitemap_manager-demo.gif`

---

## 📄 License

Distributed under the MIT License. See `LICENSE` for more information.