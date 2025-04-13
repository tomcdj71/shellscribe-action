# Shellscribe GitHub Action

[![GitHub Marketplace](https://img.shields.io/badge/Marketplace-Shellscribe-blue.svg?colorA=24292e&colorB=0366d6&style=flat&longCache=true&logo=github)](https://github.com/marketplace/actions/shellscribe-documentation-generator)

> **Transform your bash scripts into professional documentation, effortlessly.** Shellscribe intelligently extracts formatted comments from your shell scripts and generates structured, elegant, and comprehensive documentation in Markdown. Integrate it into your GitHub workflow to automatically maintain up-to-date documentation, perfectly synchronized with your code.

## 🌟 Features

- **Automatic Documentation** - Generates professional Markdown files from your comments
- **Intelligent Extraction** - Captures metadata, functions, arguments, examples, and exit codes
- **Highly Customizable** - Configure via YAML or dedicated `.scribeconf` file
- **CI/CD Integration** - Seamlessly integrates into your GitHub workflows
- **Easy Maintenance** - Keep your documentation synchronized with your code

## 📋 Usage

### Basic Example

Add this to your GitHub workflow file (e.g., `.github/workflows/documentation.yml`):

```yaml
name: Generate Shell Script Documentation

on:
  push:
    branches: [ main ]
  pull_request:
    branches: [ main ]

jobs:
  document:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      
      - name: Generate Shell Documentation
        uses: tomcdj71/shellscribe-action@v1
        with:
          source_path: './scripts'
          doc_path: './docs'
```

## ⚙️ Configuration Options

Shellscribe-action offers great flexibility in configuration. You can specify options directly in the workflow or use a `.scribeconf` file.

### Workflow Configuration

| Option | Description | Possible Values | Default |
|--------|-------------|-----------------|---------|
| `source_path` | Path to shell scripts to document | Relative or absolute path | `./` |
| `doc_path` | Destination folder for generated files | Relative or absolute path | `./docs` |
| `doc_filename` | Base name of the generated file | String without extension | `shell_doc` |
| `format` | Output format for documentation | `markdown` | `markdown` |
| `generate_index` | Creates an index file for multiple scripts | `true`, `false` | `false` |
| `log_level` | Log detail level | `normal`, `verbose` | `normal` |
| `show_toc` | Displays a table of contents | `true`, `false` | `false` |
| `show_alerts` | Displays alert blocks | `true`, `false` | `false` |
| `show_shellcheck` | Displays shellcheck directives | `true`, `false` | `false` |
| `shellcheck_display` | Presentation style for shellcheck results | `table`, `sequential` | `sequential` |
| `highlight_code` | Enables syntax highlighting | `true`, `false` | `true` |
| `highlight_language` | Language for syntax highlighting of examples | `bash` or other supported language | `bash` |
| `example_display` | Presentation style for examples | `tabs`, `sequential` | `sequential` |
| `arguments_display` | Presentation style for arguments | `table`, `sequential` | `sequential` |
| `traverse_symlinks` | Follows symbolic links when processing directories | `true`, `false` | `true` |
| `linkify_usernames` | Converts GitHub usernames to links | `true`, `false` | `false` |
| `version_placement` | Display location for version | `about`, `filename` | `about` |
| `copyright_placement` | Display location for copyright | `about`, `footer` | `about` |
| `license_placement` | Display location for license | `about`, `footer` | `about` |
| `configuration_file` | Path to custom configuration file | Relative or absolute path | `` |

### Option Details

#### `source_path`
Defines the path to your shell scripts to document. Can be a single file or a directory containing multiple scripts. If a directory is specified, all `.sh` scripts will be processed.

#### `doc_path`
Specifies the folder where documentation files will be generated. The directory will be created if it doesn't exist.

#### `doc_filename`
Defines the base name used for the generated documentation file. The extension will be added automatically according to the chosen format.

#### `format`
Specifies the output format of the documentation. Currently, only `markdown` is supported.

#### `generate_index`
When set to `true`, generates an index file that lists all documented scripts with links to their respective pages.

#### `log_level`
Controls the level of detail in logs generated during the documentation process. Use `verbose` for debugging.

#### `show_toc`
Adds a table of contents at the top of each documentation file to facilitate navigation.

#### `show_alerts`
Displays important information in stylized alert blocks for better visibility.

#### `show_shellcheck`
Includes shellcheck directives found in the code in the generated documentation.

#### `shellcheck_display`
Defines how shellcheck directives are displayed. `table` presents them in a compact table, `sequential` lists them one by one.

#### `highlight_code`
Enables or disables syntax highlighting for code blocks in the documentation.

#### `highlight_language`
Specifies the language used for syntax highlighting of code examples. Default is `bash`.

#### `example_display`
Determines how examples are presented in the documentation. `tabs` organizes them in interactive tabs, `sequential` lists them one after another.

#### `arguments_display`
Defines how function arguments are presented. `table` displays them in a structured table, `sequential` lists them individually.

#### `traverse_symlinks`
Controls whether symbolic links are followed when traversing directories. Useful for projects with a complex structure.

#### `linkify_usernames`
Automatically converts GitHub mentions (@username) to links to the corresponding profiles.

#### `version_placement`, `copyright_placement`, `license_placement`
Define where this information appears in the documentation: either in the "About" section at the top, or in the footer.

#### `configuration_file`
Allows you to specify a path to a custom `.scribeconf` file that contains all configuration options. Useful for maintaining a consistent configuration.

## 🔄 Using a Configuration File

For a cleaner and reusable configuration, you can create a `.scribeconf` file in your repository:

```
doc_path = ./docs
doc_filename = shell_documentation
format = markdown
generate_index = true
show_toc = true
show_alerts = true
example_display = tabs
arguments_display = table
```

Then reference this file in your workflow:

```yaml
- name: Generate Shell Documentation
  uses: tomcdj71/shellscribe-action@v1
  with:
    source_path: './scripts'
    configuration_file: './.scribeconf'
```

## 📝 Documentation Format

For Shellscribe to generate complete documentation, your scripts must follow a specific comment format. Here's an example:

```bash
#!/usr/bin/env bash
# @file modules/example.sh
# @description Utilities for package management
# @author John Doe (johndoe)
# @version 1.0.0

# @function install_package
# @brief Installs a package with apt
# @arg $1 string Name of the package to install
# @exitcode 0 Installation successful
# @exitcode 1 Installation failed
install_package() {
    # Implementation
}
```

For more details on the documentation syntax, see the [Shellscribe documentation](https://github.com/tomcdj71/Shellscribe/blob/main/docs/annotations_list.md).


## 📄 License

This project is licensed under the Apache 2.0 Clause - see the [LICENSE](LICENSE) file for details.

---

© tomcdj71 2025

