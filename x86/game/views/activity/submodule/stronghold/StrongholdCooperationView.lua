slot1 = class("StrongholdCooperationView", import("game.views.cooperation.CooperationView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdCooperationUI"
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	for slot4 = 1, 3 do
		slot0["skillTypeController_" .. slot4] = ControllerUtil.GetController(slot0["m_skillTrs" .. slot4], "click")
		slot0["skillLockController_" .. slot4] = ControllerUtil.GetController(slot0["m_skillTrs" .. slot4], "lock")
	end

	slot0.selfSkillTypeController = ControllerUtil.GetController(slot0.m_skillContent, "select")
end

function slot1.AddUIListener(slot0)
	uv0.super.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_skillBtn1, function ()
		StrongholdAction.QueryChooseRoomSkillType(uv0.roomData.room_id, 1)
	end)
	slot0:AddBtnListener(nil, slot0.m_skillBtn2, function ()
		StrongholdAction.QueryChooseRoomSkillType(uv0.roomData.room_id, 2)
	end)
	slot0:AddBtnListener(nil, slot0.m_skillBtn3, function ()
		StrongholdAction.QueryChooseRoomSkillType(uv0.roomData.room_id, 3)
	end)
	slot0:AddBtnListener(nil, slot0.m_skillInfoBtn, function ()
		JumpTools.OpenPageByJump("strongholdSkillInfo")
	end)
end

function slot1.RefreshUI(slot0)
	slot0.skillTypes = StrongholdData:GetRoomSkillTypes(slot0.roomData.room_id)

	for slot4 = 1, 3 do
		slot0["skillTypeController_" .. slot4]:SetSelectedIndex(slot0.skillTypes[slot4] or 0)

		slot6, slot7, slot8, slot9 = StrongholdData:GetStrongholdLevel(slot4)

		if slot7 < StrongholdData:GetSkillLimitLv() then
			slot0["skillLockController_" .. slot4]:SetSelectedIndex(1)
		else
			slot0["skillLockController_" .. slot4]:SetSelectedIndex(0)
		end

		slot0["m_skillIcon" .. slot4].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/XuHeng3rdUI/StrongholdUI/StrongholdSkill/" .. slot4)
	end

	slot0.selfSkillTypeController:SetSelectedIndex(StrongholdData:GetSelfRoomSkillType(slot0.roomData.room_id))
end

function slot1.GetRoomName(slot0)
	return ActivityStrongholdCfg[slot0.roomData.dest] and ActivityStrongholdCfg[slot1].room_name or ""
end

function slot1.ShowComboIncreaseGo(slot0)
	return true
end

return slot1
