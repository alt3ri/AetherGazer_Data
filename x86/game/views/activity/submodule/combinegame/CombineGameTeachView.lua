slot0 = class("CombineGameTeachView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaKf/IndiaKfTeachUI"
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

	slot0.list1 = LuaList.New(handler(slot0, slot0.SetRewardItem1), slot0.list1Go_, CommonItem)
	slot0.list2 = LuaList.New(handler(slot0, slot0.SetRewardItem2), slot0.list2Go_, CommonItem)
	slot0.list3 = LuaList.New(handler(slot0, slot0.SetRewardItem3), slot0.list3Go_, CommonItem)
	slot0.controller1 = ControllerUtil.GetController(slot0.gameObject_.transform, "stage1")
	slot0.controller2 = ControllerUtil.GetController(slot0.gameObject_.transform, "stage2")
	slot0.controller3 = ControllerUtil.GetController(slot0.gameObject_.transform, "stage3")
end

function slot0.SetRewardItem1(slot0, slot1, slot2)
	slot0:SetRewardItem(slot1, slot2, ActivityCombineLevelCfg[slot0.idList[1]])
end

function slot0.SetRewardItem2(slot0, slot1, slot2)
	slot0:SetRewardItem(slot1, slot2, ActivityCombineLevelCfg[slot0.idList[2]])
end

function slot0.SetRewardItem3(slot0, slot1, slot2)
	slot0:SetRewardItem(slot1, slot2, ActivityCombineLevelCfg[slot0.idList[3]])
end

function slot0.SetRewardItem(slot0, slot1, slot2, slot3)
	slot4 = slot3.reward_list

	slot2:RefreshData({
		id = slot4[slot1][1],
		number = slot4[slot1][2]
	})
	slot2:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			slot0.id,
			slot0.number
		})
	end)
end

function slot0.AddUIListener(slot0)
	for slot4 = 1, 3 do
		slot0:AddBtnListener(slot0["start" .. slot4 .. "Btn_"], nil, function ()
			if uv0["controller" .. uv1]:GetSelectedState() == "lock" then
				ShowTips(string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[uv0.idList[1]].name)))

				return
			end

			CombineGameFactory:StartGame(uv0.idList[uv1], nil, 1)
			manager.redPoint:setTip(string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(uv0.activityId), uv0.activityId, uv0.idList[uv1]), 0)
		end)
	end
end

function slot0.OnEnter(slot0)
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	if not ActivityData:GetActivityIsOpen(slot0.activityId) then
		gameContext:Go("/home", nil, , true)
		ShowTips("TIME_OVER")

		return
	end

	slot0:UpdateView()
	slot0:BindRedPoint()
end

function slot0.UpdateView(slot0)
	slot0.idList = {}
	slot0.activityId = CombineGameData:GetDataByPara("activityId")

	for slot4, slot5 in ipairs(ActivityCombineLevelCfg.all) do
		if ActivityCombineLevelCfg[slot4].type == CombineGameConst.TypeConst.TEACH or slot6.type == CombineGameConst.TypeConst.HERO_TEACH then
			table.insert(slot0.idList, slot4)
		end
	end

	slot1 = CombineGameData:GetDataByPara("stageDataTable")

	for slot5, slot6 in ipairs(slot0.idList) do
		slot7 = ActivityCombineLevelCfg[slot5]

		slot0["list" .. slot5]:StartScroll(#slot7.reward_list)

		slot0["title" .. slot5 .. "Txt_"].text = GetI18NText(slot7.name)
		slot0["start" .. slot5 .. "Txt_"].text = GetTips("ACTIVITY_COMBINE_GAME_BEGIN")

		slot0["controller" .. slot5]:SetSelectedState("normal")

		if slot0["lock" .. slot5 .. "Txt_"] then
			slot0["lock" .. slot5 .. "Txt_"].text = string.format(GetTips("ACTIVITY_COMBINE_GAME_OPEN_LIMIT_TIPS"), GetI18NText(ActivityCombineLevelCfg[slot0.idList[1]].name))
		end

		if slot1[slot0.idList[slot5]] == true then
			slot0["controller" .. slot5]:SetSelectedState("pass")
		elseif slot5 > 1 then
			slot0["controller" .. slot5]:SetSelectedState(slot1[slot0.idList[1]] == true and "normal" or "lock")
		else
			slot0["controller" .. slot5]:SetSelectedState("normal")
		end
	end

	slot0.titleTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_NAME_1")
	slot0.descTxt_.text = GetTips("ACTIVITY_COMBINE_GAME_MODE_CONTENT_1")
end

function slot0.OnCombineGameRefresh(slot0)
	slot0:UpdateView()
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[1]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(slot0.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[2]), {
		x = 105,
		y = 35
	})
	manager.redPoint:bindUIandKey(slot0.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[3]), {
		x = 105,
		y = 35
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.start1Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[1]))
	manager.redPoint:unbindUIandKey(slot0.start2Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[2]))
	manager.redPoint:unbindUIandKey(slot0.start3Btn_.transform, string.format("%s%s_TEACH_%d", ActivityTools.GetRedPointKey(slot0.activityId), slot0.activityId, slot0.idList[3]))
end

function slot0.OnExit(slot0)
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
	for slot4 = 1, 3 do
		if slot0["list" .. slot4] then
			slot0["list" .. slot4]:Dispose()

			slot0["list" .. slot4] = nil
		end
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
