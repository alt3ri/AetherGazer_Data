return {
	sequence = {
		[0.0333333333333333] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "fortune_stall_sit"
			},
			{
				referencePointName = "gua_start_sit",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			}
		},
		[0.966666666666667] = {
			{
				scheme = "guatan_stand",
				action = "changeScheme",
				entity = 0
			}
		},
		[1.8] = {
			{
				value = false,
				action = "setMobility",
				entity = 0
			}
		}
	},
	keys = {
		0.0333333333333333,
		0.966666666666667,
		1.8
	},
	duration = 1.866667,
	fps = 30
}
