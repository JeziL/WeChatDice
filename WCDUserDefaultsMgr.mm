#import "headers/WCDUserDefaultsMgr.h"

@interface WCDUserDefaultsMgr (Private)

- (void)_preferencesChanged;

@end

static void preferencesChanged() {
	CFPreferencesAppSynchronize(CFSTR("com.wangjinli.wechatdicepb"));
	[[WCDUserDefaultsMgr sharedUserDefaults] _preferencesChanged];
}

@implementation WCDUserDefaultsMgr

+ (void)load {
	[self sharedUserDefaults];
}

+ (instancetype)sharedUserDefaults {
	NSLog(@"WCD: sharedUserDefaults.");
	static id sharedInstance = nil;
	sharedInstance = [self new];
	return sharedInstance;
}

- (id)init {
	if ((self = [super init])) {
		NSLog(@"WCD: Mgr init.");
		CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(),
										NULL,
										(CFNotificationCallback)preferencesChanged,
										CFSTR("com.wangjinli.wechatdicepb/prefsChanged"),
										NULL,
										CFNotificationSuspensionBehaviorDeliverImmediately);
		[self _preferencesChanged];
	}
	return self;
}

- (void)_preferencesChanged {
	NSDictionary *preferences = [[NSDictionary alloc] initWithContentsOfFile:@"/var/mobile/Library/Preferences/com.wangjinli.wechatdicepb.plist"];
	if (!preferences) {
		NSLog(@"WCD: Read preferences Error.");
		[self attemptSettingFallbackPrefs];
	}
	NSLog(@"WCD: ------Start Read Prefs.-------");
	_diceEnabled = preferences[@"DiceEnabled"] ? [(NSNumber *)preferences[@"DiceEnabled"] boolValue] : YES;
	_jsbEnabled = preferences[@"JsbEnabled"] ? [(NSNumber *)preferences[@"JsbEnabled"] boolValue] : NO;
	_dicePoint = preferences[@"DicePoint"] ? [(NSNumber *)preferences[@"DicePoint"] intValue] : 6;
	_jsbType = preferences[@"JsbType"] ? [(NSNumber *)preferences[@"JsbType"] intValue] : 1;
	NSLog(@"WCD: Read Complete. %d, %d, %i, %i", _diceEnabled, _jsbEnabled, _dicePoint, _jsbType);
}

- (void)attemptSettingFallbackPrefs {
	_diceEnabled = YES;
	_jsbEnabled = NO;
	_dicePoint = 6;
	_jsbType = 1;
}

@end