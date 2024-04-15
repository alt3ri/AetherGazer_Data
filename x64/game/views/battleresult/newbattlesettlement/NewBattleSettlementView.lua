slot0 = class("NewBattleSettlementView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/BattleResult/Common/BattleResultWinUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.hasSnapshot_ = GetBattleResultSnapShot()

	slot0:InitUI()

	slot0.btnController = slot0.btnController_:GetController("btn")
	slot0.adaptComp = slot0:FindCom("AdaptImage", nil, slot0.commonMaskBg_.transform)

	slot0:AddListener()
end

function slot0.OnEnter(slot0)
	slot0.stageData = slot0.params_.stageData
	slot0.stageId = slot0.stageData:GetStageId()
	slot0.stageType = slot0.stageData:GetType()
	slot0.isMultiple = slot0.params_.multiple ~= nil

	BattleInstance.hideBattlePanel()
	slot0:RenderMaskBg()
	slot0:CaculateReward()
	slot0:RenderView()
	slot0:PostRenderView()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveExpTween()

	for slot4 = 1, 3 do
		slot0.heroModule[slot4]:Dispose()
	end

	if slot0.missionView then
		slot0.missionView:Dispose()
	end

	slot0.spriteRef = nil

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroModule = {
		BattleSettlementHeroHeadModule.New(slot0.heroHead1Obj_),
		BattleSettlementHeroHeadModule.New(slot0.heroHead2Obj_),
		BattleSettlementHeroHeadModule.New(slot0.heroHead3Obj_)
	}
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		uv0:CloseFunc()
	end)
	slot0:AddBtnListener(slot0.statisticsBtn_, nil, function ()
		uv0:GoToBattleStatistics()
	end)
	slot0:OnAddListner()
end

function slot0.OnAddListner(slot0)
	slot0:AddBtnListener(slot0.nextStageBtn_, nil, function ()
		uv0:OnceMoreFunc()
	end)
end

function slot0.RenderView(slot0)
	slot0:RenderTitleView()
	slot0:RefreshMyExpS()
	slot0:RefreshHeroS()
	slot0:RenderCommonUI()
	slot0:RefreshBattleTime()
	slot0:RefreshBottomBtn()
	slot0:ShowContent()
end

function slot0.RenderTitleView(slot0)
	slot1, slot2 = BattleStageTools.GetChapterSectionIndex(slot0.stageType, slot0.stageId)
	slot3 = GetI18NText(BattleStageTools.GetStageName(slot0.stageType, slot0.stageId)) or ""
	slot4 = ""

	if (slot1 ~= "" and string.format("%s-%s ", GetI18NText(slot1), GetI18NText(slot2)) .. slot3 or "" .. slot3) and slot4 ~= "" then
		SetActive(slot0.titleObj_, true)

		slot0.titleTxt_.text = slot4
	else
		SetActive(slot0.titleObj_, false)
	end
end

function slot0.RenderCommonUI(slot0)
	slot1 = true

	SetActive(slot0.statisticsBtn_.gameObject, BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)
end

function slot0.RefreshBattleTime(slot0)
	SetActive(slot0.battleTimeText_.gameObject, BattleStageTools.GetStageCfg(slot0.stageType, slot0.stageId).tag ~= BattleConst.BATTLE_TAG.STORY)

	if slot1.tag == BattleConst.BATTLE_TAG.STORY then
		return
	end

	slot0.battleTimeText_.text = table.concat({
		GetTips("BATTLE_TOTAL_TIME"),
		": ",
		slot0:GetBattleTime() or "00"
	})
end

