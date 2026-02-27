#                                 KyberBench
# Copyright (c) 2025-2026, Kyber Development Team, all right reserved.
#





BUILD_TYPE_NUM				?= 3


BUILD_TYPE_STR				?= test

ifeq ($(BUILD_TYPE_STR),release)
BUILD_TYPE_NUM				?= 0
endif

ifeq ($(BUILD_TYPE_STR),debug)
BUILD_TYPE_NUM				?= 1
endif

ifeq ($(BUILD_TYPE_STR),perf)
BUILD_TYPE_NUM				?= 2
endif

ifeq ($(BUILD_TYPE_STR),test)
BUILD_TYPE_NUM				?= 3
endif

ifeq ($(BUILD_TYPE_STR),trial)
BUILD_TYPE_NUM				?= 4
endif


