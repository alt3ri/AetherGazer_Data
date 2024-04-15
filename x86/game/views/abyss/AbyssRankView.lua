slot0 = class("AbyssRankView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_Abyss/AbyssRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BindCfgUI(slot0.commonRankGo_)

	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
	slot0.rankList_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiListGo_, AbyssRankItemView)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.dataList_[slot1], slot0.curPage_ == 1)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clubBtn_, nil, function ()
		uv0:SwitchPageIfDiff(1)
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:SwitchPageIfDiff(2)
	end)
end

function slot0.AddEventListeners(slot0)
	slot0:RegistEventListener(ABYSS_RANK_UPDATE, function ()
		if not uv0.isInit_ then
			uv0:SwitchPage(2)

			uv0.isInit_ = true
		end
	end)
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.SwitchPage(slot0, slot1)
	if slot0.tabConState_ == nil then
		slot0.tabConState_ = {
			"club",
			"all"
		}
	end

	slot0.tabController_:SetSelectedState(slot0.tabConState_[slot1])

	slot0.curPage_ = slot1
	slot0.dataList_ = slot0:GetListFromIndex(slot1)

	slot0:UpdateView()
end

function slot0.SwitchPageIfDiff(slot0, slot1)
	if slot0.curPage_ ~= slot1 then
		slot0:SwitchPage(slot1)
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.isInit_ = false

	slot0:AddEventListeners()
	RankAction.QueryCommonRank(RankConst.RANK_ID.ABYSS)

	slot1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		slot1 = false
	end

	slot0.tabNumController_:SetSelectedState(slot1 and "02" or "01")

	if slot1 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.ABYSS)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.GetListFromIndex(slot0, slot1)
	if slot1 == 1 then
		return RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS) and slot2.rankList or {}
	else
		return RankData:GetCommonRank(RankConst.RANK_ID.ABYSS) and slot2.rankList or {}
	end
end

function slot0.UpdateView(slot0)
	slot0.rankList_:StartScroll(#slot0.dataList_)

	slot0.myHeadIcon_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().portrait)
	slot0.myHeadFrame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. PlayerData:GetPlayerInfo().icon_frame)

	if slot0.curPage_ == 1 then
		if RankData:GetGuildCommonRank(RankConst.RANK_ID.ABYSS) then
			slot0.myRankLabel_.text, slot0.myScoreLabel_.text = slot1:GetCurRankDes()
		else
			slot0.myRankLabel_.text = ""
			slot0.myScoreLabel_.text = ""
		end
	elseif RankData:GetCommonRank(RankConst.RANK_ID.ABYSS) then
		slot0.myRankLabel_.text, slot0.myScoreLabel_.text = slot1:GetCurRankDes()
	else
		slot0.myRankLabel_.text = ""
		slot0.myScoreLabel_.text = ""
	end
end

function slot0.OnMainHomeViewTop(slot0)
end

function slot0.Dispose(slot0)
	if slot0.rankList_ then
		slot0.rankList_:Dispose()

		slot0.rankList_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.OnRankUpdate(slot0)
	if not slot0.isInit_ then
		slot0:SwitchPage(2)

		slot0.isInit_ = true
	end
end

return slot0
