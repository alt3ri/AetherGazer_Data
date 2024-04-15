slot0 = class("CombineGameView", ReduxView)
slot1 = CombineGameConst.Type
slot2 = CombineGameConst.TypeText
slot3 = CombineGameConst.VictoryCondition
slot4 = CombineGameConst.BaseInfoConst

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGameUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stageController = ControllerUtil.GetController(slot0.gameObject_.transform, "stage")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.factorBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = uv0.levelId,
			factorList = uv0.factorList
		})
	end)
	slot0:AddBtnListener(slot0.heroBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameRoleView", {
			roleId = uv0.heroId,
			lv = uv0.gameData.roleLv
		})
	end)
	slot0:AddBtnListener(slot0.winMaskBtn_, nil, function ()
		SetActive(uv0.winGo_, false)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.failMaskBtn_, nil, function ()
		SetActive(uv0.loseGo_, false)
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.levelMaskBtn_, nil, function ()
		SetActive(uv0.levelUpGo_, false)
	end)
	slot0:AddBtnListener(slot0.informationBgBtn_, nil, function ()
		SetActive(uv0.informationGo_, false)
	end)
	slot0:AddBtnListener(slot0.foodBtn_, nil, function ()
		uv0:ShowBaseInfoView(uv1.FOOD, uv0.pos1Go_)
	end)
	slot0:AddBtnListener(slot0.industBtn_, nil, function ()
		uv0:ShowBaseInfoView(uv1.ROCK, uv0.pos2Go_)
	end)
	slot0:AddBtnListener(slot0.techBtn_, nil, function ()
		uv0:ShowBaseInfoView(uv1.TECH, uv0.pos3Go_)
	end)
	slot0:AddBtnListener(slot0.pop6MaskBtn_, nil, function ()
		SetActive(uv0.pop6Go_, false)
	end)
	slot0:AddBtnListener(slot0.tipsBtn_, nil, function ()
		SetActive(uv0.tipsPopGo_, true)

		uv0.tipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_1"), uv0.gameData.speed) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_2"), uv0.gameData.maxLevel) .. "\n" .. string.format(GetTips("ACTIVITY_COMBINE_GAME_GAME_SETTING_3"), uv0.gameData.minLevel)
	end)
	slot0:AddBtnListener(slot0.tipsMask_, nil, function ()
		SetActive(uv0.tipsPopGo_, false)
	end)
	slot0:AddBtnListener(slot0.costMaskBtn_, nil, function ()
		SetActive(uv0.tipsGo_, false)
	end)
	slot0:AddBtnListener(slot0.guideMaskBtn_, nil, function ()
		SetActive(uv0.levelUpGo_, false)
	end)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function ()
				uv0:Back()
			end
		})
	end)
	slot0:AddBtnListener(slot0.homeBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("ACTIVITY_COMBINE_GAME_EXIT_CONFIRM_TIPS"),
			OkCallback = function ()
				OperationRecorder.Record(gameContext:GetLastOpenPage(), "homeBtn")
				gameContext:Go("/home", nil, , true)
			end
		})
	end)
end

function slot0.UpdateView(slot0)
	slot1 = ActivityCombineHeroCfg[slot0.heroId]

	if ActivityCombineLevelCfg[slot0.levelId].victory_condition_type == uv0.ROLE_LEVEL then
		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_1"), slot2.victory_condition[1])
	elseif slot2.victory_condition_type == uv0.TURN then
		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_2"), slot2.victory_condition[1])
	elseif slot2.victory_condition_type == uv0.RESOURCE then
		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), slot0.gameData.totalRock .. "/" .. slot2.victory_condition[2], GetTips(uv1[slot2.victory_condition[1]]))
	elseif slot2.victory_condition_type == uv0.BEAST then
		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), slot0.tools.beastDestoryCount .. "/" .. slot2.victory_condition[2], GetTips(uv1[slot2.victory_condition[1]]))
	end

	if slot0.gameData.nextTechNeed == 0 then
		slot0.techTxt_.text = slot0.gameData.tech
		slot0.expSlider_.value = 1
	else
		slot0.techTxt_.text = slot0.gameData.tech .. "/" .. slot0.gameData.nextTechNeed
		slot0.expSlider_.value = slot0.gameData.tech / slot0.gameData.nextTechNeed
	end

	SetActive(slot0.nextGo_, slot0.gameData.nextStageTurn < 999)

	if slot0.gameData.nextStageTurn >= 999 then
		slot0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), slot0.gameData.nowTurn)
	else
		slot0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), slot0.gameData.nowTurn, slot0.gameData.nextStageTurn)
	end

	slot0.foodTxt_.text = slot0.gameData.food .. "(-" .. slot0.gameData.nextTurnCost[1] .. ")"
	slot0.industryTxt_.text = slot0.gameData.rock
	slot0.heroNameTxt_.text = GetI18NText(slot1.name)
	slot0.heroLevelTxt_.text = "lv" .. slot0.gameData.roleLv
	slot0.winTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_TASK_NAME")
	slot0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
