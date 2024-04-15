slot0 = class("ServantCallNameTabModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.tabController_,
		select = {
			False = "false",
			True = "true",
			comps = slot0.tabController_:GetController("select")
		}
	}
	slot0.data = {
		tabIdx = 1
	}
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.tabClickBtn_, nil, function ()
		uv0:OnTabClick()
	end)
end

function slot0.SetTabIndex(slot0, slot1)
	slot0.data.tabIdx = slot1
end

function slot0.SetNumber(slot0, slot1)
	slot0.callNameCountTxt_.text = slot1
end

function slot0.SetSelect(slot0, slot1)
	slot2 = slot0.controller.select.False

	if slot1 then
		slot2 = slot0.controller.select.True
	end

	slot0.controller.select.comps:SetSelectedState(slot2)
end

function slot0.RegisterClickCallback(slot0, slot1)
	slot0.data.clickCallback = slot1
end

function slot0.OnTabClick(slot0)
	if slot0.data.clickCallback then
		slot1(slot0.data.tabIdx)
	end
end

function slot0.OnDispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
