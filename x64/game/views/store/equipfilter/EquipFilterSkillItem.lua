slot0 = class("EquipFilterSkillItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = slot0.controllerEx_:GetController("state")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.data_.cnt <= 0 then
			return
		end

		slot0 = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE

		if uv0.selectState_ == StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD then
			slot0 = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
		end

		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = uv0.data_.type,
			id = uv0.data_.id,
			state = slot0
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.data_ = slot1
	slot0.selectState_ = slot2
	slot4 = slot1.cnt
	slot5 = EquipSkillCfg[slot1.id]
	slot0.name_.text = GetI18NText(slot5.name)
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot5.icon)
	slot0.num_.text = slot4

	if slot4 <= 0 then
		slot0.selectController_:SetSelectedState("lock")
	elseif slot2 then
		slot0.selectController_:SetSelectedState("select")

		slot0.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
	else
		slot0.selectController_:SetSelectedState("false")

		slot0.selectState_ = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.ADD
	end
end

function slot0.GetData(slot0)
	return slot0.data_
end

return slot0
