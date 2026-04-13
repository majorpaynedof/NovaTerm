#!/bin/bash
# NovaTerm Installer — runs on Ubuntu/Debian, Fedora/RHEL, Arch Linux
set -e

INSTALL_DIR="$HOME/.local/share/novaterm"
BIN_DIR="$HOME/.local/bin"
DESKTOP_DIR="$HOME/.local/share/applications"
ICON_DIR="$HOME/.local/share/icons/hicolor/128x128/apps"

RED='\033[0;31m'; GREEN='\033[0;32m'; YELLOW='\033[1;33m'; BLUE='\033[0;34m'; NC='\033[0m'

info()    { echo -e "${BLUE}[*]${NC} $1"; }
success() { echo -e "${GREEN}[✓]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
error()   { echo -e "${RED}[✗]${NC} $1"; exit 1; }

echo ""
echo -e "${BLUE}╔══════════════════════════════════╗${NC}"
echo -e "${BLUE}║     NovaTerm Installer v1.0      ║${NC}"
echo -e "${BLUE}║  MobaXterm replacement for Linux  ║${NC}"
echo -e "${BLUE}╚══════════════════════════════════╝${NC}"
echo ""

# ── Detect distro ────────────────────────────────────────────────────────────
detect_distro() {
    if [ -f /etc/os-release ]; then
        . /etc/os-release
        echo "$ID"
    elif command -v lsb_release &>/dev/null; then
        lsb_release -is | tr '[:upper:]' '[:lower:]'
    else
        echo "unknown"
    fi
}

DISTRO=$(detect_distro)
info "Detected distro: $DISTRO"

# ── Install system dependencies ───────────────────────────────────────────────
install_deps() {
    info "Installing system dependencies…"
    case "$DISTRO" in
        ubuntu|debian|linuxmint|pop)
            sudo apt-get update -q
            sudo apt-get install -y -q \
                python3 python3-pip python3-gi python3-gi-cairo \
                gir1.2-gtk-3.0 gir1.2-vte-2.91 \
                fonts-jetbrains-mono || \
            sudo apt-get install -y -q \
                python3 python3-pip python3-gi python3-gi-cairo \
                gir1.2-gtk-3.0 gir1.2-vte-2.91
            ;;
        fedora)
            sudo dnf install -y \
                python3 python3-pip python3-gobject python3-cairo \
                gtk3 vte291 vte291-devel \
                jetbrains-mono-fonts 2>/dev/null || \
            sudo dnf install -y \
                python3 python3-pip python3-gobject python3-cairo \
                gtk3 vte291
            ;;
        rhel|centos|rocky|almalinux)
            sudo dnf install -y epel-release
            sudo dnf install -y python3 python3-pip python3-gobject gtk3 vte291
            ;;
        arch|manjaro|endeavouros)
            sudo pacman -Sy --noconfirm \
                python python-pip python-gobject python-cairo \
                gtk3 vte3 ttf-jetbrains-mono
            ;;
        opensuse*|sles)
            sudo zypper install -y \
                python3 python3-pip python3-gobject-cairo \
                typelib-1_0-Gtk-3_0 typelib-1_0-Vte-2_91
            ;;
        *)
            warn "Unknown distro '$DISTRO'. Trying apt-get…"
            sudo apt-get install -y python3 python3-pip python3-gi \
                gir1.2-gtk-3.0 gir1.2-vte-2.91 2>/dev/null || \
            error "Please install GTK3, VTE 2.91, and Python3 GObject bindings manually."
            ;;
    esac
    success "System dependencies installed"
}

install_deps

# ── Install Python packages ───────────────────────────────────────────────────
info "Installing Python packages…"
pip3 install --user paramiko cryptography 2>/dev/null || \
    pip3 install --user --break-system-packages paramiko cryptography
success "Python packages installed (paramiko, cryptography)"

# ── Copy application files ────────────────────────────────────────────────────
info "Installing NovaTerm to $INSTALL_DIR…"
mkdir -p "$INSTALL_DIR" "$BIN_DIR" "$DESKTOP_DIR" "$ICON_DIR"

# Copy main script
cp "$(dirname "$0")/novaterm.py" "$INSTALL_DIR/novaterm.py"
chmod +x "$INSTALL_DIR/novaterm.py"

# Create launcher
cat > "$BIN_DIR/novaterm" <<'EOF'
#!/bin/bash
exec python3 "$HOME/.local/share/novaterm/novaterm.py" "$@"
EOF
chmod +x "$BIN_DIR/novaterm"
success "Launcher created at $BIN_DIR/novaterm"

# ── Desktop entry ─────────────────────────────────────────────────────────────
cat > "$DESKTOP_DIR/novaterm.desktop" <<EOF
[Desktop Entry]
Version=1.0
Type=Application
Name=NovaTerm
Comment=SSH & Terminal Manager for Linux
Exec=$BIN_DIR/novaterm
Icon=novaterm
Terminal=false
Categories=Network;RemoteAccess;System;TerminalEmulator;
Keywords=ssh;terminal;sftp;remote;server;
StartupNotify=true
StartupWMClass=novaterm
EOF

# Create a simple SVG icon
cat > "$ICON_DIR/novaterm.svg" <<'SVGEOF'
<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 128 128">
  <rect width="128" height="128" rx="22" fill="#0d1117"/>
  <rect x="12" y="12" width="104" height="72" rx="6" fill="#161b22" stroke="#30363d" stroke-width="1.5"/>
  <rect x="12" y="12" width="104" height="18" rx="6" fill="#21262d"/>
  <circle cx="26" cy="21" r="4" fill="#f85149"/>
  <circle cx="40" cy="21" r="4" fill="#d29922"/>
  <circle cx="54" cy="21" r="4" fill="#3fb950"/>
  <text x="22" y="50" font-family="monospace" font-size="11" fill="#3fb950">root@server:~$</text>
  <text x="22" y="65" font-family="monospace" font-size="10" fill="#8b949e">systemctl status nginx</text>
  <rect x="22" y="68" width="8" height="13" rx="1" fill="#58a6ff" opacity="0.9"/>
  <rect x="16" y="90" width="96" height="26" rx="4" fill="#1f3a5a" stroke="#58a6ff" stroke-width="1"/>
  <text x="24" y="108" font-family="monospace" font-size="10" fill="#58a6ff">NovaTerm</text>
</svg>
SVGEOF

gtk-update-icon-cache -f -t "$HOME/.local/share/icons/hicolor" 2>/dev/null || true
update-desktop-database "$DESKTOP_DIR" 2>/dev/null || true
success "Desktop entry created"

# ── PATH check ────────────────────────────────────────────────────────────────
if [[ ":$PATH:" != *":$BIN_DIR:"* ]]; then
    warn "$BIN_DIR is not in your PATH."
    echo "    Add this to your ~/.bashrc or ~/.zshrc:"
    echo ""
    echo -e "    ${YELLOW}export PATH=\"\$HOME/.local/bin:\$PATH\"${NC}"
    echo ""
fi

# ── Done ──────────────────────────────────────────────────────────────────────
echo ""
echo -e "${GREEN}╔══════════════════════════════════╗${NC}"
echo -e "${GREEN}║   NovaTerm installed! 🎉          ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════╝${NC}"
echo ""
echo "  Run from terminal:   novaterm"
echo "  Or find it in your application menu as 'NovaTerm'"
echo ""
echo "  Sessions are saved to: ~/.config/novaterm/sessions.json"
echo ""
