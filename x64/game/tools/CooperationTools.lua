slot1 = {}
slot2 = nil

return {
	GotoCooperation = function ()
		if not CooperationData:GetRoomData() then
			error("GotoCooperation with nil room")

			return
		end

		slot2 = slot0.dest

		if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot0.type then
			OpenPageUntilLoaded("/cooperationBlank/cooperation")
		elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == slot1 then
			OpenPageUntilLoaded("/cooperationBlank/strongholdCooperation")
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == slot1 then
			OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterCooperation")
		else
			OpenPageUntilLoaded("/cooperationBlank/cooperation")
		end
	end,
	GotoCooperationEntry = function (slot0, slot1, slot2)
		if BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO == slot0 then
			OpenPageUntilLoaded("/cooperationBlank/demoCooperationEntry")
		elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == slot0 then
			OpenPageUntilLoaded("/cooperationBlank/strongholdMain")
		elseif BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == slot0 then
			OpenPageUntilLoaded("/cooperationBlank/xH3rdWaterSelectAssistant", {
				activityId = ActivityCfg.get_id_list_by_sub_activity_list[slot2][1]
			})
		end
	end,
	GetCooperationRoomName = function (slot0, slot1, slot2)
		if BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION == slot0 then
			return BattleActivityWaterCooperationCfg[slot1].name
		elseif BattleConst.STAGE_TYPE_NEW.STRONGHOLD == slot0 then
			return ActivityStrongholdCfg[slot1] and ActivityStrongholdCfg[slot1].room_name or ""
		else
			return ""
		end
	end,
	GetCooperationTeamHeroList = function (slot0, slot1, slot2)
		slot3 = {}
		slot4 = false

		if slot0 == BattleConst.STAGE_TYPE_NEW.COOPERATION_DEMO then
			if ActivityCooperationDemoCfg[slot1] then
				slot4 = true
			end

			for slot9, slot10 in ipairs(slot5.hero_standard_system_id_list) do
				table.insert(slot3, {
					id = HeroStandardSystemCfg[slot10].hero_id,
					trialID = slot10
				})
			end
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.STRONGHOLD then
			slot9 = HeroData
			slot11 = slot9

			for slot11, slot12 in pairs(HeroTools.Sort(slot9.GetHeroList(slot11))) do
				if table.indexof(ActivityStrongholdCfg[slot1].limit_heros, slot12) then
					table.insert(slot3, {
						trialID = 0,
						id = slot12
					})
				end
			end

			for slot11, slot12 in ipairs(slot5.standard_heros) do
				table.insert(slot3, {
					id = HeroStandardSystemCfg[slot12].hero_id,
					trialID = slot12
				})
			end
		elseif slot0 == BattleConst.STAGE_TYPE_NEW.ACTIVITY_WATER_COOPERATION then
			slot6, slot7 = ActivityWaterData:GetCanUseTrialList(ActivityCfg.get_id_list_by_sub_activity_list[slot2][1])

			for slot11, slot12 in ipairs(slot7) do
				table.insert(slot3, {
					id = HeroStandardSystemCfg[slot12].hero_id,
					trialID = slot12
				})
			end
		end

		if slot4 then
			slot7 = HeroData
			slot9 = slot7

			for slot9, slot10 in pairs(HeroTools.Sort(slot7.GetHeroList(slot9))) do
				table.insert(slot3, {
					trialID = 0,
					id = slot10
				})
			end
		end

		return slot3
	end,
	RegisterInvitationValidation = function (slot0, slot1)
		uv0[slot0] = slot1
	end,
	IsInvitationValid = function (slot0, slot1, slot2)
		if not uv0[slot0] then
			return true
		end

		if uv0[slot0](slot1, slot2) then
			return true
		end

		return false
	end,
	GetShowInviteRoot = function ()
		for slot4, slot5 in ipairs(GameSetting.cooperation_invite_root_show_activity_template.value) do
			for slot10, slot11 in ipairs(ActivityCfg.get_id_list_by_activity_template[slot5] or {}) do
				if ActivityData:GetActivityIsOpen(slot11) then
					return true
				end
			end
		end

		return false
	end,
	ShowHeroView = function (slot0)
		if (CooperationData:GetRoomData() and slot1:GetRoomPlayerData(slot0)) == nil then
			return
		end

		slot3 = slot2.heroList

		if slot3[1].trialID and slot5 ~= 0 then
			gameContext:Go("/newHero", {
				isEnter = true,
				isTemp = true,
				hid = slot3[1].id,
				tempHeroList = {
					slot5
				}
			})
		else
			uv0 = clone(slot2)

			JumpTools.OpenPageByJump("/newHero", {
				isEnter = true,
				notShowBar = true,
				isCooperation = true
			}, ViewConst.SYSTEM_ID.PLAYER_INFO)
		end
	end,
	GetCooperationHeroPower = function (slot0)
		if (CooperationData:GetRoomData() and slot1:GetRoomPlayerData(slot0)) == nil then
			return 0
		end

		slot3 = slot2.heroList
		slot4 = slot3[1].id
		uv0 = slot2

		if slot3[1].trialID and slot3[1].trialID ~= 0 then
			return getHeroPower(slot3[1].trialID, true)
		else
			return uv1.GetBattlePower(slot4)
		end
	end,
	GetShowPlayerHeroIdList = function ()
		if uv0 then
			slot1 = {}

			for slot5, slot6 in ipairs(uv0.heroList) do
				table.insert(slot1, slot6.id)
			end

			return slot1
		end

		return {}
	end,
	GetShowPlayerHero = function (slot0)
		for slot5, slot6 in ipairs(uv0.heroList) do
			if slot6.id == slot0 then
				slot7, slot8 = uv0:ParseHeroViewData(slot5)

				return slot7, slot8
			end
		end

		return nil, 
	end,
	GetBattlePower = function (slot0)
		slot1, slot2 = uv0.GetShowPlayerHero(slot0)
		slot3 = {}

		for slot7 = 1, 6 do
			if slot1.equip_struct_list[slot7] then
				table.insert(slot3, slot1.equip_struct_list[slot7])
			end
		end

		return calcBattlePower(slot1, slot2, slot3, slot1.trialID, {
			isCooperation = true
		})
	end,
	GetEquipInfo = function (slot0, slot1)
		return uv0.GetShowPlayerHero(slot0).equip_struct_list[slot1]
	end,
	GetHeroSkillInfo = function (slot0)
		slot1 = {
			[slot7.skill_id] = slot7.skill_level
		}

		for slot6, slot7 in ipairs(uv0.GetShowPlayerHero(slot0).skill) do
			-- Nothing
		end

		slot3 = {}

		for slot7, slot8 in ipairs(HeroCfg[slot0].skills) do
			slot9 = HeroTools.GetHeroSkillAddLevel(slot2, slot8)

			if SkillTools.GetIsDodgeSkill(slot8) then
				slot9 = 0
			end

			table.insert(slot3, {
				isCanUp = false,
				id = slot8,
				heroId = slot0,
				lv = slot1[slot8],
				addSkillLv = slot9
			})
		end

		return slot3
	end,
	GetHeroServantInfo = function (slot0)
		slot1 = {}

		if uv0.GetShowPlayerHero(slot0).servant_uid ~= 0 then
			return {
				uid = 0,
				locked = true,
				id = slot2.servant_uid,
				stage = slot2.servant_stage
			}
		else
			return nil
		end
	end
}
