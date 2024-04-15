slot0 = class("CombineGameSelectFactorView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryyUI"
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

	slot0.list1 = LuaList.New(handler(slot0, slot0.SetItem1), slot0.list1Go_, CombineGameFactorItem)
	slot0.list2 = LuaList.New(handler(slot0, slot0.SetItem2), slot0.list2Go_, CombineGameFactorItem)
end

function slot0.SetItem1(slot0, slot1, slot2)
	slot0:SetItem(slot1, slot2, slot0.upList[slot1])
end

function slot0.SetItem2(slot0, slot1, slot2)
	slot0:SetItem(slot1, slot2, slot0.downList[slot1])
end

function slot0.SetItem(slot0, slot1, slot2, slot3)
	slot2:SetData(slot1, slot3, handler(slot0, slot0.ClickCallBack), slot0.selectFactorList[slot3] or false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		manager.notify:CallUpdateFunc(COMBINE_GAME_SELECT_FACTOR_SURE, uv0.selectFactorList)
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

	slot0.id = slot0.params_.id
	slot0.selectFactorList = clone(slot0.params_.selectFactorList or {})

	slot0:UpdateView()
end

function slot0.ClickCallBack(slot0, slot1, slot2, slot3)
	if slot0.selectFactorList[slot2] then
		slot0.selectFactorList[slot2] = nil
	else
		slot0.selectFactorList[slot2] = true
	end

	slot3:SetSelectedState(slot0.selectFactorList[slot2] and "true" or "false")
	slot0:UpdateScore()
end

function slot0.UpdateView(slot0)
	slot0.upList = {}
	slot0.downList = {}

	for slot5, slot6 in ipairs(ActivityCombineLevelCfg[slot0.id].select_entry) do
		if ActivityCombineFactorCfg[slot6].score < 0 then
			table.insert(slot0.upList, slot6)
		elseif slot7.score > 0 then
			table.insert(slot0.downList, slot6)
		end
	end

	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	slot0.upTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	slot0.downTitleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")
	slot0.hardScoreTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_DIFFICULTY_RATING_NOW")

	slot0.list1:StartScroll(#slot0.upList)
	slot0.list2:StartScroll(#slot0.downList)
	slot0:UpdateScore()
end

function slot0.UpdateScore(slot0)
	slot1 = 0
	slot3 = 0

	for slot7, slot8 in pairs(slot0.selectFactorList) do
		if ActivityCombineFactorCfg[slot7].score < 0 then
			slot2 = 0 + 1
		elseif slot9.score > 0 then
			slot3 = slot3 + 1
		end

		slot1 = slot1 + slot9.score
	end

	slot0.upTxt_.text = slot2 .. "/" .. #slot0.upList
	slot0.downTxt_.text = slot3 .. "/" .. #slot0.downList
	slot0.scoreTxt_.text = slot1
end

function slot0.OnExit(slot0)
	slot0.selectFactorList = {}

	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	if slot0.list1 then
		slot0.list1:Dispose()

		slot0.list1 = nil
	end

	if slot0.list2 then
		slot0.list2:Dispose()

		slot0.list2 = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
