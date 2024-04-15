return {
	HideAllCharacter = function ()
		DormCharacterManager.GetInstance():Clear()
	end,
	GenerateHeroByDrag = function (slot0, slot1)
		DormUtils.CallOnNextUpdate(function ()
			DormLuaBridge.BeginGrabPlayerEntity(DormCharacterManager.GetInstance():Generate(DormHeroTools:GetCurSkinID(uv0)), UnityEngine.Camera.main, Input.mousePosition)
		end)
	end,
	GenreateHero = function (slot0, slot1, slot2)
		if not DormCharacterManager.GetInstance():Generate(DormHeroTools:GetCurSkinID(slot1), slot2) then
			print("未生成角色" .. slot1)
		end

		return slot5
	end,
	RandomSetHeroTrs = function (slot0, slot1)
		if DormLuaBridge.FindSpawnPos(Dorm.DormEntityManager.QueryRadius(slot1), 5, true) then
			Dorm.DormEntityManager.PutEntityLookToDir(slot1, slot3, Quaternion.Euler(0, 360 * math.random(), 0) * Vector3.forward)
		else
			DormLuaBridge.TryGrabPlayerOutOfStuck(slot1)
		end
	end,
	DisposeSingleHero = function (slot0, slot1)
		DormCharacterManager.FindAndRemove(slot1)
	end,
	ReGenerateDormHeroEntity = function (slot0)
		slot1 = CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.DormNormalHero)

		if DormData:GetCurrectSceneID() then
			slot4 = {
				[DormData:GetHeroTemplateInfo(slot9):GetHeroCurSkinID(slot9)] = true
			}

			for slot8, slot9 in ipairs(DormitoryData:GetDormHerosByArchitecture(slot2)) do
				-- Nothing
			end

			slot8 = pairs

			for slot8, slot9 in Dorm.storage:ForeachData(slot1, slot8) do
				if not slot4[slot8] then
					DormCharacterManager.GetInstance():Remove(slot8)
				end

				slot4[slot8] = nil
			end

			for slot8, slot9 in pairs(slot4) do
				slot0:RandomSetHeroTrs(slot0:GenreateHero(slot8))
			end
		end

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			dump("清理场景内角色")
		end
	end,
	GenerateHeroWhenEnterScene = function (slot0)
		if DormConst.DORM_VISIT_ROOM_MIN < DormData:GetCurrectSceneID() then
			if DormVisitTools:GetCurVisitHeroList() then
				for slot6, slot7 in ipairs(slot2) do
					uv0:RandomSetHeroTrs(uv0:GenreateHero(slot7, true))
				end
			end

			return
		end

		if not DormitoryData:GetDormMapList()[slot1].archiveIDList then
			return
		end

		slot3 = nil

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			if slot2 and #slot2 > 0 then
				for slot7, slot8 in ipairs(slot2) do
					if DormData:GetHeroInfo(slot8):GetHeroId() ~= nil then
						uv0:RandomSetHeroTrs(uv0:GenreateHero(slot10, true))
					end
				end
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(slot2[1]) and slot5:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm and slot5:GetHeroId() ~= nil then
			uv0:RandomSetHeroTrs(uv0:GenreateHero(slot7, true))
		end
	end,
	FeedAllHero = function (slot0, slot1, slot2)
		slot6 = nil
		slot7 = DormData:GetHeroArchiveID(slot1)

		for slot11, slot12 in pairs(DormData:GetHeroInfoList()) do
			if slot12:CheckCanFeedFood() then
				slot14 = nil

				if uv0:CheckHeroInRoom(DormData:GetCurrectSceneID(), slot11) then
					slot14 = uv0:GetAllHeroEIDInCurScene()[slot12:GetHeroCurSkinID(slot12:GetHeroId())]
				end

				if slot7 == slot11 then
					slot6 = slot12:FeedFood(slot14, slot2(slot14))
				else
					slot12:FeedFood(slot14, slot2(slot14))
				end
			end
		end

		return slot6
	end,
	FeedMultipleHero = function (slot0, slot1, slot2, slot3)
		slot4 = nil

		for slot8, slot9 in pairs(slot1) do
			if DormData:GetHeroInfo(DormData:GetHeroArchiveID(slot9)):CheckCanFeedFood() then
				slot4 = (slot9 ~= slot2 or slot11:FeedFood(slot8, slot3(slot8))) and slot11:FeedFood(slot8, slot3(slot8))
			end
		end

		return slot4
	end,
	RecallAllHero = function (slot0, slot1)
		slot2 = DormConst.PUBLIC_DORM_ID
		slot3 = {}
		slot4 = false

		if slot1 then
			for slot8, slot9 in ipairs(slot1) do
				if DormData:GetHeroFatigue(slot9) < GameSetting.canteen_hero_fatigue_max.value[1] then
					table.insert(slot3, slot9)
				else
					slot4 = true
				end
			end

			if slot4 then
				DormAction:DeployHeroInRoom(slot2, slot3, DormEnum.DormDeployType.ReCall)
			else
				ShowTips("DORM_NO_HERO_RECALL")
			end
		end
	end,
	GetBackHomeHeadSprite = function (slot0)
		slot1 = nil

		if DormNpcTools:CheckIDIsNpc(slot0) and slot0 or (not IdolPveNpcCfg[slot0] or IdolPveNpcCfg[slot0].icon) and uv0:GetCurSkinID(slot0) then
			return getSpriteViaConfig("DormHeroHeadIcon", slot1)
		end
	end,
	GetBackHomeFullModelSprite = function (slot0)
		if uv0:GetCurSkinID(slot0) then
			return getSpriteViaConfig("DormHeroModelIcon", slot1)
		end
	end,
	GetBackHomeFullModelFowardSprite = function (slot0)
		if uv0:GetCurSkinID(slot0) then
			return getSpriteViaConfig("DormHeroPortrait", slot1)
		end
	end,
	GetBackHomeHeroSkinIcon = function (slot0)
		if slot0 then
			return getSpriteViaConfig("DormHeroPortrait", slot0)
		end
	end,
	GetCurSkinID = function (slot0, slot1)
		if DormVisitTools:CheckCurIsVisitRoom() then
			return slot1
		end

		if DormData:GetHeroTemplateInfo(slot1) then
			if slot2:GetHeroCurSkinID(slot1) then
				return slot3
			else
				print("未找到角色" .. slot1 .. "的皮肤id")
			end
		else
			return slot1
		end
	end,
	GetCanUseDormHeroSkinList = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(SkinCfg.get_id_list_by_hero[slot0]) do
			if not HeroTools.GetIsSkinHide(slot6) and BackHomeHeroSkinCfg[slot6] then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	isUnlock = function (slot0, slot1)
		for slot7, slot8 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot1].hero)) do
			if slot8 == slot1 then
				return true
			end
		end

		return false
	end,
	GetDormHeroCanUseSkinList = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(uv0.GetCanUseDormHeroSkinList(slot1)) do
			if uv0:isUnlock(slot8) then
				table.insert(slot3, slot8)
			end
		end

		return slot3
	end,
	GetDormHeroNextCanUseSkin = function (slot0, slot1, slot2)
		if #slot0:GetDormHeroCanUseSkinList(slot1) == 0 or slot4 == 1 then
			return nil
		else
			return slot3[table.indexof(slot3, slot2) == slot4 and 1 or slot5 + 1]
		end
	end,
	CheckDormFatigueLevel = function (slot0, slot1)
		if not DormNpcTools:CheckIDIsNpc(slot1) then
			if DormData:GetHeroTemplateInfo(slot1):GetFatigue() < GameDisplayCfg.dorm_hero_hungry_fatigue.value[1] then
				return false
			else
				return true
			end
		else
			return true
		end
	end,
	CheckCanteenFatigueLevel = function (slot0, slot1)
		if not DormNpcTools:CheckIDIsNpc(slot1) then
			if DormData:GetHeroTemplateInfo(slot1):GetFatigue() < GameDisplayCfg.canteen_hero_tired_fatigue.value[1] then
				return false
			else
				return true
			end
		else
			return true
		end
	end,
	CheckFeedTime = function (slot0, slot1)
		if not DormNpcTools:CheckIDIsNpc(slot1) then
			if GameSetting.dorm_feed_max.value[1] <= DormData:GetHeroTemplateInfo(slot1).feed_times then
				return false
			else
				return true
			end
		else
			return false
		end
	end,
	GetCanUseHeroInDorm = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(HeroCfg.get_id_list_by_private[0]) do
			if HeroTools.GetHeroIsUnlock(slot7) and BackHomeHeroCfg[slot7] then
				-- Nothing
			end
		end

		for slot6, slot7 in pairs({
			[DormData:GetHeroArchiveID(slot7)] = true
		}) do
			table.insert(slot2, slot6)
		end

		return slot2
	end,
	GetAllCanUseHeroInDorm = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(HeroCfg.get_id_list_by_private[0]) do
			if HeroTools.GetHeroIsUnlock(slot6) == true and BackHomeHeroCfg[slot6] then
				table.insert(slot1, slot6)
			end
		end

		return slot1
	end,
	GetUnLockBackHomeHeroIDList = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(uv0:GetCanUseHeroInDorm()) do
			for slot13, slot14 in ipairs(DormData:GetHeroInfo(slot7):GetCanUseHeroList()) do
				table.insert(slot2, slot14)
			end
		end

		return slot2
	end,
	GetBackHomeCanUseHeroList = function (slot0, slot1)
		slot2 = {}
		slot3 = {}

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot4 = {}

			for slot8, slot9 in ipairs(HeroCfg.get_id_list_by_private[0]) do
				if HeroTools.GetHeroIsUnlock(slot9) == true and BackHomeHeroCfg[slot9] and not slot3[DormData:GetHeroArchiveID(slot9)] then
					slot3[slot10] = true

					table.insert(slot4, slot10)
				end
			end

			for slot8, slot9 in pairs(slot4) do
				if #DormData:GetHeroInfo(slot9):GetCanUseHeroList() > 0 then
					for slot14, slot15 in ipairs(slot10:GetCanUseHeroList()) do
						table.insert(slot2, slot15)
					end
				end
			end

			return slot2
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
			if DormitoryData:GetDormSceneData(slot1).archiveIDList[1] then
				for slot10, slot11 in ipairs(DormData:GetHeroInfo(slot4):GetCanUseHeroList()) do
					table.insert(slot2, slot11)
				end
			else
				print("未找到档案id")
			end

			return slot2
		end

		Debug.LogError("未找到对应房间类型")
	end,
	CheckHeroInRoom = function (slot0, slot1, slot2)
		slot3 = DormitoryData:GetDormArchivesByArchitecture(slot1)

		if BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PublicDorm then
			for slot7, slot8 in ipairs(slot3) do
				if slot8 == slot2 then
					return true
				end
			end
		elseif BackHomeCfg[slot1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(slot3[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
			return true
		end

		return false
	end,
	GetTemplateIDInDorm = function (slot0, slot1)
		slot2 = {}

		if slot1 and HeroRecordCfg[slot1] then
			for slot7, slot8 in ipairs(HeroRecordCfg[slot1].hero_id) do
				if BackHomeHeroCfg[slot8] then
					table.insert(slot2, slot8)
				end
			end
		end

		return slot2[1]
	end,
	GetAllCanUseHeroIDInDorm = function (slot0, slot1, slot2)
		slot3 = {}

		if slot1 and HeroRecordCfg[slot1] then
			for slot8, slot9 in ipairs(HeroRecordCfg[slot1].hero_id) do
				if BackHomeHeroCfg[slot9] then
					if not slot2 then
						if HeroTools.GetHeroIsUnlock(slot9) then
							table.insert(slot3, slot9)
						end
					else
						table.insert(slot3, slot9)
					end
				end
			end
		end

		return slot3
	end,
	GetAllHeroEIDInCurScene = function (slot0)
		slot6 = pairs

		for slot6, slot7 in Dorm.storage:ForeachData(DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero), slot6) do
			-- Nothing
		end

		return {
			[slot6] = slot7
		}
	end,
	IsVoiceNeedUnlock = function (slot0, slot1, slot2)
		if BackHomeHeroCfg[slot2] then
			for slot6, slot7 in ipairs(BackHomeDormLevelRewardCfg.all) do
				if BackHomeDormLevelRewardCfg[slot7].type == 2 and slot8.reward[1] == slot1 then
					return true
				end
			end
		end

		return false
	end,
	GetVoiceUnlockLevel = function (slot0, slot1, slot2)
		for slot6, slot7 in ipairs(BackHomeDormLevel.all) do
			for slot12, slot13 in ipairs(BackHomeHeroCfg[slot1].level_reward[slot6]) do
				if BackHomeDormLevelRewardCfg[slot13].type == 2 and slot14.reward[1] == slot2 then
					return slot7
				end
			end
		end

		return 1
	end,
	GetDormLevelByHeroID = function (slot0, slot1)
		return DormitoryData:GetDormLevel(DormRoomTools:GetDormIDViaArchive(DormData:GetHeroArchiveID(slot1))) or 0
	end,
	GetHeroIDByDancePos = function (slot0, slot1)
		for slot6, slot7 in pairs(DormData:GetHeroInfoList()) do
			if slot7.dancePos == slot1 then
				return slot7:GetHeroId()
			end
		end
	end,
	GetHeroListInDance = function (slot0)
		slot1 = {}

		for slot6, slot7 in pairs(DormData:GetHeroInfoList()) do
			if slot7.dancePos then
				table.insert(slot1, slot7)
			end
		end

		return slot1
	end
}
