slot0 = class("PuzzleNewCheckPoint", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.tipsController_ = ControllerUtil.GetController(slot0.transform_, "tips")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if not ActivityData:GetActivityIsOpen(uv0.activityID_) then
			ShowTips("TIME_OVER")

			return
		end

		if not uv0.unlock_ then
			return
		end

		if TangramPuzzleData:GetCurClueDic(uv0.activityID_)[uv0.id_] == true then
			if TangramPuzzleData:GetSelecteClue(uv0.activityID_, uv0.id_) == true then
				TangramPuzzleData:SetSelecteClue(uv0.activityID_, uv0.id_, false)
				uv0.tipsController_:SetSelectedState("off")
			else
				TangramPuzzleData:SetSelecteClue(uv0.activityID_, uv0.id_, true)
				uv0.tipsController_:SetSelectedState("on")
				uv0.animator_:Play("puzzleClueTemplate", -1, 0)
				uv0.animator_:Update(0)
			end
		else
			TangramPuzzleAction.Operation(uv0.activityID_, TangramPuzzleAction.OPERATION_TYPE.CLUE, {
				clueID = uv0.id_
			}, function ()
				uv0.statusController_:SetSelectedState("on")
				TangramPuzzleData:SetSelecteClue(uv0.activityID_, uv0.id_, true)
				uv0.tipsController_:SetSelectedState("on")
				uv0.animator_:Play("puzzleClueTemplate", -1, 0)
				uv0.animator_:Update(0)
			end)
		end
	end)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == false and slot0.descRebuildTimer_ then
		slot0.descRebuildTimer_:Stop()

		slot0.descRebuildTimer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.id_ = slot2
	slot0.regionType_ = PuzzleNewClueCfg[slot0.id_].area_type

	slot0:RebuildDescLayout()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.descText_.text = PuzzleNewClueCfg[slot0.id_].clue_desc

	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	slot0.unlock_ = TangramPuzzleTools.CheckRegionAllRightByType(slot0.activityID_, slot0.regionType_)

	SetActive(slot0.gameObject_, slot0.unlock_ == true)

	if slot0.unlock_ == true then
		if TangramPuzzleData:GetCurClueDic(slot0.activityID_)[slot0.id_] == true then
			slot0.statusController_:SetSelectedState("on")

			if TangramPuzzleData:GetSelecteClue(slot0.activityID_, slot0.id_) == true then
				slot0.tipsController_:SetSelectedState("on")
				slot0.animator_:Play("puzzleClueTemplate", -1, 99999)
			else
				slot0.tipsController_:SetSelectedState("off")
			end
		else
			slot0.statusController_:SetSelectedState("off")
			slot0.tipsController_:SetSelectedState("off")
		end
	end
end

function slot0.SetTipsController(slot0, slot1)
	if slot0.unlock_ == true then
		slot0.tipsController_:SetSelectedState(slot1 == true and "on" or "off")
		TangramPuzzleData:SetSelecteClue(slot0.activityID_, slot0.id_, slot1)
	end
end

function slot0.RebuildDescLayout(slot0)
	if slot0.descRebuildTimer_ then
		slot0.descRebuildTimer_:Stop()

		slot0.descRebuildTimer_ = nil
	end

	slot0.descRebuildTimer_ = FrameTimer.New(function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.descContentTrans_)

		if uv0.descRebuildTimer_ then
			uv0.descRebuildTimer_:Stop()

			uv0.descRebuildTimer_ = nil
		end
	end, 1, 1)

	slot0.descRebuildTimer_:Start()
end

return slot0
