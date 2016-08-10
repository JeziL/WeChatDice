@interface CMessageWrap

	// Remaining properties
	@property(retain, nonatomic) NSString *m_aesKey; // @dynamic m_aesKey;
	@property(nonatomic) _Bool m_bShowRewardTips; // @dynamic m_bShowRewardTips;
	@property(retain, nonatomic) NSString *m_cdnUrlString; // @dynamic m_cdnUrlString;
	@property(retain, nonatomic) NSString *m_encryptUrlString; // @dynamic m_encryptUrlString;
	@property(retain, nonatomic) NSString *m_nsDesignerId; // @dynamic m_nsDesignerId;
	@property(copy, nonatomic) NSString *m_nsEmoticonBelongToProductID; // @dynamic m_nsEmoticonBelongToProductID;
	@property(retain, nonatomic) NSString *m_nsThumbImgUrl; // @dynamic m_nsThumbImgUrl;
	@property(nonatomic) unsigned int m_uiEmoticonHeight; // @dynamic m_uiEmoticonHeight;
	@property(nonatomic) unsigned int m_uiEmoticonType; // @dynamic m_uiEmoticonType;
	@property(nonatomic) unsigned int m_uiEmoticonWidth; // @dynamic m_uiEmoticonWidth;
	@property(nonatomic) unsigned int m_uiGameContent; // @dynamic m_uiGameContent;
	@property(nonatomic) unsigned int m_uiGameType; // @dynamic m_uiGameType;
	
@end