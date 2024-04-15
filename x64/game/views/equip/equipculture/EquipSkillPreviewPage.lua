slot0 = class("EquipSkillPreviewPage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/Develop/EnchantPopUPUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.titleHieght_ = 75
	slot0.itemHeight_ = 156

	slot0:InitUI()
	slot0:AddUIListeners()
	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.enchantList_ = EquipSkillCfg.get_id_list_by_skill_type[EquipConst.EQUIP_ATTRIBUTE_TYPE.ENCHANT]

	slot0:InitPreview()

	slot0.attackScrollHelper_ = LuaList.New(handler(slot0, slot0.IndexAttackItem), slot0.skillListGo_1, EnchantSkillItem)
	slot0.defenceScrollHelper_ = LuaList.New(handler(slot0, slot0.IndexDefenceItem), slot0.skillListGo_2, EnchantSkillItem)
	slot0.subScrollHelper_ = LuaList.New(handler(slot0, slot0.IndexSubItem), slot0.skillListGo_3, EnchantSkillItem)
end

function slot0.InitPreview(slot0)
	slot0.skillList_ = {
		{},
		{},
		{}
	}
	slot0.skillLine_ = {}

	for slot4, slot5 in ipairs(slot0.enchantList_) do
		table.insert(slot0.skillList_[EquipSkillCfg[slot5].type], slot5)
	end

	for slot4, slot5 in ipairs(slot0.skillList_) do
		slot0.skillLine_[slot4] = math.ceil(#slot5 / 2)
	end

	for slot4 = 1, 3 do
		slot7 = slot0.skillLine_[slot4]

		slot0["skillRect_" .. slot4].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, slot0.titleHieght_ + slot0.itemHeight_ * slot7)
		slot0["skillListGo_" .. slot4].transform:SetSizeWithCurrentAnchors(RectTransform.Axis.Vertical, slot0.itemHeight_ * slot7)
	end
end

function slot0.IndexAttackItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.skillList_[1][slot1],
		num = 1,
		preview = true
	})
end

function slot0.IndexDefenceItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.skillList_[2][slot1],
		num = 1,
		preview = true
	})
end

function slot0.IndexSubItem(slot0, slot1, slot2)
	slot2:RefreshData({
		id = slot0.skillList_[3][slot1],
		num = 1,
		preview = true
	})
end

function slot0.OnEnter(slot0)
	slot0.attackScrollHelper_:StartScroll(#slot0.skillList_[1])
	slot0.defenceScrollHelper_:StartScroll(#slot0.skillList_[2])
	slot0.subScrollHelper_:StartScroll(#slot0.skillList_[3])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btnBack_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.attackScrollHelper_:Dispose()
	slot0.defenceScrollHelper_:Dispose()
	slot0.subScrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
