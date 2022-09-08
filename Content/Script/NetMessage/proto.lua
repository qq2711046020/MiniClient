return [[syntax="proto3";

enum err_type
{
	Success							= 0; // 成功
	Fail							= 1; // 错误（一个通用错误，一般不会发给客户端）
	RpcNoHandler					= 2; // rpc调用时没有找到协议处理函数（只会在程序有bug才会出现）
	RpcTimeout						= 3; // rpc调用超时（请求消息发出后没有在规定时间内收到应答消息）
	ArgError						= 4; // 参数错误（请求消息少参数或参数非法等）
	InvalidZoneId					= 5; // 区id非法
	MailNotExist					= 6; // 邮件不存在
	ExistPlayer						= 7; // 玩家已经存在
	GeneratePlayerIdFailed			= 8; // 生成玩家id失败
	NoPlayer						= 9; // 该角色不存在
	NameExists						= 10; // 有其他玩家使用了这个名字
	DbError							= 11; // 数据库错误
	NotFindUser						= 12; // 没有找到 User（服务器网络异常或有bug才会出现此错误）
	NotFindPlayer					= 13; // 没有找到玩家
	PlayerStateNotGaming			= 14; // 玩家不在游戏状态
	HasNotAffix						= 15; // 没有附件
	AffixAlreadyTake				= 16; // 附件已被领取
	PlayerAlreadyOnline				= 17; // Player 已经在线（服务器网络异常或有bug才会出现此错误）
	NotFindConfig					= 18; // 没有找到需要的策划表格数据（有bug时才会出现此错误）
	AlreadyInGroup					= 19; // 已在队伍中
	GroupNotFound					= 20; // 目标队伍不存在
	GroupAlreadyRequested			= 21; // 已经申请过该队伍
	GroupPermitionDeny				= 22; // 操作不允许
	NotInGroup						= 23; // 不再队伍中
	GroupSystemError				= 24; // 服务器队伍系统错误
	GroupJoinNotFound				= 25; // 没有找到相应的队伍请求
	TargetAlreadyInGroup			= 26; // 目标已在队伍中
	InviteAlreadyExisted			= 27; // 已经邀请过该人员
	GroupFull						= 28; // 队伍成员已满
	ChatChannelIdNotExist			= 29; // 聊天频道id不存在
	UserNotExist					= 30; // 用户不存在
	ChatMsgIsInvalid				= 31; // 聊天发送的消息无效
	MainlandIsInvalid				= 32; // 大陆兵团id不存在
	PlayerNotInTheChannelId 		= 33; // channel id与玩家所属channel id不符
	PlayerIdIsWrong 				= 34; // 玩家发送的player id错误
	NeedQueryPlayerList				= 35; // 需要先查询玩家列表
	NotInPlayerList					= 36; // 不在玩家列表中
	PlayerCountLimit				= 37; // 角色数量上限
	InviteNotFound					= 38; // 邀请数据不存在
	HadAlreadInTheChannelId 		= 39; // 目标已在聊天频道中
	PlayerNameEmpty					= 40; // 玩家名字为空
	SameAsOriginalName				= 41; // 和原名字相同
	MaxNameLength					= 42; // 名字超长
	MinNameLength					= 43; // 名字过短
	ItemNotExist					= 44; // 物品不存在
	EquipSlotInvalid				= 45; // 装备槽位类型错误
	ItemNotEquip					= 46; // 该物品不是装备
	PlayerLevelNotEnough			= 47; // 玩家等级不足
	ConchNotEnough					= 48; // 贝壳不足
	StarfishNotEnough				= 49; // 海星不足
	PearlNotEnough					= 50; // 珍珠不足
	HadAlreadyAttention				= 51; // 已经关注过该好友
	AttentionListFull				= 52; // 关注列表满了，没法关注他喽。
	HasNotAttention					= 53; // 已经关注过该好友
	MaxIntensifylevel				= 54; // 装备为最大强化等级
	MaterialNotEquip				= 55; // 材料不是装备
	MaterialLevelNotMatch			= 56; // 装备等级和材料等级不相等
	EquipMaterialSome				= 57; // 装备和强化材料是同一个物品
	EquipMaterialTemplateNotSome	= 58; // 装备和强化材料物品模板id不相同
	MaterialNotExist				= 59; // 材料不存在
	MaterialWear					= 60; // 不能用穿在身上的装备作为材料
	ItemNotEnough					= 61; // 物品不足
	IntensifylevelInvalid			= 62; // 强化等级非法
	DoNotHaveTheCommodity			= 63; // 没有该商品
	HadAlreadBuyTheCommodity		= 64; // 已经购买过该商品
	TheChannelIsFull				= 65; // 选择的频道爆满
	HadAlreadyChangeProfession		= 66; // 已经转职，进阶职业配置表不应有两个选择
	MaybeAdvanceFull				= 67; // 进阶满级或者配置错误
	AdvanceConditionNotEnough		= 68; // 进阶条件不满足
	ChangeProfessionIdError			= 69; // 选择进阶的职业id错误
	HadAlreadyInTheProfessionBranch = 70; // 已经在选择的职业分支
	TalentPointIsFull				= 71; // 天赋点已满
	NeedPointNotFull				= 72; // 需求总点数不足
	NotFindQuest					= 73; // 没有找到任务
	InitProfessionIllegality		= 74; // 初始职业非法
	QuestRewardIndexInvalid			= 75; // 任务奖励索引无效
	QuestNotComplete				= 76; // 任务未完成
	DailyScoreNotEnough				= 77; // 每日任务积分不足
	WeekScoreNotEnough				= 78; // 每周任务积分不足
	WishpoolRewardIdInvalid			= 79; // 祈福奖励id非法
	WishpoolCoinNotEnough			= 80; // 祈福币不足
	NotHaveWishpoolTarget			= 81; // 没有设置祈福目标
	WishpoolRewardIndexInvalid		= 82; // 祈福奖励索引无效
	WishpoolScoreNotEnough			= 83; // 祈福分不足
	RewardAlreadyTake				= 84; // 奖励已领取
	WishpoolScoreFull				= 85; // 祈福分已满
	EquipSlotNotMatch				= 86; // 装备槽位不匹配
	ProfessionNotMatch				= 87; // 职业不匹配
	TalentPointsNotEnough			= 88; // 天赋点不足
	ProfessionIdError				= 89; // 选择的分支ProfessionId错误
	HadNotChangeProfession			= 90; // 还未进行转职
	TalentIdError					= 91; // 选择的天赋id错误
	KickSessionBySomeUserLogin		= 92; // 有人登入同一个账号，造成踢用户下线
	NotFindSkillConfigure			= 93; // 没有找到技能配置
	NotFindSkillSlot				= 94; // 没有找到技能槽
	SkillSlotInvalid				= 95; // 技能槽位非法
	NotFindSkill					= 96; // 没有找到技能
	SkillExpFull					= 97; // 技能经验已满
	ItemNotSkillCard				= 98; // 物品不是技能卡
	SkillLevelNotFull				= 99; // 技能等级未满
	SkilStarlLevelFull				= 100; // 技能星级已满
	SkillExpNotFull					= 101; // 技能经验没满
	TheTypeOfPetFoodCatchIsError	= 102; // 美食捕捉类型错误
	ResidueAttPointNotEnough		= 103; // 剩余技能点不足
	ExceedAttrPointLimit			= 104; // 超过属性点最大加点限制
	NotInPetFoodCatching			= 105; // 不在美食捕捉进行中（宠物）
	IsNotCatchTime					= 106; // 还未到捕捉时间
	NotFoundConfigByFoodId			= 107; // 根据美食id没有找到数据
	DoNotNeedSpeedUp				= 108; // 宠物捕捉不需要加速
	DoNotHavePetMeetTheConditions	= 109; // 没有符合条件的宠物
	FeastCatchTicketIsNotEnough		= 110; // 盛宴捕捉券不足
	DoNotReachPutFoodTime			= 111; // 还没到投放美食的时间
	SlotIdOfPastureError			= 112; // 牧场的围栏Id错误
	UnlockThePreviousPetSlotFirst	= 113; // 请先解锁上一个宠物栏
	HadNotUnlockTheFence			= 114; // 还没解锁此宠物栏
	DoNotHaveThePet					= 115; // 不拥有此放置的宠物
	ThePetRaceMismatch				= 116; // 放置的宠物种族不匹配
	ThePetMainTalentMismatch		= 117; // 放置的宠物主资质不匹配
	PropertiesRequireMismatch		= 118; // 放置的宠物属性要求不匹配
	HadAlreadBuild					= 119; // 宠物栏已经建造过了
	PlaceSamePetToFence				= 120; // 放置了同一个宠物
	ThePetHadAlreadyFighting		= 121; // 此宠物已经在出战中
	HadNotPetFighting				= 122; // 没有宠物出战中
	IncludeDoNotExistPet			= 123; // 包含不存在的宠物
	IncludePetHadLock				= 124; // 包含已上锁的宠物
	IncludeFightingPet				= 125; // 包含出战中的宠物
	BeyondReleaseQuality			= 126; // 超出放生品质
	ThePetHadAlreadyLock			= 127; // 该宠物已经上锁
	ThePetHadAlreadyUnlock			= 128; // 该宠物已经解锁
	TheMaterialPetStarIsMismatch	= 129; // 所选的升星材料宠物星级不匹配
	TheMaterialPetIsGrazing			= 130; // 所选的升星材料宠物在牧场中
	TheMaterialPetIsBattling		= 131; // 所选的升星材料宠物正在出战
	TheMaterialPetIsClock			= 132; // 所选的升星材料宠物已上锁
	TheMaterialPetNotFound			= 133; // 所选的升星材料宠物未找到
	CurrentStarCanNotFall			= 134; // 宠物的当前星级不允许降级
	TheMasterPetQualityIsNotEnough	= 135; // 所选的升星宠物品质不够
	TheMasterPetQualityIsMismatch	= 136; // 所选的升星材料宠物品质不匹配
	TheStarLevelAlreadyEnoungh		= 137; // 所选的升星宠物已满级
	HaveInvalidPetTemplateId		= 138; // 传入非法的宠物模板id
	HaveStrengthOfPetIsNotEnough	= 139; // 存在宠物体力不足
	TheAdventureIdIsInvalid			= 140; // 传入的探索点存在无效
	AdventureNotStartCanNotCancel	= 150; // 探险未开始，无法取消
	AdventureNotStartCanNotSpeedUp	= 151; // 探险未开始，无法加速
	AdventureDoNotNeedSppedUp		= 152; // 此时探险不需要加速
	AdventureStatusCanNotRefresh	= 153; // 探险状态不允许刷新
	ThePetStrengthIsEnough			= 154; // 该宠物体力已满
	DoNotReachReceiveTime			= 155; // 探险还没到领奖时间
	ConfigureRepetSkill				= 156; // 技能重复上阵
	AdventureTimeIsNotReach			= 157; // 探险时间未到
	ExceedResearchMaxLevel			= 158; // 超过宠物研究最大等级
	RareFossilNotEnough				= 159; // 珍稀化石不足
	TheSlotNotOpen					= 160; // 技能槽未开启 
	IncludeInvalidSkillId			= 161; // 包含无效技能id
	HadNotLearnTheSkill				= 162; // 还未学习此技能
	MaxProcessCount					= 163; // 已达最大加工次数
	ItemTypeNotMatch				= 164; // 物品类型不匹配
	NotFindGemSlot					= 165; // 没有找到宝石孔
	GemSlotNotLock					= 166; // 宝石孔没有锁
	RewardNotFound				    = 167; // 奖励不存在
	NotSocketUnlockCostItem			= 168; // 不是宝石孔解锁材料
	GemSlotLock						= 169; // 宝石孔锁定
	PlaceSamePetToSlot				= 170; // 宠物重复放置宠物栏
	GemSColorNotMatch				= 171; // 宝石颜色不匹配
	BattlePetsCanNotEmpty			= 172; // 探险上阵的宠物不可为空
	CombatError   					= 173; // 战斗系统错误
	NoAvalibleCombatServer			= 174; // 没有可用战斗服务器
	TheSkilllevelBeyoudLimit		= 175; // 宠物技能等级超出限制
	NotHaveFashion					= 176; // 没有此时装
	FashionSlotNotMatch				= 177; // 时装槽位不匹配
	HaveFashion						= 178; // 已经拥有此时装
	SkillNotMatchSlot				= 179; // 宠物技能跟技能槽不匹配
	TheSkillHadAlreadyEquip			= 180; // 该宠物技能已经装备过了
	ResearchHadBeyondLimit			= 181; // 宠物研究超过最大等级
	TheSlotIdOfSkillIsError			= 182; // 宠物技能槽id错误
	SkillIdOfPetIsError				= 183; // 宠物的技能id错误
	IncludeInvalidTaskId			= 184; // 探险包含无效的任务id
	GroupPassworldError 			= 185; // 队伍密码错误
	TargetNotInGroup    			= 186; // 目标不是队员
	MasterActive    				= 187; // 队长活跃
	NoGoldFinger    				= 188; // 为获得金手指
	NoMoreFans						= 190; // 没有更多粉丝
	ThemeActionNotExist				= 191; // 主题动作不存在
	ThemeBorderNotExist    			= 192; // 主题边框不存在
	ThemeBackgroundNotExist    		= 193; // 主题背景不存在
	HeadNotExist    				= 194; // 头像不存在
	HeadBorderNotExist    			= 195; // 头像边框不存在
	ChatBubbleNotExist    			= 196; // 聊天气泡不存在
	TitleNotExist    				= 197; // 称号不存在
	Mainchallanging    				= 198; // 正在寻猎
	AchievementNotReach				= 199; // 未达成该成就
	AchievementRewarded				= 200; // 已经领取了该成绩奖励
	FashionCoinNotEnough			= 201; // 时装币不足
	HadAlreadyShieldThePlayer		= 202; // 已屏蔽过该玩家
	ThepLayerNotShield				= 203; // 该玩家未被屏蔽
	AuctionPriceGreaterFixedPrice	= 204; // 起拍价大于一口价
	AlreadyInClan					= 205; // 已经加入了部落
	NotInClan						= 206; // 不在部落中
	ClanPermitionDeny				= 207; // 部落权限不足
	ClanAlreadyRequested			= 208; // 已经申请该部落
	ClanRequestNotFound				= 209; // 申请不存在
	ClanDonationStateError			= 210; // 捐献状态不对
	ResPointNotFound				= 211; // 没有该资源点
	ItemIsBroken					= 212; // 物品耐久不足
	ResPointIsBroken				= 213; // 资源点坏掉了
	ResPointIsMining				= 214; // 正在挖矿
	ClanNameHasBanWorld				= 215; // 部落名称有屏蔽内容
	ClanManifestoHasBanWorld		= 216; // 部落宣言有屏蔽内容
	ClanFlagNotFound				= 217; // 旗帜不存在
	ClanNameTooLong					= 218; // 部落名称太长
	ClanManifestoTooLong			= 219; // 部落宣言太长
	ClanNameEmpty					= 220; // 部落名称不能为空
	ClanNameRepeated				= 221; // 部落名称重复
	CommodityNotExist				= 222; // 拍卖品不存在
	NotJobberSeller					= 223; // 不是拍卖品的卖方
	HasBidPlayer					= 224; // 已经有玩家出价
	StockNotEnough					= 225; // 库存是否足够
	GoodNotOpen						= 226; // 物品未开启，部落等级不够
	ClanNotFound					= 227; // clan不存在
	ClanSystemError					= 228; // 部落系统错误
	PriceLessEqualCurPrice			= 229; // 价格小于等于当前竞拍价
	PriceGreaterFixedPrice			= 230; // 价格大于竞拍一口价
	BidSelfCommodity				= 231; // 不能对自己出售的拍品进行竞价
	TargetNotInClan					= 232; // 目标不在部落中
	ClanPositionMaxCount			= 233; // 部落该职业人员已满员
	ClanFull						= 234; // 部落人员已满
	ClanLivenessNotEnough			= 235; // 部落活跃度不足
	ClanMapNotFound					= 236; // 领地不存在
	ClanResPointNotFound			= 237; // 资源点不存在
	LevelUpActiveNotEnough			= 238; // 部落升级活跃度不够
	NotFoundTheResPoint				= 239; // 没有找到该资源点
	TheResPointBreakageError		= 240; // 资源点破损程度数值有误
	ClanCoinNotEnough				= 241; // 部落代币不够
	HadAlreadyPublishFundsDonation	= 242; // 已经发布过资金募捐
	HadNotPublishFundsDonation		= 243; // 没有发起资金募捐
	HadNotPublishGoodsDonation		= 244; // 没有发起该物品募捐
	TheGoodsNotIncludeDonation		= 245; // 提交的物品不包含在募捐物品中
	PriceLessCurPrice				= 246; // 价格小于起拍价
	ItemCannotTradable				= 247; // 此物品不能交易
	TheTypeOfTaskNotMatch			= 248; // 上传的任务类型不对
	TheTaskIdIsError				= 249; // 任务id错误
	TheClanTaskHadNotComplete		= 250; // 该部落任务还未完成
	TheTaskIdIsNotOpen				= 251; // 任务不在开启状态
	GoodIsOverDonation				= 252; // 捐献的物品已超过募捐数量
	ClanMapAuctionNotStart			= 253; // 拍卖未开启
	ClanMapAuctionNotHighestPrice	= 254; // 出价太低了
	ClanMedalLevelNotEnough			= 255; // 部落勋章等级太低
	MaxMiningMemberCount			= 256; // 当前采集人数已满
	SmuggledGoodNotExist			= 257; // 私货不存在
	BidPriceLessCurPrice			= 258; // 出价小于当前价格
	SmuggledGoodNotAuction			= 259; // 私货商城不是拍卖商品状态
	CanNotOpenTheShop				= 260; // 不能打开该商店
	ChangeGoodsCountFaild			= 261; // 商店改变数量失败  maybe 领地商店
	DurabilityNotEnough				= 262; // 耐久不足
	NotFoundDonationType			= 263; // 没有找到募捐类型
	CanNotCommitEmpty				= 264; // 提交的数据为空
	ResPointIsRecovering			= 265; // 资源点正在恢复期
	ItemCanNotUseOnResPoint			= 266; // 物品不能用于该资源点
	ClanTargetNotMining				= 267; // 目标并未进行采集行为
	GemBagFull						= 268; // 宝石背包已满
	ItemCountNotEnough				= 269; // 物品数量不足
	LifeSkillTypeErr				= 270; // 生活技能类型错误
	LifeSkillNotTask				= 271; // 生活技能空闲状态
	LifeSkillMaterialNotEnough		= 272; // 生活技能材料不足
	LifeSkillMaking					= 273; // 生活技能正在制作中
	LifeSkillParamErr				= 274; // 生活技能参数错误
	TheClanTaskMayBeCompleted		= 275; // 部落任务可能已经完成了
	LifeSkillTalentFormula			= 276; // 生活技能指定的天赋下未找到配方
	LifeSkillTalentLock				= 277; // 生活技能天赋未解锁
	LifeSkillTalentStrNil			= 278; // 生活技能指定的天赋下未找到强化项
	LifeSkillTalentStrEnd			= 279; // 生活技能指定的天赋强化项满级
	LifeSkillTalentStrCon			= 280; // 生活技能指定的天赋强化项条件不满足
	LifeSkillPointNotEnough			= 281; // 生活技能天赋点不足
	GroupNotHasGold					= 282; // 没有金手指
	ChatRoomTypeError				= 283; // 聊天室类型错误
	BlacklistIsFull					= 284; // 黑名单已满
	DonationTaskIsInvalid			= 285; // 物品募捐任务已过期
	ChatRoomHadDismiss				= 286; // 所在聊天室已解散
	NotInThisChannel				= 287; // 没有在当前频道
	TokenLevelNotEnough				= 288; // token 等级不足
	InMystery						= 289; // 在密境中
	NotInMystery					= 290; // 不在密境中
	ProgressNotEnough				= 291; // 主线进度不足
	BoxLimit						= 292; // 宝箱已达上线
	ScoreNotEnough					= 293; // 积分不足
	BoxLocking						= 294; // 宝箱解锁中
	BoxUnlock						= 295; // 宝箱已解锁
	BoxNotFind						= 296; // 宝箱未找到
	BoxFastFail						= 297; // 宝箱加速失败
	MysteryChallengeEnd				= 298; // 秘境挑战结束
	EnergyNotEnough					= 299; // 部落采集体力不足
	NoHavePetIslandApplyed			= 300; // 没有指定应用的佣兽岛
	ThePetIslandHadAlreadyUsed		= 301; // 选择的佣兽岛已经使用
	UnlockConditionNotEnough		= 302; // 解锁条件不足
	PetHadAlreadyAppointed			= 303; // 该宠物已经被指派
	UnlockedPetNotEnough			= 304; // 解锁的宠物数量不足
	BattleReportsNotExist			= 305; // 战报不存在
	NotFoundThePetIsland			= 306; // 尚未拥有此佣兽岛
	DonationIdIsError				= 307; // DonationId错误
	TooOften						= 308; // 操作太频繁
	TheChannelNotOpen				= 309; // 频道未开启
	HadAlreadShielded				= 310; // 该玩家以被屏蔽
	HadAlreadyInChatList			= 311; // 该玩家已经在聊天列表里
	JoinGroupRequestIsOverTime		= 312; // 该入队申请已超时
}

enum proto_type
{
	none								= 0;
	s2c_result_msg						= 1;
	c2s_logout							= 2;
	c2s_user_auth						= 4;
	s2c_ret_user_auth					= 5;
	s2c_notify_player_data				= 6;
	s2c_notify_enter_world				= 7;
	s2c_player_properties_update		= 8;
	c2s_gm_cmd							= 9;
	c2s_query_player_list				= 10;
	s2c_ret_query_player_list			= 11;
	c2s_create_player					= 12;
	s2c_ret_create_player				= 13;
	c2s_enter_world						= 14;
	c2s_modify_player_name				= 15;
	s2s_ret_modify_player_name			= 16;
	c2s_client_setting					= 17;
	s2c_ret_client_setting				= 18;
	c2s_user_relogin					= 19;
	s2c_user_relogin					= 20;
	s2c_kick_session					= 21;
	
/*****************group begine*******************/
	c2s_get_simple_player_data			= 11003;
	s2c_ret_get_simple_player_data		= 11004;
	s2c_change_group					= 11005;
	s2c_update_member					= 11006;
	c2s_get_groups						= 11007;
	s2c_ret_get_groups					= 11008;
	c2s_group_join						= 11009;
	s2c_ret_group_join					= 11010;
	s2c_notify_request					= 11011;
	c2s_join_answer						= 11012;
	s2c_ret_join_answer					= 11013;
	c2s_group_invite					= 11014;
	s2c_ret_group_invite				= 11015;
	s2c_notify_group_invite				= 11016;
	c2s_handle_invite					= 11017;
	s2c_ret_handle_invite				= 11018;
	c2s_match_member					= 11019;
	s2c_ret_match_member				= 11020;
	c2s_group_exit						= 11021;
	s2c_ret_group_exit					= 11022;
	s2c_update_group_master				= 11023;
	c2s_group_set_recruitment			= 11024;
	s2c_delete_member					= 11025;
	s2c_delete_request					= 11026;
	s2c_delete_group_invite				= 11027;
	s2c_update_member_online			= 11028;
	c2s_group_find_players				= 11029;
	s2c_ret_group_find_players			= 11030;
	c2s_group_kick_member				= 11031;
	s2c_ret_group_kick_member			= 11032;
	c2s_group_become_master				= 11033;
	s2c_ret_group_become_master			= 11034;
	c2s_group_gold_finger				= 11035;
	s2c_ret_group_gold_finger			= 11036;
	c2s_group_set_position				= 11037;
	s2c_ret_group_set_position			= 11038;
	s2c_ret_group_set_recruitment		= 11039;
	s2c_update_group_set_recruitment	= 11040;
	s2c_update_group_member_position	= 11041;
	s2c_update_member_gold_finger		= 11042;
	c2s_group_gold_configure_skill 		= 11043;
	s2c_ret_group_gold_configure_skill 	= 11044;
	s2c_update_member_configure_skill 	= 11045;
	c2s_group_gold_configure_pet 		= 11046;
	s2c_ret_group_gold_configure_pet 	= 11047;
	s2c_update_member_gold_configure_pet= 11048;
	s2c_update_group_msg				= 11049;
	c2s_through_group_info				= 11050;
	s2c_through_group_info				= 11051;
	s2c_update_group_member_clan		= 11052;
	s2c_update_group_member_refresh		= 11053;
	s2c_updaue_member_main_recent		= 11054;
	s2c_clear_request					= 11055;
	s2c_notify_update_my_request		= 11056;
/*****************group end**********************/

/***************** attributes *******************/
	s2c_update_attributes				= 11201;
/***************** attributes end *******************/


	c2s_query_mail						= 12001;
	s2c_ret_query_mail					= 12002;
	c2s_read_mail						= 12003;
	s2c_ret_read_mail					= 12004;
	c2s_take_mail_affix					= 12005;
	s2c_ret_take_mail_affix				= 12006;
	c2s_remove_mail						= 12007;
	s2c_ret_remove_mail					= 12008;
	c2s_one_key_remove_mail				= 12009;
	s2c_ret_one_key_remove_mail			= 12010;
	c2s_gm_send_mail					= 12011;
	s2c_ret_gm_send_mail				= 12012;
	c2s_one_key_receive_mail			= 12013;
	s2c_ret_one_key_receive_mail		= 12014;

	c2s_show_all_channel				= 12052;
	s2c_ret_show_all_channel			= 12053; 
	c2s_shield_player					= 12054;
	s2c_ret_shield_player				= 12055;
	c2s_cancel_shield_player			= 12056;
	s2c_ret_cancel_shield_player		= 12057;
	c2s_show_blacklist					= 12058;
	s2c_ret_show_blacklist				= 12059;
	c2s_chat_msg_send					= 12060;
	s2c_ret_chat_msg_send				= 12061;
	s2c_notify_chat_room_msg			= 12062;
	c2s_change_channel_id				= 12063;
	s2c_ret_change_channel_id			= 12064;
	c2s_chat_friend_send				= 12065;
	s2c_ret_chat_friend_send			= 12066;
	c2s_query_friend_chat_data			= 12067;
	s2c_ret_query_friend_chat_data		= 12068;
	c2s_read_friend_chat_data			= 12069;
	s2c_ret_read_friend_chat_data		= 12070;
	s2c_notify_friend_msg				= 12071;	// 聊天室内监听此消息，及时显示
	c2s_query_my_attention				= 12072;
	s2c_ret_query_my_attention			= 12073;
	c2s_query_my_fans					= 12074;
	s2c_ret_query_my_fans				= 12075;
	c2s_recommend_friend				= 12076;
	s2c_ret_recommend_friend			= 12077;
	c2s_search_friend					= 12078;
	s2c_ret_search_friend				= 12079;
	c2s_pay_attention_friend			= 12080;
	s2c_ret_pay_attention_friend		= 12081;
	c2s_cancel_attention_friend			= 12082;
	s2c_ret_cancel_attention_friend		= 12083;
	s2c_notify_fans_update				= 12084;
	c2s_report_player					= 12085;
	s2c_ret_report_player				= 12086;
	c2s_chat_add_friend_tag 			= 12087;
	s2c_ret_chat_add_friend_tag 		= 12088;
	c2s_chat_del_friend_tag 			= 12089;
	s2c_ret_chat_del_friend_tag 		= 12090;
	s2c_notify_friend_tag				= 12091;


	s2c_add_item						= 13001;
	s2c_remove_item						= 13002;
	s2c_item_properties_update			= 13003;
	s2c_equip_slot_update				= 13004;
	c2s_equip_up						= 13005;
	s2c_ret_equip_up					= 13006;
	c2s_equip_down						= 13007;
	s2c_ret_equip_down					= 13008;
	c2s_equip_lock						= 13009;
	s2c_ret_equip_lock					= 13010;
	c2s_equip_intensify					= 13011;
	s2c_ret_equip_intensify				= 13012;
	c2s_gem_process						= 13013;
	s2c_ret_gem_process					= 13014;
	s2c_update_gem_slot					= 13015;
	c2s_open_gem_slot					= 13016;
	s2c_ret_open_gem_slot				= 13017;
	c2s_inlay_gem						= 13018;
	s2c_ret_inlay_gem					= 13019;

	c2s_profession_advanced					= 14006;
	s2c_ret_profession_advanced				= 14007;
	c2s_change_profession				= 14008;
	s2c_ret_change_profession			= 14009;
	c2s_commit_talent					= 14010;
	s2c_ret_commit_talent				= 14011;
	s2c_clear_talent					= 14012;
	s2c_notify_update_talent			= 14013;

	s2c_daily_quest_update					= 15001;
	s2c_week_quest_update					= 15002;
	c2s_take_daily_quest_reward				= 15003;
	s2c_ret_take_daily_quest_reward			= 15004;
	c2s_take_daily_quest_score_reward		= 15005;
	s2c_ret_take_daily_quest_score_reward	= 15006;
	c2s_take_week_quest_reward				= 15007;
	s2c_ret_take_week_quest_reward			= 15008;
	c2s_take_week_quest_score_reward		= 15009;
	s2c_ret_take_week_quest_score_reward	= 15010;
	c2s_change_wishpool_target				= 15011;
	s2c_ret_change_wishpool_target			= 15012;
	c2s_wishpool							= 15013;
	s2c_ret_wishpool						= 15014;
	c2s_take_wishpool_reward				= 15015;
	s2c_ret_take_wishpool_reward			= 15016;
	s2c_all_daily_quest_update				= 15017;
	s2c_all_week_quest_update				= 15018;

	s2c_update_skill_data					= 16001;
	s2c_update_skill_slot					= 16002;
	c2s_eat_skill_card						= 16003;
	s2c_ret_eat_skill_card					= 16004;
	c2s_skill_star_up						= 16005;
	s2c_ret_skill_star_up					= 16006;
	c2s_configure_skill						= 16007;
	s2c_ret_configure_skill					= 16008;
	c2s_configure_multi_skill				= 16009;
	s2c_ret_configure_multi_skill			= 16010;

	c2s_commit_attr_point					= 17001;
	s2c_ret_commit_attr_point				= 17002;
	c2s_reset_attr_point					= 17003;
	s2c_ret_reset_attr_point				= 17004;

	c2s_pet_battle							= 18001;
	s2c_ret_pet_battle						= 18002;
	c2s_pet_rest							= 18003;
	s2c_ret_pet_rest						= 18004;
	c2s_pet_release							= 18005;
	s2c_ret_pet_release						= 18006;
	c2s_pet_lock							= 18007;
	s2c_ret_pet_lock						= 18008;
	c2s_pet_rising_star						= 18011;
	s2c_ret_pet_rising_star					= 18012;
	c2s_pet_falling_star					= 18013;
	s2c_ret_pet_falling_star				= 18014;
	c2s_pet_change_skill					= 18015;
	s2c_ret_pet_change_skill				= 18016;
	c2s_pet_research						= 18017;
	s2c_ret_pet_research					= 18018;
	c2s_pet_skill_upgrade					= 18019;
	s2c_ret_pet_skill_upgrade				= 18020;
	c2s_pet_adventure						= 18021;
	s2c_ret_pet_adventure					= 18022;
	c2s_adventure_receive					= 18023;
	s2c_ret_adventure_receive				= 18024;
	c2s_pet_cancel_adventure				= 18025;
	s2c_ret_pet_cancel_adventure			= 18027;
	c2s_pet_put_food						= 18028;
	s2c_ret_pet_put_food					= 18029;
	c2s_pet_catch							= 18031;
	s2c_ret_pet_catch						= 18032;
	c2s_pet_cancel_catch					= 18033;
	s2c_ret_pet_cancel_catch				= 18034;
	c2s_pet_speed_up_catch					= 18035;
	s2c_ret_pet_speed_up_catch				= 18036;
	c2s_pet_build_pasture					= 18037;
	s2c_ret_pet_build_pasture				= 18038;
	c2s_pet_pasture_place					= 18039;
	s2c_ret_pet_pasture_place				= 18040;
	s2c_add_pet								= 18046;
	s2c_remove_pet							= 18047;
	s2c_pet_properties_update				= 18048;
	s2c_notify_adventure_update				= 18049;
	c2s_pet_regain_strength					= 18054;
	s2c_ret_pet_regain_strength				= 18055;
	s2c_notify_atlas_update					= 18061;
	s2c_notify_pet_skill_update				= 18062;
	c2s_pet_speed_up_adventure				= 18063;
	s2c_ret_pet_speed_up_adventure			= 18064;
	c2s_pet_adventure_refresh_task			= 18065;
	s2c_ret_pet_adventure_refresh_task		= 18066;
	s2c_update_pet_research_addition		= 18067;
	s2c_notify_pet_change_skill				= 18068;
	c2s_clan_get_mining_rewards				= 18069;
	s2c_ret_clan_get_mining_rewards			= 18070;
	s2c_notify_pet_catch_finish				= 18071;

	
	// 主玩法
	c2s_set_main_loot_field					= 18200;
	s2c_ret_set_main_loot_field				= 18201;
	c2s_main_report_list					= 18202;					
	s2c_main_report_list					= 18203;
	c2s_challange_boss						= 18204;
	s2c_ret_challange_boss					= 18205;
	s2c_main_searching						= 18206;
	c2s_main_report_request					= 18207;					
	s2c_main_report_request					= 18208;

	// 时装
	s2c_update_fashion						= 19001;
	s2c_update_fashion_slot					= 19002;
	c2s_fashion_up							= 19003;
	s2c_ret_fashion_up						= 19004;
	c2s_fashion_down						= 19005;
	s2c_ret_fashion_down					= 19006;
	c2s_buy_fashion							= 19007;
	s2c_ret_buy_fashion						= 19008;
	c2s_active_fashion_handbook				= 19009;
	s2c_ret_active_fashion_handbook			= 19010;
    c2s_wardrobe_read_fashion				= 19011;
	s2c_wardrobe_read_fashion				= 19012;

	// 秘境
	c2s_enter_mystery						= 19051;
	s2c_enter_mystery						= 19052;
	c2s_leave_mystery						= 19053;
	s2c_leave_mystery						= 19054;
	c2s_mystery_config						= 19055;
	s2c_mystery_config						= 19056;
	c2s_mystery_challenge					= 19057;
	s2c_mystery_challenge					= 19058;
	c2s_mystery_settlement					= 19059;
	s2c_mystery_settlement					= 19060;
	c2s_mystery_remove_box					= 19065;
	s2c_mystery_remove_box					= 19066;
	c2s_mystery_receive_box					= 19067;
	s2c_mystery_receive_box					= 19068;
	c2s_mystery_update_box_slot				= 19069;
	s2c_mystery_update_box_slot				= 19070;
	c2s_mystery_box_fast					= 19071;
	s2c_mystery_box_fast					= 19072;
	c2s_mystery_low_through_combat			= 19073;
	s2c_mystery_low_through_combat			= 19074;
    c2s_mystery_update_config				= 19075;
	s2c_mystery_update_config				= 19076;

	// 个人信息
	c2s_save_theme							= 19100;
	s2c_ret_save_theme						= 19101;
	c2s_save_personal_setting				= 19102;
	s2c_ret_save_personal_setting			= 19103;
	c2s_set_head							= 19105;
	s2c_ret_set_head						= 19106;
	c2s_set_head_border						= 19107;
	s2c_ret_set_head_border					= 19108;
	c2s_set_chat_bubble						= 19109;
	s2c_ret_set_chat_bubble					= 19110;
	c2s_set_title							= 19111;
	s2c_ret_set_title						= 19112;
	s2c_add_simple_appearance_res			= 19113;

	// 成就
	s2c_update_achievement					= 19200;
	c2s_get_achievement_reward				= 19201;
	s2c_ret_get_achievement_reward			= 19202;

	// 开石
	c2s_lookup_slabstone_info				= 19500;
	s2c_lookup_slabstone_info				= 19501;
	c2s_raw_stone_on_stage					= 19502;
	s2c_raw_stone_on_stage					= 19503;
	c2s_raw_stone_chisel					= 19504;
	s2c_raw_stone_chisel					= 19505;
	c2s_raw_stone_cancel					= 19506;
	s2c_raw_stone_cancel					= 19507;
	s2c_raw_stone_update                    = 19508;

	// 宝石工坊
	c2s_lookup_gem_workshop_info			= 19600;
	s2c_lookup_gem_workshop_info			= 19601;
	c2s_gem_workshop_levelup				= 19602;
	s2c_gem_workshop_levelup				= 19603;
	s2c_gem_workshop_update					= 19604;

	// 生活技能
	c2s_life_skill_make						= 19620;
	s2c_life_skill_make						= 19621;
	c2s_life_skill_decomposition			= 19622;
	s2c_life_skill_decomposition			= 19623;
	c2s_life_skill_transform				= 19624;
	s2c_life_skill_transform				= 19625;
	c2s_life_skill_stop						= 19626;
	s2c_life_skill_stop						= 19627;
	c2s_life_skill_get_rewards				= 19628;
	s2c_life_skill_get_rewards				= 19629;
	s2c_life_skill_update					= 19630;
	c2s_life_skill_talent_improved			= 19631;
	s2c_life_skill_talent_improved			= 19632;

	// 交易行
	c2s_query_jobber_item_min_price			= 20001;
	s2c_ret_query_jobber_item_min_price		= 20002;
	c2s_jobber_sell							= 20003;
	s2c_ret_jobber_sell						= 20004;
	c2s_query_jobber_my_sell_items			= 20005;
	s2c_ret_query_jobber_my_sell_items		= 20006;
	c2s_disboard_jobber_commodity			= 20007;
	s2c_ret_disboard_jobber_commodity		= 20008;
	c2s_query_jobber_items					= 20009;
	s2c_ret_query_jobber_items				= 20010;
	c2s_jobber_buy							= 20011;
	s2c_ret_jobber_buy						= 20012;
	c2s_query_jobber_bid_items				= 20013;
	s2c_ret_query_jobber_bid_items			= 20014;
	c2s_query_smuggled_goods				= 20015;
	s2c_ret_query_smuggled_goods			= 20016;
	c2s_buy_smuggled_good					= 20017;
	s2c_ret_buy_smuggled_good				= 20018;

	// 部落
	c2s_create_clan						= 21000;
	s2c_ret_create_clan					= 21001;
	c2s_exit_clan						= 21002;
	s2c_ret_exit_clan					= 21003;
	c2s_get_my_clan						= 21004;
	s2c_ret_get_my_clan					= 21005;
	c2s_get_clan						= 21006;
	s2c_ret_get_clan					= 21007;
	c2s_join_clan						= 21008;
	s2c_ret_join_clan					= 21009;
	c2s_clan_get_members				= 21010;
	s2c_ret_clan_get_members			= 21011;
	c2s_clan_handle_request				= 21012;
	s2c_ret_clan_handle_request			= 21013;
	c2s_clan_set_position				= 21014;
	s2c_ret_clan_set_position			= 21015;
	c2s_clan_set_manifesto				= 21016;
	s2c_ret_clan_set_manifesto			= 21017;
	c2s_clan_publish_donation_task		= 21018;
	s2c_ret_clan_publish_donation_task	= 21019;
	s2c_notify_update_donation			= 21020;
	c2s_clan_set_flag					= 21023;
	s2c_ret_clan_set_flag				= 21024;
	c2s_clan_set_minning_privileges		= 21025;
	s2c_ret_clan_set_minning_privileges	= 21026;
	c2s_clan_levelup					= 21027;
	s2c_ret_clan_levelup				= 21028;
	c2s_clan_get_rank_list				= 21029;
	s2c_ret_clan_get_rank_list			= 21030;
	c2s_clan_fix_res_point				= 21031;
	s2c_ret_clan_fix_res_point			= 21032;
	c2s_clan_mining_levelup				= 21033;
	s2c_ret_clan_mining_levelup			= 21034;
	c2s_clan_remove_mining_player		= 21035;
	s2c_ret_clan_remove_mining_player	= 21036;
	c2s_clan_auction					= 21037;
	s2c_ret_clan_auction				= 21038;
	c2s_clan_mining						= 21040;
	s2c_ret_clan_mining					= 21041;	
	c2s_clan_pre_dealloc				= 21043;
	s2c_ret_clan_pre_dealloc			= 21044;
	c2s_clan_get_auction				= 21045;
	s2c_ret_clan_get_auction			= 21046;
	c2s_clan_get_res					= 21047;
	s2c_ret_clan_get_res				= 21048;
	c2s_clan_get_mining_level			= 21049;
	s2c_ret_clan_get_mining_level		= 21050;
	s2c_notify_refresh_shop				= 21051;
	c2s_buy_goods						= 21052;
	s2c_ret_buy_goods					= 21053;
	c2s_refresh_shop					= 21054;
	s2c_ret_refresh_shop				= 21055;
	s2c_notify_refresh_goods			= 21056;
	c2s_clan_get_request				= 21057;
	s2c_ret_clan_get_request			= 21058;	
	c2s_clan_get_map_data				= 21059;
	s2c_ret_clan_get_map_data			= 21060;
	c2s_clan_tick_player				= 21061;
	s2c_ret_clan_tick_player			= 21062;
	c2s_clan_destroy					= 21063;
	s2c_ret_clan_destroy				= 21064;
	s2c_notify_refresh_manual_count		= 21065;
	c2s_open_clan_task					= 21066;
	s2c_ret_open_clan_task				= 21067;
	c2s_clan_complete_task				= 21068;
	s2c_ret_clan_complete_task			= 21069;
	c2s_open_clan_donation_task			= 21070;
	s2c_ret_open_clan_donation_task		= 21071;
	s2c_notify_clan_task_update			= 21075;
	c2s_submit_donation_task			= 21076;
	s2c_ret_submit_donation_task		= 21077;
	c2s_open_shop						= 21078;
	s2c_ret_open_shop					= 21079;
	s2c_notify_update_res				= 21080;
	c2s_clan_mining_set_special_item	= 21081;
	s2c_clan_mining_set_special_item	= 21082;

	// 部落领地战
	c2s_clan_battlefield_info			= 21500;
	s2c_clan_battlefield_info			= 21501;
	c2s_clan_battlefield_declare_war	= 21502;
	s2c_clan_battlefield_declare_war	= 21503;
	c2s_clan_battlefield_pvp_info		= 21504;
	s2c_clan_battlefield_pvp_info		= 21505;
	c2s_clan_battlefield_join_or_leave	= 21506;
	s2c_clan_battlefield_join_or_leave	= 21507;
	c2s_clan_battlefield_cheer			= 21508;
	s2c_clan_battlefield_cheer			= 21509;
	c2s_clan_battlefield_control		= 21510;
	s2c_clan_battlefield_control		= 21511;
	c2s_clan_battlefield_give_up		= 21512;
	s2c_clan_battlefield_give_up		= 21513;
	c2s_clan_battlefield_member_list	= 21514;
	s2c_clan_battlefield_member_list	= 21515;
	c2s_clan_battlefield_get_reward		= 21516;
	s2c_clan_battlefield_get_reward		= 21517;
	c2s_clan_battlefield_config			= 21518;
	s2c_clan_battlefield_config			= 21519;

	// 佣兽岛
	c2s_show_pet_island 						= 22001;
	s2c_ret_show_pet_island 					= 22002;
	c2s_apply_pet_island 						= 22003;
	s2c_ret_apply_pet_island 					= 22004;
	c2s_pet_island_adventure					= 22005;
	s2c_ret_pet_island_adventure				= 22006;
	c2s_pet_island_adventure_receive			= 22007;
	s2c_ret_pet_island_adventure_receive 		= 22008;
	c2s_pet_island_cancel_adventure				= 22009;
	s2c_ret_pet_island_cancel_adventure			= 22010;
	s2c_notify_pet_island_adventure_update		= 22011;
	c2s_pet_island_speed_up_adventure			= 22012;
	s2c_ret_pet_island_speed_up_adventure		= 22013;
	c2s_pet_island_adventure_refresh_task		= 22014;
	s2c_ret_pet_island_adventure_refresh_task	= 22015;
	c2s_pet_island_build_tower					= 22016;
	s2c_ret_pet_island_build_tower				= 22017;
	c2s_pet_island_tower_place					= 22018;
	s2c_ret_pet_island_tower_place				= 22019;
	s2c_notify_pet_island_tower_update			= 22020;
	s2c_notify_pet_island_update				= 22021;


	server_internal_begin				= 60000;
	rpc_request							= 60001;
	rpc_response						= 60002;
	heartbeat							= 60003;
	server_login						= 60004;
	ret_server_login					= 60005;

	g2d_query_player_list				= 61003;
	d2g_ret_query_player_list			= 61004;
	g2d_create_player					= 61005;
	d2g_ret_create_player				= 61006;
	g2d_load_player_data				= 61009;
	d2g_ret_load_player_data			= 61010;
	g2d_save_player_data				= 61011;
	d2g_ret_save_player_data			= 61012;
	g2d_modify_player_name				= 61021;
	d2g_ret_modify_player_name			= 61022;
	g2d_add_offline_mail				= 61023;
	d2g_ret_add_offline_mail			= 61024;
	g2d_load_offline_mail				= 61025;
	d2g_ret_load_offline_mail			= 61026;
	g2d_get_simple_player_data			= 61027;
	d2g_ret_get_simple_player_data		= 61028;
	g2d_save_friend_chat_data			= 61029;
	d2g_ret_save_friend_chat_data		= 61030;
	g2d_query_friend_chat_data			= 61031;
	d2g_ret_query_friend_chat_data		= 61032;
	g2d_read_friend_chat_data			= 61033;
	d2g_ret_read_friend_chat_data		= 61034;
	g2d_report_player					= 61035;
	d2g_ret_report_player				= 61036;
	g2d_save_special_channel			= 61037;
	d2g_ret_save_special_channel		= 61038;
	g2d_load_special_channel			= 61039;
	d2g_ret_load_special_channel		= 61040;
	g2d_delete_special_channel			= 61041;
	d2g_ret_delete_special_channel		= 61042;

/*******************db friend begin*****************/	
	g2fd_query_my_attention				= 62035;
	fd2g_ret_query_my_attention			= 62036;
	g2fd_query_my_fans					= 62037;
	fd2g_ret_query_my_fans				= 62038;
	g2fd_search_friend					= 62039;
	fd2g_ret_search_friend				= 62040;
	g2fd_pay_attention_friend			= 62041;
	fd2g_ret_pay_attention_friend		= 62042;
	g2fd_recommend_friend				= 62043;
	fd2g_ret_recommend_friend			= 62044;
	g2fd_cancel_attention_friend		= 62045;
	fd2g_ret_cancel_attention_friend	= 62046;
	g2fd_get_new_fans_num				= 62047;
	fd2g_ret_get_new_fans_num			= 62048;
	g2fd_get_fans_num					= 62049;
	fd2g_ret_get_fans_num				= 62050;
	g2fd_notify_level_update			= 62051;
	fd2g_ret_notify_level_update		= 62052;
	g2fd_notify_player_login			= 62053;
	fd2g_ret_notify_player_login		= 62054;

/*******************db friend end*****************/	

/*******************db group begin*****************/
	g2d_get_group						= 601030;
	d2g_ret_get_group					= 601031;
	g2d_update_group					= 601032;
	d2g_ret_update_group				= 601033;
	g2d_get_group_members				= 601034;
	d2g_ret_get_group_members			= 601035;
	g2d_update_group_member				= 601036;
	g2d_get_max_group_id				= 601037;
	d2g_get_max_group_id				= 601038;
	c2s_get_group_data					= 601039;
	s2c_ret_get_group_data				= 601040;
	g2d_get_member						= 601041;
	d2g_get_member						= 601042;
	g2d_load_groups						= 601043;
	d2g_load_groups						= 601044;
/*******************db group end*****************/

/******************global info******************/ 
	g2d_get_global_info					= 601100;
	d2g_get_global_info					= 601101;
	g2d_update_global_info				= 601102;
	d2g_update_global_info				= 601103;
/***********************************************/ 

/****************** jobber ******************/ 
	g2d_query_jobber_item_min_price		= 601200;
	d2g_ret_query_jobber_item_min_price	= 601201;
	g2d_query_jobber_my_sell_items		= 601202;
	d2g_ret_query_jobber_my_sell_items	= 601203;
	g2d_disboard_jobber_commodity		= 601204;
	d2g_ret_disboard_jobber_commodity	= 601205;
	g2d_query_jobber_items				= 601206;
	d2g_ret_query_jobber_items			= 601207;
	g2d_query_jobber_bid_items			= 601208;
	d2g_ret_query_jobber_bid_items		= 601209;
	g2d_jobber_buy_pre_check			= 601210;
	d2g_ret_jobber_buy_pre_check		= 601211;

/***********************************************/ 
/****************** clan ******************/ 
	g2d_get_clan 						= 601401;
	d2g_get_clan 						= 601402;
	g2d_save_clan 						= 601403;
	d2g_save_clan 						= 601404;
	g2d_save_clan_member				= 601405;
	d2g_save_clan_member				= 601406;
	g2d_get_clan_member					= 601407;
	d2g_get_clan_member					= 601408;
	g2d_has_clan_name					= 601409;
	d2g_has_clan_name					= 601410;
	g2d_save_battle_report				= 601411;
	d2g_ret_save_battle_report			= 601412;
	g2d_get_battle_report				= 601413;
	d2g_ret_get_battle_report			= 601414;
	/***********************************************/ 


	// mail game
	m2g_begin							= 63000;
	m2g_add_mail						= 63001;
	g2m_get_all_mails					= 63002;
	m2g_get_all_mails					= 63003;
	m2g_end								= 63999;

	all2m_send_mail						= 66000;
	m2all_ret_send_mail					= 66001;
	m2g_inform_load_offline_mail		= 66002;

/*******************game combat begin*****************/
	g2combat_combat						= 70000;
	combat2g_combat						= 70001;
/*******************game combat end*****************/

/*******************nft server begin*****************/
	g2d_get_nft_player_data				= 800001;
	d2g_ret_get_nft_player_data			= 800002;
	g2d_save_nft_player_data			= 800003;
	d2g_ret_save_nft_player_data		= 800004;
/*******************nft server end*****************/
	

}

enum attribute_ids
{
	// 宠物特有的属性
	AttackTalent			= 101;	// 宠物攻击资质
	LifeTalent				= 102;	// 宠物同心资质
	AssistTalent			= 103; 	// 宠物协力资质
	GuardTalent				= 104;	// 宠物守护资质

	// 通用属性
	Main = 1001; // 主属性
	Vitality = 1002; // 体能
	Technic = 1003; // 技巧
	HP = 2001; // 生命
	Attack = 2002; // 攻击
	Defence = 2003; // 防御
	Hit = 2004; // 命中
	Evasion = 2005; // 闪避
	Crit = 2006; // 暴击率
	Tenacity = 2007; // 暴击抗性
	Block = 2008; // 格挡
	Impale = 2009; // 破击
	CritDamage = 2010; // 暴击伤害
	TenacityValue = 2011; // 暴伤抗性
	AttackSpeed = 2012; // 攻速
	CurrentHP = 2013; // 当前生命值
	Shield = 2014; // 护盾
	Fire = 3001; // 火焰元素
	Earth = 3002; // 大地元素
	Lightning = 3003; // 闪电元素
	Frost = 3004; // 寒冰元素
	ChargeSpeedAddition = 4001; // 蓄力速度加成
	ChantSpeedAddition = 4002; // 吟唱速度加成
	GuideSpeedAddition = 4003; // 引导速度加成
	AttackDamageAddition = 4004; // 普通攻击伤害加成
	SkillDamageAddition = 4005; // 技能伤害加成
	DamageRemission = 4006; // 受到的伤害降低
	DamageAddition = 4007; // 伤害提升
	CureSelfAddition = 4008; // 受到的恢复效果加成
	ChargeSkillDamageAddition = 4009; // 蓄力技能伤害加成
	ChantSkillDamageAddition = 4010; // 吟唱技能伤害加成
	GuideSkillDamageAddition = 4011; // 引导技能伤害加成
	CureAddition = 4012; // 恢复效果加成
	PersistDamageAddition = 4013; // 持续伤害加成
	IngoreDefence = 4014; // 无视防御效果
	ProfessionAttRepression = 4015; // 角色属性克制效果
	BaseAttRepression = 4016; // 基础属性克制效果
	AttackDamageRemission = 4017; // [bing] 受到非技能攻击伤害降低
	SkillDamageRemission = 4018; // [bing] 受到技能攻击伤害降低
	HaveShieldDamageRemission = 4019; // [bing] 有护盾时受到伤害降低
	ExtraShieldAddition = 4020; // [bing] 额外获得护盾
	MaxDeDamage = 10001; // 初始减伤比例上限
	MaxHit = 10002; // 初始命中上限
	MaxEvasion = 10003; // 初始闪避上限
	MaxCrit = 10004; // 初始暴击上限
	MaxTenacity = 10005; // 初始暴击抗性上限
	MaxBlock = 10006; // 初始格挡率上限
	MaxImpale = 10007; // 初始破击率上限
	MaxCritDamage = 10008; // 初始暴击伤害上限
	MaxTenacityValue = 10009; // 初始暴伤抗性上限
}

enum game_type
{
	Town				= 0;		// 主城
}

enum res_type
{
	None				= 0;
	Conch				= 1;	// 贝壳
	Starfish			= 2;	// 海星
	Pearl				= 3;	// 珍珠
	Exp					= 4;	// 经验
	DailyScore			= 6;	// 每日任务积分
	WeekScore			= 7;	// 每周任务积分
	WishpoolScore		= 8;	// 祈福值
	FashionCoin			= 9;	// 时装货币
	TalentPoint			= 10;	// 天赋点数
	ClanLiveness		= 11;	// 部落活跃度
	ClanCoin			= 12;	// 部落代币
	PetIsland 			= 999;	// 佣兽岛	

	Skill				= 98;	// 技能
	Item				= 99;	// 物品
	
	// 以下 res_type 的值需要和 item_type 中对应类型的值保持一致
	Pet 				= 102;	// 宠物
	Fashion 			= 103;	// 时装

	ThemeAction			= 111; // 主题动作
	ThemeBorder			= 112; // 主题边框
	ThemeBackground		= 113; // 主题背景
	Head				= 114; // 玩家头像
	HeadBorder			= 115; // 玩家头像边框
	ChatBubble 			= 116; // 聊天气泡
	Title 	 			= 117; // 称号	
}

enum item_type
{
	Equip 				= 1;	// 装备
	Material 			= 2;	// 材料	
	SkillCard 			= 3;	// 技能卡
	Food 				= 4;	// 食物
	PetSkillFragment 	= 5;	// 宠物技能碎片
	PetItem				= 6;	// 宠物相关物品
	Gem					= 7;	// 宝石
	RawStone			= 8;	// 原石
	ClanMining			= 9; 	// 部落资源点采集工具
	Hammer				= 11;	// [bing] 开石用锤子

	NotItemBegin 		= 100;
	Currency 			= 101;	// 货币
	Pet 				= 102;	// 宠物
	Fashion 			= 103;	// 时装

	ThemeAction			= 111; // 主题动作
	ThemeBorder			= 112; // 主题边框
	ThemeBackground		= 113; // 主题背景
	Head				= 114; // 玩家头像
	HeadBorder			= 115; // 玩家头像边框
	ChatBubble 			= 116; // 聊天气泡
	Title 	 			= 117; // 称号	
}

// 装备槽位类型
enum equip_slot_type
{
	EquipSlot1 = 1;			// 武器
	EquipSlot2 = 2;			// 副手
	EquipSlot3 = 3;			// 头饰
	EquipSlot4 = 4;			// 衣服
	EquipSlot5 = 5;			// 护腕
	EquipSlot6 = 6;			// 鞋子
	EquipSlot7 = 7;			// 戒指
	EquipSlot8 = 8;			// 项链
	EquipSlotEnd = 9;		// 结束标识
}

// 装备品质
enum item_quality
{
	ItemQuality1 = 1;			// 普通(白)
	ItemQuality2 = 2;			// 优秀(绿)
	ItemQuality3 = 3;			// 稀有(蓝)
	ItemQuality4 = 4;			// 史诗(紫)
	ItemQuality5 = 5;			// 传说(橙)
	ItemQuality6 = 6;			// 神话(红)
	ItemQualityEnd = 7;			// 结束标识
}

enum const_type
{
	option allow_alias = true;
	skill_slot_count 				= 4;				// 技能槽位数量
	max_gem_addition_count 			= 3;				// 宝石附加项最大数量
}

enum drop_type
{
	alone_rand = 1;			// 独立随机，每个道具都根据自己的概率随机掉或不掉
	union_rand = 2;			// 联合随机，所有道具根据概率掉落其中一种
}

// 属性计算类型
enum attribute_calc_type
{
	Add = 1;
	Multi = 2;
}

// 冒险者公会任务类型
enum risker_union_quest_type
{
	Login 				= 1; // 登入
	ChangeEquip 		= 2; // 更换装备
	FollowFriends		= 3; // 关注好友
	Cooking				= 4; // 烹饪
	UpgradeGems			= 5; // 升级宝石
	CapturePets			= 6; // 捕捉宠物
	ReleasePets			= 7; // 放生宠物
	DefeatMainlineBoss	= 8; // 击败主线boss
	PetResearch			= 9; // 宠物研究
	BuildEquipment		= 10; // 打造装备
	UsePrayerCoins		= 11; // 使用祈愿币
	SecretLandVictory	= 12; // 秘境胜利
}

message resource_t
{
	int32 res_type = 1;
	int32 count = 2;
	int32 config_id = 3;
	int64 unique_id = 4;
	int64 quality = 5;
	int64 original_id = 6;
}

message properties_t
{
	map<uint32, sint64> integer_vals = 1;
	map<uint32, float> float_vals = 2;
	map<uint32, bytes> string_vals = 3;
	map<uint32, bool> boolean_vals = 4;
}

// 宝石颜色
enum gem_color
{
	Red = 1;							// 红
	Blue = 2;							// 蓝
	Yellow = 3;							// 黄
	Green = 4;							// 绿
	Orange = 5;							// 橙
	Violet = 6;							// 紫
	Any = 7;							// 炫彩
}

// 宝石附加项类型
enum gem_addition_type
{
	Attr = 1;							// 属性
	SpecialEffect = 2;					// 特殊效果
}

// 宝石孔
message gem_slot_t
{
	int64 item_id = 1;					// 镶嵌宝石的物品id，为 0 表示没镶嵌宝石
	bool lock = 2;						// 是否锁定
	int64 color = 3;					// 颜色
}

// 宝石附加项
message gem_addition_t
{
	int64 addition_type = 1;						// 宝石附加项类型， 见枚举 gem_addition_type

	int64 attr_id = 5;								// 属性id（addition_type 为属性时有效）
	int64 attr_value = 6;							// 属性值（addition_type 为属性时有效）

	int64 special_effect = 11;						// 特殊效果，为 GemSpecialAttribute 表的ID（addition_type 为特殊效果时有效）
}

// 物品数据
message item_data_t
{
	int64 item_id = 1;
	int64 template_id = 2;
	properties_t item_properties = 3;
	repeated gem_slot_t gem_slots = 4;				// 宝石孔, 物品类型为装备时有效
	repeated gem_addition_t gem_additions = 5;		// 宝石附加项，数组每一项为一次加工的效果, 物品类型为宝石时有效
}

// 装备槽位数据
message equip_slot_t
{
	int64 slot = 1;								// 装备槽位类型
	int64 item_id = 2;							// 装备唯一id，为0代表没穿装备
}

// 每日任务
message daily_quest_t
{
	int64 quest_id = 1;			// 任务 id（DailyMission 表中的 id）
	bool is_complete = 2;		// 是否完成
	bool is_take_reward = 3;	// 是否已经领取奖励
}

// 每周任务
message week_quest_t
{
	int64 quest_id = 1;			// 任务 id（WeekMission 表中的 id）
	int64 count = 2;			// 已完成次数
	bool is_take_reward = 3;	// 是否已经领取奖励
}

// 冒险者公会
message risker_union_t
{
	map<int64, daily_quest_t> daily_quests = 1;		// 每日任务
	repeated int64 take_daily_rewards = 2;			// 已经领取的每日任务积分奖励
	map<int64, week_quest_t> week_quests = 3;		// 每周任务
	repeated int64 take_week_rewards = 4;			// 已经领取的每日任务积分奖励
	repeated int64 take_wishpool_rewards = 5;		// 已经领取的许愿奖励
}

// 技能
message skill_data_t
{
	int64 skill_parent_id = 1;		// 技能类id  （对应 ParentID 字段， 通过 ParentID*10+品质 可以得到技能id）
	int64 quality = 2;				// 品质
	int64 level = 3;				// 等级
	int64 exp = 4;					// 经验
	int64 star_level = 5;			// 突破等级
}

// 技能槽位
message skill_slot_t
{
	int64 slot = 1;					// 槽位
	int64 skill_parent_id = 2;		// 技能类id  （对应 ParentID 字段， 通过 ParentID*10+品质 可以得到技能id）
}

// 技能配置
message skill_configure_t
{
	int64 configure_type = 1;								// 配置类型，见枚举 skill_configure_type
	map<int64, skill_slot_t> skill_slots = 2;				// 挂机技能配置， key 为 slot
}

// 技能配置类型
enum skill_configure_type
{
	Hunting = 1;						// 狩猎配置
	HangUp = 2;							// 挂机配置
}

// 技能系统
message skill_system_t
{
	map<int64, skill_data_t> skills = 1;					// 技能列表， key 为 skill_parent_id
	map<int64, skill_configure_t> skill_configures = 2;		// 狩猎技能配置， key 为配置类型，见枚举 skill_configure_type
}

// 宠物信息
message pet_t
{
	int32 pet_id						= 1;	// 运行时宠物ID
	int32 pet_template_id				= 2;	// 配置表id
	properties_t pet_properties			= 3;
	map<int64, int64> pet_skill_config 	= 4;	// 宠物技能 map<槽位id，技能id> 槽位id=1、2:法球，槽位id=3、4、5、67、8:被动
	map<int64, float> talents 			= 5;	// 资质
	map<int64, attribute_content> attribute		= 6;	// 属性
}

enum task_status 
{
	not_open 				 			= 1; // 未开启/未解锁
	tasking								= 2; // 任务中
	end_await_award						= 3; // 结束未领奖励
	end_already_award					= 4; // 结束已领奖励 初始化状态
}

// 探险
message adventure_t 
{
	int64 adventure_point_id			= 1;		// 探险点
	map<int64, int64> up_pets			= 2;		// up宠物 map<上阵宠物槽slot_id, 宠物模板id>
	int64 deadline_time 				= 3;		// 截止时间
	int64 status 						= 4;		// 探险状态	task_status
	int64 task_id						= 5;		// 任务id
	map<int64, int64> battle_pets		= 6;		// 上阵宠物的id map<上阵宠物槽slot_id, 宠物模板id，即图鉴中宠物id>
	bool is_high						= 7;		// 是否高级探索
}



// 宠物技能
message pet_skill_t
{
	map<int64, pet_skill_data_t> skills 		= 1;	// 法球技能/被动技能 map<技能id, pet_skill_data_t>
}

message pet_skill_data_t
{
	int64 skill_id 		= 1;				// 技能id
	int64 level 		= 2;				// 等级
}

message atlas_t
{
	int64 pet_template_id	= 1;
	int32 max_quality		= 2;	// 拥有过的最高品质
	int32 strength			= 3;	// 体力
}

enum pet_attribute_ids
{
	AttackPower				= 201;	// 宠物攻击力属性
	AttackTalent			= 101;	// 攻击资质
	LifeTalent				= 102;	// 同心资质
	AssistTalent			= 103; 	// 协力资质
	GuardTalent				= 104;	// 守护资质
}

// 宠物系统
message pet_system_t
{
	map<int64, pet_t>  pets							= 1;	// 宠物 map<宠物id, pet_t>
	map<int64, adventure_t>  adventure				= 2;	// 探险 map<探险点id, adventure_t>
	map<int64, int64>  pasture						= 3;	// 牧场	map<牧场id, 宠物id>
	map<int64, atlas_t>  atlas						= 4; 	// 图鉴（点亮的宠物）map<宠物模板id, atlas_t>
	map<int64, pet_skill_t> pet_skills 				= 5;	// 宠物技能 法球技能/被动技能 map<技能id, pet_skill_data_t>
	map<int64, float> research_additional			= 6;	// 宠物研究资质加成
	map<int64, float> pasture_bonus					= 7;	// 牧场加成
}


// 时装部位
enum fashion_slot_type
{
	FashionSlot1 = 1;		// 套装
	FashionSlot2 = 2;		// 时装
	FashionSlot3 = 3;		// 武器
	FashionSlot4 = 4;		// 背部
	FashionSlot5 = 5;		// 头发
	FashionSlot6 = 6;		// 腰部
	FashionSlot7 = 7;		// 面具
	FashionSlot8 = 8;		// 项链
	FashionSlot9 = 9;		// 贴花
	FashionSlot10 = 10;		// 头饰
	FashionSlot11 = 11;		// 其他
	FashionSlotEnd = 12;	// 结束标识
}

// 时装
message fashion_t
{
	int64 fashion_id = 1;		// 时装id
	bool handhook_active = 2;   // 图鉴是否激活
    bool wardrobe_read = 3;     // 是否已读
}

// 时装系统
message fashion_system_t
{
	map<int64, fashion_t> fashions = 1;				// 时装数据
	map<int64, int64> fashion_slots = 2;			// 穿戴的时装 map<slot, fashion_id>
}

// 外观，数据
message simple_appearance_t
{
	repeated uint64 theme_action = 1; // 主题动作
	repeated uint64 theme_border = 2; // 主题边框
	repeated uint64 theme_background = 3;// 主题背景
	repeated uint64 head = 4; // 头像
	repeated uint64 head_border = 5; // 头像框
	repeated uint64 chat_bubble = 6; // 聊天气泡
	repeated uint64 title = 7; // 称号
}

// 成就
message achievement_t
{
	uint64 id = 1;				// 成就ID
	uint64 value = 2;			// 当前值
	uint64 rewarded_index = 3;  // 已领奖的索引
}

// [bing] 活动
enum activity_state_type
{
	activity_open = 1;			// 活动开启
	activity_close = 2;			// 活动关闭
}

// 活动ID
enum activity_id_enum
{
	act_test = 1;
	act_clan_battle_declare_war = 2;
	act_clan_battle_prepare = 3;
	act_clan_battle_lock = 4;
	act_clan_battle_fight = 5;
	act_clan_battle_settlement = 6;
}

enum hammer_type
{
	HammerSmall = 1;
	HammerBig = 2;	
}

// 石板石块数据
message slabstone_block
{
	int32 remain_layer_num = 1;		// 剩余层数
	int32 durable = 2;				// 耐久
}

// 石板数据
message slabstone
{
	int64 gem_template_id = 1;								// 宝石模板ID
	int32 gem_pos = 2;										// 宝石位置 以宝石左下角为中心的位置
	int32 gem_dir = 3;										// 宝石朝向 1 = 上, 2 = 右, 3 = 下, 4 = 左
	map<int32, slabstone_block> slabstone_blocks = 4;		// 石板信息 k = 索引 1 ~ 96 , v = slabstone_block
	int64 raw_template_id = 5;								// 原石模板ID
	int64 gem_special_effect = 6;							// 原石特殊属性 没有时 = 0
}

// 宝石工坊数据
message gem_workshop
{
	int32 level = 1;		// 宝石工坊等级
	int32 exp = 2;			// 宝石工坊经验
}

// [bing] 秘境
message mystery_t
{
	uint32 mystery_id = 1;			// 秘境ID
	uint32 mystery_progress = 2;	// 秘境进度
	repeated uint32 boss_index_list = 3;	// boss 列表(index)
	uint64 mystery_score = 4;					// 秘境积分
	map<uint64, group_member_data_t> mystery_member = 5;	// 秘境配置 <member_id, value>
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 6;	// 秘境宝箱 <槽位 , value>
	float mystery_baoji = 7;
}

message life_talent_t
{
	repeated uint64 stren_id = 2;	// 天赋项 id
}


message life_skill_t
{
	// base
	uint32 life_type					= 1;	// 类型
	uint32 life_exp						= 2;	// 熟练度
	uint32 life_point					= 3;	// 可用天赋点

	// talent
	map<uint32, life_talent_t> life_talent	= 4;

	// compound
	uint64 config_id					= 5;	// 配置索引
	uint32 target_num					= 6;	// 目标剩余数量
	uint32 finish_num					= 7;	// 完成任务数量
	uint64 finish_time					= 8;	// 任务结束时间
	uint64 single_time					= 9;	// 单个任务时间
	bool flag							= 10;	// 领奖标识
}

// 玩家数据
message player_t
{
	int64 player_id = 1;
	properties_t player_properties = 2;
	attribute_t attributes = 3;
	repeated channel_chat_data_t chat_msgs = 4;					// 当前所在频道聊天信息 
	bytes setting_data = 5;										// 客户端设置数据
	map<int64, item_data_t> items = 6;							// 物品数据 map<item_id, item_data_t>
	map<int64, equip_slot_t> equip_slots = 7;					// 装备槽位数据 map<slot类型, equip_slot_t>		
	//map<int64, commodity_t> commodity_items		 = 8;			// 商店物品列表		
	risker_union_t risker_union = 9;							// 冒险者公会
	map<int64, int64> talents = 10;								// 天赋, key 为天赋id, value为对应天赋点数
	skill_system_t skill_system = 11;							// 技能系统
	pet_system_t pet			= 12;							// 宠物系统
	fashion_system_t fashion_system	 = 13;						// 时装系统
	simple_appearance_t simple_appearance = 14;				    // 简单的外观部件信息
	map<uint64, achievement_t> achievements = 15;				// 成就数据
	int64 channel_id						= 16;				// 玩家加入的频道
	map<int64, shop_t> shop_list			= 17;				// 商店列表
	map<uint32, life_skill_t> life_list		= 18;				// 生活技能列表
	repeated int64 shield_players 			= 19;				// 聊天屏蔽的玩家
	mystery_t mystery_info = 20;								// 秘境
	int64 channel_type						= 21;				// 玩家现加入的频道类型 公共频道、特色频道
	map<int64, player_info> chat_tags 		= 22;				// 聊天列表
}

message s2c_result_msg
{
	int32 err_id = 1;
	int32 flag = 2;			// flag:普通返回为 0， gm命令返回为 1
}

message c2s_logout
{
}

message c2s_user_auth
{
    bytes user_id = 1;		// format: raw_user_id@zone_id
	bytes token = 2;
}

message s2c_ret_user_auth
{
	bool is_queue_up = 1;		// 是否需要排队进入
	int64 queue_size = 2;		// 总排队人数 （is_queue_up 为 true 是有效）
	int64 my_order = 3;			// 当前玩家在排队中的位置 （is_queue_up 为 true 是有效）
}

message c2s_user_relogin
{
    bytes user_id = 1;		// format: raw_user_id@zone_id
}

message s2c_user_relogin
{
	int32 error = 1;	// 0 = 重连成功, 非 0 = 失败
	string err_msg = 2;
}

enum kick_type
{
	login = 1;	// 异地登录
	server = 2;	// 服务器维护
	banned = 3;	// 封禁账号
	reboot = 4; // 重启
}

message s2c_kick_session
{
	kick_type type = 1;	// 类型
	string params = 2;	// 参数
}

// 用于创角、选角界面的玩家信息
message mini_player_data_t
{
	int64 player_id = 1;
	bytes name = 2;
	int64 profession = 3;
	int64 level = 4;
	int64 last_logout_time = 5;
}

message c2s_query_player_list
{
}

message s2c_ret_query_player_list
{
	repeated mini_player_data_t players = 1;		// 玩家列表
}

message c2s_create_player
{
	int64 profession = 1;
	bytes name = 2;
}

message s2c_ret_create_player
{
	mini_player_data_t player = 1;
}

message c2s_enter_world
{
	int64 player_id = 1;
}

message s2c_notify_player_data
{
	player_t player = 1;
	group_t group = 2;
	combat_data_t combat_data = 3;
	main_offline_rewards_t main_offline_rewards = 4;
}

message s2c_notify_enter_world
{
	int64 server_cur_time = 2;
	int32 game_type = 3;
}

message s2c_player_properties_update
{
	properties_t player_properties = 1;
}

message c2s_gm_cmd
{
    bytes cmd = 1;
	repeated bytes args = 2;
}

/***************************玩家信息************************/
// 用于列表显示的玩家信息
message player_list_data_t
{
	int64 player_id = 1;
	bytes name = 2;
	uint32 level = 3;
	uint32 icon = 4;
	bool online = 5;
	uint64 offline_timestamp = 6;
	uint64 combat_value = 7;
	uint64 position = 8;						// 职位 见group_member_position_type
	uint64 pet_id = 9;
	uint64 pet_research_level = 10;				
	uint64 day_main_boss_count = 11;			// 当日挑战boss成功数量
	uint64 recent_days_main_boss_count = 12; 	// 最近n天挑战boss成功数量
	uint64 address = 13; // 位置
	uint64 gender = 14; // 性别
	int64 profession = 15; // 职业
	bytes clan_name = 16; // 部落 name
	uint64 clan_flag_id = 17; // 部落旗帜
	int64 offline_combat_value 	= 18;	// 离线战斗力数据
	int64 main_progress 	= 19;	// 地图进度
	uint64 gold_expiration_time = 20;	// 金手指过期时间
	map<int64, simple_equip_data_t> equipss = 21;	// 装备数据， map<装备槽位, simple_equip_data_t>
}

// 简单宝石数据
message simple_gem_t
{
	int64 color = 1;								// 宝石孔颜色
	int64 template_id = 2;							// 宝石模板id
	int64 process_count = 3;						// 宝石加工次数
	int64 max_process_count = 4;					// 宝石最大可加工次数
	int64 best_slot = 5;							// 宝石最佳装备部位 
	repeated gem_addition_t gem_additions = 6;		// 宝石附加项，数组每一项为一次加工的效果
}

// 简单装备数据
message simple_equip_data_t
{
	int64 template_id = 1;							// 装备模板id
	int64 base_attr_value = 2;						// 基础属性值
	int64 intensify_level = 3;						// 强化等级
	repeated simple_gem_t gems = 4;					// 宝石
}

// 宠物简单数据
message pet_simple_data_t 
{
	int64 pet_id 								= 1;
	map<int64, float> talents 					= 2;	// 资质
	map<int64, pet_skill_data_t> skills 		= 3;	// map<技能槽id, pet_skill_data_t>
	int64 star									= 4;	// 星级
	int64 quality 								= 5; 	// 品质
}

// 简单玩家数据
message simple_player_data_t
{
	int64 player_id = 1;		 	// 玩家 ID
	bytes name = 2;				 	// 玩家名字
	int64 level = 3;			 	// 等级
	int64 profession = 5;		 	// 职业
	bool online = 6;			 	// 是否在线
	int64 last_logout_time = 7;	 	// 上次离线时间
	int64 main_progress = 8;	 	// 地图进度
	int64 fans_num = 9;	 			// 关注这个玩家的好友的数目
	
	// 宠物
	int64 research_level = 10; 		// 研究等级
	int64 fight_pet = 11; 			// 出战宠物id 0：没有宠物出战
	pet_simple_data_t pet = 12; 	// 宠物 fight_pet为0时，pet为空
	uint64 combat_value = 13;		// 战斗力

	// 队伍
	bytes group_maser_name = 20; 		// 队长名字
	uint64 group_main_progress = 21; 	// 队伍地图进度
	uint64 group_id = 22; 				// 队伍ID
	uint64 recent_days_main_boss_count = 23; 	// 最近7天挑战boss成功数量

	// 主题
	uint64 action_id = 30;		// 动作ID
	uint64 border_id = 31;		// 边框ID
	uint64 background_id = 32;	// 背景ID

	// 装备
	map<uint32, float> atts = 40;					// 玩家属性
	map<int64, simple_equip_data_t> equipss = 41;	// 装备数据， map<装备槽位, simple_equip_data_t>
	map<int64, skill_data_t> skills = 42;			// 技能数据， map<技能槽位, skill_data_t>

	// 个人设置
	uint64 address_id = 50; 		// 位置ID  前32位表示一级地址，后32位表示二级地址
	uint64 icon = 51;				// 头像ID
	uint64 icon_border_id = 52;		// 头像框ID
	uint64 gender = 53;				// 性别 
	uint64 chat_bubble_id = 54; 	// 聊天气泡ID
	uint64 title_id = 55; 			// 称号ID

	// 成就
	uint64 achievement_level = 60; // 成就等级

	// 部落
	bytes clan_name = 70; 						// 部落名字
	uint64 clan_flag_id = 71;					// 旗帜ID
}

// 获取玩家简要信息
message c2s_get_simple_player_data
{
	int64 player_id = 1;
}

// 获取玩家简要信息返回
message s2c_ret_get_simple_player_data
{
	simple_player_data_t data = 1;
}

/**************************队伍*****************************/
enum group_member_position_type
{
	Common = 0;				// 普通成员
	SubMaster = 1;			// 副队长
	Master = 2;				// 队长
}

message combat_skill_data_t
{
	uint64 id = 1;
	uint64 level = 2;
}

// 成员数据
message group_member_data_t
{
	player_list_data_t list_data = 1;					// 列表数据
	repeated uint64 gold_finger_players = 2;			// 金手指授权给谁
	skill_system_t skill_system = 3;					// 金手指技能配置
	finger_pet_t  gold_pet_data = 4;					// 宠物金手指数据
}

// 队伍加入验证类型
enum group_vertification_type
{
	gvt_need_verify = 1;						// 验证可加入
	gvt_combat_5 = 2;							// 队伍战力相差5%
	gvt_combat_10 = 3;							// 队伍战力相差10%
	gvt_combat_15 = 4;							// 队伍战力相差15%
	gvt_combat_20 = 5;							// 队伍战力相差20%
}

// 申请进入队伍数据
message group_join_t
{
	player_list_data_t data = 1;
	uint64 timestamp = 2;
}

// 邀请数据
message group_invite_t
{
	group_list_data_t group = 1;
	uint64 timestamp = 2;
}

// 队伍列表数据
message group_list_data_t
{
	uint64 id = 1;									// group_id
	uint32 verification_type = 2; 					// 详见 group_vertification_type
	uint64 master_player_id = 3;					// 队长ID
	bytes base_info = 4;							// 基本信息
	bool online = 5;								// 是否在线
	repeated player_list_data_t members = 6;		// 队员信息
	repeated uint32 need_professions = 7;		    // 需求职业,详见profession_type
	int64 group_main_progress 	= 8;	// 地图进度
	bytes group_name = 9;	// 队长名字
	bool is_secret = 10;	// 私密小队
}

enum group_msg_type
{
	group_msg_player_online_t = 1;
	group_msg_update_map_progress_t = 2;
	group_msg_get_res_t = 3;
}

message member_base_msg_t
{
	int64 player_id = 1;		 	// 玩家 ID
	bytes name = 2;				 	// 玩家名字
	int64 level = 3;			 	// 等级
	int64 profession = 5;		 	// 职业
	uint32 icon = 4;				// 头像
}

message group_msg_player_online_t
{
	member_base_msg_t base_msg = 1 ;		// 基础信息
	bool online = 2;						// 是否在线

}

message group_msg_update_map_progress_t
{
	member_base_msg_t base_msg = 1 ;	// 基础信息
	uint64 map_id = 2;	// 当前关卡
	uint64 count = 3; // 累计数量
}

message group_msg_get_res_t
{
	member_base_msg_t base_msg = 1 ;	// 基础信息
	repeated resource_t res = 2;
}

message group_msg_t
{
	uint64 msg_type = 1;  // 见group_msg_type
	bytes msg_data = 2;
	uint64 timestamp = 3;
}

message s2c_update_group_msg
{
	group_msg_t msg = 1;
}

// 队伍数据
message group_t
{
	uint64 id = 1;									// group_id
	uint64 master_player_id = 3;					// 队长ID
	bytes base_info = 4;							// 基本信息
	bool is_secret = 5;								// 是否变更为秘密小队
	bytes password = 6;								// 密码
	uint32 verification_type = 7; 					// 详见 group_vertification_type
	repeated uint32 need_professions = 8;		    // 需求职业,详见profession_type
	repeated group_join_t join_requests = 9;		// 加入队伍的申请
	repeated group_invite_t invitations = 10;		// 加入队伍邀请
	repeated group_member_data_t members = 11;		// 成员数据
	repeated uint64 robots = 12;					// 机器人ID列表
	repeated group_msg_t msgs = 13;					// 队内信息
	bool matching = 14;
	uint32 match_verification_type = 15; 			// 详见 group_vertification_type
	repeated uint32 match_need_professions = 16;	// 需求职业,详见profession_type
	int64 group_main_progress 	= 17;	// 地图进度
	bytes group_name = 18;	// 队长名字
	uint64 combat_cost_time = 19;
	bool searching = 20;
	bool refresh = 21;		// 成员刷新标识
	map<uint64, uint64>  requested_group = 22;					// 申请过的队伍 map<group_id, 时间戳>
}

// 变更队伍
message s2c_change_group
{
	group_t group = 1;
}

// 更新队员数据
message s2c_update_member
{
	group_member_data_t member = 1;				// 成员数据
}

message s2c_delete_member
{
	uint64 player_id = 1;						// 玩家ID
	repeated uint64 robots = 2;					// 机器人ID列表
}

// 获取队伍列表
message c2s_get_groups
{
	uint64 target_id = 1;
}

// 获取队伍列表返回
message s2c_ret_get_groups
{
	repeated group_list_data_t groups = 1;
}

// 申请加入队伍
message c2s_group_join
{
	uint64 id = 1;
	bytes password = 2;
}

// 申请加入队伍返回
message s2c_ret_group_join
{
	map<uint64, uint64>  requested_group = 1;					// 申请过的队伍 map<group_id, 时间戳>
}

// 通知队员有加入申请,或删除申请
message s2c_notify_request
{
	group_join_t player_data = 1; 			
}

message s2c_delete_request
{
	uint64 player_id = 1;					// 玩家ID
}

message s2c_clear_request
{
	bool is_full			= 1;  // 当前队伍已满，通知同队人员清理请求
}

// 通知自己更新申请过的队伍列表
message s2c_notify_update_my_request
{
	uint64 del_group_id				= 1;
}

// 处理申请
message c2s_join_answer
{
	uint64 player_id = 1;					// 玩家ID
	bool allow = 2;							// 是否同意进入队伍
}

// 处理申请返回
message s2c_ret_join_answer
{
}

// 邀请加入队伍
message c2s_group_invite
{
	uint64 target_player_id = 1;
}

// 邀请加入队伍返回
message s2c_ret_group_invite
{
}

// 提醒被邀请人有邀请, 或者删除邀请
message s2c_notify_group_invite
{
	group_invite_t group = 1; // add == false时只有 id 有效
}

message s2c_delete_group_invite
{
	uint64 group_id = 1;
}

// 处理邀请
message c2s_handle_invite
{
	uint64 group_id = 1;
	bool enter = 2;
}

// 处理邀请返回
message s2c_ret_handle_invite
{

}

// 匹配队友
message c2s_match_member
{
	uint32 verification_type = 3; 					// 详见 group_vertification_type
	repeated uint32 need_professions = 4;			// 需求职业,详见profession_type
}

// 匹配队友返回
message s2c_ret_match_member
{
	uint32 verification_type = 1; 					// 详见 group_vertification_type
	repeated uint32 need_professions = 2;			// 需求职业,详见profession_type
}

// 退出队伍
message c2s_group_exit
{
}

// 退出队伍返回
message s2c_ret_group_exit
{
}

// 设置招募条件
message c2s_group_set_recruitment
{
	bytes base_info = 1;							// 基本信息
	bool is_secret = 2;								// 是否变更为秘密小队
	uint32 verification_type = 3; 					// 详见 group_vertification_type
	repeated uint32 need_professions = 4;			// 需求职业,详见profession_type
	bytes password = 5;								// 密码
}

// 设置招募条件
message s2c_ret_group_set_recruitment
{
}

// 更新招募条件
message s2c_update_group_set_recruitment
{
	bytes base_info = 1;							// 基本信息
	bool is_secret = 2;								// 是否变更为秘密小队
	uint32 verification_type = 3; 					// 详见 group_vertification_type
	repeated uint32 need_professions = 4;			// 需求职业,详见profession_type
	bytes password = 5;								// 密码
}

// 变更队长
message s2c_update_group_master
{
	uint64 master_id = 1;
}

message s2c_update_member_online
{
	uint64 player_id = 1;
	bool online = 2;
	uint64 offline_timestamp = 3;
}

message c2s_get_group_data
{
	uint64 group_id = 1;
}

message s2c_ret_get_group_data
{
	group_list_data_t data = 1;
}

// 获取玩家
message c2s_group_find_players
{
}

// 获取玩家返回
message s2c_ret_group_find_players
{
	repeated player_list_data_t players = 1;
}

// 踢人
message c2s_group_kick_member
{
	uint64 player_id = 1;
}

// 踢人返回
message s2c_ret_group_kick_member
{
}

// 成为队长
message c2s_group_become_master
{
}

// 成为队长返回
message s2c_ret_group_become_master
{
}

// 授权金手指
message c2s_group_gold_finger
{
	repeated uint64 player_ids = 1; 
}

// 授权金手指返回
message s2c_ret_group_gold_finger
{
}

// 授权金手指返回
message s2c_update_member_gold_finger
{
	uint64 player_id = 1;
	uint64 gold_expiration_time = 2;
	repeated uint64 player_ids = 3; 
}

// 设置队员职位
message c2s_group_set_position
{
	uint64 player_id = 1;
	uint64 position = 2; // 见group_member_position_type
}

// 设置队员职位返回
message s2c_ret_group_set_position
{
}

// 更新玩家职位
message s2c_update_group_member_position
{
	uint64 player_id = 1;
	uint64 position = 2; // 见group_member_position_type
}

// 金手指配置技能
message c2s_group_gold_configure_skill
{
	uint64 player_id 						= 1;
    int64 configure_type                    = 3;        // 配置类型，见枚举 skill_configure_type
    map<int64, int64> slots                 = 4;        // map<slot, skill_id>
}

// 金手指配置
message s2c_ret_group_gold_configure_skill
{
}

// 更新队员技能配置
message s2c_update_member_configure_skill
{
	uint64 player_id 						= 1;
    int64 configure_type                    = 3;        // 配置类型，见枚举 skill_configure_type
    map<int64, int64> slots                 = 4;        // map<slot, skill_id>
}

// 金手指配置上阵宠物
message c2s_group_gold_configure_pet
{
	uint64 player_id = 1;
	uint64 pet_id = 2;
}

// 金手指配置技能返回
message s2c_ret_group_gold_configure_pet
{
}

message s2c_update_member_gold_configure_pet
{
	uint64 player_id = 1;
	uint64 pet_id = 2;
}

// 通关队伍数据
message c2s_through_group_info
{
}

message s2c_through_group_info
{
	combat_data_t last_through_combat = 1;
	combat_data_t low_through_combat = 2;
}

// 更新队伍成员工会信息
message s2c_update_group_member_clan
{
	uint64 player_id = 1;
	bytes clan_name = 2; // 部落 name
	uint64 clan_flag_id = 3; // 部落旗帜
}

// 更新队伍成员刷新标识
message s2c_update_group_member_refresh
{
	bool refresh = 1;		// 刷新标识
}

// 更新队伍累计推图
message s2c_updaue_member_main_recent
{
	uint64 player_id = 1;
	uint64 day_main_boss_count = 2;			// 当日挑战boss成功数量
	uint64 recent_days_main_boss_count = 3; 	// 最近n天挑战boss成功数量
}
/**************************队伍结尾*****************************/

// 邮件
message mail_t
{
	int64 mail_id = 1;
	bool is_client_text = 2;				// true 代表邮件里的文字配置在客户端，用key进行查找，false 代表文字是服务器传给客户端的
	bytes sender = 3;						// 发件人							
	bytes title = 4;						// 标题
	bytes content = 5;						// 邮件内容
	repeated bytes content_params = 6;		// 邮件内容参数
	repeated resource_t affixs = 7;			// 附件
	bool is_read = 8;						// 是否已读
	bool is_take_affix = 9;					// 是否已经领取附件
	int64 send_time = 10;					// 发送时间
	int64 expiration_time = 11;				// 过期时间
	item_data_t detail_item_affix = 12;		// 带物品详细数据的附件（现在是交易行的拍品会用到）
	int64 config_id					= 13;	// 配置表id 当is_client_text为true时有效
}

enum mail_type 
{
	test 						= 1;
	auction_refund				= 11001;	// 【交易行】【竞拍】其他玩家出了竞拍价给出过价的人退钱
	fixed_selled				= 11002;	// 【交易行】【竞拍】一口价卖出给东西的邮件
	fixed_selled_refund			= 11003;	// 【交易行】【竞拍】其他玩家一口价买走退钱邮件
	fixed_selled_pay			= 11004;	// 【交易行】【竞拍】一口价卖出给钱邮件
	Off_shelf_return			= 11005;	// 【交易行】【竞拍】没人买手动下架退货邮件
	auction_selled				= 11006;	// 【交易行】【竞拍】竞拍到期卖出给东西邮件
	auction_selled_pay			= 11007;	// 【交易行】【竞拍】竞拍到期卖出给钱邮件
	auction_noselled_return		= 11008;	// 【交易行】【竞拍】没人买到期系统自动下架道具退回邮件
	smuggled_goods_selled		= 12001;	// 【交易行】【私货】购买成功邮件
	smuggled_goods_sell_fail	= 12002;	// 【交易行】【私货】出价失败邮件
	clan_collection_reward		= 21001;	// 【部落】【部落采集】任意异常导致的采集奖励无法正常获取时的发放形式
	clan_warfare_auction		= 22002;	// 【部落】【部落战】部落战竞拍结束后资金回退通知（无附件，仅通知）
	clan_territory_auction_return = 23003;	// 【部落】【领地拍卖】部落领地竞拍结束后资金回退（无附件，仅通知）
}
enum Affix_type 
{
	configure		= 1;	// 读取配置表
	calculation		= 2;	// 程序计算
}
// 查询邮件列表
message c2s_query_mail
{
}

message s2c_ret_query_mail
{
	repeated mail_t mails = 1;
}

// 读邮件
message c2s_read_mail
{
	int64 mail_id = 1;
}

message s2c_ret_read_mail
{
	int64 mail_id = 1;
}

// 领取邮件附件
message c2s_take_mail_affix
{
	int64 mail_id = 1;
}

message s2c_ret_take_mail_affix
{
	int64 mail_id = 1;
	repeated resource_t rewards = 2;	// 奖励列表
}

// 删除邮件
message c2s_remove_mail
{
	int64 mail_id = 1;
}

message s2c_ret_remove_mail
{
	int64 mail_id = 1;
}

// 一键删除所有没有未领取附件并且已读的邮件
message c2s_one_key_remove_mail
{
}

message s2c_ret_one_key_remove_mail
{
	repeated int64 remove_mails = 1;
}

message c2s_one_key_receive_mail
{
}

message s2c_ret_one_key_receive_mail
{
	repeated int64 received_mail_ids = 1;
	repeated resource_t rewards = 2;	// 奖励列表
}

// gm 发邮件
message c2s_gm_send_mail
{
	// 1 给自己发邮件
	// 2 根据 player_id 给指定玩家发邮件
	// 3 给 player_id 发离线邮件
	// 4 加载离线邮件
	// 5 通过邮件服务器给玩家发邮件
	int64 cmd = 1;			
	mail_t mail = 2;
	int64 player_id = 3;
	bytes user_id = 4;
}

message s2c_ret_gm_send_mail
{
}

/****************************聊天信息**********************************************/
enum server_status 
{
	idle			= 1;	// 空闲
	crowded			= 2;	// 拥挤
	full			= 3;	// 爆满
}

enum chat_type 
{
	channel				= 1000;	// 1000以下是频道聊天id
	special				= 1001; // 特色频道
	tribe				= 1002; // 部落聊天
	group				= 1003;	// 队伍聊天
}

message player_info 
{
	int64 player_id					= 1;
	bytes name						= 2;
	int64 profession 				= 3;
	int64 level 					= 4;
	uint32 icon 					= 5;
	int64 last_logout_time 			= 6;
	int32 group_position 			= 7; 		// 0-普通队员，1-队长 2 副队长
	bool online 					= 8;		// 是否在线
}

message room_data_t 
{
	int64 room_id			= 1;
	bytes room_name			= 2;
	int32 server_status 	= 3;
}

message c2s_show_all_channel
{
}

message s2c_ret_show_all_channel
{
	map<int64, room_data_t> public_channels		 			= 1;	// 公共频道 map<room_id, room_data_t>
	map<int64, room_data_t> special_channels		 		= 2;	// 特色频道 map<room_id, room_data_t>
	int64 tribe_id											= 3;	// 部落id
}

message c2s_shield_player
{
	int64 player_id					= 1;
}

message s2c_ret_shield_player
{
	player_info player				= 1;
}

message c2s_cancel_shield_player
{
	int64 player_id					= 1;
}

message s2c_ret_cancel_shield_player
{
	bytes name						= 1;
	int64 player_id					= 2;
}

message c2s_show_blacklist
{
}

message s2c_ret_show_blacklist
{
	map<int64, player_info> shield_players 				= 1;	// 黑名单
}

message channel_chat_data_t
{
	player_info player		= 1;
	bytes msg 				= 2;
	int64 timestamp			= 3;
}

message c2s_chat_msg_send
{
	int32 room_type			= 1;
	bytes msg 				= 2;
	int64 room_id			= 3;
}

message s2c_ret_chat_msg_send
{
}

message s2c_notify_chat_room_msg
{
	int64 room_type 			= 1;
	channel_chat_data_t data		= 2;
}

message c2s_change_channel_id
{
	int64 target_room_type 			= 1;	// 公共频道、特色频道
	int64 target_channel_id		= 2;
}

message s2c_ret_change_channel_id
{
	int64 channel_type 					= 1;
	int64 channel_id					= 2;
	repeated channel_chat_data_t msgs 	= 3;	
}

// 【私聊】添加聊天标签
message c2s_chat_add_friend_tag 
{
	int64 player_id				= 1;
}

message s2c_ret_chat_add_friend_tag 
{
	int64 player_id				= 1;
	player_info tag 					= 2;	// map<player_id, player_info>	
	int64 del_player_id					= 3;	// 聊天列表达到上限，删除的player_id
}

message c2s_chat_del_friend_tag 
{
	int64 player_id						= 1;
}

message s2c_ret_chat_del_friend_tag 
{
	int64 player_id				= 1;
}

message s2c_notify_friend_tag
{
	map<int64, player_info> tag 		= 1;	// map<player_id, player_info>	
	repeated int64 del_player_ids	= 2;	// 聊天列表达到上限，删除的player_id
}

// 发送信息
message c2s_chat_friend_send
{
	int64 recipient_player_id		= 1;
	bytes msg 						= 2;
}

// 收到回复后 前端保存在本地，否则前端感叹号标记状态、或者重复发送
message s2c_ret_chat_friend_send
{
	int64 recipient_player_id				= 1;
	friend_chat_data_t msgs  				= 2;
}

message s2c_notify_friend_msg
{
	map<int64, friend_chat_player_t> chat_datas 	= 1;  //map<sender_player_id, friend_chat_player_t>
}

message friend_chat_data_t
{
	int64 chat_id						= 1;
	bytes msg 							= 2;
	uint64 timestamp 					= 3;
}

message friend_chat_player_t
{
	player_info sender_player 				= 1;
	int64 max_chat_id						= 2;
	repeated friend_chat_data_t msgs 		= 3;
}

message c2s_query_friend_chat_data
{
}

message s2c_ret_query_friend_chat_data
{
	map<int64, friend_chat_player_t> chat_datas 	= 1;  //map<sender_player_id, friend_chat_player_t>
}

message c2s_read_friend_chat_data					// 正在聊天界面也要发送确认
{
	int64 sender_player_id			= 1;
	int64 max_chat_id				= 2; 
}

message s2c_ret_read_friend_chat_data
{
	int64 sender_player_id			= 1;
}

// 举报
message c2s_report_player
{
	int64 player_id			= 1;
}
message s2c_ret_report_player
{
	int64 player_id			= 1;
}

/******************************* 属性开始 *************************/
message attribute_t
{
	map<uint32, float> atts = 1;
}

message s2c_update_attributes
{
	map<uint32, float> atts = 1;			// 只更新变化的属性
}
/******************************* 属性结束 *************************/

/*******************好友系统**********************/
enum attention_status 							// fb_db 只存在attention、mutual两种状态，fans是给前端显示区分用
{
	none									= 1; // 互相没有关注
	attention								= 2; // 我关注对方
	fans 									= 3; // 对方关注了我
	mutual									= 4; // 互相关注
}

// 用于好友列表信息
message friend_t {
	bytes name 					= 1;
	int64 profession 			= 2;
	int64 level 				= 3;
	uint32 icon 				= 4;
	int64 frame					= 5;
	int64 title					= 6;
	int32 fan_num 				= 7;
	int64 location 				= 8;
	int64 last_logout_time 		= 9;
	int64 player_id				= 10;
	bool online_status			= 11;				// 在线状态
	int64 attention_status		= 12;				// 关注状态
}
message fans_friend_t {
	friend_t friend_info 		= 1;
	bool is_read				= 2;
}
message c2s_query_my_attention
{
}
message s2c_ret_query_my_attention
{
	repeated friend_t my_attentions 		= 1;
}
message c2s_query_my_fans
{
	int64 index							= 1;
}
message s2c_ret_query_my_fans
{
	repeated fans_friend_t my_fans 		= 1;
}
// 推荐好友
message c2s_recommend_friend
{
	bool is_refresh					= 1;	// 是否是刷新按钮
}
message s2c_ret_recommend_friend
{
	repeated friend_t players 		= 1;
}
message c2s_search_friend
{
	bytes factor					= 1;
}
message s2c_ret_search_friend
{
	repeated friend_t players 				= 1;
}

message c2s_pay_attention_friend
{
	int64 friend_player_id				= 1;
}
message s2c_ret_pay_attention_friend
{
	bytes name 					= 1;
}

message s2c_notify_fans_update 
{
	friend_t friend 		= 1;
}

message c2s_cancel_attention_friend
{
	int64 friend_player_id				= 1;
}
message s2c_ret_cancel_attention_friend
{
	bytes name 					= 1;
}

message c2s_modify_player_name
{
	bytes name = 1;
}

message s2s_ret_modify_player_name
{
}

message c2s_client_setting
{
	bytes setting_data = 1;
}

message s2c_ret_client_setting
{
}


// 同步物品添加
message s2c_add_item
{
	item_data_t item = 1;
}

// 同步物品删除
message s2c_remove_item
{
	int64 item_id = 1;
}

// 同步物品更新
message s2c_item_properties_update
{
	int64 item_id = 1;
	properties_t item_properties = 2; 
}

// 同步装备槽位数据
message s2c_equip_slot_update
{
	uint64 player_id = 1;
	uint64 slot = 2;
	uint64 item_id = 3;
	simple_equip_data_t slot_data = 4;
}

// 穿装备
message c2s_equip_up
{
	int64 slot = 1;
	int64 item_id = 2;
}

message s2c_ret_equip_up
{
	int64 slot = 1;
	int64 item_id = 2;
}

// 卸装备
message c2s_equip_down
{
	int64 slot = 1;
}

message s2c_ret_equip_down
{
	int64 slot = 1;
}

// 设置装备是否锁定
message c2s_equip_lock
{
	int64 item_id = 1;
	int64 lock = 2;
}

message s2c_ret_equip_lock
{
	int64 item_id = 1;
}

// 装备强化
message c2s_equip_intensify
{
	int64 item_id = 1;						// 强化目标
	int64 material_equip = 2;				// 作为材料吃掉的装备
}

message s2c_ret_equip_intensify
{
	int64 item_id = 1;
	bool is_success = 2;					// 是否成功
	int64 old_intensify_level = 3;			// 强化之前的等级
	int64 rand_value = 4;					// 强化随机数（1到10000）
}

// 宝石加工
message c2s_gem_process
{
	int64 item_id = 1;
}

message s2c_ret_gem_process
{
	int64 item_id = 1;
}

// 更新宝石孔信息
message s2c_update_gem_slot
{
	int64 equip_id = 1;				
	int64 slot = 2;						
	gem_slot_t slot_data = 3;				
}

// 给装备开宝石孔
message c2s_open_gem_slot
{
	int64 equip_id = 1;	
	int64 slot = 2;	
	map<int64, int64> cost_materials = 3;		// 消耗材料 map<物品模板id, 数量>
}

message s2c_ret_open_gem_slot
{
	int64 equip_id = 1;	
	int64 slot = 2;	
}

// 装备镶嵌、拆卸
message c2s_inlay_gem
{
	int64 equip_id = 1;	
	int64 slot = 2;	
	int64 gem_id = 3;			// 宝石物品id，为0时表示卸下
}

message s2c_ret_inlay_gem
{
	int64 equip_id = 1;	
	int64 slot = 2;	
}

// 全部每日任务数据同步
message s2c_all_daily_quest_update
{
	map<int64, daily_quest_t> daily_quests = 1;		// 每日任务
	repeated int64 take_daily_rewards = 2;			// 已经领取的每日任务积分奖励
}

// 全部每周任务数据同步
message s2c_all_week_quest_update
{
	map<int64, week_quest_t> week_quests = 1;		// 每周任务
	repeated int64 take_week_rewards = 2;			// 已经领取的每日任务积分奖励
}

// 通知每日任务已完成
message s2c_daily_quest_update
{
	int64 quest_id = 1;			// 任务 id（DailyMission 表中的 id）
}

// 更新每周任务的完成次数
message s2c_week_quest_update
{
	int64 quest_id = 1;			// 任务 id（WeekMission 表中的 id）
	int64 count = 2;			// 已完成次数
}

// 领取每日任务奖励
message c2s_take_daily_quest_reward
{
	int64 quest_id				= 1;	
}

message s2c_ret_take_daily_quest_reward
{
	int64 quest_id					= 1;
	int64 add_score					= 2;	// 获得积分
	repeated resource_t rewards 	= 3;	// 奖励列表
}

// 领取每日任务积分奖励
message c2s_take_daily_quest_score_reward
{
	int64 index				= 1;	
}

message s2c_ret_take_daily_quest_score_reward
{
	int64 index						= 1;	
	repeated resource_t rewards 	= 2;	// 奖励列表
}

// 领取每周任务奖励
message c2s_take_week_quest_reward
{
	int64 quest_id				= 1;	
}

message s2c_ret_take_week_quest_reward
{
	int64 quest_id					= 1;
	int64 add_score					= 2;	// 获得积分
	repeated resource_t rewards 	= 3;	// 奖励列表
}

// 领取每周任务积分奖励
message c2s_take_week_quest_score_reward
{
	int64 index				= 1;	
}

message s2c_ret_take_week_quest_score_reward
{
	int64 index						= 1;	
	repeated resource_t rewards 	= 2;	// 奖励列表
}

// 设置或改变许愿奖励目标
message c2s_change_wishpool_target
{
	int64 wishpool_id				= 1;	// 许愿奖励id（WishpoolReward表的id）
}

message s2c_ret_change_wishpool_target
{
	int64 wishpool_id				= 1;	// 许愿奖励id（WishpoolReward表的id）
}

// 许愿
message c2s_wishpool
{
}

message s2c_ret_wishpool
{
	bool critical					= 1;	// 是否暴击
	int64 add_score					= 2;	// 增加了多少积分	
}

// 领取许愿奖励
message c2s_take_wishpool_reward
{
	int64 index				= 1;	
}

message s2c_ret_take_wishpool_reward
{
	int64 index						= 1;	
	repeated resource_t rewards 	= 2;	// 奖励列表
}

// 添加技能或更新技能数据
message s2c_update_skill_data
{
	skill_data_t skill_data						= 1;	
}

// 更新技能槽位
message s2c_update_skill_slot
{
	int64 configure_type						= 1;	// 配置类型，见枚举 skill_configure_type
	skill_slot_t skill_slot						= 2;	
}

// 吞技能卡
message c2s_eat_skill_card
{
	map<int64, int64> materials = 1;		// 材料， map<物品配置id，数量>
}

message s2c_ret_eat_skill_card
{
}

// 技能突破
message c2s_skill_star_up
{
	int64 skill_parent_id = 1;		// 技能类id  （对应 ParentID 字段， 通过 ParentID*10+品质 可以得到技能id）
}

message s2c_ret_skill_star_up
{
}

// 将技能配置在槽位上
message c2s_configure_skill
{
	int64 configure_type			= 1;	// 配置类型，见枚举 skill_configure_type
	int64 slot						= 2;	// 槽位
	int64 skill_parent_id 			= 3;	// 技能类id  （对应 ParentID 字段， 通过 ParentID*10+品质 可以得到技能id）
}

message s2c_ret_configure_skill
{
}

// 配置多个技能
message c2s_configure_multi_skill
{
	int64 configure_type			= 1;	// 配置类型，见枚举 skill_configure_type
	map<int64, int64> slots 		= 2;	// map<slot, skill_parent_id>
}

message s2c_ret_configure_multi_skill
{
}

// 职业进阶
message c2s_profession_advanced 
{
	int64 profession_id 		 = 1; 			// 只在转职时使用
}

message s2c_ret_profession_advanced
{
}

message s2c_clear_talent
{
}

message c2s_change_profession 
{
	int64 profession_id 		 = 1; 
}

message s2c_ret_change_profession
{
}

// 天赋
message c2s_commit_talent
{
	int64 talent_id					= 1;
}

message s2c_ret_commit_talent
{
}

message s2c_notify_update_talent
{
	int64 talent_id 			= 1;
	int64 count 				= 2;
}


// 提交属性点分配
message c2s_commit_attr_point
{
	map<int64, int64> add_attr_points = 1;		// 加的属性 key为加点类型（即1、2、3），value为加了多少点	
}

message s2c_ret_commit_attr_point
{
}

// 重置属性点
message c2s_reset_attr_point
{
}

message s2c_ret_reset_attr_point
{
}


//====战报协议BEGIN==================================================
enum ecombat_type
{
	Hangup = 1;
	Boss = 2;
	Pvp = 3;
}

enum eactor_type
{
	Player = 1;
	Monster = 2;
	Robot = 3;
	Boss = 4;
	Pet = 5;
}

message battle_report_t
{
	int64             				cmd     = 1;      // 命令
	int64                           time    = 2;      // 时刻 ms
	bytes                           msg     = 3;      // 内容
}

message actor_info_t
{
	int32 			 actor_id    = 1; 	// 运行时id
	int32            template_id = 2; 	// 配置表id
	int32			 type        = 3; 	// player = 1, monster = 2, robot = 3, 4 = boss, 5 宠物 6召唤物
	bytes			 name        = 4; 	// player专属，其他读表
	int32 			 level       = 5; 	// 等级
	int32            index       = 6; 	// 站位
	int32			 camp        = 16;  // 1：蓝方（己方）， 2：红方（对方）
	map<int32,float> atts		 = 7; 	// 属性
	repeated int32   skills      = 12; 	// 技能
	uint64			 player_id   = 13;  // 玩家ID， 仅玩家可用
	uint64			 profession  = 14;  // 职业， 仅玩家可用
	bool			 online      = 15;  // 职业， 仅玩家可用
	float            less_hp_per    = 17;  //  剩余HP百分比
}

// 请求战斗数据
message c2s_main_report_list
{
}

// 返回战斗数据
message s2c_main_report_list
{
	combat_data_t data  = 1;
}

// 战斗数据
message combat_data_t
{
	uint64						id 				= 11;// 战斗ID
	int64 						time_start   	= 1; // 战斗开始时间
	int64 						time_end     	= 2; // 战斗结束
	int64 						time_current 	= 3; // 当前时间
	int32 						position_type	= 4; // 位置盘类型 1:挂机，2：Boss，3：PVP
	repeated actor_info_t 		self_group		= 5; // 己方队伍
	repeated actor_info_t 		enemy_group		= 6; // 敌方队伍
	repeated battle_report_t    reports 		= 7; // 战报
	uint64						over_progress   = 8; // 当前进度超过了百分之多少的玩家
	uint64						map_id			= 9; // 地图ID
	uint64 						cost_time 		= 10;// 从开始方第一个技能到结束的时间
	bool 						searching 		= 12;// 是否寻猎中
	uint64 						lead_map_id		= 13;// 领头队伍所在区域
	uint64 						lead_group_id   = 14;// 领头队伍ID
	uint64						combat_value    = 15;// 己方队伍战斗力
}

// 战场初始化
message r_battle_begin {
	int32 					battle_type = 1; // 战场玩法类型
}

// 战场清理
message r_battle_end 
{
	bool win = 1;
	uint64 next_report_time = 2;
}

message r_update_energy
{
	int32      instigator_id = 1;   // ActorID
	int32      target_id = 2;   	// 目标ActorID
	int32      energy = 3;  		// 当前能量
}

message r_spawn_actor
{
	actor_info_t 		info = 1; //actor信息
}

message r_active_skill
{
	int32      instigator_id = 1;  // ActorID
	uint32     skill_id      = 2;  // 技能ID
	uint32     target_id     = 3;  // 技能目标ID
	uint32     special_time  = 4;  // 蓄力, 吟唱时常
	uint32     guide_time    = 5;  // 引导时常
	bool 	   no_pre_time   = 6;  // 没有前摇
}

message r_update_buff
{
	int32 instigator_id  = 1;  // 谁
	float buff_id       = 2;  // 哪个Buff
	int32 disappear_time = 3;  // 消失时间ms
	int32 layer			 = 4;  // 层数
}

message r_hit_back
{
	int32 instigator_id = 1;  // 攻击者
	int32 target_id     = 2;  // 被攻击者
	float value         = 3;  // 击退时长s
}

message r_hit_float
{
	int32  instigator_id = 1;  // 攻击者
	int32  target_id     = 2;  // 被攻击者
	float  value         = 3;  // 浮空时长s
}

message r_silent
{
	int32  instigator_id = 1;  // 攻击者
	int32  target_id     = 2;  // 被攻击者
	float  value         = 3;  // 沉默时长s
}

message r_dizzy
{
	int32  instigator_id = 1;  // 攻击者
	int32  target_id     = 2;  // 被攻击者
	float  value         = 3;  // 眩晕时长s
}

message r_restore_hp
{
	int32  instigator_id = 1;  // 攻击者
	int32  target_id     = 2;  // 被攻击者
	int32  from_id       = 3;  // 技能或者buff的ID
	int32  from_type	 = 4;  // 1：技能，2：buff	
	float  value         = 5;  // 恢复量
}

message r_damage_hp
{
	int32  instigator_id = 1;  // 攻击者
	int32  target_id     = 2;  // 被攻击者
	int32  from_id       = 3;  // 技能或者buff的ID
	int32  from_type	 = 4;  // 1：技能，2：buff	
	float  value         = 5;  // 伤害量
	int32  crit			 = 6;  // 是否暴击
	float  delta_hp 	 = 7;  // 差值
}

message r_damage_ignore 
{ 	   // A打B的伤害被免疫
	int32  instigator_id = 1;  // A
	int32  target_id 	 = 2;  // B
}

message r_hit_ignore 
{ 		   // A硬直(击飞、浮空、眩晕)B，被格挡
	int32  instigator_id = 1;  // A
	int32  target_id 	 = 2;  // B
}

message r_hit_miss 
{ 		   //A 未命中 B
	int32  instigator_id = 1;  // A
	int32  target_id	 = 2;  // B
}

message r_break { 			   // A打断了B
	int32  instigator_id = 1;  // A
	int32  target_id     = 2;  // B
}

message r_update_shield { 	   // 护盾变化
	int32  instigator_id = 1;  // A
	float  value		 = 2;  // 值
}

message r_kuang_bao {
	int32  instigator_id = 1;  // A
	float  duration 	 = 2;  // 持续时长
}

// 召唤物消失
message r_disappear {
	int32  instigator_id = 1;  // A
}

enum report_command_type
{
	/**************Game*******************/
	r_battle_begin                       = 1    ; // 战斗开始
	r_battle_end                         = 2    ; // 战斗结束
	r_spawn_actor						 = 3	; // 创建Actor
	r_update_energy						 = 4	; // 更新actor的能量值
	r_kuang_bao							 = 5	; // 狂暴
	
	/*************技能&状态****************/
	r_active_skill                       = 11   ; // 激活技能
	r_update_buff						 = 13	; // buff更新
	r_disappear							 = 14	; // 召唤物消失

	r_hit_back                           = 23   ; // 击退
	r_hit_float                          = 24   ; // 浮空
	r_silent                             = 25   ; // 沉默
	r_dizzy                              = 26   ; // 眩晕
	/*************属性****************/
	r_restore_hp                         = 101   ; // 回血
	r_damage_hp                          = 102   ; // 伤害
	r_damage_ignore						 = 103	 ; // 伤害免疫
	r_hit_ignore						 = 104	 ; // 硬直免疫【格挡】
	r_hit_miss							 = 105	 ; // 闪避【未命中】
	r_break								 = 106	 ; // 打断
	r_update_shield						 = 107	 ; // 护盾值
}
//====战报协议END==================================================

//====宠物系统BEGIN================================================
// 金手指所需宠物信息
message attribute_content
{
	float data									= 1; // 属性值
	float talent_num 							= 2; // 天赋加成	
}
message pet_info_t 
{
	int64 pet_id 								= 1;
	map<int64, float> talents 					= 2;	// 资质
	map<int64, attribute_content> attribute		= 3;	// 属性
	map<int64, pet_skill_data_t> skills 		= 4;	// map<技能槽id, pet_skill_data_t>
	int64 star									= 5;	// 星级
	int64 quality 								= 6; 	// 品质
	int64 pet_template_id						= 7;	// 宠物配置id
}

message finger_pet_t 
{
	int64 research_level						= 1; // 研究等级
	int64 fight_pet								= 2; // 出战宠物id 0：没有宠物出战
	map<int64, pet_info_t> pets					= 4; 
}


// 捕捉
enum catch_type 
{
	delicacy_catch					= 1;  // 美食捕捉
	feast_catch						= 2;  // 盛宴捕捉 有盛宴捕捉券时自动扣券，否则自动扣珍珠
}

// 投掷美食
message c2s_pet_put_food
{
	int64 food_id 					= 1;
	int64 catch_type  				= 2;
}
message s2c_ret_pet_put_food
{
}

// 捕捉
message c2s_pet_catch
{

}

message s2c_ret_pet_catch
{
	repeated int64 pet_id 				= 1;  
}

message s2c_add_pet
{
	pet_t pet					= 1;
	
}

message s2c_pet_properties_update
{
	int32 pet_id						= 1;	// 宠物ID
	properties_t pet_properties			= 2;
}

message s2c_remove_pet
{
	int64 pet_id				= 1;
}

// 放弃（捕捉）
message c2s_pet_cancel_catch
{
}

message s2c_ret_pet_cancel_catch
{
}
// 加速 （捕捉）
message c2s_pet_speed_up_catch
{
}

message s2c_ret_pet_speed_up_catch
{
}

// 宠物放生
message c2s_pet_release
{
	repeated int64 pets			= 1;
}

message s2c_ret_pet_release
{
	repeated resource_t rewards 	= 1;	// 奖励列表
}

// 出战
message c2s_pet_battle
{
	int64 pet_id 				= 1;
}

message s2c_ret_pet_battle
{
	int64 pet_id 				= 1;
}

// 休息
message c2s_pet_rest
{

}

message s2c_ret_pet_rest
{
}

message pet_lock_status 
{
	int64 pet_id 				= 1;
	bool is_clock				= 2;
}
// 上锁
message c2s_pet_lock
{
	repeated pet_lock_status pets 				= 1;
}

message s2c_ret_pet_lock
{
}

// 升星
message c2s_pet_rising_star
{
	int64 master_pet_id 				= 1;
	int64 material_pet_id				= 2;
}

message s2c_ret_pet_rising_star
{
	
}
// 降星
message c2s_pet_falling_star
{
	int64 pet_id 						= 1;
}

message s2c_ret_pet_falling_star
{
	int64 pet_id 	 					= 1;
	int64 item_id						= 2;	// 宠物蛋
	int64 count 						= 3; 	// 宠物蛋数量
}

// 宠物装备技能
message c2s_pet_change_skill
{
	int64 pet_id 							= 1;
	int64 slot_id 							= 2;
	int64 skill_id 							= 3;
}


message s2c_ret_pet_change_skill
{
}

// 宠物装备技能改变通知
message s2c_notify_pet_change_skill
{
	int64 pet_id 							= 1;
	map<int64, int64> pet_skill_config 		= 2;	// 宠物技能 map<槽位id，技能id>
}

// 宠物研究加成类型
enum research_type 
{
	pet_addition							= 1; // 宠物属性加成（宠物攻击）
	pet_quality_addition					= 2; // 宠物资质结成
	open_slot								= 3; // 开启宠物技能槽
	player_addition							= 4; // 玩家属性加成
}

// 宠物研究
message c2s_pet_research
{
}

message s2c_ret_pet_research
{
}
// 宠物技能升级
message c2s_pet_skill_upgrade
{
	repeated int64 skill_id				= 1;		
}

message s2c_ret_pet_skill_upgrade
{
}

message s2c_notify_pet_skill_update
{
	map<int64, pet_skill_t> pet_skills 				= 1;	// 宠物技能 map<技能类型id, pet_skill_t>
}

message s2c_update_pet_research_addition 
{
	map<int64, float> research_additional			= 1; // 研究属性加成 map<属性id, 加成数值>
}
// 探险
enum adventure_type 
{
	ordinary							= 1;		// 普通探险
	high_level							= 2;		// 高级探险
}

message adventure_pets
{
	int64 adventure_point_id			= 1;		// 探险点
	map<int64, int64> battle_pets 		= 2;		// 派遣宠物map<slot_id, 宠物模板id>
}

// 宠物探险
message c2s_pet_adventure
{
	repeated adventure_pets adventures	= 1;
	int64 type 							= 2;		// adventure_type
}

message s2c_ret_pet_adventure
{
}

message s2c_notify_adventure_update
{
	map<int64, adventure_t>  adventure				= 1;	// 探险 map<探险点id, adventure_t>
}
// 宠物探险领取
message c2s_adventure_receive
{
	repeated int64 adventure_point_id			= 1;		// 探险点
}

message every_point_reward 
{
	int64 task_id					= 1;	
	repeated resource_t rewards 	= 2;	// 奖励列表
}

message s2c_ret_adventure_receive
{
	map<int64, every_point_reward>  rewards = 1; // map<探险点, 奖励>
}

// 取消探险
message c2s_pet_cancel_adventure
{
	int64 adventure_point_id			= 1;
}

message s2c_ret_pet_cancel_adventure
{
}

// 加速探险
message c2s_pet_speed_up_adventure
{
	int64 adventure_point_id			= 1;
}

message s2c_ret_pet_speed_up_adventure
{
}

// 刷新任务
message c2s_pet_adventure_refresh_task
{
	int64 adventure_point_id			= 1;
}

message s2c_ret_pet_adventure_refresh_task
{
	int64 adventure_point_id			= 1;
}


// 创建牧场
message c2s_pet_build_pasture
{
	int32 slot_id						= 1;
}

message s2c_ret_pet_build_pasture
{
	int32 slot_id						= 1;
}
// 牧场放置宠物
message c2s_pet_pasture_place
{
	int32 slot_id						= 1;
	int32 pet_id						= 2;	
}

message s2c_ret_pet_pasture_place
{
	map<int64, int32> pasture			= 1; // map<宠物栏id, 宠物id>
	map<int64, int64> additional		= 2; // 属性加成 map<属性id, 加成数值>
}

// 图鉴
message s2c_notify_atlas_update
{
	atlas_t  atlas						= 1;
}
//====宠物系统END==================================================


// =============================主线
// 设置地图掉落的列
message c2s_set_main_loot_field
{
	bytes field = 1;
}

// 设置地图掉落的列返回
message s2c_ret_set_main_loot_field
{
}

// 挑战boss
message c2s_challange_boss
{
}

// 挑战boss返回
message s2c_ret_challange_boss
{
	uint64 next_time = 1;
}

// 离线战斗奖励
message main_offline_rewards_t
{
	repeated resource_t res = 2;
	uint64 offline_time = 3;
}

// 通知正在寻猎
message s2c_main_searching
{
	bool searching = 1;		// 寻猎状态
}

// 请求 request
message c2s_main_report_request
{
}

// request返回
message s2c_main_report_request
{
	uint64 next_time = 1;
}
// =============================主线end


// 更新时装
message s2c_update_fashion
{
	fashion_t fashion = 1;
}

// 已穿戴时装整体更新（客户端可整体替换本地时装穿戴数据）
message s2c_update_fashion_slot
{
	map<int64, int64> fashion_slots = 1;	
}

// 穿时装
message c2s_fashion_up
{
	int64 slot = 1;
	int64 fashion_id = 2;
}

message s2c_ret_fashion_up
{
}

// 卸时装
message c2s_fashion_down
{
	int64 slot = 1;
}

message s2c_ret_fashion_down
{
}

// 买时装
message c2s_buy_fashion
{
	int64 fashion_id = 1; 			// 时装id
}

message s2c_ret_buy_fashion
{
	int64 fashion_id = 1; 			// 时装id
}

// 激活时装图鉴
message c2s_active_fashion_handbook
{
	int64 fashion_id = 1; 			// 时装id
}

message s2c_ret_active_fashion_handbook
{
}

message c2s_wardrobe_read_fashion
{
    repeated int64 fashion_id_list = 1; 			// 时装id
}

message s2c_wardrobe_read_fashion
{
}



// -------------------------------------秘境start-------------------------------------
// 秘境宝箱
message mystery_treasure_box_t
{
	uint64 treasure_box_id = 1;			// 宝箱 id
	uint32 config_id = 2;				// 配置表 id
	int64 open_time_stamp = 3;			// 开启时间
}
// 进入秘境
message c2s_enter_mystery
{
	uint32 mystery_id = 1;				// 秘境 id
}

message s2c_enter_mystery
{
	mystery_t mystery_info = 1;			// 秘境
}
// 离开秘境(离开视为放弃分数)
message c2s_leave_mystery
{
}

message s2c_leave_mystery
{
}
// 战前配置
message c2s_mystery_config
{
	uint64 member_id = 1;			// 成员 id
	uint64 pet_id = 2;				// 出战宠物
	map<int64, int64> slots = 3;	// 技能
}

message s2c_mystery_config
{
}
// 秘境挑战
message c2s_mystery_challenge
{
}

message s2c_mystery_challenge
{
	combat_data_t combat_data = 1;
	uint32 mystery_progress = 2;		// 秘境进度
	uint64 mystery_score = 3;			// 秘境积分
	float mystery_baoji = 4;			// 暴击倍率
}
// 秘境结算
message c2s_mystery_settlement
{
}

message s2c_mystery_settlement
{
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 1;	// 秘境宝箱 <槽位 , value>
}
// 移除宝箱
message c2s_mystery_remove_box
{
	uint32 treasure_box_id = 1;			// 宝箱 id
}

message s2c_mystery_remove_box
{
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 1;	// 秘境宝箱 <槽位 , value>
}
// 领取宝箱
message c2s_mystery_receive_box
{
	uint32 treasure_box_id = 1;			// 宝箱 id
}

message s2c_mystery_receive_box
{
	map<uint64,uint32> items = 1;		// 奖励
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 2;	// 秘境宝箱 <槽位 , value>
}
// 宝箱顺序
message c2s_mystery_update_box_slot
{
	uint64 src_id = 1;	// 宝箱 id
	uint64 dst_id = 2;	// 宝箱 id
}

message s2c_mystery_update_box_slot
{
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 1;	// 秘境宝箱 <槽位 , value>
}
// 宝箱加速
message c2s_mystery_box_fast
{
	uint32 treasure_box_id = 1;			// 宝箱 id
}

message s2c_mystery_box_fast
{
	map<uint64,uint32> items = 1;		// 奖励
	map<uint64, mystery_treasure_box_t> mystery_treasure_box = 2;	// 秘境宝箱 <槽位 , value>
}
// 秘境最低战力通关
message c2s_mystery_low_through_combat
{
}

message s2c_mystery_low_through_combat
{
		combat_data_t combat_data = 1;		// 战报
}

// 秘境更新队员配置
message c2s_mystery_update_config
{
}

message s2c_mystery_update_config
{
	map<uint64, group_member_data_t> mystery_member = 1;	// 秘境配置 <member_id, value>
}
// -------------------------------------秘境end---------------------------------------
// 拍卖品
message jobber_commodity_t
{
	int64 commodity_id = 1;					// 商品id （用于唯一标识一个拍卖品, 不是物品id）	
	item_data_t item = 2;					// 物品数据
	int64 cur_price = 3;					// 当前价格
	int64 fixed_price = 4;					// 一口价
	int64 over_time = 5;					// 拍卖结束时间（时间戳）
	int64 bid_player_id = 6;				// 最后出价的玩家
	bool is_over = 7;						// 是否结束拍卖
	int64 seller_player_id = 8;				// 售卖者
}

// 查询物品在交易行中的最低价格
message c2s_query_jobber_item_min_price
{
	int64 item_template_id = 1;					// 物品表id
}

message s2c_ret_query_jobber_item_min_price
{
	int64 item_template_id = 1;					// 物品表id
	int64 min_price = 2;						// 该物品再市场上的最低价格
}

// 交易行寄售
message c2s_jobber_sell
{
	int64 item_id = 1;							// 物品id
	int64 count = 2;							// 出售物品数量
	int64 auction_price = 3;					// 起拍价
	int64 fixed_price = 4;						// 一口价
	int64 sell_time_type = 5;					// 寄售时间类型（填 1、2、3...）
}

message s2c_ret_jobber_sell
{			
}

// 查询已寄售道具
message c2s_query_jobber_my_sell_items
{
}

message s2c_ret_query_jobber_my_sell_items
{
	repeated jobber_commodity_t commodities = 1;				// 拍卖品列表
}

// 下架拍卖品
message c2s_disboard_jobber_commodity
{
	int64 commodity_id = 1;					// 商品id （用于唯一标识一个拍卖品, 不是物品id）
}

message s2c_ret_disboard_jobber_commodity
{
}

enum jobber_sort_type
{
	PriceAsc				= 0;		// 当前竞拍价从低到高
	PriceDesc				= 1;		// 当前竞拍价从高到低
	RemainingTime			= 2;		// 道具剩余时间倒序
}

// 查询拍卖道具
message c2s_query_jobber_items
{
	int64 sort_type = 1;				// 排序类型 （见 jobber_sort_type）
	int64 item_type = 2;				// 物品类型
	int64 page = 3;						// 第几页

	// 装备筛选项
	int64 equip_profession = 11;		// 装备职业（为0表示所有职业）
	int64 equip_slot = 12;				// 装备部位（为0表示所有部位）
	int64 equip_level = 13;				// 装备等级（为0表示所有等级）
	int64 equip_quality = 14;			// 装备品质（为0表示所有品质）

	// 宝石筛选项
	int64 gem_colour = 21;				// 宝石颜色（为0表示所有颜色）
	int64 gem_star = 22;				// 宝石星级（为0表示所有星级）
	int64 gem_quality = 23;				// 宝石品质（为0表示所有品质）
}

message s2c_ret_query_jobber_items
{
	repeated jobber_commodity_t commodities = 1;				// 拍卖品列表
	int64 page = 2;												// 第几页		
	bool is_last_page = 3;										// 是否是最后一页	
}

// 竞拍、一口价购买
message c2s_jobber_buy
{
	int64 commodity_id = 1;					// 商品id （用于唯一标识一个拍卖品, 不是物品id）
	int64 price = 2;						// 出价 （如果出价等于一口价，则为一口价购买）
}

message s2c_ret_jobber_buy
{		
}

// 查看参与竞价的拍卖品
message c2s_query_jobber_bid_items
{
}

message s2c_ret_query_jobber_bid_items
{
	repeated jobber_commodity_t commodities = 1;				// 拍卖品列表			
}

// 私货
message smuggled_good_t
{
	int64 good_id = 1;						// 私货id
	int64 item_template_id = 2;				// 物品模板id
	int64 price = 3;						// 价格		
	int64 rare = 4;							// 0：普通， 1：稀有		
	int64 bid_player_id = 5;				// 最后出价的玩家
}

// 私货商城状态
enum smuggled_good_state
{
	None				= 0;
	ShowGood			= 1;		// 展示当期商品
	Auction				= 2;		// 拍卖期
	ShowResult			= 3;		// 展示上期拍卖结果
}

// 查询私货
message c2s_query_smuggled_goods
{
}

message s2c_ret_query_smuggled_goods
{
	int64 state = 1;								// 私货商城状态， 见 smuggled_good_state
	int64 state_over_time = 2;						// 此状态的结束时间
	map<int64, smuggled_good_t> goods = 3;			// 拍卖品，key 为 货物id
}

// 私货竞价
message c2s_buy_smuggled_good
{
	int64 good_id = 1;						// 私货id
	int64 price = 2;						// 出价
}

message s2c_ret_buy_smuggled_good
{		
}

// ======================简单外观数据
enum gender_type
{
	female = 0;
	male = 1;
}

message c2s_save_theme
{
	uint64 action_id = 1;
	uint64 border_id = 2;
	uint64 background_id = 3;
}

message s2c_ret_save_theme
{
}

message c2s_save_personal_setting
{
	uint64 gender = 1;
	uint64 address = 2;
}

message s2c_ret_save_personal_setting
{
}

message c2s_set_head
{
	uint64 id = 1;
}

message s2c_ret_set_head
{
}

message c2s_set_head_border
{
	uint64 id = 1;
}

message s2c_ret_set_head_border
{
}

message c2s_set_chat_bubble
{
	uint64 id = 1;
}

message s2c_ret_set_chat_bubble
{
}

message c2s_set_title
{
	uint64 id = 1;
}

message s2c_ret_set_title
{
}

message s2c_add_simple_appearance_res
{
	uint64 res_type = 1;
	uint64 res_id = 2;
}
// ----------------------简单外观数据 end

enum achievement_type
{
	UpToLevel = 1; // 升到某级
	ThroughMainLevel = 2; // 通过大关卡
}

// ----------------------成就开始
message s2c_update_achievement
{
	achievement_t data = 1;
}

message c2s_get_achievement_reward
{
	uint64 id = 1;
}

message s2c_ret_get_achievement_reward
{
	uint64 id = 1;
	uint64 rewarded_index = 2;
	repeated resource_t rewards = 3;
}
// ----------------------成就结束

// ----------------------------------------部落-------------------------------------------
// 加入部落的类型
enum clan_join_type
{
	cjt_need_verify = 1;   			// 需要确认才可加入
	cjt_against_combat_value = 2; 	// 按照战力限制加入人员  join_arg1 表示最低战力 
}

// 部落加入申请
message clan_join_t
{
	uint64 player_id = 1;
	uint64 icon = 2;
	uint64 level = 3;
	uint64 combat_value = 4;
	uint64 main_progress = 5;
	bool online = 6;
	uint64 offline_timestamp = 7;
	uint64 profession = 8;
	uint64 timestamp = 9;
	bytes name = 10;
}

// 募集资源类型
enum clan_donation_type
{
	cdt_money = 1;				// 部落资金
	cdt_levelup = 2;			// 部落升级
	cdt_fix_res_point = 3;		// 资源点修复
	cdt_hall_level_up = 4;		// 大厅升级
}

// 部落资源类型(大厅，资源点)
enum clan_minning_type
{
	cres_1 = 1;		// 采矿
	cres_2 = 2;		// 狩猎
	cres_3 = 3;		// 种植
	cres_4 = 4;		// 伐木
	cres_5 = 5;		// 畜牧
	cres_6 = 6;		// 收集
	cres_7 = 7;		// 宝石
}


enum clan_position_type
{
	clan_position_chief = 1;		// 酋长
	clan_position_deputy_chief = 2; // 副酋长
	clan_position_elder = 3;		// 长老
	clan_position_member = 4;		// 成员
}

// 部落募集数据
message clan_donation_t
{
	uint64 donation_type = 1;				// 募集类型 -> clan_donation_type
	uint64 sub_type = 2; 				// 对于大厅升级->clan_minning_type 
	map<uint64, uint64> need_res = 3; 	// 需要的资源 <ID, 数量>
	map<uint64, uint64> res = 4;		// 已捐献的资源
	uint64 donation_id			= 5;	// 用于前端判断是否捐献过
	uint64 map_id = 6;					// 领地id
}

// 开采数据
message clan_minning_t
{
	uint64 player_id = 1; 			// 玩家ID
	uint64 end_timestamp = 2;		// 当前次采集结束时间戳
	uint64 special_item_id = 3;		// 特殊物品ID 用以提高挖出物品的数量
	uint64 need_energy = 4;			// 需要的体力
    uint64 start_timestamp = 5;	// 开始时间戳
	uint64 finish_timestamp = 6;	// 全部结束时间戳
	bool auto_use_item = 7;			// 是否自动使用物品
}

// 资源点数据
message clan_res_point_t
{
	uint64 id = 1;									// 资源点配置ID
	uint64 last_count = 2; 							// 剩余资源数量 -> 针对宝石
	uint64 fix_over_timestamp = 3; 					// 修复完成时间戳
	uint64 breakage = 4;							// 破损程度 (百分比) 用的时候 / 100
	uint64 restore_timestamp = 5;					// 周期结束时间(用于宝石)
	map<uint64, clan_minning_t> minning_data = 6;	// 挖矿数据
}

// 领地数据
message clan_map_t
{
	uint64 map_id = 1;								// 领地ID
	map<uint64, clan_res_point_t> res_points = 2;	// 资源点数据
	bool pre_dealloc = 3;							// 是否预回收
}

// 部落成员数据(返回给前端数据)
message clan_member_t
{
	uint64 player_id = 1;						// 玩家ID
	uint64 icon = 2;							// 头像
	uint64 level = 3;							// 等级
	uint64 combat_value = 4;					// 战斗力
	uint64 main_progress = 5;					// 主线进度
	bool online = 6;							// 是否在线
	uint64 offline_timestamp = 7;				// 离线时间
	uint64 profession = 8;						// 职业
	bytes name = 10;							// 名字
	map<uint64, uint64> liveness_7 = 11; 		// 七日活跃度<时间戳(每天的刷新时间), 活跃度>
	uint64 position = 12;						// 职位 -> 职位权限表ID
	repeated uint64 minning_privileges = 13;	// 采集权限
	uint64 energy = 14;							// 体力
}

// 成员list数据(发送给前端数据)
message clan_member_list_t
{
	uint64 player_id = 1;						// 玩家ID
	uint64 icon = 2;							// 头像
	uint64 level = 3;							// 等级
	uint64 combat_value = 4;					// 战斗力
	uint64 main_progress = 5;					// 主线进度
	bool online = 6;							// 是否在线
	uint64 offline_timestamp = 7;				// 离线时间
	uint64 profession = 8;						// 职业
	bytes name = 10;							// 名字
	map<uint64, uint64> liveness_7 = 11; 		// 七日活跃度<时间戳(每天的刷新时间), 活跃度>
	uint64 position = 12;						// 职位 -> 职位权限表ID
	uint64 energy = 13;							// 体力
}

// 部落数据
message clan_data_t
{
	uint64 id = 1;									// 部落ID
	bytes name = 2;									// 部落名字
	uint64 sum_liveness = 3; 						// 活跃度累计值
	uint64 level = 4;								// 等级
	uint64 join_type = 5; 							// 见 clan_join_type
	uint64 join_arg1 = 6; 							// 加入限制参数
	uint64 create_timestamp = 7; 					// 创建时间戳
	uint64 flag_id = 8;								// 旗帜ID
	bytes manifesto = 9;							// 宣言
	uint64 destory_timestamp = 10;					// 解散时间
	map<uint64, uint64> res = 11;					// 部落当前拥有的资源
}

// 领地拍卖记录
message clan_auction_record_t
{
	uint64 map_id = 1;							// 地块ID
	uint64 clan_id = 2;							// 部落ID
	bytes clan_name = 3;						// 部落name
	uint64 price = 4;							// 出价
	uint64 timestamp = 5;						// 出价时间戳
	uint64 player_id = 6;						// 出价人
}

// 领地拍卖记录列表
message clan_aution_record_list_t
{
	repeated clan_auction_record_t data = 1;
}

// 拍卖状态
enum clan_auction_state_type
{
	clan_auction_close = 0;			// 未开启
	clan_auction_show = 1;			// 公示阶段
	clan_auction_start = 2;			// 拍卖中
}

// 领地拍卖数据
message clan_map_auction_t
{
	uint64 state = 1;									// 当前状态
	uint64 state_end_timestamp = 2;						// 当前状态结束时间戳
	map<uint64, clan_aution_record_list_t> records = 3; // 出价记录<地块ID, 出价记录(默认为空)>
	map<uint64, bool> sold_map = 4;						// 卖出的地块
	uint64 number = 5;									// 拍卖的期
}

// 部落列表数据(发送给前端数据)
message clan_list_t
{
	uint64 id = 1;									// 部落ID
	bytes name = 2;									// 部落名字
	uint64 liveness_7 = 3; 							// 部落七日活跃度
	uint64 level = 4;								// 等级
	uint64 member_count = 5;						// 成员数量
	uint64 join_type = 6; 							// 见 clan_join_type
	uint64 join_arg1 = 7; 							// 加入限制参数
	uint64 flag_id = 8;								// 旗帜ID
	map<uint64, clan_member_list_t> members = 9;	// 成员数据
	bytes manifesto = 10;							// 宣言
}

// 创建部落
message c2s_create_clan
{
	bytes name = 1;								// 名字
	bytes manifesto = 2;						// 宣言
	uint64 flag_id = 3;							// 旗帜ID
	uint64 join_type = 4; 						// 见 clan_join_type
	uint64 join_arg1 = 5; 						// 加入限制参数
}

// 创建部落返回
message s2c_ret_create_clan
{
	clan_data_t data = 1;
}

// 退出部落
message c2s_exit_clan
{
}

// 退出部落返回
message s2c_ret_exit_clan
{
}

// 获取部落数据
message c2s_get_my_clan
{
}

// 获取部落数据返回
message s2c_ret_get_my_clan
{
	clan_data_t data = 1;
	clan_member_t my_data = 2;
}

// 获取成员
message c2s_clan_get_members
{
}

// 获取成员
message s2c_ret_clan_get_members
{
	repeated clan_member_t members = 1;
}

// 获取部落
message c2s_get_clan
{
	uint64 clan_id = 1; 			// 部落ID（用于搜索）
	repeated uint64 pre_ids = 2; 	// 上次显示的列表(用于换一批)
}


// 获取部落返回
message s2c_ret_get_clan
{
	repeated clan_list_t data = 1;				// 部落列表
	repeated uint64 already_requested = 2;		// 已经申请的列表
}

// 申请加入部落
message c2s_join_clan
{
	uint64 clan_id = 1; 			// 部落ID
}

// 申请加入部落返回
message s2c_ret_join_clan
{
}

// 获取申请列表
message c2s_clan_get_request
{
}

// 获取申请列表返回
message s2c_ret_clan_get_request
{
	repeated clan_join_t join_requests = 1;			// 申请数据
}

// 处理申请
message c2s_clan_handle_request
{
	map<uint64, bool> data = 1; // <玩家player_id, 是否同意>
}

// 处理申请返回
message s2c_ret_clan_handle_request
{
	repeated uint64 remove_ids = 1;
}

// 职位任命
message c2s_clan_set_position
{
	uint64 player_id = 1;  	// 玩家ID
	uint64 position = 2;	// 职位
}

// 职位任命返回
message s2c_ret_clan_set_position
{
}

// 编辑宣言
message c2s_clan_set_manifesto
{
	bytes manifesto = 1;
}

// 编辑宣言返回
message s2c_ret_clan_set_manifesto
{
	bytes manifesto = 1;
}

// 设置旗帜
message c2s_clan_set_flag
{
	uint64 flag_id = 1;
}

// 设置旗帜返回
message s2c_ret_clan_set_flag
{
	uint64 flag_id = 1;
}

// 获取资源数据
message c2s_clan_get_res
{
}

// 获取资源数据返回
message s2c_ret_clan_get_res
{
	map<uint64, uint64> res = 1;	// 部落当前拥有的资源 <item_id, count>
}

message s2c_notify_update_res
{
	map<uint64, uint64> update_res = 1;		// <item id, 变更>
}

// 采集权限数据
message clan_minning_privileges_t
{
	repeated uint64 data = 1;
}

// 采集权限设置
message c2s_clan_set_minning_privileges
{
	map<uint64, clan_minning_privileges_t> data = 1;
}

// 采集权限设置返回
message s2c_ret_clan_set_minning_privileges
{
	map<uint64, clan_minning_privileges_t> data = 1;
}

// 部落升级
message c2s_clan_levelup
{
}

// 部落升级返回
message s2c_ret_clan_levelup
{
}

// 获取部落排行榜
message c2s_clan_get_rank_list
{
}

// 获取部落排行榜返回
message s2c_ret_clan_get_rank_list
{
	repeated clan_list_t data = 1;
}


// 获取领地数据
message c2s_clan_get_map_data
{
}

message clan_mining_reward_t
{
	uint64 item_id = 1;			// item_id 用于显示
	uint64 count = 2;			// 数量
	uint64 gem_id = 3;			// 对于宝石 item_id 表示原石ID
}

// 获取领地数据返回
message s2c_ret_clan_get_map_data
{
	map<uint64, clan_map_t> map_data = 1;		// 领地数据
	map<uint64, uint64> mining_rewards = 2; 	// 于记录挖矿的奖励
}

// 修复资源点
message c2s_clan_fix_res_point
{
	uint64 map_id = 1;			// 领地ID
	uint64 res_point_id = 2;	// 资源点ID
}

// 修复资源点返回
message s2c_ret_clan_fix_res_point
{
	uint64 map_id = 1;			// 领地ID
	uint64 res_point_id = 2;	// 资源点ID
	uint64 breakup = 3;			// 更新资源点损坏程度
	uint64 fix_over_timestamp = 4; // 修复完成时间
	uint64 fix_start_timestamp = 5; // 修复开始时间
}

// 获取大厅等级
message c2s_clan_get_mining_level
{
	
}

// 获取大厅等级返回
message s2c_ret_clan_get_mining_level
{
	map<uint64, int64> mining_hall_level	= 1;	// 生活大厅等级
}


// 采集大厅升级
message c2s_clan_mining_levelup
{
	uint64 minning_type = 1; // 大厅类型-> clan_minning_type
}

// 采集大厅升级返回
message s2c_ret_clan_mining_levelup
{
	uint64 minning_type = 1; // 大厅类型-> clan_minning_type
	uint64 level = 2; // 等级
}

// 挖矿
message c2s_clan_mining
{
	uint64 map_id = 1;	// 资源点ID, == 0 表示停止挖矿
	uint64 res_point_id = 2;	// 资源点ID
	uint64 item_id = 3;			// 使用的特殊物品ID
	bool auto_use_item = 4;		// 是否自动使用物品
}

// 挖矿返回
message s2c_ret_clan_mining
{
	uint64 map_id = 1;
	uint64 res_point_id = 2;		// 资源点配置ID
	uint64 player_id = 3; 			// 玩家ID
	uint64 end_timestamp = 4;		// 结束时间戳
	uint64 special_item_id = 5;		// 特殊物品ID 用以提高挖出物品的数量
	uint64 need_energy = 6;			// 需要的体力
	bool auto_use_item = 7;			// 是否自动使用物品
}

// 移除采矿的人员
message c2s_clan_remove_mining_player
{
	uint64 player_id = 1;
}

// 移除采矿的人员返回
message s2c_ret_clan_remove_mining_player
{
	uint64 map_id = 1;				// 领地ID
	uint64 res_point_id = 2;		// 资源点配置ID
	uint64 player_id = 3; 			// 玩家ID
}

// 预先回收领地
message c2s_clan_pre_dealloc
{
	uint64 map_id = 1;
	bool pre_dealloc = 2;
}

// 预先回收领地返回
message s2c_ret_clan_pre_dealloc
{
	uint64 map_id = 1;
	bool pre_dealloc = 2;
}

// 获取领地拍卖数据
message c2s_clan_get_auction
{
}

// 获取领地拍卖数据返回
message s2c_ret_clan_get_auction
{
	clan_map_auction_t data = 1;
}

// 拍卖出价
message c2s_clan_auction
{
	uint64 map_id = 1;
	uint64 price = 2;
}

// 拍卖出价返回
message s2c_ret_clan_auction
{
	clan_auction_record_t data = 1;
}

// 部落踢人
message c2s_clan_tick_player
{
	uint64 player_id = 1;
}

// 部落踢人返回
message s2c_ret_clan_tick_player
{
	uint64 player_id = 1;
}

// 解散部落
message c2s_clan_destroy
{
}

// 解散部落返回
message s2c_ret_clan_destroy
{
	uint64 destory_timestamp = 1;
}

// 获取挖矿的奖励
message c2s_clan_get_mining_rewards
{
}

// 获取挖矿的奖励返回
message s2c_ret_clan_get_mining_rewards
{
	repeated resource_t mining_rewards = 1; // 挖矿数据
}

message s2c_notify_pet_catch_finish
{
}

// 挖矿使用物品设置请求
message c2s_clan_mining_set_special_item
{
	uint64 item_id = 1;
	bool auto_use_item = 2;		// 是否自动使用物品
}

// 挖矿使用物品设置回复
message s2c_clan_mining_set_special_item
{
	int32 error = 1;
	string err_msg = 2;

	uint64 item_id = 3;
	bool auto_use_item = 4;		// 是否自动使用物品
}

//-----------------------------------
// battle field
//-----------------------------------

// [bing] 部落争夺战阶段状态
enum clan_battle_step_type
{
	clan_battle_none = 1;			// 停战
	clan_battle_declare_war = 2;	// 宣战
	clan_battle_prepare = 3;		// 准备
	clan_battle_lock = 4;			// 锁定
	clan_battle_fight = 5;			// 战斗
	clan_battle_settlement = 6;		// 结算
}

enum ClanBattleFieldTeamType
{
	team_type_elite = 1;  // 精英
	team_type_vanguard_1 = 2; // 先锋1
	team_type_vanguard_2 = 3; // 先锋2
	team_type_vanguard_3 = 4; // 先锋3
	team_type_guard_1 = 5;	// 后卫1
	team_type_guard_2 = 6;	// 后卫2
}

enum battlefield_battle_resule_type
{
	battle_resule_type_defense_win = 1; // 防守成功
	battle_resule_type_attack_win = 2; 	// 进攻成功
}

enum battlefield_operate
{
	battlefield_join = 1;		// 加入
	battlefield_leave = 2;		// 离开
	battlefield_locl = 3;		// 锁定
}

enum battlefield_reward_type
{
	battlefield_reward_type_none = 0;   // 无奖励
	battlefield_reward_type_high = 1;   // 高级奖励
	battlefield_reward_type_normal = 2; // 普通奖励
	battlefield_reward_type_fail = 3;	// 失败奖励
}

// 挑战数据
message clan_battlefield_fight_data_s2c
{
	uint64 territory_id = 1;			// 领地ID
	uint64 defence_clan_id = 2;			// 防守部落ID
	string defence_clan_name = 3;   	// 防守方部落名字
	uint64 defence_clan_flag_id = 4;	// 防守方部落旗帜ID
	uint64 defence_combat_value = 5;	// 防守方战斗力
	uint64 attack_clan_id = 6;			// 进攻部落ID
	string attack_clan_name = 7;		// 进攻方部落名字
	uint64 attack_clan_flag_id = 8;		// 进攻方部落旗帜ID
	uint64 attack_combat_value = 9;		// 进攻方战斗力
}

// 挑战列表
message clan_battlefield_fight_list_s2c
{
	repeated clan_battlefield_fight_data_s2c fight_datas = 1;
}

// 队伍成员数据
message clan_battlefield_team_member_data_s2c
{
	group_member_data_t member_data = 1;	// 成员信息
	bool is_lock = 2;						// 是否被锁定
}

// 队伍数据
message clan_battlefield_team_s2c
{
	repeated clan_battlefield_team_member_data_s2c member_datas = 1;
}

// 队伍列表数据
message clan_battlefield_team_list_s2c
{
	repeated clan_battlefield_team_s2c team_list = 1;    // 6 个队伍数据
}

// 区域数据
message clan_battlefield_territory_s2c
{
	uint64 territory_id = 1;								// 领地ID
	uint64 defence_clan_id = 2;								// 防守部落ID
	string defense_clan_name = 3;							// 防守部落名字
	uint32 defense_clan_level = 4;							// 防守部落等级
	uint64 defence_clan_sum_liveness_7 = 5;					// 防守部落7日活跃度
	uint64 attack_clan_id = 6;								// 挑战部落ID
	string attack_clan_name = 7;							// 挑战部落名字
	uint32 attack_clan_level = 8;							// 挑战部落等级
	uint64 attack_clan_sum_liveness_7 = 9;					// 挑战部落7日活跃度
	uint32 price = 10;										// 出价
	uint32 remain_protected_sec = 11;						// 受保护剩余秒数 0 = 不受保护
	map<int32, int32> breakage = 12;						// 破损率 k = res_id, v = breakage rate
}

// 区域列表数据
message clan_battlefield_map_data_s2c
{
	map<uint64, clan_battlefield_territory_s2c> map_fields = 1;   // k = territory_id
}

// 战斗结果数据
message clan_battlefield_battle_result_s2c
{
	uint64 territory_id = 1;			// 领地ID
	uint64 defense_clan_id = 2;			// 防御方部落ID
	string defense_clan_name = 3;		// 防御方部落名字
	uint64 defense_clan_flag_id = 4;	// 防御方部落旗帜
	uint32 defense_clan_level = 5;		// 防御方部落等级
	uint64 defense_combat_value = 6;	// 防御方战斗力
	int32 defense_score = 7;			// 防御方积分
	uint64 attack_clan_id = 8;			// 防御方部落ID
	string attack_clan_name = 9;		// 进攻方部落名字
	uint64 attack_clan_flag_id = 10;	// 进攻方部落旗帜
	uint32 attack_clan_level = 11;		// 进攻方部落等级
	uint64 attack_combat_value = 12; 	// 进攻方战斗力
	int32 attack_score = 13;			// 进攻方积分
	int32 fight_result = 14;			// 对战结果 battlefield_battle_resule_type
}

// 战斗结果列表
message clan_battlefield_battle_result_list_s2c
{
	repeated clan_battlefield_battle_result_s2c repeated_results = 1;
}

// 单场战斗结果数据
message clan_battlefield_single_battle_result_s2c
{
	int32 team_type = 1;			// 队伍类型 ClanBattleFieldTeamType
	int32 defense_score = 2;		// 防御方积分
	int32 attack_score = 3;			// 进攻方积分
	int32 fight_result = 4;			// 对战结果 battlefield_battle_resule_type
	uint64 combat_id = 5;			// 战报SN
}

// [bing] 领地战获取战区数据请求
message c2s_clan_battlefield_info
{

}

// [bing] 领地战获取战区数据回复
message s2c_clan_battlefield_info
{
	int32 clan_battlefield_step = 1;								// 阶段 clan_battle_step_type
	int32 less_sec = 2;												// 剩余时间(秒)
	clan_battlefield_map_data_s2c map_infos = 3;					// 地图信息
	clan_battlefield_fight_list_s2c fight_list = 4; 				// 挑战列表信息  (准备和锁定和战斗阶段有数据)
	clan_battlefield_battle_result_list_s2c battle_results = 5;		// 战斗结果数据  (战斗结束和结算阶段有数据)
	uint64 give_up_territory_id = 6;								// 待放弃领地ID
	bool can_get_reward = 7;										// 可领取奖励
}

// 领地战宣战请求
message c2s_clan_battlefield_declare_war
{
	uint64 territory_id = 1;	// 领地ID
	int64 price = 2;			// 出价
}

// 领地战宣战回复
message s2c_clan_battlefield_declare_war
{
	int32 error = 1;
	string err_msg = 2;
}

// 领地战查看对战布局请求
message c2s_clan_battlefield_pvp_info
{
	uint64 territory_id = 1;	// 领地ID
}

// 领地战查看对战布局回复
message s2c_clan_battlefield_pvp_info
{
	uint64 territory_id = 1;	// 领地ID
	clan_battlefield_team_list_s2c team_list_data = 2; 	// 我方6个队伍信息

	uint64 my_clan_id = 3;			// 我方部落ID
	string my_clan_name = 4;		// 我方部落名字
	uint64 my_clan_flag_id = 5;		// 我方部落旗帜
	uint64 my_clan_level = 6;		// 我方部落等级
	uint64 my_combat_value = 7;		// 我方战斗力
	int32 my_cheer_value = 8;		// 我方助力值
	int32 my_cheer_num = 9;			// 我方助力人数

	uint64 target_clan_id = 10;			// 对方部落ID
	string target_clan_name = 11;		// 对方部落名字
	uint64 target_clan_flag_id = 12;	// 对方部落旗帜
	uint64 target_clan_level = 13;		// 对方部落等级
	uint64 target_combat_value = 14; 	// 对方战斗力
	int32 target_cheer_value = 15;		// 敌方助力值
	int32 target_cheer_num = 16;		// 敌方助力人数

	bool self_is_cheer = 17;		// 自己是否已经助威
	bool my_is_defense = 18;		// 自己部落是否防守

	repeated clan_battlefield_single_battle_result_s2c battle_results = 20;   // 战斗结果列表
}

// 领地战查看领地战玩家数据列表请求
message c2s_clan_battlefield_member_list
{
	
}

message clan_battlefield_member_info
{
	clan_member_t member_info = 1;   // 成员基本数据
	bool is_cheer = 2;	// 是否助威过
	bool is_in_defense_team = 3;
	bool is_in_attack_team = 4;
}

// 领地战查看领地战玩家数据列表回复
message s2c_clan_battlefield_member_list
{
	int32 error = 1;
	string err_msg = 2;

	repeated clan_battlefield_member_info members_info = 3;
}

// 领地战上下阵操作请求
message c2s_clan_battlefield_join_or_leave
{
	uint64 territory_id = 1;	// 领地ID
	uint32 team_index = 2;		// 队伍索引
	uint32 operate = 3;			// 操作类型
}

// 领地战上下阵操作回复
message s2c_clan_battlefield_join_or_leave
{
	int32 error = 1;
	string err_msg = 2;
}

// 领地战助威请求
message c2s_clan_battlefield_cheer
{
	uint64 territory_id = 1;	// 领地ID
	uint32 cheer_level = 2;		// 助威级别
}

// 领地战助威回复
message s2c_clan_battlefield_cheer
{
	int32 error = 1;
	string err_msg = 2;
}

// 领地战调配操作请求
message c2s_clan_battlefield_control
{
	uint64 territory_id = 1;	// 领地ID
	uint32 team_index = 2;		// 队伍索引
	uint32 team_socket = 3;		// 队伍成员位置 1 - 4
	uint32 operate = 4;			// 操作类型 1 = 上阵, 2 = 下阵, 3 = 锁定/解锁
	uint64 member_id = 5;		// 上阵部落成员ID
}

// 领地战调配操作回复
message s2c_clan_battlefield_control
{
	int32 error = 1;
	string err_msg = 2;
}

// 领地战放弃领地请求
message c2s_clan_battlefield_give_up
{
	uint64 territory_id = 1;	// 领地ID
}

// 领地战放弃领地回复
message s2c_clan_battlefield_give_up
{
	int32 error = 1;
	string err_msg = 2;

	uint64 territory_id = 3;	// 领地ID
}

// 领地战领取奖励请求
message c2s_clan_battlefield_get_reward
{

}

// 领地战领取奖励回复
message s2c_clan_battlefield_get_reward
{
	int32 error = 1;
	string err_msg = 2;
}

// 领地战修改金手指请求
message c2s_clan_battlefield_config
{
	uint64 member_id = 1;			// 成员 id
	uint64 pet_id = 2;				// 出战宠物
	map<int64, int64> slots = 3;	// 技能
}

// 领地战修改金手指回复
message s2c_clan_battlefield_config
{
	int32 error = 1;
	string err_msg = 2;
}

// ----------------------商店-----begin-----
enum shop_type 
{
	black_mark					= 1;	// 黑市
	tribe_ordinary				= 2;	// 部落普通商店
	tribe_territory				= 3;	// 部落领地商店
	tribe_special				= 4;	// 部落特殊商店
	
}

enum shop_refresh_type
{
	timer_refresh 				= 1;	// 每日时间点刷新
	day_refresh 				= 2;	// 指定周几某时刻刷新
	none 						= 3;	// 不刷新
}

enum shop_refresh_data_type
{
	weight_refresh 				= 1;	// 根据权重重新筛选物品
	data_refresh 				= 2;	// 只刷新物品计数等数据
	other_refresh				= 3;	// 其他形式刷新
	none 						= 4;	// 不刷新
}

message shop_goods_t
{
	int32 goods_id 					= 1;
	int32 count 					= 2;
	int32 buy_count 				= 3;
	int64 next_refresh_time			= 4;
	int64 next_week_refresh_time 	= 5;
	map<int64, int64> gem_amount 	= 6;	// map<gem_id, amount>
}

message shop_t
{
	int32 shop_id								= 1;
	int64 next_refresh_time						= 2;
	int64 next_manual_refresh_reset_time		= 3;
	int32 refresh_count							= 4;
	repeated shop_goods_t goods_list			= 5;
}

enum shop_goods_limit_type
{
	none			= 1;	// 不限购
	daily_limit		= 2;	// 每日限购
	week_limit		= 3;	// 7日限购
	limit_forerver	= 4;	// 不刷新限购
}

message s2c_notify_refresh_shop
{
	shop_t shop					= 1;
}

message s2c_notify_refresh_goods
{
	int32 shop_id				= 1;
	shop_goods_t goods			= 2;
}

message s2c_notify_refresh_manual_count 
{
	int32 shop_id				= 1;
}

message c2s_buy_goods
{
	int32 shop_id				= 1;
	int32 goods_id				= 2;
	int32 buy_count				= 3;
}

message s2c_ret_buy_goods
{
	int32 goods_id				= 1;
	repeated resource_t rewards = 2;
}

message c2s_refresh_shop
{
	int32 shop_id			= 1;
}

message s2c_ret_refresh_shop
{
}

message c2s_open_shop
{
	int32 shop_id			= 1;	// shop_type
}

message s2c_ret_open_shop
{
	int32 shop_id			= 1;	// shop_type
	shop_t shop				= 2;
}
// ----------------------商店-----end-----

enum clan_target_type
{
	counting_task				= 1;	// 计数型任务
	prop_task					= 2;	// 提交道具型任务
}

enum clan_task_sub_type
{
	pet_catch 			= 1; // 宠物捕捉
	donate_props		= 2; // 捐献道具
	scramble_cheer		= 3; // 争夺战助威
	daily_login			= 4; // 每日登录
}
// 部落任务类型
enum clan_task_panel_type 
{
	week_task 					= 1; // 周任务
	daily_task 					= 2; // 日常任务
	funds_donation				= 3; // 资金募捐
	item_donation				= 4; // 物品募捐
}

// 部落任务
message clan_task_t 
{
	int64 task_id 			= 1;	// 任务 id
	int64 count				= 2;	// 完成数量	计数型任务
	map<uint64, uint64> res = 3;	// 完成数量 map<道具id, 数量> 提交道具型任务
	int64 status 			= 4;	// 任务状态
}

// 打开部落日常、周任务
message c2s_open_clan_task
{
	int64 clan_task_type 			= 1;	// ->clan_task_panel_type 1或者2
}

message s2c_ret_open_clan_task
{	
	int64 clan_task_type 					= 1;	// ->clan_task_panel_type 1或者2
	map<int64, clan_task_t> tasks			= 2;	// map<task_id, clan_task_t>
	int64 next_daily_refresh_time			= 3;
	int64 next_week_refresh_time			= 4;

}

// 部落任务完成（日、周任务）
message c2s_clan_complete_task
{
	int64 task_id							= 1;
}

message s2c_ret_clan_complete_task
{
	int64 task_id							= 1;
	repeated resource_t rewards 			= 2;	// 奖励列表
}

message s2c_notify_clan_task_update 
{
	int64 clan_task_type 					= 1;	// ->clan_task_panel_type 1或者2
	map<int64, clan_task_t> tasks			= 2;
}


// 打开部募捐任务
message c2s_open_clan_donation_task
{
}

message s2c_ret_open_clan_donation_task
{	
	map<uint64, clan_donation_t> donations = 1;	// map<clan_donation_type,clan_donation_t>
}

message donation_item_t 
{	
	uint64 donation_id					= 1;
	int64 map_id						= 2;
	map<int64, int64> resources			= 3;
}

// 批量提交募捐任务
message c2s_submit_donation_task
{
	repeated donation_item_t donation_items =	1;
}

message s2c_ret_submit_donation_task
{
	repeated resource_t rewards = 1;
}

// 发布募集任务
message c2s_clan_publish_donation_task
{
	uint64 donation_type 	= 1;		// 募集类型->clan_donation_type
	uint64 map_id			= 2;		// 领地id	资源点修复时有用
	uint64 sub_type 		= 3;		// 子类型 	资源点修复时：资源点id
	uint64 count 			= 4;		// 用于 cdt_money = 1;(其他功能性募捐服务器计算需要的资源)
}

message s2c_ret_clan_publish_donation_task
{
}

// 更新募捐任务（更新数量也用此消息）
message s2c_notify_update_donation
{
	repeated int64 completed_donation_ids				= 1;
	map<uint64, clan_donation_t> donations 	= 2;
}

// 结束募集任务
message c2s_clan_finish_donation_task
{
	uint64 donation_type 	= 1;		// 募集类型->clan_donation_type
	uint64 sub_type 		= 2;		// 子类型 	资源点修复时：资源点id
	uint64 count 			= 3;		// 用于 cdt_money = 1;(其他功能性募捐服务器计算需要的资源)
}

message s2c_ret_clan_finish_donation_task
{
}

// ----------------------------------------部落end----------------------------------------

// -------------------------------------开石start-------------------------------------

// 原石上台请求
message c2s_raw_stone_on_stage
{
	int64 raw_stone_item_id = 1;		// 原石ID
}

// 原石上台回复
message s2c_raw_stone_on_stage
{

}

// 原石开凿请求
message c2s_raw_stone_chisel
{
	int64 hammer_item_id = 1;			// 锤子ID
	int32 chisel_pos = 2;				// 开凿位置
}

// 原石开凿回复
message s2c_raw_stone_chisel
{
	int64 get_gem_id = 1;				// 获得的宝石ID 未凿开时 = 0
}

// 原石放弃请求
message c2s_raw_stone_cancel
{

}

// 原石放弃回复
message s2c_raw_stone_cancel
{

}

// 原石变动回复
message s2c_raw_stone_update
{
	slabstone data = 1; 				// 开石石板数据
}

// -------------------------------------开石end---------------------------------------

// -------------------------------------宝石工坊start---------------------------------------

// 宝石工坊数据请求(客户端登陆时会请求 服务器回工坊和石板数据)
message c2s_lookup_gem_workshop_info
{

}

// 宝石工坊数据回复
message s2c_lookup_gem_workshop_info
{
	gem_workshop workshop_data = 1;	// 宝石工坊数据
	slabstone slabstone_data = 2; 	// 开石石板数据
}

// 宝石工坊升级请求
message c2s_gem_workshop_levelup
{

}

// 宝石工坊升级回复
message s2c_gem_workshop_levelup
{

}

// 宝石工坊数据变动回复
message s2c_gem_workshop_update
{
	gem_workshop workshop_data = 1;	// 宝石工坊数据
}

// -------------------------------------宝石工坊end---------------------------------------

// ------------------------------------life skills begin----------------------------------

enum life_skill_type
{
	process_item		= 1;	// 加工
	forge_equip			= 2;	// 打造装备
	cooking_food		= 3;	// 烹饪
	alchemy				= 4;	// 药品
	sacrifice			= 5;	// 献祭
	engineering			= 6;	// 工具
	transform			= 7;	// 转化
	equip_recycle		= 8;	// 装备分解
	gem_recycle			= 9;	// 宝石分解
}

// 制作
message c2s_life_skill_make
{
	uint32 life_type			= 1;
	uint64 config_id 			= 2;	// 配方 id
	uint32 talent_id			= 3;	// 天赋 id
	uint32 config_num 			= 4;	// 配方 num
}

message s2c_life_skill_make
{
	uint32 life_type			= 1;
	uint64 config_id 			= 2;	// 配方 id
	uint32 target_num			= 3;	// 目标剩余数量
	uint32 finish_num			= 4;	// 完成任务数量
	uint64 finish_time			= 5;	// 任务结束时间
	uint64 single_time			= 6;	// 单个任务时间
}

// 分解
message c2s_life_skill_decomposition
{
	uint32 life_type 			= 1;
	map<uint64, uint32> items  	= 2;		// 材料
}

message s2c_life_skill_decomposition
{
	uint32 life_type 			= 1;
	repeated resource_t rewards = 2;
}

// 转化
message c2s_life_skill_transform
{
	uint32 life_type 			= 1;
	map<uint64, uint32> transform	= 2;	// <转化 id, 转化 num>
}

message s2c_life_skill_transform
{
	uint32 life_type 			= 1;
	repeated resource_t rewards = 2;
}

// 停止生产
message c2s_life_skill_stop
{
	uint32 life_type			= 1;
}

message s2c_life_skill_stop
{
	uint32 life_type			= 1;
	repeated resource_t rewards = 2;
}

// 获取合成产物
message c2s_life_skill_get_rewards
{
	uint32 life_type			= 1;
}

message s2c_life_skill_get_rewards
{
	uint32 life_type			= 1;
    repeated resource_t rewards = 2;
}

message s2c_life_skill_update
{
	uint32 life_type					= 1;	// 生活技能类型
	uint64 config_id					= 2;	// 配置索引
	uint32 life_exp						= 3;	// 熟练度
	uint32 life_point					= 4;	// 可用天赋点
	uint32 target_num					= 5;	// 目标剩余数量
	uint32 finish_num					= 6;	// 完成任务数量
	uint64 finish_time					= 7;	// 任务结束时间
	bool flag							= 8;	// 领奖标识
}

message c2s_life_skill_talent_improved
{
	uint32 life_type			= 1;
	uint32 talent_id			= 2;	// 天赋 id
	uint32 stren_id				= 3;	// 强化项 id
}

message s2c_life_skill_talent_improved
{
	uint32 life_type			= 1;
    uint32 talent_id			= 2;	// 天赋 id
	life_talent_t talent 		= 3;	// 天赋
	uint32 life_point			= 4;	// 剩余天赋点
	uint64 stren_id				= 5;	// 天赋强化项 id
}

// -------------------------------------life skills end-----------------------------------

// -------------------------------------佣兽岛start-----------------------------------
// 探索事件颜色
enum adventure_event_color 
{
	Green = 1;							// 绿
	Blue = 2;							// 蓝
	Violet = 3;							// 紫
	Orange = 4;							// 橙
}

message pet_island_t 
{
	uint64 pet_island_id 				= 1;
	uint64 pet_island_template_id		= 2;
	bool is_using						= 3;
}
message c2s_show_pet_island 
{
}

message s2c_ret_show_pet_island 
{	
	map<uint64, pet_island_t> pet_islands 			= 1;	// map<佣兽岛唯一id，pet_island_t>
	map<int64, adventure_t>  adventures				= 2;	// map<探索点id， adventure_t>
	map<int64, int64>  towers						= 3;	// 哨塔	map<哨塔id, 宠物id>
	map<int64, float> additional					= 4; // 属性加成 map<属性id, 加成数值>
}

message c2s_apply_pet_island 
{
	int64 pet_island_id			= 1;		// 佣兽岛唯一id
}

message s2c_ret_apply_pet_island 
{
	int64 pet_island_id								= 1; // 佣兽岛唯一id
	map<int64, adventure_t>  adventures				= 2; // map<探索点id， adventure_t>
	map<int64, int64>  towers						= 3; // 哨塔	map<哨塔id, 宠物id>
	map<int64, float> additional					= 4; // 属性加成 map<属性id, 加成数值>
}

message c2s_pet_island_adventure
{
	repeated adventure_pets adventures	= 1;
	int64 type 							= 2;		// adventure_type
}
message s2c_ret_pet_island_adventure
{
}
message c2s_pet_island_adventure_receive
{
	repeated int64 adventure_point_ids			= 1;		// 探险点
}
message s2c_ret_pet_island_adventure_receive
{
	map<int64, every_point_reward>  rewards = 1; // map<探险点, 奖励>
}
message c2s_pet_island_cancel_adventure
{
	int64 adventure_point_id			= 1;
}
message s2c_ret_pet_island_cancel_adventure
{
}

message s2c_notify_pet_island_adventure_update
{
	int64 pet_island_id								= 1; // 佣兽岛唯一id
	map<int64, adventure_t>  adventure				= 2;	// 探险 map<探险点id, adventure_t>
}

// 加速探险
message c2s_pet_island_speed_up_adventure
{
	repeated int64 adventure_point_ids			= 1;
}

message s2c_ret_pet_island_speed_up_adventure
{
}

// 刷新任务
message c2s_pet_island_adventure_refresh_task
{
	int64 adventure_point_id			= 1;
}

message s2c_ret_pet_island_adventure_refresh_task
{
	int64 adventure_point_id			= 1;
}

// 建造哨塔
message c2s_pet_island_build_tower
{
	int32 slot_id						= 1;
}

message s2c_ret_pet_island_build_tower
{
	int32 slot_id						= 1;
	int64 island_id 					= 2;
}
// 哨塔放置宠物
message c2s_pet_island_tower_place
{
	int32 slot_id						= 1;
	int64 pet_id						= 2;	
}

message s2c_ret_pet_island_tower_place
{
	int64 island_id 					= 1;
	map<int64, int64> towers			= 2; // map<宠物栏id, 宠物id>
}

enum island_update_t 
{
	add 			= 1;
	sell 			= 2;
}

message s2c_notify_pet_island_update
{
	map<uint64, pet_island_t> add_island 			= 1;	// map<佣兽岛唯一id，pet_island_t>
	repeated uint64 sell_island						= 2;
}

message s2c_notify_pet_island_tower_update 
{
	map<int64, int64> towers			= 1; // map<宠物栏id, 宠物id>
	map<int64, float> additional		= 2; // 属性加成 map<属性id, 加成数值>
	int64 island_id 					= 3;
}

// 补充体力
message c2s_pet_regain_strength						
{
	repeated int64 pets_id						= 1; // 宠物模板id
}

message s2c_ret_pet_regain_strength
{
	
}
// -------------------------------------佣兽岛end-----------------------------------
]]