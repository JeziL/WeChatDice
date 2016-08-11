THEOS_DEVICE_IP = localhost -p 2222
TARGET = iphone:9.3:8.0

FOR_RELEASE = 1

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeChatDice
WeChatDice_FILES = Tweak.xm WCDUserDefaultsMgr.mm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat Preferences"
SUBPROJECTS += wechatdicepb
include $(THEOS_MAKE_PATH)/aggregate.mk
