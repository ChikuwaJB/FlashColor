#import <libcolorpicker/libcolorpicker.h>
static NSMutableDictionary *settings;
static BOOL Enable;
void refreshPrefs()
{
	[settings release];
	settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist"]; //Load settings the old way.
	Enable=[settings objectForKey:@"Enable"] ? [[settings objectForKey:@"Enable"] boolValue] : YES;
}
void notificationCallback (CFNotificationCenterRef center,void * observer,CFStringRef name,const void * object,CFDictionaryRef userInfo) {
	[[[%c(SBScreenFlash) mainScreenFlasher] initWithScreen:[UIScreen mainScreen]] flashWhiteWithCompletion:nil];
}
static void PreferencesChangedCallback(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	refreshPrefs();
}
%hook SBScreenFlash
- (void)_createUIWithColor:(id)arg1{
	if(Enable){
		refreshPrefs();
		%orig(LCPParseColorString([settings objectForKey:@"Color"], @"#FFFFFF"));
	}else{
		%orig;
	}
}
- (void)flashColor:(id)arg1 withCompletion:(id)arg2{
	if(Enable){
		refreshPrefs();
		%orig(LCPParseColorString([settings objectForKey:@"Color"], @"#FFFFFF"),arg2);
	}else{
		%orig;
	}
}
%end

%ctor {
	@autoreleasepool {
		settings = [[NSMutableDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist"];
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) PreferencesChangedCallback, CFSTR("com.chikuwa.flashcolor/r"), NULL, CFNotificationSuspensionBehaviorCoalesce);
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, notificationCallback, CFSTR("com.chikuwa.flashcolor/runflash"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
		refreshPrefs();
		Enable=[settings objectForKey:@"Enable"] ? [[settings objectForKey:@"Enable"] boolValue] : YES;
		%init;
	}
}