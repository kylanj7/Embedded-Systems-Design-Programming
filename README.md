# Embedded Systems Tools Installer

A comprehensive bash script to automatically install essential tools for embedded systems development on Linux systems.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Shell Script](https://img.shields.io/badge/Shell-Bash-green.svg)](https://www.gnu.org/software/bash/)
[![Platform](https://img.shields.io/badge/Platform-Linux-blue.svg)](https://www.linux.org/)

## 🚀 Quick Start

```bash
# Clone the repository
git clone https://github.com/yourusername/embedded-tools-installer.git
cd embedded-tools-installer

# Make the script executable
chmod +x install_embedded_tools.sh

# Run the installer
./install_embedded_tools.sh
```

## 📋 What Gets Installed

### Development Environments
- **Visual Studio Code** + PlatformIO extension
- **Arduino IDE** (latest 2.x version)
- **GNU Arm Embedded Toolchain** (free alternative to Keil µVision)

### Circuit Design & Simulation
- **KiCad** + component libraries
- **LTspice** (via Wine on Linux)

### Analysis & Debugging Tools
- **PulseView** (sigrok logic analyzer software)
- **OpenHantek** (USB oscilloscope software)
- **ScopeGUI** (universal oscilloscope interface)

### System Configuration
- USB device permissions (udev rules)
- Development board support
- Required system dependencies

## 🖥️ Supported Systems

| Distribution | Package Manager | Status |
|--------------|----------------|--------|
| Ubuntu/Debian | apt | ✅ Fully Supported |
| CentOS/RHEL | yum | ✅ Fully Supported |
| Arch Linux | pacman | ✅ Supported* |

*Some packages may require AUR on Arch Linux

## 📦 Detailed Tool List

### ✅ Automatically Installed
- **Visual Studio Code** - Cross-platform code editor
- **PlatformIO** - Embedded development platform
- **Arduino IDE** - Arduino development environment
- **KiCad** - Open-source PCB design suite
- **PulseView** - Logic analyzer software
- **GNU Arm Embedded Toolchain** - ARM Cortex development tools
- **OpenHantek** - USB oscilloscope software
- **Wine** - Windows compatibility layer (for LTspice)

### ⚠️ Manual Installation Required
- **MPLAB X IDE** - Download from [Microchip website](https://www.microchip.com/en-us/tools-resources/develop/mplab-x-ide)
- **Keil µVision** - Windows-only, requires license (GNU ARM toolchain installed as alternative)

### 🍷 Wine-Based Installation
- **LTspice** - Downloads installer, requires Wine to run

## 🔧 Prerequisites

- Linux-based operating system
- Internet connection
- `sudo` privileges
- Basic system tools (`wget`, `curl`, `git`)

## 📖 Usage

### Basic Installation
```bash
./install_embedded_tools.sh
```

### Post-Installation Steps

1. **Log out and log back in** to apply USB device permissions
2. **Install MPLAB X IDE manually** if needed for PIC development
3. **Install LTspice via Wine**:
   ```bash
   wine ~/Applications/LTspice/LTspice.exe
   ```

### Verifying Installation

Check that tools are properly installed:
```bash
# Check VS Code
code --version

# Check Arduino CLI (if installed)
arduino-cli version

# Check KiCad
kicad --version

# Check PulseView
pulseview --version

# Check ARM toolchain
arm-none-eabi-gcc --version
```

## 🔌 USB Device Support

The script automatically configures udev rules for:
- Arduino boards (various vendors)
- ST-Link programmers
- USB-to-serial adapters (CP2102, FTDI)
- Logic analyzers (Saleae, clones)

## 🛠️ Troubleshooting

### Common Issues

**Permission denied for USB devices**
```bash
# Add yourself to the plugdev group
sudo usermod -a -G plugdev $USER
# Log out and log back in
```

**VS Code PlatformIO not working**
```bash
# Reinstall PlatformIO extension
code --uninstall-extension platformio.platformio-ide
code --install-extension platformio.platformio-ide
```

**Wine/LTspice issues**
```bash
# Configure Wine
winecfg
# Install Windows fonts
winetricks corefonts
```

**Arduino IDE AppImage not launching**
```bash
# Install FUSE if missing
sudo apt install fuse  # Ubuntu/Debian
sudo yum install fuse  # CentOS/RHEL
```

### Log Files

The script provides colored output. To save logs:
```bash
./install_embedded_tools.sh 2>&1 | tee installation.log
```

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

### Development Setup
1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Make your changes
4. Test on different Linux distributions
5. Commit your changes (`git commit -m 'Add amazing feature'`)
6. Push to the branch (`git push origin feature/amazing-feature`)
7. Open a Pull Request

### Coding Standards
- Use shellcheck for script validation
- Follow bash best practices
- Include error handling
- Maintain compatibility across distributions

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚠️ Disclaimer

This script modifies system packages and configurations. While tested on multiple distributions, please:
- Review the script before running
- Test in a virtual machine first
- Backup important data
- Run with appropriate privileges

## 📞 Support

- 🐛 **Bug Reports**: [Open an issue](https://github.com/yourusername/embedded-tools-installer/issues)
- 💡 **Feature Requests**: [Open an issue](https://github.com/yourusername/embedded-tools-installer/issues)
- 📧 **General Questions**: [Discussions](https://github.com/yourusername/embedded-tools-installer/discussions)

## 🙏 Acknowledgments

- [PlatformIO](https://platformio.org/) - Embedded development platform
- [KiCad](https://kicad.org/) - Open-source PCB design
- [sigrok](https://sigrok.org/) - Signal analysis software suite
- [Arduino](https://arduino.cc/) - Open-source electronics platform

## 📊 Project Stats

![GitHub stars](https://img.shields.io/github/stars/yourusername/embedded-tools-installer)
![GitHub forks](https://img.shields.io/github/forks/yourusername/embedded-tools-installer)
![GitHub issues](https://img.shields.io/github/issues/yourusername/embedded-tools-installer)
![GitHub last commit](https://img.shields.io/github/last-commit/yourusername/embedded-tools-installer)

---

**Made with ❤️ for the embedded systems community**
