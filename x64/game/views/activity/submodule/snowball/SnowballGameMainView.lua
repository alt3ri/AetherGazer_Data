slot1 = class("SnowballGameMainView", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/JapanRegionSnowballMainUI"
end

function slot1.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot0:GetActivityID())
end

function slot2(slot0)
	return AssignmentCfg[slot0.id].type == TaskConst.TASK_TYPE.OSIRIS_TASK_DAILY or slot2.type == TaskConst.TASK_TYPE.OSIRIS_TASK_CHALLENGE
end

function slot1.Init(slot0)
	slot0:BindCfgUI()

	slot0.questSubView = ActivityQuestSubView.New(slot0.gameObject_, SnowballGameData.activityID, uv0, SnowballQuestItem, true)
	slot0.stateControler = ControllerUtil.GetController(slot0.transform_, "state")

	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		if uv0:IsActivityTime() then
			DormMinigame.Launch("HZ07_xueqiu1")
		end
	end)
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		slot0 = "ACTIVITY_SNOWBALL_DESC"

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips(slot0),
			key = slot0
		})
	end)
end

function slot1.Dispose(slot0)
	slot0.questSubView:Dispose()
	uv0.super.Dispose(slot0)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0.questSubView:OnEnter()

	slot1 = SnowballGameData.activityID

	manager.redPoint:bindUIandKey(slot0.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0.questSubView:OnExit()

	slot1 = SnowballGameData.activityID

	manager.redPoint:unbindUIandKey(slot0.startBtn_.transform, RedPointConst.ACTIVITY_2_6_SNOWBALL_IN_GAME)
end

function slot1.GetActivityID(slot0)
	return SnowballGameData.activityID
end

function slot1.RefreshUI(slot0)
	slot0:RefreshTimeText()

	if ActivityTools.GetActivityStatus(slot0:GetActivityID()) == 1 then
		slot0.stateController:SetSelectedState("unlock")
	else
		slot0.stateController:SetSelectedState("close")
	end
end

function slot1.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN,
		MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN
	})
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_STAGE_COIN, true)
	manager.windowBar:SetBarCanAdd(MaterialConst.SNOWBALL_ACTIVITY_ICE_COIN, true)
end

return slot1
