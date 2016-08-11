#include "WCDRootListController.h"

@implementation WCDRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"Root" target:self] retain];
	}

	return _specifiers;
}

- (void)openGitHubRepo {
	[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://github.com/JeziL/WeChatDice"]];
}

@end
