return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "break_fail"
			},
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_pizhuan_fail_1",
				action = "playEfx",
				entity = 0,
				duration = -1
			},
			{
				attachPoint = "gua_R_hand",
				efxPath = "Dorm/Effect/houzhai/fx_pizhuan_fail_2_Bip001_R_Hand",
				action = "playEfx",
				entity = 0,
				duration = -1
			}
		},
		[1.06666666666667] = function (slot0)
			Dorm.DormEntityManager.ClearAllEffect(slot0.entityID, "pizhuan_game")
		end
	},
	duration = 7.6,
	fps = 30
}