end

function slot0.OnEnter(slot0)
	slot0.levelId = slot0.params_.levelId
	slot0.heroId = slot0.params_.heroId
	slot0.factorList = slot0.params_.factorList
	slot0.result = 3
	slot0.needBury = true
	slot0.gameData = CombineGameFactory:GetGameData()

	slot0:PrepareAction()
	slot0:UpdateView()
end

function slot0.UpdateGameData(slot0)
	slot0.tools.speed = slot0.gameData.speed
	slot0.tools.maxLevel = slot0.gameData.maxLevel
	slot0.tools.minLevel = slot0.gameData.minLevel

	slot0.tools.gailv:Clear()

	slot4 = 0

	slot0.tools.gailv:Add(slot4)

	for slot4 = 1, 5 do
		slot0.tools.gailv:Add(math.max(slot0.gameData.pool[slot4], 0))
	end
end

function slot0.PrepareAction(slot0)
	slot0.tools = CombineGameWorld.Instance
	slot0.foodLock = false
	slot0.techLock = false
	slot0.rockLock = false
	slot0.foodList = {}
	slot0.techList = {}
	slot0.rockList = {}
	slot1 = ActivityCombineLevelCfg[slot0.levelId]

	if manager.guide:IsPlaying() and not GuideData:IsFinish(59) then
		slot0.isTech = slot1.type == 1
		slot0.tools.isTeach = slot0.isTech
		CombineGameWorld.Instance.canDrag = slot0.isTech == false
	end

	slot0:NextStageView()
	slot0:UpdateStartRole()

	slot0.tools.nextYearAction = handler(slot0, slot0.NextTurnUpdate)
	slot0.tools.startGameAction = handler(slot0, slot0.StartGame)
	slot5 = slot0
	slot6 = slot0.MapExtension
	slot0.tools.mapExtensionAction = handler(slot5, slot6)

	function slot0.tools.newResourceAction(slot0, slot1)
		uv0:ChangeResource(slot0, slot1)
		uv0:CheckGame()
	end

	function slot0.tools.buildResourceAction(slot0, slot1)
		uv0:BuildChangeResource(slot0, slot1)
		uv0:CheckGame()
	end

	function slot0.tools.informationAction(slot0, slot1, slot2)
		uv0:ShowInformationView(slot0, slot1, slot2)
	end

	slot0.tools:StartGame()
	slot0:UpdateSkill()

	for slot5, slot6 in ipairs(slot1.create_cells_location) do
		slot0.tools:AddInitList(slot6[1], slot6[2], slot6[3])
	end
end

function slot0.UpdateStartRole(slot0)
	for slot5, slot6 in ipairs(ActivityCombineHeroCfg[slot0.heroId].level_unlock) do
		if slot5 <= slot0.gameData.roleLv then
			CombineGameFactory:NewFactor(slot6)
		end
	end

	slot0.gameData.nextTechNeed = math.floor(slot1.level_exp[slot0.gameData.roleLv] * slot0.gameData.techRate * (100 + ActivityCombineSettingCfg[slot0.gameData.age].score) / 100)

	if slot0.gameData.roleLv == #slot1.level_exp then
		slot0.gameData.nextTechNeed = 0
	end
end

