slot0 = class("SevenDaySkinItem_3_0", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rareController_ = slot0.controllerExCollection_:GetController("quality")
	slot0.starController_ = slot0.controllerExCollection_:GetController("star")
	slot0.pointController_ = slot0.controllerExCollection_:GetController("point")
	slot0.highLightController_ = slot0.controllerExCollection_:GetController("award")
	slot0.completedController_ = slot0.controllerExCollection_:GetController("completed")
	slot0.grayController_ = slot0.controllerExCollection_:GetController("gray")
	slot0.repController_ = slot0.controllerExCollection_:GetController("replenishment")
end

function slot0.RefreshView(slot0, slot1, slot2, slot3)
	slot0.item = slot1
	slot0.isResign = slot3
	slot4 = slot1[1]
	slot0.rewardState = slot2
	slot7 = ItemCfg[slot4].display_rare
	slot0.bottomAmountText_.text = slot1[2]

	slot0.rareController_:SetSelectedIndex(slot7)
	slot0.starController_:SetSelectedIndex(slot7)

	slot0.iconImage_.sprite = ItemTools.getItemSprite(slot4)

	if slot2 == 0 then
		if slot3 then
			slot0.highLightController_:SetSelectedIndex(0)
			slot0.completedController_:SetSelectedIndex(0)
			slot0.grayController_:SetSelectedIndex(0)
			slot0.pointController_:SetSelectedIndex(1)
			slot0.repController_:SetSelectedIndex(0)
		else
			slot0.highLightController_:SetSelectedIndex(0)
			slot0.completedController_:SetSelectedIndex(0)
			slot0.grayController_:SetSelectedIndex(0)
			slot0.pointController_:SetSelectedIndex(2)
			slot0.repController_:SetSelectedIndex(1)
		end
	elseif slot2 == 1 then
		slot0.highLightController_:SetSelectedIndex(1)
		slot0.completedController_:SetSelectedIndex(0)
		slot0.grayController_:SetSelectedIndex(0)
		slot0.pointController_:SetSelectedIndex(1)
		slot0.repController_:SetSelectedIndex(1)
	elseif slot2 == 2 then
		slot0.highLightController_:SetSelectedIndex(0)
		slot0.completedController_:SetSelectedIndex(1)
		slot0.grayController_:SetSelectedIndex(1)
		slot0.pointController_:SetSelectedIndex(0)
		slot0.repController_:SetSelectedIndex(1)
	end
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, handler(slot0, slot0.OnItemClick))
end

function slot0.RegisterListener(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.OnItemClick(slot0)
	if slot0.clickHandler_ and slot0.rewardState == 1 then
		slot0.clickHandler_()
	elseif slot0.clickHandler_ and slot0.isResign and slot0.rewardState == 0 then
		slot0.clickHandler_()
	else
		ShowPopItem(POP_ITEM, slot0.item)
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
