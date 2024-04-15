local var_0_0 = {
	HideAllCharacter = function()
		DormCharacterManager.GetInstance():Clear()
	end,
	GenerateHeroByDrag = function(arg_2_0, arg_2_1)
		DormUtils.CallOnNextUpdate(function()
			local var_3_0 = DormCharacterManager.GetInstance()
			local var_3_1 = DormHeroTools:GetCurSkinID(arg_2_1)
			local var_3_2 = var_3_0:Generate(var_3_1)

			DormLuaBridge.BeginGrabPlayerEntity(var_3_2, UnityEngine.Camera.main, Input.mousePosition)
		end)
	end,
	GenreateHero = function(arg_4_0, arg_4_1, arg_4_2)
		local var_4_0 = DormCharacterManager.GetInstance()
		local var_4_1 = DormHeroTools:GetCurSkinID(arg_4_1)
		local var_4_2 = var_4_0:Generate(var_4_1, arg_4_2)

		if not var_4_2 then
			print("未生成角色" .. arg_4_1)
		end

		return var_4_2
	end,
	RandomSetHeroTrs = function(arg_5_0, arg_5_1)
		local var_5_0 = Dorm.DormEntityManager.QueryRadius(arg_5_1)
		local var_5_1 = DormLuaBridge.FindSpawnPos(var_5_0, 5, true)

		if var_5_1 then
			local var_5_2 = Quaternion.Euler(0, 360 * math.random(), 0) * Vector3.forward

			Dorm.DormEntityManager.PutEntityLookToDir(arg_5_1, var_5_1, var_5_2)
		else
			DormLuaBridge.TryGrabPlayerOutOfStuck(arg_5_1)
		end
	end,
	DisposeSingleHero = function(arg_6_0, arg_6_1)
		DormCharacterManager.FindAndRemove(arg_6_1)
	end,
	ReGenerateDormHeroEntity = function(arg_7_0)
		local var_7_0 = CanteenAIFunction:GetNameSpace(DormEnum.CharacterType.DormNormalHero)
		local var_7_1 = DormData:GetCurrectSceneID()

		if var_7_1 then
			local var_7_2 = DormitoryData:GetDormHerosByArchitecture(var_7_1)
			local var_7_3 = {}

			for iter_7_0, iter_7_1 in ipairs(var_7_2) do
				var_7_3[DormData:GetHeroTemplateInfo(iter_7_1):GetHeroCurSkinID(iter_7_1)] = true
			end

			for iter_7_2, iter_7_3 in Dorm.storage:ForeachData(var_7_0, pairs) do
				if not var_7_3[iter_7_2] then
					DormCharacterManager.GetInstance():Remove(iter_7_2)
				end

				var_7_3[iter_7_2] = nil
			end

			for iter_7_4, iter_7_5 in pairs(var_7_3) do
				local var_7_4 = arg_7_0:GenreateHero(iter_7_4)

				arg_7_0:RandomSetHeroTrs(var_7_4)
			end
		end

		if BackHomeDataManager:GetCurSystem() == DormEnum.DormSystemType.CricketBattle then
			dump("清理场景内角色")
		end
	end
}

