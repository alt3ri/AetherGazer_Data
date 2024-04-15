slot0 = class("StoreEquipFilterPanel", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.sortController_ = slot0.sortControllerEx_:GetController("sort")
	slot0.colorController_ = slot0.filterControllerEx_:GetController("color")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.decomposeBtn_, nil, function ()
		JumpTools.GoToSystem("/equipDecompose", {}, ViewConst.SYSTEM_ID.BAG)
	end)
	slot0:AddBtnListener(slot0.filterBtn_, nil, function ()
		uv0:Go("equipFilter", {
			filterParams = uv0.filterParams_,
			equipPosition = uv0.equipPosition_
		})
	end)
	slot0:AddBtnListener(slot0.sortBtn_, nil, function ()
		manager.notify:Invoke(SWITCH_SORT)
	end)
	slot0:AddToggleListener(slot0.sortDropdown_, function (slot0)
		manager.notify:Invoke(SWITCH_SORT_RARE, slot0)
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.filterParams_ = slot1
	slot0.equipPosition_ = slot2
	slot0.cntText_.text = string.format("%d/%d", EquipTools.GetEquipNum(), GameSetting.max_equip.value[1])

	if slot1.order == ItemConst.SORT_TYPE.DOWN then
		slot0.sortController_:SetSelectedState("down")
	else
		slot0.sortController_:SetSelectedState("up")
	end

	if #slot1.suit > 0 or #slot1.skill > 0 then
		slot0.colorController_:SetSelectedState("orange")
	else
		slot0.colorController_:SetSelectedState("normal")
	end
end

return slot0
