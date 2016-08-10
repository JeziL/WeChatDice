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
	static id sharedInstance = nil;
	static dispatch_once_t token = 0;
	dispatch_once(&token, ^{
		sharedInstance = [self new];
	});
	return sharedInstance;
}

- (id)init {
	if ((self = [super init])) {
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

- (void)preferencesChanged {
	CFStringRef appId = CFSTR("com.wangjinli.wechatdicepb");
	CFArrayRef keyList = CFPreferencesCopyKeyList(appId, kCFPreferencesCurrentUser, kCFPreferencesAnyHost);
	if (!keyList) {
		[self attemptSettingFallbackPrefs];
		return;
	}
	NSDictionary *preferences = (NSDictionary *)CFBridgingRelease(CFPreferencesCopyMultiple(keyList, appId, kCFPreferencesCurrentUser, kCFPreferencesAnyHost));
	CFRelease(keyList);
	if (!preferences) {
		[self attemptSettingFallbackPrefs];
	}
	_diceEnabled = preferences[@"DiceEnabled"] ? [(NSNumber *)preferences[@"DiceEnabled"] boolValue] : YES;
	_jsbEnabled = preferences[@"JsbEnabled"] ? [(NSNumber *)preferences[@"JsbEnabled"] boolValue] : NO;
	_dicePoint = preferences[@"DicePoint"] ? [(NSNumber *)preferences[@"DicePoint"] intValue] : 6;
	_jsbType = preferences[@"JsbType"] ? [(NSNumber *)preferences[@"JsbType"] intValue] : 1;
}

- (void)attemptSettingFallbackPrefs {
	_diceEnabled = YES;
	_jsbEnabled = NO;
	_dicePoint = 6;
	_jsbType = 1;
}

@end