function slot0.StartGame(slot0)
	slot0.tools.rock = slot0.gameData.rock

	slot0.tools.spriteList:Clear()

	slot4 = getSpriteWithoutAtlas

	slot0.tools.spriteList:Add(slot4("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. 1))

	for slot4, slot5 in ipairs(GameSetting.activity_combine_game_icon.value) do
		slot0.tools.spriteList:Add(getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot5))
	end

	slot0.tools.skillSprites:Clear()

	for slot4, slot5 in ipairs(ActivityCombineSkillCfg.all) do
		slot6 = ActivityCombineSkillCfg[slot5]
		slot0.tools.skillSprites[slot6.id] = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot6.icon)
	end

	slot0.heroIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[slot0.heroId].Icon_2)

	slot0.stageController:SetSelectedState("box1")
	slot0:SetInitBlock()
	slot0:UpdateGameData()
end

function slot0.MapExtension(slot0)
	slot4 = "box2"

	slot0.stageController:SetSelectedState(slot4)

	for slot4 = 1, 10 do
		slot0.tools:NewBlock()
	end
end

function slot0.ShowInformationView(slot0, slot1, slot2, slot3)
	SetActive(slot0.informationGo_, true)

	if slot1 ~= 0 then
		slot4 = ActivityCombineSkillCfg[slot1]
		slot0.informationTxt_.text = GetI18NText(slot4.description)
		slot0.cdTxt_.text = "CD:" .. math.max(slot4.cd + slot0.gameData.effectCD, 0)
	end

	slot0.informationGo_.transform.position = slot3.position
end

function slot0.SetInitBlock(slot0)
	slot1 = GameSetting.activity_combine_game_init_cells_location.value

	if next(ActivityCombineLevelCfg[slot0.levelId].init_cells_location) then
		for slot6, slot7 in ipairs(slot2.init_cells_location) do
			slot0.tools:NewBlock(slot7[1], slot7[2], slot7[3], slot7[4])
		end
	else
		slot0.tools.minLevel = slot0.gameData.minLevel

		slot0.tools.gailv:Clear()

		slot7 = 0

		slot0.tools.gailv:Add(slot7)

		for slot7 = 1, 5 do
			slot0.tools.gailv:Add(slot1[slot7])

			slot3 = 0 + slot1[slot7]
		end

		slot0.tools:NewPoor()

		for slot7 = 1, slot3 do
			slot0.tools:NewBlock()
		end
	end
end

function slot0.UpdateSkill(slot0)
	for slot4, slot5 in ipairs(slot0.gameData.skillList) do
		slot6 = ActivityCombineSkillCfg[slot5]

		slot0.tools:UpdateSkill(slot4 - 1, slot5, math.max(slot6.cost + slot0.gameData.skillCost, 0), math.max(slot6.cd + slot0.gameData.effectCD, 0))
	end
end

function slot0.PlayAnimation(slot0, slot1, slot2)
	table.insert(slot0[slot1 .. "List"], (slot2 >= 0 and "+" or "") .. slot2)

	if slot0[slot1 .. "Lock"] == false then
		slot0[slot1 .. "Lock"] = true
		slot0[slot1 .. "AddTxt_"].text = slot0[slot1 .. "List"][1]

		slot0[slot1 .. "AddAni_"]:Play("token_text", -1, 0)
		table.remove(slot0[slot1 .. "List"], 1)
		function (slot0)
			TimeTools.StartAfterSeconds(0.5, function ()
				uv0[uv1 .. "Lock"] = false

				if uv0[uv1 .. "List"][1] then
					uv0[uv1 .. "AddAni_"]:Play("token_text", -1, 0)

					uv0[uv1 .. "AddTxt_"].text = uv0[uv1 .. "List"][1]

					table.remove(uv0[uv1 .. "List"], 1)

					uv0[uv1 .. "Lock"] = true

					uv2(uv1)
				end
			end, {})
		end(slot1)
	end
end

function slot0.BuildChangeResource(slot0, slot1, slot2)
	for slot7 = 1, slot2 do
		slot3 = 0 + CombineGameFactory.ChangeResource(uv0.TECH, slot1)
	end

	if slot3 == 0 then
		return
	end

	slot0.gameData.tech = slot0.gameData.tech + slot3

	if slot0.gameData.nextTechNeed == 0 then
		slot0.techTxt_.text = slot0.gameData.tech
	else
		slot0.techTxt_.text = slot0.gameData.tech .. "/" .. slot0.gameData.nextTechNeed
	end

	slot0.expSlider_.value = slot0.gameData.tech / slot0.gameData.nextTechNeed
	slot0.gameData.totalTech = slot0.gameData.totalTech + (slot3 > 0 and slot3 or 0)

	slot0:PlayAnimation("tech", slot3)
