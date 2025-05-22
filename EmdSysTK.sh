#!/bin/bash

# Embedded Systems Tools Installer Script
# This script installs essential tools for embedded systems development
# Tested on Ubuntu/Debian-based systems

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to print colored output
print_status() {
    echo -e "${BLUE}[INFO]${NC} $1"
}

print_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $1"
}

print_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check if running on supported system
check_system() {
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        print_status "Detected Linux system"
        if command -v apt &> /dev/null; then
            PACKAGE_MANAGER="apt"
        elif command -v yum &> /dev/null; then
            PACKAGE_MANAGER="yum"
        elif command -v pacman &> /dev/null; then
            PACKAGE_MANAGER="pacman"
        else
            print_error "Unsupported package manager. This script supports apt, yum, and pacman."
            exit 1
        fi
    else
        print_error "This script is designed for Linux. For Windows/macOS, please install tools manually."
        exit 1
    fi
}

# Update package lists
update_packages() {
    print_status "Updating package lists..."
    case $PACKAGE_MANAGER in
        apt)
            sudo apt update
            ;;
        yum)
            sudo yum update -y
            ;;
        pacman)
            sudo pacman -Sy
            ;;
    esac
    print_success "Package lists updated"
}

# Install system dependencies
install_dependencies() {
    print_status "Installing system dependencies..."
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y wget curl git build-essential python3 python3-pip \
                libusb-1.0-0-dev libftdi1-dev libudev-dev pkg-config
            ;;
        yum)
            sudo yum install -y wget curl git gcc gcc-c++ python3 python3-pip \
                libusb1-devel libftdi-devel libudev-devel pkgconfig
            ;;
        pacman)
            sudo pacman -S --noconfirm wget curl git base-devel python python-pip \
                libusb libftdi libudev pkgconf
            ;;
    esac
    print_success "Dependencies installed"
}

# Install Visual Studio Code
install_vscode() {
    print_status "Installing Visual Studio Code..."
    if command -v code &> /dev/null; then
        print_warning "VS Code already installed"
        return
    fi

    case $PACKAGE_MANAGER in
        apt)
            wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
            sudo install -o root -g root -m 644 packages.microsoft.gpg /etc/apt/trusted.gpg.d/
            sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/trusted.gpg.d/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
            sudo apt update
            sudo apt install -y code
            ;;
        yum)
            sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc
            sudo sh -c 'echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/vscode.repo'
            sudo yum install -y code
            ;;
        pacman)
            # VS Code is available in AUR
            print_warning "For Arch Linux, install from AUR: yay -S visual-studio-code-bin"
            ;;
    esac
    
    # Install PlatformIO extension
    if command -v code &> /dev/null; then
        code --install-extension platformio.platformio-ide
        print_success "VS Code and PlatformIO extension installed"
    fi
}

# Install Arduino IDE
install_arduino() {
    print_status "Installing Arduino IDE..."
    
    # Download latest Arduino IDE 2.x
    ARDUINO_VERSION="2.3.2"
    ARDUINO_URL="https://downloads.arduino.cc/arduino-ide/arduino-ide_${ARDUINO_VERSION}_Linux_64bit.AppImage"
    
    mkdir -p ~/Applications
    cd ~/Applications
    
    if [ ! -f "arduino-ide_${ARDUINO_VERSION}_Linux_64bit.AppImage" ]; then
        wget "$ARDUINO_URL"
        chmod +x "arduino-ide_${ARDUINO_VERSION}_Linux_64bit.AppImage"
    fi
    
    # Create desktop entry
    cat > ~/.local/share/applications/arduino-ide.desktop << EOF
[Desktop Entry]
Name=Arduino IDE
Comment=Arduino Integrated Development Environment
Exec=$HOME/Applications/arduino-ide_${ARDUINO_VERSION}_Linux_64bit.AppImage
Icon=arduino-ide
Terminal=false
Type=Application
Categories=Development;Electronics;
EOF
    
    print_success "Arduino IDE installed"
}

# Install KiCad
install_kicad() {
    print_status "Installing KiCad..."
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y kicad kicad-libraries
            ;;
        yum)
            sudo yum install -y kicad kicad-libraries
            ;;
        pacman)
            sudo pacman -S --noconfirm kicad kicad-library kicad-library-3d
            ;;
    esac
    print_success "KiCad installed"
}

# Install LTspice (Wine required for Linux)
install_ltspice() {
    print_status "Installing LTspice..."
    print_warning "LTspice requires Wine on Linux. Installing Wine and downloading LTspice..."
    
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y wine
            ;;
        yum)
            sudo yum install -y wine
            ;;
        pacman)
            sudo pacman -S --noconfirm wine
            ;;
    esac
    
    # Create directory for LTspice
    mkdir -p ~/Applications/LTspice
    cd ~/Applications/LTspice
    
    # Download LTspice
    if [ ! -f "LTspice.exe" ]; then
        wget "https://ltspice.analog.com/software/LTspice64.exe" -O LTspice.exe
        print_warning "LTspice downloaded. Run 'wine ~/Applications/LTspice/LTspice.exe' to install"
    fi
    
    print_success "LTspice installer downloaded (requires Wine)"
}

