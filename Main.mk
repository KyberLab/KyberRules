#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Default Macros

# file_is_exist
# $(1) file path
# return empty if exist.
ifeq ($(origin file_is_exist),undefined)
define file_is_exist
$(shell ls $(1) > /dev/null 2>&1;echo $$? | grep -v 0)
endef
endif


# rule_inc
# $(1) rule file path
ifeq ($(origin rule_inc),undefined)
define rule_inc
$(if $(call file_is_exist,$(1)),$(error Rule File "$(1)" Not Exist !!!),include $(1))
endef
endif


# is_in_docker
# return : empty if in docker
ifeq ($(origin is_in_docker),undefined)
define is_in_docker
$(shell echo `[ ! -f /.dockerenv ]` $$? | grep -v 1)
endef
endif


# cur_dir
# return : current directory path
ifeq ($(origin cur_dir),undefined)
define cur_dir
$(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))
endef
endif



###############################################################################
# Path Check

ifeq ($(origin RULES_ROOT_PATH),undefined)
#$(warning "RULES_ROOT_PATH has not been defined.")
RULES_ROOT_PATH				:= $(call cur_dir)
#$(warning Define RULES_ROOT_PATH = $(RULES_ROOT_PATH))
endif


ifneq ($(call file_is_exist,$(RULES_ROOT_PATH)/Main.mk),)
$(error "Main.mk not exist !!!")
endif



###############################################################################
# Config Rules

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/config/Verbose.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/config/Type.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/config/XPrint.mk))



###############################################################################
# Macro Rules

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/macro/Basic.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/macro/XPrint.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/macro/String.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/macro/File.mk))

$(eval $(call rule_inc,$(RULES_ROOT_PATH)/macro/Version.mk))



###############################################################################
# Version Init

RULES_VERSION_FULL			:= $(call git_version_full,$(RULES_ROOT_PATH))
RULES_VERSION_MAIN			:= $(call git_version_main,$(RULES_VERSION_FULL))

RULES_VERSION				:= $(call git_version,$(RULES_VERSION_MAIN))
RULES_SUBVERSION			:= $(call git_subversion,$(RULES_VERSION_MAIN))
RULES_REVISION				:= $(call git_revision,$(RULES_VERSION_MAIN))

RULES_SCMVERSION			:= $(call git_scmversion,$(RULES_VERSION_FULL))




###############################################################################

.PHONY	: rules_info rules_colors

