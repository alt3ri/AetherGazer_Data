DormHeroTemplate = class("DormDataTemplate")

function DormHeroTemplate.Ctor(slot0, slot1)
	slot2 = DormHeroTools:GetAllCanUseHeroIDInDorm(slot1.archives_id)[1]

	if not slot1.hero_id then
		if slot2 then
			slot0.hero_id = slot2
		else
			print(debug.traceback("无可用人物,档案id为" .. slot1.archives_id))

			return
		end
	else
		slot0.hero_id = slot1.hero_id
	end

	slot0.fatigue = slot1.fatigue or GameSetting.canteen_hero_fatigue_max.value[1]
	slot0.feed_times = slot1.feed_times or 0
	slot0.archives_id = slot1.archives_id
	slot0.feedTotalTime = slot1.totalFeedTime or 0

	slot0:InitHeroSkinData(slot1.skinID)
end

function DormHeroTemplate.InitHeroSkinData(slot0, slot1)
	slot0.skinInfo = {}

	for slot6, slot7 in ipairs(slot0:GetCanUseHeroList()) do
		slot0.skinInfo[slot7] = slot7
	end

	if slot1 then
		for slot6, slot7 in ipairs(slot1) do
			if slot0.skinInfo[slot7.hero_id] then
				slot0.skinInfo[slot8] = slot7.skin_id
			else
				print("未找到对应角色")
			end
		end
	end
end

function DormHeroTemplate.InitHeroRoomID(slot0, slot1)
	slot0.roomID = slot1
end

function DormHeroTemplate.Dispose(slot0)
end

function DormHeroTemplate.GetHeroId(slot0)
	if BackHomeHeroCfg[slot0.hero_id] then
		return slot0.hero_id
	elseif #slot0:GetCanUseHeroList() > 0 then
		return slot1[1]
	end
end

function DormHeroTemplate.GetHeroTotalFeedTime(slot0)
	return slot0.feedTotalTime
end

function DormHeroTemplate.GetRoomID(slot0)
	return slot0.roomID
end

function DormHeroTemplate.SetCurHeroID(slot0, slot1)
	if slot1 == nil then
		slot0.hero_id = nil

		return
	end

	if slot0.archives_id == DormData:GetHeroArchiveID(slot1) then
		slot0.hero_id = slot1
	else
		print("传入角色id不是本档案角色")
	end
end

function DormHeroTemplate.GetHeroCurSkinID(slot0, slot1)
	if slot0.skinInfo then
		if not slot0.skinInfo[slot1] and DormData:GetHeroArchiveID(slot1) == slot0.archives_id and BackHomeHeroCfg[slot1] and HeroTools.GetHeroIsUnlock(slot1) then
			slot0.skinInfo[slot1] = slot1
		end

		if slot0.skinInfo[slot1] then
			return slot0.skinInfo[slot1]
		end
	end

	return slot1
end

function DormHeroTemplate.SetHeroSkinID(slot0, slot1, slot2)
	if slot0.skinInfo then
		slot0.skinInfo[slot1] = slot2
	end
end

function DormHeroTemplate.GetCanUseHeroList(slot0)
	return DormHeroTools:GetAllCanUseHeroIDInDorm(slot0.archives_id) or {}
end

function DormHeroTemplate.GetFatigue(slot0)
	return slot0.fatigue
end

function DormHeroTemplate.SetFatigue(slot0, slot1)
	if slot1 < 0 then
		print("设置体力越界")

		return
	end

	slot0.fatigue = slot1

	slot0:UpdataHeroState()
end

function DormHeroTemplate.CalFatigue(slot0, slot1)
	slot0.fatigue = slot0.fatigue + slot1

	if slot0.fatigue < 0 then
		slot0.fatigue = 0
	end

	slot0:UpdataHeroState()
end

function DormHeroTemplate.UpdataHeroState(slot0)
	slot1 = GameSetting.dorm_canteen_work_fatigue.value[1] / 100

	if slot0.fatigue < slot1 - slot1 % 0.1 then
		if slot0.jobType then
			slot0.jobType = nil
		end

		slot0:BackToDorm()
	end
end

