slot0 = singletonClass("DormitoryData")
slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9, slot10 = nil

function slot0.IsUnlockScene(slot0, slot1)
	if slot0:GetDormSceneData(slot1) == nil then
		return false
	end

	return true
end

function slot11(slot0)
	uv0 = slot0 or 0
end

function slot12(slot0)
	uv0 = {}

	for slot4, slot5 in ipairs(slot0.dorm) do
		uv0[slot5.id] = {
			pos_id = slot5.pos_id,
			exp = slot5.exp or 0,
			likeNum = slot5.liked_num or 0,
			archiveIDList = {}
		}

		for slot9, slot10 in ipairs(slot5.archives_id) do
			table.insert(uv0[slot5.id].archiveIDList, slot10)
		end

		uv0[slot5.id].give_furnitures = {}

		if slot5.give_furnitures then
			for slot9, slot10 in ipairs(slot5.give_furnitures) do
				if BackHomeFurniture[slot10.id].is_give == 1 then
					uv0[slot5.id].give_furnitures[slot10.id] = slot10.num
				end
			end
		end

		if BackHomeCfg[slot5.id].type == DormConst.BACKHOME_TYPE.PrivateDorm and uv0[slot5.id].archiveIDList[1] then
			DormData:GetHeroInfo(uv0[slot5.id].archiveIDList[1]):InitHeroRoomID(slot5.id)
		end
	end
end

function slot13(slot0)
	uv0 = {}

	if not uv0 then
		print("地图集合数据为空")
	end

	if slot0 then
		for slot4, slot5 in ipairs(slot0) do
			DormRoomTools:InitNewSingleRoomData(slot5, uv0)
		end

		for slot4, slot5 in pairs(uv0) do
			DormRoomTools:RefreshDormExp(slot4)
		end
	end

	DormData:UpdateAllPlaceFurNumList()
end

function slot14()
	uv0 = getData("Dorm", "feedAllHeroFlag") or false
	uv1 = getData("Dorm", "buyFurCurrencyID")

	if not uv1 then
		uv1 = DormConst.DORM_CURRENCY_ID
	end
end

function slot15()
	DormRedPointTools:SaveFurPlaceRedPointData()
	DormFurnitureTools:SaveFurEditFlag()

	if uv0 then
		saveData("Dorm", "feedAllHeroFlag", uv0)
	end

	if uv1 then
		saveData("Dorm", "buyFurCurrencyID", uv1)
	end
end

function slot16()
	DormFurnitureTemplateData:Dispose()
	DormRoomTools:Dispose()
	DormSuitData:DisposeDormSuitData()
end

function slot17()
	for slot3, slot4 in pairs(uv0) do
		slot4.roomInfo = nil
		slot4.specialFur = nil
	end
end

function slot0.Init(slot0)
	DormVisitTools:InitExhibitList()

	uv0 = {}

	for slot5, slot6 in ipairs(getData("Dorm", "likeInfo") or {}) do
		uv0[slot6.roomID] = slot6.num
	end
end

function slot0.InitSimpleDormInfo(slot0, slot1)
	DormRoomTools:InitDormHasPlaceFurInfo(slot1)
	DormVisitTools:InitDormVisitData(slot1)
	DormFurnitureTemplateData:InitTemplateSimpleDorm(slot1)
	DormSuitData:InitDormSuitList(slot1)
	uv0(slot1)
	uv1(slot1.daily_game_currency_num)
end

function slot0.InitDetialDormData(slot0, slot1)
	DormRoomTools:InitDormHasPlaceFurInfo(slot1)
	DormFurnitureTemplateData:InitDormFurnitureTemplate(slot1)
	DormVisitTools:InitDormVisitData(slot1)
	uv0(slot1.dorms)
	DormFurnitureTools:InitFurEditFlag()
	uv1()
end

function slot0.EnterCurSystem(slot0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Dorm, false)
	DormRedPointTools:EnterDormitorySystem()
	DormSuitData:EnterDormSystem()
end

function slot0.ExitCurSystem(slot0)
	DormTools:SystemStayTime(DormConst.BACKHOME_SYSTEM_TYPE.Dorm, true)

	uv0 = nil
	uv1 = nil

	DormRhythmGameData:Dispose()
	DormRedPointTools:ExitDormitorySystem()
	DormSuitData:ExitDormSystem()
end

function slot0.ExitBackHomeSystem(slot0)
	uv0()
	uv1()
	uv2()
end

function slot0.OtherSystemVisitBack(slot0)
	uv0()
	uv1()
end

function slot0.RefreshDormDailyZero(slot0)
	uv0(0)
end

function slot0.GetDormMapList(slot0)
	if uv0 then
		return uv0
	end

	print("宿舍地图数据不存在")
end

function slot0.GetDormSceneData(slot0, slot1)
	if uv0 and uv0[slot1] then
		return uv0[slot1]
	end
end

function slot0.GetArchiveIDViaRoomID(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1].archiveIDList
	end
end

function slot0.GetDormExp(slot0, slot1)
	if not uv0[slot1].exp then
		uv0[slot1].exp = 0
	end

	return uv0[slot1].exp
end

function slot0.GetDormLevel(slot0, slot1)
	if not slot1 then
		return
	end

	slot2 = nil
	slot4 = 0

	if slot0:GetDormExp(slot1) then
		for slot8, slot9 in ipairs(BackHomeDormLevel.all) do
			if slot3 < BackHomeDormLevel[slot9].exp + slot4 then
				slot2 = slot9

				break
			end
		end

		return slot2 or #BackHomeDormLevel.all
	end
