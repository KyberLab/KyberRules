#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Basic XPrint Functions


# xprint
# $(1) fonts
# $(2)...$(6) string
# return : none
ifeq ($(origin xprint),undefined)
define xprint
$(ECHO) "$(if $(1),$(1))" $(2) $(3) $(4) $(5) $(6) "$(if $(1),$(COLOR_RESET))"
endef
endif


# xprint0
# $(1) fonts
# $(2)...$(6) string
# return : none
ifeq ($(origin xprint0),undefined)
define xprint0
$(ECHO) -n "$(if $(1),$(1))" $(2) $(3) $(4) $(5) $(6) "$(if $(1),$(COLOR_RESET))"
endef
endif


# xprint_filled_len
# $(1) string
# $(2) width of key
ifeq ($(origin xprint_filled_len),undefined)
define xprint_filled_len
$(shell echo "$(if $(2),$(2),$(XPRINT_TOTAL_WIDTH)) - $(call string_len,$(1))" | bc)
endef
endif


# xprint_filled
# $(1) color
# $(2) string
# $(3) width of key
# $(4) char
ifeq ($(origin xprint_filled),undefined)
define xprint_filled
filled_len=$(call xprint_filled_len,$(2),$(3)) && \
$(call xprint0,$(if $(1),$(1),$(XPRINT_VALUE_COLOR)),$(if $(2),$(2),"")) && \
$(ECHO) -n "$(if $(1),$(1),$(XPRINT_VALUE_COLOR))" && printf "%$${filled_len}s" $(if $(4),$(4)," ") && $(ECHO) "$(COLOR_RESET)"
endef
endif



###############################################################################
# Repeat char string generator


# xprint_chars
# $(1) width
# $(2) char
# return : string of repeated chars
ifeq ($(origin xprint_chars),undefined)
define xprint_chars
"$(call char_repeat,$(if $(2),$(2),$(XPRINT_FILLED_CHAR)),$(if $(1),$(1),$(XPRINT_TOTAL_WIDTH)))"
endef
endif


