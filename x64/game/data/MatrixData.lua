require("game.data.MatrixDataTemplate")

slot0 = {}
slot1 = {}
slot2 = {}
slot3 = 0
slot4 = 1
slot5 = {}
slot6 = {}
slot7 = 0
slot8 = 0
slot9 = {}
slot10 = {}
slot11 = 0
slot12 = nil
slot13 = {}
slot14 = {}
slot15 = {}
slot16 = {}
slot17 = nil
slot18 = {}
slot19 = {}
slot20 = nil
slot21 = 0
slot22 = 0
slot23 = 0
slot24 = 0
slot25 = {}
slot26 = 0
slot27 = {}
slot28 = 0
slot29 = singletonClass("MatrixData")

function slot29.Init(slot0)
	uv0 = {}
	uv1 = {}
	uv2 = {}
	uv3 = 0
	uv4 = 1
	uv5 = {}
	uv6 = {}
	uv7 = 0
	uv8 = 0
	uv9 = {}
	uv10 = {}
	uv11 = 0
	uv12 = nil
	uv13 = {}
	uv14 = {}
	uv15 = {}
	uv16 = {}
	uv17 = nil
	uv18 = {}
	uv19 = {}
	uv20 = nil
	uv21 = {}
	uv22 = 0
	uv23 = 0
	uv24 = 0
	uv25 = 0
	uv26 = {}
end

function slot29.InitMatrixSystem(slot0, slot1)
	uv0 = {}
	uv1 = {}

	for slot5, slot6 in ipairs(slot1.ready_hero_list) do
		slot7 = slot6.hero_standard_id

		table.insert(uv0, slot7)

		uv1[HeroStandardSystemCfg[slot7].hero_id] = slot6.skin_id
	end

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.difficulty_list) do
		table.insert(uv2, MatrixDifficultyTemplate.New(slot6))
	end

	uv3 = slot1.next_refresh_timestamp
end

function slot29.InitMatrixUser(slot0, slot1)
	uv0 = slot1.game_state

	MatrixData:UpdateTerminalLevel()

	uv1 = {}

	for slot5, slot6 in ipairs(slot1.point_reward_list) do
		slot7 = {
			rank = slot6.rank,
			item_list = {}
		}

		for slot11 = 1, #slot6.item_list do
			slot12 = slot6.item_list[slot11]

			table.insert(slot7.item_list, {
				item_id = slot12.item_id,
				item_num = slot12.item_num
			})
		end

		slot7.is_got_reward = slot6.is_got_reward
		slot7.need_level = slot6.need_level

		table.insert(uv1, slot7)
	end

	MatrixTools.UpdateSortScoreList()

	uv2 = {}

	for slot5, slot6 in ipairs(slot1.terminal.gift_list) do
		uv2[slot6.id] = slot6.level
	end

	uv3 = {}

	for slot5, slot6 in ipairs(slot1.unlocked_beacon_id_list) do
		table.insert(uv3, slot6)
	end

	if MatrixConst.STATE_TYPE.NOTSTARTED == uv0 then
		return
	end

	if slot1.current_progress then
		uv4 = slot2.tier_id
		uv5 = {}

		for slot6, slot7 in ipairs(slot2.artifact_list) do
			table.insert(uv5, {
				id = slot7.id,
				wins = slot7.wins
			})
		end

		uv6 = MatrixDifficultyTemplate.New(slot2.difficulty)
		slot6 = uv6.price_template_id
		uv7 = MatrixPhaseTemplate.New(slot2.phase, slot6)
		uv8 = {}
		uv9 = {}

		for slot6, slot7 in ipairs(slot2.hero_list) do
			if HeroStandardSystemCfg[slot7.hero_id] then
				slot10 = slot9.hero_id
				slot11 = nil
				slot11 = (uv6.difficulty ~= 3 or MatrixOwnerHeroTemplate.New(slot10, slot8)) and MatrixHeroTemplate.New(slot10, slot8)

				slot11:InitData(slot7)

				uv8[slot10] = slot11

				table.insert(uv9, slot10)
			end
		end

		uv10 = {}

		for slot6, slot7 in ipairs(slot2.custom_affix_id_list) do
			table.insert(uv10, slot7)
		end

		uv11 = {}

		for slot6, slot7 in ipairs(slot2.attribute_list) do
			uv11[slot7.id] = slot7.value
		end

		uv12 = {}

		for slot6, slot7 in ipairs(slot2.beacon_id_list) do
			table.insert(uv12, slot7)
		end

		uv13 = {}

		for slot6, slot7 in ipairs(slot2.current_terminal.gift_list) do
			uv13[slot7.id] = slot7.level
		end
	end