rules_info : 
	$(Q)$(call xprint_title,	"Verbose Information")
	$(Q)$(call xprint_filled,$(XPRINT_VALUE_COLOR))
	$(Q)$(call xprint_value,	"Prompt Total Width",		$(XPRINT_TOTAL_WIDTH))
	$(Q)$(call xprint_value,	"Prompt Key Shift",			$(XPRINT_KEY_SHIFT))
	$(Q)$(call xprint_value,	"Prompt Key Width",			$(XPRINT_KEY_WIDTH))
	$(Q)$(call xprint_value,	"Prompt Filled Char",		$(XPRINT_FILLED_CHAR))
	$(Q)$(call xprint_filled,$(XPRINT_VALUE_COLOR))
	$(Q)$(call xprint_title,	"Rules Version Information")
	$(Q)$(call xprint_filled,$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules Version Full",		$(RULES_VERSION_FULL),$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules Version Main",		$(RULES_VERSION_MAIN),$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules Version",			$(RULES_VERSION),$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules Subversion",			$(RULES_SUBVERSION),$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules Revision",			$(RULES_REVISION),$(HB_GREEN))
	$(Q)$(call xprint_value,	"Rules SCM Version",		$(RULES_SCMVERSION),$(HB_GREEN))
	$(Q)$(call xprint_filled,$(HB_GREEN))



rules_colors : rules_rcolors rules_bcolors rules_ucolors rules_bg_colors rules_hi_colors rules_bh_colors rules_hb_colors


rules_rcolors : 
	$(Q)$(call xprint_title,	"XPrint Regular Colors")
	$(Q)$(call xprint_title,	"BLACK",$(BLACK))
	$(Q)$(call xprint_title,	"RED",$(RED))
	$(Q)$(call xprint_title,	"GREEN",$(GREEN))
	$(Q)$(call xprint_title,	"YELLOW",$(YELLOW))
	$(Q)$(call xprint_title,	"BLUE",$(BLUE))
	$(Q)$(call xprint_title,	"PURPLE",$(PURPLE))
	$(Q)$(call xprint_title,	"CYAN",$(CYAN))
	$(Q)$(call xprint_title,	"WHITE",$(WHITE))
	$(Q)$(call xprint_line)


rules_bcolors : 
	$(Q)$(call xprint_title,	"XPrint Bold Colors")
	$(Q)$(call xprint_title,	"Bold BLACK",$(BBLACK))
	$(Q)$(call xprint_title,	"Bold RED",$(BRED))
	$(Q)$(call xprint_title,	"Bold GREEN",$(BGREEN))
	$(Q)$(call xprint_title,	"Bold YELLOW",$(BYELLOW))
	$(Q)$(call xprint_title,	"Bold BLUE",$(BBLUE))
	$(Q)$(call xprint_title,	"Bold PURPLE",$(BPURPLE))
	$(Q)$(call xprint_title,	"Bold CYAN",$(BCYAN))
	$(Q)$(call xprint_title,	"Bold WHITE",$(BWHITE))
	$(Q)$(call xprint_line)


rules_ucolors : 
	$(Q)$(call xprint_title,	"XPrint Underline Colors")
	$(Q)$(call xprint_title,	"Underline BLACK",$(UBLACK))
	$(Q)$(call xprint_title,	"Underline RED",$(URED))
	$(Q)$(call xprint_title,	"Underline GREEN",$(UGREEN))
	$(Q)$(call xprint_title,	"Underline YELLOW",$(UYELLOW))
	$(Q)$(call xprint_title,	"Underline BLUE",$(UBLUE))
	$(Q)$(call xprint_title,	"Underline PURPLE",$(UPURPLE))
	$(Q)$(call xprint_title,	"Underline CYAN",$(UCYAN))
	$(Q)$(call xprint_title,	"Underline WHITE",$(UWHITE))
	$(Q)$(call xprint_line)


rules_bg_colors : 
	$(Q)$(call xprint_title,	"XPrint Background Colors")
	$(Q)$(call xprint_title,	"Background BLACK",$(BG_BLACK))
	$(Q)$(call xprint_title,	"Background RED",$(BG_RED))
	$(Q)$(call xprint_title,	"Background GREEN",$(BG_GREEN))
	$(Q)$(call xprint_title,	"Background YELLOW",$(BG_YELLOW))
	$(Q)$(call xprint_title,	"Background BLUE",$(BG_BLUE))
	$(Q)$(call xprint_title,	"Background PURPLE",$(BG_PURPLE))
	$(Q)$(call xprint_title,	"Background CYAN",$(BG_CYAN))
	$(Q)$(call xprint_title,	"Background WHITE",$(BG_WHITE))
	$(Q)$(call xprint_line)


rules_hi_colors : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Colors")
	$(Q)$(call xprint_title,	"High Intensity BLACK",$(HI_BLACK))
	$(Q)$(call xprint_title,	"High Intensity RED",$(HI_RED))
	$(Q)$(call xprint_title,	"High Intensity GREEN",$(HI_GREEN))
	$(Q)$(call xprint_title,	"High Intensity YELLOW",$(HI_YELLOW))
	$(Q)$(call xprint_title,	"High Intensity BLUE",$(HI_BLUE))
	$(Q)$(call xprint_title,	"High Intensity PURPLE",$(HI_PURPLE))
	$(Q)$(call xprint_title,	"High Intensity CYAN",$(HI_CYAN))
	$(Q)$(call xprint_title,	"High Intensity WHITE",$(HI_WHITE))
	$(Q)$(call xprint_line)


rules_bh_colors : 
	$(Q)$(call xprint_title,	"XPrint Bold High Intensity Colors")
	$(Q)$(call xprint_title,	"Bold High Intensity BLACK",$(BH_BLACK))
	$(Q)$(call xprint_title,	"Bold High Intensity RED",$(BH_RED))
	$(Q)$(call xprint_title,	"Bold High Intensity GREEN",$(BH_GREEN))
	$(Q)$(call xprint_title,	"Bold High Intensity YELLOW",$(BH_YELLOW))
	$(Q)$(call xprint_title,	"Bold High Intensity BLUE",$(BH_BLUE))
	$(Q)$(call xprint_title,	"Bold High Intensity PURPLE",$(BH_PURPLE))
	$(Q)$(call xprint_title,	"Bold High Intensity CYAN",$(BH_CYAN))
	$(Q)$(call xprint_title,	"Bold High Intensity WHITE",$(BH_WHITE))
	$(Q)$(call xprint_line)


rules_hb_colors : rules_hb_colors_title rules_hb_colors_line rules_hb_colors_info rules_hb_colors_value rules_hb_colors_notice

rules_hb_colors_title : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Background Colors Title")
	$(Q)$(call xprint_title,	"High Intensity Background BLACK",$(HB_BLACK))
	$(Q)$(call xprint_title,	"High Intensity Background RED",$(HB_RED))
	$(Q)$(call xprint_title,	"High Intensity Background GREEN",$(HB_GREEN))
	$(Q)$(call xprint_title,	"High Intensity Background YELLOW",$(HB_YELLOW))
	$(Q)$(call xprint_title,	"High Intensity Background BLUE",$(HB_BLUE))
	$(Q)$(call xprint_title,	"High Intensity Background PURPLE",$(HB_PURPLE))
	$(Q)$(call xprint_title,	"High Intensity Background CYAN",$(HB_CYAN))
	$(Q)$(call xprint_title,	"High Intensity Background WHITE",$(HB_WHITE))
	$(Q)$(call xprint_line)

rules_hb_colors_line : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Background Colors Line")
	$(Q)$(call xprint_line,$(HB_BLACK))
	$(Q)$(call xprint_line,$(HB_RED))
	$(Q)$(call xprint_line,$(HB_GREEN))
	$(Q)$(call xprint_line,$(HB_YELLOW))
	$(Q)$(call xprint_line,$(HB_BLUE))
	$(Q)$(call xprint_line,$(HB_PURPLE))
	$(Q)$(call xprint_line,$(HB_CYAN))
	$(Q)$(call xprint_line,$(HB_WHITE))
	$(Q)$(call xprint_line)


rules_hb_colors_info : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Background Colors Info")
	$(Q)$(call xprint_info,		"High Intensity Background BLACK", $(HB_BLACK))
	$(Q)$(call xprint_info,		"High Intensity Background RED", $(HB_RED))
	$(Q)$(call xprint_info,		"High Intensity Background GREEN", $(HB_GREEN))
	$(Q)$(call xprint_info,		"High Intensity Background YELLOW", $(HB_YELLOW))
	$(Q)$(call xprint_info,		"High Intensity Background BLUE", $(HB_BLUE))
	$(Q)$(call xprint_info,		"High Intensity Background PURPLE", $(HB_PURPLE))
	$(Q)$(call xprint_info,		"High Intensity Background CYAN", $(HB_CYAN))
	$(Q)$(call xprint_info,		"High Intensity Background WHITE", $(HB_WHITE))
	$(Q)$(call xprint_line)



rules_hb_colors_value : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Background Colors Value")
	$(Q)$(call xprint_value,	"High Intensity Background BLACK", HB_BLACK, $(HB_BLACK))
	$(Q)$(call xprint_value,	"High Intensity Background RED", HB_RED, $(HB_RED))
	$(Q)$(call xprint_value,	"High Intensity Background GREEN", HB_GREEN, $(HB_GREEN))
	$(Q)$(call xprint_value,	"High Intensity Background YELLOW", HB_YELLOW, $(HB_YELLOW))
	$(Q)$(call xprint_value,	"High Intensity Background BLUE", HB_BLUE, $(HB_BLUE))
	$(Q)$(call xprint_value,	"High Intensity Background PURPLE", HB_PURPLE, $(HB_PURPLE))
	$(Q)$(call xprint_value,	"High Intensity Background CYAN", HB_CYAN, $(HB_CYAN))
	$(Q)$(call xprint_value,	"High Intensity Background WHITE", HB_WHITE, $(HB_WHITE))
	$(Q)$(call xprint_line)

rules_hb_colors_notice : 
	$(Q)$(call xprint_title,	"XPrint High Intensity Background Colors Notice")
	$(Q)$(call xprint_notice,	"High Intensity Background BLACK", $(HB_BLACK))
	$(Q)$(call xprint_notice,	"High Intensity Background RED", $(HB_RED))
	$(Q)$(call xprint_notice,	"High Intensity Background GREEN", $(HB_GREEN))
	$(Q)$(call xprint_notice,	"High Intensity Background YELLOW", $(HB_YELLOW))
	$(Q)$(call xprint_notice,	"High Intensity Background BLUE", $(HB_BLUE))
	$(Q)$(call xprint_notice,	"High Intensity Background PURPLE", $(HB_PURPLE))
	$(Q)$(call xprint_notice,	"High Intensity Background CYAN", $(HB_CYAN))
	$(Q)$(call xprint_notice,	"High Intensity Background WHITE", $(HB_WHITE))
	$(Q)$(call xprint_line)