# xprint_space
# $(1) width
# return : string of repeated spaces
ifeq ($(origin xprint_space),undefined)
define xprint_space
$(shell echo \"$(call xprint_chars,$(if $(1),$(1),$(XPRINT_TOTAL_WIDTH)),x)\" | tr 'x' ' ')
endef
endif



###############################################################################
# Center align string generator

# xprint_center_left_len
# $(1) string
# $(2) width
# return : length of left string
ifeq ($(origin xprint_center_left_len),undefined)
define xprint_center_left_len
$(shell echo "($(if $(2),$(2),$(XPRINT_TOTAL_WIDTH)) - 2 - $(call string_len,$(1))) / 2" | bc)
endef
endif


# xprint_center_right_len
# $(1) string
# $(2) width
# $(3) length of left string
# return : length of right string
ifeq ($(origin xprint_center_right_len),undefined)
define xprint_center_right_len
$(shell echo "$(if $(2),$(2),$(XPRINT_TOTAL_WIDTH)) - 2 - $(3) - $(call string_len,$(1))" | bc)
endef
endif


# xprint_center
# $(1) string
# $(2) width
# $(3) char
# notice : char 'X' for space.
# return : string of centered string
ifeq ($(origin xprint_center),undefined)
define xprint_center
$(call xprint_chars,$(call xprint_center_left_len,$(1),$(2)),$(3))" $(1) "$(call xprint_chars,$(call xprint_center_right_len,$(1),$(2),$(call xprint_center_left_len,$(1),$(2))),$(3))
endef
endif


###############################################################################
# Left align string generator

# xprint_string_left
# $(1) string
# $(2) width of left
# $(3) char
# notice : char 'X' for space.
# return : string of left string
ifeq ($(origin xprint_string_left),undefined)
define xprint_string_left
$(call xprint_chars,$(XPRINT_KEY_SHIFT),$(if $(3),$(3),X))$(1)$(call xprint_chars,$(shell echo "$(2) - $(XPRINT_KEY_SHIFT) - $(call string_len,$(1))" | bc),$(if $(3),$(3),X))
endef
endif



###############################################################################
# Blank and line print


# xprint_blank
# $(1) color
# $(2) width
# return : none
# print blank line
ifeq ($(origin xprint_blank),undefined)
define xprint_blank
$(call xprint,$(if $(1),$(1),$(XPRINT_LINE_COLOR)),$(call xprint_space,$(2)))
endef
endif


# xprint_line
# $(1) color
# $(2) char
# $(3) width
# return : none
# print line with char
ifeq ($(origin xprint_line),undefined)
define xprint_line
$(call xprint_blank,$(if $(1),$(strip $(1)),$(XPRINT_LINE_COLOR))) && \
$(call xprint,$(if $(1),$(strip $(1)),$(XPRINT_LINE_COLOR)),$(call xprint_chars,$(if $(3),$(3),$(XPRINT_TOTAL_WIDTH)),$(if $(2),$(2),$(XPRINT_FILLED_CHAR)))) && \
$(call xprint_blank,$(if $(1),$(strip $(1)),$(XPRINT_LINE_COLOR)))
endef
endif



###############################################################################

# xprint_title
# $(1) string
# $(2) color
# $(3) char
# $(4) width
# notice : char 'X' for space.
ifeq ($(origin xprint_title),undefined)
define xprint_title
$(call xprint_blank,$(if $(2),$(strip $(2)),$(XPRINT_TITLE_COLOR))) && \
$(call xprint,$(if $(2),$(strip $(2)),$(XPRINT_TITLE_COLOR)),$(call xprint_center,$(call string_strip,$(1)),$(4),$(3))) && \
$(call xprint_blank,$(if $(2),$(strip $(2)),$(XPRINT_TITLE_COLOR)))
endef
endif


# xprint_info
# $(1) string
# $(2) color
# $(3) width
# $(4) char
# notice : char 'X' for space.
ifeq ($(origin xprint_info),undefined)
define xprint_info
$(call xprint_blank,$(if $(2),$(strip $(2)),$(XPRINT_INFO_COLOR))) && \
$(call xprint,$(if $(2),$(strip $(2)),$(XPRINT_INFO_COLOR)),$(call xprint_center,$(call string_strip,$(1)),$(3),$(if $(4),$(4),X))) && \
$(call xprint_blank,$(if $(2),$(strip $(2)),$(XPRINT_INFO_COLOR)))
endef
endif


# xprint_value_str
# $(1) key
# $(2) value
# $(3) width of key
# $(4) char
# notice : char 'X' for space.
ifeq ($(origin xprint_value_str),undefined)
define xprint_value_str
$(call xprint_string_left,$(call string_strip,$(1)),$(if $(3),$(3),$(XPRINT_KEY_WIDTH)),$(if $(4),$(4),X)) : $(if $(2),$(call string_strip,$(2))," ")
endef
endif


# xprint_value
# $(1) key
# $(2) value
# $(3) color
# $(4) width of key
# $(5) char
# notice : char 'X' for space.
ifeq ($(origin xprint_value),undefined)
define xprint_value
$(call xprint_filled,$(strip $(3)),$(call xprint_value_str,$(call string_strip,$(1)),$(call string_strip,$(2)),$(4),$(5)),$(4),$(5))
endef
endif


# xprint_notice
# $(1) string
# $(2) color
# $(3) width of left
# $(4) char
# notice : char 'X' for space.
ifeq ($(origin xprint_notice),undefined)
define xprint_notice
$(call xprint_filled,$(if $(2),$(strip $(2)),$(XPRINT_INFO_COLOR)),$(call xprint_string_left,$(call string_strip,$(1)),$(strip $(3)),$(if $(4),$($(4)),X)),$(3),$(4))
endef
endif

