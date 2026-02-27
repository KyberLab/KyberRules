# KyberRules

[中文版本](README_zh.md) | English Version

KyberRules is a modular, extensible collection of Makefile rules designed to simplify project build and management processes. It provides rich macro definitions, configuration management, and colored output functionality to help developers build more standardized and efficient build systems.

## Directory Structure

```
rules/
├── Main.mk           # Main rules file, system entry point
├── config/           # Configuration rules directory
│   ├── Type.mk       # Type definition rules
│   ├── Verbose.mk    # Verbose output configuration rules
│   └── XPrint.mk     # Colored printing configuration rules
├── macro/            # Macro definitions directory
│   ├── Basic.mk      # Basic macro definitions
│   ├── File.mk       # File operation related macros
│   ├── String.mk     # String processing related macros
│   ├── Version.mk    # Version management related macros
│   └── XPrint.mk     # Colored printing related macros
├── README.md         # This document
└── README_zh.md      # Chinese version of this document
```

## Features

### 1. Basic Utility Macros

- **File Check**: `file_is_exist` - Check if a file exists
- **Rule Inclusion**: `rule_inc` - Safely include rule files
- **Environment Detection**: `is_in_docker` - Detect if running in Docker environment
- **Path Handling**: `cur_dir` - Get current directory path

### 2. Configuration Management

- **Path Configuration**: Automatically detect and set `RULES_ROOT_PATH`
- **Configuration Validation**: Ensure necessary rule files exist
- **Modular Configuration**: Fine-grained configuration through files in config/ directory

### 3. Version Management

- **Git Integration**: Automatically generate version numbers from Git commit information
- **Version Decomposition**: Break down version numbers into major, minor, and revision numbers
- **SCM Version**: Generate source code management version information

### 4. Colored Output

- **Rich Color Support**: Support for regular, bold, underline, background, and high-intensity colors
- **Formatted Output**: Provide formatted output functions for titles, information, values, and notifications
- **Customizable Width**: Support for custom output width and alignment

## Usage

### 1. Including KyberRules

Include the Main.mk file in your Makefile:

```makefile
# Set RULES_ROOT_PATH to point to the rules directory (if not set)
# RULES_ROOT_PATH := /path/to/rules

# Include the main rules file
include $(RULES_ROOT_PATH)/Main.mk
```

### 2. Viewing Rules Information

```bash
# View rules version and configuration information
make rules_info

# View all supported colors
make rules_colors
```

### 3. Using Built-in Macros

```makefile
# Check if a file exists
ifneq ($(call file_is_exist,$(CONFIG_FILE)),)
    $(error "Configuration file does not exist!")
endif

# Get current directory
CUR_DIR := $(call cur_dir)

# Safely include rule files
$(eval $(call rule_inc,$(CUR_DIR)/custom_rules.mk))
```

### 4. Using Colored Output

```makefile
# Print title
$(call xprint_title, "Build Configuration")

# Print information
$(call xprint_info, "Building version: $(VERSION)")

# Print key-value pair
$(call xprint_value, "Target Platform", $(TARGET_PLATFORM))

# Print notification
$(call xprint_notice, "Build completed")

# Print separator line
$(call xprint_line)
```

## Version Information

KyberRules automatically generates version numbers through Git commit information:

- **RULES_VERSION_FULL**: Full version number (including Git commit hash)
- **RULES_VERSION_MAIN**: Main version number
- **RULES_VERSION**: Version number
- **RULES_SUBVERSION**: Subversion number
- **RULES_REVISION**: Revision number
- **RULES_SCMVERSION**: SCM version information

## Dependencies

- **Git**: Required for version information generation
- **GNU Make**: Version 3.81 or higher
- **Bash**: Required for shell command execution

## Notes

1. Ensure `RULES_ROOT_PATH` is correctly set to point to the directory containing Main.mk
2. All custom rule files should use the `.mk` extension
3. When using in Docker environment, some paths and commands may need adjustment
4. Colored output functionality depends on terminal support for ANSI escape sequences

## Examples

### Example 1: Basic Usage

```makefile
# Set rules root path
RULES_ROOT_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/rules

# Include rules
include $(RULES_ROOT_PATH)/Main.mk

# Custom target
build:
    $(call xprint_title, "Building Project")
    $(call xprint_info, "Version: $(RULES_VERSION)")
    $(call xprint_value, "Target", $@)
    # Build commands...
    $(call xprint_notice, "Build completed")

# Show rules information
info: rules_info
```

### Example 2: Custom Rules

```makefile
# Set rules root path
RULES_ROOT_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/rules

# Include rules
include $(RULES_ROOT_PATH)/Main.mk

# Custom macro
ifeq ($(origin my_custom_macro),undefined)
define my_custom_macro
    $(call xprint_info, "Executing custom macro: $1")
    # Macro implementation...
endef
endif

# Use custom macro
test:
    $(call my_custom_macro, "Test parameter")
```

## License

KyberRules project adopts the Apache License 2.0 open source license. For specific terms, please refer to the [LICENSE](LICENSE) file in the project root directory.

## Contribution

Contributions and suggestions are welcome. Please ensure you follow the project's code style and contribution guidelines.

---

**KyberRules Project**
Copyright (c) 2025-2026, Kyber Development Team, all rights reserved.
