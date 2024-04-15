slot0 = class("ActivityInviteRegionView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionConserverUI/JapanRegionCarteUI"
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

	slot4 = ActivityInviteHeadItem
	slot0.list = LuaList.New(handler(slot0, slot0.SetItem), slot0.listGo_, slot4)
	slot0.drawController = ControllerUtil.GetController(slot0.drawGo_.transform, "state")
	slot0.listController = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot0.regionItem = {}

	for slot4 = 1, 6 do
		slot0.regionItem[slot4] = ActivityInviteRegionItem.New(slot0["regionGo" .. slot4 .. "_"])
	end
end

function slot0.SetItem(slot0, slot1, slot2)
	slot3 = InviteData:GetDataByPara("heroPlotList")

	slot2:SetData({
		heroId = slot3[slot1][1].hero_id,
		image = slot3[slot1][1].hero_image_route
	}, slot1, handler(slot0, slot0.SelectListener), slot0.selectIndex)
end

function slot0.SelectListener(slot0, slot1, slot2)
	if slot1 == slot0.selectIndex then
		return
	end

	if slot0.completeHeroTable[slot2] then
		slot0.selectIndex = slot1

		slot0:UpdateView()
	else
		slot0.selectIndex = nil

		slot0:Back()
		JumpTools.GoToSystem("/ActivityInviteMain", {
			needBack = false,
			selectIndex = slot1
		})
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.drawBtn_, nil, function ()
		JumpTools.GoToSystem("/draw", {
			poolId = InviteData:GetDataByPara("poolID")
		}, ViewConst.SYSTEM_ID.DRAW)
	end)
end

function slot0.UpdateView(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	slot0.inviteTimes = InviteData:GetDataByPara("inviteTimes")
	slot0.completeHeroTable = InviteData:GetDataByPara("completeHeroTable")
	slot0.heroPlotList = InviteData:GetDataByPara("heroPlotList")[slot0.selectIndex]
	slot0.heroId = slot0.heroPlotList[1].hero_id
	slot0.InviteTime_.text = string.format(GetTips("ACTIVITY_INVITE_TIME"), slot0.inviteTimes)
	slot0.inviteTxt_.text = string.format(GetTips("ACTIVITY_INVITE_REWARD_TIME"), GameSetting.activity_invite_daily_opportunities.value[1] - (#slot0.completeHeroTable[slot0.heroId] - 1) % 3)
	slot0.activityId = InviteData:GetDataByPara("activityId")
	slot7 = slot0.heroPlotList[1].hero_image_route
	slot0.roleIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/VersionUI/JapanRegionUI_2_6/" .. slot7)
	slot0.nameTxt_.text = GetI18NText(HeroCfg[slot0.heroId].suffix)

	for slot7 = 1, 6 do
		slot0.regionItem[slot7]:SetData(slot0.heroPlotList[slot7 + 1].id, slot7)
	end

	SetActive(slot0.headListGo_, #slot0.completeHeroTable[slot0.heroId] == 7)
	slot0.listController:SetSelectedState(#slot0.completeHeroTable[slot0.heroId] == 7 and "2" or "1")

	if #slot0.completeHeroTable[slot0.heroId] == 7 then
		slot0.list:StartScroll(#slot1)
	end

	slot0:UpdateDrawController()

	slot4 = ActivityData:GetActivityData(slot0.activityId)
	slot0.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(slot4.stopTime, nil, true)
	slot0.updateTimer_ = Timer.New(function ()
		uv0.remainTime_.text = GetTips("REMAINING_TIME") .. manager.time:GetLostTimeStr2(uv1.stopTime, nil, true)
	end, 1, slot4.stopTime, 1)

	slot0.updateTimer_:Start()
end

function slot0.UpdateFreeDraw(slot0)
	slot0:UpdateDrawController()
end

function slot0.UpdateDrawController(slot0)
	slot3 = InviteData:GetDataByPara("inviteTimes")
	slot4 = InviteData:GetDataByPara("allComplete")

	if ItemTools.getItemNum(InviteData:GetDataByPara("drawItemId")) > 0 then
		slot0.drawController:SetSelectedState("2")
	elseif slot3 == 0 and slot2 == 0 or slot4 then
		slot0.drawController:SetSelectedState("3")
	else
		slot0.drawController:SetSelectedState("1")
	end
end

function slot0.OnInviteUpdate(slot0, slot1)
	slot0:UpdateView()

	if slot1 == nil then
		return
	end

	JumpTools.GoToSystem("ActivityInvitePlotView", {
		id = slot1,
		haveReward = slot0.getReward
	})

	slot0.getReward = nil
end

function slot0.OnInviteGetReward(slot0, slot1)
	slot0.getReward = slot1 ~= nil
end

function slot0.OnEnter(slot0)
	slot0.selectHeroIndex = 1
	slot0.selectIndex = slot0.selectIndex or slot0.params_.selectIndex
	slot0.params_.selectIndex = nil

	manager.redPoint:bindUIandKey(slot0.drawGo_.transform, RedPointConst.INVITE_DRAW, {
		x = 50,
		y = 70
	})
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
	if slot0.updateTimer_ then
		slot0.updateTimer_:Stop()

		slot0.updateTimer_ = nil
	end

	manager.redPoint:unbindUIandKey(slot0.drawGo_.transform, RedPointConst.INVITE_DRAW)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.regionItem) do
		slot5:Dispose()
	end

	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	Object.Destroy(slot0.gameObject_)
end

return slot0
