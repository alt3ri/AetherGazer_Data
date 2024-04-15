return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "04",
				crossFade = 0.02,
				action = "play",
				entity = 0,
				animeActionName = "student_chair"
			},
			{
				referencePointName = "gua_start_sit",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			},
			{
				animeActionSubName = "04",
				crossFade = 0.02,
				action = "play",
				entity = 1,
				animeActionName = "student_chair"
			}
		},
		[0.166666666666667] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_HZ05_xiaoyuan1_kezhuo1",
				action = "playEfx",
				entity = 0,
				duration = 12
			}
		},
		[6.5] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_HZ05_xiaoyuan1_kezhuo1_paopao",
				action = "playEfx",
				entity = 0,
				duration = 5
			}
		}
	},
	keys = {
		0,
		0.166666666666667,
		6.5
	},
	duration = 14.8,
	fps = 30
}
