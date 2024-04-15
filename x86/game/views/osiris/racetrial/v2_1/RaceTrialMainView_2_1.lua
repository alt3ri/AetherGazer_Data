slot0 = class("RaceTrialMainView_2_1", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return RaceTrialTools.GetMainUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.battleList_ = {}
	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, slot0:GetBattleItemClass())
	slot0.receiveCon_ = ControllerUtil.GetController(slot0.transform_, "receiveCon")
	slot0.scoreRewardItem_ = CommonItem.New(slot0.CommonItemGo_)

	slot0.scoreRewardItem_:RegistCallBack(function ()
		ShowPopItem(POP_ITEM, uv0.reward_)
	end)

	slot0.receivePointRewardHandler_ = handler(slot0, slot0.OnReceivePoint)
end

function slot0.GetBattleItemClass(slot0)
	return RaceTrialTools.GetBattleItemClass(slot0.activityID_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.battleList_[slot1], slot0.activityID_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.firstRewardBtn_, nil, function ()
		if not uv0:IsActivityTime(uv0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("raceTrialFirstReward", {
			mainActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.scoreRewardBtn_, nil, function ()
		if not uv0:IsActivityTime(uv0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeRaceTrialScoreRewardPop", {
			mainActivityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if not uv0:IsActivityTime(uv0.activityID_) then
			return
		end

		RaceTrialAction:ReceiveScoreReward(uv0.curLv_)
	end)
	slot0:AddBtnListener(slot0.DivineBtn_, nil, function ()
		if not uv0:IsActivityTime(uv0.activityID_) then
			return
		end

		JumpTools.OpenPageByJump("volumeHeroRaceTrialDetails")
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_OSIRIS_TACE_TRIAL_DESCRIPE")
		})
	end)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:RefreshUI()
		slot0:BindRedPointUI()
		slot0:RegistEventListener(RACE_TRIAL_POINT_RECEIVE, slot0.receivePointRewardHandler_)
	else
		for slot5, slot6 in pairs(slot0.scrollHelper_:GetItemList()) do
			slot6:OnExit()
		end

		slot0.scoreRewardItem_:OnExit()
		saveData(string.format("RaceTrial_%d", slot0.activityID_), "scrollPosX", slot0.scrollHelper_:GetScrolledPosition().x)
		slot0:UnBindRedPointUI()
		slot0:RemoveAllEventListener()
	end
end

function slot0.OnReceivePoint(slot0)
	slot0:GetCurLv()
	slot0:RefreshScoreItem()
end

function slot0.BindRedPointUI(slot0)
	manager.redPoint:bindUIandKey(slot0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0.activityID_))
end

function slot0.UnBindRedPointUI(slot0)
	manager.redPoint:unbindUIandKey(slot0.firstRewardBtn_.transform, string.format("%s_%s_firstReward", RedPointConst.ACTIVITY_RACE_TRIAL, slot0.activityID_))
end

function slot0.RefreshUI(slot0)
	slot0:GetCurLv()
	slot0:RefreshList()
	slot0:RefreshScoreItem()
end

function slot0.GetCurLv(slot0)
	slot0.curLv_ = RaceTrialData:GetCurLv(slot0.activityID_)
	slot0.data_ = RaceTrialData:GetScoreRewardByID(slot0.curLv_)
end

function slot0.RefreshList(slot0)
	slot0.battleList_ = ActivityData:GetActivityData(slot0.activityID_).subActivityIdList

	slot0.scrollHelper_:StartScrollByPosition(#slot0.battleList_, Vector2(getData(string.format("RaceTrial_%d", slot0.activityID_), "scrollPosX"), 1))
end

function slot0.RefreshScoreItem(slot0)
	slot0.rewardCfg_ = ActivityPointRewardCfg[slot0.curLv_]
	slot0.curScoreText_.text = RaceTrialData:GetTotalScore(slot0.activityID_)
	slot0.needScoreText_.text = "/" .. slot0.rewardCfg_.need
	slot0.reward_ = slot0.rewardCfg_.reward_item_list[1]

	slot0.scoreRewardItem_:RefreshData(formatReward(slot0.rewardCfg_.reward_item_list[1]))

	if slot0.data_.receive_flag then
		slot0.receiveCon_:SetSelectedState("received")
	elseif slot0.rewardCfg_.need <= slot1 then
		slot0.receiveCon_:SetSelectedState("complete")
	else
		slot0.receiveCon_:SetSelectedState("incomplete")
	end
end

function slot0.OnPointReceive(slot0)
	slot0:GetCurLv()
	slot0:RefreshScoreItem()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.scoreRewardItem_:Dispose()

	slot0.receivePointRewardHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
