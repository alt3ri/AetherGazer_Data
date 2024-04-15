require("game.data.DormDataTemplate")

slot0 = import("game.dorm.DormEnum")
slot1 = singletonClass("DormData")
slot2, slot3, slot4, slot5 = nil

function slot1.InitSimplaDormData(slot0, slot1)
	uv0:InitHeroInfo(slot1)
	BackHomeNpcData:InitNpcInfo(slot1)
	uv0:InitFurnitureInfoList(slot1.furnitures)
end

function slot1.InitDetailDormData(slot0, slot1)
	uv0:InitFurnitureInfoList(slot1.furnitures)
end

function slot1.RefreshDailyZero(slot0)
	if uv0 then
		for slot4, slot5 in pairs(uv0) do
			slot5:ResetFeedTime()
		end
	end
end

function slot1.Init(slot0)
	uv0 = false
	uv1 = nil
end

function slot1.InitHeroInfo(slot0, slot1)
	uv0 = {}

	if slot1.backhome_hero then
		for slot5, slot6 in ipairs(slot1.backhome_hero) do
			if DormHeroTools:GetTemplateIDInDorm(slot6.archives_id) then
				uv0[slot6.archives_id] = DormHeroTemplate.New({
					archives_id = slot6.archives_id,
					hero_id = slot6.hero_id,
					feed_times = slot6.feed_times or 0,
					fatigue = slot6.fatigue,
					totalFeedTime = slot6.total_feed_times
				})
			end
		end
	end

	if slot1.hero_setting then
		for slot5, slot6 in ipairs(slot1.hero_setting) do
			slot7 = slot6.hero_id

			uv0[HeroRecordCfg.get_id_list_by_hero_id[slot7][1]]:SetHeroSkinID(slot7, slot6.skin_id)
		end
	end
end

function slot1.GetHeroInfoList(slot0)
	return uv0
end

function slot1.GetHeroInfo(slot0, slot1)
	if uv0 and DormHeroTools:GetTemplateIDInDorm(slot1) then
		if not uv0[slot1] then
			if DormHeroTools:GetAllCanUseHeroIDInDorm(slot1)[1] then
				uv0[slot1] = DormHeroTemplate.New({
					archives_id = slot1
				})
			end
		end

		return uv0[slot1]
	else
		print(string.format("后宅不存在档案id为%s的可用角色", tostring(slot1)))
	end
end

function slot1.GetHeroTemplateInfo(slot0, slot1)
	return slot0:GetHeroInfo(slot0:GetHeroArchiveID(slot1))
end

function slot1.GetCharacterInfo(slot0, slot1)
	if DormNpcTools:CheckIDIsNpc(slot1) then
		return BackHomeNpcData:GetBackHomeNpcInfoList()[slot1]
	else
		return uv0:GetHeroTemplateInfo(slot1)
	end
end

function slot1.GetHeroFatigue(slot0, slot1)
	if slot0:GetHeroInfo(slot0:GetHeroArchiveID(slot1)) then
		return slot3.fatigue
	else
		return 0
	end
end

function slot1.SetHeroFatigue(slot0, slot1, slot2)
	slot3 = slot0:GetHeroArchiveID(slot1)

	if not uv0 then
		uv0 = {}
	end

	if DormHeroTools:GetTemplateIDInDorm(slot3) then
		if not uv0[slot3] then
			uv0[slot3] = DormHeroTemplate.New({
				archives_id = slot3
			})
		end

		uv0[slot3]:SetFatigue(slot2)
	else
		print(string.format("后宅不存在档案id为%s的可用角色", tostring(slot3)))
	end
end

function slot1.GetHeroArchiveID(slot0, slot1)
	if HeroRecordCfg.get_id_list_by_hero_id[slot1] then
		return HeroRecordCfg.get_id_list_by_hero_id[slot1][1]
	end

	return slot1
end

function slot1.RefreshInDormHeroInfo(slot0, slot1, slot2, slot3)
	if not slot1 or not slot2 then
		return
	end

	slot5 = slot0:GetHeroInfoList()

	if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		DormitoryData:GetDormSceneData(slot1).archiveIDList = {}

		for slot9, slot10 in ipairs(slot2) do
			slot11 = DormData:GetHeroArchiveID(slot10)
			slot12 = slot0:GetHeroTemplateInfo(slot11)

			slot12:SetCurHeroID(slot10)

			slot12.dancePos = nil

			table.insert(slot4.archiveIDList, slot11)
			slot5[slot11]:ResetHeroSkill()
		end
	elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		if slot4.archiveIDList[1] ~= DormData:GetHeroArchiveID(slot2[1]) and slot4.archiveIDList and #slot4.archiveIDList > 0 then
			print("该房间已被其他角色使用")

			return
		end

		slot4.archiveIDList = {}

		table.insert(slot4.archiveIDList, slot7)

		slot8 = slot0:GetHeroTemplateInfo(slot7)

		if not slot3 then
			slot8:SetCurHeroID(slot6)

			slot8.dancePos = nil
		end

		slot5[slot7]:ResetHeroSkill()
	end
end

function slot1.SetCurrentScene(slot0, slot1)
	uv0 = slot1
end