function var_0_0.GenerateHeroWhenEnterScene(arg_8_0)
	local var_8_0 = DormData:GetCurrectSceneID()

	if var_8_0 > DormConst.DORM_VISIT_ROOM_MIN then
		local var_8_1 = DormVisitTools:GetCurVisitHeroList()

		if var_8_1 then
			for iter_8_0, iter_8_1 in ipairs(var_8_1) do
				local var_8_2 = var_0_0:GenreateHero(iter_8_1, true)

				var_0_0:RandomSetHeroTrs(var_8_2)
			end
		end

		return
	end

	local var_8_3 = DormitoryData:GetDormMapList()[var_8_0].archiveIDList

	if not var_8_3 then
		return
	end

	local var_8_4

	if BackHomeCfg[var_8_0].type == DormConst.BACKHOME_TYPE.PublicDorm then
		if var_8_3 and #var_8_3 > 0 then
			for iter_8_2, iter_8_3 in ipairs(var_8_3) do
				local var_8_5 = DormData:GetHeroInfo(iter_8_3):GetHeroId()

				if var_8_5 ~= nil then
					local var_8_6 = var_0_0:GenreateHero(var_8_5, true)

					var_0_0:RandomSetHeroTrs(var_8_6)
				end
			end
		end
	elseif BackHomeCfg[var_8_0].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_8_7 = var_8_3[1]
		local var_8_8 = DormData:GetHeroInfo(var_8_7)

		if var_8_8 and var_8_8:GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
			local var_8_9 = var_8_8:GetHeroId()

			if var_8_9 ~= nil then
				local var_8_10 = var_0_0:GenreateHero(var_8_9, true)

				var_0_0:RandomSetHeroTrs(var_8_10)
			end
		end
	end
end

function var_0_0.FeedAllHero(arg_9_0, arg_9_1, arg_9_2)
	local var_9_0 = DormData:GetHeroInfoList()
	local var_9_1 = var_0_0:GetAllHeroEIDInCurScene()
	local var_9_2 = DormData:GetCurrectSceneID()
	local var_9_3
	local var_9_4 = DormData:GetHeroArchiveID(arg_9_1)

	for iter_9_0, iter_9_1 in pairs(var_9_0) do
		if iter_9_1:CheckCanFeedFood() then
			local var_9_5

			if var_0_0:CheckHeroInRoom(var_9_2, iter_9_0) then
				local var_9_6 = iter_9_1:GetHeroId()

				var_9_5 = var_9_1[iter_9_1:GetHeroCurSkinID(var_9_6)]
			end

			if var_9_4 == iter_9_0 then
				var_9_3 = iter_9_1:FeedFood(var_9_5, arg_9_2(var_9_5))
			else
				iter_9_1:FeedFood(var_9_5, arg_9_2(var_9_5))
			end
		end
	end

	return var_9_3
end

function var_0_0.FeedMultipleHero(arg_10_0, arg_10_1, arg_10_2, arg_10_3)
	local var_10_0

	for iter_10_0, iter_10_1 in pairs(arg_10_1) do
		local var_10_1 = DormData:GetHeroArchiveID(iter_10_1)
		local var_10_2 = DormData:GetHeroInfo(var_10_1)

		if var_10_2:CheckCanFeedFood() then
			if iter_10_1 == arg_10_2 then
				var_10_0 = var_10_2:FeedFood(iter_10_0, arg_10_3(iter_10_0))
			else
				var_10_0 = var_10_2:FeedFood(iter_10_0, arg_10_3(iter_10_0))
			end
		end
	end

	return var_10_0
end

function var_0_0.RecallAllHero(arg_11_0, arg_11_1)
	local var_11_0 = DormConst.PUBLIC_DORM_ID
	local var_11_1 = {}
	local var_11_2 = false

	if arg_11_1 then
		for iter_11_0, iter_11_1 in ipairs(arg_11_1) do
			if DormData:GetHeroFatigue(iter_11_1) < GameSetting.canteen_hero_fatigue_max.value[1] then
				table.insert(var_11_1, iter_11_1)
			else
				var_11_2 = true
			end
		end

		if var_11_2 then
			DormAction:DeployHeroInRoom(var_11_0, var_11_1, DormEnum.DormDeployType.ReCall)
		else
			ShowTips("DORM_NO_HERO_RECALL")
		end
	end
end

function var_0_0.GetBackHomeHeadSprite(arg_12_0)
	local var_12_0

	if DormNpcTools:CheckIDIsNpc(arg_12_0) then
		var_12_0 = arg_12_0
	elseif IdolPveNpcCfg[arg_12_0] then
		var_12_0 = IdolPveNpcCfg[arg_12_0].icon
	else
		var_12_0 = var_0_0:GetCurSkinID(arg_12_0)
	end

	if var_12_0 then
		return getSpriteViaConfig("DormHeroHeadIcon", var_12_0)
	end
