slot0 = class("PuzzleNewCheckPoint", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.statusConst_ = {
		RECEIVED = 2,
		FINISH = 1,
		UNFINISH = 0
	}

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
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if PuzzleNewData:GetCurCheckList(uv0.activityID_)[uv0.id_] == true and PuzzleNewData:GetSelecteCheckPoint(uv0.activityID_, uv0.id_) then
			PuzzleNewData:SetSelecteCheckPoint(uv0.activityID_, uv0.id_, false)
			AnimatorTools.PlayAnimatorWithCallback(uv0.animator_, "puzzleClueTemplate_close", function ()
				uv0:RefreshStatus()
			end)

			return
		end

		PuzzleNewAction.Operation(uv0.activityID_, PuzzleNewAction.OPERATION_TYPE.CHECK, function ()
			PuzzleNewData:SetSelecteCheckPoint(uv0.activityID_, uv0.id_, true)
			uv0:RefreshStatus()
			uv0.animator_:Play("puzzleClueTemplate", -1, 0)
			uv0.animator_:Update(0)

			if uv0.clickCallback_ then
				uv0.clickCallback_(uv0.id_)
			end
		end, uv0.id_)
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
	slot0.clickCallback_ = nil
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	if slot0.descRebuildTimer_ then
		slot0.descRebuildTimer_:Stop()

		slot0.descRebuildTimer_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityID_ = slot1
	slot0.id_ = slot2
	slot0.descText_.text = PuzzleNewClueCfg[slot0.id_].clue_desc

	slot0:RebuildDescLayout()
	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	slot2 = PuzzleNewData:GetCheckTipsList(slot0.activityID_)

	if PuzzleNewData:GetCurCheckList(slot0.activityID_)[slot0.id_] == true then
		if PuzzleNewData:GetSelecteCheckPoint(slot0.activityID_, slot0.id_) then
			slot0.statusController_:SetSelectedState("finish")
			slot0.animator_:Play("puzzleClueTemplate", -1, 99999)
		else
			slot0.statusController_:SetSelectedState("tips")
		end
	elseif slot2[slot0.id_] == true then
		slot0.statusController_:SetSelectedState("tips")
	else
		slot0.statusController_:SetSelectedState("none")
	end
end

function slot0.RegistClickCallback(slot0, slot1)
	slot0.clickCallback_ = slot1
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
