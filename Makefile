ARCHS = armv7 arm64
GO_EASY_ON_ME=1
PACKAGE_VERSION = $(THEOS_PACKAGE_BASE_VERSION)

THEOS_PACKAGE_DIR_NAME = debs
include theos/makefiles/common.mk

TWEAK_NAME = FlashColor
FlashColor_FILES = Tweak.xm
FlashColor_LIBRARIES = colorpicker
FlashColor_FRAMEWORKS=UIKit
include $(THEOS_MAKE_PATH)/tweak.mk
internal-stage::
	find _ -name "*.plist" -print0 | xargs -0 plutil -convert binary1

after-install::
	#install.exec "dpkg -r com.chikuwa.foreverflashlight"
	#install.exec "killall -9 SpringBoard"
SUBPROJECTS += flashcolor
include $(THEOS_MAKE_PATH)/aggregate.mk
