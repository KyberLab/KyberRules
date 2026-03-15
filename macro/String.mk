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


# string_escape_double_quotes
# $(1) string
# return : escaped string
# Support multiple levels of escaping
define string_escape_double_quotes
$(shell echo '$1' | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')
endef


# string_kv_dedup
# $(1) string containing key=value pairs (space-separated)
# return : string with duplicate keys removed, keeping the last occurrence
# Handles quoted values with spaces (e.g., KEY="value with spaces")
define string_kv_dedup
$(shell printf '%s' '$(1)' | awk -v RS='' -v ORS='' '
{
    n = split($$0, parts, " ");
    in_quote = 0;
    kv_count = 0;
    current = "";
    for (i = 1; i <= n; i++) {
        if (current == "") {
            current = parts[i];
        } else {
            current = current " " parts[i];
        }
        quote_count = 0;
        for (j = 1; j <= length(parts[i]); j++) {
            if (substr(parts[i], j, 1) == "\"") {
                quote_count++;
            }
        }
        if (quote_count % 2 == 1) {
            in_quote = !in_quote;
        }
        if (!in_quote) {
            kv_count++;
            kv[kv_count] = current;
            eq = index(current, "=");
            if (eq > 0) {
                key = substr(current, 1, eq - 1);
            }
            current = "";
        }
    }
    if (current != "") {
        kv_count++;
        kv[kv_count] = current;
    }
    delete outputted;
    result = "";
    for (i = kv_count; i >= 1; i--) {
        eq = index(kv[i], "=");
        if (eq > 0) {
            key = substr(kv[i], 1, eq - 1);
            if (!(key in outputted)) {
                if (result != "") {
                    result = kv[i] " " result;
                } else {
                    result = kv[i];
                }
                outputted[key] = 1;
            }
        }
    }
    print result;
}')
endef

