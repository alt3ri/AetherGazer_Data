slot0 = class("CombineGameWatchFactorView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfGlossaryUI"
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
	slot2:SetData(slot1, slot3)
end

function slot0.AddUIListener(slot0)
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

	slot0.id = slot0.params_.id
	slot0.factorList = slot0.params_.factorList

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.upList = {}
	slot0.downList = {}

	slot0[slot0.factorList == nil and "UpdateLevelView" or "UpdateFactorView"](slot0)

	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR")
	slot0.upTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_FRONT")
	slot0.downTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_FACTOR_NEGATIVE")

	slot0.list1:StartScroll(#slot0.upList)
	slot0.list2:StartScroll(#slot0.downList)
end

function slot0.UpdateLevelView(slot0)
	for slot6, slot7 in ipairs(slot1[CombineGameConst.TypeConst.ENDLESS == ActivityCombineLevelCfg[slot0.id].type and "select_entry" or "default_entry"]) do
		if ActivityCombineFactorCfg[slot7].score < 0 then
			table.insert(slot0.upList, slot7)
		elseif slot8.score > 0 then
			table.insert(slot0.downList, slot7)
		end
	end
end

function slot0.UpdateFactorView(slot0)
	for slot4, slot5 in pairs(slot0.factorList) do
		if ActivityCombineFactorCfg[slot4].score < 0 then
			table.insert(slot0.upList, slot4)
		elseif slot6.score > 0 then
			table.insert(slot0.downList, slot4)
		end
	end
end

function slot0.OnExit(slot0)
	slot0.params_.id = nil
	slot0.params_.factorList = nil

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
