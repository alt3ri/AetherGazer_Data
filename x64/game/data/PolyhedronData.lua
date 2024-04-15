require("game.data.PolyhedronDataTemplate")

slot0 = singletonClass("PolyhedronData", BaseHeroViewData)
slot1 = {}
slot2, slot3 = nil
slot4 = 0
slot5 = {}
slot6 = 1
slot7 = 0
slot8 = {}
slot9 = 0
slot10 = {}
slot11 = {}
slot12 = {}
slot13 = {}
slot14 = {}
slot15 = nil
slot16 = 0
slot17 = 1
slot18 = {}
slot19 = {}
slot20 = {}
slot21 = 1
slot22 = 0

function slot0.Init(slot0)
	uv0 = nil
	uv1 = nil
	uv2 = 0
	uv3 = {}
	uv4 = {}
	uv5 = 1
	uv6 = 0
	uv7 = {}
	uv8 = 0
	uv9 = {}
	uv10 = {}
	uv11 = {}
	uv12 = {}
	uv13 = 0
	uv14 = 0
	uv15 = 1
	uv16 = {}
	uv17 = {}
end

function slot0.InitPolyhedronGameData(slot0, slot1)
	uv0 = slot1.activity_id

	slot0:UpdateTerminalLevel()

	slot2 = slot1.terminal
	uv1 = slot2.reset_times
	uv2 = {}

	for slot6, slot7 in ipairs(slot2.upgrade_id_list) do
		table.insert(uv2, slot7)
	end

	uv3 = {}

	for slot6, slot7 in ipairs(slot1.beacon_id_list) do
		table.insert(uv3, slot7)
	end

	if not uv4 then
		uv4 = PolyhedronTemplate.New(slot1.game)
	else
		uv4:UpdateGame(slot3)
	end

	uv5 = uv4:GetTipsList()

	for slot9, slot10 in ipairs(slot1.decision.apply_id_list) do
		uv6[slot10] = true
	end

	uv7 = {}
	uv8 = {}

	for slot9, slot10 in ipairs(slot1.unlocked_hero_list) do
		table.insert(uv7, slot10.hero_id)

		slot12 = {}

		for slot16, slot17 in ipairs(slot10.astrolabe_id_list) do
			table.insert(slot12, slot17)
		end

		uv8[slot11] = slot12
	end

	uv9 = {}

	for slot9, slot10 in ipairs(slot1.clear_difficulty_list) do
		table.insert(uv9, slot10)
	end

	table.sort(uv9, function (slot0, slot1)
		return slot1 < slot0
	end)

	uv10 = {}

	for slot10, slot11 in ipairs(slot1.manual.sample_list) do
		uv10[slot11.id] = slot11.state
	end

	uv11 = slot1.already_challenge_times or 0
	uv12 = slot1.is_new or 0
end

function slot0.GetHeroIDList(slot0)
	if PolyhedronHeroShelvesCfg[slot1] then
		return PolyhedronHeroShelvesCfg[uv0:GetActivityID()] and PolyhedronHeroShelvesCfg[slot1].leader_hero_id or PolyhedronHeroCfg.all
	else
		Debug.LogError(string.format("PolyhedronHeroShelvesCfg%s,无配置,", slot1))

		return {}
	end
end

function slot0.UpdatePolyhedronProcess(slot0, slot1)
	if uv0 then
		uv0:UpdateProcess(slot1.progress)
	else
		error("UpdatePolyhedronProcess error")
	end

	uv1 = uv0:GetTipsList()
end

function slot0.ResetCacheTipInfoIndex(slot0)
	uv0 = 1
end

function slot0.UpdatePolyhedronSettlement(slot0, slot1)
	slot2 = slot1.end_info
	uv0 = {
		point = slot2.point,
		decision_exp = slot2.decision_exp,
		terminal_exp = slot2.terminal_exp
	}
end

function slot0.GetPolyhedronInfo(slot0)
	return uv0
end

function slot0.GetPolyhedronSettlement(slot0)
	return uv0
end

function slot0.GetClearMaxDifficulty(slot0)
	return uv0[1] or 0
end

function slot0.UpdateTerminalLevel(slot0)
	uv0, uv1 = PolyhedronTools.PolyhedronTerminalExpToLevel(ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_POLYHEDRON_TERMINAL_EXP))
end

function slot0.GetTerminalLevel(slot0)
	return uv0
end

function slot0.GetTerminalExp(slot0)
	return uv0
end

function slot0.GetTerminalGift(slot0)
	return uv0
end

function slot0.SetTerminalGift(slot0, slot1)
	uv0 = slot1
end

function slot0.GetResetTimes(slot0)
	return uv0
end

