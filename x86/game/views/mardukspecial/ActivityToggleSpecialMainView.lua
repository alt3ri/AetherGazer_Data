slot1 = class("ActivityToggleSpecialMainView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))
slot2 = "MARDUK_SPECIAL_NOTE_1"

function slot1.GetUIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdEscortUI/XH3rdEscortUI"
end

function slot1.Init(slot0)
	slot0.items_ = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.rankLockController_ = ControllerUtil.GetController(slot0.rankBtn_.transform, "rankLock")
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityToggleSpecialRewardView", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.rankBtn_, nil, function ()
		if not uv0.rankOpen_ then
			return
		end

		JumpTools.OpenPageByJump("/mardukSpecialRank", {
			activityId = uv0.activityID_,
			subActivityId = uv0.activityIds_[uv0.curIndex_]
		})
	end)
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(uv0),
			key = uv0
		})
	end)
end

function slot1.OnTop(slot0)
	slot0:UpdateBar()
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.activityIds_ = ActivityCfg[slot0.activityID_].sub_activity_list

	for slot4, slot5 in ipairs(slot0.activityIds_) do
		if not slot0.items_[slot4] then
			slot0.items_[slot4] = slot0:CreateItem(slot4)
		end

		slot0.items_[slot4]:SetData(slot4, slot0.activityID_, slot5)
		slot0.items_[slot4]:OnEnter()
	end

	manager.redPoint:bindUIandKey(slot0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	slot0:StartMyTimer()
	slot0:UpdateTimer()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot0.curIndex_ = nil

	for slot4, slot5 in pairs(slot0.items_) do
		slot5:OnExit()
	end

	AnimatorTools.Stop()
	slot0:StopMyTimer()
	manager.redPoint:unbindUIandKey(slot0.rewardbtntrans_, string.format("%s_%d", RedPointConst.MARDUK_SPECIAL_REWARD, ActivityConst.ACTIVITY_2_2_SPECIAL))
	manager.windowBar:HideBar()
end

function slot1.StartMyTimer(slot0)
	if slot0.mytimer_ == nil then
		slot0.mytimer_ = Timer.New(function ()
			uv0:UpdateTimer()
		end, 1, -1)
	end

	slot0.mytimer_:Start()
end

function slot1.StopMyTimer(slot0)
	if slot0.mytimer_ then
		slot0.mytimer_:Stop()

		slot0.mytimer_ = nil
	end
end

function slot1.CreateItem(slot0, slot1)
	slot3 = ActivityToggleSpecialItem.New(slot0["item" .. slot1 .. "Go_"])

	slot3:SetItemSelectHandler(handler(slot0, slot0.OnNodeSelect))

	return slot3
end

function slot1.OnNodeSelect(slot0, slot1, slot2)
	if not slot2 then
		slot0.items_[slot0.curIndex_]:ShowSelect(false)

		slot0.curIndex_ = nil

		slot0:UpdateView()

		return
	end

	if slot0.curIndex_ ~= nil and slot1 == slot0.curIndex_ then
		return
	end

	slot0:SetSelect(slot1)
end

function slot1.SetSelect(slot0, slot1)
	if slot0.curIndex_ then
		slot0.items_[slot0.curIndex_]:ShowSelect(false)
	end

	slot0.curIndex_ = slot1

	if slot0.curIndex_ then
		slot0:ScrollToItem(slot1)
	end

	slot0.items_[slot1]:ShowSelect(true)
	slot0:UpdateView()
end

function slot1.ScrollToItem(slot0, slot1)
	slot2 = slot0.container_.rect.width

	if 0 + 140 * (slot1 - 1) + 470 / 2 - slot0.scrollViewTransform_.rect.height / 2 < 0 then
		slot6 = 0
	end

	if slot6 > slot2 + slot4 / 2 then
		slot6 = slot2 + slot4 / 2
	end

	slot0.container_.localPosition.y = slot6

	LeanTween.moveLocalY(slot0.container_.gameObject, slot6, 0.2)
end

function slot1.UpdateView(slot0)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contenttrans_)

	slot0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot0.activityID_).stopTime)
end

function slot1.UpdateTimer(slot0)
	slot1 = false

	for slot6, slot7 in ipairs(slot0.activityIds_) do
		if #ActivityCfg[slot7].sub_activity_list > 0 then
			if 0 == 0 then
				slot2 = slot7
			end

			if ActivityData:GetActivityIsOpen(slot7) then
				slot1 = true

				break
			end
		end
	end

	slot0.rankOpen_ = slot1

	if slot1 then
		slot0.rankLockController_:SetSelectedState("false")
	else
		slot0.rankLockController_:SetSelectedState("true")

		slot4 = ActivityData:GetActivityData(slot2).stopTime

		if ActivityData:GetActivityData(slot2).stopTime < manager.time:GetServerTime() then
			slot0.timeLabel_.text = GetTips("TIME_OVER")
		else
			slot0.timeLabel_.text = string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(slot2).startTime))
		end
	end

	if manager.time:GetServerTime() < ActivityData:GetActivityData(slot0.activityID_).stopTime then
		slot0.lastTimeLabel_.text = manager.time:GetLostTimeStrWith2Unit(slot4)
	else
		slot0.lastTimeLabel_.text = GetTips("TIME_OVER")
	end

	for slot8, slot9 in pairs(slot0.items_) do
		slot9:UpdateTime()
	end
end

function slot1.Dispose(slot0)
	if slot0.items_ then
		for slot4, slot5 in pairs(slot0.items_) do
			slot5:Dispose()
		end

		slot0.items_ = nil
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.activityOpenHandler_ = nil

	uv0.super.Dispose(slot0)
end

return slot1
