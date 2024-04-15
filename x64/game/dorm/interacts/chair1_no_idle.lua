return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "chair1_sit_down"
			},
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 1,
				animeActionName = "chair1_sit_down"
			},
			{
				referencePointName = "gua_start_sit",
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
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 1,
				animeActionName = "chair1_sit_stand"
			},
			{
				scheme = "chair1_no_idle",
				action = "changeScheme",
				entity = 0
			},
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		},
		[4] = {
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0,
		1.26666666666667,
		4
	},
	duration = 4.033333,
	fps = 30
}
