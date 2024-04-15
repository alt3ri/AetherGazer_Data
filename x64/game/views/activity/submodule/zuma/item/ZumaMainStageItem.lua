slot0 = class("ZumaMainStageItem", ReduxView)
slot1 = {
	progressState = {
		star1 = "state2",
		name = "Progress",
		star2 = "state3",
		noShow = "state0",
		star0 = "state1",
		star3 = "state4"
	},
	selectState = {
		onSelect = "state1",
		name = "sel",
		unSelect = "state0"
	},
	stateState = {
		unComplete = "state2",
		name = "state",
		lock = "state0",
		normal = "state1"
	},
	rankState = {
		state2 = "state2",
		name = "rank",
		state1 = "state1",
		noShow = "no"
	},
	lineState = {
		normalColor = Color(0.611764705882353, 0.7372549019607844, 0.788235294117647, 1),
		lockColor = Color(0.7137254901960784, 0.7764705882352941, 0.8, 0.4)
	}
}
slot2 = {
	UnComplete = 3,
	UnLock = 1,
	Complete = 2
}

function slot0.SetRedState(slot0, slot1)
	if slot1 then
		manager.redPoint:bindUIandKey(slot0.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0.levelCfg.activity_id))
	else
		manager.redPoint:unbindUIandKey(slot0.stageitemBtn_.transform, string.format("%s_%s", RedPointConst.ZUMA_OPEN, slot0.levelCfg.activity_id))
	end
end

function slot0.OnCtor(slot0, slot1, slot2, slot3, slot4)
	slot0.index = slot4
	slot0.gameObject_ = slot1
	slot0.levelCfg = slot3
	slot0.levelID = slot3.id
	slot0.difficultType = slot3.difficult

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.progressController = slot0.controllerexcollection_:GetController(uv0.progressState.name)
	slot0.selectController = slot0.controllerexcollection_:GetController(uv0.selectState.name)
	slot0.stateController = slot0.controllerexcollection_:GetController(uv0.stateState.name)
	slot0.rankController = slot0.controllerexcollection_:GetController(uv0.rankState.name)

	slot0:AddBtnListener(slot0.stageitemBtn_, nil, function ()
		manager.notify:CallUpdateFunc(ZUMA_SELECT_CHAPTER, uv0.index)
	end)

	slot0.nameText_.text = slot0.levelCfg.name
end

function slot0.RefreshUi(slot0)
	slot1 = slot0.levelCfg
	slot0.rankNumTxt_.text = ZumaData:GetZumaStageScore(slot0.levelID) or 0

	slot0:UpdateStageState()
end

function slot0.GetLevelCfg(slot0)
	return slot0.levelCfg
end

function slot0.UpdateSelectState(slot0, slot1)
	slot0.selectController:SetSelectedState(slot1 and uv0.selectState.onSelect or uv0.selectState.unSelect)
end

function slot0.UpdateStageState(slot0)
	if ActivityData:GetActivityData(ActivityZumaLevelCfg[slot0.levelID].activity_id) and slot2:IsActivitying() then
		if ZumaData:GetZumaStageScore(slot0.levelID) then
			slot0:CheckStageState(uv0.Complete)
		elseif ZumaData:GetZumaBeforeIsFinish(slot0.levelID) then
			slot0:CheckStageState(uv0.UnComplete)
		else
			slot0:CheckStageState(uv0.UnLock)
		end
	else
		slot0:CheckStageState(uv0.UnLock)
	end
end

function slot0.CheckStageState(slot0, slot1)
	slot0.stageState = slot1

	slot0:ChangeLockState()
	slot0:ChangeProgressState()
	slot0:ChangeRankState()
end

function slot0.ChangeLockState(slot0)
	if slot0.stageState == uv0.UnLock then
		slot0.stateController:SetSelectedState(uv1.stateState.lock)
	elseif slot0.stageState == uv0.Complete then
		slot0.stateController:SetSelectedState(uv1.stateState.normal)
	elseif slot0.stageState == uv0.UnComplete then
		slot0.stateController:SetSelectedState(uv1.stateState.unComplete)
	end
end

function slot0.ChangeProgressState(slot0)
	if slot0.stageState == uv0.UnLock or slot0.difficultType == ZumaConst.ZUMA_DIFFICULT.NIGHT then
		slot0.progressController:SetSelectedState(uv1.progressState.noShow)
	elseif slot0.stageState == uv0.Complete then
		if slot0:GetFinishConditionNums() == 1 then
			slot0.progressController:SetSelectedState(uv1.progressState.star1)
		elseif slot1 == 2 then
			slot0.progressController:SetSelectedState(uv1.progressState.star2)
		elseif slot1 == 3 then
			slot0.progressController:SetSelectedState(uv1.progressState.star3)
		elseif slot1 == 0 then
			slot0.progressController:SetSelectedState(uv1.progressState.star0)
		end
	elseif slot0.stageState == uv0.UnComplete then
		slot0.progressController:SetSelectedState(uv1.progressState.star0)
	end
end

function slot0.ChangeRankState(slot0)
	if slot0.difficultType ~= ZumaConst.ZUMA_DIFFICULT.NIGHT then
		slot0.rankController:SetSelectedState(uv0.rankState.noShow)

		return
	end

	if slot0.stageState == uv1.UnLock then
		slot0.rankController:SetSelectedState(uv0.rankState.noShow)
	elseif slot0.stageState == uv1.Complete then
		slot0.rankController:SetSelectedState(uv0.rankState.state2)
	elseif slot0.stageState == uv1.UnComplete then
		slot0.rankController:SetSelectedState(uv0.rankState.state1)
	end
end

function slot0.GetFinishConditionNums(slot0)
	for slot7, slot8 in pairs(slot0.levelCfg.activity_point_reward or {}) do
		if ActivityPointRewardCfg[slot8].need <= ZumaData:GetZumaStageScore(slot0.levelID) then
			slot3 = 0 + 1
		end
	end

	return slot3
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
