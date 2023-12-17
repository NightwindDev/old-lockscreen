# Sourced from https://gist.github.com/dlevi309/3da8d364556942fbd63acb52f3ecb866
TARGET = iphone:clang:latest:14.4
ARCHS = arm64 arm64e
INSTALL_TARGET_PROCESSES = SpringBoard

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = oldlockscreen

$(TWEAK_NAME)_FILES = Tweak.x
$(TWEAK_NAME)_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk