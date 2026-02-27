#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#




###############################################################################
# Basic Echo Config

ifeq ($(call is_in_docker),)
ECHO						?= echo -e
else
ECHO						?= echo
endif



###############################################################################
# Basic Verbose Config

V							?=



###############################################################################
# Image Verbose Config

IV							?=



###############################################################################
# Default Verbose Definition

Q							:= @
MAKE						:= make -s
SCONS						:= scons

IQ							:= $(Q)



###############################################################################

ifneq ($(V),)

IV							:= 1
Q							:= 
IQ							:= $(Q)

MAKE						:= make
SCONS						:= scons --verbose

else

ifneq ($(IV),)
IQ							:= 
endif

endif


override MAKEFLAGS=

