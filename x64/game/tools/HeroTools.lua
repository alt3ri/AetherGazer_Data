HeroSorter = import("game.tools.HeroSorter")
slot1 = HeroSorter.New()
slot2 = {}
slot3 = 0

function slot4()
	return uv0 < #HeroRecordCfg.all
end

function slot5(slot0)
	slot1 = false

	for slot5 = uv0 + 1, #HeroRecordCfg.all do
		for slot12, slot13 in pairs(HeroRecordCfg[HeroRecordCfg.all[slot5]].hero_id) do
			uv1[slot13] = slot6

			if slot0 == slot13 then
				slot1 = true
			end
		end

		uv0 = slot5

		if slot1 then
			return slot6
		end
	end

	return nil
end

function slot6(slot0)
	if uv0[slot0] == nil then
		slot1 = uv1(slot0)
	end

	return slot1
end

return {
	GetNeedPreLoadHeroId = function ()
		if HeroData:GetHeroList() == nil then
			return {}
		end

		slot1 = uv0.Sort(HeroData:GetHeroList(), true)

		for slot6 = 1, HeroConst.PRELOAD_HERO_NUM do
			if slot1[slot6] and HideInfoData.GetHeroHideList()[slot1[slot6]] ~= true then
				slot0[slot1[slot6]] = true
			end
		end

		slot0[PlayerData:GetPlayerInfo().poster_girl] = true

		return slot0
	end,
	Sort = function (slot0, slot1)
		slot2 = {}

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" then
				if slot1 or false then
					table.insert(slot2, slot6)
				elseif slot7.hero_unlock == 1 or slot7.unlock == 1 then
					table.insert(slot2, slot6)
				end
			end
		end

		return uv0:SortWithId(slot2)
	end,
	SortHero = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			table.insert(slot1, slot6)
		end

		return uv0:SetUnlockFirst(true):SortWithId(slot1)
	end,
	Count = function (slot0)
		slot2 = 0

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" then
				if slot7.hero_unlock == 1 or slot7.unlock == 1 then
					slot1 = 0 + 1
				end

				slot2 = slot2 + 1
			end
		end

		return slot1, slot2
	end,
	GetStarCnt = function (slot0)
		return math.floor(slot0 / 100)
	end,
	GetStarCfgId = function (slot0, slot1)
		return slot0 * 100 + slot1
	end,
	GetNextStarAndPhase = function (slot0, slot1)
		if slot0 == HeroConst.MAX_STAR then
			return slot0, slot1
		end

		if HeroConst.PER_STAR_PHASE < slot1 + 1 then
			return slot0 + 1, 0
		end

		return slot0, slot1
	end,
	GetCanExchangeHero = function ()
		slot0 = {}
		slot3 = HeroData
		slot5 = slot3

		for slot4, slot5 in pairs(slot3.GetHeroList(slot5)) do
			slot6 = 0
			slot7 = HeroCfg[slot5.id]

			if slot5.unlock == 1 then
				for slot15 = table.keyof(HeroStarCfg.all, uv0.GetStarCfgId(HeroStarCfg[slot5.star].star, HeroStarCfg[slot5.star].phase)), #HeroStarCfg.all do
					slot6 = slot6 + HeroStarCfg[HeroStarCfg.all[slot15]].star_up
				end

				if slot6 < slot5.piece then
					table.insert(slot0, {
						id = ItemCfg[slot5.id].fragment,
						number = slot5.piece - slot6
					})
				end
			end
		end

		return slot0
	end,
	GetHeroIsUnlock = function (slot0)
		return HeroData:GetHeroList()[slot0] and slot1.unlock ~= 0 or false
	end,
	GetHeroRecoveryNum = function (slot0)
		return GameSetting.recovery_fragment.value[HeroCfg[slot0].rare]
	end,
	PlayTalk = function (slot0, slot1, slot2, slot3)
		slot4 = HeroCfg[slot0]

		HeroTools.StopTalk()
		manager.audio:PlayUIAudioByVoice(slot1)

		if (slot2 or 1) == 1 then
			if slot3 ~= nil then
				LuaForUtil.PlayVoiceWithCriLipsync(slot3, string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
			else
				manager.audio:PlayVoice(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
			end
		else
			manager.audio:PlayVoice(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
		end

		manager.notify:Invoke(HERO_SOUND_PLAY, slot0, slot1, slot2)
	end,
	PlayVoice = function (slot0, slot1, slot2)
		slot3 = HeroCfg[slot0]
		slot2 = slot2 or 1

		HeroTools.StopTalk()

		slot4 = nil

		manager.notify:Invoke(HERO_SOUND_PLAY, slot0, slot1, slot2)

		return (slot2 ~= 1 or manager.audio:PlayVoice(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))) and manager.audio:PlayVoice(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
	end,
	GetTalkLength = function (slot0, slot1, slot2)
		if (slot2 or 1) == 1 then
			return manager.audio:GetVoiceLength(string.format("vo_sys_%d", slot0), string.format("v_s_%d_%s", slot0, slot1), string.format("vo_sys_%d.awb", slot0))
		else
			return manager.audio:GetVoiceLength(string.format("vo_bat_%d", slot0), string.format("v_b_%d_%s", slot0, slot1), string.format("vo_bat_%d.awb", slot0))
		end
	end,
	StopTalk = function ()
		manager.audio:Stop("voice")
	end,
	GetConstructHero = function (slot0)
		if slot0.skin > 0 then
			slot0.using_skin = slot0.skin
		else
			slot0.using_skin = slot0.id
		end

		return slot0
	end,
	InitTransitionByCfg = function (slot0, slot1)
		slot2 = {}
		slot1 = type(slot1) == "table" and slot1 or {}

		for slot6, slot7 in pairs(type(slot0) == "table" and slot0 or {}) do
			slot8 = {}

			for slot13, slot14 in pairs(slot7) do
				slot15 = slot1[slot6] and slot1[slot6][slot13] or 0
				slot9 = 0 + slot15

				table.insert(slot8, {
					skill_id = slot14,
					skill_level = slot15
				})
			end

			slot2[slot6] = {
				slot_id = slot6,
				talent_points = slot9,
				skill_list = slot8
			}
		end

		return slot2
	end,
	AttributeAdd = function (slot0, slot1, slot2)
		if slot0 == HeroConst.SUB_MUL_ATTRIBUTE_ID then
			return HeroConst.ATTRIBUTE_PRECISION - (HeroConst.ATTRIBUTE_PRECISION - (slot1 or 0)) * (HeroConst.ATTRIBUTE_PRECISION - (slot2 or 0)) / HeroConst.ATTRIBUTE_PRECISION
		elseif slot0 == HeroConst.SUB_MUL_INJURY_ID or slot0 == HeroConst.SUB_MUL_SELF_INJURY_ID then
			return (HeroConst.ATTRIBUTE_PRECISION + slot1) * (HeroConst.ATTRIBUTE_PRECISION + slot2) / HeroConst.ATTRIBUTE_PRECISION
		else
			return slot1 + slot2
		end
	end,
	GetHeroAttribute = function (slot0)
		slot1 = {}
		slot2 = slot0.star
		slot5 = HeroCfg[slot0.id].star_up_skill_template
		slot7 = uv0.GetStageDicWithStarTemplateAndStarSkillType(slot5, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)

		for slot11, slot12 in ipairs(uv0.GetStageListWithStarTemplateAndStarSkillType(slot5, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)) do
			if slot12 <= slot2 then
				for slot18, slot19 in pairs(HeroStarSkillCfg[slot7[slot12]].params) do
					slot1[slot19[1]] = (slot1[slot19[1]] or 0) + slot19[2]
				end
			else
				break
			end
		end

		slot1[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (slot1[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + slot4.base_crit2[(slot0.break_level or 0) + 1]

		for slot12, slot13 in pairs(PublicAttrCfg.all) do
			if HeroConst.HERO_ATTRIBUTE_MAP[slot13] then
				if slot15.base then
					slot14 = 0 + slot4[slot15.base][HeroStarCfg[slot2].star]
				end

				if slot15.grow_fixed then
					slot14 = slot14 + (slot0.level - 1) * slot4[slot15.grow_fixed][slot8]
				end
			end

			if slot1[slot13] == nil then
				slot1[slot13] = 0
			end

			slot1[slot13] = slot1[slot13] + slot14
		end

		return slot1
	end,
	CaculateHeroAttribute = function (slot0, slot1)
		slot2 = {}
		slot3 = slot0.star or slot0.hero_star
		slot4 = slot0.hero_level or slot0.level or uv0.CheckExp(1, slot0.exp) or 1
		slot6 = HeroCfg[slot0.hero_id or slot0.id]

		for slot10, slot11 in pairs(slot1) do
			slot2[slot10] = (slot2[slot10] or 0) + slot11
		end

		slot7 = slot6.star_up_skill_template
		slot9 = uv0.GetStageDicWithStarTemplateAndStarSkillType(slot7, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)

		for slot13, slot14 in ipairs(uv0.GetStageListWithStarTemplateAndStarSkillType(slot7, HeroConst.HERO_STAR_SKILL_TYPE.ATTRIBUTE_UP)) do
			if slot14 <= slot3 then
				for slot20, slot21 in pairs(HeroStarSkillCfg[slot9[slot14]].params) do
					slot2[slot21[1]] = (slot2[slot21[1]] or 0) + slot21[2]
				end
			else
				break
			end
		end

		slot2[HeroConst.HERO_ATTRIBUTE.CRITICAL] = (slot2[HeroConst.HERO_ATTRIBUTE.CRITICAL] or 0) + slot6.base_crit2[(slot0.break_level or 0) + 1]
		slot10 = {
			WeaponTools.WeaponAtk(slot11.level, slot11.breakthrough),
			[slot14[1]] = slot14[2]
		}
		slot12 = slot0:GetServantInfo()

		if slot0:GetWeaponInfo() then
			slot14 = HeroCfg[slot5].weapon_break_attribute[slot11.breakthrough + 1]

			if slot12.id ~= 0 then
				slot16 = WeaponServantCfg[slot12.id].attribute
				slot10[1] = slot10[1] + slot10[1] * WeaponServantCfg[slot12.id].attrib_addition / 100
				slot10[slot16[1]] = slot10[slot16[1]] + slot16[2]
			end

			for slot18, slot19 in pairs(slot10) do
				if not slot2[slot18] then
					slot2[slot18] = slot19
				end

				slot2[slot18] = slot2[slot18] + slot19
			end
		end

		for slot17, slot18 in pairs(PublicAttrCfg.all) do
			if HeroConst.HERO_ATTRIBUTE_MAP[slot18] then
				if slot20.base then
					slot19 = 0 + slot6[slot20.base][HeroStarCfg[slot3].star]
				end

				if slot20.grow_fixed then
					slot19 = slot19 + (slot4 - 1) * slot6[slot20.grow_fixed][slot13]
				end
			end

			if slot2[slot18] == nil then
				slot2[slot18] = 0
			end

			slot2[slot18] = slot2[slot18] + slot19
		end

		return slot2
	end,
	CalFinalAttribute = function (slot0)
		for slot4, slot5 in pairs(HeroConst.HERO_ATTRIBUTE_MAP) do
			if slot5.ratio and slot0[slot4] then
				slot0[slot4] = slot0[slot4] * (1 + (slot0[slot5.ratio] / GameSetting.hp_ratio_percent.value[1] or 1))
			end
		end

		for slot4, slot5 in ipairs(slot0) do
			if PublicAttrCfg[slot4].percent and slot6.percent == 1 then
				slot0[slot4] = slot0[slot4]
			else
				slot0[slot4] = math.floor(slot0[slot4])
			end
		end
	end,
	Format = function (slot0, slot1)
		for slot6, slot7 in ipairs(slot0) do
			for slot11, slot12 in ipairs(slot1) do
				slot2[slot6][slot12] = slot7[slot12]
			end
		end

		return {
			[slot6] = {}
		}
	end,
	CheckBlankTable = function (slot0)
		slot1 = true

		for slot5, slot6 in pairs(slot0 or {}) do
			slot1 = false

			break
		end

		return slot1
	end,
	GetEquipMap = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			if type(slot6) == "table" then
				for slot10, slot11 in pairs(slot6.equip) do
					slot1[slot11.equip_id] = slot5
				end
			end
		end

		return slot1
	end,
	GetHeroEquipS = function (slot0)
		return deepClone(HeroData:GetHeroData(slot0).equip)
	end,
	CheckExp = function (slot0, slot1)
		if GameLevelSetting[slot0] == nil or GameLevelSetting[slot0 + 1] == nil then
			return slot0
		end

		if slot2.hero_level_exp1 <= slot1 then
			return uv0.CheckExp(slot0 + 1, slot1 - slot4)
		else
			return slot0
		end
	end,
	GetUnlockSkill = function (slot0)
		slot7 = HeroConst.SKILL_TYPE.ATTACK

		table.insert({}, {
			lv = 1,
			id = slot0,
			type = slot7
		})

		for slot7 = 1, #HeroData:GetHeroList()[slot0].skill do
			table.insert(slot1, {
				id = slot2[slot7].skill_id,
				lv = slot2[slot7].lv or 0,
				type = HeroConst.SKILL_TYPE.SKILL
			})
		end

		return slot1
	end,
	GetExSkillId = function (slot0)
		return slot0 * 1000 + 209
	end,
	GetTotalSkillLv = function (slot0, slot1)
		return uv0.GetSkillLv(slot0, slot1) + uv0.GetHeroSkillAddLevel(HeroData:GetHeroData(slot0), slot1)
	end,
	GetSkillLv = function (slot0, slot1)
		slot2 = nil
		slot6 = slot0

		for slot6, slot7 in ipairs(HeroData:GetHeroData(slot6).skill) do
			if slot7.skill_id == slot1 then
				return slot7.skill_level
			end
		end

		return 0
	end,
	GetSkillAttrLv = function (slot0, slot1)
		slot2 = nil

		for slot6, slot7 in ipairs(HeroData:GetHeroData(slot0).skillAttrList or {}) do
			if slot7.index == slot1 then
				return slot7.level
			end
		end

		return 0
	end,
	GetIsCanSkillUpNew = function (slot0, slot1)
		for slot6, slot7 in ipairs(HeroData:GetHeroData(slot0).skill) do
			if SkillTools.GetIsCanUpNew(slot7.skill_id, slot7.skill_level, slot1) then
				return true
			end
		end

		return false
	end,
	GetHeroSkillInfo = function (slot0, slot1)
		slot2 = {
			[slot8.skill_id] = slot8.skill_level
		}

		for slot7, slot8 in ipairs(HeroData:GetHeroData(slot0).skill) do
			-- Nothing
		end

		slot4 = {}

		for slot8, slot9 in ipairs(HeroCfg[slot0].skills) do
			slot10 = uv0.GetHeroSkillAddLevel(slot3, slot9)

			if SkillTools.GetIsDodgeSkill(slot9) then
				slot10 = 0
			end

			table.insert(slot4, {
				id = slot9,
				heroId = slot0,
				lv = slot2[slot9],
				isCanUp = SkillTools.GetIsCanUp(slot9, slot2[slot9]),
				addSkillLv = slot10
			})
		end

		if slot1 == true then
			for slot8, slot9 in ipairs(slot4) do
				slot9.lv = 1
				slot9.isCanUp = false
				slot9.addSkillLv = 0
			end
		end

		return slot4
	end,
	GetHeroSkillAddLevel = function (slot0, slot1)
		if table.indexof(HeroCfg[slot0.id or slot0.hero_id].skills, slot1) then
			slot6 = {}
			slot7 = slot3.star_up_skill_template
			slot9 = uv0.GetStageDicWithStarTemplateAndStarSkillType(slot7, HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP)

			for slot13, slot14 in ipairs(uv0.GetStageListWithStarTemplateAndStarSkillType(slot7, HeroConst.HERO_STAR_SKILL_TYPE.SKILL_UP)) do
				if slot14 <= slot0.star then
					for slot20, slot21 in pairs(HeroStarSkillCfg[slot9[slot14]].params) do
						slot6[slot21[1]] = (slot6[slot21[1]] or 0) + slot21[2]
					end
				else
					break
				end
			end

			return slot6[slot4] or 0
		end

		return 0
	end,
	CountTransitionTotalSkill = function (slot0, slot1)
		slot2 = HeroTools.GetHeroEquipSkillAddLevel(slot0)
		slot3 = slot0.transition
		slot4 = {}
		slot5 = {
			[EquipCfg[slot10.prefab_id].pos] = slot10
		}

		for slot9, slot10 in ipairs(slot1 or {}) do
			if slot10.prefab_id ~= 0 then
				-- Nothing
			end
		end

		for slot10, slot11 in ipairs(slot3) do
			if slot5[slot11.slot_id] and GameSetting.exclusive_open_need.value[1] <= slot13:GetLevel() then
				for slot18, slot19 in ipairs(slot11.skill_list) do
					if not slot4[slot19.skill_id] then
						slot4[slot20] = 0
					end

					slot4[slot20] = slot4[slot20] + slot19.skill_level
				end
			end
		end

		for slot11, slot12 in pairs(slot4) do
			slot7 = 0 + slot12 + slot2
		end

		return slot7
	end,
	CalTransitionSkillAttribute = function (slot0, slot1)
		slot2 = {}
		slot3 = {}
		slot4 = {}
		slot5 = slot0.transition
		slot6 = HeroTools.GetHeroEquipSkillAddLevel(slot0)
		slot7 = GameSetting.exclusive_skill_level_up_type.value
		slot8 = {
			[EquipCfg[slot13.prefab_id].pos] = slot13
		}

		for slot12, slot13 in ipairs(slot1) do
			if slot13.prefab_id ~= 0 then
				-- Nothing
			end
		end

		slot9 = {}
		slot10 = {}
		slot11 = {}

		for slot15, slot16 in pairs(slot5) do
			if slot8[slot15] and GameSetting.exclusive_open_need.value[1] <= EquipTools.CountEquipLevel(slot17) then
				for slot22, slot23 in ipairs(slot16.skill_list) do
					if EquipSkillCfg[slot23.skill_id].equip_effect_id == 0 then
						slot26 = false

						for slot30, slot31 in ipairs(slot7) do
							if slot24 == slot31[1] then
								slot26 = slot31[2]

								break
							end
						end

						if slot26 then
							slot11[slot24] = (slot11[slot24] or 0) + slot23.skill_level
						else
							slot9[slot24] = (slot9[slot24] or 0) + slot23.skill_level
						end
					else
						slot10[slot24] = (slot10[slot24] or 0) + slot23.skill_level
					end
				end
			end
		end

		for slot15, slot16 in pairs(slot9) do
			slot17 = EquipSkillCfg[slot15]
			slot2[slot18] = (slot2[slot17.attribute] or 0) + slot17.upgrade * (slot16 + slot6)
		end

		for slot15, slot16 in pairs(slot10) do
			slot17 = EquipSkillCfg[slot15]
			slot3[slot15] = (slot3[slot15] or 0) + slot16 + slot6
		end

		slot12 = HeroCfg[slot0.id].skills

		for slot16, slot17 in pairs(slot11) do
			for slot23, slot24 in ipairs(slot7) do
				if slot16 == slot24[1] then
					slot4[slot12[slot24[2]]] = EquipSkillCfg[slot16].upgrade * (slot17 + slot6)

					break
				end
			end
		end

		return slot2, slot3, slot4
	end,
	GetHeroEquipSkillAddLevel = function (slot0)
		if uv0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[slot0.id or slot0.hero_id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_UP)[1] <= slot0.star then
			return 1
		end

		return 0
	end,
	GetHeroWeaponAddLevel = function (slot0)
		if uv0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[slot0.id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.WEAPON_UP)[1] <= slot0.star then
			return 2
		end

		return 0
	end,
	GetIsSuitNumCut = function (slot0)
		if not slot0 then
			return false
		end

		if (slot0.star or slot0.hero_star) and HeroStarCfg[slot3] and uv0.GetStageListWithStarTemplateAndStarSkillType(HeroCfg[slot0.id or slot0.hero_id].star_up_skill_template, HeroConst.HERO_STAR_SKILL_TYPE.EQUIP_SUIT)[1] <= slot3 then
			return true
		end

		return false
	end,
	CountHeroTotalSkilllv = function (slot0)
		for slot6, slot7 in ipairs(HeroData:GetHeroList()[slot0].skill) do
			slot2 = 0 + slot7.skill_level + uv0.GetHeroSkillAddLevel(slot1, slot7.skill_id)
		end

		return slot2
	end,
	GetEquipSuitEffect = function (slot0)
		slot1 = {}

		for slot5, slot6 in ipairs(slot0) do
			if slot6.equip_id ~= 0 then
				slot1[slot9] = (slot1[EquipCfg[EquipData:GetEquipList()[slot6.equip_id].prefab_id].type] or 0) + 1
			end
		end

		slot2 = {}
		slot3 = 0

		for slot7, slot8 in pairs(slot1) do
			for slot13, slot14 in ipairs(EquipSuitCfg.get_id_list_by_suit[slot7]) do
				if EquipSuitCfg[slot14].need <= slot8 then
					if slot2[slot15.suit] == nil then
						slot2[slot15.suit] = {}
						slot3 = slot3 + 1
					end

					table.insert(slot2[slot15.suit], slot15)
				end
			end
		end

		return slot2, slot3
	end,
	GetIsCanSkillUp = function (slot0)
		slot1 = HeroCfg[slot0.id]

		if slot0.unlock == 0 then
			return false
		end

		slot2 = {
			[slot7.skill_id] = slot7.skill_level
		}

		for slot6, slot7 in ipairs(slot0.skill) do
			-- Nothing
		end

		for slot6, slot7 in ipairs(slot1.skills) do
			if SkillTools.GetIsCanUp(slot7, slot2[slot7]) then
				return true
			end
		end

		return false
	end,
	GetIsCanUpStar = function (slot0)
		if slot0.unlock == 0 then
			if GameSetting.unlock_hero_need.value[HeroCfg[slot0.id].rare] <= slot0.piece then
				return true
			end
		else
			if HeroConst.MAX_STAR_UP_ID <= slot0.star then
				return false
			end

			if HeroStarCfg[slot2].star_up <= slot0.piece and HeroStarCfg[slot2].gold_cost <= ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) then
				return true
			end
		end

		return false
	end,
	SortByChat = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = {
			[slot8] = slot9.chat_unread
		}

		for slot8, slot9 in pairs(slot0) do
			if type(slot9) == "table" and slot9.unlock == 1 then
				table.insert(slot3, slot8)
			end
		end

		table.sort(slot3)
		table.sort(slot3, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		if uv0.lastList and uv0.lastList[slot2 - slot1] and slot6 ~= slot3[slot5] and table.indexof(slot3, slot6) then
			table.remove(slot3, slot7)
			table.insert(slot3, slot5, slot6)
		end

		uv0.lastList = slot3

		return slot3
	end,
	SortByChat2 = function (slot0)
		if uv0.chatList then
			return uv0.chatList
		end

		slot1 = {}
		slot2 = {
			[slot6] = slot7.chat_unread
		}

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "table" and slot7.unlock == 1 then
				table.insert(slot1, slot6)
			end
		end

		table.sort(slot1)
		table.sort(slot1, function (slot0, slot1)
			return uv0[slot1] < uv0[slot0]
		end)

		uv0.chatList = slot1

		return slot1
	end,
	HeroUsingSkinInfo = function (slot0)
		if (HeroData:GetHeroData(slot0) and slot2.using_skin or 0) == 0 then
			slot3 = slot0
		end

		return SkinCfg[slot3]
	end,
	SetHeroModelWeaponActivity = function (slot0, slot1)
		LuaForUtil.ShowWeapon(slot0, slot1)
	end,
	HeroUnlockSkinS = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(HeroData:GetHeroData(slot0).unlocked_skin) do
			table.insert(slot2, slot7.skin_id)
		end

		table.insert(slot2, slot0)

		return slot2
	end,
	CanChangeSkin = function (slot0)
		if uv0.GetSkinIsUnlock(slot0) then
			return false
		end

		if not uv0.GetSkinChangeItem(slot0) then
			return false
		end

		if ItemTools.getItemNum(slot2) > 0 then
			return true
		end
	end,
	GetSkinIsUnlock = function (slot0)
		for slot6, slot7 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot0].hero)) do
			if slot7 == slot0 then
				return true
			end
		end

		return false
	end,
	GetSkinIsCanUnLock = function (slot0)
		if SkinCfg[slot0].unlock_id_list[1] then
			return true
		end

		return false
	end,
	GetHasOwnedSkin = function (slot0)
		slot1 = SkinCfg[slot0].hero
		slot2 = HeroData:GetHeroData(slot1)
		slot3 = {}

		if slot0 == slot1 then
			return true
		end

		for slot7, slot8 in ipairs(slot2.unlocked_skin) do
			if slot8.skin_id == slot0 and slot8.time == 0 then
				return true
			end
		end

		return false
	end,
	GetIsLimitTimeSkin = function (slot0)
		slot3 = {}

		for slot7, slot8 in ipairs(HeroData:GetHeroData(SkinCfg[slot0].hero).unlocked_skin) do
			if slot8.skin_id == slot0 and slot8.time ~= 0 then
				return true
			end
		end

		return false
	end,
	GetSkinChangeItem = function (slot0)
		return SkinCfg[slot0].change_item
	end,
	GetHeadSprite = function (slot0)
		return getSpriteViaConfig("HeroLittleIcon", slot0)
	end,
	GetSmallHeadSprite = function (slot0)
		return getSpriteViaConfig("HeroItemshead", slot0)
	end,
	GetHeroAttackRangeIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_range_type_tag.value) do
			if slot6[1] == CharactorParamCfg[slot0].RangeType then
				slot1 = slot6[2]

				break
			end
		end

		return getSprite("Atlas/Hero_arrtAtlas", slot1)
	end,
	GetHeroRaceIcon = function (slot0)
		return uv0.GetRaceIcon(HeroCfg[slot0].race)
	end,
	GetRaceIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_race_type_tag.value) do
			if slot6[1] == slot0 then
				slot1 = slot6[2]
			end
		end

		return getSprite("Atlas/CampItemAtlas", slot1)
	end,
	GetHeroSkillAttributeIcon = function (slot0, slot1)
		if type(HeroCfg[slot0].ATK_attribute) ~= "table" or not HeroCfg[slot0].ATK_attribute[1] then
			print(string.format("%s角色表未配置ATK_attribute", slot0))

			return nil
		end

		return uv0.GetSkillAttributeIcon(HeroCfg[slot0].ATK_attribute[1], slot1)
	end,
	GetSkillAttributeIcon = function (slot0, slot1)
		slot2 = nil

		if slot1 then
			for slot6, slot7 in ipairs(GameDisplayCfg.hero_atack_type_white_tag.value) do
				if slot7[1] == slot0 then
					slot2 = slot7[2]

					break
				end
			end
		else
			for slot6, slot7 in ipairs(GameDisplayCfg.hero_atack_type_tag.value) do
				if slot7[1] == slot0 then
					slot2 = slot7[2]

					break
				end
			end
		end

		return getSprite("Atlas/Hero_arrtAtlas", slot2)
	end,
	GetHeroSkillMechanismIcon = function (slot0)
		slot1 = nil

		for slot5, slot6 in ipairs(GameDisplayCfg.hero_mechanism_type_tag.value) do
			if slot6[1] == HeroCfg[slot0].mechanism_type[1] then
				slot1 = slot6[2]

				break
			end
		end

		return getSprite("Atlas/Hero_arrtAtlas", slot1)
	end,
	GetRareSprite = function (slot0)
		return getSprite("Atlas/Common", string.format("star_%s", slot0))
	end,
	GetHeroCurrentMaxLevel = function (slot0)
		return HeroTools.GetHeroBreakConfig(HeroCfg[slot0.id].race, slot0.break_level or 0).max_level
	end,
	GetHeroBreakConfig = function (slot0, slot1)
		for slot5, slot6 in ipairs(HeroBreakCfg.all) do
			if HeroBreakCfg[slot6].race == slot0 and HeroBreakCfg[slot6].break_times == slot1 then
				return HeroBreakCfg[slot6]
			end
		end

		error(string.format("在hero_break.csv中找不到race=%d,breakLevel=%d的项", slot0, slot1))

		return nil
	end,
	GetHeroServantInfo = function (slot0)
		slot1 = WeaponServantData.GetWeaponServantList()

		if HeroData:GetHeroList()[slot0].servant_uid == 0 then
			return nil
		end

		return slot1[slot2]
	end,
	GetHeroSpecServant = function (slot0)
		return HeroCfg[slot0].spec_servant
	end,
	GetHeroProficiency = function (slot0)
		return math.min(HeroData:GetHeroData(slot0).clear_times, GameSetting.mastery_level_max.value[1])
	end,
	CanBreakHero = function (slot0)
		slot1 = HeroCfg[slot0]

		if not HeroData:GetHeroData(slot0).unlock or slot2.level >= HeroConst.HERO_LV_MAX or HeroTools.GetHeroCurrentMaxLevel(slot2) > slot2.level then
			return false
		end

		if PlayerData:GetPlayerInfo().userLevel < HeroTools.GetHeroBreakConfig(slot1.race, slot2.break_level or 0).user_level then
			return false
		end

		for slot8 = 1, #slot3.cost do
			slot9 = slot3.cost[slot8]

			if not (slot9[2] <= ItemTools.getItemNum(slot9[1])) then
				return false
			end
		end

		if ItemTools.getItemNum(CurrencyConst.CURRENCY_TYPE_GOLD) < slot3.cost_gold then
			return false
		end

		return true
	end,
	GetHeroOntologyID = function (slot0)
		for slot4, slot5 in ipairs(HeroRecordCfg.all) do
			slot6 = HeroRecordCfg[slot5]

			if slot0 == slot5 then
				return slot5, true
			end

			for slot10, slot11 in ipairs(slot6.hero_id) do
				if slot0 == slot11 then
					return slot5, false
				end
			end
		end
	end,
	GetHeroTeachVideo = function (slot0)
		slot1 = HeroCfg[slot0]

		if HeroData:GetHeroData(slot0).unlock == 0 then
			return nil
		end

		if slot1.study_stage[1] and TeachStageExInfoCfg[slot3] and slot4.video_url then
			return slot4.video_url
		end
	end,
	IsSkinUnlock = function (slot0)
		for slot6, slot7 in ipairs(HeroTools.HeroUnlockSkinS(SkinCfg[slot0].hero)) do
			if slot7 == slot0 then
				return true
			end
		end

		return false
	end,
	GetShopIdBySkinId = function (slot0)
		slot1 = 0
		slot2 = 0

		for slot6, slot7 in pairs(RechargeShopDescriptionCfg) do
			if (slot7.type == 14 or slot7.type == 8) and slot7.param and slot7.param[1] == slot0 then
				slot1 = slot7.id
			end
		end

		for slot6, slot7 in pairs(ShopCfg) do
			if slot7.description and slot7.description == slot1 then
				slot2 = slot7.goods_id
			end
		end

		return slot2 or 0
	end,
	IsSkinOutOfDate = function (slot0)
		if uv0.GetShopIdBySkinId(slot0) and slot1 > 0 then
			return ShopData.IsGoodOutOfDate(slot1, getShopCfg(slot1).shop_id)
		else
			return true
		end
	end,
	CanBeDraw = function (slot0, slot1)
		for slot6, slot7 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
			if ActivityData:GetActivityIsOpen(slot7) and ActivityDrawPoolCfg[slot7] then
				for slot12, slot13 in ipairs(slot8.config_list) do
					if slot1 == slot13 then
						return true
					end
				end
			end
		end

		return false
	end,
	GetIsHide = function (slot0)
		return HideInfoData:GetHeroHideList()[slot0] or false
	end,
	GetIsSkinHide = function (slot0)
		return HideInfoData:GetSkinHideList()[slot0] or false
	end,
	GetSkinIsCanUnlockAndGet = function (slot0)
		if SkinCfg[slot0].unlock_id_list[1] then
			for slot4, slot5 in pairs(SkinCfg[slot0].unlock_id_list) do
				slot6, slot7, slot8 = IsConditionAchieved(slot5, {
					heroId = SkinCfg[slot0].hero
				})

				if not slot6 then
					return false
				end
			end

			return true
		else
			return false
		end
	end,
	IsSamePerson = function (slot0, slot1)
		slot3 = uv0(slot1)

		return uv0(slot0) ~= nil and slot3 ~= nil and slot2 == slot3
	end,
	GetUnlockInteractionCfg = function (slot0, slot1)
		for slot7, slot8 in pairs(HeroInteractionCfg[slot1]) do
			if string.find(slot7, "_talk") then
				slot11 = string.split(slot7, "_")[1]

				for slot15, slot16 in ipairs(slot2[slot7]) do
					if HeroVoiceCfg.get_id_list_by_file[string.split(slot16, "_")[2]] and slot0:IsUnlockVoice(slot1, HeroVoiceCfg.get_id_list_by_file[slot17[2]][1]) then
						table.insert(slot3[slot11], slot2[slot11][slot15])
						table.insert(slot3[slot11 .. "_talk"], slot2[slot11 .. "_talk"][slot15])

						if slot2[slot11 .. "_delay"] then
							table.insert(slot3[slot11 .. "_delay"], slot2[slot11 .. "_delay"][slot15])
						end

						if slot2[slot11 .. "_weight"] then
							table.insert(slot3[slot11 .. "_weight"], slot2[slot11 .. "_weight"][slot15])
						end
					end
				end
			end
		end

		return {
			[slot11] = {},
			[slot11 .. "_talk"] = {},
			[slot11 .. "_delay"] = {},
			[slot11 .. "_weight"] = {}
		}
	end,
	IsUnlockVoice = function (slot0, slot1, slot2)
		if DormHeroTools:IsVoiceNeedUnlock(slot2, slot1) and DormHeroTools:GetDormLevelByHeroID(slot1) < DormHeroTools:GetVoiceUnlockLevel(slot1, slot2) then
			return false
		end

		if HeroVoiceCfg[slot2].unlock_condition == 0 then
			return true
		else
			return IsConditionAchieved(slot3, {
				heroId = slot1
			})
		end
	end,
	GetModuleAttribute = function (slot0)
		slot2 = {
			0,
			0,
			0,
			0
		}

		for slot7, slot8 in pairs(HeroTools.GetModuleEffectByHeroAndLevel(slot0.id, slot0.weapon_module_level)) do
			if WeaponModuleEffectCfg[slot8].type == 1 then
				for slot13, slot14 in pairs(slot9.attributes) do
					slot2[slot14[1]] = slot2[slot14[1]] + slot14[2]
				end
			end
		end

		return slot2
	end,
	GetSkillAttribute = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(slot0.skillAttrList) do
			if SkillTools.GetSkillAttrCfg(slot0.id, slot7.index, slot7.level) then
				for slot12, slot13 in pairs(slot8.attr) do
					slot2[slot13[1]] = slot13[2]
				end
			end
		end

		return slot2
	end,
	GetModuleAllDes = function (slot0, slot1)
		slot2, slot3, slot4, slot5 = nil

		if HeroData:GetHeroList()[slot1].servant_uid ~= HeroTools.GetHeroSpecServant(slot1) then
			slot6 = 0
		end

		for slot10, slot11 in pairs(slot0) do
			if WeaponModuleEffectCfg[slot11].type == 1 then
				if slot2 == nil then
					slot2 = {
						slot11
					}
				else
					table.insert(slot2, slot11)
				end
			end

			if slot12 == 2 then
				slot3 = (slot3 ~= nil or SkillTools.GetSkillModuleDes(slot11)) and SkillTools.GetSkillModuleDes(slot11) .. "\n" .. SkillTools.GetSkillModuleDes(slot11)
			end

			if slot12 == 3 then
				slot4 = (slot4 ~= nil or AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6)) and AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6) .. "\n\n" .. AstrolabeTools.GetAstrolabeModuleDes(slot11, slot6)
			end

			if slot12 == 4 then
				slot5 = (slot5 ~= nil or WeaponTools.GetWeaponModuleDes(slot11)) and WeaponTools.GetWeaponModuleDes(slot11) .. "\n\n" .. WeaponTools.GetWeaponModuleDes(slot11)
			end

			if slot12 == 5 then
				slot3 = (slot3 ~= nil or SkillTools.GetServantSkillModuleDes(slot11)) and slot3 .. "\n" .. SkillTools.GetServantSkillModuleDes(slot11)
			end
		end

		return slot2, slot3, slot4, slot5
	end,
	MergeModuleAttribute = function (slot0)
		slot1 = {}

		for slot5, slot6 in pairs(slot0) do
			for slot11, slot12 in pairs(WeaponModuleEffectCfg[slot6].attributes) do
				if slot1[slot12[1]] then
					slot1[slot12[1]] = slot1[slot12[1]] + slot12[2]
				else
					slot1[slot12[1]] = slot12[2]
				end
			end
		end

		return slot1
	end,
	CheckModulePieceCanEnter = function ()
		for slot4, slot5 in pairs(ItemCfg.get_id_list_by_sub_type[ItemConst.ITEM_SUB_TYPE.MODULE_PIECE]) do
			if ItemTools.getItemNum(slot5) > 0 then
				return true
			end
		end

		return false
	end,
	GetModuleEffectByHeroAndLevel = function (slot0, slot1)
		slot2 = {}

		if slot0 and slot1 and WeaponModuleCfg[slot0] then
			for slot7 = 1, slot1 do
				for slot11, slot12 in pairs(slot3.skill[slot7]) do
					table.insert(slot2, slot12)
				end
			end
		end

		return slot2
	end,
	GetStageDicWithStarTemplateAndStarSkillType = function (slot0, slot1)
		if HeroStarUpTemplateCfg.template_dic[slot0] and HeroStarUpTemplateCfg.template_dic[slot0][slot1] then
			return HeroStarUpTemplateCfg.template_dic[slot0][slot1].stage_dic
		end

		return {}
	end,
	GetStageListWithStarTemplateAndStarSkillType = function (slot0, slot1)
		if HeroStarUpTemplateCfg.template_dic[slot0] and HeroStarUpTemplateCfg.template_dic[slot0][slot1] then
			return HeroStarUpTemplateCfg.template_dic[slot0][slot1].stage_list
		end

		return {}
	end,
	GetHeroNameLinkChar = function ()
		slot0 = nil

		return (SettingData:GetCurrentLanguage() == "en" or slot1 == "fr" or slot1 == "de") and " - " or slot1 == "jp" and "·" or "·"
	end,
	GetHeroFullName = function (slot0)
		slot1 = HeroCfg[slot0]

		return GetI18NText(slot1.name) .. HeroTools.GetHeroNameLinkChar() .. GetI18NText(slot1.suffix)
	end,
	GetModulePowersByHeroIDAndLevel = function (slot0, slot1, slot2)
		slot3 = {}

		if WeaponModuleCfg[slot1] then
			for slot8 = 1, slot2 do
				for slot13, slot14 in pairs(slot4.skill[slot8]) do
					table.insert(slot3, slot14)
				end
			end
		end

		return slot3
	end,
	SetHeroNewTagRed = function (slot0, slot1, slot2, slot3)
		if getData("heroNew", slot1) or {} then
			slot5 = 0

			for slot9, slot10 in ipairs(slot4) do
				if slot10 == slot0 then
					slot5 = slot9

					break
				end
			end

			slot6 = false

			if slot5 > 0 then
				if not slot3 then
					slot6 = true

					table.remove(slot4, slot5)
					manager.redPoint:setTip(slot2, 0, RedPointStyle.SHOW_NEW_TAG)
				end
			elseif slot3 then
				slot6 = true

				table.insert(slot4, slot0)
				manager.redPoint:setTip(slot2, 1, RedPointStyle.SHOW_NEW_TAG)
			end

			if slot6 then
				saveData("heroNew", slot1, slot4)
			end
		end
	end,
	DispatchAllHeroNewRed = function (slot0, slot1)
		for slot6, slot7 in ipairs(getData("heroNew", slot0) or {}) do
			manager.redPoint:setTip(slot1 .. slot7, 1, RedPointStyle.SHOW_NEW_TAG)
		end
	end,
	GetHeroShowData = function (slot0, slot1)
		slot2 = {}

		if slot1 then
			CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		end

		if CommonFilterData:IsAll(Filter_Root_Define.Hero_Filter_List.filter_id) or slot1 then
			return slot0
		end

		for slot7, slot8 in pairs(slot0) do
			if not uv0.GetIsHide(slot8.id) and not slot3 then
				slot10 = HeroCfg[slot8.id]
				slot9 = CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.RACE.groupID, {
					Filter_Tags_Define["Race" .. slot10.race]
				}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.ARRT.groupID, {
					Filter_Tags_Define["ARRT" .. slot10.ATK_attribute[1]]
				}) and CommonFilterData:SpecificHasFlag(Filter_Root_Define.Hero_Filter_List.filter_id, Filter_Group_Define.MECHAINISMTYPE.groupID, {
					Filter_Tags_Define["MECHAINISM" .. slot10.mechanism_type[1]]
				})
			end

			if slot9 then
				table.insert(slot2, slot8)
			end
		end

		return slot2
	end,
	IsSpHero = function (slot0)
		if HeroCfg[slot0] then
			return slot1.role_type == 1
		end

		return false
	end,
	FormatFilterHeroDataList = function (slot0, slot1, slot2, slot3)
		HeroViewDataProxy.New(slot0):SetTempHeroList(slot3)

		for slot9, slot10 in ipairs(slot1) do
			-- Nothing
		end

		return {
			[slot9] = {
				id = slot10,
				trialID = slot4:GetHeroData(slot10).tempID,
				type = slot2,
				heroViewProxy = slot4
			}
		}
	end
}
