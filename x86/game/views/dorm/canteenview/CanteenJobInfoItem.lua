slot0 = class("CanteenJobInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)

	SetActive(slot0.gameObject_, true)

	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.gameObject_.transform, "name")
	slot0.jobController = ControllerUtil.GetController(slot0.gameObject_.transform, "job")
	slot0.heroItem = CanteenHeroItem.New(slot0.heroitemGo_1)

	slot0.heroItem:SetFunction(true)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.jobText.text = CanteenTools:GetJobName(slot1)

	if slot1 == DormNpcTools.BackHomeNpcType.cook then
		slot0.jobController:SetSelectedState("cook")
	elseif slot1 == DormNpcTools.BackHomeNpcType.waiter then
		slot0.jobController:SetSelectedState("waiter")
	elseif slot1 == DormNpcTools.BackHomeNpcType.cashier then
		slot0.jobController:SetSelectedState("cashier")
	end

	if CanteenHeroTools:GetCanteenJobList()[slot1] then
		if slot3.heroID then
			slot0.stateController:SetSelectedState("normal")
			slot0.heroItem:RefreshUI(slot4)
		else
			slot0.stateController:SetSelectedState("empty")
		end
	end
end

function slot0.Dispose(slot0)
	slot0.heroItem:Dispose()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
