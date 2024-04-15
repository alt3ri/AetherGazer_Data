slot0 = {
	SetEntity = function (slot0)
		uv0 = slot0

		Dorm.LuaBridge.MiniGameBridge.MuteAudioTriggerOnEntityAnimator(slot0)
	end,
	Work = function ()
		slot1 = Dorm.storage:PickData(LianLianKanGameManager.ItemEidNameSpace(DormEnum.ItemType.Pan))

		if uv0 and slot1 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(slot0, slot1, false)
		end
	end,
	Cook = function (slot0, slot1, slot2)
		if slot0 ~= uv0 then
			return
		end

		(DormCharacterInteractBehaviour.MakeInteractTask(uv1("saucepan", BackHomeHeroSkinCfg[DormUtils.GetEntityData(slot0).cfgID].style), DormCharacterInteractBehaviour.MakeCtx(slot0, slot1)) or DormCharacterActionManager.taskRunner:NewTask()):Then(function ()
			uv0:Notify()
		end):Start()
	end,
	OnEntityCompleteAllCmd = function (slot0)
		if slot0 == uv0 then
			if uv1 ~= nil then
				uv1:Abort()
			end

			slot2 = DormUtils.GetEntityData(uv0)
			uv1 = DormCharacterActionManager.taskRunner:NewTask():WaitUntil(function ()
				return (uv0.pause or 0) <= UnityEngine.Time.time
			end):Then(function ()
				uv0.pause = nil

				uv1.Work()

				uv2 = nil
			end):SetOnAbort(function ()
				uv0 = nil
			end)

			uv1:Start()
		end
	end,
	OnPauseForSec = function (slot0)
		DormUtils.GetEntityData(uv0).pause = UnityEngine.Time.time + slot0
	end
}
slot2 = require("game.dorm.canteen.RestaurantCharacter.InteractAction.InteractUtil").waitAnime.handleEventWaitAnimation
slot3 = nil

function slot4(slot0, slot1)
	if package.loaded["game.dorm.interacts.canteen.cook_" .. slot0 .. "_" .. slot1] then
		if type(slot3) == "table" then
			return slot3
		end
	elseif Dorm.InteractionGrouping[slot2] then
		return slot4[math.random(#slot4)]
	end
end

slot5 = nil
slot0.events = {
	[ON_DORM_CHARACTER_WAIT_CMD] = slot0.OnEntityCompleteAllCmd,
	[ON_DORM_CHARACTER_INTERACT] = slot0.Cook,
	[LIANLIANKAN_PREVIEW_REMOVE_ALL] = slot0.OnPauseForSec
}

return slot0
