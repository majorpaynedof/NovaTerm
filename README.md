# NovaTerm 🖥️

A **MobaXterm replacement for Linux** — native GTK3 desktop app with real SSH terminal emulation, SFTP file browser, tabbed sessions, and session management.

## Features

| Feature | Description |
|---|---|
| **SSH Terminals** | Full xterm-256color terminal via VTE — works with vim, tmux, htop, etc. |
| **Session Manager** | Save/edit/delete SSH sessions, organized in groups, persisted to `~/.config/novaterm/sessions.json` |
| **SFTP File Browser** | Browse remote files, upload, and download — docked beside each terminal |
| **Tabbed Interface** | Multiple sessions open simultaneously, tabs reorderable by drag |
| **Local Terminals** | Open local bash/zsh shells in tabs too |
| **Broadcast Command** | Send a command to all open tabs at once |
| **Import / Export** | Share session lists as JSON |
| **Dark Theme** | GitHub-dark colour scheme with JetBrains Mono font |
| **Auth Methods** | SSH key (agent or file), password |

## Requirements

| Package | Purpose |
|---|---|
| Python 3.8+ | Runtime |
| PyGObject (python3-gi) | GTK bindings |
| GTK 3.0 | UI toolkit |
| VTE 2.91 | Terminal emulator widget |
| Paramiko | SSH client + SFTP |

## Installation

```bash
# Clone or download, then:
chmod +x install.sh
./install.sh

# Run:
novaterm
```

The installer supports **Ubuntu/Debian, Fedora, Arch Linux, openSUSE** and auto-installs all dependencies.

## Manual Install (any distro)

```bash
# Ubuntu / Debian
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 gir1.2-vte-2.91
pip3 install --user paramiko

# Fedora
sudo dnf install python3-gobject gtk3 vte291
pip3 install --user paramiko

# Arch
sudo pacman -S python-gobject gtk3 vte3
pip3 install --user paramiko

# Run directly
python3 novaterm.py
```

## Session File Format

Sessions are stored at `~/.config/novaterm/sessions.json`:

```json
{
  "groups": [
    {
      "name": "Production",
      "sessions": [
        {
          "name": "web-prod-01",
          "host": "192.168.1.10",
          "port": 22,
          "user": "ubuntu",
          "auth": "key",
          "key": "~/.ssh/id_rsa",
          "group": "Production"
        }
      ]
    }
  ]
}
```

## Keyboard Shortcuts

| Shortcut | Action |
|---|---|
| `Ctrl+Shift+C` | Copy |
| `Ctrl+Shift+V` | Paste |
| `Ctrl+Shift+T` | New tab (via menu) |
| `Ctrl+Page Up/Down` | Switch tabs |
| `Ctrl++` / `Ctrl+-` | Font size (via menu) |

## Comparison with MobaXterm

| Feature | MobaXterm | NovaTerm |
|---|---|---|
| Platform | Windows only | Linux native |
| SSH sessions | ✅ | ✅ |
| SFTP browser | ✅ | ✅ |
| Tabbed terminals | ✅ | ✅ |
| Local terminal | ✅ | ✅ |
| Session groups | ✅ | ✅ |
| Open source | ❌ (proprietary) | ✅ MIT |
| X11 forwarding | ✅ | Via SSH -X flag |
| Macros/scripting | ✅ | Planned |
| Port forwarding UI | ✅ | Planned |

## Roadmap

- [ ] SSH port forwarding manager (local / remote / dynamic tunnels)  
- [ ] X11 forwarding toggle  
- [ ] Session colour coding / tagging  
- [ ] Multi-pane split view  
- [ ] Built-in text editor for remote files  
- [ ] Session activity notifications  
- [ ] MobaXterm session importer  

## License

MIT