function DormHeroTemplate.GetRecoverFatigueNum(slot0)
	slot3 = 3600 / GameSetting.dorm_fatigue_time.value[1]

	if slot0:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or slot1 == DormEnum.DormHeroState.InCanteenJob then
		return 0
	elseif slot1 == DormEnum.DormHeroState.OutDorm then
		return GameSetting.dorm_base_fatigue_increase.value[1] / 100
	elseif slot1 == DormEnum.DormHeroState.InPublicDorm then
		slot4 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
		slot5 = 0

		if slot0.hero_id then
			slot5 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
		end

		return slot4 * (100 + slot5) / 100 * slot3
	elseif slot1 == DormEnum.DormHeroState.InPrivateDorm then
		slot5 = GameSetting.dorm_fatigue_increase.value[DormHeroTools:GetDormLevelByHeroID(slot0.archives_id)][2] / 100
		slot6 = 0

		if slot0.hero_id then
			slot6 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
		end

		return slot5 * (100 + slot6) / 100 * slot3
	elseif slot1 == DormEnum.DormHeroState.InIdolTraineeCamp then
		if slot0.roomID then
			slot5 = GameSetting.dorm_fatigue_increase.value[DormHeroTools:GetDormLevelByHeroID(slot0.archives_id)][2] / 100
			slot6 = 0

			if slot0.hero_id then
				slot6 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
			end

			return slot5 * (100 + slot6) / 100 * slot3
		else
			slot4 = GameSetting.dorm_lobby_fatigue_increase.value[1] / 100
			slot5 = 0

			if slot0.hero_id then
				slot5 = DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverSelfFast, slot0.hero_id) + DormSkillData:GetSkillEffect(CanteenConst.HeroSkillType.FatigueRecoverAllFast, slot0.hero_id)
			end

			return slot4 * (100 + slot5) / 100 * slot3
		end
	else
		return 0
	end

	print("人物处于未知状态")
end

function DormHeroTemplate.GetCurRoomID(slot0)
	if slot0:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or slot1 == DormEnum.DormHeroState.InCanteenJob then
		return DormConst.CANTEEN_ID
	end

	if slot1 == DormEnum.DormHeroState.InPublicDorm then
		return DormConst.PUBLIC_DORM_ID
	elseif slot1 == DormEnum.DormHeroState.InPrivateDorm then
		return DormRoomTools:GetDormIDViaArchive(slot0.archives_id)
	end

	return nil
end

function DormHeroTemplate.GetHeroState(slot0)
	slot1 = DormRoomTools:GetDormIDViaArchive(slot0.archives_id)

	if slot0.dancePos then
		return DormEnum.DormHeroState.InIdolTraineeCamp
	end

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(slot0.archives_id) then
		return DormEnum.DormHeroState.InCanteenEntrust
	end

	if slot0.jobType then
		return DormEnum.DormHeroState.InCanteenJob
	end

	if DormConst.PUBLIC_DORM_ID then
		for slot7, slot8 in ipairs(DormData:GetDormSceneData(slot2).archiveIDList) do
			if slot8 == slot0.archives_id then
				return DormEnum.DormHeroState.InPublicDorm
			end
		end

		if slot1 then
			return DormEnum.DormHeroState.InPrivateDorm
		end

		return DormEnum.DormHeroState.OutDorm
	end
end

function DormHeroTemplate.GetHeroFavorability(slot0)
	return ArchiveData:GetArchive(slot0.archives_id).lv
end

function DormHeroTemplate.GetGiftNum(slot0, slot1)
	if DormitoryData:GetDormSceneData(DormRoomTools:GetDormIDViaArchive(slot0.archives_id)) and slot3.give_furnitures then
		return slot3.give_furnitures[slot1] or 0
	else
		return 0
	end
end

function DormHeroTemplate.GetCanGiftNum(slot0, slot1)
	slot2 = 0

	if DormRoomTools:GetDormIDViaArchive(slot0.archives_id) then
		slot4 = slot0:GetGiftNum(slot1)
		slot5 = DormData:GetFurNumInfo(slot1).num
		slot6 = DormData:GetFurNumInfo(slot1).give_num
		slot7 = BackHomeFurniture[slot1].give_max

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot1) then
			slot7 = 1
		end

		if math.min(slot5 - slot6, slot7 - slot4) < 0 then
			slot2 = 0
		end
	end

	return slot2
end

function DormHeroTemplate.GetCanBuyAndGiftNum(slot0, slot1)
	slot2 = 0

	if DormRoomTools:GetDormIDViaArchive(slot0.archives_id) then
		slot4 = slot0:GetGiftNum(slot1)
		slot5 = BackHomeFurniture[slot1].give_max

		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot1) then
			slot5 = 1
		end

		if math.min(slot5, slot5 - slot4) < 0 then
			slot2 = 0
		end
	end

	return slot2
end

function DormHeroTemplate.CheckCanFeedFood(slot0)
	if GameSetting.dorm_feed_max.value[1] <= slot0.feed_times then
		return false, "feedTime"
	end

	if GameSetting.canteen_hero_fatigue_max.value[1] < slot0.fatigue then
		return false, "fatigue"
	end

	if DormHeroTools:GetDormLevelByHeroID(slot0.archives_id) < GameSetting.dorm_menu_feed_unlock.value[1] then
		return false, "unlock"
	end

	return true
