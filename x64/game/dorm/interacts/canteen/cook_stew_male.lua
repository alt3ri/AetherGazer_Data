return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "01",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "stew"
			}
		},
		[0.6] = {
			{
				grabBy = 0,
				attachPoint = "gua_R_hand_bone",
				action = "grabPart",
				itemPartName = "item_shaozi",
				grabFrom = 1
			}
		},
		[1.5] = {
			{
				grabBy = 0,
				attachPoint = "gua_L_hand_bone",
				action = "grabPart",
				itemPartName = "item_guogai",
				grabFrom = 1
			}
		},
		[1.6] = {
			{
				attachPoint = "gua_smoke",
				efxPath = "Dorm/Effect/houzhai/fx_HZ04_TG_male_smoke",
				action = "playEfx",
				entity = 1,
				duration = 2.3
			}
		},
		[3.83333333333333] = {
			{
				itemPartHost = 1,
				itemPartName = "item_guogai",
				action = "restorePart"
			}
		},
		[8.3] = {
			{
				itemPartHost = 1,
				itemPartName = "item_shaozi",
				action = "restorePart"
			}
		}
	},
	keys = {
		0,
		0.6,
		1.5,
		1.6,
		3.83333333333333,
		8.3
	},
	duration = 9.367,
	fps = 30
}