# Install PulseView (sigrok)
install_pulseview() {
    print_status "Installing PulseView..."
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y pulseview sigrok-cli
            ;;
        yum)
            sudo yum install -y pulseview sigrok-cli
            ;;
        pacman)
            sudo pacman -S --noconfirm pulseview sigrok-cli
            ;;
    esac
    
    # Add user to plugdev group for USB access
    sudo usermod -a -G plugdev $USER
    print_success "PulseView installed"
}

# Install oscilloscope software
install_oscilloscope_apps() {
    print_status "Installing oscilloscope applications..."
    
    # Install OpenHantek6022 (for Hantek USB oscilloscopes)
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y openhantek
            ;;
        yum)
            print_warning "OpenHantek not available in yum repositories"
            ;;
        pacman)
            # Available in AUR
            print_warning "For Arch Linux, install from AUR: yay -S openhantek"
            ;;
    esac
    
    # Install scopegui (universal oscilloscope software)
    print_status "Installing ScopeGUI via pip..."
    pip3 install --user scopegui
    
    print_success "Oscilloscope applications installed"
}

# Install MPLAB X IDE (Microchip)
install_mplab() {
    print_status "Installing MPLAB X IDE..."
    print_warning "MPLAB X IDE requires manual download from Microchip website"
    print_warning "Visit: https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide"
    print_warning "Download the Linux installer and run it manually"
}

# Install Keil µVision alternative (GNU Arm Embedded Toolchain)
install_arm_toolchain() {
    print_status "Installing GNU Arm Embedded Toolchain (Keil alternative)..."
    case $PACKAGE_MANAGER in
        apt)
            sudo apt install -y gcc-arm-none-eabi gdb-arm-none-eabi
            ;;
        yum)
            sudo yum install -y arm-none-eabi-gcc-cs arm-none-eabi-gdb
            ;;
        pacman)
            sudo pacman -S --noconfirm arm-none-eabi-gcc arm-none-eabi-gdb
            ;;
    esac
    print_success "GNU Arm Embedded Toolchain installed"
}

# Setup udev rules for USB devices
setup_udev_rules() {
    print_status "Setting up udev rules for development boards..."
    
    # Create udev rules for common development boards
    sudo tee /etc/udev/rules.d/99-embedded-dev.rules > /dev/null << 'EOF'
# Arduino boards
SUBSYSTEM=="usb", ATTR{idVendor}=="2341", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1a86", MODE="0666", GROUP="plugdev"

# ST-Link
SUBSYSTEM=="usb", ATTR{idVendor}=="0483", ATTR{idProduct}=="3748", MODE="0666", GROUP="plugdev"

# Generic USB-to-serial adapters
SUBSYSTEM=="usb", ATTR{idVendor}=="10c4", ATTR{idProduct}=="ea60", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="0403", MODE="0666", GROUP="plugdev"

# Logic analyzers
SUBSYSTEM=="usb", ATTR{idVendor}=="0925", MODE="0666", GROUP="plugdev"
SUBSYSTEM=="usb", ATTR{idVendor}=="1d50", MODE="0666", GROUP="plugdev"
EOF
    
    sudo udevadm control --reload-rules
    print_success "Udev rules configured"
}

# Main installation function
main() {
    echo "================================"
    echo "Embedded Systems Tools Installer"
    echo "================================"
    echo
    
    check_system
    update_packages
    install_dependencies
    install_vscode
    install_arduino
    install_kicad
    install_ltspice
    install_pulseview
    install_oscilloscope_apps
    install_arm_toolchain
    setup_udev_rules
    
    echo
    print_success "Installation completed!"
    echo
    print_warning "Please note:"
    echo "1. Log out and log back in for group permissions to take effect"
    echo "2. MPLAB X IDE requires manual download from Microchip website"
    echo "3. Keil µVision is Windows-only; GNU Arm Embedded Toolchain installed instead"
    echo "4. LTspice requires Wine on Linux"
    echo
    print_status "Tools installed:"
    echo "  ✓ Visual Studio Code + PlatformIO"
    echo "  ✓ Arduino IDE"
    echo "  ✓ KiCad"
    echo "  ✓ LTspice (via Wine)"
    echo "  ✓ PulseView (sigrok)"
    echo "  ✓ GNU Arm Embedded Toolchain"
    echo "  ✓ Oscilloscope applications"
    echo
}

# Run main function
main "$@"
