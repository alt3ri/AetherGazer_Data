slot0 = class("SectionSelectRaceDescriptionView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationGodPopUPUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList = {}
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnEnter(slot0)
	slot0.raceID_ = slot0.params_.raceID
	slot0.sameCamp_ = slot0.params_.sameCamp
	slot0.raceIDList_ = slot0:GetRaceIDList()

	for slot4, slot5 in ipairs(slot0.raceIDList_) do
		if not slot0.itemList[slot4] then
			slot6 = Object.Instantiate(slot0.godlistnewGo_, slot0.contentTrs_)

			SetActive(slot6, true)

			slot0.itemList[slot4] = slot0:GetItemClass().New(slot6)
		end

		slot0.itemList[slot4]:SetData(slot0.raceIDList_[slot4], slot0.raceID_ == slot0.raceIDList_[slot4], slot0.sameCamp_)
	end

	slot0.contentTrs_.localPosition = Vector3(slot0.contentTrs_.localPosition.x, 0, 0)

	TimeTools.StartAfterSeconds(0.1, function ()
		LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.contentTrs_)
	end, {})
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.raceIDList_[slot1], slot0.raceID_ == slot0.raceIDList_[slot1], slot0.sameCamp_)
end

function slot0.GetRaceIDList(slot0)
	slot1 = clone(RaceEffectCfg.all)

	table.sort(slot1, function (slot0, slot1)
		if slot0 == uv0.raceID_ then
			return true
		end

		if slot1 == uv0.raceID_ then
			return false
		end

		return slot0 < slot1
	end)

	return slot1
end

function slot0.GetItemClass(slot0)
	return SectionSelectRaceDescriptionItem
end

return slot0
