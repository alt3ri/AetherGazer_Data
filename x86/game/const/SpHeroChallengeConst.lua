slot0 = {
	accelerateID = 54057,
	entrustMaxLevel = 4,
	EntrustState = {
		pool = 3,
		execute = 1,
		waite = 2
	},
	EntrustPosState = {
		empty = "empty",
		start = "start",
		fin = "finish",
		lock = "lock"
	},
	ScheduleID = {
		Decode = 2428406,
		Endurance = 2428402,
		Barbecue = 2428407,
		Boss = 2428405,
		Deter = 2428403,
		Explode = 2428404,
		Awake = 2428401,
		Entrust = 2428408
	},
	ScheduleTypeName = {
		MiniGame = "ACTIVITY_HERO_CHALLENGE_GAME_TYPE",
		Entrust = "ACTIVITY_HERO_CHALLENGE_ENTRUST_TYPE",
		Battle = "ACTIVITY_HERO_CHALLENGE_BATTLE_TYPE"
	},
	ScheduleType = {
		MiniGame = 2,
		Entrust = 3,
		Battle = 1
	},
	ScheduleSubType = {
		boss = 5,
		train1 = 2,
		barbuce = 7,
		train2 = 3,
		decode = 6,
		train3 = 4,
		entrust = 8,
		story = 1
	},
	BattleSubType = {
		boss = 5,
		train1 = 2,
		train2 = 3,
		train3 = 4,
		story = 1
	},
	ChapterType = {
		train = 2,
		boss = 3,
		story = 1
	}
}
slot0.trainIndex = {
	[slot0.BattleSubType.train1] = 1,
	[slot0.BattleSubType.train2] = 2,
	[slot0.BattleSubType.train3] = 3
}
slot0.chapterID = {
	[slot0.BattleSubType.story] = 701,
	[slot0.BattleSubType.train1] = 702,
	[slot0.BattleSubType.train2] = 702,
	[slot0.BattleSubType.train3] = 702,
	[slot0.BattleSubType.boss] = 703
}
slot0.scheduleIndex = {
	[slot0.ScheduleSubType.story] = slot0.ScheduleID.Awake,
	[slot0.ScheduleSubType.train1] = slot0.ScheduleID.Endurance,
	[slot0.ScheduleSubType.train2] = slot0.ScheduleID.Deter,
	[slot0.ScheduleSubType.train3] = slot0.ScheduleID.Explode,
	[slot0.ScheduleSubType.boss] = slot0.ScheduleID.Boss,
	[slot0.ScheduleSubType.decode] = slot0.ScheduleID.Decode,
	[slot0.ScheduleSubType.barbuce] = slot0.ScheduleID.Barbecue,
	[slot0.ScheduleSubType.entrust] = slot0.ScheduleID.Entrust
}
slot0.PriorityType = {
	slot0.ScheduleType.Battle,
	slot0.ScheduleType.MiniGame,
	slot0.ScheduleType.Entrust
}
slot0.scheduleNum = GameSetting.activity_hero_challenge_schedule_limit.value[1]

return slot0