end

function slot0.ChangeResource(slot0, slot1, slot2)
	if CombineGameFactory.ChangeResource(slot1, slot2) == 0 then
		return
	end

	if slot1 == uv0.FOOD then
		slot0.gameData.food = slot0.gameData.food + slot2
		slot0.foodTxt_.text = slot0.gameData.food .. "(-" .. slot0.gameData.nextTurnCost[1] .. ")"
		slot0.gameData.totalFood = slot0.gameData.totalFood + (slot2 > 0 and slot2 or 0)

		slot0:PlayAnimation("food", slot2)
	elseif slot1 == uv0.TECH then
		slot0.gameData.tech = slot0.gameData.tech + slot2

		if slot0.gameData.nextTechNeed == 0 then
			slot0.techTxt_.text = slot0.gameData.tech
		else
			slot0.techTxt_.text = slot0.gameData.tech .. "/" .. slot0.gameData.nextTechNeed
		end

		slot0.expSlider_.value = slot0.gameData.tech / slot0.gameData.nextTechNeed
		slot0.gameData.totalTech = slot0.gameData.totalTech + (slot2 > 0 and slot2 or 0)

		slot0:PlayAnimation("tech", slot2)
	elseif slot1 == uv0.ROCK then
		slot0.gameData.rock = slot0.gameData.rock + slot2
		slot0.industryTxt_.text = slot0.gameData.rock
		slot0.tools.rock = slot0.gameData.rock
		slot0.gameData.totalRock = slot0.gameData.totalRock + (slot2 > 0 and slot2 or 0)

		slot0:PlayAnimation("rock", slot2)
	end
end

function slot0.CheckGame(slot0)
	slot0.tools:RefreshSkillStage()
	SetActive(slot0.foodPopGo_, slot0.gameData.food <= 10)

	if slot0.gameData.nextTechNeed <= slot0.gameData.tech and slot0.gameData.nextTechNeed ~= 0 then
		slot0:RoleLevelUpView()
		slot0:UpdateGameData()
		slot0:UpdateView()
	end

	if slot0.gameData.food < 0 then
		slot0:GameFail()

		return
	end

	if slot0:CheckVictory() then
		slot0:GameWin()

		return
	end
end

function slot0.NextTurnUpdate(slot0)
	slot0:ChangeResource(uv0.FOOD, -slot0.gameData.nextTurnCost[uv0.FOOD])
	slot0:ChangeResource(uv0.ROCK, -slot0.gameData.nextTurnCost[uv0.ROCK])
	slot0:ChangeResource(uv0.TECH, -slot0.gameData.nextTurnCost[uv0.TECH])

	slot0.gameData.nowTurn = slot0.gameData.nowTurn + 1

	slot0:CheckGame()

	if slot0.gameData.nextStageTurn >= 999 then
		slot0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN_2"), slot0.gameData.nowTurn)
	else
		slot0.roundTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_TURN"), slot0.gameData.nowTurn, slot0.gameData.nextStageTurn)
	end

	if slot0.gameData.nextStageTurn < slot0.gameData.nowTurn then
		slot0:NextStageView()
		slot0:UpdateGameData()
		slot0:UpdateView()
	end

	slot0.tools.speed = slot0.gameData.speed
	slot0.tools.maxLevel = slot0.gameData.maxLevel
	slot0.tools.minLevel = slot0.gameData.minLevel
end

function slot0.CheckVictory(slot0)
	if ActivityCombineLevelCfg[slot0.levelId].victory_condition_type == uv0.ROLE_LEVEL then
		return slot1.victory_condition[1] <= slot0.gameData.roleLv
	elseif slot1.victory_condition_type == uv0.TURN then
		return slot1.victory_condition[1] <= slot0.gameData.nowTurn
	elseif slot1.victory_condition_type == uv0.RESOURCE then
		slot2 = nil

		if slot1.victory_condition[1] == uv1.FOOD then
			slot2 = slot0.gameData.totalFood
		elseif slot1.victory_condition[1] == uv1.ROCK then
			slot2 = slot0.gameData.totalRock
		elseif slot1.victory_condition[1] == uv1.TECH then
			slot2 = slot0.gameData.totalTech
		end

		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_3"), slot2 .. "/" .. slot1.victory_condition[2], GetTips(uv2[slot1.victory_condition[1]]))

		return slot1.victory_condition[2] <= slot2
	elseif slot1.victory_condition_type == uv0.BEAST then
		slot0.winConditionTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_VICTORY_CONDITION_4"), slot0.tools.beastDestoryCount .. "/" .. slot1.victory_condition[2], GetTips(uv2[slot1.victory_condition[1]]))

		return slot1.victory_condition[2] <= slot0.tools.beastDestoryCount
	end

	return false
