#import <Preferences/Preferences.h>
#import <libcolorpicker/libcolorpicker.h>
@interface FlashColorListController: PSListController {
}
@end

@implementation FlashColorListController
- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"FlashColor" target:self] retain];
	}
	return _specifiers;
}
-(void)donate{
[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://www.coinbase.com/checkouts/958f129240d7888c0e28d1a2e4179530"]];
	[[UIApplication sharedApplication] applicationOpenURL:[NSURL URLWithString:@"https://www.coinbase.com/checkouts/958f129240d7888c0e28d1a2e4179530"]];
}
- (void)viewWillAppear:(BOOL)animated
{
	[self clearCache];
	[self reload];
	[super viewWillAppear:animated];
	UIColor *color=[UIColor redColor];
	[[UISwitch appearance] setOnTintColor:color];

	 self.navigationController.navigationBar.tintColor = color;
	 self.navigationController.navigationController.navigationBar.tintColor = color;
}
- (void)selectflashColor
{
	NSMutableDictionary *prefsDict = [NSMutableDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist"];
	if (!prefsDict) prefsDict = [NSMutableDictionary dictionary];
				NSString *readFromKey = @"someCoolKey";
				NSString *fallbackHex = @"#ff0000";  // (You want to load from prefs probably)
	    UIColor *startColor = LCPParseColorString([prefsDict objectForKey:@"Color"], fallbackHex); // this color will be used at startup
	    PFColorAlert *alert = [PFColorAlert colorAlertWithStartColor:startColor showAlpha:YES];
	    [alert displayWithCompletion:
	    ^void (UIColor *pickedColor){
				NSString *hexString = [UIColor hexFromColor:pickedColor];
				[prefsDict setObject:hexString forKey:@"Color"];
				[prefsDict writeToFile:@"/var/mobile/Library/Preferences/com.chikuwa.flashcolor.plist" atomically:YES];
	    }];
}
- (void)viewWillDisappear:(BOOL)animated {
	self.navigationController.navigationBar.tintColor =nil;
	self.navigationController.navigationController.navigationBar.tintColor = nil;
	[[UISwitch appearance] setOnTintColor:nil];
}
- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}
-(void)runflash{
	CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), CFSTR("com.chikuwa.flashcolor/runflash"), NULL,NULL, TRUE);
}
@end

// vim:ft=objc
