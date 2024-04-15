slot1 = CombineGameConst.TypeConst
slot2 = CombineGameConst.FactorType
slot3 = CombineGameConst.RefreshType
slot4 = {}
slot5 = {}
slot6 = {}

return {
	ResetGameData = function (slot0)
		uv0 = {}
		uv1.skillCost = 0
		uv1.initResource = clone(GameSetting.activity_combine_game_init.value)
		uv1.resourceChange = {
			0,
			0,
			0,
			0,
			0,
			0
		}
		uv1.effectCD = 0
		uv1.combineEffect = 0
		uv1.nextTurnCost = {
			0,
			0,
			0,
			0,
			0
		}
		uv1.maxLevel = 2
		uv1.minLevel = 1
		uv1.speed = 1
		uv1.roleLv = 1
		uv1.pool = clone(GameSetting.activity_combine_game_init_cells_list.value)
		uv1.techRate = 1
		uv1.turnRate = 1
		uv1.nowTurn = 1
		uv1.food = 0
		uv1.tech = 0
		uv1.rock = 0
		uv1.nextTechNeed = 0
		uv1.nextStageTurn = 0
		uv1.age = 0
		uv1.totalRock = 0
		uv1.totalFood = 0
		uv1.totalTech = 0
		uv1.skillIndex = 0
		uv1.skillList = {}
		uv1.stageFoodChange = {}
		uv1.buildResource = 0
		uv1.needRefreshSkill = false
		uv1.needRefreshBlock = false
	end,
	GetGameData = function (slot0)
		uv0.food = uv0.initResource[1]
		uv0.rock = uv0.initResource[2]
		uv0.tech = uv0.initResource[3]

		return uv0
	end,
	NewFactor = function (slot0, slot1, slot2)
		if ActivityCombineFactorCfg[slot1] == nil then
			return
		end

		uv0[slot1] = slot3.effect

		if uv1[slot3.effect_type] and slot2 then
			if uv1[slot3.effect_type] == 1 then
				uv2.needRefreshSkill = true
			elseif uv1[slot3.effect_type] == 2 then
				uv2.needRefreshBlock = true
			end
		end

		if slot3.effect_type == uv3.UNLOCK_SKILL then
			table.insert(uv2.skillList, slot3.effect[1])
		elseif slot3.effect_type == uv3.COST_CHANGE then
			uv2.skillCost = uv2.skillCost + slot3.effect[1]
		elseif slot3.effect_type == uv3.RESOURCE_GET_CHANGE then
			uv2.resourceChange[slot3.effect[1]] = uv2.resourceChange[slot3.effect[1]] + slot3.effect[2]
		elseif slot3.effect_type == uv3.SKILL_CD_CHANGE then
			uv2.effectCD = uv2.effectCD + slot3.effect[1]
		elseif slot3.effect_type == uv3.COMBINE_EFFECT_CHANGE then
			uv2.combineEffect = uv2.combineEffect + slot3.effect[1]
		elseif slot3.effect_type == uv3.NEXT_TURN_EFFECT_CHANGE then
			uv2.nextTurnCost[slot3.effect[1]] = uv2.nextTurnCost[slot3.effect[1]] - slot3.effect[2]
		elseif slot3.effect_type == uv3.MAX_LEVEL_EXCHANGE then
			uv2.maxLevel = slot3.effect[1]
		elseif slot3.effect_type == uv3.MIN_LEVEL_EXCHANGE then
			uv2.minLevel = slot3.effect[1]
		elseif slot3.effect_type == uv3.SPEED_CHANGE then
			uv2.speed = uv2.speed + slot3.effect[1]
		elseif slot3.effect_type == uv3.EXP_CHANGE then
			uv2.techRate = uv2.techRate + slot3.effect[1] / 100
		elseif slot3.effect_type == uv3.POOL_CHANGE then
			uv2.pool[slot3.effect[1]] = uv2.pool[slot3.effect[1]] + slot3.effect[2]
		elseif slot3.effect_type == uv3.ROLE_LEVEL_CHANGE then
			uv2.roleLv = slot3.effect[1]
		elseif slot3.effect_type == uv3.NEXT_TECH_CHANGE then
			uv2.turnRate = uv2.turnRate + slot3.effect[1] / 100
		elseif slot3.effect_type == uv3.INIT_RESOURCE_CHANGE then
			uv2.initResource[slot3.effect[1]] = uv2.initResource[slot3.effect[1]] + slot3.effect[2]
		elseif slot3.effect_type == uv3.STAGE_FOOD_CHANGE then
			uv2.stageFoodChange[slot3.effect[1]] = slot3.effect[2]
		elseif slot3.effect_type == uv3.BUILDING_CHANGE then
			uv2.buildResource = slot3.effect[1] + uv2.buildResource
		end
	end,
	StartGame = function (slot0, slot1, slot2, slot3)
		slot4 = ActivityCombineLevelCfg[slot1]

		slot0:ResetGameData()

		for slot8, slot9 in pairs(slot2 or {}) do
			slot0:NewFactor(slot8)
		end

		for slot8, slot9 in ipairs(slot4.default_entry) do
			slot0:NewFactor(slot9)
		end

		TimeTools.StartAfterSeconds(0.2, function ()
			JumpTools.GoToSystem("/CombineGameView", {
				factorList = uv0,
				heroId = uv1.can_use_hero[uv2],
				levelId = uv3
			})
		end, {})
	end,
	EndGame = function (slot0, slot1, slot2, slot3)
		if not slot3 then
			return
		end

		slot5 = 0

		if ActivityCombineLevelCfg[slot1].type == uv0.ENDLESS then
			for slot9, slot10 in pairs(slot2 or {}) do
				slot5 = slot5 + ActivityCombineFactorCfg[slot9].score
			end
		end
	end,
	CheckFactor = function (slot0)
		return uv0[slot0] ~= nil
	end,
	GetFactorPara = function (slot0)
		return uv0[slot0][1]
	end,
	PlayEffect = function (slot0)
		manager.audio:PlayEffect(CombineGameConst.SheeList[slot0], CombineGameConst.NameList[slot0], "")
	end,
	ChangeResource = function (slot0, slot1)
		if slot0 == 0 then
			return slot1
		end

		if slot1 > 0 then
			slot1 = slot1 + uv0.resourceChange[slot0]
		end

		return slot1
	end,
	PlayAni = function (slot0, slot1, slot2)
		table.insert(uv0, slot2)
		AnimatorTools.PlayAnimationWithCallback(slot0, slot1, function ()
			for slot3, slot4 in ipairs(uv0) do
				SetActive(slot4, false)
			end

			uv0 = {}
		end)
	end,
	GameBreak = function (slot0)
		slot0:ResetGameData()
	end
}
