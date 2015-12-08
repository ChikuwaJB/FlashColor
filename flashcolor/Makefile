ARCHS = armv7 arm64
GO_EASY_ON_ME=1
include theos/makefiles/common.mk

BUNDLE_NAME = FlashColor
FlashColor_FILES = FlashColor.mm
FlashColor_INSTALL_PATH = /Library/PreferenceBundles
FlashColor_FRAMEWORKS = UIKit
FlashColor_PRIVATE_FRAMEWORKS = Preferences
FlashColor_LIBRARIES = colorpicker

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/FlashColor.plist$(ECHO_END)
