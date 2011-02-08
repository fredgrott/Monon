LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_MODULE    := MononNative
### Add all source file names to be included in lib separated by a whitespace
LOCAL_SRC_FILES := MononNative.cpp

include $(BUILD_SHARED_LIBRARY)
