slot0 = class("ActivityMatrixRankView", ReduxView)
slot1 = {
	ALL = 1,
	GUILD = 2
}

function slot0.UIName(slot0)
	return "UI/VolumeIIIUI/SoloRoguelike/VolumeSoloRoguelikeRankUI"
end

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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, ActivityMatrixRankItem)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.rankList_[slot1])
end

function slot0.AddUIListeners(slot0)
	slot0:AddToggleListener(slot0.allToggle_, function (slot0)
		if slot0 then
			uv0.curRankType_ = uv1.ALL

			uv0:RefreshUI()
		end
	end)
	slot0:AddToggleListener(slot0.guildToggle_, function (slot0)
		if slot0 then
			uv0.curRankType_ = uv1.GUILD

			uv0:RefreshUI()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityId

	RankAction.QueryActivityRank(slot0.activityID_)

	if GuildData:GetGuildInfo().id == nil then
		SetActive(slot0.guildToggleGo_, false)

		slot0.curRankType_ = uv0.ALL
	else
		SetActive(slot0.guildToggleGo_, true)
		RankAction.QueryGuildActivityRank(slot0.activityID_)
	end

	slot0:RefreshUI()
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
		if RankData:GetActivityRank(slot0.activityID_) then
			slot0.rank_.text, slot0.score_.text = slot2:GetCurRankDes()
		else
			slot0.rank_.text = ""
			slot0.score_.text = ""
		end
	elseif RankData:GetGuildActivityRank(slot0.activityID_) then
		slot0.rank_.text, slot0.score_.text = slot2:GetCurRankDes()
	else
		slot0.rank_.text = ""
		slot0.score_.text = ""
	end
end

function slot0.RefreshNone(slot0)
	slot0.rank_.text = GetTips("MATRIX_RANK_NO_RANK")
	slot0.score_.text = GetTips("MATRIX_RANK_NO_INFO")
end

function slot0.RefreshList(slot0)
	if slot0.curRankType_ == uv0.ALL then
		slot0.rankList_ = RankData:GetActivityRank(slot0.activityID_) and slot1.rankList or {}
	else
		slot0.rankList_ = RankData:GetGuildActivityRank(slot0.activityID_) and slot1.rankList or {}
	end

	table.sort(slot0.rankList_, function (slot0, slot1)
		return slot0.rank < slot1.rank
	end)
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

	slot0.allToggle_.isOn = true
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.OnActivityMatrixRankUpdate(slot0)
	slot0:RefreshUI()
end

function slot0.OnRankUpdate(slot0)
	slot0:RefreshUI()
end

return slot0
