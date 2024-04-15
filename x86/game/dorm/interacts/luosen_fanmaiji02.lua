return {
	sequence = {
		[0] = {
			{
				referencePointName = "gua_start",
				referenceTarget = 1,
				action = "putAt",
				entity = 0
			},
			{
				animeActionSubName = "02",
				crossFade = 0.01,
				action = "play",
				entity = 0,
				animeActionName = "lawson_vending_machine"
			},
			{
				animeActionSubName = "02",
				crossFade = 0.01,
				action = "play",
				entity = 1,
				animeActionName = "lawson_vending_machine"
			}
		},
		[4.03333333333333] = {
			{
				grabBy = 0,
				attachPoint = "gua_L_hand_bone",
				action = "grabPart",
				itemPartName = "item_yanqiu",
				grabFrom = 1
			}
		},
		[5.53333333333333] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_lawson_fanmaiji_2",
				action = "playEfx",
				entity = 0,
				duration = 1.5
			}
		},
		[5.8] = {
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_lawson_fanmaiji_3",
				action = "playEfx",
				entity = 0,
				duration = 1.5
			}
		},
		[7.86666666666667] = {
			{
				itemPartHost = 1,
				itemPartName = "item_yanqiu",
				action = "restorePart"
			}
		}
	},
	keys = {
		0,
		4.03333333333333,
		5.53333333333333,
		5.8,
		7.86666666666667
	},
	duration = 10,
	fps = 30
}
