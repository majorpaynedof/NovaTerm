# NovaTerm

> A MobaXterm replacement for Linux — built with GTK3, VTE, and Paramiko.

**Author:** Joseph Martin  
**License:** MIT  
**Platform:** Linux (all major distributions)

---

## Overview

NovaTerm is a native Linux SSH and RDP terminal manager inspired by MobaXterm. It provides a full-featured tabbed terminal environment with an integrated SFTP file browser, session management, and RDP support — all in a clean dark-themed GTK3 desktop application.

No Wine. No browser. No Electron. Pure native Linux GTK3.

---

## Features

| Feature | Description |
|---|---|
| **SSH Sessions** | Full `xterm-256color` terminal via VTE — vim, tmux, htop all work |
| **SFTP File Browser** | Browse, upload, download, rename, delete, chmod remote files |
| **RDP Sessions** | Connect to Windows/Linux desktops via xfreerdp |
| **Session Manager** | Save sessions in named groups, auto-persisted to disk |
| **Tabbed Interface** | Multiple sessions simultaneously, tabs reorderable |
| **Local Terminals** | Open local bash/zsh shells alongside SSH sessions |
| **Progress Transfers** | Upload/download with live progress bar |
| **Folder Download** | Recursively download folders and their contents over SFTP |
| **Broadcast Command** | Send a command to all open tabs at once |
| **Import / Export** | Share session lists as JSON |
| **Dark Theme** | GitHub-dark colour scheme with JetBrains Mono font |
| **Custom Icon** | Use any photo as the app icon and splash screen image |

---

## Installation

```bash
git clone https://github.com/majorpaynedof/Novaterm.git
cd novaterm
chmod +x install.sh
./install.sh
novaterm
```

The installer automatically detects your Linux distribution and installs all required dependencies.

---

## Distribution Support

| Distribution | Package Manager | Status |
|---|---|---|
| Ubuntu 20.04+ | apt | ✅ Tested |
| Debian 11+ | apt | ✅ Supported |
| Zorin OS 16+ | apt | ✅ Tested |
| Linux Mint 20+ | apt | ✅ Supported |
| Pop!_OS | apt | ✅ Supported |
| Elementary OS 6+ | apt | ✅ Supported |
| Kali / Parrot | apt | ✅ Supported |
| Fedora 36+ | dnf | ✅ Supported |
| RHEL / Rocky / Alma 8+ | dnf | ✅ Supported |
| Nobara | dnf | ✅ Supported |
| Arch Linux | pacman | ✅ Supported |
| Manjaro | pacman | ✅ Supported |
| EndeavourOS | pacman | ✅ Supported |
| Garuda | pacman | ✅ Supported |
| openSUSE Leap/Tumbleweed | zypper | ✅ Supported |
| Void Linux | xbps | ✅ Supported |
| Alpine Linux | apk | ⚠️ Partial |
| Raspberry Pi OS | apt | ✅ Supported |
| Gentoo | emerge | ⚠️ Manual |

**Minimum requirements:** GTK 3.20+, VTE 0.50+, Python 3.8+, X11 or XWayland

---

## Manual Dependency Install

```bash
# Ubuntu / Debian / Zorin / Mint
sudo apt install python3-gi python3-gi-cairo gir1.2-gtk-3.0 \
    gir1.2-vte-2.91 gir1.2-gdkpixbuf-2.0 openssh-client freerdp2-x11

# Fedora / RHEL / Rocky
sudo dnf install python3-gobject python3-cairo gtk3 vte291 \
    gdk-pixbuf2 freerdp openssh-clients

# Arch / Manjaro
sudo pacman -S python-gobject python-cairo gtk3 vte3 gdk-pixbuf2 freerdp openssh

# openSUSE
sudo zypper install python3-gobject python3-gobject-cairo \
    typelib-1_0-Gtk-3_0 typelib-1_0-Vte-2_91 freerdp openssh

# All distros — Python packages
pip3 install --user paramiko cryptography Pillow
```

---

## Usage

### SSH Session
1. Click **New Session** in the toolbar
2. Enter hostname, port, username, choose SSH key or password auth
3. Click **Save** — connects immediately and saves for next time

### RDP Session
1. Click **New Session**, toggle to **RDP**
2. Enter hostname, username, password, resolution
3. Click **Save**

### SFTP File Browser
- Opens automatically on the right side when SSH connects
- Right-click for context menu: rename, delete, new folder, chmod, copy path
- `F2` rename · `Del` delete · `F5` refresh · `Backspace` go up

### Keyboard Shortcuts
| Key | Action |
|---|---|
| `Ctrl+Shift+C` | Copy from terminal |
| `Ctrl+Shift+V` | Paste to terminal |
| `Ctrl+Page Up/Down` | Switch tabs |
| `F2` | Rename (file browser) |
| `Del` | Delete (file browser) |
| `F5` | Refresh (file browser) |

---

## Session File

Sessions are stored at `~/.config/novaterm/sessions.json`:

```json
{
  "groups": [
    {
      "name": "Production",
      "sessions": [
        {
          "name": "web-server",
          "host": "192.168.1.10",
          "port": 22,
          "user": "ubuntu",
          "auth": "key",
          "key": "~/.ssh/id_rsa",
          "type": "ssh"
        }
      ]
    }
  ]
}
```

---

## Custom Icon

Place `icon.png` or `icon.jpg` in the same folder as `install.sh` before running the installer. The image will be resized to all standard icon sizes and embedded into the splash screen.

---

## Project Structure

```
novaterm/
├── novaterm.py     # Main application (~1800 lines)
├── install.sh      # Universal installer (all distros)
├── icon.png        # App icon (optional — replace with your own)
├── README.md       # Documentation
└── LICENSE         # MIT License
```

---

## Comparison with MobaXterm

| Feature | MobaXterm | NovaTerm |
|---|---|---|
| Platform | Windows only | Linux native |
| SSH sessions | ✅ | ✅ |
| SFTP browser | ✅ | ✅ |
| Tabbed terminals | ✅ | ✅ |
| RDP support | ✅ | ✅ |
| Session groups | ✅ | ✅ |
| Open source | ❌ Proprietary | ✅ MIT |
| Cost | Freemium | Free |
| Native Linux | ❌ Wine only | ✅ |

---

## Roadmap

- [ ] SSH port forwarding manager
- [ ] Macro/snippet runner panel
- [ ] Split terminal panes
- [ ] Built-in remote file editor
- [ ] MobaXterm session importer
- [ ] Theme customisation

---

## Uninstall

```bash
rm -f ~/.local/bin/novaterm
rm -rf ~/.local/share/novaterm
rm -f ~/.local/share/applications/novaterm.desktop
rm -rf ~/.local/share/icons/hicolor/*/apps/novaterm.*
rm -rf ~/.config/novaterm   # also removes saved sessions
```

---

## License

MIT License — Copyright (c) 2026 Joseph Martin

---

## In Memoriam

NovaTerm is named for **Nova** — CH PR Mikka Supernova, an Alaskan Klee Kai — a loyal companion who watched over every line of this project.
Forever a good girl. Run free. 🐾
