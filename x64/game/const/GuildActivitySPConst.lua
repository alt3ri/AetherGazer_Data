slot0 = {
	sliderNum = 0.8333333333333334,
	StoryType = {
		Level1BossNoPass = 4,
		Level1BossPass = 3,
		FirstEnter = 1,
		Level2BossPass = 5,
		Condition = 2
	},
	NodeName = {
		elite = 300202,
		normal = 300201
	},
	StageType = {
		Second = 2,
		First = 1
	},
	CameraPosition = Vector3.New(0, 0, -10),
	CameraEulerAngles = Vector3.New(0, 0, 0)
}
slot0.NodeType = {
	slot0.NodeName.normal,
	slot0.NodeName.elite
}
slot0.StoryPriorty = {
	slot0.StoryType.FirstEnter,
	slot0.StoryType.Condition,
	slot0.StoryType.Level1BossPass,
	slot0.StoryType.Level1BossNoPass,
	slot0.StoryType.Level2BossPass
}

return slot0
