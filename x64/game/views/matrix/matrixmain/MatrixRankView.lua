slot0 = class("MatrixRankView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Matrix/Main/MatrixRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rankTypeController = ControllerUtil.GetController(slot0.m_rankTypeController, "toggle")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, MatrixRankItem)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_guildBtn, nil, function ()
		uv0:SelectRankType(MatrixConst.MatirxRankType.GUILD)
	end)
	slot0:AddBtnListener(slot0.m_allBtn, nil, function ()
		uv0:SelectRankType(MatrixConst.MatirxRankType.ALL)
	end)
end

function slot0.SelectRankType(slot0, slot1)
	if slot0.rankType == slot1 then
		return
	end

	slot0:Refresh(slot1)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnUpdate(slot0)
	slot0:Refresh(slot0.params_.type)
end

function slot0.OnEnter(slot0)
	slot0:RefreshGuildRankGo()
	RankAction.QueryCommonRank(RankConst.RANK_ID.MATRIX)

	if GuildData:GetGuildInfo() and slot1.id ~= nil and slot1.id ~= 0 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.MATRIX)
	end

	slot0:Refresh(slot0.params_.type)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0, slot1)
	slot0.rankType = slot1

	if slot0.rankType == MatrixConst.MatirxRankType.ALL then
		slot0.rankList = RankData:GetCommonRank(RankConst.RANK_ID.MATRIX) and slot2.rankList or {}

		if slot2 then
			slot0.m_rank.text, slot0.m_score.text = slot2:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	else
		slot0.rankList = RankData:GetGuildCommonRank(RankConst.RANK_ID.MATRIX) and slot2.rankList or {}

		if slot2 then
			slot0.m_rank.text, slot0.m_score.text = slot2:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	end

	slot0.list_:StartScroll(#slot0.rankList)

	slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot2.portrait)
	slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot2.icon_frame)

	slot0.rankTypeController:SetSelectedIndex(slot0.rankType - 1)
end

function slot0.RefreshNone(slot0)
	slot0.m_rank.text = GetTips("MATRIX_RANK_NO_RANK")
	slot0.m_score.text = GetTips("MATRIX_RANK_NO_INFO")
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
		SetActive(slot0.m_guildGo, false)
	else
		SetActive(slot0.m_guildGo, true)
	end
end

function slot0.OnRankUpdate(slot0)
	slot0:Refresh(slot0.rankType)
end

return slot0
