slot0 = singletonClass("WarChessData")
slot1 = 0
slot2, slot3 = nil
slot4 = {}
slot5 = {}
slot6 = {}
slot7, slot8 = nil
slot9 = {}
slot10 = {}
slot11 = nil
slot12 = {}
slot13 = {}
slot14 = 0
slot15 = {}
slot16 = {}
slot17 = 0
slot18 = 0
slot19 = {}
slot20 = {}

function slot0.Init(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = {}
	slot1 = {}
	slot2 = nil
	uv3 = nil
	uv4 = 0
	uv5 = {}
	uv6 = 0
	uv7 = {}
	uv8 = 0
	uv9 = 0
	uv10 = {}
end

function slot0.SetWarChessData(slot0, slot1, slot2)
	slot3 = NewWarChessLevelCfg[slot1]
	uv0 = slot3.activity
	uv1 = ActivityTools.GetMainActivityId(uv0)
	uv2.mapId = slot3.id_level
	uv2.bronPos = {
		x = slot2.pos.x,
		z = slot2.pos.z
	}
	slot4 = {}

	for slot8, slot9 in ipairs(slot2.task) do
		table.insert(slot4, {
			taskID = slot9.id,
			progress = slot9.progress
		})
	end

	uv2.taskList = slot4
	slot5 = {}

	for slot9, slot10 in ipairs(slot2.buff) do
		table.insert(slot5, {
			buffID = slot10.id,
			duration = slot10.duration
		})
	end

	uv2.buffList = slot5
	slot6 = {}

	for slot10, slot11 in ipairs(slot2.global_event) do
		table.insert(slot6, slot11.global_event_id)
	end

	uv2.globalEventList = slot6
	uv3 = {}

	for slot10, slot11 in ipairs(slot2.attribute) do
		uv3[slot11.id] = slot11.value
	end

	uv4 = {}

	for slot10, slot11 in ipairs(slot2.dice) do
		table.insert(uv4, slot11)
	end

	uv5 = nil
	uv6 = {}
	uv7 = 0

	for slot10, slot11 in ipairs(slot2.skill) do
		slot13 = nil

		table.insert(uv6, {
			skillID = slot11.id,
			useLimit = NewWarChessDiceSkillCfg[slot11.id].use_limit ~= 0 and slot12.use_limit - slot11.times or -1,
			skillIndex = uv7
		})

		uv7 = uv7 + 1
	end

	uv8 = {}

	for slot10, slot11 in ipairs(slot2.hero) do
		table.insert(uv8, {
			slot11.id,
			slot11.hp_ratio
		})
	end

	for slot11, slot12 in ipairs(slot2.floor) do
		-- Nothing
	end

	uv2.mapChangeInfo = {
		[NewChessTools.TwoDToOneD(slot12.pos.x, slot12.pos.z)] = {
			tag = slot12.tag,
			pos = {
				x = slot12.pos.x,
				z = slot12.pos.z
			},
			status = slot12.state or 0,
			direction = (slot12.rotation or 0) / 60
		}
	}

	for slot12, slot13 in ipairs(slot2.object) do
		-- Nothing
	end

	uv2.objectChangeInfo = {
		[NewChessTools.TwoDToOneD(slot13.pos.x, slot13.pos.z)] = {
			objecttag = slot13.tag,
			pos = {
				x = slot13.pos.x,
				z = slot13.pos.z
			},
			objectdirection = (slot13.rotation or 0) / 60
		}
	}
	uv2.fogInfo = WarChessTools.DecodeFogInfo(slot2.fog)
	uv2.direction = slot2.direction
	uv2.curChanceID = slot2.choose_list.chance_id
	uv2.curChancePosx = slot2.choose_list.pos.x
	uv2.curChancePosz = slot2.choose_list.pos.z
	uv9 = slot2.choose_list.chance_id
	uv10 = {}

	for slot12, slot13 in ipairs(slot2.choose_list.choose_list) do
		table.insert(uv10, {
			chanceItemID = slot13.id,
			state = slot13.state,
			ispre = slot13.is_pre
		})
	end
end

function slot0.GetCurrentWarChessMapData(slot0)
	return uv0
end

function slot0.GetCurrentWarChessMapID(slot0)
	if uv0.mapId then
		return uv0.mapId
	else
		return slot0:GetTemporaryData("CurEnterMapID")
	end
end

function slot0.GetCurrentActivity(slot0)
	return uv0
end

function slot0.GetCurrentMainActivity(slot0)
	return uv0
end

function slot0.SetExtendMap(slot0, slot1)
	uv0 = slot1
end

function slot0.SetExtendObjectMap(slot0, slot1)
	uv0 = slot1
end

function slot0.SetJsonMap(slot0, slot1)
	uv0 = slot1
end

function slot0.AboutToStart(slot0)
	uv0 = true
end

function slot0.IsAboutToStart(slot0)
	uv0 = false

	return uv0
end

function slot0.GetAttribute(slot0, slot1)
	slot2, slot3 = nil

	if type(slot1) == "string" then
		slot3 = NewWarChessAttributeCfg[slot1].id
	elseif type(slot1) == "number" then
		slot3 = slot1

		for slot7, slot8 in pairs(NewWarChessAttributeCfg) do
			if slot8.id == slot1 then
				slot2 = slot7

				break
			end
		end
	end

	if uv0[slot3] then
		if uv0[slot3] < NewWarChessAttributeCfg[slot2].min then
			return NewWarChessAttributeCfg[slot2].min
		end

		return uv0[slot3]
	else
		return NewWarChessAttributeCfg[slot2].default
	end
end

function slot0.SubAttribute(slot0, slot1, slot2)
	slot3, slot4 = nil

	if type(slot1) == "string" then
		slot4 = NewWarChessAttributeCfg[slot1].id
	elseif type(slot1) == "number" then
		slot4 = slot1

		for slot8, slot9 in pairs(NewWarChessAttributeCfg) do
			if slot9.id == slot1 then
				slot3 = slot8

				break
			end
		end
	end

	if uv0[slot4] then
		uv0[slot4] = uv0[slot4] + slot2
	else
		uv0[slot4] = NewWarChessAttributeCfg[slot3].default + slot2
	end

	if slot3 == "GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT" then
		manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATEMOVEPOINT)
	end