function slot0.RefreshHeroS(slot0)
	slot1, slot2 = slot0.stageData:GetHeroTeam()
	slot3 = slot0.stageData:GetSystemHeroTeam()

	if slot1[2] == 0 then
		table.remove(slot1, 2)
		table.remove(slot2, 2)
		table.insert(slot1, 0)
		table.insert(slot2, 0)
	end

	slot4 = slot0.params_.battleResult.heroDataCollect

	for slot8 = 1, 3 do
		if not slot1[slot8] or slot1[slot8] == 0 then
			slot0.heroModule[slot8]:SetHeroData(nil)
			slot0.heroModule[slot8]:ShowCaptain(false)
		else
			slot0.heroModule[slot8]:ShowCaptain(slot8 == 1)

			slot9 = slot0.stageData:GetHeroDataByPos(slot8)

			slot0.heroModule[slot8]:SetHeroData({
				id = slot9.id,
				using_skin = slot9.using_skin,
				star = slot9.star or 0
			})

			if slot4[slot8] and slot0:NeedAddExp() then
				slot0.heroModule[slot8]:PlayLevelUpTween(slot4[slot8].oldLv, slot4[slot8].newLv, slot4[slot8].oldPersent, slot4[slot8].newPersent, 2)
			else
				slot0.heroModule[slot8]:ShowLevel(slot9.level, 1)
			end
		end
	end
end

function slot0.RefreshMyExpS(slot0)
	slot1 = slot0.stageData:GetAddUserExp() * slot0.stageData:GetMultiple()
	slot2 = slot0.stageData:GetActivityID()
	slot3 = slot0.params_.battleResult.oldPlayerEXPInfo
	slot4 = slot3.userLevel
	slot5 = slot3.remain_exp
	slot6 = ActivityData:GetActivityData(slot2)

	if slot2 ~= 0 and (not slot6 or not slot6:IsActivitying()) or not slot0:NeedAddExp() then
		slot1 = 0
	end

	if math.min(slot1, LvTools.GetMaxTotalExp("user_level_exp") - slot3.total_exp) < 0 then
		slot8 = 0
	end

	slot9, slot10 = LvTools.CheckExp(slot4, slot5 + slot8, "user_level_exp")

	if slot4 > 30 and slot9 - slot4 > 1 then
		error(string.format("经验计算有问题，玩家原来经验%s，添加了%s经验，lv: %s->%s", tostring(slot5), tostring(slot8), tostring(slot4), tostring(slot9)))
	end

	slot0.expTxt_.text = string.format("EXP+%d", slot8)

	if LvTools.GetIsMaxLv(slot9, "user") then
		slot0.lvNumTxt_.text = "--/--"
	else
		slot0.lvNumTxt_.text = table.concat({
			slot10,
			"/",
			GameLevelSetting[slot9].user_level_exp
		})
	end

	slot12 = math.floor(slot10 / GameLevelSetting[slot9].user_level_exp * 1000) / 1000

	if math.floor(slot5 / GameLevelSetting[slot4].user_level_exp * 1000) / 1000 > 0.99 then
		slot11 = 0.99
	end

	if slot12 > 0.99 then
		slot12 = 0.99
	end

	if slot1 > 0 then
		manager.audio:PlayEffect("ui_system", "exp_add", "")
	end

	if slot4 == slot9 and math.abs(slot11 - slot12) < 0.0001 then
		SetActive(slot0.maskBtn_.gameObject, false)
		slot0:SetExpWithoutTween(slot9, slot12)
	else
		slot0:StartExpTween(slot4, slot9, slot11, slot12)
	end
end

function slot0.RenderUserData(slot0, slot1)
	slot2, slot3 = math.modf(slot1)
	slot4 = GameLevelSetting[slot2].user_level_exp
	slot0.levelTxt_.text = string.format("%d", slot2)

	if LvTools.GetIsMaxLv(slot2, "user") then
		slot0.expSlider_.value = 1
	else
		slot0.expSlider_.value = slot3
	end
end

function slot0.RefreshBottomBtn(slot0)
	slot1, slot2 = slot0:NeedOnceMore()

	if slot2 then
		slot0.confirmBtnTxt_.text = GetI18NText(slot2)
	else
		slot0.confirmBtnTxt_.text = GetTips("CHALLENGE_ONCE_MORE")
	end

	SetActive(slot0.nextStageBtn_.gameObject, slot1)

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0.params_.stageData:GetType() then
		SetActive(slot0.costImage_.gameObject, false)
	end
