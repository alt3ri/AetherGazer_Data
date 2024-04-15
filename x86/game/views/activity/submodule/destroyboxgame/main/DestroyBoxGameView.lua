slot0 = class("DestroyBoxGameView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionBoxUI/JapanRegionBoxUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.viewList_ = {
		DestroyBoxGameNormalView.New(slot0.challengeGo3_),
		DestroyBoxGameChallengeView.New(slot0.challengeGo1_, 1),
		DestroyBoxGameChallengeView.New(slot0.challengeGo2_, 2)
	}
	slot0.switchSelectItemHandler_ = handler(slot0, slot0.SwitchSelectItem)
end

function slot0.OnEnter(slot0)
	slot4 = INFO_BAR

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		slot4
	})
	manager.windowBar:SetGameHelpKey("DESTROY_BOX_GAME_DESC")

	slot0.mainActivityID_ = slot0.params_.activityID

	slot0:RefreshTime()

	for slot4, slot5 in ipairs(slot0.viewList_) do
		slot5:OnEnter(slot0.mainActivityID_)
	end

	slot0:SwitchSelectItem()
	manager.notify:RegistListener(DESTROY_BOX_GAME_SELECT_STAGE, slot0.switchSelectItemHandler_)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.DESTROY_BOX_GAME_REWARD, slot0.mainActivityID_))
end

function slot0.OnExit(slot0)
	slot5 = "%s_%s"

	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format(slot5, RedPointConst.DESTROY_BOX_GAME_REWARD, slot0.mainActivityID_))

	slot4 = slot0.switchSelectItemHandler_

	manager.notify:RemoveListener(DESTROY_BOX_GAME_SELECT_STAGE, slot4)
	manager.windowBar:HideBar()
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.viewList_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0.switchSelectHandler_ = nil

	for slot4, slot5 in ipairs(slot0.viewList_) do
		slot5:Dispose()
	end

	slot0.viewList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("destroyBoxGameReward", {
			mainActivityID = uv0.mainActivityID_
		})
	end)
	slot0:AddBtnListener(slot0.battleBtn_, nil, function ()
		if manager.time:GetServerTime() < ActivityData:GetActivityData(uv0.mainActivityID_).startTime then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot0.startTime, nil, true)))

			return
		elseif slot0.stopTime <= slot1 then
			ShowTips("TIME_OVER")

			return
		end

		if ActivityTools.GetActivityStatus(DestroyBoxGameCfg[DestroyBoxGameData:GetSelectID(uv0.mainActivityID_)].activity_id) ~= 1 then
			if manager.time:GetServerTime() < ActivityData:GetActivityData(slot3.activity_id).startTime then
				ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr2(slot4.startTime, nil, true)))
			elseif slot4.stopTime <= slot5 then
				ShowTips("TIME_OVER")
			end

			return
		elseif not DestroyBoxGameData:IsFinishPreStage(slot2) then
			ShowTips("STAGE_LOCK")

			return
		end

		DestroyBoxGameAction.ClickBoxStageItem(slot3.activity_id, slot2)
		uv0:Go("/sectionSelectHero", {
			canChangeTeam = false,
			activityID = slot3.activity_id,
			section = slot3.stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME
		})
	end)
end

function slot0.SwitchSelectItem(slot0)
	for slot5, slot6 in ipairs(slot0.viewList_) do
		slot6:SwitchSelectItem(DestroyBoxGameData:GetSelectID(slot0.mainActivityID_))
	end
end

function slot0.RefreshTime(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = manager.time:GetLostTimeStr2(ActivityData:GetActivityData(slot0.mainActivityID_).stopTime, nil, true)
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = manager.time:GetLostTimeStr2(uv1, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
