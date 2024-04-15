return {
	sequence = {
		[0] = {
			{
				m_Time = 0,
				animeActionSubName = "1",
				action = "play",
				entity = 0,
				crossFade = 0.05,
				animeActionName = "fortune_stall_idle"
			},
			{
				m_Time = 0,
				animeActionSubName = "1",
				action = "play",
				entity = 1,
				crossFade = 0.05,
				animeActionName = "fortune_stall_idle"
			}
		},
		[5.5] = {
			{
				attachPoint = "gua_fx",
				m_Time = 5.5,
				action = "playEfx",
				entity = 1,
				efxPath = "Dorm/Effect/houzhai/fx_9072_stall_idle1_glo",
				duration = 5
			}
		},
		[6.23333333333333] = {
			{
				attachPoint = "gua_fx",
				m_Time = 6.233333,
				action = "playEfx",
				entity = 1,
				efxPath = "Dorm/Effect/houzhai/fx_9072_stall_idle1_zi",
				duration = 6.9
			}
		}
	},
	keys = {
		0,
		5.5,
		6.23333333333333
	},
	duration = 13.13333,
	fps = 30
}
