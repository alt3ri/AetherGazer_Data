slot0 = class("IdolTraineeRewardStageItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.SetData(slot0, slot1)
	slot0.stageID = slot1

	if slot0.stageID then
		slot0.nameText_.text = IdolTraineePveBattleCfg[slot0.stageID].name

		slot0:InitRewardList()
	end
end

function slot0.InitRewardList(slot0)
	if not slot0.awardList then
		slot0.awardList = {}

		if IdolTraineePveBattleCfg[slot0.stageID].taskIDList and slot1 ~= "" then
			for slot5, slot6 in ipairs(slot1) do
				slot0.awardList[slot6] = IdolTraineeRewardListItem.New(Object.Instantiate(slot0.levelitemGo_, slot0.contentTrs_))

				slot0.awardList[slot6]:SetData(slot6)
			end
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	end
end

function slot0.RefreshUI(slot0)
	if slot0.awardList then
		for slot4, slot5 in pairs(slot0.awardList) do
			slot5:SetData(slot4)
		end
	end
end

function slot0.GetCanReciveAwardList(slot0)
	slot1 = {}

	if slot0.awardList then
		for slot5, slot6 in pairs(slot0.awardList) do
			if slot6.stateController_:GetSelectedState() == "complete" then
				table.insert(slot1, slot5)
			end
		end
	end

	return slot1
end

function slot0.Dispose(slot0)
	if slot0.awardList then
		for slot4, slot5 in pairs(slot0.awardList) do
			slot5:Dispose()
		end

		slot0.awardList = nil
	end

	Object.DestroyImmediate(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
