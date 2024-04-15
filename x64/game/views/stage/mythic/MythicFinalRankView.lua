slot0 = class("MythicFinalRankView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Mythic/MythicRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.rankTypeConst_ = MythicData:GetRankTypeConst()

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BindCfgUI(slot0.commonRankGo_)

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MythicFinalRankItem)
	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.clubBtn_, nil, function ()
		uv0:SwitchPageIfDiff(uv0.rankTypeConst_.GUILD)
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:SwitchPageIfDiff(uv0.rankTypeConst_.ALL)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MYTHIC)

	if GuildData:GetGuildInfo() and slot1.id ~= nil and slot1.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MYTHIC)
	end

	if slot0.params_.reset then
		slot0.params_.reset = nil

		slot0:SwitchPageIfDiff(slot0.rankTypeConst_.ALL)
	end

	slot0:Refresh()
end

function slot0.OnExit(slot0)
	slot0.pos_ = slot0.list_:GetScrolledPosition()

	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0)
	if MythicData:GetCurRankType() == slot0.rankTypeConst_.ALL then
		slot0.rankList = RankData:GetCommonRank(RankConst.RANK_ID.MYTHIC) and slot2.rankList or {}

		if slot2 then
			slot0.myRankLabel_.text, slot0.myScoreLabel_.text = slot2:GetCurRankDes()
		else
			slot0.myRankLabel_.text = ""
			slot0.myScoreLabel_.text = ""
		end

		slot0.tabController_:SetSelectedState("all")
	else
		slot0.rankList = RankData:GetGuildCommonRank(RankConst.RANK_ID.MYTHIC) and slot2.rankList or {}

		if slot2 then
			slot0.myRankLabel_.text, slot0.myScoreLabel_.text = slot2:GetCurRankDes()
		else
			slot0.myRankLabel_.text = ""
			slot0.myScoreLabel_.text = ""
		end

		slot0.tabController_:SetSelectedState("club")
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot0.pos_ then
		slot0.list_:SetScrolledPosition(slot0.pos_)
	end

	slot0.myHeadIcon_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot2.portrait)
	slot0.myHeadFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)
end

function slot0.SwitchPageIfDiff(slot0, slot1)
	if slot1 ~= MythicData:GetCurRankType() then
		MythicData:SetCurRankType(slot1)
		slot0:Refresh()
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)

	slot0.refreshGuildHandler_ = nil
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0.tabNumController_:SetSelectedState("01")
	else
		slot0.tabNumController_:SetSelectedState("02")
	end
end

function slot0.OnRankUpdate(slot0)
	slot0:Refresh()
end

return slot0