end

function slot0.SetAttribute(slot0, slot1, slot2)
	slot3, slot4 = nil

	if type(slot1) == "string" then
		slot4 = NewWarChessAttributeCfg[slot1].id
	elseif type(slot1) == "number" then
		slot4 = slot1

		for slot8, slot9 in pairs(NewWarChessAttributeCfg) do
			if slot9.id == slot1 then
				slot3 = slot8

				break
			end
		end
	end

	uv0[slot4] = slot2

	if slot3 == "GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT" then
		manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATEMOVEPOINT)
	end

	return uv0[slot4]
end

function slot0.FixCurMapNewDayMovePoint(slot0)
	if uv0 and uv0.mapId then
		slot0:SetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", slot0:GetMovePoint(uv0.mapId))
	end
end

function slot0.SetCurrentIndex(slot0, slot1, slot2)
	if uv0.bronPos.x == slot1 and uv0.bronPos.z == slot2 then
		return false
	end

	uv0.bronPos = {
		x = slot1,
		z = slot2
	}

	return true
end

function slot0.GetCurrentIndex(slot0)
	return uv0.bronPos
end

function slot0.GetCharacterDirection(slot0)
	return uv0.direction
end

function slot0.SetCharacterDirection(slot0, slot1)
	uv0.direction = slot1
end

