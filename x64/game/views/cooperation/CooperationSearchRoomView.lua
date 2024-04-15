slot0 = class("CooperationSearchRoomView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Cooperation/CooperationSearchRoomUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0.m_inputField.textComponent:RegisterDirtyVerticesCallback(function ()
		slot0 = string.match(uv0.m_inputField.text, "%d+")
		uv0.m_inputField.text = slot0
		uv0.m_inputField.textComponent.text = slot0
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_searchBtn, nil, function ()
		if tonumber(uv0.m_inputField.text) == nil then
			ShowTips("ACTIVITY_STRONGHOLD_ROOM_NUM_TIPS")

			return
		end

		slot1, slot2 = textLimit(uv0.m_inputField.text, 10)

		if not slot2 then
			ShowTips("ACTIVITY_STRONGHOLD_CORRECT_ROOM_NUM_TIPS")

			return
		end

		CooperationAction.JoinRoom(slot0, nil, CooperationConst.JOIN_ROOM_SOURCE.ROOM_ID)
	end)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
