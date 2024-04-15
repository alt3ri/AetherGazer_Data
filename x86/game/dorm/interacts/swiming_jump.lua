return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 0,
				animeActionName = "swiming_jump"
			},
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 1,
				animeActionName = "swiming_jump"
			},
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_swiming_jump",
				action = "playEfx",
				entity = 1,
				duration = 6.5
			},
			{
				referencePointName = "gua_start_sit",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			}
		},
		[6.5] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 1,
				animeActionName = "swiming_stand"
			},
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "swiming_stand"
			},
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_swiming_stand",
				action = "playEfx",
				entity = 1,
				duration = 14.4
			}
		}
	},
	keys = {
		0,
		6.5
	},
	duration = 20.96667,
	fps = 30
}
