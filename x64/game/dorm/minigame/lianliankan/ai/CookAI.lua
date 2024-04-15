local var_0_0 = {}
local var_0_1 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.InteractUtil").waitAnime.handleEventWaitAnimation
local var_0_2

function var_0_0.SetEntity(arg_1_0)
	var_0_2 = arg_1_0

	Dorm.LuaBridge.MiniGameBridge.MuteAudioTriggerOnEntityAnimator(arg_1_0)
end

function var_0_0.Work()
	local var_2_0 = var_0_2
	local var_2_1 = Dorm.storage:PickData(LianLianKanGameManager.ItemEidNameSpace(DormEnum.ItemType.Pan))

	if var_2_0 and var_2_1 then
		Dorm.DormEntityManager.SendInteractToEntityCMD(var_2_0, var_2_1, false)
	end
end

local function var_0_3(arg_3_0, arg_3_1)
	local var_3_0 = "game.dorm.interacts.canteen.cook_" .. arg_3_0 .. "_" .. arg_3_1
	local var_3_1 = package.loaded[var_3_0]

	if var_3_1 then
		if type(var_3_1) == "table" then
			return var_3_1
		end
	else
		local var_3_2 = Dorm.InteractionGrouping[var_3_0]

		if var_3_2 then
			return var_3_2[math.random(#var_3_2)]
		end
	end
end

function var_0_0.Cook(arg_4_0, arg_4_1, arg_4_2)
	if arg_4_0 ~= var_0_2 then
		return
	end

	local var_4_0 = DormUtils.GetEntityData(arg_4_0).cfgID
	local var_4_1 = BackHomeHeroSkinCfg[var_4_0].style
	local var_4_2 = var_0_3("saucepan", var_4_1)
	local var_4_3 = DormCharacterInteractBehaviour.MakeCtx(arg_4_0, arg_4_1)

	;(DormCharacterInteractBehaviour.MakeInteractTask(var_4_2, var_4_3) or DormCharacterActionManager.taskRunner:NewTask()):Then(function()
		arg_4_2:Notify()
	end):Start()
end

local var_0_4

function var_0_0.OnEntityCompleteAllCmd(arg_6_0)
	if arg_6_0 == var_0_2 then
		if var_0_4 ~= nil then
			var_0_4:Abort()
		end

		local var_6_0 = DormCharacterActionManager.taskRunner
		local var_6_1 = DormUtils.GetEntityData(var_0_2)

		var_0_4 = var_6_0:NewTask():WaitUntil(function()
			return (var_6_1.pause or 0) <= UnityEngine.Time.time
		end):Then(function()
			var_6_1.pause = nil

			var_0_0.Work()

			var_0_4 = nil
		end):SetOnAbort(function()
			var_0_4 = nil
		end)

		var_0_4:Start()
	end
end

function var_0_0.OnPauseForSec(arg_10_0)
	DormUtils.GetEntityData(var_0_2).pause = UnityEngine.Time.time + arg_10_0
end

var_0_0.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = var_0_0.OnEntityCompleteAllCmd,
	[ON_DORM_CHARACTER_INTERACT] = var_0_0.Cook,
	[LIANLIANKAN_PREVIEW_REMOVE_ALL] = var_0_0.OnPauseForSec
}

return var_0_0
