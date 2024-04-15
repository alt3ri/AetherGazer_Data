slot0 = class("EquipFilterSelectItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		manager.notify:Invoke(EQUIP_FILTER_SELECT_CHANGE, {
			type = uv0.data_.type,
			id = uv0.data_.id,
			state = StoreConst.EQUIP_FILTER_ITEM_ADD_OR_REMOVE.REMOVE
		})
	end)
end

function slot0.SetData(slot0, slot1)
	slot0.data_ = slot1

	slot0:Show(true)

	if slot1.type == StoreConst.EQUIP_FILTER_TYPE.SUIT then
		slot0.nameText_.text = GetI18NText(EquipSuitCfg[slot1.id].name)
	else
		slot0.nameText_.text = GetI18NText(EquipSkillCfg[slot1.id].name)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
