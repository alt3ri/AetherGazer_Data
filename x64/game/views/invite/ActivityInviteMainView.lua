slot0 = class("ActivityInviteMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionInvitationUI"
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

	slot0.itemViewList = {}
	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, ActivityInviteHeadItem)
	slot0.drawController = ControllerUtil.GetController(slot0.drawGo_.transform, "state")
end

function slot0.SetItem(slot0, slot1, slot2)
	slot2:SetData({
		heroId = slot0.heroPlotList[slot1][1].hero_id,
		image = slot0.heroPlotList[slot1][1].hero_image_route
	}, slot1, handler(slot0, slot0.SelectListener), slot0.selectIndex)
end

function slot0.AddUIListener(slot0)
	function slot1()
		if not InviteData:GetDataByPara("completeHeroTable")[uv0.heroPlotList[uv0.selectIndex][1].id] then
			InviteAction.CompletePlot(InviteData:GetDataByPara("activityId"), slot1)
		end
	end

	slot0:AddBtnListener(slot0.drawBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", {
			poolId = InviteData:GetDataByPara("poolID")
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
	slot0:AddBtnListener(slot0.inviteBtn_, nil, function ()
		slot1 = GetI18NText(HeroCfg[uv0.heroPlotList[uv0.selectIndex][1].hero_id].suffix)

		if uv0:SafeCheck() then
			uv0:Back()
			JumpTools.GoToSystem("/ActivityInviteRegionView", {
				selectIndex = uv0.selectIndex
			})

			return
		end

		if InviteData:GetDataByPara("inviteTimes") == 0 then
			ShowTips("ACTIVITY_INVITE_TIME_NOT_ENOUGH")

			return
		end

		ShowMessageBox({
			content = string.format(GetTips("ACTIVITY_INVITE_CONFIRM_TIPS"), slot1),
			OkCallback = uv1
		})
	end)
end

function slot0.SelectListener(slot0, slot1)
	if slot0.list:GetItemList()[slot1]:GetFinishController():GetSelectedState() == "2" then
		slot0:Back()
		JumpTools.GoToSystem("/ActivityInviteRegionView", {
			selectIndex = slot1
		})

		return
	end

	slot5 = slot0.list
	slot7 = slot5

	for slot6, slot7 in ipairs(slot5.GetItemList(slot7)) do
		if slot7:GetFinishController() ~= "2" then
			slot0.selectIndex = slot1

			slot7:GetController():SetSelectedState(slot6 == slot0.selectIndex and "true" or "false")
		end
	end

	slot0:UpdateRefreshView()
end

function slot0.UpdateDefaultView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0.activityId = InviteData:GetDataByPara("activityId")
	slot0.heroPlotList = InviteData:GetDataByPara("heroPlotList")
	slot0.drawItemId = InviteData:GetDataByPara("drawItemId")

	slot0.list:StartScroll(#slot0.heroPlotList)

	slot1 = ActivityData:GetActivityData(slot0.activityId)
	slot0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot1.stopTime, nil, true)
	slot0.updateTimer_ = Timer.New(function ()
		uv0.remainTxt_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv1.stopTime, nil, true)
	end, 1, slot1.stopTime, 1)
end

function slot0.UpdateRefreshView(slot0)
	slot0.nameTxt_.text = GetI18NText(HeroCfg[slot0.heroPlotList[slot0.selectIndex][1].hero_id].suffix)
	slot0.roleImg.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. tostring(slot0.heroPlotList[slot0.selectIndex][1].hero_image_route))

	slot0:UpdateDrawController()
end

function slot0.UpdateFreeDraw(slot0)
	slot0:UpdateDrawController()
end

function slot0.UpdateDrawController(slot0)
	slot3 = InviteData:GetDataByPara("allComplete")
	slot0.inviteTimeTxt_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), InviteData:GetDataByPara("inviteTimes"))
	slot0.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), GameSetting.activity_invite_daily_opportunities.value[1])

	if ItemTools.getItemNum(slot0.drawItemId) > 0 then
		slot0.drawController:SetSelectedState("2")
	elseif slot2 == 0 and slot1 == 0 or slot3 then
		slot0.drawController:SetSelectedState("3")
	else
		slot0.drawController:SetSelectedState("1")
	end
end

function slot0.OnEnter(slot0)
	slot0.selectIndex = slot0.params_.selectIndex or slot0:GetDefaultSelect()

	slot0:UpdateDefaultView()
	slot0:UpdateRefreshView()
	slot0:BindRedPoint()
end

function slot0.SafeCheck(slot0)
	slot0.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	if InviteData:GetDataByPara("completeHeroTable")[slot0.heroPlotList[slot0.selectIndex][1].hero_id] then
		return true
	end

	return false
end

function slot0.GetDefaultSelect(slot0)
	slot0.heroPlotList = InviteData:GetDataByPara("heroPlotList")

	for slot5, slot6 in ipairs(slot0.heroPlotList) do
		if InviteData:GetDataByPara("completeHeroTable")[slot6[1].hero_id] == nil then
			return slot5
		end
	end
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	manager.redPoint:bindUIandKey(slot0.inviteBtn_.transform, RedPointConst.INVITE_PLOT, {
		x = 150,
		y = 35
	})
end

function slot0.UnbindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.redPoint:unbindUIandKey(slot0.inviteBtn_.transform, RedPointConst.INVITE_PLOT)
end

function slot0.OnInviteUpdate(slot0)
	slot0:Back()
	JumpTools.GoToSystem("/ActivityInviteRegionView", {
		selectIndex = slot0.selectIndex
	})
end

function slot0.OnExit(slot0)
	slot0:UnbindRedPoint()

	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_INVITE_DESCRIPTION")
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
