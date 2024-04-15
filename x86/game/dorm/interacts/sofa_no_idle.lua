return {
	sequence = {
		[0.0166666666666667] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "chair1_sit_down"
			},
			{
				referencePointName = "gua_sit_sofa",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			}
		},
		[1.26666666666667] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "chair1_sit_stand"
			},
			{
				scheme = "chair1_no_idle",
				action = "changeScheme",
				entity = 0
			}
		},
		[2.96666666666667] = {
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.0166666666666667,
		1.26666666666667,
		2.96666666666667
	},
	duration = 3,
	fps = 30
}
