slot0 = class("ChapterPlot19MainView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationVerMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.updateAllHandler_ = handler(slot0, slot0.UpdateAll)
	slot0.OnCloseDayPanelHandler_ = handler(slot0, slot0.OnCloseDayPanel)
	slot0.mapView_ = ChapterPlot19MapView.New(slot0.mapGo_)
	slot0.dayView_ = ChapterPlotDayView.New(slot0, slot0.dayGo_)
	slot0.watchController_ = slot0.watchControllerEx_:GetController("watchState")
	slot0.hideScanController_ = slot0.watchControllerEx_:GetController("hideScan")
	slot0.showScanEffectController_ = slot0.watchControllerEx_:GetController("showScanEffect")
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.notify:RegistListener(CHAPTER_DAY_CHANGED, slot0.updateAllHandler_)
	manager.notify:RegistListener(CHAPTER_CLOSE_DAY_LIST, slot0.OnCloseDayPanelHandler_)
	slot0:UpdateAll(true)
	slot0:OnCloseDayPanel()
	slot0.mapView_:OnEnter()
	slot0.dayView_:OnEnter()
	slot0:AddArrowTimer()
	manager.redPoint:bindUIandKey(slot0.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
end

function slot0.OnEnterOver(slot0)
	slot0:CheckNeedAutoBattle()
end

function slot0.OnUpdate(slot0)
	slot0.mapView_:OnUpdate()
	slot0.dayView_:OnUpdate()
	slot0:RefreshCollectClue()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.collectTf_, RedPointConst.COMBAT_PLOT_CHAPTER_19_STAR)
	manager.windowBar:HideBar()
	slot0:StopScan()
	slot0:StopArrowTimer()
	slot0.mapView_:OnExit()
	slot0.dayView_:OnExit()
	manager.notify:RemoveListener(CHAPTER_DAY_CHANGED, slot0.updateAllHandler_)
	manager.notify:RemoveListener(CHAPTER_CLOSE_DAY_LIST, slot0.OnCloseDayPanelHandler_)

	slot0.lastAudioID_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.collectBtn_, nil, function ()
		if uv0.mapView_:GetBackCnt() > 0 then
			uv0:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterPlot19Reward", {
			level = 1,
			chapterID = uv0.chapterID_
		})
	end)
	slot0:AddBtnListener(slot0.clueBtn_, nil, function ()
		if uv0.mapView_:GetBackCnt() > 0 then
			uv0:Back()

			return
		end

		JumpTools.OpenPageByJump("chapterClue", {
			chapterID = uv0.chapterID_
		})
	end)
	slot0:AddBtnListener(slot0.scanBtn_, nil, function ()
		if uv0.mapView_:GetBackCnt() > 0 then
			uv0:Back()

			return
		end

		manager.ui:UIEventEnabled(false)
		uv0:ScanAnimator(function ()
			manager.ui:UIEventEnabled(true)
			BattleStageAction.ScanClueLocation(uv0.mapID_, function (slot0)
				uv0:RefreshMap()
				uv0:RefreshScanBtn()
				ShowTips(string.format(GetTips("SCAN_MEMORY_FRAGMENT"), #slot0.location_id_list))
			end)
		end)
	end)
	slot0:AddBtnListener(slot0.watchBtn_, nil, function ()
		if uv0.mapView_:GetBackCnt() > 0 then
			uv0:Back()

			return
		end

		if ChapterTools.IsNeedOperateFirstDayWatch(uv0.chapterID_, uv0.selectDay_) then
			BattleStageAction.OperateChapterDay(uv0.chapterID_, ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id[uv0.chapterID_][1]].day, function ()
				BattleFieldData:SaveChapterMapDay(uv1.chapterID_, ChapterMapCfg[uv0[2]].day)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				uv1:OnCloseDayPanel()
			end)

			return
		end

		if ChapterTools.IsNeedOperateLastDayWatch(uv0.chapterID_, uv0.selectDay_) then
			BattleStageAction.OperateChapterDay(uv0.chapterID_, ChapterMapCfg[slot0[#slot0]].day, function ()
				BattleFieldData:SaveChapterMapDay(uv0.chapterID_, uv1)
				manager.notify:Invoke(CHAPTER_DAY_CHANGED)
				uv0:OnCloseDayPanel()
			end)

			return
		end

		slot2 = 1

		if #ChapterMapCfg.get_id_list_by_chapter_id_day[uv0.chapterID_][uv0.selectDay_] > 1 and table.keyof(slot1, uv0.mapID_) == 1 then
			slot2 = 2
		end

		BattleFieldData:SaveChapterMapID(uv0.chapterID_, uv0.selectDay_, ChapterMapCfg.get_id_list_by_chapter_id_day[uv0.chapterID_][uv0.selectDay_][slot2])
		manager.notify:Invoke(CHAPTER_DAY_CHANGED)
		uv0:OnCloseDayPanel()
	end)
	slot0:AddBtnListener(slot0.storyCollectBtn_, nil, function ()
		if ChapterTools.IsReadFirstEvent(uv0.chapterID_) then
			JumpTools.OpenPageByJump("chapterPlot19StoryCollect", {
				chapterID = uv0.chapterID_
			})
		else
			ShowTips("COLLECTION_STORY_AND_READ")
		end
	end)
end

function slot0.UpdateAll(slot0, slot1)
	slot0:RefreshData()
	slot0:ResetMapPosition()
	slot0:RefreshUI(slot1)

	if not slot1 then
		slot0:CheckNeedAutoBattle()
	end
end

function slot0.OnCloseDayPanel(slot0)
	slot0:RefreshSwitchBtn()
end

function slot0.RefreshData(slot0)
	slot0.chapterClientID_ = ChapterConst.CHAPTER_CLIENT_19
	slot0.chapterID_ = ChapterClientCfg[slot0.chapterClientID_].chapter_list[1]
	slot0.selectDay_ = BattleFieldData:GetChapterMapDay(slot0.chapterID_)
	slot0.mapID_ = BattleFieldData:GetChapterMapID(slot0.chapterID_, slot0.selectDay_)
end

function slot0.CheckNeedAutoBattle(slot0)
	if table.keyof(GameSetting.chapter19_auto_battle_day_list.value, slot0.selectDay_) and ChapterLocationCfg[ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot0.selectDay_][1]].location_list[1]].stage_list[1] and not ChapterTools.IsClearStage(slot4) and not BattleStageData:GetAutoBattleFlag(slot4) then
		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_VITALITY) < BattleChapterStageCfg[slot4].cost then
			return
		end

		BattleFieldData:SetChapterLocationID(slot0.chapterID_, slot3)
		BattleStageData:SaveAutoBattleFlag(slot4)
		ChapterTools.DoReadyBattle(BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT, slot4)
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0:RefreshCollectStar()
	slot0:RefreshMap(slot1)
	slot0:RefreshDay()
	slot0:RefreshScanBtn()
	slot0:RefreshCollectClue()
	slot0:RefreshAudio()
