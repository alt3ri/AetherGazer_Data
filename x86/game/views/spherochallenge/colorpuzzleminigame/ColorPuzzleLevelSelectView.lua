slot0 = class("ColorPuzzleLevelSelectView", ReduxView)
slot1 = 53100
slot2 = 54057

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/ColorPuzzle/ColorPuzzleLevelSelectView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.levelBtns = {}

	slot0:InitLevelBtns(slot0.levelRoot_.childCount)

	slot0.levelInfoPanel = {}

	slot0:InitLevelDetailPanel()
	slot0:AddBtnListener(slot0.bgBtn_, nil, handler(slot0, slot0.UpdateLevelSelect))
	slot0:AddBtnListener(slot0.levelInfoPanel.descBtn, nil, function ()
		if uv0.levelInfoPanel.tipsController:GetSelectedState() == "show" then
			uv0.levelInfoPanel.tipsController:SetSelectedState("close")
		else
			uv0.levelInfoPanel.tipsController:SetSelectedState("show")
		end
	end)

	slot0.scrollMoveView_ = ScrollMoveView.New(slot0, slot0.scrollViewGo_)
	slot0.scrollCom = slot0.scrollViewGo_:GetComponent(typeof(ScrollRect))
end

function slot0.OnEnter(slot0)
	for slot6, slot7 in pairs(slot0.levelBtns) do
		slot9 = slot7.stateController
		slot1 = 0 + 1

		if ColorPuzzleData:IsLevelUnlocked(slot7.level) then
			if ColorPuzzleData:IsLevelCleared(slot8) then
				slot2 = 0 + 1

				slot7.clearController:SetSelectedState("yes")
			else
				slot7.clearController:SetSelectedState("no")
			end

			slot9:SetSelectedState("open")
		else
			slot9:SetSelectedState("lock")
		end

		slot0:UpdateLevelSelect(nil)
	end

	slot0.progress_.text = string.format("%d / %d", slot2, slot1)

	slot0.levelInfoPanel.tipsController:SetSelectedState("close")

	if slot0.params_.isDetailJump and table.indexof(ActivityHeroChallengeColor.all, SPHeroChallengeTools:GetNextCanBattleStageID(SpHeroChallengeConst.ScheduleSubType.decode)) then
		slot0:UpdateLevelSelect(slot4)
	end
end

function slot0.IsOpenSectionInfo(slot0)
	return slot0.showDetailController:GetSelectedState() == "show"
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		uv0,
		uv1
	})
	manager.windowBar:SetBarCanAdd(uv1, true)
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0.scrollMoveView_:OnExit()
end

function slot0.InitLevelBtns(slot0, slot1)
	for slot5 = 1, slot1 do
		slot6 = slot0:GetLevelCfg(slot5)
		slot7 = slot0.levelRoot_:GetChild(slot5 - 1).gameObject
		slot8 = {
			level = slot6.level_id,
			go = slot7,
			rectTransform = slot7:GetComponent("RectTransform")
		}

		slot0:BindCfgUI(slot7, slot8)
		slot0:AddBtnListener(slot8.btn_, nil, function ()
			uv0:UpdateLevelSelect(uv1)
		end)

		slot0.levelBtns[slot5] = slot8
		slot8.name_.text = slot6.name
		slot8.stateController = slot8.controllers_:GetController("state")
		slot8.clearController = slot8.controllers_:GetController("clear")
	end
end

