slot0 = class("CombineGameDailyView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiakfDailyUI"
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

	slot0.getController = ControllerUtil.GetController(slot0.gameObject_.transform, "get")
	slot0.selectController = ControllerUtil.GetController(slot0.roleGo_.transform, "stage")
	slot0.list = LuaList.New(handler(slot0, slot0.SetRewardItem), slot0.listGo_, CommonItem)
end

function slot0.SetRewardItem(slot0, slot1, slot2)
	slot3 = slot0.cfg.reward_list

	slot2:RefreshData({
		id = slot3[slot1][1],
		number = slot3[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.factorBtn_, nil, function ()
		JumpTools.GoToSystem("CombineGameWatchFactorView", {
			id = uv0.id
		})
	end)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		manager.redPoint:setTip(string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(uv0.activityId), uv0.activityId), 0)
		CombineGameFactory:StartGame(uv0.id, nil, uv0.selectHero)
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
			ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (ActivityCombineHeroCfg[uv0.cfg.can_use_hero[2]].unlock_condition[1][2] - uv0.id + 2) * 86400)))

			return
		end

		uv0.selectHero = 2

		uv0.selectController:SetSelectedState("stage2")
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(slot0.activityId) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0.id = CombineGameData:GetDataByPara("nowDay")
	slot0.selectHero = getData("CombineGame", "daily" .. slot0.id) or 1

	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.UpdateView(slot0)
	slot0.cfg = ActivityCombineLevelCfg[slot0.id]
	slot0.activityId = CombineGameData:GetDataByPara("activityId")
	slot0.descTxt_.text = GetTips(slot0.cfg.description)
	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_2")
	slot0.dailyDescTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_2")
	slot0.startTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")
	slot0.factorTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	slot0.selectFactorList = slot0.cfg.default_entry
	slot0.heroList = slot0.cfg.can_use_hero
	slot1 = CombineGameData:GetDataByPara("stageDataTable")[slot0.id]
	slot2 = ActivityCombineHeroCfg[slot0.heroList[1]]
	slot3 = ActivityCombineHeroCfg[slot0.heroList[2]]

	if slot0.selectHero == 2 then
		slot0.selectController:SetSelectedState("stage2")
	else
		slot0.selectController:SetSelectedState(CombineGameData:CheckHeroLock(slot0.activityId, slot0.heroList[2]) and "stage1" or "stage3")
	end

	slot0.getController:SetSelectedState(slot1 == true and "true" or "false")
	slot0.list:StartScroll(#slot0.cfg.reward_list)

	slot4 = 1
	slot5 = 1
	slot6 = 0
	slot7 = 0

	for slot11 = 1, 3 do
		SetActive(slot0["upGo" .. slot11 .. "_"], false)
		SetActive(slot0["downGo" .. slot11 .. "_"], false)
	end

	for slot11, slot12 in ipairs(slot0.selectFactorList) do
		if ActivityCombineFactorCfg[slot12].score < 0 then
			if slot4 <= 3 then
				SetActive(slot0["upGo" .. slot4 .. "_"], true)

				slot0["upImg" .. slot4 .. "_"].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot13.icon)
				slot4 = slot4 + 1
			else
				slot6 = slot6 + 1
			end
		elseif slot13.score > 0 then
			if slot5 <= 3 then
				SetActive(slot0["downGo" .. slot5 .. "_"], true)

				slot0["downImg" .. slot5 .. "_"].sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/combinegame/" .. slot13.icon)
				slot5 = slot5 + 1
			else
				slot7 = slot7 + 1
			end
		end
	end

	slot0.hero1Image_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. slot2.icon)
	slot0.hero2Image_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. slot3.icon)
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId), {
		x = 150,
		y = 35
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.startBtn_.transform, string.format("%s%s_DAILY", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId))
end

function slot0.OnCombineGameRefresh(slot0)
	slot0.id = CombineGameData:GetDataByPara("nowDay")

	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	saveData("CombineGame", "daily" .. slot0.id, slot0.selectHero)
	slot0:UnbindRedPoint()
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
