#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# Path Format : 
#   1. path - file_src=path, file_dst=path, file_perm=<empty>
#   2. src:dst - file_src=src, file_dst=dst, file_perm=<empty>
#   3. src:dst:perm - file_src=src, file_dst=dst, file_perm=perm


# file_src
# $(1) file name - format <name/src:dst:perm>
# return : source file name
ifeq ($(origin file_src),undefined)
define file_src
$(shell echo $(1) | awk -F ":" '{print $$1}')
endef
endif


# file_dst
# $(1) file name - format <name/src:dst:perm>
# return : destination file name
ifeq ($(origin file_dst),undefined)
define file_dst
$(shell echo $(1) | awk -F ":" 'NF==1 {print $$1} NF>=2 {print $$2}')
endef
endif


# file_perm
# $(1) file name - format <name/old:new:perm>
# return : permission
ifeq ($(origin file_perm),undefined)
define file_perm
$(shell echo $(1) | awk -F ":" 'NF==3 {print $$3}')
endef
endif


# file_copy
# $(1) src
# $(2) dst
ifeq ($(origin file_copy),undefined)
define file_copy
bash -c "cp -rfv $(1) $(2)"
endef
endif
# $(if $(shell [ -d $(2) ]; echo $$? | grep 0),yes,no)


# file_install
# $(1) src file
# $(2) dst file
# $(3) file perm
# $(4) log file
ifeq ($(origin file_install),undefined)
define file_install
install -pvD -m $(if $(3),$(3),0664) $(1) $(2) $(if $(4),&& echo $(1) $(2) $(3) >> $(4))
endef
endif


# file_installx_dir
# $(1) src dir
# $(2) dst dir
# $(3) file perm
# $(4) log file
ifeq ($(origin file_installx_dir),undefined)
define file_installx_dir
cd $(1) && find . -type f | sed 's/^\.\///g' | xargs -i bash -c "$(call file_install,$(1)/{},$(2)/{},$(3),$(4))"
endef
endif


# file_installx_helper
# $(1) src root
# $(2) src file
# $(3) dst root
# $(4) dst file
# $(5) perm
# $(6) log file
ifeq ($(origin file_installx_helper),undefined)
define file_installx_helper
if [ -d $(1)/$(2) ] ; then cd $(1)/$(2) && $(call file_installx_dir,$(1)/$(2),$(3)/$(4),$(5),$(6)); else $(call file_install,$(1)/$(2),$(3)/$(4),$(5),$(6)); fi
endef
endif


# file_installx
# $(1) path - path/src:dst
# $(2) file - src:dst:perm
# $(3) log file
ifeq ($(origin file_installx),undefined)
define file_installx
$(call file_installx_helper,$(call file_src,$(1)),$(call file_src,$(2)),$(call file_dst,$(1)),$(call file_dst,$(2)),$(call file_perm,$(2)),$(3))
endef
endif

