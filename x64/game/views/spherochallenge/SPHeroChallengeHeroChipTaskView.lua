slot0 = class("SPHeroChallengeHeroChipTaskView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/SPHeroChallenge/SPHeroChallengeTaskPop"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.taskListModule = CommonTaskListModule.New(slot0.comTaskList_)
	slot0.gatherList = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awardList_, SPHeroChallengeCommonItem)
	slot0.chipAwardController = slot0.chipController:GetController("awardState")
end

function slot0.OnEnter(slot0)
	slot0.taskListModule:OnEnter()

	slot0.activityID = slot0.params_.activityID

	if slot0.activityID then
		slot0.taskListModule:RenderActivityTaskList(slot0.activityID)
	end

	slot0:RefreshView()
	slot0:RegisterEvents()
	slot0:StartTimer()
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
	slot0.taskListModule:OnExit()
	slot0:RemoveAllEventListener()
	slot0:CloseTimer()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.awardBtn, nil, function ()
		if uv0.chipAwardController:GetSelectedState() == "canReceive" then
			TaskAction:SubmitTask(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].HeroChipTask)
		end
	end)
	slot0:AddBtnListener(slot0.drawBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", {
			poolId = DrawTools:GetRoleUpPoolID(uv0.roleID)
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(ON_TASK_SUBMIT_RESPONSE, function ()
		uv0:RefreshGatherProgress()
		SPHeroChallengeRedPointTools:UpdataCanGetEntrustRewardRedPoint(SPHeroChallengeData:GetActivityID())
	end)
end

function slot0.Dispose(slot0)
	if slot0.taskListModule then
		slot0.taskListModule:Dispose()
	end

	if slot0.gatherList then
		slot0.gatherList:Dispose()
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
	slot0:CloseTimer()
end

function slot0.RefreshView(slot0)
	slot0:RefreshGatherProgress()
	slot0:RefreshHeroExtractState()
end

function slot0.RefreshHeroExtractState(slot0)
	slot0.roleID = SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].heroID

	if DrawTools:GetRoleUpPoolID(slot0.roleID) then
		SetActive(slot0.drawBtn_.gameObject, true)
	else
		SetActive(slot0.drawBtn_.gameObject, false)
	end
end

function slot0.RefreshGatherProgress(slot0)
	if TaskData2:GetTask(SPHeroChallengeData.activityCfg[SPHeroChallengeData:GetActivityID()].HeroChipTask) then
		slot4 = AssignmentCfg[slot2].need

		if slot3.complete_flag > 0 then
			slot0.chipAwardController:SetSelectedState("received")
		elseif slot4 <= slot3.progress then
			slot0.chipAwardController:SetSelectedState("canReceive")
		else
			slot0.chipAwardController:SetSelectedState("notMeet")
		end

		slot0.awardList = {}

		for slot10 = 1, slot4 do
			slot11 = {}

			table.insert(slot0.awardList, (slot10 > slot3.progress or {
				state = "full",
				id = CurrencyConst.CURRENCY_HERO_CHALLENGE_COIN_2
			}) and {
				id = -1,
				state = "empty"
			})
		end

		slot0.awardProText.text = string.format("%s/%s", tostring(slot3.progress), tostring(slot4))

		slot0.gatherList:StartScroll(#slot0.awardList)
	end
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.awardList[slot1])
end

function slot0.StartTimer(slot0)
	slot0:CloseTimer()

	slot0.timer = Timer.New(function ()
		uv0:RefreshHeroExtractState()
	end, 1, -1)

	slot0.timer:Start()
end

function slot0.CloseTimer(slot0)
	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

return slot0