end

function DormHeroTemplate.ResetFeedTime(slot0)
	slot0.feed_times = 0
end

function slot0(slot0)
	if type(slot0) == "number" then
		return slot0, 1
	else
		return slot0[1], slot0[2]
	end
end

function DormHeroTemplate.PickInteractAction(slot0)
	if slot0 and next(slot0) then
		for slot5, slot6 in ipairs(slot0) do
			slot7, slot8 = uv0(slot6)
			slot1 = 0 + slot8
		end

		for slot6, slot7 in ipairs(slot0) do
			slot8, slot9 = uv0(slot7)

			if math.random() * slot1 - slot9 < 0 then
				return slot8
			end
		end
	end

	return nil
end

function DormHeroTemplate.FeedFood(slot0, slot1, slot2)
	slot0.feed_times = slot0.feed_times + 1
	slot0.feedTotalTime = slot0.feedTotalTime + 1

	if slot1 and not Dorm.DormEntityManager.TestDuringInteract(slot1, true) then
		slot3 = nil

		if slot2 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(slot1, slot1, slot2, false)

			if DormCharacterInteractBehaviour.GetSequence(slot0:GetHeroCurSkinID(slot0.hero_id), nil, DormInteractSequence[slot2].name) then
				slot3 = slot6.duration
			end
		end

		DormUtils.ClearSingleSpecialVfx(slot1, DormEnum.SpecialVfx.Hungry)

		return slot3
	end
end

function DormHeroTemplate.GiftFur(slot0, slot1, slot2, slot3)
	if slot1 and slot2 then
		if not DormData:GetDormSceneData(DormRoomTools:GetDormIDViaArchive(slot0.archives_id)).give_furnitures then
			slot5.give_furnitures = {}
		end

		if not slot5.give_furnitures[slot1] then
			slot5.give_furnitures[slot1] = 0
		end

		slot5.give_furnitures[slot1] = slot5.give_furnitures[slot1] + slot2
		slot6 = DormData:GetFurnitureInfoList()
		slot6[slot1].give_num = slot6[slot1].give_num + slot2

		if slot6[slot1].num < slot6[slot1].give_num then
			print("家具礼物数量大于拥有数量")
		end

		if slot3 then
			Dorm.DormEntityManager.SendInteractToEntityCMD(slot3, slot3, DormHeroTemplate.PickInteractAction(GameDisplayCfg.dorm_interaction_gift.value), false)
		end
	else
		Debug.LogError("赠送家具id或数量为空")
	end
end

function DormHeroTemplate.TouchHero(slot0, slot1, slot2)
	Dorm.DormEntityManager.SendInteractToEntityCMD(slot1, slot1, slot2, false)

	if slot0.hero_id then
		SDKTools.SendMessageToSDK("backhome_dorm_stroke", {
			hero_id = slot0.hero_id
		})
	end

	slot6 = nil

	if DormCharacterInteractBehaviour.GetSequence(slot0:GetHeroCurSkinID(slot0.hero_id), nil, DormInteractSequence[slot2].name) then
		slot6 = slot5.duration
	end

	return slot6
end

function DormHeroTemplate.BackToDorm(slot0)
	slot0.jobType = nil
	slot0.dancePos = nil

	if slot0:GetHeroState() == DormEnum.DormHeroState.InPublicDorm or slot1 == DormEnum.DormHeroState.InPrivateDorm then
		return
	end

	if DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID) then
		if slot3.archiveIDList then
			if not DormRoomTools:GetDormIDViaArchive(slot0.archives_id) and #slot4 < GameSetting.dorm_lobby_hero_max.value[1] then
				table.insert(slot4, slot0.archives_id)
			end
		end

		slot0:ResetHeroSkill()
		CanteenHeroTools:RefreshCanteenJobList()
	end

	slot0:ResetHeroSkill()
end

function DormHeroTemplate.GoToCanteen(slot0)
	slot0.dancePos = nil

	if #DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList > 0 then
		for slot5 = 1, #slot1 do
			if slot1[slot5] == slot0.archives_id then
				table.remove(slot1, slot5)

				break
			end
		end
	end

	slot0:ResetHeroSkill()
end

function DormHeroTemplate.GoToDance(slot0, slot1)
	if slot0:GetHeroState() == DormEnum.DormHeroState.InCanteenEntrust or slot2 == DormEnum.DormHeroState.InCanteenJob then
		return
	end

	if slot1 and slot2 == DormEnum.DormHeroState.InPublicDorm and #DormitoryData:GetDormSceneData(DormConst.PUBLIC_DORM_ID).archiveIDList > 0 then
		for slot7 = 1, #slot3 do
			if slot3[slot7] == slot0.archives_id then
				table.remove(slot3, slot7)

				break
			end
		end
	end

	slot0.dancePos = slot1

	if not slot0.dancePos then
		slot0:BackToDorm()
	end

	slot0:ResetHeroSkill()