end

function slot29.MatrixOverData(slot0, slot1)
	uv0 = {}

	for slot5, slot6 in ipairs(slot1.currency_list) do
		uv0[slot6.id] = slot6.num
	end

	uv1 = slot1.clear_time
	uv2 = slot1.min_clear_time or slot1.clear_time
	uv3 = slot1.difficulty_complete_times
	uv4 = {}

	for slot5, slot6 in ipairs(slot1.evaluate_id_list) do
		table.insert(uv4, slot6)
	end

	if #uv4 > 1 then
		table.sort(uv4, function (slot0, slot1)
			return MatrixEvaluateCfg[slot1].value < MatrixEvaluateCfg[slot0].value
		end)
	end

	uv5 = slot1.score
end

function slot29.UpdateTerminalLevel(slot0)
	uv0, uv1 = MatrixTools.MatrixExpToLevel(ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_MATRIX_TERMINAL_EXP))
end

function slot29.GetGameState(slot0)
	return uv0
end

function slot29.GetMatrixPhaseData(slot0)
	return uv0
end

function slot29.GetMatrixHeroTeam(slot0)
	return uv0
end

function slot29.GetMatrixBattleHeroTeam(slot0)
	return uv0 or uv1
end

function slot29.SetMatrixBattleHeroTeam(slot0, slot1)
	uv0 = slot1
end

function slot29.GetHeroData(slot0, slot1)
	return uv0[slot1]
end

function slot29.GetTierID(slot0)
	return uv0
end

function slot29.GetDifficulty(slot0)
	return uv0.difficulty
end

function slot29.GetDifficultyData(slot0)
	return uv0
end

function slot29.GetArtifactList(slot0)
	return uv0
end

function slot29.GetCustomAffix(slot0)
	return uv0
end

function slot29.GetPointRewardList(slot0)
	return uv0
end

function slot29.GetTerminalLevel(slot0)
	return uv0
end

function slot29.GetTerminalExp(slot0)
	return uv0
end

function slot29.GetTerminalGift(slot0)
	return uv0
end

function slot29.GetCurrentTerminalGifi(slot0)
	return uv0
end

function slot29.SetTerminalGift(slot0, slot1)
	uv0 = slot1
end

function slot29.GetBeaconIsLock(slot0, slot1)
	return not table.indexof(uv0, slot1)
end

function slot29.GetUnlockBeaconList(slot0)
	return uv0
end

function slot29.GetUseBeaconList(slot0)
	return uv0
end

function slot29.GetChipManagerID(slot0)
	return uv0:GetChipManagerID()
end

function slot29.GetChipList(slot0)
	return uv0:GetChipIDList()
end

function slot29.GetTierScore(slot0, slot1)
	if slot1 == nil then
		slot1 = uv0
	end

	if MatrixTierCfg[slot1] and slot2.level_reward[slot0:GetDifficulty()] then
		return math.floor(slot3 * (1 + slot0:GetAffixDifficultyRate() + slot0:GetScoreAddition()))
	end

	return 0
end

function slot29.GetAffixDifficultyRate(slot0)
	slot4 = MatrixData:GetCustomAffix()

	for slot8, slot9 in ipairs(MatrixData:GetDifficultyData():GetRegularAffix()) do
		slot1 = 0 + ActivityAffixPoolCfg[slot9].multiple
	end

	for slot8, slot9 in ipairs(slot4) do
		slot1 = slot1 + ActivityAffixPoolCfg[slot9].multiple
	end

	return slot1 / 1000
end

function slot29.GetReadyHeroList(slot0)
	return uv0
end

function slot29.GetHeroSkin(slot0, slot1)
	if (HeroData:GetHeroData(slot1) and slot2.using_skin or 0) == 0 then
		slot3 = slot1
	end

	return slot3
end

function slot29.GetReadyDifficultyData(slot0, slot1)
	for slot5, slot6 in pairs(uv0) do
		if slot6:GetDifficulty() == slot1 then
			return slot6
		end
	end

	error("cant find Matrix Difficulty id :" .. slot1)

	return nil
end

function slot29.GetNextRefreshTime(slot0)
	return uv0
