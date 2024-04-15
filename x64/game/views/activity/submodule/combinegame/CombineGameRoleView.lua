slot0 = class("CombineGameRoleView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfRoleUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, CombineGameRoleItem)
	slot0.selectController = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.roleController = ControllerUtil.GetController(slot0.gameObject_.transform, "role")
	slot0.stageController = ControllerUtil.GetController(slot0.roleGo_.transform, "stage")
	slot0.lockController = ControllerUtil.GetController(slot0.gameObject_.transform, "lock")
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData(slot0:UpdateShowTable()[slot1], slot0.lv, slot0.selectModel)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.skillBtn_, nil, function ()
		uv0.selectModel = 1

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.inbornBtn_, nil, function ()
		uv0.selectModel = 2

		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.role1Btn_, nil, function ()
		uv0.roleId = ActivityCombineHeroCfg.all[1]
		uv0.selectModel = 1

		uv0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(uv0.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.role2Btn_, nil, function ()
		uv0.roleId = ActivityCombineHeroCfg.all[2]
		uv0.selectModel = 1

		uv0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(uv0.activityId, ActivityCombineHeroCfg.all[2]) and "stage2" or "stage4")
		uv0:UpdateView()
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(slot0.activityId) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0.lv = slot0.params_.lv
	slot0.roleId = slot0.params_.roleId
	slot0.selectModel = 1

	SetActive(slot0.selectGo_, true)
	slot0:UpdateView()
	slot0.stageController:SetSelectedState(CombineGameData:CheckHeroLock(slot0.activityId, ActivityCombineHeroCfg.all[2]) and "stage1" or "stage3")
end

function slot0.UpdateView(slot0)
	if slot0.roleId == nil then
		slot0.roleId = ActivityCombineHeroCfg.all[1]
	end

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot1 = ActivityCombineHeroCfg[slot0.roleId]
	slot0.activityId = CombineGameData:GetDataByPara("activityId")
	slot0.nowDay = CombineGameData:GetDataByPara("nowDay")

	slot0.selectController:SetSelectedState(slot0.selectModel == 1 and "skill" or "inborn")
	slot0.roleController:SetSelectedState(slot0.lv ~= 999 and "hide" or "show")

	slot0.nameTxt_.text = GetI18NText(slot1.name)
	slot0.descTxt_.text = GetI18NText(slot1.description)
	slot0.skillTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_SKILL")
	slot0.inbornTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_HERO_FACTOR")
	slot0.lvTxt_.text = slot0.lv == 999 and #slot1.level_unlock or slot0.lv
	slot0.role1Img_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[1]].icon)
	slot0.role2Img_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]].icon)

	TimeTools.StartAfterSeconds(0.01, function ()
		uv0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/IndiaUI_2_8/" .. ActivityCombineHeroCfg[uv0.roleId].image)
	end, {})
	SetActive(slot0.lvGo_, slot0.lv ~= 999)

	slot0.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (ActivityCombineHeroCfg[ActivityCombineHeroCfg.all[2]].unlock_condition[1][2] - slot0.nowDay + 2) * 86400))
	slot0.timer_ = Timer.New(function ()
		uv1.lockTxt_.text = string.format(GetTips("ACTIVITY_COMBINE_GAME_HERO_UNLOCKED"), manager.time:GetLostTimeStr2(manager.time:GetNextFreshTime() + (uv0.unlock_condition[1][2] - uv1.nowDay + 2) * 86400))
	end, 1, -1)

	slot0.timer_:Start()
	slot0.lockController:SetSelectedState((CombineGameData:CheckHeroLock(slot0.activityId, ActivityCombineHeroCfg.all[2]) or slot0.roleId == ActivityCombineHeroCfg.all[1] or slot0.lv ~= 999) and "false" or "true")
	slot0.list:StartScroll(#slot0:UpdateShowTable())
end

function slot0.UpdateShowTable(slot0)
	slot2 = {}

	for slot6, slot7 in ipairs(ActivityCombineHeroCfg[slot0.roleId].level_unlock) do
		if slot0.selectModel == 1 and ActivityCombineFactorCfg[slot7].effect_type == 1 then
			table.insert(slot2, {
				id = slot7,
				lv = slot6
			})
		elseif slot0.selectModel == 2 and slot8.effect_type ~= 1 then
			table.insert(slot2, {
				id = slot7,
				lv = slot6
			})
		end
	end

	return slot2
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

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
