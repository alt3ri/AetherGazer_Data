slot0 = class("ChapterSectionView", import("..SectionBaseView"))

function slot0.Init(slot0)
	slot0.hardLevelItems_ = {}
	slot0.currentAttachView_ = nil
	slot0.attachViewList_ = {}

	uv0.super.Init(slot0)
end

function slot0.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.hardLevelView_ = HardLevelSectionView.New(slot0.selectDifficultPanel_)
	slot0.skuldBtnController_ = ControllerUtil.GetController(slot0.skuldbtn_.transform, "isbreach")
	slot0.chapterPartBtnView_ = ChapterPartBtnView.New(slot0.chapterBranchGo_)
	slot0.stopMoveHandler_ = handler(slot0, slot0.StopMove)
end

function slot0.RefreshData(slot0)
	uv0.super.RefreshData(slot0)

	slot1 = slot0:GetAttachView()

	if slot0.currentAttachView_ then
		if slot0.currentAttachView_ ~= slot1 then
			slot0.currentAttachView_:OnExit()

			slot0.currentAttachView_ = slot1

			slot1:OnEnter()
		end
	elseif slot1 then
		slot0.currentAttachView_ = slot1

		slot1:OnEnter()
	end
end

function slot0.GetAttachView(slot0)
	if ChapterCfg[slot0.chapterID_].attach_prefab ~= "" then
		if slot0.chapterID_ == 10112 then
			if not slot0.attachViewList_[slot0.chapterID_] then
				slot0.attachViewList_[slot0.chapterID_] = SectionExtraAttachSkuldView.New(slot0, slot1.attach_prefab, slot0.setionAttachGo_)
			end

			return slot0.attachViewList_[slot0.chapterID_]
		else
			if not slot0.attachViewList_[slot0.chapterID_] then
				slot0.attachViewList_[slot0.chapterID_] = SectionExtraAttachTimelineView.New(slot0, slot1.attach_prefab, slot0.setionAttachGo_)
			end

			return slot0.attachViewList_[slot0.chapterID_]
		end
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshText()
	uv0.super.RefreshUI(slot0)
	slot0:RefreshHardLevelUI()
	slot0:RefreshCollectProgress()
	slot0:SwitchRewardShow()
	slot0:RefreshTogglePanel()
	slot0:SwitchBG()
	slot0:CheckSkuldBtn()
	slot0:RefreshPartBtn()
	slot0:HideActivityRedPoint()

	if slot0.currentAttachView_ then
		slot0.currentAttachView_:RefreshUI()
	end
end

function slot0.RefreshText(slot0)
	SetActive(slot0.titleGo_, true)

	slot3 = ChapterClientCfg[ChapterCfg[slot0.chapterID_].clientID]
	slot0.chapterIndexText_.text = slot3.desc
	slot0.chapterNameText_.text = slot3.name
end

function slot0.ShowPanel(slot0)
	SetActive(slot0.collectBtnGo_, true)
	SetActive(slot0.selectDifficultGo_, true)
end

function slot0.AddListeners(slot0)
	uv0.super.AddListeners(slot0)
	slot0:AddBtnListener(slot0.collectBtn_, nil, function ()
		if uv0:IsOpenSectionInfo() then
			JumpTools.Back()

			return
		end

		uv0.stopMove_ = true

		JumpTools.OpenPageByJump("chapterSectionReward", {
			chapterID = uv0.chapterID_,
			level = uv0.hardLevel_
		})
	end)
	slot0:AddBtnListener(slot0.skuldbtn_, nil, function ()
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			JumpTools.GoToSystem("/skuldTravelView")
		else
			slot0 = GameSetting.travel_skuld_unlock.value[1]
			slot2, slot3 = BattleStageTools.GetChapterSectionIndex(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot0)

			ShowTips(string.format(GetTips("MISSION_PROGRESS_UNLOCK_EX"), getChapterDifficulty(slot0), GetI18NText(slot2) .. "-" .. GetI18NText(slot3)))
		end
	end)
end

function slot0.RefreshCustomData(slot0)
	slot0.hardLevel_ = ChapterCfg[slot0.chapterID_].difficulty
	slot0.curStar_ = ChapterTools.GetChapterStarCnt(slot0.chapterID_)
	slot0.totalStar_ = ChapterTools.GetChapterTotalStarCnt(slot0.chapterID_)

	slot0.hardLevelView_:SetData(slot0.hardLevel_, slot0.curStar_ / slot0.totalStar_)
	BattleFieldAction.ChangePlotHardLevel(slot0.hardLevel_)
end

function slot0.SwitchRewardShow(slot0)
	if slot0:IsOpenRoute("chapterSectionReward") then
		SetActive(slot0.difficultPanel_, false)
		SetActive(slot0.collectBtnGo_, false)

		slot0.viewportRect_.localScale = Vector3.zero
	else
		SetActive(slot0.collectBtnGo_, true)

		slot0.viewportRect_.localScale = Vector3(1, 1, 1)
	end
end

