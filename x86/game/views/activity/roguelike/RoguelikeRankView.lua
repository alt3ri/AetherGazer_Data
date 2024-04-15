slot0 = class("RoguelikeRankView", ReduxView)
slot1 = {
	ALL = 2,
	Club = 1
}

function slot0.UIName(slot0)
	return "UI/StrategyMatrix/StrategyMatrixRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.UIBackCount(slot0)
	return 2
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0.isInit_ = false
	slot0.rank_id = slot0.params_.rank_id

	RankAction.QueryActivityRank(slot0.rank_id)

	slot2 = GuildData.IsGuildValid(GuildData:GetGuildInfo().id)

	slot0.TogClub:SetActive(slot2)

	if slot2 then
		RankAction.QueryGuildActivityRank(slot0.rank_id)
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.InitUI(slot0)
	slot0.gameObject_:InjectUI(slot0)

	slot0.scroll = LuaList.New(handler(slot0, slot0.RefreshItem), slot0.GoList, RoguelikeRankItemView)
	slot0.toggleList = {
		slot0.TogClub,
		slot0.TogAll
	}
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.scroll then
		slot0.scroll:Dispose()

		slot0.scroll = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.SwitchTab(slot0, slot1)
	slot0.toggleList[slot1].isOn = true
	slot0.tab = slot1
	slot0.dataList = slot0:GetListFromIndex(slot0.rank_id, slot1)

	slot0:RefreshView()
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.RefreshView(slot0)
	slot0.ImgHead.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().portrait)
	slot0.ImgFrame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. PlayerData:GetPlayerInfo().icon_frame)

	if slot0.tab == uv0.Club then
		if RankData:GetGuildActivityRank(slot0.rank_id) then
			slot0.TxtMyRank.text, slot0.TxtMyScore.text = slot1:GetCurRankDes()
		else
			slot0.TxtMyRank.text = ""
			slot0.TxtMyScore.text = ""
		end
	elseif slot0.tab == uv0.ALL then
		if RankData:GetActivityRank(slot0.rank_id) then
			slot0.TxtMyRank.text, slot0.TxtMyScore.text = slot1:GetCurRankDes()
		else
			slot0.TxtMyRank.text = ""
			slot0.TxtMyScore.text = ""
		end
	end

	slot0.scroll:StartScroll(#slot0.dataList)
end

function slot0.RefreshItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.dataList[slot1], slot0.tab == uv0.Club)
end

function slot0.OnActivityMatrixRankUpdate(slot0)
	slot0:SwitchTab(uv0.ALL)
end

function slot0.AddUIListener(slot0)
	for slot4, slot5 in ipairs(slot0.toggleList) do
		slot0:AddToggleListener(slot5, function (slot0)
			if slot0 then
				uv0:SwitchTab(uv1)
			end
		end)
	end
end

function slot0.GetListFromIndex(slot0, slot1, slot2)
	slot3 = {}

	if slot2 == uv0.Club then
		slot3 = RankData:GetGuildActivityRank(slot0.rank_id) and slot4.rankList or {}
	elseif slot2 == uv0.ALL then
		slot3 = RankData:GetActivityRank(slot0.rank_id) and slot4.rankList or {}
	end

	table.sort(slot3, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)

	return slot3
end

function slot0.OnRankUpdate(slot0)
	slot0:SwitchTab(uv0.ALL)
end

return slot0
