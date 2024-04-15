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
		[1.33333333333333] = {
			{
				grabBy = 0,
				attachPoint = "gua_L_hand_bone",
				action = "grabPart",
				itemPartName = "item_guogai",
				grabFrom = 1
			}
		},
		[1.73333333333333] = {
			{
				attachPoint = "gua_smoke",
				efxPath = "Dorm/Effect/houzhai/fx_HZ04_ZLsmoke",
				action = "playEfx",
				entity = 1,
				duration = 18
			}
		},
		[3.3] = {
			{
				grabBy = 0,
				attachPoint = "gua_R_hand_bone",
				action = "grabPart",
				itemPartName = "item_shaozi",
				grabFrom = 1
			}
		},
		[10.3333333333333] = {
			{
				itemPartHost = 1,
				itemPartName = "item_shaozi",
				action = "restorePart"
			}
		},
		[14.1333333333333] = {
			{
				itemPartHost = 1,
				itemPartName = "item_guogai",
				action = "restorePart"
			}
		}
	},
	keys = {
		0,
		1.33333333333333,
		1.73333333333333,
		3.3,
		10.3333333333333,
		14.1333333333333
	},
	duration = 18.36667,
	fps = 30
}