function slot0.InitLevelDetailPanel(slot0)
	slot1 = slot0.levelInfoPanel

	slot0:BindCfgUI(slot0.levelDetailPanel_, slot1)

	slot0.showDetailController = slot0.controllers_:GetController("levelDetail")
	slot1.stateController = slot1.controllers_:GetController("state")
	slot1.tipsController = slot1.controllers_:GetController("showTips")
	slot1.showController = slot1.controllers_:GetController("showTime")
	slot1.rewardList = LuaList.New(handler(slot0, slot0.IndexRewardItem), slot1.rewardList_, CommonItemView)

	slot0:AddBtnListener(slot1.startBtn_, nil, function ()
		slot0, slot1 = ColorPuzzleData:IsLevelCanNotChallenge(uv0.level)

		if slot0 then
			ShowTips(slot1)

			return
		end

		if not SPHeroChallengeTools:CheckActivityCloseWithTips() then
			JumpTools.OpenPageByJump("/colorPuzzleLevel", {
				level = uv0.level
			})
		end
	end)
end

function slot0.IndexRewardItem(slot0, slot1, slot2)
	slot4 = rewardToItemTemplate(formatReward(slot0.levelInfoPanel.rewards[slot1]))

	function slot4.clickFun(slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end

	slot2:SetData(slot4)
end

function slot0.GetLevelCfg(slot0, slot1)
	return nullable(ActivityHeroChallengeColor, nullable(ActivityHeroChallengeColor, "all", slot1))
end

function slot0.UpdateLevelSelect(slot0, slot1)
	if slot1 then
		slot2 = slot0:GetLevelCfg(slot1)
		slot4 = slot0.levelInfoPanel
		slot4.level = slot2.level_id
		slot4.rewards = slot2.reward
		slot4.name_.text = slot2.name
		slot4.textText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_BATTLE_TIME_DESC")
		slot6, slot7 = SPHeroChallengeData:GetCurActivityInfo():GetStartBattelScheduleByType(SpHeroChallengeConst.ScheduleSubType.decode)
		slot8 = nil
		slot4.challengeText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_REMAIN_TIME"), (slot6 - slot7 > 0 or string.format("<color='#FF000B'>%d</color>", tostring(slot6 - slot7))) and tostring(slot6 - slot7), slot6)
		slot9, slot10 = ColorPuzzleData:IsLevelUnlocked(slot3)

		if slot9 then
			if ColorPuzzleData:IsLevelCleared(slot3) then
				slot4.stateController:SetSelectedState("clear")
				slot4.showController:SetSelectedState("close")
				slot4.rewardList:StartScroll(0)
			else
				slot4.showController:SetSelectedState("show")
				slot4.stateController:SetSelectedState("open")
				slot4.rewardList:StartScroll(#slot4.rewards)
			end
		else
			slot4.stateController:SetSelectedState("lock")

			slot4.lockText_.text = GetTips(slot10)
		end

		slot4.time_.text = ColorPuzzleData:GetLevelClearTime(slot3) and manager.time:DescCDTime(slot11) or "--:--:--"

		slot0.showDetailController:SetSelectedState("show")
		slot0:ScrollList(slot1)
	else
		slot0.scrollCom.enabled = true

		slot0.showDetailController:SetSelectedState("hide")
	end

	for slot5, slot6 in pairs(slot0.levelBtns) do
		slot6.stateController:SetSelectedState(slot1 == slot5 and "select" or "open")
	end
end

function slot0.ScrollList(slot0, slot1)
	slot0.scrollMoveView_.needInitScroll_ = false

	slot0.scrollMoveView_:RefreshUI(slot0:GetScrollPos(slot1), slot0:GetScrollWidth())
end

function slot0.GetScrollPos(slot0, slot1)
	return slot0.levelBtns[slot1].rectTransform.anchoredPosition.x
end

function slot0.GetScrollWidth(slot0)
	for slot5, slot6 in ipairs(slot0.levelBtns) do
		slot1 = math.max(slot0.levelBtns[slot5].rectTransform.anchoredPosition.x, 0)
	end

	return slot1
end

function slot0.Dispose(slot0)
	slot0.levelInfoPanel.rewardList:Dispose()
	uv0.super.Dispose(slot0)
	slot0.scrollMoveView_:Dispose()

	slot0.scrollMoveView_ = nil
end

return slot0
