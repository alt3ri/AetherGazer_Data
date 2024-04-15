slot0 = singletonClass("CanteenEntrustData")
slot1 = nil
slot2 = {}

function slot0.InitSimpleCanteenEntrustData(slot0, slot1)
	slot0:Init(slot1.canteens[1].entrust)
end

function slot0.InitDetailCanteenEntrustData(slot0, slot1)
	slot0:Init(slot1.canteens[1].entrust)
	slot0:InitTaskTimeLevel()
end

function slot0.DisposeDetailData(slot0)
	saveData("Dorm", "taskTimeLevel", uv0)
end

function slot0.Init(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		slot0:InitEntrustData(slot6)
	end

	for slot6 = 1, #GameSetting.dorm_canteen_task_unlock.value do
		if not uv0[slot6] then
			slot0:InitEntrustData({
				id = -1,
				pos = slot6
			})
		end
	end
end

function slot0.InitTaskTimeLevel(slot0)
	uv0 = {}

	if not getData("Dorm", "taskTimeLevel") or type(slot1) ~= "table" or tostring(slot1) == "userdata: NULL" then
		slot1 = {}
		slot1 = {
			1,
			1,
			1,
			1
		}
	end

	uv0 = slot1
end

function slot0.InitEntrustData(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if ({
		pos = slot1.pos,
		id = slot1.id,
		hero_list = {},
		tags = {}
	}).id > 0 then
		if slot1.hero_list then
			for slot6, slot7 in ipairs(slot1.hero_list) do
				table.insert(slot2.hero_list, slot7)
			end
		end

		for slot6, slot7 in ipairs(slot1.tags) do
			table.insert(slot2.tags, {
				type = slot7.type,
				tag = slot7.tag
			})
		end

		slot2.num_max = slot1.num_max
		slot2.refresh_times = slot1.refresh_times
		slot2.start_time = slot1.start_time

		if slot1.duration == 0 then
			slot2.timeLevel = 0
		else
			slot6 = slot1.id

			for slot6, slot7 in ipairs(BackHomeCanteenTaskCfg[slot6].time) do
				if slot7[1] == slot1.duration then
					slot2.timeLevel = slot6
				end
			end
		end
	end

	uv0[slot1.pos] = slot2
end

function slot0.CalcEntrustLastTime(slot0, slot1)
	if slot1.start_time + BackHomeCanteenTaskCfg[slot1.id].time[slot1.timeLevel][1] * 60 - manager.time:GetServerTime() > 0 then
		slot1.lastTime = slot7

		return manager.time:DescCDTime(slot7)
	else
		slot1.lastTime = 0

		return 0
	end
end

function slot0.GetEntrustLastTime(slot0, slot1)
	if uv0[slot1] and uv1:IsEntrustStarted(slot2) then
		return uv1:CalcEntrustLastTime(slot2)
	end
end

function slot0.GetEntrustList(slot0)
	return uv0
end

function slot0.GetEntrustByPos(slot0, slot1)
	return uv0[slot1]
end

function slot0.CheckHasTimeOverEntrust(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6.id > 0 and #slot6.hero_list > 0 and uv1:CalcEntrustLastTime(slot6) == 0 then
			table.insert(slot1, slot5)
		end
	end

	return slot1
end

slot3 = nil

function slot0.GetDispatchCharacterList(slot0)
	if not uv0 then
		uv0 = {}
	end

	return uv0
end

function slot0.ClearDispatchCharacterList(slot0)
	uv0 = {}
end

slot4 = nil

function slot0.SetCurDispatchTask(slot0, slot1, slot2, slot3)
	if not uv0 then
		uv0 = {}
	end

	uv0.id = slot1
	uv0.pos = slot2
	uv0.timeLevel = slot3
end

function slot0.SetDispatchCharacterList(slot0, slot1)
	slot2 = BackHomeCanteenTaskCfg[uv0.id].need[2]

	if not uv1 then
		uv1 = {}
	end

	if slot2 >= #uv1 then
		for slot7, slot8 in ipairs(uv1) do
			if DormData:GetHeroArchiveID(slot8) == DormData:GetHeroArchiveID(slot1) then
				table.remove(uv1, slot7)

				break
			end
		end

		table.insert(uv1, slot1)
	else
		error("选人列表已满")
	end
end

function slot0.RemoveDispatchCharacterList(slot0, slot1)
	if uv0 then
		for slot5 = 1, #uv0 do
			if uv0[slot5] == slot1 then
				table.remove(uv0, slot5)

				return
			end
		end

		error("没找到需要去处的选择角色")
	end
end

function slot0.CheckDispatchCharacterList(slot0, slot1)
	if uv0 then
		for slot5, slot6 in ipairs(uv0) do
			if slot6 == slot1 then
				return true
			end
		end

		return false
	end
end

function slot0.CheckDispatchCharacterArchiveList(slot0, slot1)
	slot2 = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	if uv0 then
		for slot6, slot7 in ipairs(uv0) do
			if HeroRecordCfg.get_id_list_by_hero_id[slot7][1] == slot2 then
				return true
			end
		end

		return false
	end
end

function slot0.CheckHasChooseEntrustCharacter(slot0, slot1)
	slot2 = HeroRecordCfg.get_id_list_by_hero_id[slot1][1]

	for slot6, slot7 in pairs(uv0) do
		if slot7.hero_list then
			for slot11, slot12 in ipairs(slot7.hero_list) do
				if slot2 == HeroRecordCfg.get_id_list_by_hero_id[slot12][1] then
					return true
				end
			end
		end
	end

	return false
end

function slot0.GetCurDispatchTask(slot0)
	return uv0
end

function slot0.CalculateEntrustSuccess(slot0)
	if #uv0 == 0 then
		return 0
	end

	for slot6, slot7 in ipairs(uv0) do
		slot2 = 0 + slot0:CalHeroMatchNum(slot7, uv1[uv2.pos].tags)
	end

	slot3 = BackHomeCanteenTaskCfg[uv2.id].base_success

	for slot8, slot9 in ipairs(uv0) do
		slot4 = slot2 * BackHomeCanteenTaskCfg[uv2.id].tag_success + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.EntrustExternSucceedAdd, slot9)
	end

	if slot3 + slot4 > 100 then
		slot5 = 100
	end

	return slot5
end

function slot0.CalHeroMatchNum(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(slot2) do
		if slot8.type == 1 then
			if CharactorParamCfg[slot1].RangeType == slot8.tag then
				slot3 = 0 + 1
			end
		elseif slot9 == 2 then
			if HeroCfg[slot1].race == slot8.tag then
				slot3 = slot3 + 1
			end
		elseif slot9 == 3 then
			if HeroCfg[slot1].ATK_attribute[1] == slot8.tag then
				slot3 = slot3 + 1
			end
		elseif slot9 == 4 and HeroCfg[slot1].mechanism_type[1] == slot8.tag then
			slot3 = slot3 + 1
		end
	end

	return slot3
end

function slot0.ConfirmEntrustList(slot0)
	CanteenAction:SendTaskDispatchInfo({
		sceneID = DormData:GetCurrectSceneID(),
		pos = uv0.pos,
		heroList = uv1,
		timeLevel = uv0.timeLevel
	})
end

function slot0.CancelEntrust(slot0, slot1)
	CanteenAction:SendTaskDispatchInfo({
		sceneID = DormData:GetCurrectSceneID(),
		pos = slot1
	})
end

function slot0.ConfirmEntrustListCallBack(slot0, slot1)
	if slot1.hero_list ~= nil then
		for slot5, slot6 in ipairs(slot1.hero_list) do
			table.insert(uv0[slot1.pos].hero_list, slot6)

			slot7 = DormData:GetHeroTemplateInfo(slot6)

			slot7:SetCurHeroID(slot6)
			slot7:GoToCanteen()
		end

		uv0[slot1.pos].start_time = manager.time:GetServerTime()
		uv0[slot1.pos].timeLevel = CanteenTools:GetIndexByTaskDuring(uv0[slot1.pos].id, slot1.duration)
	else
		slot5 = slot1.pos

		for slot5, slot6 in ipairs(uv0[slot5].hero_list) do
			slot7 = DormData:GetHeroTemplateInfo(slot6)

			slot7:SetCurHeroID(slot6)
			slot7:BackToDorm()
		end

		uv0[slot1.pos].hero_list = {}
		uv0[slot1.pos].start_time = nil
		uv0[slot1.pos].timeLevel = 0
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_ENTRUST_SUCCESS, slot1.pos)

	uv1 = {}
	uv2 = {}
end

function slot0.RefreshEntrustData(slot0, slot1)
	if DormConst.DISPATCH_REFRESH_TIME <= uv0[slot1].refresh_times then
		return
	end

	CanteenAction:RefreshEntrust(DormData:GetCurrectSceneID(), slot1)
end

function slot0.EntrustFinish(slot0, slot1, slot2)
	slot0:CalEntrustAward(slot1)

	if slot2 then
		for slot6, slot7 in ipairs(slot2) do
			slot0:InitEntrustData(slot7)
		end
	end

	manager.notify:Invoke(CANTEEN_DISPATCH_REWARD_VIEW)
	DormRedPointTools:ConsumeNotification(RedPointConst.CANTEEN_DISPATCH_FINISHED)
end

slot5 = nil

function slot0.CalEntrustAward(slot0, slot1)
	uv0 = {}

	if slot1 then
		for slot5, slot6 in ipairs(slot1) do
			table.insert(uv0, {
				id = slot6.entrustID,
				award = slot6.rewardList,
				extra_reward = slot6.extra_reward
			})
		end
	end
end

function slot0.GetEntrustFinishAwardList(slot0)
	return uv0
end

function slot0.RefreshDailyZero(slot0)
	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			if slot5.refresh_times then
				slot5.refresh_times = 0
			end
		end
	end
end

function slot0.GetUiPosByEntrustPos(slot0, slot1)
	for slot5, slot6 in ipairs(GameDisplayCfg.canteen_task_id_pos.value) do
		if slot6[2] == slot1 then
			return slot6[1]
		end
	end
end

function slot0.NoEntrustDispatched()
	for slot3, slot4 in pairs(uv0) do
		if uv1:IsEntrustStarted(slot4) then
			return false
		end
	end

	return true
end

function slot0.AnyEntrustFinished()
	for slot3, slot4 in pairs(uv0) do
		if uv1:IsEntrustStarted(slot4) and uv1:CalcEntrustLastTime(slot4) == 0 then
			return true
		end
	end

	return false
end

function slot0.IsEntrustStarted(slot0, slot1)
	return slot1.id ~= -1 and slot1.start_time and slot1.start_time > 0
end

function slot0.SetTaskTimeLevel(slot0, slot1, slot2)
	if uv0 then
		uv0[slot1] = slot2
	end
end

function slot0.GetTaskTimeLevel(slot0, slot1)
	if uv0 then
		if uv0[slot1] and tostring(uv0[slot1]) ~= "userdata: NULL" then
			return tonumber(uv0[slot1])
		else
			return 1
		end
	else
		return 1
	end
end

return slot0
