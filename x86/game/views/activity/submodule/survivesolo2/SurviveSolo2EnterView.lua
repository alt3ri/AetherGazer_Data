ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("SurviveSolo2EnterView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return SurviveSolo2Tools.GetEnterUIName(slot0.activityID_)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SurviveSolo2EnterItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshData(slot0.activityID_, slot0.activityList_[slot1])
	slot2:RefreshTime(manager.time:GetServerTime())
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("surviveSoloReward2", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if SurviveSolo2Tools.GetGameHelpKey(uv0.activityID_) ~= "" then
			JumpTools.OpenPageByJump("gameHelp", {
				icon = "icon_i",
				iconColor = Color(1, 1, 1),
				title = GetTips("STAGE_DESCRIPE"),
				content = GetTips(slot0),
				key = slot0
			})
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0:BindUIRedPoint()
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshActivityData()
	slot0:RefreshTime()
	slot0:RefreshList()
end

function slot0.RefreshActivityData(slot0)
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshTime(slot0)
	slot1 = nil

	slot0:StopTimer()

	if manager.time:GetServerTime() < slot0.startTime_ then
		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
		slot0.timer_ = Timer.New(function ()
			uv0 = uv1.startTime_ - manager.time:GetServerTime()

			if uv0 <= 0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			end
		end, 1, -1)

		slot0.timer_:Start()
	elseif slot2 < slot0.stopTime_ then
		slot0.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
		slot0.timer_ = Timer.New(function ()
			uv0 = manager.time:GetServerTime()

			if uv1.stopTime_ <= uv0 then
				uv1:StopTimer()
				uv1:RefreshTime()

				return
			else
				uv1.timeLable_.text = manager.time:GetLostTimeStrWith2Unit(uv1.stopTime_)
			end
		end, 1, -1)

		slot0.timer_:Start()
	else
		slot0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshList(slot0)
	slot0.activityList_ = ActivitySoloSlayerCfg.get_id_list_by_main_activity_id[slot0.activityID_]

	slot0.scrollHelper_:StartScroll(#slot0.activityList_)
	slot0:StartItemTimer()
end

function slot0.StartItemTimer(slot0)
	slot0:StopItemTimer()

	slot0.itemTimer_ = Timer.New(function ()
		for slot4, slot5 in pairs(uv0.scrollHelper_:GetItemList()) do
			slot5:RefreshTime(manager.time:GetServerTime())
		end
	end, 1, -1)

	slot0.itemTimer_:Start()
end

function slot0.StopItemTimer(slot0)
	if slot0.itemTimer_ then
		slot0.itemTimer_:Stop()

		slot0.itemTimer_ = nil
	end
end

function slot0.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshList()
	end
end

function slot0.BindUIRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.rewardBtn_.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0.activityID_)
end

function slot0.UnbindUIRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardBtn_.gameObject.transform, RedPointConst.SOLO_SURVIVE_REWARD .. "_" .. slot0.activityID_)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:UnbindUIRedPoint()
	slot0:StopItemTimer()
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.scrollHelper_:GetItemList()) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