function slot0.GetSectionItemClass(slot0)
	return ChapterSectionItem
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0:IsOpenRoute("chapterSectionInfo")
end

function slot0.GetCfgName(slot0)
	return BattleChapterStageCfg
end

function slot0.RefreshHardLevelUI(slot0)
	slot0:RefreshSelectDifficult()
end

function slot0.RefreshTogglePanel(slot0)
	if not getChapterNumList(ChapterCfg[slot0.params_.chapterID].sub_type)[2] then
		SetActive(slot0.selectDifficultGo_, false)

		return
	end

	if #ChapterCfg[getChapterNumList(slot1)[2][1]].section_id_list < 1 then
		SetActive(slot0.selectDifficultGo_, false)

		return
	end

	if slot0:IsOpenSectionInfo() or slot0:IsOpenRoute("chapterSectionReward") then
		SetActive(slot0.selectDifficultGo_, false)
	else
		SetActive(slot0.selectDifficultGo_, true)
	end
end

function slot0.RefreshCollectProgress(slot0)
	slot0.collectTotalText_.text = string.format("/%s", slot0.totalStar_)
	slot0.collectCurText_.text = slot0.curStar_
end

function slot0.RefreshSelectDifficult(slot0)
	slot0.collectProgress_.fillAmount = slot0.curStar_ / slot0.totalStar_
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.hardLevelView_:OnEnter()
	slot0.chapterPartBtnView_:OnEnter()
	slot0:SwitchRewardShow()
	manager.notify:RegistListener(CHAPTER_SCROLL_STOP, slot0.stopMoveHandler_)
	manager.redPoint:bindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0.chapterID_))
	manager.redPoint:bindUIandKey(slot0.skuldbtn_.transform, RedPointConst.TRAVEL_SKULD_BATTLE .. ActivityConst.ACTIVITY_1_6_SKULD_TRAVEL)
end

function slot0.CheckSkuldBtn(slot0)
	if not slot0:IsOpenSectionInfo() and not slot0:IsOpenRoute("chapterSectionReward") and ChapterCfg[slot0.params_.chapterID].sub_type == 13 then
		if SkuldTravelData:GetSkuldTravelIsOpen() then
			SetActive(slot0.skuldbtn_.gameObject, true)
		else
			SetActive(slot0.skuldbtn_.gameObject, false)
		end

		slot0.skuldBtnController_:SetSelectedState(SkuldTravelData:GetSkuldBtnIsBreach() and "true" or "false")
	else
		SetActive(slot0.skuldbtn_.gameObject, false)
	end
end

function slot0.RefreshPartBtn(slot0)
	if not slot0:IsOpenSectionInfo() and not slot0:IsOpenRoute("chapterSectionReward") then
		slot0.chapterPartBtnView_:RefreshUI(slot0.chapterID_)
	else
		SetActive(slot0.chapterBranchGo_, false)
	end
end

function slot0.OnUpdate(slot0)
	if slot0.chapterID_ ~= slot0.params_.chapterID then
		manager.redPoint:unbindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0.chapterID_))
		manager.redPoint:bindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0.params_.chapterID))
	end

	uv0.super.OnUpdate(slot0)
end

function slot0.OnExit(slot0)
	if slot0.currentAttachView_ then
		slot0.currentAttachView_:OnExit()

		slot0.currentAttachView_ = nil
	end

	uv0.super.OnExit(slot0)
	slot0.hardLevelView_:OnExit()
	slot0.chapterPartBtnView_:OnExit()
	manager.redPoint:unbindUIandKey(slot0.collectBtnGo_.transform, string.format("%s_%s", RedPointConst.COMBAT_PLOT_CHAPTER_STAR, slot0.chapterID_))
	OperationRecorder.RecordStayView("STAY_VIEW_SECTION", slot0:GetStayTime(), slot0.chapterID_)
	manager.notify:RemoveListener(CHAPTER_SCROLL_STOP, slot0.stopMoveHandler_)
	manager.redPoint:unbindUIandKey(slot0.skuldbtn_.transform, TravelSkuldBattleBtnKey)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attachViewList_) do
		slot5:Dispose()
	end

	slot0.attachViewList_ = nil

	slot0.hardLevelView_:Dispose()

	slot0.hardLevelView_ = nil

	slot0.chapterPartBtnView_:Dispose()

	slot0.chapterPartBtnView_ = nil
	slot0.stopMoveHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.HideActivityRedPoint(slot0)
	slot3 = nil

	if ((ChapterCfg[slot0.chapterID_].unlock_activity_id == 0 or slot2.unlock_activity_id) and slot2.activity_id) ~= 0 and not RedPointData:GetIsRedPointOpen(RedPointConst.ACTIVITY_RANGE + slot3) and ActivityTools.GetActivityStatus(slot3) == 1 then
		RedPointAction.HandleRedPoint(RedPointConst.ACTIVITY_RANGE + slot3)
		manager.redPoint:setTip(string.format("%s%s", ActivityTools.GetRedPointKey(slot3), slot3), 0)
	end
end

function slot0.StopMove(slot0)
	slot0.stopMove_ = true
end

return slot0
