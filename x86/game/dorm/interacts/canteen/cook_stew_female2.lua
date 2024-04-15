return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "02",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "stew"
			}
		},
		[1.5] = {
			{
				grabBy = 0,
				attachPoint = "gua_L_hand_bone",
				action = "grabPart",
				itemPartName = "item_guogai",
				grabFrom = 1
			},
			{
				attachPoint = "gua_smoke",
				efxPath = "Dorm/Effect/houzhai/fx_HZ04_TGsmoke",
				action = "playEfx",
				entity = 1,
				duration = 13
			}
		},
		[4.2] = {
			{
				grabBy = 0,
				attachPoint = "gua_R_hand_bone",
				action = "grabPart",
				itemPartName = "item_shaozi",
				grabFrom = 1
			}
		},
		[9.03333333333333] = {
			{
				itemPartHost = 1,
				itemPartName = "item_shaozi",
				action = "restorePart"
			}
		},
		[12.3666666666667] = {
			{
				itemPartHost = 1,
				itemPartName = "item_guogai",
				action = "restorePart"
			}
		}
	},
	keys = {
		0,
		1.5,
		4.2,
		9.03333333333333,
		12.3666666666667
	},
	duration = 14.33333,
	fps = 30
}
