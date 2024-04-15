slot1 = class("FactorySkinTrialActivityView", import("game.views.skinTrialActivity.SkinTrialActivityView"))

function slot1.UIName(slot0)
	if SDKTools.GetIsOverSea() then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_oversea"
	end

	if slot0.params_.activityID == ActivityConst.FACTORY_SKIN_TRIAL then
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_1"
	else
		return "UI/MardukUI/skinTrial/MardukSkinTrialMainUI_2"
	end
end

function slot1.RefreshSkinItem(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot5] then
			slot0.skinItemList_[slot5]:SetSkinTrialID(slot6)
		else
			slot0.skinItemList_[slot5] = slot0:GetItemClass().New(slot0:GetSkinItemObj(slot5), slot6)
		end
	end

	for slot5 = #slot0.skinItemList_, #slot0.skinTrialIDList_ + 1, -1 do
		slot0.skinItemList_[slot5]:Dispose()

		slot0.skinItemList_[slot5] = nil
	end
end

function slot1.GetSkinItemObj(slot0, slot1)
	if not SDKTools.GetIsOverSea() then
		return slot0.skinItemPanel_:GetChild(slot1 - 1).gameObject
	else
		return Object.Instantiate(slot0.skinItem_, slot0.skinItemPanel_)
	end
end

function slot1.GetskinTrialIDList(slot0)
	slot1 = {}
	slot2 = {}
	slot3 = {}

	if SDKTools.GetIsOverSea() then
		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA) then
			slot2[#slot2 + 1] = ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA) then
			slot2[#slot2 + 1] = ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA
		end
	else
		slot2[#slot2 + 1] = slot0.activityID_
	end

	for slot7, slot8 in ipairs(slot2) do
		table.insertto(slot3, ActivityData:GetActivityData(slot8).subActivityIdList)
	end

	for slot7, slot8 in ipairs(slot3) do
		for slot13, slot14 in ipairs(ActivitySkinTrialCfg.get_id_list_by_activity_id[slot8]) do
			table.insert(slot1, slot14)
		end
	end

	return slot1
end

function slot1.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		return
	end

	for slot4, slot5 in ipairs(slot0.skinTrialIDList_) do
		if slot0.skinItemList_[slot4] and slot0.skinItemList_[slot4].RefreshTime ~= nil then
			slot0.skinItemList_[slot4]:RefreshTime()
		end
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			return
		end

		for slot3, slot4 in ipairs(uv0.skinTrialIDList_) do
			if uv0.skinItemList_[slot3] and uv0.skinItemList_[slot3].RefreshTime ~= nil then
				uv0.skinItemList_[slot3]:RefreshTime()
			end
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot1.GetItemClass(slot0)
	return FactorySkinTrialActivityItem
end

return slot1
