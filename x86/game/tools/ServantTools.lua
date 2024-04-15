return {
	GetServantMap = function ()
		for slot5, slot6 in pairs(HeroData:GetHeroList()) do
			if slot6.servant_uid ~= 0 then
				-- Nothing
			end
		end

		return {
			[slot6.servant_uid] = slot5
		}
	end,
	GetServantLimited = function (slot0, slot1)
		slot2 = HeroData:GetHeroList()
		slot3 = {}
		slot4 = {}
		slot5 = WeaponServantData:GetWeaponServantList()

		if slot1 then
			for slot9, slot10 in pairs(slot2) do
				slot4[slot10.servant_uid] = 1
			end
		end

		if slot0 then
			for slot9, slot10 in pairs(slot5) do
				if slot10.locked == 0 and not slot4[slot9] then
					table.insert(slot3, slot10)
				end
			end
		else
			for slot9, slot10 in pairs(slot5) do
				table.insert(slot3, slot10)
			end
		end

		return slot3
	end,
	GetServantByIDLimited = function (slot0, slot1, slot2, slot3)
		slot4 = HeroData:GetHeroList()
		slot5 = {}
		slot6 = {}
		slot7 = WeaponServantData:GetServantSByID(slot0)

		if slot2 then
			for slot11, slot12 in pairs(slot4) do
				slot6[slot12.servant_uid] = 1
			end
		end

		if slot1 then
			for slot11, slot12 in pairs(slot7) do
				if WeaponServantData:GetServantDataByUID(slot11).locked == 0 and not slot6[slot11] and slot11 ~= slot3 then
					table.insert(slot5, slot11)
				end
			end
		else
			for slot11, slot12 in pairs(slot7) do
				table.insert(slot5, slot11)
			end
		end

		return slot5
	end,
	ServantBreakCost = function (slot0, slot1)
		if GameSetting.weapon_promote_max.value[slot0] < slot1 then
			print("已超过最大突破次数")

			return false
		end

		return GameSetting.weapon_servant_gold_cost.value[slot0][slot1]
	end,
	ServantBreakMaterialCost = function (slot0, slot1)
		if uv0.GetServantSpecHero(slot0) then
			return GameSetting.weapon_promote_cost_exclusive.value
		else
			return GameSetting.weapon_promote_cost.value[slot1 - 3]
		end
	end,
	GetServantSpecHero = function (slot0)
		slot2 = nil

		if WeaponServantCfg[slot0].effect[1] > 0 then
			slot2 = WeaponEffectCfg[slot1].spec_char[1]
		end

		return slot2
	end,
	IsSleepServant = function (slot0)
		if WeaponServantCfg[slot0] and slot1.type == 3 then
			return true
		end

		return false
	end,
	GetSleepyServantByServant = function (slot0)
		if uv0.GetServantSpecHero(slot0) then
			for slot6, slot7 in ipairs(WeaponServantCfg.get_id_list_by_race[WeaponServantCfg[slot0].race]) do
				if WeaponServantCfg[slot7].type == 3 then
					return slot7
				end
			end
		end

		return false
	end,
	GetSleepyServantNum = function (slot0)
		if not WeaponServantCfg.get_id_list_by_race[slot0] then
			error("错误的race:" .. slot0)
		end

		slot1 = nil

		for slot5, slot6 in ipairs(WeaponServantCfg.get_id_list_by_race[slot0]) do
			if WeaponServantCfg[slot6].type == 3 then
				slot1 = slot6
			end
		end

		return table.length(WeaponServantData:GetServantSByID(slot1))
	end,
	GetServantDecomposeRewardItem = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			slot1[slot9] = (slot1[GameSetting.weapon_servant_break_cost_return.value[WeaponServantCfg[slot6.id].starlevel][1][1]] and slot1[slot9] or 0) + slot8[1][2]
		end

		slot3 = 1

		for slot7, slot8 in pairs(slot1) do
			slot3 = slot3 + 1
		end

		return {
			[slot3] = {
				id = slot7,
				number = slot8
			}
		}
	end,
	GetIsHide = function (slot0)
		return HideInfoData:GetWeaponServantHideList()[slot0] or false
	end,
	GetServantShowCount = function ()
		for slot5, slot6 in pairs(WeaponServantData:GetWeaponServantList()) do
			if not uv0.GetIsHide(slot6.id) then
				slot0 = 0 + 1
			end
		end

		return slot0
	end,
	GetWeaponShowData = function (slot0, slot1)
		slot3 = {}
		slot4 = ServantTools.GetServantMap()

		for slot12, slot13 in pairs(WeaponServantData:GetWeaponServantList()) do
			slot15 = slot1 and function (slot0, slot1)
				if slot1.hideStar then
					for slot6, slot7 in pairs(slot1.hideStar) do
						if WeaponServantCfg[slot0.id].starlevel == slot7 then
							return true
						end
					end
				end

				if slot1.hideEquip and uv0[slot0.uid] then
					return true
				end

				return false
			end(slot13, slot1) or false

			if not uv0.GetIsHide(slot13.id) and not CommonFilterData:IsAll(slot0 or Filter_Root_Define.Servant_Filter_List.filter_id) and not slot15 then
				if uv0.ServantBreakCost(WeaponServantCfg[slot13.id].starlevel, slot13.stage) and slot18 < ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) and slot16.type ~= 3 then
					table.insert({}, Filter_Tags_Define.Beyond)
				end

				if slot4[slot13.uid] then
					table.insert(slot17, Filter_Tags_Define.Equip)
				end

				if slot16.type == 3 then
					table.insert(slot17, Filter_Tags_Define.CallName)
				end

				slot14 = uv0.FilterCheck(slot16, slot2, slot17)
			end

			if slot14 and not slot15 then
				table.insert(slot3, slot13)
			end
		end

		return slot3
	end,
	FilterCheck = function (slot0, slot1, slot2)
		slot3 = false

		if slot1 == Filter_Root_Define.Servant_Filter_List.filter_id then
			return CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
				Filter_Tags_Define["Race" .. slot0.race]
			}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.SERVANT_ADD.groupID, slot2) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Servant_Filter_List.filter_id, Filter_Group_Define.RARITY.groupID, {
				Filter_Tags_Define["Star" .. slot0.starlevel]
			})
		elseif slot1 == Filter_Root_Define.Decompose_Servant_Filter_List.filter_id then
			return CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
				Filter_Tags_Define["Race" .. slot0.race]
			}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.DECOMPOSE_RARITY.groupID, {
				Filter_Tags_Define["Star" .. slot0.starlevel]
			}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Decompose_Servant_Filter_List.filter_id, Filter_Group_Define.DECOMPOSE_SERVANT_ADD.groupID, slot2)
		end
	end,
	ServantSort = function (slot0, slot1)
		slot4 = slot0.stage
		slot5 = slot1.stage
		slot6 = WeaponServantCfg[slot0.id].race
		slot7 = WeaponServantCfg[slot1.id].race
		slot8 = slot0.id
		slot9 = slot1.id
		slot10 = slot0.uid
		slot11 = slot1.uid

		if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
			return slot3 < slot2
		end

		if slot4 ~= slot5 then
			return slot5 < slot4
		end

		if slot6 ~= slot7 then
			return slot7 < slot6
		end

		if slot8 ~= slot9 then
			return slot9 < slot8
		end

		return slot11 < slot10
	end,
	GetServantList = function (slot0, slot1, slot2, slot3, slot4, slot5, slot6)
		function slot7(slot0, slot1)
			slot2 = ServantTools.GetServantSpecHero(slot0.id)
			slot3 = ServantTools.GetServantSpecHero(slot1.id)

			if slot0.id == slot1.id then
				slot4 = WeaponServantCfg[slot0.id].starlevel
				slot5 = WeaponServantCfg[slot1.id].starlevel
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if slot0.stage ~= slot1.stage then
					return slot7 < slot6
				end

				if slot4 ~= slot5 then
					return slot5 < slot4
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			else
				if uv0 then
					if uv0 == slot2 then
						return true
					elseif uv0 == slot3 then
						return false
					end
				end

				slot4 = WeaponServantCfg[slot0.id].starlevel
				slot5 = WeaponServantCfg[slot1.id].starlevel
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if slot0.stage ~= slot1.stage then
					return slot7 < slot6
				end

				if slot4 ~= slot5 then
					return slot5 < slot4
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			end
		end

		function slot8(slot0, slot1)
			slot2 = ServantTools.GetServantSpecHero(slot0.id)
			slot3 = ServantTools.GetServantSpecHero(slot1.id)

			if slot0.id == slot1.id then
				slot6 = slot0.stage
				slot7 = slot1.stage
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
					return slot5 < slot4
				end

				if slot6 ~= slot7 then
					return slot7 < slot6
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			else
				if uv0 then
					if uv0 == slot2 then
						return true
					elseif uv0 == slot3 then
						return false
					end
				end

				slot6 = slot0.stage
				slot7 = slot1.stage
				slot8 = WeaponServantCfg[slot0.id].race
				slot9 = WeaponServantCfg[slot1.id].race
				slot10 = slot0.id
				slot11 = slot1.id
				slot12 = slot0.uid
				slot13 = slot1.uid

				if WeaponServantCfg[slot0.id].starlevel ~= WeaponServantCfg[slot1.id].starlevel then
					return slot5 < slot4
				end

				if slot6 ~= slot7 then
					return slot7 < slot6
				end

				if slot8 ~= slot9 then
					return slot9 < slot8
				end

				if slot10 ~= slot11 then
					return slot11 < slot10
				end

				return slot13 < slot12
			end
		end

		slot9 = nil

		if slot1 then
			slot9 = HeroTools.GetHeroServantInfo(slot1) and slot10.uid
		end

		function slot10(slot0, slot1)
			if uv0 then
				if uv0 == slot0.uid then
					return true
				elseif uv0 == slot1.uid then
					return false
				end
			end

			return 1
		end

		slot11 = 0
		slot12 = false

		if slot1 and slot1 ~= 0 then
			slot11 = HeroTools.GetHeroSpecServant(slot1)
		end

		slot13 = WeaponServantData:GetSortConfig()
		slot14 = slot4 or slot13[1]
		slot15 = slot5 or slot13[2]
		slot16 = nil

		if slot1 then
			slot16 = HeroCfg[slot1].race
		end

		slot17 = {}
		slot18 = {}
		slot19 = {}

		for slot24, slot25 in pairs(slot2 or WeaponServantData:GetWeaponServantList()) do
			if slot1 then
				if WeaponServantCfg[slot25.id].race == slot16 then
					if not table.indexof(slot17, WeaponServantCfg[slot25.id].race) then
						table.insert(slot17, slot27)
					end

					if not slot18[slot27] then
						slot18[slot27] = 0
					end

					slot18[slot27] = slot18[slot27] + 1

					table.insert(slot19, slot25)
				end
			else
				if not table.indexof(slot17, WeaponServantCfg[slot25.id].race) then
					table.insert(slot17, slot27)
				end

				if not slot18[slot27] then
					slot18[slot27] = 0
				end

				slot18[slot27] = slot18[slot27] + 1

				table.insert(slot19, slot25)
			end

			if slot11 ~= 0 and slot25.id == slot11 then
				slot12 = true
			end
		end

		slot18[0] = #slot19

		if slot3 and slot11 ~= 0 and not slot12 then
			if slot6 then
				if uv0.FilterCheck(WeaponServantCfg[slot11], slot6) then
					slot21 = WeaponServantData:GetDefaultData(slot11)
					slot21.isRecommend = true

					table.insert(slot19, slot21)
				end
			else
				slot21 = WeaponServantData:GetDefaultData(slot11)
				slot21.isRecommend = true

				table.insert(slot19, slot21)
			end
		end

		table.sort(slot19, function (slot0, slot1)
			if slot0.isRecommend then
				return true
			end

			if slot1.isRecommend then
				return false
			end

			if uv0(slot0, slot1) == 1 then
				if uv1 == 0 then
					if uv2 == 0 then
						return uv3(slot0, slot1)
					else
						return uv3(slot1, slot0)
					end
				elseif uv1 == 1 then
					if uv2 == 0 then
						return uv4(slot0, slot1)
					else
						return uv4(slot1, slot0)
					end
				end
			else
				return slot2
			end
		end)

		return slot19
	end,
	GetAwakeServantList = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(WeaponServantData:GetAllPrivateWeaponServantIdList()) do
			if not ServantTools.GetIsHide(slot8) and WeaponServantCfg[slot8].race == slot1 then
				table.insert(slot3, {
					locked = 0,
					stage = 1,
					uid = 0,
					id = slot8
				})
			end
		end

		table.sort(slot3, function (slot0, slot1)
			slot6 = slot0.id
			slot7 = slot1.id

			if (uv0:MaterialEnoughById(slot0.id) and 1 or 0) ~= (uv0:MaterialEnoughById(slot1.id) and 1 or 0) then
				return slot5 < slot3
			end

			return slot6 < slot7
		end)

		return slot3
	end,
	MaterialEnoughById = function (slot0, slot1)
		slot3 = {}

		for slot7, slot8 in ipairs(GameSetting.exclusive_weapon_servant_cost.value) do
			if slot8[1] == WeaponServantCfg[slot1].race then
				slot3 = slot8[2]
			end
		end

		slot5 = 0

		if WeaponServantData:GetWeaponServantById(slot3[1][1]) then
			slot5 = #slot4
		end

		return slot3[2][2] <= ItemTools.getItemNum(slot3[2][1]) and slot3[1][2] <= slot5
	end,
	JumpToCallName = function (slot0, slot1)
		manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, {
			openTab = "callName",
			guideForce = true,
			race = WeaponServantCfg[slot1].race,
			servantID = slot1,
			HeroID = slot0
		})
	end,
	JumpToNormalList = function (slot0, slot1)
		manager.notify:Invoke(SERVANT_SWITCH_TO_CALLNAME, {
			openTab = "hold",
			servantUID = slot1,
			HeroID = slot0
		})
	end,
	ServantIsHeroRecom = function (slot0, slot1)
		if not slot1 or not slot0 then
			return false
		end

		if slot1 == 0 or slot0 == 0 then
			return false
		end

		if not WeaponServantCfg[slot0] then
			return false
		end

		slot4 = 0

		if slot2.effect[1] > 0 then
			slot4 = WeaponEffectCfg[slot3].spec_char[1]
		end

		if slot4 and slot4 > 0 and slot4 == slot1 then
			return true
		end

		return false
	end
}
