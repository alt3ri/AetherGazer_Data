return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "01",
				crossFade = 0.0311,
				action = "play",
				entity = 0,
				animeActionName = "lounge_sit03_eat"
			}
		},
		[0.6] = {
			{
				attachPoint = "gua_R_hand_bone",
				efxPath = "Effect/Dorm/food01",
				action = "playEfx",
				entity = 0,
				duration = 4.5,
				offset = {
					z = 0,
					x = 0,
					y = 0
				},
				rotation = {
					w = 1,
					z = 0,
					x = 0,
					y = 0
				},
				scale = {
					z = 1,
					x = 1,
					y = 1
				}
			}
		},
		[5.5] = {
			{
				attachPoint = "gua_R_hand_bone",
				action = "clearEfx",
				entity = 0
			}
		}
	},
	keys = {
		0,
		0.6,
		5.5
	},
	duration = 6,
	fps = 30
}
