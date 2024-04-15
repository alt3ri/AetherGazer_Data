slot0 = class("EquipNewSkillInfoView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.transform_ = slot1.transform
	slot0.gameObject_ = slot1

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillInfoList_ = {}
	slot0.locationList = {}
	slot0.infoScrollHelper_ = LuaList.New(handler(slot0, slot0.indexInfoItem), slot0.skillListGo_, EquipSkillInfoItem)
	slot0.locationScrollHelper_ = LuaList.New(handler(slot0, slot0.indexLocationItem), slot0.locationListGo_, EquipSkillLocationItem)
	slot0.stateController_ = slot0.skillCon_:GetController("state")
	slot0.tabController_ = slot0.skillCon_:GetController("tab")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnSkill_, nil, function ()
		uv0.tabController_:SetSelectedState("skill")
	end)
	slot0:AddBtnListener(slot0.btnLoacation_, nil, function ()
		uv0.tabController_:SetSelectedState("location")
	end)
end

function slot0.RefreshData(slot0, slot1, slot2, slot3)
	slot0.handler_ = slot1
	slot0.info_ = slot2
	slot0.isShowLocate_ = slot3

	slot0:RefreshInfoList()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Equip/EquipSkillIcon/" .. slot0.skillCfg_.icon)
	slot0.name_.text = GetI18NText(slot0.skillCfg_.name)
	slot0.lv_.text = string.format("%s/%s", slot0.info_.num, slot0.skillCfg_.lvmax)

	slot0.stateController_:SetSelectedState(slot0.isShowLocate_ and "on" or "off")
	slot0.tabController_:SetSelectedState("skill")
	slot0.infoScrollHelper_:StartScroll(#slot0.skillInfoList_)

	if slot0.isShowLocate_ and slot0.info_.location then
		slot0.locationScrollHelper_:StartScroll(#slot0.info_.location)
	end
end

function slot0.RefreshInfoList(slot0)
	slot0.skillInfoList_ = {}
	slot0.skillCfg_ = EquipSkillCfg[slot0.info_.id]

	for slot4 = 1, slot0.skillCfg_.lvmax do
		if slot0.skillCfg_.desc_spec_value ~= nil and slot0.skillCfg_.desc_spec_value ~= "" then
			-- Nothing
		end

		table.insert(slot0.skillInfoList_, {
			level = GetTips("LEVEL") .. string.format("%d", slot4),
			desc = GetCfgDescriptionWithValue(slot0.skillCfg_.desc[1], tostring(slot0.skillCfg_.upgrade / slot0.skillCfg_.percent * slot4)),
			desc = string.gsub(desc, tostring(slot6), slot0.skillCfg_.desc_spec_value[slot4]),
			alpha = slot4 <= slot0.info_.num and 1 or 0.5
		})
	end
end

function slot0.indexInfoItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0, slot0.skillInfoList_[slot1])
end

function slot0.indexLocationItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0, slot0.info_.location[slot1])
end

function slot0.Dispose(slot0)
	if slot0.infoScrollHelper_ then
		slot0.infoScrollHelper_:Dispose()

		slot0.infoScrollHelper_ = nil
	end

	if slot0.locationScrollHelper_ then
		slot0.locationScrollHelper_:Dispose()

		slot0.locationScrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
