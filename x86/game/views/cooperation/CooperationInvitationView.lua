slot0 = class("CooperationInvitationView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Cooperation/CooperationInvitationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.toggles_ = {
		slot0.m_friendBtn,
		slot0.m_guildBtn,
		slot0.m_nearBtn
	}
	slot0.typeList_ = {
		CooperationConst.INVITE_TYPE.FRIEND,
		CooperationConst.INVITE_TYPE.GUILD,
		CooperationConst.INVITE_TYPE.RECENT
	}
	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, CooperationInvitationItem)
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggles_) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SelectGroup(table.indexof(uv0.toggles_, uv1))
			end
		end)
	end

	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.SelectGroup(slot0, slot1)
	slot0.curType_ = slot0.typeList_[slot1]
	slot0.curPlayerList_ = slot0.inviteData_[slot0.curType_] or {}

	table.sort(slot0.curPlayerList_, function (slot0, slot1)
		if uv0:GetPlayerStatus(slot0) ~= uv0:GetPlayerStatus(slot1) then
			return slot2 < slot3
		end

		return slot0.uid < slot1.uid
	end)
	slot0.list:StartScroll(#slot0.curPlayerList_)
end

function slot0.GetPlayerStatus(slot0, slot1)
	if CooperationData:GetHadInvited(slot1.uid) then
		return 3
	elseif not CooperationTools.IsInvitationValid(slot0.activityId_, slot1.uid, slot1.activity_data_list) then
		return 2
	end

	return 1
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.activityId_ = CooperationData:GetRoomData().activity_id

	CooperationData:ClearHadInvited()

	if GuildData:GetGuildInfo() ~= nil and slot2.id ~= nil then
		SetActive(slot0.m_guildBtn.gameObject, true)
		CooperationAction.RequestInviteList(slot0.typeList_)
	else
		SetActive(slot0.m_guildBtn.gameObject, false)
		CooperationAction.RequestInviteList({
			CooperationConst.INVITE_TYPE.FRIEND,
			CooperationConst.INVITE_TYPE.RECENT
		})
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnCooperationInviteListUpdate(slot0, slot1)
	slot0.inviteData_ = slot1

	slot0:SelectGroup(1)

	slot0.toggles_[1].isOn = true
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.curType_, slot0.curPlayerList_[slot1])
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnCooperationInviteSuccess(slot0)
	for slot5, slot6 in pairs(slot0.list:GetItemList()) do
		slot6:UpdateState()
	end
end

return slot0
