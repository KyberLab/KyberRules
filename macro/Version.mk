#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




RULES_VERSION				?= 1
RULES_SUBVERSION			?= 0
RULES_REVISION				?= 0

RULES_VERSION_DIGITS		?= 2


# version_convert
# $(1) version number
# $(2) default version number
# return : version number
ifeq ($(origin version_convert),undefined)
define version_convert
$(shell version=`echo $(1) | sed 's/[^0-9]*//g' | cut -c -$(RULES_VERSION_DIGITS) | tr -d " "`; if [ x$${version} != x ]; then echo \"$${version}\"; else echo $(2); fi)
endef
endif


# git_version_full
# $(1) git repo path
# return git version full string.
ifeq ($(origin git_version_full),undefined)
define git_version_full
$(if $(call file_is_exist,$(1)/.git),v$(RULES_VERSION).$(RULES_SUBVERSION).$(RULES_REVISION),$(shell git --git-dir=$(1)/.git describe --tags --always --dirty="-dirty"))
endef
endif


# git_version_main
# $(1) git version full string
# return git version main string.
ifeq ($(origin git_version_main),undefined)
define git_version_main
$(shell echo $(1) | awk -F "-" '{ print $$1}' | tr -d "v")
endef
endif


# git_version
# $(1) git version main string
# return git version string.
ifeq ($(origin git_version),undefined)
define git_version
$(call version_convert,$(shell echo $(1) | awk -F "." '{ print $$1}'),$(RULES_VERSION))
endef
endif


# git_subversion
# $(1) git version main string
# return git subversion string.
ifeq ($(origin git_subversion),undefined)
define git_subversion
$(call version_convert,$(shell echo $(1) | awk -F "." '{ print $$2}'),$(RULES_SUBVERSION))
endef
endif


# git_revision
# $(1) git version main string
# return git revision string.
ifeq ($(origin git_revision),undefined)
define git_revision
$(call version_convert,$(shell echo $(1) | awk -F "." '{ print $$3}'),$(RULES_REVISION))
endef
endif


# git_scmversion
# $(1) git version full string
# return git scm version string.
ifeq ($(origin git_scmversion),undefined)
define git_scmversion
$(shell echo $(1) | awk -F "-" '{print $$3}' | sed -e 's/^g//g')
endef
endif

