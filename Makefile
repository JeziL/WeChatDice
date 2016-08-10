THEOS_DEVICE_IP = localhost -p 2222
TARGET = iphone:9.3:8.0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = WeChatDice
WeChatDice_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 WeChat"
SUBPROJECTS += wechatdicepb
include $(THEOS_MAKE_PATH)/aggregate.mk
