return {
	sequence = {
		[0] = {
			{
				animeActionSubName = "",
				crossFade = 0.05,
				action = "play",
				entity = 0,
				animeActionName = "break_success"
			},
			{
				attachPoint = "root",
				efxPath = "Dorm/Effect/houzhai/fx_pizhuan_success",
				action = "playEfx",
				entity = 0,
				duration = -1
			}
		},
		[1.06666666666667] = {
			{
				grabBy = 1,
				attachPoint = "gua_invisible",
				action = "grabPart",
				itemPartName = "piwa",
				grabFrom = 1
			},
			{
				grabBy = 1,
				attachPoint = "root",
				action = "grabPart",
				itemPartName = "piwa_crack",
				grabFrom = 1
			}
		},
		[1.8] = function (slot0)
			Dorm.DormEntityManager.ClearAllEffect(slot0.entityID, "pizhuan_game")
		end
	},
	duration = 4.6,
	fps = 30
}
