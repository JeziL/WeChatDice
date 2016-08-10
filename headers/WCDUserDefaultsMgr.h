#import <objc/runtime.h>

@interface WCDUserDefaultsMgr: NSObject

@property (nonatomic, assign, readonly) BOOL diceEnabled;
@property (nonatomic, assign, readonly) BOOL jsbEnabled;
@property (nonatomic, assign, readonly) unsigned int dicePoint;
@property (nonatomic, assign, readonly) unsigned int jsbType;

+ (instancetype)sharedUserDefaults;

@end