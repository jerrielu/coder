# coder

`coder` is a standalone, zero-dependency Bash CLI for storing and activating environment-variable profiles for coding tools.

It is designed to be:

- Pure Bash
- Self-installing
- Cross-platform across macOS and Linux
- Simple to read and modify
- Safe to use without external packages

## Quick Start

One-line install from GitHub:

```bash
curl -fsSL https://raw.githubusercontent.com/jerrielu/coder/main/install.sh | bash
```

Alternative (clone then install):

```bash
git clone https://github.com/jerrielu/coder.git
cd coder
./install.sh
```

Then run:

```bash
coder
```

## Local Script Setup

1. Make the script executable:

```bash
chmod +x ./coder
```

2. Run it once from the repo:

```bash
./coder
```

3. The first run self-installs the command to:

```bash
~/.local/bin/coder
```

4. On install, `coder` also appends `~/.local/bin` to common shell startup files if it is missing:

- `~/.profile`
- `~/.bash_profile`
- `~/.bashrc`
- `~/.zprofile`
- `~/.zshrc`

5. Reload your shell config or open a new shell. For the current shell, you can run:

```bash
export PATH="$HOME/.local/bin:$PATH"
```

6. Launch the global command:

```bash
coder
```

## Current-Shell Activation

Environment variables can only be exported into the current shell if the shell evaluates generated export commands.

Use:

```bash
eval "$(coder --emit-activate PROFILE_NAME)"
```

Optional shell integration can be installed with:

```bash
coder --install-shell-hook
```

Then reload your shell:

```bash
source ~/.bashrc
```

For zsh, the hook is written to `~/.zshrc` when run from zsh.

## Interactive Dashboard

The first screen is an activation dashboard:

- `↑` / `↓`: move profile selection
- `←` / `→`: switch profile pages
- `Enter`: activate selected profile
- `A`: add profile
- `U`: update selected profile
- `D`: delete selected profile
- `M`: open manage tools menu
- `Q`: exit

## Supported Profile Types

### Predefined Tools

These use the requested industry-standard environment variables.

- Cloud Code
  - `CLOUD_CODE_API_KEY`
  - `CLOUD_CODE_ENDPOINT`
- OpenAI Codex / OpenAI API
  - `OPENAI_API_KEY`
  - `OPENAI_BASE_URL`
- Gemini
  - `GOOGLE_API_KEY`
  - `GOOGLE_API_URL`
- Open Code
  - `OPEN_CODE_API_KEY`
  - `OPEN_CODE_URL`

### Custom Tools

Custom profiles accept any valid environment-variable names and values.

## Storage Design

Configuration is stored under:

```text
~/.coder/
```

Profile files are stored at:

```text
~/.coder/profiles/[name].profile
```

Format:

```text
tool=TYPE
env_KEY=VALUE
metadata=NOTES
```

The last selected active profile name is stored in:

```text
~/.coder/active_profile
```

## Design Notes

`coder` uses a single-file architecture so installation, inspection, and editing stay simple.

Key design choices:

- Self-install copies the script to `~/.local/bin/coder` on first run.
- Install also persists `~/.local/bin` in common Bash and zsh startup files when missing.
- Profiles are plain-text files for easy portability and manual recovery.
- Predefined tool profiles reduce key-name mistakes.
- Custom profiles support arbitrary environment variables.
- Activation is implemented with emitted `export` statements because a child process cannot directly modify the parent shell.
- A shell hook is optional rather than mandatory, which keeps the default installation lightweight.

## User Guide

### Add a profile

Run `coder`, press `A`, then:

- Select a tool using arrow keys + `Enter` (no free-text tool entry)
- Enter profile name
- Enter metadata
- Enter environment variable values for that tool

### List profiles

Press `M`, then choose `List Profiles` to inspect all profiles, metadata, and environment-variable values.

### Update a profile

Use `↑` / `↓` to select a profile on the dashboard, press `U`, confirm twice, and re-enter tool/profile values.

### Delete a profile

Use `↑` / `↓` to select a profile on the dashboard, press `D`, and confirm deletion twice.

### Activate a profile

Use `↑` / `↓` to select a profile and press `Enter`, then run the printed `eval` command if needed:

```bash
eval "$(coder --emit-activate PROFILE_NAME)"
```

### Help

```bash
coder --help
```

## Example Profile

```text
tool=OPENAI
env_OPENAI_API_KEY=sk-example
env_OPENAI_BASE_URL=https://api.openai.com/v1
metadata=Personal OpenAI profile
```
