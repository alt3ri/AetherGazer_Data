slot0 = class("ActivityReforgeTrimView", ReduxView)
slot1 = {
	INFO = "info",
	TASK = "task"
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeTrimUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.passiveSkillList_ = {}

	for slot4, slot5 in pairs(ActivityReforgeSkillCfg.all) do
		if ActivityReforgeSkillCfg[slot5].type == 0 then
			table.insert(slot0.passiveSkillList_, slot5)
		end
	end

	slot0.wavePanelController_ = slot0.controllerEx_:GetController("wavePanel")
	slot4 = ActivityReforgeWaveTaskItem
	slot0.waveTaskList_ = LuaList.New(handler(slot0, slot0.IndexWaveTaskItem), slot0.waveTaskListGo_, slot4)
	slot0.curWaveInfoToggle_ = uv0.INFO
	slot0.curWaveTeamData_ = nil
	slot0.bigSkillItemList_ = {}

	for slot4 = 1, 4 do
		slot0.bigSkillItemList_[slot4] = ActivityReforgeTrimSkillBigItem.New(slot0["bigSkillItemGo" .. slot4 .. "_"])
	end

	slot0.smallSkillItemList_ = {}

	for slot4 = 1, 4 do
		slot0.smallSkillItemList_[slot4] = ActivityReforgeTrimSkillSmallItem.New(slot0["smallSkillItemGo" .. slot4 .. "_"])
	end

	slot0.heroHeadItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4] = ActivityReforgeHeroHeadItem.New(slot0["heroHeadGo" .. slot4 .. "_"])
	end
end

