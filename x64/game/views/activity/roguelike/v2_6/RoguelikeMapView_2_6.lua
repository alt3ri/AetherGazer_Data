slot0 = class("RoguelikeMapView_2_6", ReduxView)

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRoguelikeUI/JapanRoguelikeMapUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.map = nil
	slot0.activity_id = slot0.params_.activity_id
	slot0.activityData = ActivityData:GetActivityData(slot0.activity_id)

	slot0.gameObject_:InjectUI(slot0)
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.BtnReset, nil, handler(slot0, slot0.OnBtnResetClick))
	slot0:AddBtnListener(slot0.BtnRole, nil, handler(slot0, slot0.OnBtnRoleClick))
	slot0:AddBtnListener(slot0.BtnReward, nil, handler(slot0, slot0.OnBtnRewardClick))
	slot0:AddBtnListener(slot0.BtnRank, nil, handler(slot0, slot0.OnBtnRankClick))
end

function slot0.OnBtnResetClick(slot0)
	ShowMessageBox({
		title = GetTips("PROMPT"),
		content = GetTips("GIVE_UP_MATRIX"),
		OkCallback = function ()
			StrategyMatrixAction.QueryMatrixGiveUp(uv0.activity_id)
		end,
		CancelCallback = function ()
		end
	})
end

function slot0.OnBtnRoleClick(slot0)
	JumpTools.OpenPageByJump("/strategyMatrixHero", {
		matrix_activity_id = slot0.activity_id,
		heroId = StrategyMatrixData:GetMatrixHeroTeam(slot0.activity_id)[1]
	})
end

function slot0.OnBtnRewardClick(slot0)
	OperationRecorder.RecordButtonTouch("activity_polyhedron_izanami_reward2")
	JumpTools.OpenPageByJump("strategyMatrixRward", {
		task_activity_id = ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6
	})
end

function slot0.OnBtnRankClick(slot0)
	JumpTools.OpenPageByJump("/roguelikeRank", {
		rank_id = slot0.rank_id
	})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activity_id
	slot0.rank_id = slot0:GetRankId(slot0.activity_id)

	slot0:BindRedPoint()
	slot0:GenerateRoguelikeMap(slot0.Content)
	slot0:Refresh()

	slot0.timer = Timer.New(handler(slot0, slot0.Tick), 1, -1)

	slot0.timer:Start()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.map then
		slot0.map:Exit()
	end

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	slot0:UnBindRedPoint()
end

function slot0.OnUpdate(slot0)
	slot0:InitBar()
end

function slot0.OnTop(slot0)
	slot0:InitBar()

	if slot0.map then
		slot0.map:OnTop()
	end
end

function slot0.InitBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(StrategyMatrixTools.GetGameTipKey(slot0.activity_id))
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back()
	end)
end

function slot0.Refresh(slot0)
	slot0:TryPlayAnimation()
	slot0:Tick()
	slot0:RefreshTitleAndBg()
end

function slot0.GenerateRoguelikeMap(slot0, slot1)
	slot0.mapId = StrategyMatrixData:GetMapId(slot0.activity_id)

	if slot0.map and slot0.mapId ~= slot0.map:GetMapId() then
		slot0.map:Dispose()

		slot0.map = nil
	end

	slot0.map = slot0.map or StrategyMatrixMap.New(slot0.mapId, slot1)

	slot0.map:SetData(slot0.activity_id)
end

function slot0.TryPlayAnimation(slot0)
	if slot0.params_.playerAnim then
		slot0.m_animation:Play(nil, 0)

		slot0.params_.playerAnim = nil

		slot0.map:PlayerAnim(true)
	else
		slot0.m_animation:Play(nil, 1)
		slot0.map:PlayerAnim(false)
	end
end

function slot0.RefreshTitleAndBg(slot0)
	if not RoguelikeConst[slot0.activity_id] or not StrategyMatrixCfg[slot0.activity_id] then
		print("请在RoguelikeConst加上对应活动id的配置")

		return
	end

	if not StrategyMatrixData:GetTierID(slot0.activity_id) then
		slot0.TxtTier.text = ""

		return
	end

	slot4 = StrategyMatrixTierTemplateCfg[slot3]
	slot5 = StrategyMatrixData:GetRoguelikeScore(slot0.activity_id)
	slot6 = slot2.activity_difficulty ~= 1

	slot0.CtrlDifficult:SetSelectedIndex(slot6 and 1 or 0)

	slot0.TxtDifficult.text = GetTips(slot6 and "HARDLEVEL_HARD" or "HARDLEVEL_EASY")
	slot0.TxtTier.text = GetTips("ACTIVITY_ROGUELIKE_TITLE_" .. slot4.tier)
	slot0.ImgBg.sprite = getSpriteWithoutAtlas(slot1.background[slot4.tier])

	slot0.CtrlRank.gameObject:SetActive(slot0.rank_id ~= 0)
	slot0.CtrlRank:SetSelectedIndex(slot5 > 0 and 1 or 0)

	slot0.TxtScore.text = slot5
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.BtnReward.transform, string.format("%s_%s", RedPointConst.STRATEGY_MATRIX_REWARD, ActivityConst.ACTIVITY_ROGUELIKE_NORMAL_2_6))
end

function slot0.Tick(slot0)
	if manager.time:GetServerTime() <= slot0.activityData.stopTime then
		slot0.TxtTime.text = manager.time:GetLostTimeStr(slot0.activityData.stopTime)
	else
		slot0.TxtTime.text = GetTips("TIME_OVER")
	end
end

function slot0.GetRankId(slot0, slot1)
	if not ActivityCfg[slot1] then
		return 0
	end

	for slot6, slot7 in ipairs(slot2.sub_activity_list) do
		if ActivityCfg[slot7] and slot8.activity_template == ActivityTemplateConst.ROGUELIKE_RANK then
			return slot7
		end
	end

	return 0
end

function slot0.Dispose(slot0)
	if slot0.map then
		slot0.map:Dispose()
	end

	slot0.map = nil

	uv0.super.Dispose(slot0)
end

return slot0