end

function slot0.GameWin(slot0)
	slot0.winTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_VICTORY")
	slot0.result = 1

	SetActive(slot0.winGo_, true)
	CombineGameFactory:EndGame(slot0.levelId, slot0.factorList, true)

	if slot0.result == 1 and (CombineGameData:GetDataByPara("stageDataTable")[slot0.levelId] ~= true or ActivityCombineLevelCfg[slot0.levelId].type == CombineGameConst.TypeConst.ENDLESS) then
		CombineGameAction.GameWin(slot0.levelId, slot0:CalculateScore())
	end
end

function slot0.GameFail(slot0)
	slot0.loseTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DEFEAT")
	slot0.result = 2

	SetActive(slot0.loseGo_, true)
	CombineGameFactory:EndGame(slot0.levelId, slot0.factorList, false)
end

function slot0.NextStageView(slot0)
	slot0.gameData.age = slot0.gameData.age + 1

	if ActivityCombineSettingCfg[slot0.gameData.age] == nil then
		slot0.gameData.nextStageTurn = 999

		return
	end

	slot0.gameData.nextStageTurn = slot1.rounds * slot0.gameData.turnRate
	slot5 = slot0.gameData.nextTurnCost[1] + slot1.food_cost
	slot6 = 0
	slot0.gameData.nextTurnCost[1] = math.max(slot5, slot6)

	for slot5, slot6 in ipairs(slot1.cells_list) do
		slot0.gameData.pool[slot5] = slot0.gameData.pool[slot5] + slot6
	end

	if slot0.gameData.stageFoodChange[slot0.gameData.age] then
		slot0.gameData.resourceChange[uv0.FOOD] = slot0.gameData.resourceChange[uv0.FOOD] + slot0.gameData.stageFoodChange[slot0.gameData.age]
	end

	slot0.tools.mapExtension = slot1.map_bigger == 1

	if slot0.gameData.age ~= 1 then
		slot0.nextStageTipsTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_CONSUME_INCREASE"), slot1.food_cost)
		slot0.stageDescTxt_.text = GetI18NText(slot1.desc)

		SetActive(slot0.nextStageTipsTxt_.transform.parent.gameObject, slot1.food_cost ~= 0)
		TimeTools.StartAfterSeconds(1, function ()
			SetActive(uv0.tipsGo_, true)
		end, {})
	end
end

