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

## Supported Profile Types

### Predefined Tools

These use the requested industry-standard environment variables.

- Claude Code
- OpenAI Codex

### Custom Tools

Custom profiles accept any valid environment-variable names and values.
When creating or updating a custom profile, `coder` also asks for a required tool binary to launch.

## Storage Design

Configuration is stored under:

```text
~/.coder/
```


### Help

```bash
coder --help
```

### Version

```bash
coder --version
```