function slot0.IndexWaveTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.curWaveCfg_.task_list[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.passiveSkillBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_
		})
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		if uv0.params_.IsBattleBack then
			BattleInstance.QuitBattle(uv0.params_.stageData)
		else
			JumpTools.Back()
		end
	end)
	slot0:AddBtnListener(slot0.reChallengeBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("ACTIVITY_REFORGE_REBATTLE_CHECK"),
			OkCallback = function ()
				slot0 = ActivityReforgeData:GetCurLastWinWaveID()

				BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[slot0].map_id, {
					activityID = uv0.activityID_,
					chapterActivityID = uv0.chapterActivityID_,
					levelID = uv0.levelID_,
					waveID = slot0,
					skillList = ActivityReforgeData:GetPassWaveUsedSkillList(slot0),
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(slot0)
				}))
			end
		})
	end)
	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		slot0, slot1 = ActivityReforgeData:GetCurUsingSkillList()

		if slot1 then
			ShowMessageBox({
				content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
				OkCallback = function ()
					slot0 = ActivityReforgeData:GetCurNextWaveID()

					BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[slot0].map_id, {
						activityID = uv0.activityID_,
						chapterActivityID = uv0.chapterActivityID_,
						levelID = uv0.levelID_,
						waveID = uv0.curWaveID_,
						skillList = ActivityReforgeData:GetCurUsingSkillList(),
						battleParams = ActivityReforgeData:GetFrontWaveBattleParams(slot0)
					}))
				end
			})
		else
			slot2 = ActivityReforgeData:GetCurNextWaveID()

			BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[slot2].map_id, {
				activityID = uv0.activityID_,
				chapterActivityID = uv0.chapterActivityID_,
				levelID = uv0.levelID_,
				waveID = uv0.curWaveID_,
				skillList = ActivityReforgeData:GetCurUsingSkillList(),
				battleParams = ActivityReforgeData:GetFrontWaveBattleParams(slot2)
			}))
		end
	end)
	slot0:AddBtnListener(slot0.toggleBtn_, nil, function ()
		if uv0.curWaveInfoToggle_ == uv1.INFO then
			uv0.curWaveInfoToggle_ = uv1.TASK
		elseif uv0.curWaveInfoToggle_ == uv1.TASK then
			uv0.curWaveInfoToggle_ = uv1.INFO
		end

		uv0:RefreshWaveInfoPanelStatus()
	end)
	slot0:AddBtnListener(slot0.battleInfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.levelID_ = slot0.params_.levelID
	slot0.levelCfg_ = ActivityReforgeLevelCfg[slot0.levelID_]
	slot0.curWaveID_ = ActivityReforgeData:GetCurNextWaveID()
	slot0.curWaveCfg_ = ActivityReforgeWaveCfg[slot0.curWaveID_]
	slot0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(slot0.curWaveID_)
	slot0.curUsingPassiveSkillList_ = ActivityReforgeData:GetCurUsingPassiveSkillList()

	slot0:RefreshWaveInfoPanel()
	slot0:RefreshWaveInfoPanelStatus()
	slot0:RefreshSkillInfoPanel()
	slot0:CheckIsPopBattleInfoView()
end

function slot0.OnTop(slot0)
	if not slot0.params_.IsBattleBack then
		manager.windowBar:SwitchBar({
			BACK_BAR,
			HOME_BAR
		})
	end
end

function slot0.OnExit(slot0)
	if not slot0.params_.IsBattleBack then
		manager.windowBar:HideBar()
	end
end

function slot0.RefreshWaveInfoPanel(slot0)
	slot1 = ActivityReforgeTeamCfg[slot0.curWaveTeamData_.teamID]

	for slot5 = 1, 3 do
		slot0.heroHeadItemList_[slot5]:SetData(slot1.team_info[slot0.curWaveTeamData_.level][slot5])
	end

	slot0.levelText_.text = slot0.curWaveTeamData_.level

	if slot1.combo_skill_id > 0 then
		SetActive(slot0.comboSkillGo_, true)

		slot3 = ComboSkillCfg[slot1.combo_skill_id]
		slot0.comboName_.text = GetI18NText(HeroSkillCfg[slot3.skill_id].name)
		slot0.comboSkillLevelText_.text = slot3.maxLevel
		slot0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", slot3.skill_id)
	else
		SetActive(slot0.comboSkillGo_, false)
	end

	slot0.waveTaskList_:StartScroll(#slot0.curWaveCfg_.task_list)

	slot0.waveDesText_.text = slot0.curWaveCfg_.description
	slot0.waveIndexText_.text = "休整阶段-波次" .. table.indexof(slot0.levelCfg_.wave_list, slot0.curWaveID_)
end

function slot0.RefreshWaveInfoPanelStatus(slot0)
	if slot0.curWaveInfoToggle_ == uv0.INFO then
		slot0.wavePanelController_:SetSelectedState("info")
	elseif slot0.curWaveInfoToggle_ == uv0.TASK then
		slot0.wavePanelController_:SetSelectedState("task")
	end
end

function slot0.RefreshSkillInfoPanel(slot0)
	for slot5 = 1, 4 do
		slot0.bigSkillItemList_[slot5]:SetData(slot0.activityID_, slot0.chapterActivityID_, slot0.levelID_, slot5)

		if ActivityReforgeData:GetInitiativeSkillUseNum(slot5) == 1 then
			slot1 = 0 + 1
		end
	end

	for slot5 = 1, 4 do
		if slot0.curUsingPassiveSkillList_[slot5] then
			slot0.smallSkillItemList_[slot5]:SetData(slot0.activityID_, slot0.chapterActivityID_, slot0.levelID_, slot0.curUsingPassiveSkillList_[slot5])
		else
			slot0.smallSkillItemList_[slot5]:SetData(slot0.activityID_, slot0.chapterActivityID_, slot0.levelID_, 0)
		end
	end

	slot0.initiativeUseText_.text = slot1 .. "/" .. 4
	slot0.passiveUseText_.text = #slot0.curUsingPassiveSkillList_ .. "/" .. #slot0.passiveSkillList_

	if #slot0.curUsingPassiveSkillList_ - 4 > 0 then
		slot0.overFlowText_.text = "+" .. slot2
	else
		slot0.overFlowText_.text = "+" .. 0
	end
end

function slot0.CheckIsPopBattleInfoView(slot0)
	if slot0.params_.IsBattleBack and ActivityReforgeData:GetCachePopBattleInfoView() then
		ActivityReforgeData:SetCachePopBattleInfoView(false)
		JumpTools.OpenPageByJump("activityReforgeBattleInfoView", {
			activityID = slot0.activityID_,
			chapterActivityID = slot0.chapterActivityID_,
			levelID = slot0.levelID_,
			waveID = ActivityReforgeData:GetCurLastWinWaveID()
		})
	end
end

function slot0.Dispose(slot0)
	if slot0.waveTaskList_ then
		slot0.waveTaskList_:Dispose()

		slot0.waveTaskList_ = nil
	end

	for slot4 = 1, 4 do
		slot0.bigSkillItemList_[slot4]:Dispose()

		slot0.bigSkillItemList_[slot4] = nil
	end

	slot0.bigSkillItemList_ = nil

	for slot4 = 1, 4 do
		slot0.smallSkillItemList_[slot4]:Dispose()

		slot0.smallSkillItemList_[slot4] = nil
	end

	slot0.smallSkillItemList_ = nil

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4]:Dispose()

		slot0.heroHeadItemList_[slot4] = nil
	end

	slot0.heroHeadItemList_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