end

function slot0.RenderMaskBg(slot0)
	if not slot0.hasSnapshot_ then
		slot0.commonMaskBg_.sprite = getSpriteWithoutAtlas("TextureBg/BattleResult/battleResult_bg_common")

		slot0.adaptComp:AdaptImg()
		SetActive(slot0.commonMaskBg_.gameObject, true)
		SetActive(slot0.maskBg_.gameObject, false)
	else
		SetActive(slot0.commonMaskBg_.gameObject, false)
		SetActive(slot0.maskBg_.gameObject, true)
	end
end

function slot0.RemoveExpTween(slot0)
	if slot0.expTween_ then
		slot0.expTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.gameObject_)

		slot0.expTween_ = nil
	end
end

function slot0.StartExpTween(slot0, slot1, slot2, slot3, slot4)
	slot0:RemoveExpTween()
	SetActive(slot0.maskBtn_.gameObject, true)

	slot5 = -1
	slot0.tween_ = LeanTween.value(slot0.expSlider_.gameObject, slot1 + slot3, slot2 + slot4, 2):setEase(LeanTweenType.easeOutCubic):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = math.modf(slot0)

		if uv0 == -1 then
			uv0 = slot1
		end

		if slot1 ~= uv0 then
			manager.audio:PlayEffect("ui_system", "exp_levelup", "")

			uv0 = slot1
		end

		uv1:RenderUserData(slot0)
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:CheckLevelUp()
		SetActive(uv0.maskBtn_.gameObject, false)
		uv0:RemoveExpTween()
	end))
end

function slot0.SetExpWithoutTween(slot0, slot1, slot2)
	slot0:RenderUserData(slot1 + slot2)
end

function slot0.ShowContent(slot0)
	slot0:onRenderMissionContent()
end

function slot0.onRenderMissionContent(slot0)
	if not slot0.missionView then
		slot0.missionView = BattleSettlementMissionModule.New(slot0.contentContainer_)
	end

	slot2 = {}

	slot0.missionView:RenderView(slot0.stageType, slot0.stageId, slot0.params_.starMissionData)
	slot0.missionView:RenderRewards(slot0.params_.rewardList)
end

function slot0.GetPlayerInfo(slot0)
	return PlayerData:GetPlayerInfo()
end

function slot0.GetBattleTime(slot0)
	return manager.time:DescCdTime2(LuaExchangeHelper.GetBattleStatisticsData().dataForLua.battleTime)
end

function slot0.CheckLevelUp(slot0)
	if #slot0:GetLevelUpInfoList() > 0 then
		PlayerAction.LevelUpFinish()
		slot0:Go("levelUp", {
			levelUpInfoList = slot1
		})
	end
end

function slot0.GetLevelUpInfoList(slot0)
	return PlayerData:GetlevelUpInfos()
end

function slot0.NeedAddExp(slot0)
	return true
end