end

function var_0_0.GetBackHomeFullModelSprite(arg_13_0)
	local var_13_0 = var_0_0:GetCurSkinID(arg_13_0)

	if var_13_0 then
		return getSpriteViaConfig("DormHeroModelIcon", var_13_0)
	end
end

function var_0_0.GetBackHomeFullModelFowardSprite(arg_14_0)
	local var_14_0 = var_0_0:GetCurSkinID(arg_14_0)

	if var_14_0 then
		return getSpriteViaConfig("DormHeroPortrait", var_14_0)
	end
end

function var_0_0.GetBackHomeHeroSkinIcon(arg_15_0)
	if arg_15_0 then
		return getSpriteViaConfig("DormHeroPortrait", arg_15_0)
	end
end

function var_0_0.GetCurSkinID(arg_16_0, arg_16_1)
	if DormVisitTools:CheckCurIsVisitRoom() then
		return arg_16_1
	end

	local var_16_0 = DormData:GetHeroTemplateInfo(arg_16_1)

	if var_16_0 then
		local var_16_1 = var_16_0:GetHeroCurSkinID(arg_16_1)

		if var_16_1 then
			return var_16_1
		else
			print("未找到角色" .. arg_16_1 .. "的皮肤id")
		end
	else
		return arg_16_1
	end
end

function var_0_0.GetCanUseDormHeroSkinList(arg_17_0)
	local var_17_0 = {}

	for iter_17_0, iter_17_1 in ipairs(SkinCfg.get_id_list_by_hero[arg_17_0]) do
		if not HeroTools.GetIsSkinHide(iter_17_1) and BackHomeHeroSkinCfg[iter_17_1] then
			table.insert(var_17_0, iter_17_1)
		end
	end

	return var_17_0
end

function var_0_0.isUnlock(arg_18_0, arg_18_1)
	local var_18_0 = SkinCfg[arg_18_1].hero
	local var_18_1 = HeroTools.HeroUnlockSkinS(var_18_0)

	for iter_18_0, iter_18_1 in ipairs(var_18_1) do
		if iter_18_1 == arg_18_1 then
			return true
		end
	end

	return false
end

function var_0_0.GetDormHeroCanUseSkinList(arg_19_0, arg_19_1)
	local var_19_0 = var_0_0.GetCanUseDormHeroSkinList(arg_19_1)
	local var_19_1 = {}

	for iter_19_0, iter_19_1 in ipairs(var_19_0) do
		if var_0_0:isUnlock(iter_19_1) then
			table.insert(var_19_1, iter_19_1)
		end
	end

	return var_19_1
end

function var_0_0.GetDormHeroNextCanUseSkin(arg_20_0, arg_20_1, arg_20_2)
	local var_20_0 = arg_20_0:GetDormHeroCanUseSkinList(arg_20_1)
	local var_20_1 = #var_20_0

	if var_20_1 == 0 or var_20_1 == 1 then
		return nil
	else
		local var_20_2 = table.indexof(var_20_0, arg_20_2)

		return var_20_0[var_20_2 == var_20_1 and 1 or var_20_2 + 1]
	end
end

function var_0_0.CheckDormFatigueLevel(arg_21_0, arg_21_1)
	if not DormNpcTools:CheckIDIsNpc(arg_21_1) then
		if DormData:GetHeroTemplateInfo(arg_21_1):GetFatigue() < GameDisplayCfg.dorm_hero_hungry_fatigue.value[1] then
			return false
		else
			return true
		end
	else
		return true
	end
end

function var_0_0.CheckCanteenFatigueLevel(arg_22_0, arg_22_1)
	if not DormNpcTools:CheckIDIsNpc(arg_22_1) then
		if DormData:GetHeroTemplateInfo(arg_22_1):GetFatigue() < GameDisplayCfg.canteen_hero_tired_fatigue.value[1] then
			return false
		else
			return true
		end
	else
		return true
	end
end