function slot0.RoleLevelUpView(slot0)
	if slot0.gameData.roleLv == #ActivityCombineHeroCfg[slot0.heroId].level_unlock then
		return
	end

	slot0.oldLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot0.gameData.roleLv)
	slot0.gameData.roleLv = math.min(slot0.gameData.roleLv + 1, #slot1.level_unlock)
	slot0.newLvTxt_.text = string.format(GetTips("DORM_LEVEL_TIPS"), slot0.gameData.roleLv)
	slot0.levelUpTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_LEVEL_UP"), slot0.gameData.roleLv)
	slot0.gameData.tech = slot0.gameData.tech - slot0.gameData.nextTechNeed

	if ActivityCombineSettingCfg[slot0.gameData.age] == nil then
		print("daawasdfasfdaw" .. slot0.gameData.age)

		slot2 = ActivityCombineSettingCfg[slot0.gameData.age - 1]
	end

	slot3 = slot2.score

	if slot0.gameData.roleLv == #slot1.level_unlock then
		slot0.gameData.nextTechNeed = 0
	else
		slot0.gameData.nextTechNeed = math.floor(slot1.level_exp[slot0.gameData.roleLv] * slot0.gameData.techRate * (100 + slot3) / 100)
	end

	if ActivityCombineFactorCfg[slot1.level_unlock[slot0.gameData.roleLv]].effect_type == 1 then
		slot5 = ActivityCombineSkillCfg[slot4.effect[1]]
		slot0.skillDescTxt_.text = GetI18NText(slot5.description)
		slot0.skillImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot5.icon)
	else
		slot0.skillDescTxt_.text = GetI18NText(slot4.description)
		slot0.skillImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot4.icon)
	end

	if slot0.gameData.nextTechNeed == 0 then
		slot0.expSlider_.value = 1
	else
		slot0.expSlider_.value = slot0.gameData.tech / slot0.gameData.nextTechNeed
	end

	if manager.guide:IsPlaying() then
		TimeTools.StartAfterSeconds(0.07, function ()
			SetActive(uv0.levelUpGo_, true)
		end, {})
	else
		TimeTools.StartAfterSeconds(1, function ()
			SetActive(uv0.levelUpGo_, true)
		end, {})
	end

	CombineGameFactory:NewFactor(slot1.level_unlock[slot0.gameData.roleLv], true)

	if slot0.gameData.needRefreshSkill then
		slot0.gameData.needRefreshSkill = false

		slot0:UpdateGameData()
		slot0:UpdateSkill()
	elseif slot0.gameData.needRefreshBlock then
		slot0.gameData.needRefreshBlock = false

		slot0:UpdateGameData()
		slot0.tools:RefreshAllBlock()
	end

	slot0.tools:RefreshSkillStage()
end

function slot0.ShowBaseInfoView(slot0, slot1, slot2)
	SetActive(slot0.pop6Go_, true)

	slot0.pop6Go_.transform.position = slot2.transform.position
	slot0.pop6DescTxt_.text = GetTips(uv0[slot1])
end

function slot0.CalculateScore(slot0)
	for slot5, slot6 in pairs(slot0.factorList or {}) do
		slot1 = 0 + ActivityCombineFactorCfg[slot5].score
	end

	return slot1
end

function slot0.BuryPoint(slot0)
	if slot0.needBury == false then
		return
	end

	if slot0.needBury == true then
		slot0.needBury = false
	end

	slot2 = {}

	for slot6 = 1, slot0.tools:DetailBuryPointNeedData().Count do
		if slot2[slot1[slot6 - 1]] == nil then
			slot2[slot1[slot6 - 1]] = 1
		else
			slot2[slot1[slot6 - 1]] = slot2[slot1[slot6 - 1]] + 1
		end
	end

	for slot7, slot8 in pairs(slot2) do
		table.insert({}, slot7 .. "," .. slot8)
	end

	slot4 = slot0.tools.skillUseCount

	for slot9, slot10 in ipairs(ActivityCombineSkillCfg.all) do
		if slot4:TryGetValue(slot10, nil) then
			-- Nothing
		end
	end

	slot6 = {}

	for slot10, slot11 in pairs({
		[slot10] = slot4[slot10]
	}) do
		table.insert(slot6, slot10 .. "," .. slot11)
	end

	SDKTools.SendMessageToSDK("match_threepuzzle_over", {
		hero_id = slot0.heroId,
		level_id = slot0.gameData.roleLv,
		stage_id = slot0.levelId,
		battle_times = slot0.gameData.nowTurn,
		point_list = table.toString(slot3),
		skill_list = table.toString(slot6),
		result = slot0.result,
		score = ActivityCombineLevelCfg[slot0.levelId].type == 3 and slot0:CalculateScore() or nil
	})
end

function slot0.OnExit(slot0)
	slot0:BuryPoint()
	slot0.tools:ResetGame()
	slot0.tools:EndDrag()

	slot0.foodAddTxt_.text = ""
	slot0.rockAddTxt_.text = ""
	slot0.techAddTxt_.text = ""

	SetActive(slot0.tipsGo_, false)
	SetActive(slot0.winGo_, false)
	SetActive(slot0.loseGo_, false)
	SetActive(slot0.levelUpGo_, false)
	SetActive(slot0.informationGo_, false)
	SetActive(slot0.pop6Go_, false)
	SetActive(slot0.foodPopGo_, false)
	SetActive(slot0.tipsPopGo_, false)
end

function slot0.Dispose(slot0)
	slot0:BuryPoint()
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
