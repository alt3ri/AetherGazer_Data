slot0 = class("CooperationInvitationItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.onlineController = ControllerUtil.GetController(slot0.transform_, "online")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_invitBtn, function ()
		slot0 = CooperationData:GetRoomData()
		slot1 = slot0.activity_id

		if slot0:IsFull() then
			ShowTips("COOPERATION_NO_ALLOW_INVITE_FULL")

			return
		end

		if not CooperationTools.IsInvitationValid(slot1, uv0.uid, uv0.playerData_.activity_data_list) then
			return
		end

		CooperationAction.InvitePlayer(uv0.uid, uv0.type)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index_ = slot1
	slot0.type = slot2
	slot0.playerData_ = slot3
	slot4 = 0
	slot0.m_name.text = slot3.nick
	slot0.m_lvLab.text = ""
	slot0.m_icon.sprite = ItemTools.getItemSprite(slot3.icon)
	slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. (slot3.icon_frame ~= 0 and slot3.icon_frame or 2001))
	slot0.m_lvLab.text = GetTips("LEVEL") .. string.format("%s", slot3.level or 0)
	slot0.uid = slot3.uid

	if (slot3.timestamp or 0) == 0 then
		slot0.m_timeLab.text = GetTips("ONLINE")

		slot0.onlineController:SetSelectedIndex(0)
	else
		slot0.m_timeLab.text = manager.time:GetOnLineText(slot4)

		slot0.onlineController:SetSelectedIndex(1)
	end

	slot0:UpdateState()
end

function slot0.UpdateState(slot0)
	slot2 = CooperationData:GetRoomData().activity_id

	if CooperationData:GetHadInvited(slot0.uid) then
		slot0.stateController:SetSelectedIndex(1)
	elseif not CooperationTools.IsInvitationValid(slot2, slot0.uid, slot0.playerData_.activity_data_list) then
		slot0.stateController:SetSelectedIndex(2)
	else
		slot0.stateController:SetSelectedIndex(0)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
