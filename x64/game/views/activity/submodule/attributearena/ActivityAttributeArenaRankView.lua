slot0 = class("ActivityAttributeArenaRankView", ReduxView)

function slot0.UIName(slot0)
	return AttributeArenaTools.GetRankUI(slot0.params_.rank_activity_id)
end

slot1 = {
	ALL = 1,
	GUILD = 2
}

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.curRankType_ = uv0.ALL

	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityAttributeArenaRankItem)
	slot0.switchList = LuaList.New(handler(slot0, slot0.IndexSwitchItem), slot0.switchList_, ActivityAttributeArenaRankSwitchItem)
	slot0.switchItemClickHandle = handler(slot0, slot0.SwitchItemClick)
	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.rankList_[slot1])
end

function slot0.IndexSwitchItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.index)
	slot2:RegistCallBack(slot0.switchItemClickHandle)
end

function slot0.SwitchItemClick(slot0, slot1)
	slot0.params_.index = slot1
	slot0.index = slot1

	RankAction.QueryActivityRank(slot0.activityID_, slot0.index)

	if GuildData:GetGuildInfo().id == nil then
		slot0.tabNumController_:SetSelectedState("01")

		slot0.curRankType_ = uv0.ALL
	else
		slot0.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(slot0.activityID_, slot0.index)
	end

	slot0.switchList:Refresh()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.clubBtn_, nil, function ()
		uv0:SwitchPageIfDiff(uv1.GUILD)
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:SwitchPageIfDiff(uv1.ALL)
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.rank_activity_id

	if slot0.params_.index then
		slot0.index = slot0.params_.index
	else
		slot0.index = 1
	end

	RankAction.QueryActivityRank(slot0.activityID_, slot0.index)

	if GuildData:GetGuildInfo().id == nil then
		slot0.tabNumController_:SetSelectedState("01")

		slot0.curRankType_ = uv0.ALL
	else
		slot0.tabNumController_:SetSelectedState("02")
		RankAction.QueryGuildActivityRank(slot0.activityID_, slot0.index)
	end

	slot0.switchList:StartScroll(3)
	slot0:RefreshUI()
end

function slot0.SwitchPageIfDiff(slot0, slot1)
	if slot0.curRankType_ ~= slot1 then
		slot0.curRankType_ = slot1

		slot0:RefreshUI()
	end
end

function slot0.RefreshUI(slot0)
	slot0:RefreshSelfRank()
	slot0:RefreshList()
end

function slot0.RefreshSelfRank(slot0)
	slot0.icon_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot1.portrait)
	slot0.frame_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot1.icon_frame)
	slot0.name_.text = slot1.nick

	if slot0.curRankType_ == uv0.ALL then
		if RankData:GetActivityRank(slot0.activityID_, slot0.index) then
			slot0.rank_.text, slot0.score_.text = slot2:GetCurRankDes()
		else
			slot0.rank_.text = ""
			slot0.score_.text = ""
		end

		slot0.tabController_:SetSelectedState("all")
	else
		if RankData:GetGuildActivityRank(slot0.activityID_, slot0.index) then
			slot0.rank_.text, slot0.score_.text = slot2:GetCurRankDes()
		else
			slot0.rank_.text = ""
			slot0.score_.text = ""
		end

		slot0.tabController_:SetSelectedState("club")
	end
end

function slot0.RefreshNone(slot0)
	slot0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	slot0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function slot0.RefreshList(slot0)
	if slot0.curRankType_ == uv0.ALL then
		slot0.rankList_ = RankData:GetActivityRank(slot0.activityID_, slot0.index) and slot1.rankList or {}
	else
		slot0.rankList_ = RankData:GetGuildActivityRank(slot0.activityID_, slot0.index) and slot1.rankList or {}
	end

	slot0.scrollHelper_:StartScroll(#slot0.rankList_)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:SwitchPageIfDiff(uv0.ALL)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	slot0.switchList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnRankUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.AdaptLeft(slot0)
	if slot0.leftTrs_ == nil then
		slot0.leftGo_ = slot0:FindGo("RankUI_01/panel/left")
		slot0.leftTrs_ = slot0.leftGo_:GetComponent(typeof(RectTransform))
		slot0.needAdaptLeft_ = false
	end

	uv0.super.AdaptLeft(slot0)
end

function slot0.AdaptRight(slot0)
	if slot0.rightTrs_ == nil then
		slot0.rightGo_ = slot0:FindGo("RankUI_01/panel/right_adapt")
		slot0.rightTrs_ = slot0.rightGo_:GetComponent(typeof(RectTransform))
		slot0.needAdaptRight_ = true
	end

	uv0.super.AdaptRight(slot0)
end

return slot0