end

function slot0.ResetMapPosition(slot0)
	slot0.mapView_:ResetMapPosition()
end

function slot0.RefreshCollectStar(slot0)
	slot1 = ChapterTools.GetChapterStarCnt(slot0.chapterID_)
	slot2 = ChapterTools.GetChapterTotalStarCnt(slot0.chapterID_)
	slot0.numText_.text = slot1
	slot0.totalText_.text = string.format("/%s", slot2)
	slot0.collectImage_.fillAmount = slot1 / slot2
end

function slot0.RefreshMap(slot0, slot1)
	slot0.mapView_:SetMapID(slot0.chapterID_, slot0.mapID_, slot1)
end

function slot0.RefreshDay(slot0)
	slot0.dayView_:SetData(slot0.selectDay_, slot0.chapterID_)
end

function slot0.RefreshScanBtn(slot0)
	slot0.hideScanController_:SetSelectedState(tostring(not ChapterTools.HasClueLocation(slot0.mapID_)))
	slot0.showScanEffectController_:SetSelectedState(tostring(ChapterTools.HasUnscanClue(slot0.mapID_)))
end

function slot0.RefreshSwitchBtn(slot0)
	if slot0.selectDay_ == ChapterMapCfg[ChapterMapCfg.get_id_list_by_chapter_id[slot0.chapterID_][1]].day and not ChapterTools.IsNeedOperateFirstDayWatch(slot0.chapterID_, slot0.selectDay_) or ChapterTools.IsLastDay(slot0.chapterID_, slot0.selectDay_) then
		if slot0.isHideWatch_ ~= true then
			slot0.watchAnimator_:Play("View_out", 0, 1)

			slot0.isHideWatch_ = true
		end
	else
		if slot0.isHideWatch_ then
			slot0.watchAnimator_:Play("dayList_enter", 0, 0)

			slot0.isHideWatch_ = false
		end

		if ChapterTools.IsNeedOperateFirstDayWatch(slot0.chapterID_, slot0.selectDay_) then
			slot0.watchController_:SetSelectedState("lock")
		elseif ChapterTools.IsNeedOperateLastDayWatch(slot0.chapterID_, slot0.selectDay_) then
			slot0.watchController_:SetSelectedState("exitSpecialSpace")
		elseif table.keyof(ChapterMapCfg.get_id_list_by_chapter_id_day[slot0.chapterID_][slot0.selectDay_], slot0.mapID_) == 1 then
			slot0.watchController_:SetSelectedState("innerSpace")

			slot0.watchText_.text = GetTips("SURFACE_SPACE")
		else
			slot0.watchController_:SetSelectedState("outwardSpace")

			if slot0.selectDay_ == 4 then
				slot0.watchText_.text = "???"
			else
				slot0.watchText_.text = GetTips("INNER_SPACE")
			end
		end
	end

	if ChapterTools.NeedShowSwitchMapGuild(slot0.chapterID_, slot0.selectDay_, slot0.mapID_) then
		slot0.watchGuildAnimator_:Play("map_unlock2", 0, 0)
	else
		slot0.watchGuildAnimator_:Play("empty", 0, 0)
	end
