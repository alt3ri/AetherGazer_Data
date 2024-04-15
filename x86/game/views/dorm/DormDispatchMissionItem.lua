slot0 = class("DormDispatchMissionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.timeController = ControllerUtil.GetController(slot0.transform_, "task")
	slot0.workController = ControllerUtil.GetController(slot0.transform_, "workbtn")
	slot0.refreshController = ControllerUtil.GetController(slot0.transform_, "refresh")
	slot0.coolController = ControllerUtil.GetController(slot0.transform_, "cooling")
	slot0.levelController = ControllerUtil.GetController(slot0.transform_, "level")
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.roleuilistScroll_ = LuaList.New(handler(slot0, slot0.indexRecommendRoleItem), slot0.roleuilistUilist_, DormRecommendRoleItem)
	slot0.awarduilistScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awarduilistUilist_, CommonItemView)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.dispatchbtnBtn_, nil, function ()
		if #uv0.heroList == 0 then
			if uv0.confirmCallBack then
				uv0.confirmCallBack(uv0.ID, uv0.pos, uv0.timeLevel)
			end
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_TAKS_CANCEL"),
				OkCallback = function ()
					if uv0.cancelCallBack then
						uv0.cancelCallBack(uv0.ID, uv0.pos, uv0.timeLevel)
					end
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.refreshbtnBtn_, nil, function ()
		if uv0.refreshTime > 0 then
			ShowTips(string.format(GetTips("CANTEEN_TASK_REFRESH_COOLDOWN"), manager.time:DescCDTime(manager.time:GetNextFreshTime() - manager.time:GetServerTime())))

			return
		else
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("CANTEEN_REFRESH_CONFIRM"),
				OkCallback = function ()
					if uv0.refreshCallBack then
						uv0.refreshCallBack(uv0.pos)
					end
				end,
				CancelCallback = function ()
				end
			})
		end
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.unLockBtn_, slot4, function ()
		if GameSetting.dorm_canteen_task_unlock.value[uv0.pos][2] ~= 0 then
			if IsConditionAchieved(slot0) then
				CanteenAction:UnLockEntrust(uv0.pos)
			else
				ShowTips("NO_REACH_UNLOCK")
			end
		else
			CanteenAction:UnLockEntrust(uv0.pos)
		end
	end)

	for slot4 = 1, 3 do
		slot0:AddToggleListener(slot0["level_" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				if uv0.heroList and #uv0.heroList > 0 then
					return
				end

				uv0:SetTimeLevel(uv1)
			end
		end)
	end
end

function slot0.SetTimeLevel(slot0, slot1)
	slot2 = nil
	slot0.timeLevel = (slot1 == nil or tostring(slot1) == "userdata: NULL" or type(slot1) ~= "number") and 1 or slot1
	slot0["level_" .. slot0.timeLevel .. "Tgl_"].isOn = true

	slot0:RefreshRecommendAward(slot0.entrust.id, slot0.entrust.pos, slot0.timeLevel)

	slot0.tasktimeText_.text = DormTools:MinSwitchTime(BackHomeCanteenTaskCfg[slot0.entrust.id].time[slot0.timeLevel][1])

	CanteenEntrustData:SetTaskTimeLevel(slot0.pos, slot0.timeLevel)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.pos = slot1.pos
	slot0.entrust = slot1

	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.CANTEEN_UNLOCK_ENTRUST, slot0.pos)) then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end

	if slot1.id < 0 then
		slot4, slot5, slot6 = nil

		if GameSetting.dorm_canteen_task_unlock.value[slot0.pos][2] ~= 0 then
			slot4, slot5, slot6 = IsConditionAchieved(slot3)
		else
			slot4 = true
		end

		if slot4 then
			slot0.lockController:SetSelectedState("canUnlock")
		else
			slot0.lockController:SetSelectedState("lock")

			slot0.conditionText_.text = string.format(GetTips("DORM_CANTEEN_TASK_UNLOCK_TIPS"), slot5, slot6)
		end

		return
	end

	slot0.lockController:SetSelectedState("unlock")

	slot0.type = 1
	slot0.refreshTime = CanteenEntrustData:GetEntrustList()[slot0.pos].refresh_times
	slot3 = BackHomeCanteenTaskCfg[slot1.id]
	slot0.ID = slot1.id
	slot0.tasknameText_.text = GetI18NText(slot3.name)
	slot0.characternumText_.text = slot3.need[2]
	slot0.destextText_.text = GetI18NText(slot3.desc)
	slot0.heroList = slot1.hero_list

	for slot7 = 1, 3 do
		slot0["timeText" .. slot7].text = BackHomeCanteenTaskCfg[slot1.id].time[slot7][1] / 60
		slot0["timeTextH" .. slot7].text = string.format("  (%s)", GetTips("HOUR"))
	end

	if #slot0.heroList > 0 then
		slot0.type = 2

		slot0.timeController:SetSelectedState("on")

		slot0.timeText_.text = CanteenEntrustData:GetEntrustLastTime(slot0.pos)
		slot0.statsDecText_.text = GetTips("CANTEEN_DISPATCHED_HERO")
		slot0.hastasknameText_.text = GetI18NText(slot3.name)

		slot0.workController:SetSelectedState("off")
		slot0:SetTimeLevel(slot1.timeLevel)
	else
		slot0.statsDecText_.text = GetTips("CANREEN_RECOMEND_HERO")

		slot0.timeController:SetSelectedState("off")
		slot0.workController:SetSelectedState("on")

		if not slot0.timeLevel then
			slot0.timeLevel = CanteenEntrustData:GetTaskTimeLevel(slot0.pos)
		end

		slot0:SetTimeLevel(slot0.timeLevel)
	end

	slot0.totalReText.text = "/" .. GameDisplayCfg.dorm_canteen_refresh_max.value[1]
	slot0.curReText.text = 1 - slot0.refreshTime

	if slot0.refreshTime > 0 then
		slot0.coolController:SetSelectedState("on")
	end

	slot0.levelController:SetSelectedState(slot3.task_level)
