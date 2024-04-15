slot1 = class("XuHeng3rdDemonChallengeMainView", import("game.views.activity.Submodule.DemonChallenge.Dream.DreamDemonChallengeMainView"))

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.glowController = ControllerUtil.GetController(slot0.glow_, "name")
end

function slot1.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.curLevelIndex_ ~= slot1 then
		manager.audio:PlayEffect("minigame_activity_2_2", "minigame_activity_2_2_xinmo_turn", "")
		slot0:ResetAnimator(slot0.roleAni_, "XuHeng3rdDemonLevelUI_shuimo")

		slot0.roleAni_.enabled = true

		slot0.glowController:SetSelectedIndex(slot1 - 1)
	end

	saveData("DemonChallenge" .. "_" .. USER_ID, tostring(slot2), manager.time:GetServerTime())
	uv0.super.OnLevelSelect(slot0, slot1, slot2, slot3, slot4)
end

function slot1.LevelRenderer(slot0, slot1, slot2)
	if slot0.levelControllerS_[slot1] == nil then
		slot0.levelControllerS_[slot1] = ControllerUtil.GetController(slot2.transform, "lock")
	end

	slot0.levelControllerS_[slot1]:SetSelectedState("false")

	slot0.lockTextS_[slot1] = slot0:FindCom(typeof(Text), "title/lock/text", slot2.transform)

	slot0:AddBtnListener(slot0:FindCom(typeof(Button), "title/lock", slot2.transform), nil, function ()
		if ActivityData:GetActivityData(uv0).stopTime <= manager.time:GetServerTime() then
			ShowTips("TIME_OVER")
		else
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(slot0.startTime)))
		end
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.windowBar:SetGameHelpKey("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")
end

function slot1.ResetAnimator(slot0, slot1, slot2)
	slot1:Play(slot2, 0, 0)
	slot1:Update(0)

	slot1.enabled = false
end

return slot1
