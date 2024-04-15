slot0 = class("ActivityReforgeWaveView", ReduxView)
slot1 = {
	INFO = "info",
	TASK = "task"
}

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeWaveUI"
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

	slot0.wavePanelController_ = slot0.controllerEx_:GetController("wavePanel")
	slot0.teamInfoController_ = slot0.controllerEx_:GetController("teamInfo")
	slot0.levelUpController_ = slot0.controllerEx_:GetController("levelUp")
	slot0.waveList_ = LuaList.New(handler(slot0, slot0.IndexWaveItem), slot0.waveListGo_, ActivityReforgeWaveItem)
	slot4 = ActivityReforgeWaveTaskItem
	slot0.waveTaskList_ = LuaList.New(handler(slot0, slot0.IndexWaveTaskItem), slot0.waveTaskListGo_, slot4)
	slot0.curWaveInfoToggle_ = uv0.INFO
	slot0.waveItemClickHandle_ = handler(slot0, slot0.OnWaveItemClick)
	slot0.curWaveIndex_ = 1
	slot0.curWaveTeamData_ = nil
	slot0.skillItemList_ = {}

	for slot4 = 1, 4 do
		slot0.skillItemList_[slot4] = ActivityReforgeSkillSmallItem.New(slot0["skillItemGo" .. slot4 .. "_"])
	end

	slot0.heroHeadItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4] = ActivityReforgeHeroHeadItem.New(slot0["heroHeadGo" .. slot4 .. "_"])
	end
end

function slot0.OnWaveItemClick(slot0, slot1)
	if slot0.curWaveIndex_ == slot1 then
		return
	end

	slot0.curWaveIndex_ = slot1
	slot0.curWaveID_ = slot0.levelCfg_.wave_list[slot0.curWaveIndex_]
	slot0.curWaveCfg_ = ActivityReforgeWaveCfg[slot0.curWaveID_]
	slot0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(slot0.curWaveID_)

	slot0:RefreshWaveList()
	slot0:RefreshWaveInfoPanel()
	slot0.wavePanelAni_:Play("WaveUI_item")
end

function slot0.IndexWaveItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.levelCfg_.wave_list[slot1], slot0.curWaveIndex_)
	slot2:SetClickHandle(slot0.waveItemClickHandle_)
end

