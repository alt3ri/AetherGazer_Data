slot0 = class("IdolTraineeChapterRewardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolChapterRewardPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.reciveBtn, nil, function ()
		if #uv0:GetCurCanReciveTaskIdList() > 0 then
			TaskAction:SubmitTaskList(slot0, nil, handler(uv0, uv0.RefreshRewardList))
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.chapterID = slot0.params_.chapterID

	slot0:InitChapterList()
	slot0:RefreshRewardList()
	slot0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, handler(slot0, slot0.RefreshRewardList))
end

function slot0.InitChapterList(slot0)
	if slot0.chapterID ~= slot0.chapterOldID then
		slot0:DestoryItemList()

		slot0.stageList = {}

		for slot5, slot6 in ipairs(IdolTraineeChapterCfg[slot0.chapterID].section_id_list) do
			slot0.stageList[slot6] = IdolTraineeRewardStageItem.New(Object.Instantiate(slot0.leveltitleGo_, slot0.contentTrs_))

			slot0.stageList[slot6]:SetData(slot6)
		end

		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrs_)
	end
end

function slot0.RefreshRewardList(slot0)
	if slot0.stageList then
		for slot4, slot5 in pairs(slot0.stageList) do
			slot5:RefreshUI()
		end
	end

	SetActive(slot0.allReciveGo_, #slot0:GetCurCanReciveTaskIdList() > 0)
end

function slot0.DestoryItemList(slot0)
	if slot0.stageList then
		for slot4, slot5 in pairs(slot0.stageList) do
			slot5:Dispose()
		end

		slot0.stageList = nil
	end
end

function slot0.GetCurCanReciveTaskIdList(slot0)
	slot1 = {}

	if slot0.stageList then
		for slot5, slot6 in pairs(slot0.stageList) do
			for slot11, slot12 in ipairs(slot6:GetCanReciveAwardList()) do
				table.insert(slot1, slot12)
			end
		end
	end

	return slot1
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	if slot0.stageList then
		for slot4, slot5 in pairs(slot0.stageList) do
			slot5:Dispose()
		end

		slot0.stageList = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
