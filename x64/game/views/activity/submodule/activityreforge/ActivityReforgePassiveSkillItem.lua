slot0 = class("ActivityReforgePassiveSkillItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.skillItemList_ = {}
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.viewType_ = slot1
	slot0.skillList_ = slot2
	slot0.itemSelectHandler_ = slot3
	slot0.activityID_ = slot4
	slot0.levelID_ = slot5
	slot0.curSkillID_ = slot6
	slot0.slotText_.text = GetTips("ACTIVITY_REFORGE_PASSIVE_SLOT")
	slot11 = GetTips("ACTIVITY_REFORGE_USE_MAX")
	slot12 = ActivityReforgeData:GetPassiveSkillUseNum() .. "/" .. #slot0.skillList_
	slot0.slotNumText_.text = string.format(slot11, slot12)

	for slot11, slot12 in pairs(slot0.skillList_) do
		if slot0.skillItemList_[slot11] == nil then
			slot0.skillItemList_[slot11] = ActivityReforgeSkillItem.New(Object.Instantiate(slot0.itemGo_, slot0.contentTrans_))
		end

		slot0.skillItemList_[slot11]:SetIsActive(true)
		slot0.skillItemList_[slot11]:SetData(slot0.viewType_, slot0.skillList_[slot11], slot0.itemSelectHandler_, slot0.activityID_, slot0.levelID_, slot0.curSkillID_)
	end

	for slot11 = #slot0.skillList_ + 1, #slot0.skillItemList_ do
		slot0.skillItemList_[slot11]:SetIsActive(false)
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.OnExit(slot0)
	for slot4, slot5 in pairs(slot0.skillItemList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.skillItemList_) do
		slot0.skillItemList_[slot4]:Dispose()

		slot0.skillItemList_[slot4] = nil
	end

	slot0.clickHandle_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
