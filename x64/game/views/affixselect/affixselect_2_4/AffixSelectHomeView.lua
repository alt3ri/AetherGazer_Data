slot1 = class("AffixSelectHomeView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionAffixSelect/AffixSelectStageUI"
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot4 = "reward_btnstate"
	slot0.reward_btnstateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.bonusItem_ = CommonItem.New(slot0.bonusItemGo_)
	slot0.items_ = {}

	for slot4 = 1, 8 do
		table.insert(slot0.items_, AffixSelectItemView.New(slot0["itemGo" .. slot4 .. "_"]))
	end
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_firstpass")
		JumpTools.OpenPageByJump("affixSelectFirstRewardJapanRegion", {
			affixActivityId = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("activity_affixbattle_reward_score")
		JumpTools.OpenPageByJump("affixSelectScoreRewardJapanRegion", {
			affixActivityId = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		ActivityAction.ReceivePointReward({
			ActivityAffixSelectData:GetCurrentActivityReward(uv0.activityId)
		})
	end)
	slot0.bonusItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id
		})
	end)
	slot0:AddBtnListener(nil, slot0.m_tipBtn, function ()
		slot0 = GetTips("ACTIVITY_SKADI_SEA_DESCRIBE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_AFFIX_DESCRIBE")
		})
	end)
end

function slot1.OnEnter(slot0)
	slot0.activityId = ActivityConst.ACTIVITY_2_4_AFFIX_SELECT

	for slot6, slot7 in ipairs(slot0.items_) do
		slot7:SetData(slot6, ActivityCfg[slot0.activityId].sub_activity_list[slot6])
	end

	ActivityAffixSelectAction.ReadUnPassRedPoint()
	manager.redPoint:bindUIandKey(slot0.firstPassNoticeContainer_, string.format("%s_%s", RedPointConst.AFFIX_SELECT_FIRST_BONUS_CAN_GET, slot0.activityId), {
		x = 0,
		y = 0
	})
	slot0:UpdateView()

	if getData("affixSelect", "mainScrollPos") then
		slot0.itemScrollRect_.horizontalNormalizedPosition = slot3
	end

	slot0:StartTimer()
	slot0:RegistEventListener(ACTIVITY_REWARD_GET, handler(slot0, slot0.UpdateView))
end

function slot1.OnExit(slot0)
	slot0:StopTimer()
	slot0:RemoveAllEventListener()
	saveData("affixSelect", "mainScrollPos", slot0.itemScrollRect_.horizontalNormalizedPosition)
	manager.redPoint:unbindUIandKey(slot0.firstPassNoticeContainer_)
	manager.windowBar:HideBar()
	slot0:RemoveAllEventListener()
end

function slot1.StartTimer(slot0)
	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.timer_:Start()
end

function slot1.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot1.UpdateTimer(slot0)
	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.activityId).stopTime)
end

function slot1.UpdateView(slot0)
	slot1 = ActivityAffixSelectData:GetCurrentActivityReward(slot0.activityId)
	slot0.currentScoreLabel_.text = ActivityAffixSelectData:GetTotalScore(slot0.activityId)
	slot0.totalScoreLabel_.text = "/" .. ActivityPointRewardCfg[slot1].need

	if ActivityAffixSelectData:GetRewardStatus(slot0.activityId, slot1) == 0 then
		slot0.reward_btnstateController_:SetSelectedState("received")
	elseif slot3 == 1 then
		slot0.reward_btnstateController_:SetSelectedState("normal")
	else
		slot0.reward_btnstateController_:SetSelectedState("receive")
	end

	slot0.bonusItem_:RefreshData({
		id = slot2.reward_item_list[1][1],
		number = slot2.reward_item_list[1][2]
	})
	slot0.bonusItem_:SetBottomText("")

	slot0.bonusNumLabel_.text = slot2.reward_item_list[1][2]

	slot0:UpdateTimer()
end

function slot1.OnReceivePointReward(slot0, slot1)
	slot0:UpdateView()
end

function slot1.OnMainHomeViewTop(slot0)
end

function slot1.Dispose(slot0)
	if slot0.bonusItem_ then
		slot0.bonusItem_:Dispose()

		slot0.bonusItem_ = nil
	end

	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot1
