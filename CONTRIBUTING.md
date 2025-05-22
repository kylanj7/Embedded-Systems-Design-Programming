# Contributing to Embedded Systems Tools Installer

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🎯 Ways to Contribute

- 🐛 **Bug Reports**: Found a bug? Let us know!
- 💡 **Feature Requests**: Have an idea for improvement?
- 🔧 **Code Contributions**: Submit bug fixes or new features
- 📝 **Documentation**: Improve or expand documentation
- 🧪 **Testing**: Test on different distributions and report results

## 🚀 Getting Started

### Prerequisites
- Linux system (Ubuntu, CentOS, or Arch Linux)
- Basic knowledge of bash scripting
- Git installed on your system

### Development Setup
1. **Fork the repository**
   ```bash
   # Click the "Fork" button on GitHub, then clone your fork
   git clone https://github.com/yourusername/embedded-tools-installer.git
   cd embedded-tools-installer
   ```

2. **Create a development branch**
   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Set up development tools**
   ```bash
   # Install shellcheck for script validation
   sudo apt install shellcheck  # Ubuntu/Debian
   sudo yum install ShellCheck  # CentOS/RHEL
   sudo pacman -S shellcheck    # Arch Linux
   ```

## 📋 Development Guidelines

### Code Style
- Follow bash best practices
- Use 4 spaces for indentation
- Keep lines under 100 characters when possible
- Use meaningful variable names
- Include comments for complex logic

### Script Structure
```bash
# Function naming convention
function_name() {
    # Function implementation
}

# Error handling
set -e  # Exit on error

# Use proper exit codes
exit 0  # Success
exit 1  # General error
```

### Testing Your Changes

1. **Lint your code**
   ```bash
   shellcheck install_embedded_tools.sh
   ```

2. **Test on virtual machines**
   - Test on at least one supported distribution
   - Verify both fresh installs and updates
   - Test with and without sudo privileges

3. **Test specific functions**
   ```bash
   # Test individual functions by commenting out others
   # in the main() function
   ```

## 🐛 Bug Reports

When reporting bugs, please include:

### Required Information
- **OS and version**: `cat /etc/os-release`
- **Script version**: Git commit hash
- **Error message**: Full error output
- **Steps to reproduce**: Detailed steps

### Bug Report Template
```markdown
**Description**
Brief description of the issue

**Environment**
- OS: Ubuntu 22.04 LTS
- Package Manager: apt
- Script Version: commit abc123

**Steps to Reproduce**
1. Run ./install_embedded_tools.sh
2. Select option X
3. Error occurs

**Expected Behavior**
What should have happened

**Actual Behavior**
What actually happened

**Error Output**
```
Paste error messages here
```

**Additional Context**
Any other relevant information
```

## 💡 Feature Requests

For feature requests, please provide:
- **Use case**: Why is this feature needed?
- **Proposed solution**: How should it work?
- **Alternatives considered**: Other approaches you've thought of
- **Additional context**: Screenshots, examples, etc.

## 🔧 Code Contributions

### Before You Start
1. Check existing issues and PRs to avoid duplicates
2. Discuss major changes in an issue first
3. Keep changes focused and atomic

### Making Changes

1. **Follow the coding standards**
   ```bash
   # Good function example
   install_new_tool() {
       print_status "Installing New Tool..."
       
       case $PACKAGE_MANAGER in
           apt)
               sudo apt install -y new-tool
               ;;
           yum)
               sudo yum install -y new-tool
               ;;
           pacman)
               sudo pacman -S --noconfirm new-tool
               ;;
       esac
       
       print_success "New Tool installed"
   }
   ```

2. **Add proper error handling**
   ```bash
   # Check if command exists
   if ! command -v tool &> /dev/null; then
       print_error "Tool not found"
       return 1
   fi
   ```

3. **Update documentation**
   - Update README.md if adding new tools
   - Add comments to complex code
   - Update help text if needed

4. **Test thoroughly**
   - Test on multiple distributions
   - Verify both new installs and updates
   - Check that existing functionality still works

### Pull Request Process

1. **Create a descriptive PR title**
   - `feat: add support for New Tool`
   - `fix: resolve Arduino IDE installation issue`
   - `docs: update installation instructions`

2. **Write a clear description**
   ```markdown
   ## Changes
   - Added support for New Tool installation
   - Updated udev rules for New Tool devices
   
   ## Testing
   - Tested on Ubuntu 22.04
   - Tested on CentOS 8
   - Verified existing tools still install correctly
   
   ## Related Issues
   Closes #123
   ```

3. **Ensure CI passes**
   - All shellcheck tests pass
   - No merge conflicts
   - All requested changes addressed

## 🧪 Testing Guidelines

### Test Scenarios
- **Fresh installation**: Clean system with no tools installed
- **Partial installation**: Some tools already installed
- **Update scenario**: Older versions of tools present
- **Permission issues**: Test without sudo (should fail gracefully)
- **Network issues**: Test with limited connectivity

### Test Matrix
| Distribution | Package Manager | Status |
|--------------|----------------|--------|
| Ubuntu 20.04 | apt | Required |
| Ubuntu 22.04 | apt | Required |
| CentOS 8 | yum | Required |
| Arch Linux | pacman | Nice to have |

### Manual Testing Checklist
- [ ] Script runs without errors
- [ ] All supported tools install correctly
- [ ] USB permissions work after reboot
- [ ] VS Code extensions install properly
- [ ] KiCad opens and functions
- [ ] PulseView detects logic analyzers
- [ ] Help/usage information is accurate

## 📝 Documentation

### README Updates
When adding new tools or features:
- Update the "What Gets Installed" section
- Add troubleshooting information if needed
- Update system requirements
- Add usage examples

### Code Documentation
- Add comments for complex functions
- Document any non-obvious behavior
- Include examples in comments when helpful

## 🏷️ Release Process

### Version Numbering
We use semantic versioning (MAJOR.MINOR.PATCH):
- **MAJOR**: Breaking changes
- **MINOR**: New features, backward compatible
- **PATCH**: Bug fixes, backward compatible

### Creating a Release
1. Update version in script header
2. Update CHANGELOG.md
3. Create release tag
4. Write release notes

## 📞 Getting Help

- **Questions**: Open a [Discussion](https://github.com/yourusername/embedded-tools-installer/discussions)
- **Issues**: Open an [Issue](https://github.com/yourusername/embedded-tools-installer/issues)
- **Chat**: Join our community chat (if available)

## 🙏 Recognition

Contributors will be:
- Listed in the README.md
- Mentioned in release notes
- Credited in commit messages

Thank you for contributing to the embedded systems community! 🚀