function var_0_0.CheckFeedTime(arg_23_0, arg_23_1)
	if not DormNpcTools:CheckIDIsNpc(arg_23_1) then
		if DormData:GetHeroTemplateInfo(arg_23_1).feed_times >= GameSetting.dorm_feed_max.value[1] then
			return false
		else
			return true
		end
	else
		return false
	end
end

function var_0_0.GetCanUseHeroInDorm(arg_24_0)
	local var_24_0 = {}
	local var_24_1 = {}

	for iter_24_0, iter_24_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(iter_24_1) and BackHomeHeroCfg[iter_24_1] then
			var_24_0[DormData:GetHeroArchiveID(iter_24_1)] = true
		end
	end

	for iter_24_2, iter_24_3 in pairs(var_24_0) do
		table.insert(var_24_1, iter_24_2)
	end

	return var_24_1
end

function var_0_0.GetAllCanUseHeroInDorm(arg_25_0)
	local var_25_0 = {}

	for iter_25_0, iter_25_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
		if HeroTools.GetHeroIsUnlock(iter_25_1) == true and BackHomeHeroCfg[iter_25_1] then
			table.insert(var_25_0, iter_25_1)
		end
	end

	return var_25_0
end

function var_0_0.GetUnLockBackHomeHeroIDList(arg_26_0)
	local var_26_0 = var_0_0:GetCanUseHeroInDorm()
	local var_26_1 = {}

	for iter_26_0, iter_26_1 in ipairs(var_26_0) do
		local var_26_2 = DormData:GetHeroInfo(iter_26_1):GetCanUseHeroList()

		for iter_26_2, iter_26_3 in ipairs(var_26_2) do
			table.insert(var_26_1, iter_26_3)
		end
	end

	return var_26_1
end