function slot0.GetRewardData(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(slot0.params_.rewardList) do
		table.insert(slot1, slot6)
	end

	return slot1
end

function slot0.CheckIsMultipleReward(slot0)
	if not slot0.params_.rewardList then
		return false
	end

	if #slot0.params_.rewardList == 0 then
		return false
	end

	if slot0.params_.rewardList[1] and slot0.params_.rewardList[1].id then
		return false
	end

	return true
end

function slot0.CaculateReward(slot0)
	if slot0.isMultiple or slot0:CheckIsMultipleReward() then
		return
	end

	slot0.rewardHeroExp_ = 0
	slot1 = 0

	if slot0.params_.rewardList then
		for slot5, slot6 in ipairs(slot0.params_.rewardList) do
			if ItemCfg[slot6[1]].type == ItemConst.ITEM_TYPE.CURRENCY and slot6[1] == CurrencyConst.CURRENCY_TYPE_HERO_EXP then
				slot1 = slot5
			end
		end
	end

	if slot1 ~= 0 then
		slot0.rewardHeroExp_ = slot0.params_.rewardList[slot1][2]

		table.remove(slot0.params_.rewardList, slot1)
	end
end

function slot0.OnTop(slot0)
	SetActive(slot0.gameObject_, true)

	slot0.toStat_ = false
end

function slot0.OnBehind(slot0)
	if slot0.toStat_ then
		SetActive(slot0.gameObject_, false)
	end
end

function slot0.GoToBattleStatistics(slot0)
	slot0.toStat_ = true

	JumpTools.OpenPageByJump("battleStatistics", {
		stageData = slot0.params_.stageData,
		battleTime = slot0:GetBattleTime(),
		hasSnapshot_ = slot0.hasSnapshot_
	})
end

function slot0.ShowVitalityBox(slot0, slot1)
	if needShowVitalityFullBox() then
		showVitalitySendMail(slot1)
	else
		slot1()
	end
end

function slot0.ShowEquipBox(slot0, slot1)
	if needShowBagFullBox() then
		showEquipSendMail(slot1)
	else
		slot1()
	end
end

function slot0.CloseFunc(slot0)
	OperationRecorder.Record(slot0.class.__cname, "closeCombat")
	slot0:ShowVitalityBox(function ()
		uv0:ShowEquipBox(function ()
			BattleInstance.QuitBattle(uv0.params_.stageData)
		end)
	end)
end

function slot0.NeedOnceMore(slot0)
	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_TOWER == slot0.params_.stageData:GetType() then
		slot1 = slot0.params_.stageData:GetStageId()

		if slot3[(table.indexof(ChapterCfg[getChapterIDByStageID(slot1)].section_id_list, slot1) or 0) + 1] ~= nil then
			return true, GetTips("CHALLENGE_NEXT_LEVEL")
		end
	end

	return false
end

function slot0.PostRenderView(slot0)
	if slot0.params_.battleResult.errorCode == BattleConst.ERROR_CODE_TIME_OVER then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("ACTIVITY_LOCK_SETTLEMENT_TIP"),
			OkCallback = function ()
				uv0:CloseFunc()
			end
		})
	end
end

function slot0.OnceMoreFunc(slot0)
	slot1 = slot0.params_.destID
	slot2 = slot0.params_.stageID
	slot3 = slot0.stageData:GetCost()
	slot4 = slot0.stageData:GetMultiple()
	slot5 = CurrencyData:GetCurrencyNum(CurrencyConst.CURRENCY_TYPE_VITALITY)
	slot6 = CurrencyConst.CURRENCY_TYPE_VITALITY

	if slot0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT2_GAME_CHALLENGE then
		slot8 = ActivityPt2Cfg[slot0.stageData:GetDest()]
		slot3 = slot8.cost[1][2]
		slot5 = ItemTools.getItemNum(slot8.cost[1][1])
	elseif slot0.stageType == BattleConst.STAGE_TYPE_NEW.ACTIVITY_PT_SCROLL then
		slot8 = ActivityPtRouletteStageCfg[slot0.stageData:GetDest()]
		slot3 = slot8.cost[2]
		slot5 = ItemTools.getItemNum(slot8.cost[1])
	end

	if slot5 < slot3 * slot4 then
		if slot6 ~= CurrencyConst.CURRENCY_TYPE_VITALITY then
			ShowTips(string.format(GetTips("CURRENCY_NO_ENOUGH"), ItemTools.getItemName(slot6)))
		elseif CurrencyData:GetFatigueBuyTimes() < GameSetting.fatigue_max_buy_time.value[1] or hasVitalityProp() then
			JumpTools.OpenPopUp("currencyBuyFatigue", {}, ViewConst.SYSTEM_ID.BUY_FATIGUE)
		else
			ShowTips("ERROR_ITEM_NOT_ENOUGH_FATIGUE")
		end
	else
		BattleInstance.OnceMoreBattle(slot0.stageData)
	end
end

return slot0
