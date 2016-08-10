#import <objc/runtime.h>

@interface WCDUserDefaultsMgr: NSObject

@property (nonatomic, assign, readonly) BOOL diceEnabled;
@property (nonatomic, assign, readonly) BOOL jsbEnabled;
@property (nonatomic, assign, readonly) NSInteger dicePoint;
@property (nonatomic, assign, readonly) NSInteger jsbType;

+ (instancetype)sharedUserDefaults;

@end