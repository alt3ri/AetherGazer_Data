slot0 = class("PushSnowBallRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/IndiaUI_2_8/IndiaPushTheSnowballUI/PushTheSnowballRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rankTypeConst_ = PushSnowBallData:GetRankTypeConst()

	slot0:InitUI()

	slot0.modeController_ = ControllerUtil.GetController(slot0.transform_, "mode")
	slot0.guildController_ = ControllerUtil.GetController(slot0.guildBtn_.transform, "toggle")
	slot0.allController_ = ControllerUtil.GetController(slot0.allBtn_.transform, "toggle")
	slot0.bossController_ = ControllerUtil.GetController(slot0.bossModelBtn_.transform, "toggle")
	slot0.survivalController_ = ControllerUtil.GetController(slot0.survivalModelBtn_.transform, "toggle")

	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.rankList_, PushSnowBallRankItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		if PushSnowBallData:GetCurRankType() ~= uv0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(uv0.activityID_, uv0.index)
		end

		PushSnowBallData:SetCurRankType(uv0.rankTypeConst_.ALL)
		uv0.allController_:SetSelectedState("on")
		uv0.guildController_:SetSelectedState("off")
		uv0:Refresh()
	end)
	slot0:AddBtnListener(slot0.guildBtn_, nil, function ()
		if PushSnowBallData:GetCurRankType() ~= uv0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(uv0.activityID_, uv0.index)
		end

		PushSnowBallData:SetCurRankType(uv0.rankTypeConst_.GUILD)
		uv0.guildController_:SetSelectedState("on")
		uv0.allController_:SetSelectedState("off")
		uv0:Refresh()
	end)
	slot0:AddBtnListener(slot0.bossModelBtn_, nil, function ()
		uv0:OnClickSubType(1)
		uv0.bossController_:SetSelectedState("on")
		uv0.survivalController_:SetSelectedState("off")
	end)
	slot0:AddBtnListener(slot0.survivalModelBtn_, nil, function ()
		uv0:OnClickSubType(2)
		uv0.survivalController_:SetSelectedState("on")
		uv0.bossController_:SetSelectedState("off")
	end)
end

function slot0.OnClickSubType(slot0, slot1)
	if slot0.index ~= slot1 then
		if PushSnowBallData:GetCurRankType() == slot0.rankTypeConst_.ALL then
			RankAction.QueryActivityRank(slot0.activityID_, slot1)
		elseif slot2 == slot0.rankTypeConst_.GUILD then
			RankAction.QueryGuildActivityRank(slot0.activityID_, slot1)
		end
	end

	slot0.index = slot1

	slot0:Refresh()
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = PushSnowBallData:GetTeamRankActivtyID()
	slot1 = ActivityData:GetActivityData(slot0.activityID_)

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.startTime_ = slot1.startTime
	slot0.stopTime_ = slot1.stopTime
	slot0.index = 1

	RankAction.QueryActivityRank(slot0.activityID_, slot0.index)
	slot0.bossController_:SetSelectedState("on")
	slot0.survivalController_:SetSelectedState("off")
	slot0:Refresh()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0.pos_ = slot0.list_:GetScrolledPosition()

	slot0:StopTimer()
	manager.windowBar:HideBar()
	PushSnowBallData:SetCurRankType(slot0.rankTypeConst_.ALL)
end

function slot0.Refresh(slot0)
	slot1 = PushSnowBallData:GetCurRankType()

	if slot0.index == 1 then
		slot0.modeController_:SetSelectedState("boss")
	else
		slot0.modeController_:SetSelectedState("necking")
	end

	if slot1 == slot0.rankTypeConst_.ALL then
		slot0.rankList = RankData:GetActivityRank(slot0.activityID_, slot0.index) and slot2.rankList or {}

		if slot2 then
			slot0.rankText_.text, slot0.scoreText_.text = slot2:GetCurRankDes()
		else
			slot0.rankText_.text = ""
			slot0.scoreText_.text = ""
		end
	else
		slot0.rankList = RankData:GetGuildActivityRank(slot0.activityID_, slot0.index) and slot2.rankList or {}

		if slot2 then
			slot0.rankText_.text, slot0.scoreText_.text = slot2:GetCurRankDes()
		else
			slot0.rankText_.text = ""
			slot0.scoreText_.text = ""
		end
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot0.pos_ then
		slot0.list_:SetScrolledPosition(slot0.pos_)
	end

	slot0.nameText_.text = PlayerData:GetPlayerInfo() and slot2.nick
	slot0.iconImg_.sprite = ItemTools.getItemSprite(slot2 and slot2.portrait)
	slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)

	slot0:RefreshGuildRankGo()
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList[slot1], slot0.index)
end

function slot0.Dispose(slot0)
	if slot0.list_ then
		slot0.list_:Dispose()

		slot0.list_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.leftTimeText_.text = manager.time:GetLostTimeStr2(slot0.stopTime_, nil, true)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ < manager.time:GetServerTime() then
			return
		end

		uv0.leftTimeText_.text = manager.time:GetLostTimeStr2(uv0.stopTime_, nil, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		SetActive(slot0.guildBtn_.gameObject, false)
	else
		SetActive(slot0.guildBtn_.gameObject, true)
	end
end

function slot0.OnRankUpdate(slot0)
	slot0:Refresh()
end

return slot0
