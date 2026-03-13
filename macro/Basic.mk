#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# file_is_exist
# $(1) file
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


# newline
ifeq ($(origin newline),undefined)
define newline

endef
endif


# is_in_docker
# return : empty if in docker
ifeq ($(origin is_in_docker),undefined)
define is_in_docker
$(strip $(shell echo -n `[ ! -f /.dockerenv ]` $$? | grep -v 1))
endef
endif

