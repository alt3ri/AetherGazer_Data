slot0 = class("NewBattleFailedView", ReduxView)
slot1 = import("game.tools.BattleInstance")

function slot0.UIName(slot0)
	return "Widget/System/BattleResult/BattleFailed/BattleResultLoseUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.styleController = slot0.controllerEx_:GetController("default0")
	slot0.lvController = slot0.lvController_:GetController("red")
	slot0.btnController = slot0.btnController_:GetController("btn")
	slot0.typeImgs = {}
	slot0.criList = LuaList.New(handler(slot0, slot0.indexTypeItem), slot0.criListObj_, BattleFailedCriItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnBattleCount_, nil, function ()
		uv0:GoToBattleStatistics()
	end)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		uv0:OnClickBack()
	end)
	slot0:AddBtnListener(slot0.restartBtn_, nil, function ()
		uv0:OnClickRestart()
	end)
	slot0:AddBtnListener(slot0.btnMask_, nil, function ()
		uv0:OnClickBack()
	end)
	SetActive(slot0.btnMask_.gameObject, true)
	slot0.btnController:SetSelectedState("nobtn")
end

function slot0.GoToBattleStatistics(slot0)
	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = slot0.params_.stageData,
		battleTime = slot0:GetBattleTime()
	})
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2((LuaExchangeHelper.GetBattleStatisticsData() or LuaExchangeHelper.GetBattleStatisticsDataBeforeBattleEnd()).dataForLua.battleTime)
end

function slot0.OnEnter(slot0)
	slot0.stageData_ = slot0.params_.stageData
	slot0.stageID_ = slot0.stageData_:GetStageId()
	slot0.stageType_ = slot0.stageData_:GetType()
	slot0.recommendAttriList = {}

	uv0.hideBattlePanel()
	slot0:RebuildUI()
	slot0:RecordThreeStar()
end

function slot0.OnExit(slot0)
end

function slot0.RebuildUI(slot0)
	slot0:ChangeStyle()
	slot0:RefreshRecommendType()
	slot0:RefreshRecommendLevel()

	slot0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		slot0:GetBattleTime() or "00"
	})
	slot0.titleTxt_.text = BattleStageTools.GetStageName(slot0.stageType_, slot0.stageID_)
end

function slot0.ChangeStyle(slot0)
	if slot0.params_.isHalfWay_ then
		slot0.styleController:SetSelectedState("end")
	else
		slot0.styleController:SetSelectedState("lose")
	end
end

function slot0.OnClickBack(slot0)
	slot0:QuitUI()
end

function slot0.QuitUI(slot0)
	if #PlayerData:GetlevelUpInfos() > 0 then
		PlayerAction.LevelUpFinish()
		slot0:Go("levelUp", {
			levelUpInfoList = slot1,
			callback = function ()
				FrameTimer.New(function ()
					uv0.QuitBattle(uv1.params_.stageData, true, true)
				end, 1, 1):Start()
			end
		})
	else
		uv0.QuitBattle(slot0.params_.stageData, true, true)
	end
end

function slot0.OnClickRestart(slot0)
	LuaExchangeHelper.GameOver(2)
	BattleController.GetInstance():LaunchBattle(slot0.params_.stageData)
end

function slot0.RecordThreeStar(slot0)
	slot1 = slot0.params_.starMissionData
	slot2 = {}

	for slot6 = 1, 3 do
		if slot1 ~= nil and slot1[slot6] ~= nil then
			slot7 = ThreeStarConditionCfg[slot1[slot6].id]
			slot8 = nil

			if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot0.stageType_ then
				slot8 = BattleStageData:GetStageData()[slot0.stageID_]
			elseif BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BOSS_CHALLENGE == slot0.stageType_ then
				slot8 = BattleBossChallengeNormalData:GetStarList(slot0.stageID_)
			end

			slot9 = false

			if slot8 and slot8.stars and slot8.stars[slot6] == 1 then
				slot9 = true
			end

			slot10 = false

			if slot7.id == 15 or slot7.id == 16 then
				slot10 = slot1[slot6].isComplete
			end

			slot2[slot6] = (slot10 or slot9) and 1 or 0
		end
	end

	uv0.RecordThreeStar(slot0.stageType_, slot0.stageID_, slot2)
end

function slot0.RefreshRecommendType(slot0)
	if BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_) then
		if #(slot1.recommend_attribute_list or {}) > 0 then
			SetActive(slot0.recommendTypeObj_, true)

			slot0.recommendAttriList = slot2

			slot0.criList:StartScroll(#slot2)
		else
			SetActive(slot0.recommendTypeObj_, false)
		end
	else
		SetActive(slot0.recommendTypeObj_, false)
	end
end

function slot0.RefreshRecommendLevel(slot0)
	slot2, slot3 = slot0.params_.stageData:GetHeroTeam()

	for slot7 = 1, 3 do
		if slot2[slot7] and slot2[slot7] ~= 0 then
			slot1 = math.max(slot0.params_.stageData:GetHeroDataByPos(slot7).level, 0)
		end
	end

	if slot0:GetRecommendLevel() and slot4 ~= 0 then
		SetActive(slot0.lvController_.gameObject, true)

		slot0.recommendNumTxt_.text = slot4

		if slot4 <= slot1 then
			slot0.lvController:SetSelectedState("state0")
		else
			slot0.lvController:SetSelectedState("state1")
		end
	else
		SetActive(slot0.lvController_.gameObject, false)
	end
end

function slot0.indexTypeItem(slot0, slot1, slot2)
	slot2:OnRenderItem(HeroTools.GetSkillAttributeIcon(slot0.recommendAttriList[slot1]))
end

function slot0.GetRecommendLevel(slot0)
	return BattleStageTools.GetStageCfg(slot0.stageType_, slot0.stageID_).recommend_level
end

function slot0.Dispose(slot0)
	slot0.criList:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
