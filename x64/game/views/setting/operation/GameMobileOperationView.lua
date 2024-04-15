slot0 = class("GameMobileOperationView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.battleSetBtn_, nil, function ()
		uv0:Go("battleUIAdjust", {})
	end)
end

function slot0.AddEventListeners(slot0)
end

function slot0.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot0.SaveData(slot0)
end

function slot0.CheckDataChange(slot0)
	return false
end

function slot0.RecoverTmpData(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.UpdatePageData(slot0)
end

return slot0
