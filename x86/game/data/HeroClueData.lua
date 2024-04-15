slot0 = singletonClass("HeroClueData")

function slot0.Init(slot0)
	slot0.inited_ = {}
	slot0.unlockClueDataDic_ = {}
	slot0.newClueDic_ = {}
	slot0.selectedClue_ = {}
end

function slot0.IsInited(slot0, slot1)
	return slot0.inited_[slot1] == true
end

function slot0.InitData(slot0, slot1)
	slot0.inited_[slot1.activity_id] = true
	slot0.unlockClueDataDic_ = {}
	slot0.newClueDic_ = {}

	for slot6, slot7 in ipairs(slot1.clue_list) do
		slot8 = slot7.id
		slot0.unlockClueDataDic_[slot8] = {
			id = slot8,
			num = slot7.num
		}

		slot0:UpdateClueLevel(slot8)
	end

	slot0.selectedClue_[slot2] = {}
end

function slot0.GetUnlockClueDataDic(slot0)
	return slot0.unlockClueDataDic_ or {}
end

function slot0.SetUnlockClue(slot0, slot1, slot2)
	if not slot0.unlockClueDataDic_[slot1] then
		slot0.unlockClueDataDic_[slot1] = {
			id = slot1,
			num = slot2
		}
		slot0.newClueDic_[slot1] = true
	else
		slot0.unlockClueDataDic_[slot1].num = slot0.unlockClueDataDic_[slot1].num + slot2
	end

	slot0:UpdateClueLevel(slot1)
end

function slot0.UpdateClueLevel(slot0, slot1)
	slot3 = 0

	for slot10 = #HeroClueCfg[slot1].level, 1, -1 do
		if slot5[slot10] <= slot0.unlockClueDataDic_[slot1].num then
			slot3 = slot10

			break
		end
	end

	slot0.unlockClueDataDic_[slot1].level = slot3
end

function slot0.GetNewClueDic(slot0)
	return slot0.newClueDic_
end

function slot0.SetNewClueDic(slot0, slot1, slot2)
	slot0.newClueDic_[slot1] = slot2
end

function slot0.GetSelectedClue(slot0, slot1, slot2)
	return slot0.selectedClue_[slot1][slot2]
end

function slot0.SetSelectedClue(slot0, slot1, slot2)
	if manager.redPoint:getTipBoolean(string.format("%s_%s_%s", RedPointConst.HERO_CLUE_NEW, slot1, slot2)) == false then
		return
	end

	slot0.selectedClue_[slot1][slot2] = true

	slot0:SetNewClueDic(slot2, false)
	HeroClueAction.UpdateNewClueRedPoint(slot1)
end

return slot0