end

function slot29.GetEvaluateList(slot0)
	return uv0
end

function slot29.GetCurrentClearTime(slot0)
	return uv0
end

function slot29.GetMinClearTime(slot0)
	return uv0
end

function slot29.GetMatrixCurrencyList(slot0)
	return uv0
end

function slot29.GetDifficultyClearTime(slot0)
	return uv0
end

function slot29.GetMatrixOverScore(slot0)
	return uv0
end

function slot29.GetWeaponServantLevel(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.WEAPON_LEVEL] or 0
end

function slot29.GetHeroEquipMaxCount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_EQUIP_COUNT] or 0
end

function slot29.GetAstrolabeMaxCount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.MAX_ASTROLABE_COUNT] or 0
end

function slot29.GetShoRefreshTimes(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_REFRESH_TIMES] or 0
end

function slot29.GetShopFressRefreshTimes(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FRESS_REFRESH_TIMES] or 0
end

function slot29.GetFirstGoodsDiscount(slot0)
	return uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SHOP_FIRST_GOODS_DISCOUNT] or 1
end

function slot29.GetCanChangeCaptain(slot0)
	if uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.CHANGE_TEAM_LEADER] == 1 then
		return true
	end

	return false
end

function slot29.GetScoreAddition(slot0)
	if not uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.SCORE_ADDITION] then
		return 0
	end

	return slot1 / 1000
end

function slot29.GetGiveUpRewardAddition(slot0)
	if not uv0[MatrixConst.MATRIX_ATTRIBUTE_TYPE.GIVE_UP_REWARD_ADDITION] then
		return 0
	end

	return slot1 / 1000
end

function slot29.GetRaceEffect(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if slot6 == 12 then
			return true
		end
	end

	return false
end

function slot29.GetAffixList(slot0)
	if uv0 then
		for slot6, slot7 in ipairs(uv0:GetRegularAffix()) do
			if ActivityAffixPoolCfg[slot7] then
				table.insert({}, slot8.affix)
			end
		end

		for slot6, slot7 in ipairs(uv1) do
			if ActivityAffixPoolCfg[slot7] then
				table.insert(slot1, slot8.affix)
			end
		end

		return slot1
	end

	return {}
end

function slot29.GetArtifactAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in ipairs(uv0) do
		if MatrixItemCfg[slot6.id] and MatrixTools.GetAffixByEffectId(slot9.params[1], slot6.wins) then
			table.insert(slot1, slot11)
		end
	end

	return slot1
end

function slot29.GetBeaconAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixBeaconCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.effect_id_list) do
				if MatrixTools.GetAffixByEffectId(slot12) then
					table.insert(slot1, slot13)
				end
			end
		end
	end

	return slot1
end

function slot29.GetTerminalAffixList(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] and MatrixTools.GetAffixByEffectId(slot7.effect_id_list[slot6]) then
			table.insert(slot1, slot9)
		end
	end

	return slot1
end

function slot29.GetTotalAffix(slot0)
	slot1 = {}

	table.insertto(slot1, slot0:GetAffixList())
	table.insertto(slot1, slot0:GetArtifactAffixList())
	table.insertto(slot1, slot0:GetBeaconAffixList())
	table.insertto(slot1, slot0:GetTerminalAffixList())

	return slot1
end

function slot29.CalMatrixAttribute(slot0)
	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] then
			MatrixTools.GetAttrByEffectId({}, slot7.effect_id_list[slot6])
		end
	end

	for slot5, slot6 in pairs(uv1) do
		if MatrixBeaconCfg[slot6] then
			for slot11, slot12 in ipairs(slot7.effect_id_list) do
				MatrixTools.GetAttrByEffectId(slot1, slot12)
			end
		end
	end

	return slot1
end

function slot29.CalMatrixSelectHeroAttribute(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(uv0) do
		if MatrixTerminalGiftCfg[slot5] then
			MatrixTools.GetAttrByEffectId(slot1, slot7.effect_id_list[slot6])
		end
	end

	return slot1
end

function slot29.GetCacheCustomAffix(slot0)
	return uv0
end

function slot29.SetCacheCustomAffix(slot0, slot1)
	uv0 = slot1
end

slot30 = nil

function slot29.SetBattleTier(slot0, slot1)
	uv0 = slot1
end

function slot29.GetBattleTier(slot0)
	return uv0
end

return slot29
