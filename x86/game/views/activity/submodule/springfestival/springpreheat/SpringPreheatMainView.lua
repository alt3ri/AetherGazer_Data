slot1 = class("SpringPreheatMainView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaWishingTree/IndiaWishingTreeMainUI"
end

function slot1.Ctor(slot0, slot1, slot2)
	slot0.activityId_ = slot2

	uv0.super.Ctor(slot0, slot1, slot0:GetActivityID())
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.letterController = ControllerUtil.GetController(slot0.letterBtn_.transform, "state")
	slot0.rewardController = ControllerUtil.GetController(slot0.rewardBtn_.transform, "reward")
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.prayBtn_, nil, function ()
		if not SpringPreheatData:IsTodayWritten() and SpringPreheatData:GetLetterStorage() < uv0:GetMaxLetterCount() then
			ShowTips("SPRING_PREHEAT_LETTER_NOT_WRITE")

			return
		end

		JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatPray", {})
	end)
	slot0:AddBtnListener(slot0.letterBtn_, nil, function ()
		uv0:OnClickLetterBtn()
	end)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("springPreheatReward", {})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		slot0 = "SPRING_PREHEAT_LETTER_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:bindUIandKey(slot0.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, slot2))
	manager.redPoint:bindUIandKey(slot0.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, slot2))
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, slot2))
	slot0:AddTimer()
	slot0:RefreshUI()
end

function slot1.OnTop(slot0)
	slot0:RefreshUI()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:unbindUIandKey(slot0.letterBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_LETTER, slot2))
	manager.redPoint:unbindUIandKey(slot0.prayBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_PRAY, slot2))
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_2_8_SPRING_PREHEAT_REWARD, slot2))
	slot0:StopTimer()
end

function slot1.RefreshUI(slot0)
	slot0:RefreshTimeUI()

	slot2 = SpringPreheatData:GetActivityDay()
	slot0.letterInfoText_.text = string.format("%d/%d", SpringPreheatData:GetLetterStorage(), slot0:GetMaxLetterCount())
	slot0.rewardInfoText_.text = string.format("%d/%d", slot0:GetAcquiredCount(), #SpringPreheatData:GetProgressRewardList())

	slot0.rewardController:SetSelectedState(SpringPreheatData:HasRewardCanAcquire() and "true" or "false")

	slot6 = false

	if slot1 == slot5 then
		slot0.letterController:SetSelectedState("max")
	elseif SpringPreheatData:IsTodayWritten() then
		slot0.letterController:SetSelectedState("written")
	else
		slot0.letterController:SetSelectedState("write")

		slot6 = true
	end

	SpringPreheatAction:UpdateRedPoint(slot0:GetActivityID())
end

function slot1.RefreshTimeUI(slot0)
	slot1 = ActivityData:GetActivityData(slot0:GetActivityID())
	slot2 = slot1.startTime
	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot1.stopTime, true)
end

function slot1.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = Timer.New(function ()
		uv0:RefreshUI()
	end, 1, -1)

	slot0.timer_:Start()
end

function slot1.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot1.OnClickLetterBtn(slot0)
	if SpringPreheatData:IsTodayWritten() then
		ShowTips("SPRING_PREHEAT_LETTER_WRITTEN")

		return
	end

	slot1 = slot0:GetMaxLetterCount()

	if SpringPreheatData:GetLetterStorage() == 0 and GameSetting.spring_preheat_2_8_story.value[1] and not manager.story:IsStoryPlayed(slot3) then
		slot0:Go("/springPreheatBlank")
		manager.story:StartStoryById(slot3, function (slot0)
			JumpTools.OpenPageByJump("/springPreheatEditLetter", {})
		end)

		return
	end

	if slot2 == slot1 then
		ShowTips("SPRING_PREHEAT_LETTER_MAX")

		return
	end

	JumpTools.OpenPageByJump("/springPreheatBlank/springPreheatEditLetter", {})
end

function slot1.GetActivityID(slot0)
	return slot0.activityId_
end

function slot1.GetAcquiredCount(slot0)
	for slot5, slot6 in ipairs(SpringPreheatData:GetProgressRewardList()) do
		if SpringPreheatData:IsAcquired(slot6.id) then
			slot1 = 0 + 1
		end
	end

	return slot1
end

function slot1.IsPraySelected(slot0)
	return SpringPreheatData:GetActivityDay() <= SpringPreheatData:GetCurSelectionDay()
end

function slot1.GetDays(slot0)
	return SpringPreheatData:GetMaxProgress()
end

function slot1.GetMaxLetterCount(slot0)
	return math.min(slot0:GetDays(), SpringPreheatData:GetActivityTotalDay())
end

return slot1
