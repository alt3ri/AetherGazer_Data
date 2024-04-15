slot0 = class("ZumaMainStageInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.difficultType = slot2
	slot0.difficultCfgList = ZumaData:GetZumaCfgData()[slot2]

	slot0:InitUI()
end

function slot0.GetDifficultCfgList(slot0)
	return slot0.difficultCfgList
end

function slot0.SetRedState(slot0, slot1)
	for slot5, slot6 in pairs(slot0.stageList) do
		slot6:SetRedState(slot1)
	end
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	if slot0.scrollviewGo_ then
		slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollviewGo_)
	end

	slot0.stagePosList = {}
	slot0.stageList = {}

	for slot4 = 1, #slot0.difficultCfgList do
		slot5, slot6 = slot0:CreateStageItem(slot4)
		slot0.stageList[slot4] = ZumaMainStageItem.New(slot5, slot6, slot0.difficultCfgList[slot4], slot4)
	end
end

function slot0.CreateStageItem(slot0, slot1)
	slot2 = slot0[string.format("stage%sTrs_", slot1)]
	slot0.stagePosList[slot1] = slot2.anchoredPosition.x

	return slot2:GetChild(0).gameObject, nil
end

function slot0.DefalutSelect(slot0, slot1)
	slot2 = nil

	for slot6, slot7 in pairs(slot0.stageList) do
		if slot1 == slot7.levelID then
			slot2 = slot6

			break
		end
	end

	if slot2 and slot0.difficultType == ZumaConst.ZUMA_DIFFICULT.HARD then
		slot0.contentTrs_.anchoredPosition = Vector2(-slot0.stagePosList[slot2], 0)
	end
end

function slot0.UpdateMoveView(slot0, slot1)
	if slot1 then
		slot0:BeginMoveTween(Vector2(-slot0.stagePosList[slot1], 0))
	else
		slot0:BeginMoveTween()
	end

	if slot0.scrollviewSr_ then
		if slot1 then
			slot0.scrollviewSr_.enabled = false
		else
			slot0.scrollviewSr_.enabled = true
		end
	end
end

function slot0.BeginMoveTween(slot0, slot1)
	slot0:RemoveTween()

	slot2 = slot0.contentTrs_
	slot3 = false

	if slot0.scrollviewTrs_ then
		slot3 = true
		slot2 = slot0.scrollviewTrs_
	end

	if not slot1 then
		slot1 = Vector2.zero
	elseif slot3 then
		slot1.x = slot0.scrollviewTrs_.rect.width / 2 + slot1.x - slot0.contentTrs_.anchoredPosition.x
	end

	slot0.tween_ = LeanTween.value(slot2.gameObject, slot2.anchoredPosition, slot1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		uv0.anchoredPosition = Vector2(slot0, 0)
	end)):setOnComplete(System.Action(function ()
		uv0:RemoveTween()
	end)):setEase(LeanTweenType.easeOutSine)
end

function slot0.RemoveTween(slot0)
	if slot0.tween_ then
		slot0.tween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tween_.id)

		slot0.tween_ = nil
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return true
end

function slot0.RefreshStageUi(slot0, slot1)
	if slot1 then
		slot0.stageList[slot1]:RefreshUi()
	else
		for slot5, slot6 in pairs(slot0.stageList) do
			slot6:RefreshUi()
		end
	end
end

function slot0.GetTragetItem(slot0, slot1)
	return slot0.stageList[slot1]
end

function slot0.GetAllScore(slot0)
	for slot5, slot6 in pairs(slot0.stageList) do
		slot1 = 0 + (ZumaData:GetZumaStageScore(slot6.levelID) or 0)
	end

	return slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveTween()

	for slot4, slot5 in pairs(slot0.stageList) do
		slot5:Dispose()
	end

	if slot0.scrollMoveView_ then
		slot0.scrollMoveView_:Dispose()

		slot0.scrollMoveView_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
