# KyberRules

[English Version](README.md) | 中文版本

KyberRules 是一套模块化、可扩展的 Makefile 规则集合，用于简化项目构建和管理过程。它提供了丰富的宏定义、配置管理和彩色输出功能，帮助开发者构建更加规范和高效的构建系统。

## 目录结构

```
rules/
├── Main.mk           # 主要规则文件，系统入口点
├── config/           # 配置规则目录
│   ├── Type.mk       # 类型定义规则
│   ├── Verbose.mk    # 详细输出配置规则
│   └── XPrint.mk     # 彩色打印配置规则
├── macro/            # 宏定义目录
│   ├── Basic.mk      # 基础宏定义
│   ├── File.mk       # 文件操作相关宏
│   ├── String.mk     # 字符串处理相关宏
│   ├── Version.mk    # 版本管理相关宏
│   └── XPrint.mk     # 彩色打印相关宏
└── README.md         # 本文档
```

## 功能特性

### 1. 基础工具宏

- **文件检查**：`file_is_exist` - 检查文件是否存在
- **规则包含**：`rule_inc` - 安全包含规则文件
- **环境检测**：`is_in_docker` - 检测是否在 Docker 环境中
- **路径处理**：`cur_dir` - 获取当前目录路径

### 2. 配置管理

- **路径配置**：自动检测和设置 `RULES_ROOT_PATH`
- **配置验证**：确保必要的规则文件存在
- **模块化配置**：通过 config/ 目录下的文件进行精细配置

### 3. 版本管理

- **Git 集成**：通过 Git 提交信息自动生成版本号
- **版本分解**：将版本号分解为主版本、次版本和修订号
- **SCM 版本**：生成源代码管理版本信息

### 4. 彩色输出

- **丰富的颜色支持**：支持常规、粗体、下划线、背景色和高强度颜色
- **格式化输出**：提供标题、信息、值和通知等格式化输出函数
- **可定制宽度**：支持自定义输出宽度和对齐方式

## 使用方法

### 1. 包含 KyberRules

在你的 Makefile 中包含 Main.mk 文件：

```makefile
# 设置 RULES_ROOT_PATH 指向 rules 目录（如果未设置）
# RULES_ROOT_PATH := /path/to/rules

# 包含主规则文件
include $(RULES_ROOT_PATH)/Main.mk
```

### 2. 查看规则信息

```bash
# 查看规则版本和配置信息
make rules_info

# 查看所有支持的颜色
make rules_colors
```

### 3. 使用内置宏

```makefile
# 检查文件是否存在
ifneq ($(call file_is_exist,$(CONFIG_FILE)),)
    $(error "配置文件不存在！")
endif

# 获取当前目录
CUR_DIR := $(call cur_dir)

# 安全包含规则文件
$(eval $(call rule_inc,$(CUR_DIR)/custom_rules.mk))
```

### 4. 使用彩色输出

```makefile
# 打印标题
$(call xprint_title, "构建配置")

# 打印信息
$(call xprint_info, "正在构建版本: $(VERSION)")

# 打印键值对
$(call xprint_value, "目标平台", $(TARGET_PLATFORM))

# 打印通知
$(call xprint_notice, "构建完成")

# 打印分隔线
$(call xprint_line)
```

## 版本信息

KyberRules 通过 Git 提交信息自动生成版本号：

- **RULES_VERSION_FULL**：完整版本号（包含 Git 提交哈希）
- **RULES_VERSION_MAIN**：主版本号
- **RULES_VERSION**：版本号
- **RULES_SUBVERSION**：次版本号
- **RULES_REVISION**：修订号
- **RULES_SCMVERSION**：SCM 版本信息

## 依赖

- **Git**：用于版本信息生成
- **GNU Make**：3.81 或更高版本
- **Bash**：用于 shell 命令执行

## 注意事项

1. 确保 `RULES_ROOT_PATH` 正确设置，指向包含 Main.mk 的目录
2. 所有自定义规则文件应使用 `.mk` 扩展名
3. 当在 Docker 环境中使用时，某些路径和命令可能需要调整
4. 彩色输出功能依赖于终端支持 ANSI 转义序列

## 示例

### 示例 1：基本使用

```makefile
# 设置规则根路径
RULES_ROOT_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/rules

# 包含规则
include $(RULES_ROOT_PATH)/Main.mk

# 自定义目标
build:
    $(call xprint_title, "构建项目")
    $(call xprint_info, "版本: $(RULES_VERSION)")
    $(call xprint_value, "目标", $@)
    # 构建命令...
    $(call xprint_notice, "构建完成")

# 显示规则信息
info: rules_info
```

### 示例 2：自定义规则

```makefile
# 设置规则根路径
RULES_ROOT_PATH := $(dir $(abspath $(lastword $(MAKEFILE_LIST))))/rules

# 包含规则
include $(RULES_ROOT_PATH)/Main.mk

# 自定义宏
ifeq ($(origin my_custom_macro),undefined)
define my_custom_macro
    $(call xprint_info, "执行自定义宏: $1")
    # 宏实现...
endef
endif

# 使用自定义宏
test:
    $(call my_custom_macro, "测试参数")
```

## 许可证

KyberRules 项目采用 Apache License 2.0 开源许可证。具体条款请参考项目根目录下的 [LICENSE](LICENSE) 文件。

## 贡献

欢迎提交问题和改进建议。请确保遵循项目的代码风格和贡献指南。

---

**KyberRules 项目**
版权所有 (c) 2025-2026, Kyber 开发团队, 保留所有权利。
