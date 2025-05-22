# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Initial release of embedded systems tools installer

## [1.0.0] - 2025-05-22

### Added
- **Core Installation Script**
  - Automated installation of essential embedded systems tools
  - Support for Ubuntu/Debian (apt), CentOS/RHEL (yum), and Arch Linux (pacman)
  - Cross-platform compatibility detection

- **Development Environments**
  - Visual Studio Code with PlatformIO extension
  - Arduino IDE 2.x (AppImage installation)
  - GNU Arm Embedded Toolchain (free Keil alternative)

- **Circuit Design Tools**
  - KiCad PCB design suite with component libraries
  - LTspice circuit simulator (via Wine on Linux)

- **Analysis & Debugging Tools**
  - PulseView logic analyzer software (sigrok)
  - OpenHantek USB oscilloscope software
  - ScopeGUI universal oscilloscope interface

- **System Configuration**
  - Automated udev rules setup for USB development boards
  - Support for Arduino, ST-Link, USB-to-serial adapters
  - Logic analyzer and oscilloscope device permissions

- **User Experience**
  - Colored terminal output for better readability
  - Comprehensive error handling and status reporting
  - Automatic dependency resolution
  - Post-installation instructions and guidance

- **Documentation**
  - Comprehensive README with installation and usage instructions
  - Troubleshooting guide for common issues
  - Contributing guidelines for developers
  - MIT license for open-source distribution

### Technical Details
- **Package Managers**: Support for apt, yum, and pacman
- **Architecture**: 64-bit Linux systems
- **Dependencies**: Automatic installation of build tools and libraries
- **Permissions**: Proper USB device access configuration

### Known Limitations
- Keil µVision requires Windows (GNU ARM toolchain provided as alternative)
- MPLAB X IDE requires manual download due to licensing restrictions
- LTspice requires Wine for Linux compatibility
- Some Arch Linux packages may require AUR installation

### Security
- Script requires sudo privileges for system package installation
- USB device permissions configured following security best practices
- No automatic execution of downloaded binaries without user consent

---

## Release Notes Format

### Added
- New features and tools

### Changed
- Changes in existing functionality

### Deprecated
- Soon-to-be removed features

### Removed
- Now removed features

### Fixed
- Bug fixes

### Security
- Security-related changes
