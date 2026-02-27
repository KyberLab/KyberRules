#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# XPrint Colors

COLOR_RESET					?= \033[0m

# Regular Colors
BLACK						?= \033[0;30m
RED							?= \033[0;31m
GREEN						?= \033[0;32m
YELLOW						?= \033[0;33m
BLUE						?= \033[0;34m
PURPLE						?= \033[0;35m
CYAN						?= \033[0;36m
WHITE						?= \033[0;37m

# Bold Colors
BBLACK						?= \033[1;30m
BRED						?= \033[1;31m
BGREEN						?= \033[1;32m
BYELLOW						?= \033[1;33m
BBLUE						?= \033[1;34m
BPURPLE						?= \033[1;35m
BCYAN						?= \033[1;36m
BWHITE						?= \033[1;37m

# Underline Colors
UBLACK						?= \033[4;30m
URED						?= \033[4;31m
UGREEN						?= \033[4;32m
UYELLOW						?= \033[4;33m
UBLUE						?= \033[4;34m
UPURPLE						?= \033[4;35m
UCYAN						?= \033[4;36m
UWHITE						?= \033[4;37m

# Background Colors
BG_BLACK					?= \033[40m
BG_RED						?= \033[41m
BG_GREEN					?= \033[42m
BG_YELLOW					?= \033[43m
BG_BLUE						?= \033[44m
BG_PURPLE					?= \033[45m
BG_CYAN						?= \033[46m
BG_WHITE					?= \033[47m

# High Intensity Colors
HI_BLACK					?= \033[0;90m
HI_RED						?= \033[0;91m
HI_GREEN					?= \033[0;92m
HI_YELLOW					?= \033[0;93m
HI_BLUE						?= \033[0;94m
HI_PURPLE					?= \033[0;95m
HI_CYAN						?= \033[0;96m
HI_WHITE					?= \033[0;97m

# Bold High Intensity Colors
BH_BLACK					?= \033[1;90m
BH_RED						?= \033[1;91m
BH_GREEN					?= \033[1;92m
BH_YELLOW					?= \033[1;93m
BH_BLUE						?= \033[1;94m
BH_PURPLE					?= \033[1;95m
BH_CYAN						?= \033[1;96m
BH_WHITE					?= \033[1;97m

# High Intensity Background Colors
HB_BLACK					?= \033[0;100m
HB_RED						?= \033[0;101m
HB_GREEN					?= \033[0;102m
HB_YELLOW					?= \033[0;103m
HB_BLUE						?= \033[0;104m
HB_PURPLE					?= \033[0;105m
HB_CYAN						?= \033[0;106m
HB_WHITE					?= \033[0;107m



###############################################################################
# XPrint Config

XPRINT_KEY_SHIFT			?= 4
XPRINT_KEY_WIDTH			?= 30
XPRINT_TOTAL_WIDTH			?= $(shell echo `TERM=xterm tput cols` - 2 | bc)

XPRINT_FILLED_CHAR			?= '='

XPRINT_TITLE_COLOR			?= $(HB_RED)
XPRINT_LINE_COLOR			?= $(HB_RED)
XPRINT_INFO_COLOR			?= $(HB_GREEN)
XPRINT_VALUE_COLOR			?= $(HB_BLUE)

