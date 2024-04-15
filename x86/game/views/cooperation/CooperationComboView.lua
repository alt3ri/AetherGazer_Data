slot0 = class("CooperationComboView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/Stronghold/StrongholdbuffUI"
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
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_mask, function ()
		uv0:Back()
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

return slot0
