slot0 = class("StrongholdSkillInfoView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdPopupUI"
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

	slot0.list = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, StrongholdSkillInfoItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.skillTypes = StrongholdData:GetRoomSkillTypes(CooperationData:GetRoomData().room_id)
	slot0.skillTypes_key = {
		1,
		2,
		3
	}

	slot0.list:StartScroll(#slot0.skillTypes_key)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.list:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot3, slot0.skillTypes[slot0.skillTypes_key[slot1]] or 0)
end

return slot0
