slot0 = class("ActivityAttributeArenaRankSwitchItem", ReduxView)

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

	slot0.selectedController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_btn, function ()
		if uv0.clickFunc then
			uv0.clickFunc(uv0.index)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index = slot1

	slot0.selectedController:SetSelectedState(slot1 == slot2 and "true" or "false")

	slot3 = GetTips("ACTIVITY_ATTRIBUTE_RANK_" .. slot1)
	slot0.labText_1.text = slot3
	slot0.labText_2.text = slot3
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.clickFunc = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