end

function slot0.RefreshCollectClue(slot0)
	slot1, slot2 = ChapterTools.GetChapterClueCnt(slot0.chapterID_)
	slot0.clueCntText_.text = string.format("%s/%s", slot1, slot2)
end

function slot0.ScanAnimator(slot0, slot1)
	slot0:StopScan()
	slot0.scanAnimator_:Play("scan", 0, 0)

	slot0.scanTimer_ = FrameTimer.New(function ()
		if uv0.scanAnimator_:GetCurrentAnimatorStateInfo(0).normalizedTime >= 1 then
			uv1()
			uv0:StopScan()
		end
	end, 1, -1)

	slot0.scanTimer_:Start()
end

function slot0.StopScan(slot0)
	if slot0.scanTimer_ then
		slot0.scanTimer_:Stop()

		slot0.scanTimer_ = nil
	end
end

function slot0.AddArrowTimer(slot0)
	slot0.arrowTimer_ = FrameTimer.New(function ()
		uv0:ShowArrow()
	end, 1, -1)

	slot0.arrowTimer_:Start()
end

function slot0.StopArrowTimer(slot0)
	if slot0.arrowTimer_ then
		slot0.arrowTimer_:Stop()

		slot0.arrowTimer_ = nil
	end
end

function slot0.ShowArrow(slot0)
	if ChapterTools.GetUnclearMainStageLocationID(slot0.mapID_) then
		slot3 = ChapterLocationCfg[slot1]
		slot5 = slot0.viewPortTf_.rect.width / 2
		slot7 = slot5 - 200
		slot8 = slot0.viewPortTf_.rect.height / 2 - 200

		if slot5 < math.abs((Vector3(slot3.position[1], slot3.position[2], 0) + slot0.contentTf_.localPosition).x) or slot6 < math.abs(slot4.y) then
			SetActive(slot0.arrowGo_, true)

			slot9 = MathTools.GetAngle(Vector3(0, 0, 0), slot4) + 180
			slot0.arrowTf_.localEulerAngles = Vector3(0, 0, slot9)
			slot9 = (slot9 + 180) % 360 - 180
			slot11 = slot7 * math.tan(slot9 / 180 * math.pi)

			if slot9 > -90 and slot9 < 90 then
				slot11 = -slot7 * math.tan(slot9 / 180 * math.pi)
			end

			if slot8 < math.abs(slot11) then
				slot10 = slot9 > -180 and slot9 < 0 and slot8 / math.tan(slot9 / 180 * math.pi) or -slot8 / math.tan(slot9 / 180 * math.pi)
			end

			slot0.arrowTf_.localPosition = Vector3(slot10, slot11, 0)
		else
			SetActive(slot0.arrowGo_, false)
		end
	else
		SetActive(slot0.arrowGo_, false)
	end
end

function slot0.RefreshAudio(slot0)
	slot1 = ChapterTools.GetChapterAudioIDList(slot0.mapID_)

	if slot0.lastAudioID_ == slot1[#slot1] then
		return
	end

	for slot6, slot7 in ipairs(slot1) do
		manager.audio:PlayUIAudio(ChapterAudioCfg[slot7].bgm_id)
	end

	slot0.bgmNameText_.text = ChapterAudioCfg[slot2].name
	slot0.lastAudioID_ = slot2
end

function slot0.Dispose(slot0)
	slot0.updateAllHandler_ = nil
	slot0.OnCloseDayPanelHandler_ = nil

	slot0.mapView_:Dispose()

	slot0.mapView_ = nil

	slot0.dayView_:Dispose()

	slot0.dayView_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
