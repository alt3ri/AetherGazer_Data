slot1, slot2, slot3, slot4 = nil
slot5 = {}
slot6 = false
slot7 = nil

return {
	InitDormVisitData = function (slot0, slot1)
		uv0 = slot1.exhibition_id or 0
	end,
	InitExhibitList = function (slot0)
		uv0 = {}
	end,
	SetListIndex = function (slot0, slot1)
		uv0 = slot1
	end,
	GetListIndex = function (slot0)
		return uv0
	end,
	GetLayoutID = function (slot0)
		return uv0 or 0
	end,
	CheckCurIsVisitRoom = function (slot0)
		if DormData:GetCurrectSceneID() and DormConst.DORM_VISIT_ROOM_MIN < slot1 then
			return true
		end

		return false
	end,
	GetTemplateExhibitList = function (slot0, slot1)
		if not uv0 then
			uv0 = {}
		end

		if not uv0[slot1] then
			DormAction:AskFurTemplateExhibitList(slot1)
		else
			return uv0[slot1]
		end
	end,
	RefreshTemplateExhibit = function (slot0, slot1, slot2)
		uv0[slot2] = {}

		for slot6, slot7 in ipairs(slot1) do
			while true do
				if slot7.architecture_id == 0 then
					break
				end

				uv0[slot2][slot7.user_id] = {
					user_id = slot7.user_id,
					nick = slot7.profile_base.nick,
					level = slot7.level,
					icon = slot7.profile_base.icon,
					iconFrame = slot7.profile_base.icon_frame or 2001,
					architecture_id = slot7.architecture_id,
					furniture_num = slot7.furniture_num,
					likeNum = slot7.liked_num or 0,
					heroIDList = {}
				}

				for slot11, slot12 in ipairs(slot7.hero_id_list) do
					table.insert(uv0[slot2][slot7.user_id].heroIDList, slot12)
				end

				break
			end
		end
	end,
	RefreshCurTemplateExhibit = function (slot0, slot1, slot2, slot3)
		uv0 = {
			userID = slot2
		}
		slot4 = nil
		uv1 = slot1.layout_uid

		if BackHomeCfg[slot1.architecture_id].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot4 = DormConst.DORM_VISIT_LOBBY
		elseif slot5 == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot4 = DormConst.DORM_VISIT_PRIVATE
		end

		slot6 = DormitoryData:GetDormMapList()

		if slot4 then
			slot7 = {}
			uv0.roomInfo = RoomInfo.New()
			uv0.architecture_id = slot1.architecture_id
			uv0.roomInfo.id = slot4
			uv0.roomInfo.sceneName = BackHomeCfg[slot4].scene
			uv0.roomInfo.furnitureInfoS, uv0.specialFur, uv0.suitInfo = DormFurnitureTools:ResolverFurnitureInfo(slot1.furniture_pos_list, slot4)
			uv0.likeNum = slot1.liked_num or 0
			uv0.todayLikeNum = slot1.own_today_liked_num or 0

			if slot1.hero_id_list then
				for slot15, slot16 in ipairs(slot1.hero_id_list) do
					table.insert(slot7, slot16)
				end
			end

			uv0.archiveIDList = slot7

			if not slot3 then
				slot12, uv0.friendType = slot0:GetExhibitListByUserID(slot2)
				slot12.architecture_id = slot1.architecture_id or slot12.architecture_id
				slot12.likeNum = slot1.liked_num or 0
				slot12.heroIDList = slot7

				slot0:SetIsOtherSystem(false)
			else
				slot12 = ForeignInfoData:GetCurForeignDetailInfo()
				slot13 = 2

				if FriendsData:GetInfoByID(slot2) and slot14.relationship == FriendsConst.FRIEND_TYPE.MY_FRIENDS then
					slot13 = 1
				end

				uv0.friendType = slot13
				slot12.backhome_architecture_id = slot1.architecture_id or slot12.backhome_architecture_id
				slot12.hero_id_list = slot7
			end
		end

		slot6[slot4] = uv0
	end,
	CheckCanSaveTemplate = function (slot0)
		if uv0 then
			if uv0.friendType ~= 1 then
				return false, "DORM_NEED_FRIEND_TEMPLATE_COPY"
			else
				return true
			end
		end
	end,
	SetCurTemplateExhibit = function (slot0, slot1)
		uv0 = slot1
	end,
	GetCurTemplateExhibit = function (slot0)
		if uv0 then
			return uv0
		end
	end,
	GetExhibitListByUserID = function (slot0, slot1)
		for slot5, slot6 in pairs(uv0) do
			for slot10, slot11 in pairs(slot6) do
				if slot1 == slot10 then
					return slot11, slot5
				end
			end
		end
	end,
	SetIsOtherSystem = function (slot0, slot1)
		uv0 = slot1
	end,
	GetIsOtherSystem = function (slot0)
		return uv0
	end,
	SetBackFunc = function (slot0, slot1)
		function uv0()
			BackHomeTools:OtherSystemVisitExit()
			uv0()

			uv1 = nil
		end
	end,
	GetBackFunc = function (slot0)
		return uv0
	end,
	GetCurVisitHeroList = function (slot0)
		return uv0.archiveIDList
	end,
	GetCurVisitPlayerType = function (slot0)
		return uv0.friendType
	end,
	GetVisitUserID = function (slot0)
		slot1 = nil

		if uv0 then
			return uv0.userID
		end
	end,
	GetCurVisitRoomData = function (slot0)
		return uv0
	end,
	ClearVisitRoomData = function (slot0)
		if DormitoryData:GetDormMapList()[DormConst.DORM_VISIT_LOBBY] then
			slot1[DormConst.DORM_VISIT_LOBBY] = nil
		end

		if slot1[DormConst.DORM_VISIT_PRIVATE] then
			slot1[DormConst.DORM_VISIT_PRIVATE] = nil
		end

		uv0 = nil
		uv1 = nil
	end,
	GetTodayLikeNum = function (slot0)
		slot1 = 0

		if uv0 then
			slot1 = uv0.todayLikeNum
		end

		return slot1
	end,
	Dispose = function (slot0)
		uv0 = nil
	end
}
