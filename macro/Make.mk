#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




# make_cmd_vars_helper
# $(1) make command variables helper
# return : make command variables helper
#
# Example 1:
# origin : A=1 2 B=test C=foo bar baz
# return : A="1 2" B=test C="foo bar baz"
# Example 2:
# origin : X=yyy --zzz uuu www-- g-gg zz_uu _yy yy_ A=1 2 B=test C=foo bar baz
# return : X="yyy --zzz uuu www-- g-gg zz_uu _yy yy_" A="1 2" B=test C="foo bar baz"
ifeq ($(origin make_cmd_vars_helper),undefined)
define make_cmd_vars_helper
$(shell echo '$1' | awk '{
    i = 1;
    while (i <= NF) {
        if ($$i ~ /=/) {
            if (var) {
                if (value) {
                    if (value ~ / /) {
                        printf "%s=\"%s\" ", var, value;
                    } else {
                        printf "%s=%s ", var, value;
                    }
                } else {
                    printf "%s ", var;
                }
            }
            split($$i, a, "=");
            var = a[1];
            value = substr($$i, index($$i, "=") + 1);
            i++;
        } else {
            if (var) {
                value = value " " $$i;
                i++;
            } else {
                i++;
            }
        }
    }
    if (var) {
        if (value) {
            if (value ~ / /) {
                printf "%s=\"%s\"", var, value;
            } else {
                printf "%s=%s", var, value;
            }
        } else {
            printf "%s", var;
        }
    }
}')
endef
endif


# make_cmd_vars
# return : make command variables
ifeq ($(origin make_cmd_vars),undefined)
define make_cmd_vars
$(call string_kv_dedup,$(foreach var,$(call make_cmd_vars_helper,$(shell ps -o args= -p $$(ps -o ppid= -p $$$$) | sed 's/make//g' | sed 's/$(MAKECMDGOALS)//g')),$(if $(shell echo $(var) | grep =),$(var),$(patsubst %,%=,$(var)))))
endef
endif

