#import "headers/CEmoticonWrap.h"
#import "headers/CMessageWrap.h"
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

unsigned int _dicePoint = 6;

%hook BaseMsgContentLogicController

- (void)SendEmoticonMessage:(id)arg1 {
	CEmoticonWrap *wrap = (CEmoticonWrap *)arg1;
	NSLog(@"--------WCD-1: SendEmoticonMessage.----------");
	NSLog(@"m_uiGameType: %i", wrap.m_uiGameType);
	NSLog(@"m_extFlag: %i", wrap.m_extFlag);
	NSLog(@"m_imageData: %@", wrap.m_imageData);
	NSLog(@"m_nsMD5: %@", wrap.m_nsMD5);
	%orig;
}

%end

%hook GameController

- (void)sendGameMessage:(id)arg1 toUsr:(id)arg2 {
	CEmoticonWrap *wrap = (CEmoticonWrap *)arg1;
	NSLog(@"--------WCD-2: sendGameMessage.----------");
	NSLog(@"m_uiGameType: %i", wrap.m_uiGameType);
	NSLog(@"m_extFlag: %i", wrap.m_extFlag);
	NSLog(@"m_imageData: %@", wrap.m_imageData);
	NSLog(@"m_nsMD5: %@", wrap.m_nsMD5);
	%orig;
}

+ (id)getMD5ByGameContent:(unsigned int)arg1 {
	NSLog(@"--------WCD-3: getMD5ByGameContent.----------");
	if (arg1 > 3 && arg1 < 10) {
		NSLog(@"Is a dice.");
		if (_dicePoint != 0) {
			return %orig(_dicePoint + 3);
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
	NSLog(@"--------WCD-4: AddEmoticonMsg.----------");
	NSLog(@"m_uiGameType: %i", wrap.m_uiGameType);
	NSLog(@"m_uiGameContent: %i", wrap.m_uiGameContent);
	if (_dicePoint != 0) {
		%orig(arg1, setDice(wrap, _dicePoint));
	}
	else {
		%orig;
	}
}

%end

%hook CEmoticonUploadMgr

- (void)StartUpload:(id)arg1 {
	CMessageWrap *wrap = (CMessageWrap *)arg1;
	NSLog(@"--------WCD-5: StartUpload.----------");
	NSLog(@"m_uiGameType: %i", wrap.m_uiGameType);
	NSLog(@"m_uiGameContent: %i", wrap.m_uiGameContent);
	if (_dicePoint != 0) {
		%orig(setDice(wrap, _dicePoint));
	} else {
		%orig;
	}
}

%end