function slot0.AddUnlockBeacon(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end
end

function slot0.GetUnlockBeaconList(slot0)
	return uv0
end

function slot0.GetBeaconIsLock(slot0, slot1)
	return not table.indexof(uv0, slot1)
end

function slot0.GetBeaconMaxBeaconSelect(slot0)
	for slot6, slot7 in ipairs(uv0) do
		if table.indexof({
			3001,
			3005,
			3011
		}, slot7) then
			slot2 = 0 + 1
		end
	end

	return slot2
end

function slot0.GetArtifaceAtlasState(slot0, slot1)
	return uv0[slot1] or 0
end

function slot0.GetPolyhedronHeroUnlock(slot0, slot1)
	return table.indexof(uv0, slot1)
end

function slot0.UnlockHero(slot0, slot1)
	if not table.indexof(uv0, slot1) then
		table.insert(uv0, slot1)
	end

	slot0:GetHeroData(slot1).unlock = 1
end

function slot0.GetUnlockHeroList(slot0)
	return uv0
end

function slot0.GetHeroData(slot0, slot1)
	slot4 = SkinCfg[HeroStandardSystemCfg[PolyhedronHeroCfg[slot1].standard_id].skin_id].hero

	if not uv0[slot1] then
		uv0[slot1] = PolyhedronHeroDataTemplate.New(slot4, slot1)

		uv0[slot1]:Init(slot3, slot1)

		uv0[slot1].unlock = not slot0:GetPolyhedronHeroUnlock(slot1) and 0 or 1

		PolyhedronData:SetUseAstrolabe(slot4, slot0:GetUseAstrolabe(slot4))
	end

	if uv0[slot1].unlock == 1 then
		uv0[slot1].using_skin = HeroData:GetHeroData(slot4).using_skin

		if uv0[slot1].using_skin == 0 then
			uv0[slot1].using_skin = slot4
		end
	end

	return uv0[slot1]
end

function slot0.GetPolicyApplyList(slot0)
	return uv0
end

function slot0.SetPolicyApplyList(slot0, slot1)
	for slot5, slot6 in ipairs(slot1) do
		uv0[slot6] = true
	end
end

function slot0.GetActivityID(slot0)
	return uv0
end

function slot0.GetSortRankHeroIDList(slot0)
	slot1 = RankData:GetCommonRankList(RankConst.RANK_ID.POLYHERON)
	slot2 = clone(PolyhedronData.GetHeroIDList())

	table.sort(slot2, function (slot0, slot1)
		slot3 = uv0[slot1]

		if (uv0[slot0] and slot2.score or 0) ~= (slot3 and slot3.score or 0) then
			return slot5 < slot4
		else
			return slot0 < slot1
		end
	end)

	return slot2
end

function slot0.ResetTerminalCallback(slot0)
	uv0 = {}

	manager.notify:Invoke(POLYHEDRON_TERMINAL_RESET, {})
end

function slot0.SetCacheSelectHero(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheSelectHero(slot0)
	return uv0
end

function slot0.SetCacheSelectDifficulty(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheSelectDifficulty(slot0)
	return uv0
end

function slot0.SetCacheBeaconList(slot0, slot1)
	uv0 = slot1
end

function slot0.GetCacheBeaconList(slot0)
	return uv0
end

function slot0.GetStandardId(slot0)
	return 1
end

function slot0.GetHeroClicked(slot0, slot1)
	return uv0[slot1] or false
end

function slot0.SetHeroClicked(slot0, slot1)
	if PolyhedronAction:GetPolyhedronHeroRedPointCount(slot1) > 0 then
		uv0[slot1] = true

		PolyhedronAction:RefreshHeroesRedPoint()
	end
end

function slot0.GetTipsData(slot0)
	if uv0[uv1] then
		uv1 = uv1 + 1

		return deepClone(uv0[uv1])
	else
		return nil
	end
end

function slot0.GetUseAstrolabe(slot0, slot1)
	if uv0[slot1] then
		return uv0[slot1]
	end

	if HeroStandardSystemCfg[PolyhedronHeroCfg[slot1].standard_id].astrolabe_suit_id and slot4.astrolabe_suit_id ~= 0 then
		return HeroAstrolabeCfg.get_id_list_by_hero_astrolabe_suit_id[slot4.astrolabe_suit_id]
	end
end

function slot0.SetUseAstrolabe(slot0, slot1, slot2)
	uv0[slot1] = slot2
	uv1[slot1].using_astrolabe = slot2
end

function slot0.GetAlreadyChallengeTimes(slot0)
	return uv0
end

function slot0.ResetAlreadyChallengeTimes(slot0)
	uv0 = 0
end

function slot0.GetExFilterSorterFunc(slot0)
	return function (slot0, slot1)
		slot4 = HeroData:GetHeroData(slot0.id).unlock
		slot5 = HeroData:GetHeroData(slot1.id).unlock

		if (not PolyhedronData:GetPolyhedronHeroUnlock(slot0.id) and 0 or 1) ~= (not PolyhedronData:GetPolyhedronHeroUnlock(slot1.id) and 0 or 1) then
			return true, slot3 < slot2
		elseif slot4 ~= slot5 then
			return true, slot5 < slot4
		end

		return false, false
	end
end

function slot0.GetHeroList(slot0)
	return uv0
end

function slot0.GetEquipDataList(slot0, slot1)
	return slot0:GetHeroData(slot1).equip_list
end

function slot0.GetIsNewRed(slot0)
	return uv0 == 1
end

function slot0.SetNewRedValue(slot0, slot1)
	uv0 = slot1
end

return slot0
