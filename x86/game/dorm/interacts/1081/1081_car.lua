return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 1,
				animeActionName = "car_drive"
			},
			{
				animeActionSubName = "",
				crossFade = 0.01,
				action = "play",
				entity = 0,
				animeActionName = "car_drive"
			},
			{
				attachPoint = "gua_sit",
				attachTo = 1,
				itemEntity = 0,
				action = "attachTo"
			},
			{
				attachPoint = "gua_sit",
				efxPath = "Dorm/Effect/houzhai/fx_9081_pinmu",
				action = "playEfx",
				entity = 1,
				duration = 13
			},
			{
				attachPoint = "gua_fx_qiu",
				efxPath = "Dorm/Effect/houzhai/fx_9081_qiu",
				action = "playEfx",
				entity = 1,
				duration = 13
			}
		}
	},
	keys = {
		0
	},
	duration = 13.06667,
	fps = 30
}
