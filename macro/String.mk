#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# string_len
# $(1) string
# return : length of the string
ifeq ($(origin string_len),undefined)
define string_len
$(shell echo -n \"$(1)\" | tr ' ' 'x' | wc -m | xargs -i echo {} - 2 | bc)
endef
endif


# string_to_lower
# $(1) string
# return : lower case string
ifeq ($(origin string_to_lower),undefined)
define string_to_lower
$(shell echo $(1) | tr '[:upper:]' '[:lower:]')
endef
endif


# string_to_upper
# $(1) string
# return : upper case string
ifeq ($(origin string_to_upper),undefined)
define string_to_upper
$(shell echo $(1) | tr '[:lower:]' '[:upper:]')
endef
endif


# string_to_camel
# $(1) string
# return : camel case string
ifeq ($(origin string_to_camel),undefined)
define string_to_camel
$(shell echo $(1) | sed 's/.*/\u&/')
endef
endif


# string_strip
# $(1) string
# return : string of trimmed string
# notice : trim tab char to space char.
ifeq ($(origin string_strip),undefined)
define string_strip
$(strip $(shell echo $(1) | tr '\t' ' '))
endef
endif


# char_repeat
# $(1) char to repeat
# $(2) repeat number
# notice : char 'X' for space.
# return : repeated string
ifeq ($(origin char_repeat),undefined)
define char_repeat
$(shell echo $(foreach n,$(shell seq -s ' ' 1 $(2)),$(1)) | tr -d ' ' | tr 'X' ' ')
endef
endif