end

function slot0.GetDormArchivesByArchitecture(slot0, slot1)
	slot2 = {}

	if uv0[slot1].archiveIDList then
		for slot6, slot7 in ipairs(uv0[slot1].archiveIDList) do
			table.insert(slot2, slot7)
		end
	end

	return slot2
end

function slot0.GetDormHerosByArchitecture(slot0, slot1)
	slot2 = DormData:GetHeroInfoList()
	slot3 = {}

	if uv0[slot1].archiveIDList then
		for slot7, slot8 in ipairs(uv0[slot1].archiveIDList) do
			table.insert(slot3, slot2[slot8].hero_id)
		end
	end

	return slot3
end

function slot0.GetRoomIDByPosID(slot0, slot1)
	if uv0 then
		for slot5, slot6 in pairs(uv0) do
			if slot6.pos_id == slot1 then
				return slot5
			end
		end
	end
end

function slot0.GetDormFurListByRoomID(slot0, slot1)
	if uv0 and uv0[slot1].roomInfo then
		return uv0[slot1].roomInfo.furnitureInfoS
	else
		print("场景数据缺少roomInfo,场景id为" .. slot1)
	end
end

function slot0.GetAllFeedFlag(slot0)
	return uv0
end

function slot0.GetBuyFurCurrencyID(slot0)
	return uv0
end

function slot0.SetBuyFurCurrencyID(slot0, slot1)
	uv0 = slot1
end

function slot0.GetDailyCurrency(slot0)
	return uv0 or 0
end

function slot0.AddDailCurrencyNum(slot0, slot1)
	uv0 = uv0 + slot1
end

function slot0.SetLastLikeNum(slot0, slot1, slot2)
	if not slot2 and not DormData:GetCurrectSceneID() or not BackHomeCfg[slot2] then
		return
	end

	if not uv0[slot2] then
		uv0[slot2] = 0
	end

	uv0[slot2] = slot1
	slot3 = {}

	for slot7, slot8 in pairs(uv0) do
		table.insert(slot3, {
			roomID = slot7,
			num = slot8
		})
	end

	saveData("Dorm", "likeInfo", slot3)
end

function slot0.GetLastLikeNum(slot0, slot1)
	if not slot1 and not DormData:GetCurrectSceneID() or not BackHomeCfg[slot1] then
		return 0
	end

	if not uv0[slot1] then
		uv0[slot1] = 0
	end

	return uv0[slot1]
end

function slot0.SetAllFeedFlag(slot0, slot1)
	uv0 = slot1
end

function slot0.RevisePrivateDormPosData(slot0, slot1)
	for slot5, slot6 in ipairs(slot1.dorm_pos_list) do
		uv0[slot6.architecture_id].pos_id = slot6.pos_id
	end
end

function slot0.UnLockDormArchitecture(slot0, slot1, slot2)
	DormRoomTools:InitNewSingleRoomData({
		pos_id = slot2,
		id = slot1
	}, uv0, true)

	for slot9, slot10 in ipairs(BackHomeCfg[slot1].default_item) do
		slot11 = DormData:GetFurNumInfo(slot10[1])

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot10[1]) then
			slot11.num = slot11.num + slot10[2]
			slot11.hasPlaceNum = slot11.hasPlaceNum + slot10[2]
		else
			slot11.num = slot11.num + slot10[2]
		end
	end
end

function slot0.FinishDorm(slot0)
end

function slot0.StartNextDayTimer(slot0)
	slot0:StopNextDayTimer()

	uv0 = Timer.New(function ()
		if uv0 < manager.time:GetServerTime() then
			uv1:StopNextDayTimer()
			uv1:UpdatePrivateDormRedPoint()
		end
	end, 1, -1)

	uv0:Start()
end

function slot0.StopNextDayTimer(slot0)
	if uv0 then
		uv0:Stop()

		uv0 = nil
	end
end

function slot0.UpdatePrivateDormRedPoint(slot0)
	if not JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.DORM) then
		for slot5, slot6 in pairs(uv0) do
			if DormTools:ShouldShowBirthdayBtn(slot5) then
				manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT_ROOM .. slot5, 1)
			else
				manager.redPoint:setTip(RedPointConst.DORM_PLACEMENT_ROOM .. slot5, 0)
			end
		end
	end
end

function slot0.HaveWatchedTheatre(slot0, slot1)
	for slot5, slot6 in ipairs(uv0) do
		if slot1 == slot6.id then
			if slot6.timestamp_list[1] ~= nil and tonumber(os.date("!%Y", slot7)) == tonumber(os.date("!%Y", manager.time:GetServerTime())) then
				return true
			end

			break
		end
	end

	return false
end

function slot0.SetTheatreWatched(slot0, slot1)
	if uv0[slot1] == nil then
		table.insert(uv0, {
			id = slot1,
			timestamp_list = {}
		})
	end

	table.insert(slot2.timestamp_list, 1, manager.time:GetServerTime())
end

function slot0.VisitFlag(slot0, slot1)
	uv0 = slot1
end

function slot0.GetFlag(slot0)
	return uv0
end

function slot0.SetFloor(slot0, slot1)
	uv0 = slot1
end

function slot0.GetFloor(slot0)
	return uv0
end

return slot0