function slot1.GetCurrectSceneID(slot0)
	return uv0
end

function slot1.GetDormSceneData(slot0, slot1)
	if slot1 then
		if BackHomeCfg[slot1] then
			if slot2.type == DormConst.BACKHOME_TYPE.Canteen then
				return CanteenData:GetCanteenSceneData()
			elseif slot3 == DormConst.BACKHOME_TYPE.PublicDorm or slot3 == DormConst.BACKHOME_TYPE.PrivateDorm or slot3 == DormConst.BACKHOME_TYPE.VISITPUBLICDORM or slot3 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
				return DormitoryData:GetDormMapList()[slot1]
			end
		else
			Debug.LogError("不存在" .. slot1 .. "场景的配置信息")
		end
	else
		Debug.LogError("id为空")
	end
end

function slot1.GetDormSceneDataList(slot0, slot1)
	if slot1 == uv0.DormSystemType.Canteen then
		return {
			CanteenData:GetCanteenSceneData()
		}
	elseif slot1 == uv0.DormSystemType.Dormitory then
		return DormitoryData:GetDormMapList()
	end
end

function slot1.InitFurnitureInfoList(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6.furniture_id] = {
			num = slot6.num,
			give_num = slot6.give_num or 0,
			hasPlaceNum = 0
		}
	end
end

function slot1.GetFurnitureInfoList(slot0)
	return uv0
end

function slot1.GetFurNumInfo(slot0, slot1)
	if not uv0 then
		uv0 = {}
	end

	if uv0[slot1] then
		return uv0[slot1]
	else
		uv0[slot1] = {
			hasPlaceNum = 0,
			num = 0,
			give_num = 0
		}

		return uv0[slot1]
	end
end

function slot1.AddFurTotalNum(slot0, slot1, slot2, slot3)
	if uv0 then
		slot4 = slot0:GetFurNumInfo(slot1)
		slot4.num = slot2
		slot4.give_num = slot3
	end

	if BackHomeFurniture[slot1].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.SPECIFY and DormRoomTools:GetDormIDViaArchive(BackHomeFurniture[slot1].hero_id) then
		DormRoomTools:RefreshDormExp(slot5, slot1, slot2)

		if DormitoryData:GetDormLevel(slot5) ~= DormitoryData:GetDormLevel(slot5) then
			DormRoomTools:GetDormLevelAward(slot4, slot6, slot7)
			manager.notify:Invoke(DORM_PRIVATE_LEVEL_UP, slot5, slot4)
		end
	end
end

function slot6()
	for slot3, slot4 in pairs(uv0) do
		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot3) then
			slot4.hasPlaceNum = 0
		end
	end

	for slot4, slot5 in pairs(DormitoryData:GetDormMapList()) do
		slot6, slot7 = DormFurnitureTools:GetHasPlaceFurNumInfoInMap(slot4)

		for slot11, slot12 in pairs(slot7) do
			if not uv0[slot11] then
				uv0[slot11] = {
					hasPlaceNum = 0,
					num = 0,
					give_num = 0
				}
			end

			if not uv0[slot11].hasPlaceNum then
				uv0[slot11].hasPlaceNum = 0
			end

			uv0[slot11].hasPlaceNum = uv0[slot11].hasPlaceNum + slot12
		end
	end
end

function slot7()
	slot0 = DormitoryData:GetDormMapList()

	for slot4, slot5 in pairs(uv0) do
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot4) then
			slot5.hasPlaceNum = 0
		end
	end

	for slot4, slot5 in pairs(slot0) do
		for slot10, slot11 in pairs(slot0[slot4].specialFur) do
			if not uv0[slot11] then
				uv0[slot11] = {
					hasPlaceNum = 0,
					num = 0,
					give_num = 0
				}
			end

			uv0[slot11].hasPlaceNum = uv0[slot11].hasPlaceNum + 1
		end
	end
end

function slot8()
	for slot4, slot5 in pairs(DormitoryData:GetDormMapList()) do
		for slot10, slot11 in pairs(slot0[slot4].suitInfo) do
			if DormSuitData:GetNeedUseFurNumInfoBySuitID(slot10) then
				for slot16, slot17 in ipairs(slot12) do
					if not uv0[slot17[1]] then
						uv0[slot17[1]] = {
							hasPlaceNum = 0,
							num = 0,
							give_num = 0
						}
					end

					uv0[slot17[1]].hasPlaceNum = uv0[slot17[1]].hasPlaceNum + slot17[2]
				end
			else
				for slot16 = 0, slot11.furList.Length - 1 do
					if not uv0[slot11.furList[slot16].id] then
						uv0[slot17.id] = {
							hasPlaceNum = 0,
							num = 0,
							give_num = 0
						}
					end

					uv0[slot17.id].hasPlaceNum = uv0[slot17.id].hasPlaceNum + 1
				end
			end
		end
	end
end

function slot1.UpdateAllPlaceFurNumList(slot0)
	uv0()
	uv1()
	uv2()
end

function slot1.ChangeDevModelFlag(slot0, slot1)
	if Application.isEditor then
		uv0 = slot1
	end
end

function slot1.GetDevModelFlag(slot0)
	if Application.isEditor then
		return uv0
	end
end

return slot1
