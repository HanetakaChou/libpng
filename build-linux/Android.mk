#
# Copyright (C) YuqiaoZhang(HanetakaChou)
# 
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU Lesser General Public License as published
# by the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU Lesser General Public License for more details.
# 
# You should have received a copy of the GNU Lesser General Public License
# along with this program.  If not, see <https://www.gnu.org/licenses/>.
#

# https://developer.android.com/ndk/guides/android_mk

LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE := png

LOCAL_SRC_FILES := \
	$(LOCAL_PATH)/../intel/filter_sse2_intrinsics.c \
	$(LOCAL_PATH)/../intel/intel_init.c \
	$(LOCAL_PATH)/../png.c \
	$(LOCAL_PATH)/../pngerror.c \
	$(LOCAL_PATH)/../pngget.c \
	$(LOCAL_PATH)/../pngmem.c \
	$(LOCAL_PATH)/../pngpread.c \
	$(LOCAL_PATH)/../pngread.c \
	$(LOCAL_PATH)/../pngrio.c \
	$(LOCAL_PATH)/../pngrtran.c \
	$(LOCAL_PATH)/../pngrutil.c \
	$(LOCAL_PATH)/../pngset.c \
	$(LOCAL_PATH)/../pngtrans.c \
	$(LOCAL_PATH)/../pngwio.c \
	$(LOCAL_PATH)/../pngwrite.c \
	$(LOCAL_PATH)/../pngwtran.c \
	$(LOCAL_PATH)/../pngwutil.c

LOCAL_CFLAGS :=

ifeq (armeabi-v7a,$(TARGET_ARCH_ABI))
LOCAL_ARM_MODE := arm
LOCAL_ARM_NEON := true
else ifeq (arm64-v8a,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS +=
else ifeq (x86,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else ifeq (x86_64,$(TARGET_ARCH_ABI))
LOCAL_CFLAGS += -mf16c
LOCAL_CFLAGS += -mfma
LOCAL_CFLAGS += -mavx2
else
LOCAL_CFLAGS +=
endif

LOCAL_CFLAGS += -Wall
LOCAL_CFLAGS += -Werror=return-type

LOCAL_CFLAGS += -DPNG_INTEL_SSE_OPT=1

LOCAL_C_INCLUDES :=

LOCAL_CPPFLAGS := 
LOCAL_CPPFLAGS += -std=c++20

LOCAL_LDFLAGS :=
LOCAL_LDFLAGS += -Wl,--enable-new-dtags
LOCAL_LDFLAGS += -Wl,-rpath,\$$ORIGIN
LOCAL_LDFLAGS += -Wl,--version-script,$(LOCAL_PATH)/png.map
LOCAL_LDFLAGS += -lm

LOCAL_STATIC_LIBRARIES :=
LOCAL_STATIC_LIBRARIES += zlib

include $(BUILD_SHARED_LIBRARY)
