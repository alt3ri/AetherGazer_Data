slot0 = singletonClass("SkinTrialData")
slot1 = {}

function slot0.Init(slot0)
	slot0.skinTrialStateList_ = {}
	slot0.completedSkinTrialIDList_ = {}
	slot0.stageIDToSkinTrialID_ = {}
end

function slot0.InitData(slot0, slot1)
	slot2 = {}

	for slot6, slot7 in ipairs(slot1.activity_info) do
		if ActivitySkinTrialCfg[slot7.id] ~= nil then
			slot0.skinTrialStateList_[slot8] = slot7.state

			if not slot2[slot8] then
				slot2[slot8] = 0
			end

			if slot7.state == 1 then
				if table.keyof(slot0.completedSkinTrialIDList_, slot8) == nil then
					table.insert(slot0.completedSkinTrialIDList_, slot8)
				end
			else
				slot2[slot8] = 1
			end
		end
	end

	for slot6, slot7 in pairs(slot2) do
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot6), slot7)
	end
end

function slot0.OnRewardSuccess(slot0, slot1)
	slot0.skinTrialStateList_[slot1] = 1

	slot0:SetSelectSkinTrialID(slot1)
end

function slot0.GetSkinTrialStateList(slot0)
	return slot0.skinTrialStateList_
end

function slot0.SetSelectSkinTrialID(slot0, slot1)
	saveData("SkinTrial", string.format("select_%s_%s", ActivitySkinTrialCfg[slot1].activity_id, slot1), true)

	slot3 = ActivitySkinTrialCfg[slot1]

	if slot0:GetSkinTrialStatus(slot1) ~= 2 then
		manager.redPoint:setTip(string.format("%s_%s", RedPointConst.SKIN_TRIAL, slot1), 0)
	end
end

function slot0.GetSelectSkinTrialID(slot0, slot1)
	return getData("SkinTrial", string.format("select_%s_%s", ActivitySkinTrialCfg[slot1].activity_id, slot1))
end

function slot0.IsCompleted(slot0, slot1)
	if table.keyof(slot0.completedSkinTrialIDList_, slot1) then
		return true
	else
		return false
	end
end

function slot0.SaveStageID(slot0, slot1)
	slot0.stageIDToSkinTrialID_[ActivitySkinTrialCfg[slot1].stage_id] = slot1
end

function slot0.GetSkinTrialID(slot0, slot1)
	return slot0.stageIDToSkinTrialID_[slot1]
end

function slot0.SaveRoute(slot0, slot1)
	uv0 = deepClone(slot1)
end

function slot0.GetRoute(slot0)
	return uv0
end

function slot0.SaveSkinTrialMainScrollPos(slot0, slot1, slot2)
	if slot2 == "Global" then
		slot0.selectTrialPos = slot1
	elseif slot2 == "Back" then
		slot0.backTrialPos = slot1
	end
end

function slot0.GetSkinTrialMainScrollPos(slot0, slot1)
	if slot1 == "Global" then
		return slot0.selectTrialPos
	elseif slot1 == "Back" then
		return slot0.backTrialPos
	end
end

function slot0.GetSkinTrialStatus(slot0, slot1)
	return slot0.skinTrialStateList_[slot1] or 0
end

return slot0
