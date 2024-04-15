slot0 = class("CombineGameEndlessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfEndlessUI"
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

	slot0.scoreController = ControllerUtil.GetController(slot0.gameObject_.transform, "score")
	slot0.textController = ControllerUtil.GetController(slot0.gameObject_.transform, "text")
	slot0.selectController = ControllerUtil.GetController(slot0.roleGo_.transform, "stage")
	slot0.factorController = ControllerUtil.GetController(slot0.gameObject_.transform, "factor")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.factorBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = uv0.id,
			selectFactorList = uv0.selectFactorList
		})
	end)
	slot0:AddBtnListener(slot0.newFactorBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = uv0.id,
			selectFactorList = uv0.selectFactorList
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameSelectFactorView", {
			id = uv0.id,
			selectFactorList = uv0.selectFactorList
		})

		uv0.isBegin = true
	end)
	slot0:AddBtnListener(slot0.roleBtn_, nil, function ()
		JumpTools.GoToSystem("/CombineGameRoleView", {
			lv = 999
		})
	end)
	slot0:AddBtnListener(slot0.hero1Btn_, nil, function ()
		uv0.selectHero = 1

		uv0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(uv0.activityId, uv0.heroList[2]) and "stage1" or "stage3")
	end)
	slot0:AddBtnListener(slot0.hero2Btn_, nil, function ()
		if CombineGameData:CheckHeroLock(uv0.activityId, uv0.heroList[2]) == false then
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (ActivityCombineHeroCfg[uv0.cfg.can_use_hero[2]].unlock_condition[1][2] - CombineGameData:GetDataByPara("nowDay") + 2) * 86400)))

			return
		end

		uv0.selectHero = 2

		uv0.selectController:SetSelectedState("stage2")
	end)
end

function slot0.OnCombineGameRefresh(slot0)
	slot0:UpdateView()
end

function slot0.OnEnter(slot0)
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(slot0.activityId) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	for slot4, slot5 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[slot4].type == CombineGameConst.TypeConst.ENDLESS then
			slot0.id = slot4
		end
	end

	slot0.selectHero = getData("CombineGame", "endless") or 1
	slot0.selectFactorList = {}

	slot0:GetLastFactor()
	slot0:UpdateView()

	if slot0.selectHero == 2 then
		slot0.selectController:SetSelectedState("stage2")
	else
		slot0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(slot0.activityId, slot0.heroList[2]) and "stage1" or "stage3")
	end
end

function slot0.GetLastFactor(slot0)
	if getData("CombineGame", "factor") == nil then
		return
	end

	for slot6, slot7 in ipairs(string.split(slot1, ":")) do
		slot0.selectFactorList[tonumber(slot7)] = true
	end
end

function slot0.UpdateView(slot0)
	slot0.cfg = ActivityCombineLevelCfg[slot0.id]
	slot0.activityId = CombineGameData:GetDataByPara("activityId")
	slot0.descTxt_.text = GetI18NText(slot0.cfg.description)

	slot0.textController:SetSelectedState("false")

	slot0.nowDay = CombineGameData:GetDataByPara("nowDay")
	slot0.heroList = slot0.cfg.can_use_hero

	slot0.scoreController:SetSelectedState(CombineGameData:GetDataByPara("stageDataTable")[slot0.id] ~= nil and "true" or "false")

	slot0.hero1Image_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[slot0.heroList[1]].icon)
	slot0.hero2Image_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[slot0.heroList[2]].icon)
	slot0.maxScoreTxt_.text = CombineGameData:GetDataByPara("score")
	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_3")
	slot0.titleDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_3")
	slot0.selectTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	slot0.editTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_EDIT")
	slot0.nowDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")
	slot0.maxDifficultyTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_MAX")
	slot0.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

	slot0:UpdateFactorAndScoreView()
end

function slot0.UpdateFactorAndScoreView(slot0)
	SetActive(slot0.selectGo_, next(slot0.selectFactorList) == nil)

	slot1 = 1
	slot2 = 1
	slot3 = 0
	slot4 = 0
	slot5 = 0

	for slot9 = 1, 4 do
		SetActive(slot0["upGo" .. slot9 .. "_"], false)
		SetActive(slot0["downGo" .. slot9 .. "_"], false)
	end

	for slot9, slot10 in pairs(slot0.selectFactorList) do
		slot11 = ActivityCombineFactorCfg[slot9]
		slot5 = slot5 + slot11.score

		if slot11.score < 0 then
			if slot1 <= 3 then
				SetActive(slot0["upGo" .. slot1 .. "_"], true)

				slot0["upImg" .. slot1 .. "_"].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot11.icon)
				slot1 = slot1 + 1
			else
				SetActive(slot0.upGo4_, true)

				slot0.upCountTxt_.text = slot3 + 1
			end
		elseif slot11.score > 0 then
			if slot2 <= 3 then
				SetActive(slot0["downGo" .. slot2 .. "_"], true)

				slot0["downImg" .. slot2 .. "_"].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot11.icon)
				slot2 = slot2 + 1
			else
				SetActive(slot0.downGo4_, true)

				slot0.downCountTxt_.text = slot4 + 1
			end
		end
	end

	slot0.factorController:SetSelectedState(slot2 == slot1 and slot1 == 1 and "false" or "true")

	slot0.scoreTxt_.text = slot5
end

function slot0.OnExit(slot0)
	slot0.isBegin = false

	saveData("CombineGame", "endless", slot0.selectHero)
	manager.windowBar:HideBar()
end

function slot0.OnSelectFactorSure(slot0, slot1)
	slot0.selectFactorList = slot1
	slot2 = nil
	slot3 = 1

	for slot7, slot8 in pairs(slot1) do
		slot2 = slot3 == 1 and slot7 or slot7 .. ":" .. slot7
		slot3 = slot3 + 1
	end

	saveData("CombineGame", "factor", slot2)
	slot0:UpdateFactorAndScoreView()

	if slot0.isBegin then
		slot0.isBegin = false

		CombineGameFactory:StartGame(slot0.id, slot0.selectFactorList, slot0.selectHero)
	end
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
