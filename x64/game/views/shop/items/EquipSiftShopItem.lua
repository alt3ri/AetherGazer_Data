slot0 = class("EquipSiftShopItem", ReduxView)

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

	slot0.stateController = slot0.controllerEx_:GetController("state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0.callback(uv0.id, uv0.stateController)
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.id = slot1
	slot0.cfg = EquipSuitCfg[slot1]
	slot0.selectTable = slot2
	slot0.callback = slot3
	slot0.isClickClean = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.name_.text = GetI18NText(slot0.cfg.name)

	SetSpriteWithoutAtlasAsync(slot0.icon_, SpritePathCfg.EquipIcon_s.path .. slot0.cfg.icon)
	slot0.stateController:SetSelectedState(slot0.selectTable[slot0.id] and "select" or "false")

	if slot0.isClickClean then
		slot0.stateController:SetSelectedState("false")
	end
end

function slot0.UpdateTimerView(slot0)
end

function slot0.RegistCallBack(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