function var_0_0.GetBackHomeCanUseHeroList(arg_27_0, arg_27_1)
	local var_27_0 = {}
	local var_27_1 = {}

	if BackHomeCfg[arg_27_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		local var_27_2 = {}

		for iter_27_0, iter_27_1 in ipairs(HeroCfg.get_id_list_by_private[0]) do
			if HeroTools.GetHeroIsUnlock(iter_27_1) == true and BackHomeHeroCfg[iter_27_1] then
				local var_27_3 = DormData:GetHeroArchiveID(iter_27_1)

				if not var_27_1[var_27_3] then
					var_27_1[var_27_3] = true

					table.insert(var_27_2, var_27_3)
				end
			end
		end

		for iter_27_2, iter_27_3 in pairs(var_27_2) do
			local var_27_4 = DormData:GetHeroInfo(iter_27_3)

			if #var_27_4:GetCanUseHeroList() > 0 then
				for iter_27_4, iter_27_5 in ipairs(var_27_4:GetCanUseHeroList()) do
					table.insert(var_27_0, iter_27_5)
				end
			end
		end

		return var_27_0
	elseif BackHomeCfg[arg_27_1].type == DormConst.BACKHOME_TYPE.PrivateDorm then
		local var_27_5 = DormitoryData:GetDormSceneData(arg_27_1).archiveIDList[1]

		if var_27_5 then
			local var_27_6 = DormData:GetHeroInfo(var_27_5):GetCanUseHeroList()

			for iter_27_6, iter_27_7 in ipairs(var_27_6) do
				table.insert(var_27_0, iter_27_7)
			end
		else
			print("未找到档案id")
		end

		return var_27_0
	end

	Debug.LogError("未找到对应房间类型")
end

function var_0_0.CheckHeroInRoom(arg_28_0, arg_28_1, arg_28_2)
	local var_28_0 = DormitoryData:GetDormArchivesByArchitecture(arg_28_1)

	if BackHomeCfg[arg_28_1].type == DormConst.BACKHOME_TYPE.PublicDorm then
		for iter_28_0, iter_28_1 in ipairs(var_28_0) do
			if iter_28_1 == arg_28_2 then
				return true
			end
		end
	elseif BackHomeCfg[arg_28_1].type == DormConst.BACKHOME_TYPE.PrivateDorm and DormData:GetHeroInfo(var_28_0[1]):GetHeroState() == DormEnum.DormHeroState.InPrivateDorm then
		return true
	end

	return false
end

function var_0_0.GetTemplateIDInDorm(arg_29_0, arg_29_1)
	local var_29_0 = {}

	if arg_29_1 and HeroRecordCfg[arg_29_1] then
		local var_29_1 = HeroRecordCfg[arg_29_1].hero_id

		for iter_29_0, iter_29_1 in ipairs(var_29_1) do
			if BackHomeHeroCfg[iter_29_1] then
				table.insert(var_29_0, iter_29_1)
			end
		end
	end

	return var_29_0[1]
end

function var_0_0.GetAllCanUseHeroIDInDorm(arg_30_0, arg_30_1, arg_30_2)
	local var_30_0 = {}

	if arg_30_1 and HeroRecordCfg[arg_30_1] then
		local var_30_1 = HeroRecordCfg[arg_30_1].hero_id

		for iter_30_0, iter_30_1 in ipairs(var_30_1) do
			if BackHomeHeroCfg[iter_30_1] then
				if not arg_30_2 then
					if HeroTools.GetHeroIsUnlock(iter_30_1) then
						table.insert(var_30_0, iter_30_1)
					end
				else
					table.insert(var_30_0, iter_30_1)
				end
			end
		end
	end

	return var_30_0
end

function var_0_0.GetAllHeroEIDInCurScene(arg_31_0)
	local var_31_0 = DormUtils.EIdNamespace(DormEnum.CharacterType.DormNormalHero)
	local var_31_1 = {}

	for iter_31_0, iter_31_1 in Dorm.storage:ForeachData(var_31_0, pairs) do
		var_31_1[iter_31_0] = iter_31_1
	end

	return var_31_1
end

function var_0_0.IsVoiceNeedUnlock(arg_32_0, arg_32_1, arg_32_2)
	if BackHomeHeroCfg[arg_32_2] then
		for iter_32_0, iter_32_1 in ipairs(BackHomeDormLevelRewardCfg.all) do
			local var_32_0 = BackHomeDormLevelRewardCfg[iter_32_1]

			if var_32_0.type == 2 and var_32_0.reward[1] == arg_32_1 then
				return true
			end
		end
	end

	return false
end

function var_0_0.GetVoiceUnlockLevel(arg_33_0, arg_33_1, arg_33_2)
	for iter_33_0, iter_33_1 in ipairs(BackHomeDormLevel.all) do
		local var_33_0 = BackHomeHeroCfg[arg_33_1].level_reward[iter_33_0]

		for iter_33_2, iter_33_3 in ipairs(var_33_0) do
			local var_33_1 = BackHomeDormLevelRewardCfg[iter_33_3]

			if var_33_1.type == 2 and var_33_1.reward[1] == arg_33_2 then
				return iter_33_1
			end
		end
	end

	return 1
end

function var_0_0.GetDormLevelByHeroID(arg_34_0, arg_34_1)
	local var_34_0 = DormData:GetHeroArchiveID(arg_34_1)
	local var_34_1 = DormRoomTools:GetDormIDViaArchive(var_34_0)

	return DormitoryData:GetDormLevel(var_34_1) or 0
end

function var_0_0.GetHeroIDByDancePos(arg_35_0, arg_35_1)
	local var_35_0 = DormData:GetHeroInfoList()

	for iter_35_0, iter_35_1 in pairs(var_35_0) do
		if iter_35_1.dancePos == arg_35_1 then
			return iter_35_1:GetHeroId()
		end
	end
end

function var_0_0.GetHeroListInDance(arg_36_0)
	local var_36_0 = {}
	local var_36_1 = DormData:GetHeroInfoList()

	for iter_36_0, iter_36_1 in pairs(var_36_1) do
		if iter_36_1.dancePos then
			table.insert(var_36_0, iter_36_1)
		end
	end

	return var_36_0
end

return var_0_0