end

function DormHeroTemplate.DisposeRunSkill(slot0)
	if slot0.hero_id then
		if not BackHomeHeroCfg[slot0.hero_id] then
			return
		end

		for slot5, slot6 in ipairs(BackHomeHeroCfg[slot0.hero_id].skill_list) do
			if DormSkillData:CheckSkillIsRun(slot0.hero_id, slot6, DormEnum.EntityType.Character) then
				DormSkillData:DisposeSkillComponent(slot0.hero_id, slot6, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.OpenHeroSkill(slot0)
	if slot0.hero_id then
		slot3 = {}

		for slot8 = 1, #BackHomeHeroCfg[slot0.hero_id].skill_list do
			if GameSetting.dorm_hero_skill_unlock.value[slot8] <= HeroData:GetHeroData(slot0.hero_id).level then
				table.insert(slot3, slot1[slot8])
			end
		end

		for slot8, slot9 in ipairs(slot3) do
			if DormSkillData:CheckSkillIsOpen(slot0.hero_id, slot9, DormEnum.EntityType.Character) then
				DormSkillData:AddSkillComponent(slot0.hero_id, slot9, DormEnum.EntityType.Character)
			end
		end
	end
end

function DormHeroTemplate.ResetHeroSkill(slot0)
	slot0:DisposeRunSkill()
	slot0:OpenHeroSkill()
end

function DormHeroTemplate.SetJob(slot0, slot1)
	slot0.jobType = slot1
end

function DormHeroTemplate.InitDanceTrainData(slot0, slot1)
	if not slot0.property then
		slot0.property = {}
	end

	slot0.property[slot1.hero_id] = IdolTraineeData:ParseIdolProperty(slot1.attribute_list, slot1.hero_id)
end

function DormHeroTemplate.UpdataDanceTrainData(slot0, slot1, slot2)
	slot3 = slot2.hero_id

	if not slot0.property and BackHomeHeroCfg[slot3].idol_usable == 1 then
		slot0:InitDanceTrainData({
			hero_id = slot3
		})
	end

	slot0.property[slot3][slot2.attribute_index] = slot1.attribute_value
end

function DormHeroTemplate.GetDanceProperty(slot0, slot1)
	if slot1 then
		slot2 = slot1 or slot0.hero_id

		if not slot0.property then
			slot0:InitDanceTrainData({
				hero_id = slot2
			})
		end

		return slot0.property[slot2]
	end
end

DormRoomTemplate = class("DormRoomTemplate")

function DormRoomTemplate.Ctor(slot0, slot1)
	slot0.id = slot1.id
	slot0.type = slot1.type
	slot0.name = slot1.name
	slot0.posID = slot1.pos
	slot0.furnitureInfoS = slot1.furnitureInfoS
	slot0.specialFur = slot1.specialFur
end

function DormRoomTemplate.GetDormTemplateFurList(slot0)
	if slot0.furnitureInfoS then
		return slot0.furnitureInfoS
	else
		print("模板家具列表为空")
	end
end

function DormRoomTemplate.GetDormTemplateType(slot0)
	if slot0.type then
		return slot0.type
	end

	print("模板家具类型为空")
end

function DormRoomTemplate.GetDormTemplateFurNumInfo(slot0)
	slot1 = 0
	slot2 = {}

	if slot0.furnitureInfoS then
		for slot6 = 0, slot0.furnitureInfoS.Length - 1 do
			slot1 = slot1 + 1

			if not slot2[slot0.furnitureInfoS[slot6].id] then
				slot2[slot7.id] = 0
			end

			slot2[slot7.id] = slot2[slot7.id] + 1
		end
	end

	for slot6, slot7 in pairs(slot0.specialFur) do
		slot2[slot7] = 1
	end

	return slot1 + DormConst.DORM_SPECIAL_FURNITURE_NUM, slot2
end

function DormRoomTemplate.ReviseFurTemplateNameInfo(slot0, slot1)
	slot0.name = slot1
end

function DormRoomTemplate.GetTemplateName(slot0)
	return slot0.name
end

function DormRoomTemplate.GetTemplateWallAndFloorInfo(slot0)
	return slot0.specialFur
end

function DormRoomTemplate.Dispose(slot0)
	slot0.id = nil
	slot0.type = nil
	slot0.name = nil
	slot0.posID = nil
	slot0.furnitureInfoS = nil
	slot0.specialFur = nil
	slot0.hasHit = false
end
