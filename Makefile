export THEOS_DEVICE_IP=localhost -p 2222
export TARGET = iphone:10.1:10.1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = BlackKeyboard
BlackKeyboard_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 SpringBoard"