function slot0.ChangeFogInfo(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		-- Nothing
	end
end

function slot0.ChangeGridLua(slot0, slot1, slot2, slot3)
	slot5 = nil

	if uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] then
		slot5 = (slot3 == 0 or NewChessTools.CreateChessData(slot1, slot2, uv1, slot3)) and NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
		slot4.direction = slot5.direction
		slot4.status = slot5.status
		slot4.attribute = slot5.attribute
	elseif slot3 ~= 0 then
		slot5 = NewChessTools.CreateChessData(slot1, slot2, uv1, slot3)
		slot4 = NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
		slot4.direction = slot5.direction
		slot4.status = slot5.status
		slot4.attribute = slot5.attribute
	else
		slot4 = NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
	end

	slot4.tag = slot3
	uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.ChangeGridLuaInheritDir(slot0, slot1, slot2, slot3)
	slot5 = nil

	if uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] then
		slot5 = (slot3 == 0 or NewChessTools.CreateChessData(slot1, slot2, uv1, slot3)) and NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
		slot4.direction = slot4.direction
		slot4.status = slot5.status
		slot4.attribute = slot5.attribute
	elseif slot3 ~= 0 then
		slot5 = NewChessTools.CreateChessData(slot1, slot2, uv1, slot3)
		slot4 = NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
		slot4.direction = slot4.direction
		slot4.status = slot5.status
		slot4.attribute = slot5.attribute
	else
		slot4 = NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
	end

	slot4.tag = slot3
	uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.ChangeObjectLua(slot0, slot1, slot2, slot3)
	slot5 = nil

	if uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] then
		slot4.objectdirection = ((slot3 == 0 or NewChessTools.CreateChessData(slot1, slot2, uv1, slot3)) and NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))).objectdirection
	elseif slot3 ~= 0 then
		NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2)).objectdirection = NewChessTools.CreateChessData(slot1, slot2, uv1, slot3).objectdirection
	else
		slot4 = NewChessTools.CreateChessData(slot1, slot2, uv2, NewChessTools.TwoDToOneD(slot1, slot2))
	end

	slot4.objecttag = slot3
	uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.DeleteObjectLua(slot0, slot1, slot2)
	if not uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] then
		slot3 = NewChessTools.CreateChessData(slot1, slot2, uv1, NewChessTools.TwoDToOneD(slot1, slot2))
	end

	slot3.objecttag = -1
	slot3.objectdirection = 0
	uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot3
end

function slot0.GetGridLua(slot0, slot1, slot2)
	if not uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] then
		return NewChessTools.CreateChessData(slot1, slot2, uv1, NewChessTools.TwoDToOneD(slot1, slot2))
	end

	return slot3
end

function slot0.ChangeGridDirection(slot0, slot1, slot2, slot3)
	slot4 = uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] or NewChessTools.CreateChessData(slot1, slot2, uv1, NewChessTools.TwoDToOneD(slot1, slot2))
	slot4.direction = math.fmod(slot4.direction + slot3, 6)
	uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.ChangeObjectDirection(slot0, slot1, slot2, slot3)
	slot4 = uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] or NewChessTools.CreateChessData(slot1, slot2, uv1, NewChessTools.TwoDToOneD(slot1, slot2))
	slot4.objectdirection = math.fmod(slot4.objectdirection + slot3, 6)
	uv0.objectChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot4
end

function slot0.GetGridDirection(slot0, slot1, slot2)
	slot3 = uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] or NewChessTools.CreateChessData(slot1, slot2, uv1, NewChessTools.TwoDToOneD(slot1, slot2))
	uv0.mapChangeInfo[NewChessTools.TwoDToOneD(slot1, slot2)] = slot3

	return slot3.direction
end

function slot0.GetDiceContinuousList(slot0)
	if uv0 == nil then
		uv0 = {}

		for slot4, slot5 in pairs(uv1) do
			table.insert(uv0, {
				slot5
			})
		end
	end

	return uv0
end

function slot0.ClearDiceContinuousList(slot0)
	uv0 = nil
end

function slot0.ClearAniCache(slot0)
	for slot4, slot5 in pairs(uv0) do
		slot5.IsNew = false
	end
end

function slot0.ReCacheDiceData(slot0)
	uv0 = {}

	for slot4, slot5 in pairs(uv1) do
		table.insert(uv0, {
			slot5
		})
	end
end

function slot0.CheckDiceNum(slot0)
	if slot0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_DICE_MAX") <= slot0:GetDiceNum() then
		return true
	end

	return false
end

function slot0.AddDice(slot0, slot1)
	table.insert(uv0, slot1)
	table.insert(uv1, {
		slot1,
		IsNew = true
	})
end

function slot0.RemoveDice(slot0, slot1)
	for slot5, slot6 in pairs(slot1) do
		slot7 = false

		for slot11, slot12 in pairs(uv0) do
			if slot12 == slot6 then
				uv0[slot11] = 0
				slot7 = true

				break
			end
		end

		if not slot7 then
			print("lrq 移除了当前没有的骰子！！！")
		end
	end

	slot2 = {}

	for slot6, slot7 in pairs(uv0) do
		if slot7 ~= 0 then
			table.insert(slot2, slot7)
		end
	end

	uv0 = slot2
	uv1 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function slot0.GetDiceNum(slot0)
	return #uv0
