@interface CEmoticonWrap

	@property(nonatomic) unsigned int m_extFlag; // @synthesize m_extFlag;
	@property(retain, nonatomic) NSData *m_imageData; // @synthesize m_imageData;
	@property(retain, nonatomic) NSString *m_nsThumbImgUrl; // @synthesize m_nsThumbImgUrl;
	@property(retain, nonatomic) NSString *m_nsDesignerId; // @synthesize m_nsDesignerId;
	@property(nonatomic) unsigned int m_lastUsedTime; // @synthesize m_lastUsedTime;
	@property(retain, nonatomic) NSString *m_packageId; // @synthesize m_packageId;
	@property(retain, nonatomic) NSString *m_nsThumbImgPath; // @synthesize m_nsThumbImgPath;
	@property(retain, nonatomic) NSMutableDictionary *m_extInfo; // @synthesize m_extInfo;
	@property(retain, nonatomic) NSString *m_nsAppID; // @synthesize m_nsAppID;
	@property(nonatomic) unsigned int m_uiGameType; // @synthesize m_uiGameType;
	@property(nonatomic) _Bool m_bCanDelete; // @synthesize m_bCanDelete;
	@property(retain, nonatomic) NSString *m_nsMD5; // @synthesize m_nsMD5;
	@property(nonatomic) unsigned int m_uiType; // @synthesize m_uiType;

@end