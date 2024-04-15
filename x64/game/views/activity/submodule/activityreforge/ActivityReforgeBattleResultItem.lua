slot0 = class("ActivityReforgeBattleResultItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.barGoList_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	slot0.type_ = slot1
	slot0.barMinNum_ = slot2
	slot0.levelID_ = slot3
	slot0.curData_ = slot4
	slot0.allPlayerData_ = deepClone(slot5)
	slot0.rangeLength_ = slot6
	slot0.barNum_ = slot0.barMinNum_
	slot0.maxPalyerNum_ = 0

	for slot10, slot11 in ipairs(slot0.allPlayerData_) do
		if slot0.maxPalyerNum_ < slot11 then
			slot0.maxPalyerNum_ = slot11
		end
	end

	for slot10, slot11 in ipairs(slot0.allPlayerData_) do
		if 100 * slot11 / slot0.maxPalyerNum_ <= 1 then
			slot0.allPlayerData_[slot10] = 0
		end
	end

	for slot10 = #slot0.allPlayerData_, 1, -1 do
		if slot0.barMinNum_ < slot10 then
			if slot0.allPlayerData_[slot10] > 0 then
				slot0.barNum_ = slot10

				break
			end
		else
			break
		end
	end

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	if slot0.type_ == 1 then
		slot1 = manager.time:DescCTime(slot0.curData_, "%M%S")
		slot3 = math.floor(slot1 / 100) % 100

		if slot1 % 100 < 10 then
			slot2 = "0" .. slot2
		end

		if slot3 < 10 then
			slot3 = "0" .. slot3
		end

		slot0.numText_.text = slot3 .. ":" .. slot2
	else
		slot0.numText_.text = slot0.curData_
	end

	slot1 = slot0.barPanelTrans_.rect.width / slot0.barNum_

	for slot5 = 1, slot0.barNum_ do
		if slot0.barGoList_[slot5] == nil then
			slot0.barGoList_[slot5] = Object.Instantiate(slot0.barGo_, slot0.barPanelTrans_)
		end

		slot0.barGoList_[slot5].transform.sizeDelta = Vector2.New(slot1, slot0.allPlayerData_[slot5] / slot0.maxPalyerNum_ * slot0.barPanelTrans_.rect.height)
		slot0.barGoList_[slot5].transform.anchoredPosition = Vector3.New((slot5 - 1) * slot0.barGoList_[slot5].transform.rect.width, slot0.barGoList_[slot5].transform.anchoredPosition.y, 0)
	end

	for slot5, slot6 in pairs(slot0.barGoList_) do
		if slot5 <= slot0.barNum_ then
			SetActive(slot0.barGoList_[slot5], true)
		else
			SetActive(slot0.barGoList_[slot5], false)
		end
	end

	if slot0.curData_ / (slot0.barNum_ * slot0.rangeLength_) > 1 then
		slot2 = 1
	end

	slot0.lineTrans_.transform.anchoredPosition = Vector3.New(slot2 * slot0.barPanelTrans_.rect.width, 0, 0)
	slot5 = 0

	if slot0.type_ == 1 then
		if ActivityReforgeData:GetBestFinishLevelServerData(slot0.levelID_).minUseSeconds / (slot0.barNum_ * slot0.rangeLength_) > 1 then
			slot6 = 1
		end

		slot5 = slot6 * slot0.barPanelTrans_.rect.width
	elseif slot0.type_ == 2 then
		if slot4.minLosePoint / (slot0.barNum_ * slot0.rangeLength_) > 1 then
			slot6 = 1
		end

		slot5 = slot6 * slot0.barPanelTrans_.rect.width
	elseif slot0.type_ == 3 then
		if slot4.minUseGold / (slot0.barNum_ * slot0.rangeLength_) > 1 then
			slot6 = 1
		end

		slot5 = slot6 * slot0.barPanelTrans_.rect.width
	end

	slot0.bestLineTrans_.transform.anchoredPosition = Vector3.New(slot5, 0, 0)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.barGoList_) do
		Object.Destroy(slot5)

		slot0.barGoList_[slot4] = nil
	end

	slot0.barGoList_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
