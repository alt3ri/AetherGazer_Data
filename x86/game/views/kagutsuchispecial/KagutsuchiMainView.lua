slot1 = class("KagutsuchiHomeView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionKagutsuchiUI"
end

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot0:GetActivityID())
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot1.AddUIListener(slot0)
	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1
	slot3 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, slot2)
	slot4 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, slot2)
	slot5 = string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_HANAFUDA, slot2)

	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("activity_kagutsuchi_draw1")

		if not ActivityTools.ActivityOpenCheck(uv0) then
			return
		end

		JumpTools.OpenPageByJump("/kagutsuchiGacha", {})
	end)
	slot0:AddBtnListener(slot0.workBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(uv1)
		JumpTools.OpenPageByJump("/kagutsuchiWork", {
			activityID = uv2:GetActivityID()
		})
	end)
	slot0:AddBtnListener(slot0.fishBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(uv1)
		DormMinigame.Launch("HZ07_diaoyu1")
	end)
	slot0:AddBtnListener(slot0.hanafudaBtn_, nil, function ()
		if not ActivityTools.ActivityOpenCheck(uv0) then
			return
		end

		KagutsuchiWorkAction:BanRedPoint(uv1)
		JumpTools.OpenPageByJump("/hanafudaGameView", {})
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:RefreshUI()

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:bindUIandKey(slot0.workBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, slot2))
	manager.redPoint:bindUIandKey(slot0.hanafudaBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, slot2))
	manager.redPoint:bindUIandKey(slot0.fishBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, slot2))
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, slot2))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot1 = slot0:GetActivityID()
	slot2 = ActivityTools.GetRedPointKey(slot1) .. slot1

	manager.redPoint:unbindUIandKey(slot0.workBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_REWARD, slot2))
	manager.redPoint:unbindUIandKey(slot0.hanafudaBtn_.transform, string.format("%s_%s", RedPointConst.KAGUTUSUCHI_HANAFUDA, slot2))
	manager.redPoint:unbindUIandKey(slot0.fishBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_WORK_FISH, slot2))
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.transform, string.format("%s_%s", RedPointConst.ACTIVITY_KAGUTSUCHI_GACHA, slot2))
end

function slot1.GetActivityID(slot0)
	return ActivityConst.KAGUTSUCHI_ACTIVITY
end

function slot1.RefreshUI(slot0)
	slot1 = slot0:GetActivityID()
	slot2 = ActivityData:GetActivityData(slot1)
	slot3 = slot2.startTime
	slot4 = slot2.stopTime
	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)

	KagutsuchiWorkAction:UpdateRedPoint(slot1)
end

return slot1
