#import "headers/CEmoticonWrap.h"
#import "headers/CMessageWrap.h"
#import "headers/WCDUserDefaultsMgr.h"
#import <UIKit/UIKit.h>

CMessageWrap *setDice(CMessageWrap *wrap, unsigned int point) {
	if (wrap.m_uiGameType == 2) {
		wrap.m_uiGameContent = point + 3;
	}
	return wrap;
}

CMessageWrap *setJsb(CMessageWrap *wrap, unsigned int type) {
	if (wrap.m_uiGameType == 1) {
		wrap.m_uiGameContent = type;
	}
	return wrap;
}

WCDUserDefaultsMgr *prefs = nil;

%hook GameController

+ (id)getMD5ByGameContent:(unsigned int)arg1 {
	prefs = [WCDUserDefaultsMgr sharedUserDefaults];
	if (arg1 > 3 && arg1 < 10) {
		if (prefs.diceEnabled) {
			return %orig(prefs.dicePoint + 3);
		} else {
			return %orig;
		}
	} else if (arg1 > 0 && arg1 < 4) {
		if (prefs.jsbEnabled) {
			return %orig(prefs.jsbType);
		} else {
			return %orig;
		}
	} else {
		return %orig;
	}
}

%end

%hook CMessageMgr

- (void)AddEmoticonMsg:(id)arg1 MsgWrap:(id)arg2 {
	CMessageWrap *wrap = (CMessageWrap *)arg2;
	if (prefs == nil) { prefs = [WCDUserDefaultsMgr sharedUserDefaults]; }
	if (wrap.m_uiGameType == 2) {
		if (prefs.diceEnabled) {
			%orig(arg1, setDice(arg2, prefs.dicePoint));
		} else {
			%orig;
		}
	} else if (wrap.m_uiGameType == 1) {
		if (prefs.jsbEnabled) {
			%orig(arg1, setJsb(arg2, prefs.jsbType));
		} else {
			%orig;
		}
	} else {
		%orig;
	}
}

%end

%hook CEmoticonUploadMgr

- (void)StartUpload:(id)arg1 {
	CMessageWrap *wrap = (CMessageWrap *)arg1;
	if (prefs == nil) { prefs = [WCDUserDefaultsMgr sharedUserDefaults]; }
	if (wrap.m_uiGameType == 2) {
		if (prefs.diceEnabled) {
			%orig(setDice(arg1, prefs.dicePoint));
		} else {
			%orig;
		}
	} else if (wrap.m_uiGameType == 1) {
		if (prefs.jsbEnabled) {
			%orig(setJsb(arg1, prefs.jsbType));
		} else {
			%orig;
		}
	} else {
		%orig;
	}
}

%end