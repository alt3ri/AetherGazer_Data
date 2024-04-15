slot0 = class("ActivityReforgeBattleInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeBattleInfoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "status"
	slot0.controller_ = slot0.controllerEx_:GetController(slot4)
	slot0.heroHeadItemList_ = {}

	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4] = ActivityReforgeHeroHeadItem.New(slot0["heroHeadGo" .. slot4 .. "_"])
	end
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.chapterActivityID_ = slot0.params_.chapterActivityID
	slot0.levelID_ = slot0.params_.levelID
	slot0.waveID_ = slot0.params_.waveID
	slot0.curWaveTeamData_ = ActivityReforgeData:GetWaveTeamInfo(slot0.waveID_)

	for slot5 = 1, 3 do
		slot6 = ActivityReforgeTeamCfg[slot0.curWaveTeamData_.teamID].team_info[slot0.curWaveTeamData_.level][slot5]

		slot0.heroHeadItemList_[slot5]:SetData(slot6)

		slot9 = nil

		if (ActivityReforgeData:GetFinishWaveHeroInfo(slot0.waveID_, HeroStandardSystemCfg[slot6].hero_id).leftHp <= 0 and 0 or slot8.leftHp / slot8.maxHp) <= 0.01 then
			SetActive(slot0["dieGo" .. slot5 .. "_"], true)

			slot0["hpImage" .. slot5 .. "_"].fillAmount = 0
		else
			SetActive(slot0["dieGo" .. slot5 .. "_"], false)

			slot0["hpImage" .. slot5 .. "_"].fillAmount = slot9
		end
	end

	slot0.waveNameText_.text = ActivityReforgeWaveCfg[slot0.waveID_].wave_name
	slot3 = manager.time:DescCTime(ActivityReforgeData:GetWaveFinishData(slot0.waveID_).useSeconds, "%M%S")
	slot5 = math.floor(slot3 / 100) % 100

	if slot3 % 100 < 10 then
		slot4 = "0" .. slot4
	end

	if slot5 < 10 then
		slot5 = "0" .. slot5
	end

	slot0.timeText_.text = slot5 .. ":" .. slot4
	slot0.pointText_.text = slot2.losePoint
	slot0.useGoldText_.text = slot2.useGold
	slot9 = ActivityReforgeData:GetGoldMaxNum(slot0.activityID_)

	for slot14, slot15 in pairs(ActivityReforgeLevelCfg[slot0.levelID_].wave_list) do
		slot7 = 0 + ActivityReforgeWaveCfg[slot15].point

		if slot15 ~= slot0.waveID_ then
			slot16 = ActivityReforgeData:GetWaveFinishData(slot15)
			slot8 = 0 + slot16.losePoint
			slot10 = 0 + slot16.useGold
		end
	end

	slot0.pointImage1_.fillAmount = (slot8 + slot2.losePoint) / slot7
	slot0.pointImage2_.fillAmount = slot8 / slot7
	slot0.useGoldImage1_.fillAmount = (slot10 + slot2.useGold) / slot9
	slot0.useGoldImage2_.fillAmount = slot10 / slot9

	if table.indexof(slot6, slot0.waveID_) == #slot6 then
		slot0.isLast_ = true

		slot0.controller_:SetSelectedState("last")
	else
		slot0.isLast_ = false

		slot0.controller_:SetSelectedState("normal")
	end
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.reBattleBtn_, nil, function ()
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
	slot0:AddBtnListener(slot0.continueBtn_, nil, function ()
		ActivityReforgeAction.LevelFinish(uv0.chapterActivityID_, uv0.levelID_, function ()
			ActivityReforgeAction.RequestAllPlayerLevelData(uv0.chapterActivityID_, uv0.levelID_, function ()
				JumpTools.OpenPageByJump("/activityReforgeBattleResultView", {
					activityID = uv0.activityID_,
					chapterActivityID = uv0.chapterActivityID_,
					levelID = uv0.levelID_,
					IsBattleBack = uv0.params_.IsBattleBack,
					stageData = uv0.params_.stageData
				})
			end)
		end)
	end)
end

function slot0.Dispose(slot0)
	for slot4 = 1, 3 do
		slot0.heroHeadItemList_[slot4]:Dispose()

		slot0.heroHeadItemList_[slot4] = nil
	end

	slot0.heroHeadItemList_ = nil

	slot0.super.Dispose(slot0)
end

return slot0
