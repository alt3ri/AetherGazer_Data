slot0 = class("EquipSkillInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/EquipSkillPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.uiListGo_, EquipSkillInfoItem2)
end

function slot0.OnEnter(slot0)
	if slot0.equipSkillData_ and slot0.equipSkillData_.id == slot0.params_.equipSkillData.id then
		return
	end

	slot0.equipSkillData_ = slot0.params_.equipSkillData

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.uiList_:Dispose()

	slot0.uiList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0.selectItem_:ShowSelect(false)
		uv0:Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = EquipSkillCfg[slot0.equipSkillData_.id]
	slot0.selectItem_ = slot0.equipSkillData_.selectItem

	slot0.selectItem_:ShowSelect(true)

	slot0.iconImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot1.icon)
	slot0.nameText_.text = GetI18NText(slot1.name)
	slot0.lvText_.text = string.format("%s/%s", slot0.equipSkillData_.skillLevel, slot1.lvmax)

	slot0.uiList_:StartScroll(EquipSkillCfg[slot0.equipSkillData_.id].lvmax)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.equipSkillData_.id, slot0.equipSkillData_.skillLevel, slot1)
end

return slot0