function slot0.IndexWaveTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.curWaveCfg_.task_list[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if ActivityReforgeData:CheckLevelCanStart() then
			slot0, slot1 = ActivityReforgeData:GetCurUsingSkillList()

			if slot1 then
				ShowMessageBox({
					content = GetTips("ACTIVITY_REFORGE_SKILL_EMPTY_BATTLE"),
					OkCallback = function ()
						slot1 = uv0.levelCfg_.wave_list[1]

						BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[uv0.levelCfg_.wave_list[1]].map_id, {
							activityID = uv0.activityID_,
							chapterActivityID = uv0.chapterActivityID_,
							levelID = uv0.levelID_,
							waveID = slot1,
							skillList = uv1,
							battleParams = ActivityReforgeData:GetFrontWaveBattleParams(slot1)
						}))
					end
				})
			else
				slot3 = uv0.levelCfg_.wave_list[1]

				BattleController.GetInstance():LaunchBattle(BattleStageFactory.Produce(BattleConst.STAGE_TYPE_NEW.ACTIVITY_REFORGE, ActivityReforgeWaveCfg[uv0.levelCfg_.wave_list[1]].map_id, {
					activityID = uv0.activityID_,
					chapterActivityID = uv0.chapterActivityID_,
					levelID = uv0.levelID_,
					waveID = slot3,
					skillList = slot0,
					battleParams = ActivityReforgeData:GetFrontWaveBattleParams(slot3)
				}))
			end

			return
		end

		ShowTips("ACTIVITY_REFORGE_UNFINISH_ALL_WAVE_TEAM")
	end)
	slot0:AddBtnListener(slot0.teamBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityReforgeTeamView", {
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_,
			curWaveID = uv0.curWaveID_
		})
	end)
	slot0:AddBtnListener(slot0.toggleBtn_, nil, function ()
		if uv0.curWaveInfoToggle_ == uv1.INFO then
			uv0.curWaveInfoToggle_ = uv1.TASK
		elseif uv0.curWaveInfoToggle_ == uv1.TASK then
			uv0.curWaveInfoToggle_ = uv1.INFO
		end

		uv0:RefreshWaveInfoPanelStatus()
	end)
	slot0:AddBtnListener(slot0.resetTeamLevelBtn_, nil, function ()
		if uv0.curWaveTeamData_ and uv0.curWaveTeamData_.level > 1 then
			ActivityReforgeAction.ResetTeamLevel(uv0.chapterActivityID_, uv0.levelID_, uv0.curWaveTeamData_.teamID)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_NO_LEVELUP")
		end
	end)
	slot0:AddBtnListener(slot0.teamLevelUpBtn_, nil, function ()
		if uv0.curWaveTeamData_ and uv0.curWaveTeamData_.level < #ActivityReforgeTeamCfg[uv0.curWaveTeamData_.teamID].team_info then
			ActivityReforgeAction.TeamLevelUp(uv0.chapterActivityID_, uv0.levelID_, uv0.curWaveTeamData_.teamID, function ()
				uv0.teamInfoAni_:Play("LevelUp")
			end)
		else
			ShowTips("ACTIVITY_REFORGE_TEAM_LEVEL_MAX")
		end
	end)
	slot0:AddBtnListener(slot0.passiveSkillBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewStatus = 2,
			viewType = 2,
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID

	if slot0.levelID_ ~= slot0.params_.levelID then
		slot0.levelID_ = slot0.params_.levelID
		slot0.curWaveIndex_ = 1
	end

	slot0.levelCfg_ = ActivityReforgeLevelCfg[slot0.levelID_]
	slot0.curWaveID_ = slot0.levelCfg_.wave_list[slot0.curWaveIndex_]
	slot0.curWaveCfg_ = ActivityReforgeWaveCfg[slot0.curWaveID_]
	slot0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(slot0.curWaveID_)

	slot0:RefreshWaveList()
	slot0:RefreshWaveInfoPanel()
	slot0:RefreshWaveInfoPanelStatus()

	for slot4 = 1, 4 do
		slot0.skillItemList_[slot4]:SetData(slot0.activityID_, slot0.chapterActivityID_, slot0.levelID_, slot4)
	end

	SetActive(slot0.passiveNumText_.gameObject, true)

	slot0.passiveNumText_.text = "+" .. #ActivityReforgeData:GetCurUsingPassiveSkillList()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR,
		CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_REFORGE_GAMEHELPKEY")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.RefreshWaveList(slot0)
	slot0.waveList_:StartScroll(#slot0.levelCfg_.wave_list)
end

function slot0.RefreshWaveInfoPanel(slot0)
	slot0.waveName_.text = string.format(GetTips("ACTIVITY_REFORGE_CUR_WAVE"), slot0.curWaveIndex_)

	if slot0.curWaveTeamData_ then
		for slot7, slot8 in pairs(ActivityReforgeTeamCfg[slot0.curWaveTeamData_.teamID].team_info[slot0.curWaveTeamData_.level]) do
			table.insert({}, slot8)
		end

		for slot7 = 1, 3 do
			slot0.heroHeadItemList_[slot7]:SetData(slot1.team_info[slot0.curWaveTeamData_.level][slot7])
			slot0.heroHeadItemList_[slot7]:SetClickCallBack(function (slot0)
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					hid = slot0,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					tempHeroList = uv0
				})
			end)
		end

		slot0.teamInfoController_:SetSelectedState("normal")

		slot0.levelText_.text = slot0.curWaveTeamData_.level

		if slot1.combo_skill_id > 0 then
			SetActive(slot0.comboSkillGo_, true)

			slot5 = ComboSkillCfg[slot1.combo_skill_id]
			slot0.comboName_.text = GetI18NText(HeroSkillCfg[slot5.skill_id].name)
			slot0.comboLevelText_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot5.maxLevel)
			slot0.comboIcon_.sprite = getSpriteViaConfig("ComboSkill", slot5.skill_id)
		else
			SetActive(slot0.comboSkillGo_, false)
		end

		slot0.teamLevelUpCost_.text = slot1.cost[slot0.curWaveTeamData_.level]
		slot4 = #slot1.team_info

		if slot0.curWaveTeamData_.level == 1 then
			slot0.levelUpController_:SetSelectedState("noDown")
		elseif slot4 <= slot0.curWaveTeamData_.level then
			slot0.levelUpController_:SetSelectedState("noUp")
		else
			slot0.levelUpController_:SetSelectedState("mid")
		end
	else
		slot0.teamInfoController_:SetSelectedState("empty")

		slot0.levelText_.text = 1
	end

	slot0.waveTaskList_:StartScroll(#slot0.curWaveCfg_.task_list)

	slot0.waveDesText_.text = slot0.curWaveCfg_.description
end

function slot0.RefreshWaveInfoPanelStatus(slot0)
	if slot0.curWaveInfoToggle_ == uv0.INFO then
		slot0.wavePanelController_:SetSelectedState("info")
	elseif slot0.curWaveInfoToggle_ == uv0.TASK then
		slot0.wavePanelController_:SetSelectedState("task")
	end
end

function slot0.OnActivityReforgeCurLevelUpdate(slot0)
	slot0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(slot0.curWaveID_)

	slot0:RefreshWaveList()
	slot0:RefreshWaveInfoPanel()
	slot0:RefreshWaveInfoPanelStatus()
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_ACTIVITY_REFORGE
	})
end

function slot0.Dispose(slot0)
	if slot0.waveList_ then
		slot0.waveList_:Dispose()

		slot0.waveList_ = nil
	end

	if slot0.waveTaskList_ then
		slot0.waveTaskList_:Dispose()

		slot0.waveTaskList_ = nil
	end

	for slot4 = 1, 4 do
		slot0.skillItemList_[slot4]:Dispose()

		slot0.skillItemList_[slot4] = nil
	end

	slot0.skillItemList_ = nil

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4]:Dispose()

		slot0.heroHeadItemList_[slot4] = nil
	end

	slot0.heroHeadItemList_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
