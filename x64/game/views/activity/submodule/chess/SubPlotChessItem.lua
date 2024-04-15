slot0 = class("ActivityChessItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.chapterID_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.OnEnter(slot0)
	slot0.ACTIVITY_CONST = WarchessLevelCfg[slot0.chapterID_].type
	slot0.reprintActivityID_ = ActivityTools.GetReprintActivityID(slot0.ACTIVITY_CONST)

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0:IsPrestageLock() then
			slot1 = WarchessLevelCfg[uv0.chapterID_]

			ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(GetTips("CHESS_NAME_" .. slot1.tag)), WarchessLevelCfg[slot1.unlock_level].name_level))

			return
		end

		if uv0:IsLock() then
			if WarchessLevelCfg[uv0.chapterID_].unlock_condition[1] == 1 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ActivityStoryChapterCfg[slot0[2][1]].name), BattleActivityStoryStageCfg[slot0[2][2]].name))
			elseif slot0[1] == 2 then
				ShowTips(string.format(GetTips("UNLOCK_CONDITION_ACTIVITY_TIPS"), GetI18NText(ChapterCfg[slot0[2][1]].subhead), BattleActivityStoryStageCfg[slot0[2][2]].name))
			end

			return
		end

		ChessTools.EnterChessMap(uv0.chapterID_, true)
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = ChessTools.GetChapterProgress(slot0.chapterID_)
	slot0.imageProgress_.fillAmount = slot1 / 100
	slot0.textProress_.text = slot1
	slot0.textName_.text = WarchessLevelCfg[slot0.chapterID_].name_level

	slot0:RefreshState()
end

function slot0.IsPrestageLock(slot0)
	if WarchessLevelCfg[slot0.chapterID_].unlock_level ~= 0 and ChessTools.GetChapterProgress(slot3) < slot2.success_progress then
		return true
	end

	return false
end

function slot0.IsLock(slot0)
	if WarchessLevelCfg[slot0.chapterID_].type == slot0.ACTIVITY_CONST and WarchessLevelCfg[slot1].unlock_condition ~= "" then
		if slot2[1] == 1 then
			if not BattleStageData:GetStageData()[slot2[2][2]] or slot3.clear_times < 1 then
				return true
			end
		elseif slot2[1] == 2 then
			return not ChapterTools.IsClearStage(slot2[2][2])
		end
	end

	return false
end

function slot0.GetOpenTimestamp(slot0)
	return WarChessData:GetChessTime(slot0.chapterID_) or 0
end

function slot0.RefreshState(slot0)
	slot2 = WarChessData:GetCurrentChapter(WarchessLevelCfg[slot0.chapterID_].type)

	if slot0:IsPrestageLock() or slot0:IsLock() then
		slot0.controller_:SetSelectedState("open")

		return
	end

	if slot2 == slot0.chapterID_ then
		slot0.controller_:SetSelectedState("challenge")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