end

function slot0.RefreshTimeMessage(slot0)
	if slot0.type == 2 then
		slot0.timeText_.text = CanteenEntrustData:GetEntrustLastTime(slot0.pos)

		if CanteenEntrustData:GetEntrustLastTime(slot0.pos) == 0 then
			manager.notify:Invoke(CANTEEN_DISPATCH_TIME_OVER)
		end
	end
end

function slot0.RefreshRecommendAward(slot0, slot1, slot2, slot3)
	if slot0.type == 1 then
		slot0.recommendRoleList_ = {}

		for slot8 = 1, #CanteenEntrustData:GetEntrustList()[slot2].tags do
			table.insert(slot0.recommendRoleList_, slot4.tags[slot8])
		end

		slot0.roleuilistScroll_:StartScroll(#slot0.recommendRoleList_)
	elseif slot0.type == 2 then
		slot0.recommendRoleList_ = slot0.heroList

		slot0.roleuilistScroll_:StartScroll(#slot0.recommendRoleList_)
	end

	slot0.roleuilistUilist_:GetComponent("ScrollRectEx").horizontal = false
	slot0.award_list = {}

	for slot8 = 1, #BackHomeCanteenTaskCfg[slot1].reward_list do
		table.insert(slot0.award_list, {
			id = BackHomeCanteenTaskCfg[slot1].reward_list[slot8][1],
			number = math.floor(BackHomeCanteenTaskCfg[slot1].reward_list[slot8][2] * BackHomeCanteenTaskCfg[slot1].time[slot3][2] / 100),
			clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id
				})
			end
		})
	end

	if slot0.oldID ~= slot1 or slot0.oldTimeLevel ~= slot3 then
		slot0.awarduilistScroll_:StartScroll(#slot0.award_list)

		slot0.oldID = slot1
		slot0.oldTimeLevel = slot3
	end
end

function slot0.RegisterConfirmCallBack(slot0, slot1)
	if slot1 then
		slot0.confirmCallBack = slot1
	end
end

function slot0.RegisterCancelCallBack(slot0, slot1)
	if slot1 then
		slot0.cancelCallBack = slot1
	end
end

function slot0.RegisterRefreshCallBack(slot0, slot1)
	if slot1 then
		slot0.refreshCallBack = slot1
	end
end

function slot0.indexRecommendRoleItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.recommendRoleList_[slot1], slot0.type)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:SetData(slot0.award_list[slot1], slot0.type)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.roleuilistScroll_ then
		slot0.roleuilistScroll_:Dispose()
	end

	if slot0.awarduilistScroll_ then
		slot0.awarduilistScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
