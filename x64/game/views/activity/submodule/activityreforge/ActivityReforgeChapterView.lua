slot0 = class("ActivityReforgeChapterView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ActivityReforge/NorseUI_3_0_ActivityReforgeChapterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0.gameHelpKey_ = "ACTIVITY_REFORGE_GAMEHELPKEY"

	slot0:BindCfgUI()

	slot0.curSelectIndex_ = 1
	slot0.btnControllerList_ = {}

	for slot4 = 1, 4 do
		slot0.btnControllerList_[slot4] = slot0["chapterListContEx" .. slot4 .. "_"]:GetController("status")
	end

	slot0.bossChartController_ = slot0.controllerEx_:GetController("bosschart")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.goldInfoBtn_, nil, function ()
		JumpTools.OpenPageByJump("activityReforgeGoldInfoView")
	end)
	slot0:AddBtnListener(slot0.taskBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeTaskView", {
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeSkillView", {
			viewType = 1,
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterActivityID_,
			levelID = uv0.levelID_
		})
	end)

	slot4 = slot0.levelBtn_

	slot0:AddBtnListener(slot4, nil, function ()
		JumpTools.OpenPageByJump("/activityReforgeLevelView", {
			activityID = uv0.activityID_,
			chapterActivityID = uv0.chapterIDList_[uv0.curSelectIndex_]
		})
	end)

	for slot4 = 1, 4 do
		slot0:AddBtnListener(slot0["chapterBtn" .. slot4 .. "_"], nil, function ()
			if uv0 ~= uv1.curSelectIndex_ then
				return
			end

			JumpTools.OpenPageByJump("/activityReforgeLevelView", {
				activityID = uv1.activityID_,
				chapterActivityID = uv1.chapterIDList_[uv0]
			})
		end)
		slot0:AddBtnListener(slot0["chapterListBtn" .. slot4 .. "_"], nil, function ()
			if uv0 == uv1.curSelectIndex_ then
				return
			end

			if ActivityData:GetActivityIsOpen(uv1.chapterIDList_[uv0]) then
				if ActivityReforgeData:GetChapterIsUnlock(slot0) then
					manager.redPoint:setTip(RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot0, 0)

					uv1.curSelectIndex_ = uv0

					uv1:RefreshUI()
					uv1.bossAni_:Play("boss02_refresh")
				else
					ShowTips("ACTIVITY_REFORGE_CHPATER_LOCK")
				end
			else
				ShowTips("ERROR_ACTIVITY_NOT_OPEN")
			end
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.ActivityID
	slot0.chapterIDList_ = ActivityCfg[slot0.activityID_].sub_activity_list
	slot0.goldMaxNum_.text = ActivityReforgeData:GetGoldMaxNum(slot0.activityID_)

	slot0:CreateTimer()
	slot0:RefreshUI()
	slot0:BindRedPoint()
	slot0:CheckCacheAddGoldNum()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.skillBtn_.transform, RedPointConst.ACTIVITY_REFORGE_SKILL .. slot0.activityID_)

	slot6 = slot0.taskBtn_.transform

	manager.redPoint:bindUIandKey(slot6, RedPointConst.ACTIVITY_REFORGE_TASK .. slot0.activityID_)

	for slot6 = 1, 4 do
		manager.redPoint:bindUIandKey(slot0["chapterListBtn" .. slot6 .. "_"].transform, RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot0.chapterIDList_[slot6])
	end
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.skillBtn_.transform, RedPointConst.ACTIVITY_REFORGE_SKILL .. slot0.activityID_)

	slot6 = slot0.taskBtn_.transform

	manager.redPoint:unbindUIandKey(slot6, RedPointConst.ACTIVITY_REFORGE_TASK .. slot0.activityID_)

	for slot6 = 1, 4 do
		manager.redPoint:unbindUIandKey(slot0["chapterListBtn" .. slot6 .. "_"].transform, RedPointConst.ACTIVITY_REFORGE_NEW_CHPATER .. slot0.chapterIDList_[slot6])
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey(slot0.gameHelpKey_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UnBindRedPoint()
	slot0:StopTimer()
	slot0:StopAddGoldNumTimer()
end

function slot0.CreateTimer(slot0)
	slot0.activityID_ = slot0.activityID_
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	if manager.time:GetServerTime() < slot0.stopTime_ then
		slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_)
	else
		slot0:StopTimer()

		slot0.timeText_.text = GetTips("TIME_OVER")
	end

	if slot0.timer_ == nil then
		slot0.timer_ = Timer.New(function ()
			if manager.time:GetServerTime() < uv0.stopTime_ then
				uv0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(uv0.stopTime_)
			else
				uv0:StopTimer()

				uv0.timeText_.text = GetTips("TIME_OVER")
			end
		end, 1, -1)

		slot0.timer_:Start()
	end
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.StopAddGoldNumTimer(slot0)
	if slot0.addGoldNumCacheTimer_ then
		slot0.addGoldNumCacheTimer_:Stop()

		slot0.addGoldNumCacheTimer_ = nil
	end
end

function slot0.RefreshUI(slot0)
	for slot4 = 1, 4 do
		if ActivityReforgeData:GetChapterIsUnlock(slot0.chapterIDList_[slot4]) then
			if slot0.curSelectIndex_ == slot4 then
				slot0.btnControllerList_[slot4]:SetSelectedState("on")
			else
				slot0.btnControllerList_[slot4]:SetSelectedState("off")
			end
		else
			slot0.btnControllerList_[slot4]:SetSelectedState("lock")
		end
	end

	slot2 = ActivityReforgeChapterCfg[slot0.chapterIDList_[slot0.curSelectIndex_]]
	slot0.nameText_.text = slot2.chapter_name
	slot0.desText_.text = slot2.chapter_des

	slot0.bossChartController_:SetSelectedState(slot0.curSelectIndex_)
end

function slot0.CheckCacheAddGoldNum(slot0)
	if ActivityReforgeData:GetCacheAddGoldNum() > 0 then
		slot0.goldAddText_.text = "+" .. slot1

		SetActive(slot0.goldAddGo_, true)
		slot0:StopAddGoldNumTimer()

		slot0.addGoldNumCacheTimer_ = Timer.New(function ()
			uv0:StopAddGoldNumTimer()
			SetActive(uv0.goldAddGo_, false)

			uv0.goldMaxNum_.text = ActivityReforgeData:SubGoldMaxNum(uv0.activityID_, uv1)

			ActivityReforgeData:ClearCacheAddGoldNum()
		end, 2, 1)

		slot0.addGoldNumCacheTimer_:Start()
	else
		SetActive(slot0.goldAddGo_, false)
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	slot0:StopAddGoldNumTimer()
	slot0.super.Dispose(slot0)
end

return slot0
