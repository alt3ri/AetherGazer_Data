local var_0_0 = {
	[0] = {
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 1,
			animeActionName = "pool_dabble"
		},
		{
			animeActionSubName = "",
			crossFade = 0.02,
			action = "play",
			entity = 0,
			animeActionName = "pool_dabble"
		},
		{
			attachPoint = "root",
			efxPath = "Dorm/Effect/houzhai/fx_pool_dabble",
			action = "playEfx",
			entity = 1,
			duration = 10.3
		}
	}
}
local var_0_1 = {
	sequence = var_0_0,
	keys = {
		0
	}
}

var_0_1.duration = 10.36667
var_0_1.fps = 30

return var_0_1