end

function slot0.RemoveFrontDice(slot0, slot1)
	slot2 = {}

	for slot6 = slot1 + 1, #uv0 do
		table.insert(slot2, uv0[slot6])
	end

	uv0 = slot2
	uv1 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function slot0.SubDiceListNum(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		uv0[slot5] = slot6 + slot1

		if uv0[slot5] > 6 then
			uv0[slot5] = 6
		end

		if uv0[slot5] < 1 then
			uv0[slot5] = 1
		end
	end

	uv1 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function slot0.RemoveAllDice(slot0)
	uv0 = {}
	uv1 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function slot0.SetAllDice(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		uv0[slot5] = slot1
	end

	uv1 = nil

	manager.notify:CallUpdateFunc(NEWWARCHESS_DICE_UPDATE)
end

function slot0.AddNewSkill(slot0, slot1)
	slot3 = nil

	table.insert(uv0, {
		skillID = slot1,
		useLimit = (NewWarChessDiceSkillCfg[slot1].use_limit == 0 or slot2.use_limit) and -1
	})
end

function slot0.GetSkillList(slot0)
	return uv0
end

function slot0.UseSkill(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6.skillID == slot1 then
			if slot6.useLimit <= 0 then
				Debug.LogError("该技能使用次数为0")
			else
				slot6.useLimit = slot6.useLimit - 1
			end
		end
	end
end

function slot0.AddAllSkillCount(slot0)
	for slot4, slot5 in pairs(uv0) do
		if NewWarChessDiceSkillCfg[slot5.skillID].use_limit ~= 0 then
			slot5.useLimit = slot6.use_limit
		else
			slot5.useLimit = -1
		end
	end
end

function slot0.GetSkillInfo(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6.skillID == slot1 then
			return slot6
		end
	end

	return 0
end

function slot0.AddNewHero(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot1 == slot6[1] then
			return false
		end
	end

	table.insert(uv0, {
		slot1,
		NewChessConst.HERO_HP_RATE
	})

	return true
end

function slot0.SetServerHeroList(slot0, slot1)
	uv0 = slot1
end

function slot0.GetHeroInfoList(slot0)
	return uv0
end

function slot0.GetHeroInfo(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot1 == slot6[1] then
			return slot6
		end
	end
end

function slot0.GetHeroHp(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot1 == NewWarChessHeroCfg[slot6[1]].hero_id then
			return slot6[2]
		end
	end

	return NewChessConst.HERO_HP_RATE
end

function slot0.SubAllHeroHp(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		slot6[2] = slot6[2] + slot1

		if slot6[2] < 0 then
			slot6[2] = 0
		end

		if NewChessConst.HERO_HP_RATE < slot6[2] then
			slot6[2] = NewChessConst.HERO_HP_RATE
		end
	end
end

function slot0.CheckIsAllDie(slot0)
	for slot4, slot5 in pairs(uv0) do
		if slot5[2] > 0 then
			return false
		end
	end

	return true
end

function slot0.GetHeroIDList(slot0)
	slot1 = {}

	for slot6, slot7 in pairs(NewWarChessData:GetHeroInfoList()) do
		table.insert(slot1, NewWarChessHeroCfg[slot7[1]].temp_id)
	end

	return slot1
end

function slot0.GetCurChanceID(slot0)
	uv0 = 0

	return uv0, uv1.curChancePosx, uv1.curChancePosz
end

function slot0.SetChanceInfo(slot0, slot1, slot2)
	uv0 = slot1
	uv1 = slot2
end

function slot0.GetChanceItemState(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6.chanceItemID == slot1 then
			return slot6
		end
	end
end

function slot0.GetCurChanceItemList(slot0)
	return uv0
end

function slot0.GetServerChanceID(slot0)
	uv0 = 0

	return uv0
end

function slot0.AddServerEvent(slot0, slot1)
	table.insert(uv0, slot1)
end

function slot0.GetServerEvent(slot0, slot1, slot2)
	slot3 = 0

	for slot7, slot8 in pairs(uv0) do
		if slot1 == slot8.timing then
			if (slot1 == NewChessConst.TIMING_WALK_OUT or slot1 == NewChessConst.TIMING_WALK_INTO or slot1 == NewChessConst.TIMING_INTERACT or slot1 == NewChessConst.TIMING_WALK_OUT_OBJECT or slot1 == NewChessConst.TIMING_WALK_INTO_OBJECT or slot1 == NewChessConst.TIMING_INTERACT_OBJECT or slot1 == NewChessConst.TIMING_FARCLICK_OBJECT) and slot2[1] == slot8.timingParams[1] and slot2[2] == slot8.timingParams[2] then
				slot3 = slot7

				break
			end

			if (slot1 == NewChessConst.TIMING_CHANCE_CHOOSE or slot1 == NewChessConst.TIMING_BUFF or slot1 == NewChessConst.TIMING_TASK or slot1 == NewChessConst.TIMING_GLOBAL_EVENT) and slot2[1] == slot8.timingParams[1] then
				slot3 = slot7

				break
			end

			if slot1 == NewChessConst.TIMING_START then
				slot3 = slot7

				break
			end
		end
	end

	if slot3 ~= 0 then
		uv0[slot3] = nil

		return uv0[slot3].eventList
	end

	print("lrq 触发了服务端没下发的事件！！timing:", slot1)
	trace("timingParams %o", slot2)

	return nil
end

function slot0.SetTemporaryData(slot0, slot1, slot2)
	uv0[slot1] = slot2
end

function slot0.GetTemporaryData(slot0, slot1, slot2)
	uv0[slot1] = nil

	return uv0[slot1]
end

slot21 = {}

function slot0.SetSystemServerData(slot0, slot1)
	uv0 = {}

	if slot1.value_list then
		for slot5, slot6 in ipairs(slot1.value_list) do
			uv0[slot6.chapter_id] = {
				exploreValue = slot6.explore_value,
				movePoint = slot6.move_value,
				isFinish = slot6.is_finish,
				getRewardLevelList = cleanProtoTable(slot6.value_list)
			}
		end
	end
end

function slot0.GetExploreValue(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].exploreValue
	else
		return 0
	end
end

function slot0.GetMovePoint(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].movePoint
	else
		return NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default
	end
end

function slot0.GetRewardIsGet(slot0, slot1, slot2)
	if uv0[slot1] then
		if table.indexof(uv0[slot1].getRewardLevelList, slot2) then
			return true
		else
			return false
		end
	else
		return false
	end
end

function slot0.SetCurMapExploreValue(slot0, slot1, slot2)
	if uv0[slot1] then
		uv0[slot1].exploreValue = slot2
	else
		uv0[slot1] = {
			isFinish = 0,
			exploreValue = slot2,
			movePoint = NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default,
			getRewardLevelList = {}
		}
	end
end

function slot0.ReceiveReward(slot0, slot1, slot2)
	if uv0[slot1] then
		table.insert(uv0[slot1].getRewardLevelList, slot2)
	else
		uv0[slot1] = {
			exploreValue = 0,
			isFinish = 0,
			movePoint = NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.default,
			getRewardLevelList = {
				slot2
			}
		}
	end
end

function slot0.GetLevelIsFinish(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].isFinish
	else
		return false
	end
end

function slot0.SaveDataToSystem(slot0)
	if uv1[uv0.mapId] == nil then
		uv1[slot1] = {
			movePoint = 0,
			exploreValue = 0,
			isFinish = 0,
			getRewardLevelList = {}
		}
	end

	uv1[slot1].movePoint = slot0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT")

	if uv1[slot1].isFinish == 0 and slot0:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FINISH") == 1 then
		for slot6, slot7 in pairs(NewWarChessLevelCfg.all) do
			if NewWarChessLevelCfg[slot7].front_level_id == slot1 then
				manager.redPoint:setTip(RedPointConst.NEW_WARCHESS_NEWMAP .. "_" .. ActivityConst.ACTIVITY_NEWWARCHESS_2_6, 1)

				break
			end
		end
	end

	uv1[slot1].isFinish = slot2
end

return slot0
