slot0 = class("RankBaseView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Polyhedron/PolyhedronRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.rankTypeController_ = ControllerUtil.GetController(slot0.m_rankTypeController, "toggle")
	slot0.subTypeController_ = ControllerUtil.GetController(slot0.m_subTypeController, "subType")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, RankItemBase)
	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.heroListGo_, RankHeroItemBase)
	slot0.heroClickHandler_ = handler(slot0, slot0.OnClickHero)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	SetActive(slot0.panelGo_, false)

	slot0.initCache_ = {}
	slot0.heroCache_ = {}

	slot0:RefreshGuildRankGo()
	RankAction.QueryActivityAllRank(slot0:GetRankID(), function ()
		RankAction.QueryActivityRankWitchCallBack(uv0:GetRankID(), 0, function ()
			uv0.heroIDList_, uv0.trialIDList_ = uv0:GetHeroList()
			uv0.rankType_ = uv0.params_.type or RankBaseConst.RANK_TYPE.ALL
			uv0.subType_ = uv0.params_.subType or RankBaseConst.SUB_TYPE.BASE
			uv0.heroID_ = uv0.params_.heroID or uv0.heroIDList_[1]

			uv0:Refresh(uv0.rankType_, uv0.subType_, uv0.heroID_)
			uv0:AddTimer()
		end)
	end)
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()

	slot0.list_ = nil

	slot0.heroList_:Dispose()

	slot0.heroList_ = nil
	slot0.heroClickHandler_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_scoreBtn, nil, function ()
		if uv0.subType_ == RankBaseConst.SUB_TYPE.SCORE then
			return
		end

		uv0:SwitchRank(uv0.rankType_, RankBaseConst.SUB_TYPE.SCORE, uv0.heroID_)
	end)
	slot0:AddBtnListener(slot0.m_heroBtn, nil, function ()
		if uv0.subType_ == RankBaseConst.SUB_TYPE.HERO then
			return
		end

		RankAction.QueryActivityRankWitchCallBack(uv0:GetRankID(), uv0:GetSendSeverHeroID(uv0.heroID_), function ()
			uv0:SwitchRank(uv0.rankType_, RankBaseConst.SUB_TYPE.HERO, uv0.heroID_ or uv0.heroIDList_[1])
			uv0.heroList_:StartScroll(#uv0.heroIDList_)
		end)
	end)
	slot0:AddBtnListener(slot0.m_guildBtn, nil, function ()
		if uv0.rankType_ == RankBaseConst.RANK_TYPE.GUILD then
			return
		end

		uv0:SwitchRank(RankBaseConst.RANK_TYPE.GUILD, uv0.subType_, uv0.heroID_)
	end)
	slot0:AddBtnListener(slot0.m_allBtn, nil, function ()
		if uv0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
			return
		end

		uv0:SwitchRank(RankBaseConst.RANK_TYPE.ALL, uv0.subType_, uv0.heroID_)
	end)
end

function slot0.SwitchRank(slot0, slot1, slot2, slot3)
	slot4 = true

	if slot0.initCache_[slot1] and slot0.initCache_[slot1][slot2] then
		if slot2 == RankBaseConst.SUB_TYPE.HERO and not slot0.initCache_[slot1][slot2][slot3] then
			slot4 = false
		end
	else
		slot4 = false
	end

	if slot4 == true then
		slot0:Refresh(slot1, slot2, slot3)
	else
		slot5 = 0

		if slot1 == RankBaseConst.RANK_TYPE.GUILD then
			RankAction.QueryGuildActivityRankWitchCallBack(slot0:GetRankID(), (slot2 ~= RankBaseConst.SUB_TYPE.HERO or slot0:GetSendSeverHeroID(slot3)) and 0, function ()
				uv0:Refresh(uv1, uv2, uv3)
			end)
		else
			RankAction.QueryActivityRankWitchCallBack(slot0:GetRankID(), slot5, function ()
				uv0:Refresh(uv1, uv2, uv3)
			end)
		end
	end
end

function slot0.OnClickHero(slot0, slot1)
	if slot0.heroID_ == slot1 then
		return
	end

	for slot6, slot7 in pairs(slot0.heroList_:GetItemList()) do
		slot7:SetSelect(slot1)
	end

	slot0:SwitchRank(slot0.rankType_, slot0.subType_, slot1)
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.initCache_[slot1] = slot0.initCache_[slot1] or {}

	if slot2 == RankBaseConst.SUB_TYPE.SCORE then
		slot0.initCache_[slot1][slot2] = true
	else
		slot0.initCache_[slot1][slot2] = slot0.initCache_[slot1][slot2] or {}
		slot0.initCache_[slot1][slot2][slot3] = true
	end

	slot0.rankType_ = slot1
	slot0.subType_ = slot2

	if slot2 == RankBaseConst.SUB_TYPE.HERO then
		slot0.heroID_ = slot3 or slot0.heroIDList_[1]
	end

	slot4 = 0

	if slot0.rankType_ == RankBaseConst.RANK_TYPE.ALL then
		slot0.rankList_ = RankData:GetActivityRank(slot0:GetRankID(), (slot0.subType_ ~= RankBaseConst.SUB_TYPE.HERO or slot0:GetSendSeverHeroID(slot0.heroID_)) and 0) and slot5.rankList or {}

		if slot5 then
			slot0.m_rank.text, slot0.m_score.text = slot5:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	else
		slot0.rankList_ = RankData:GetGuildActivityRank(slot0:GetRankID(), slot4) and slot5.rankList or {}

		if slot5 then
			slot0.m_rank.text, slot0.m_score.text = slot5:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	end

	slot0.list_:StartScroll(#slot0.rankList_)

	if slot2 == RankBaseConst.SUB_TYPE.SCORE then
		slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot5.portrait)
		slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. (slot5 and slot5.icon_frame))

		if slot0.playerAnimator_ then
			SetActive(slot0.playerIconGo_, false)
			slot0.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		slot5 = HeroCfg[slot3]
		slot0.m_heroIcon.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. slot0:GetHeroSkinID(slot3))
		slot0.m_heroNameText_.text = string.format("%s·%s", slot5.name, slot5.suffix)

		if slot0.heroAnimator_ then
			SetActive(slot0.heroIconGo_, false)
			slot0.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	slot0.rankTypeController_:SetSelectedIndex(slot0.rankType_ - 1)
	slot0.subTypeController_:SetSelectedIndex(slot0.subType_ - 1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList_[slot1])
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		SetActive(slot0.m_guildGo, false)
	else
		SetActive(slot0.m_guildGo, true)
	end
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot3 = slot0.heroIDList_[slot1]

	slot2:SetData(slot3, slot0:GetRankID(), slot0:GetHeroSkinID(slot3), slot0:GetSendSeverHeroID(slot3))
	slot2:SetClickHandler(slot0.heroClickHandler_)
	slot2:SetSelect(slot0.heroID_)
end

function slot0.AddTimer(slot0)
	slot0.activityID_ = slot0:GetActivityID()
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime

	slot0:StopTimer()

	slot0.timeText_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.timeText_.text = GetTips("TIME_OVER")

			return
		end

		uv0.timeText_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()
	end

	slot0.timer_ = nil
end

function slot0.GetRankID(slot0)
	return slot0.params_.rankID or slot0:GetActivityID()
end

function slot0.GetActivityID(slot0)
	return slot0.params_.activityID
end

function slot0.GetHeroList(slot0)
	return RankTools.GetRankHeroList(slot0:GetRankID(), slot0:GetActivityID())
end

function slot0.GetHeroSkinID(slot0, slot1)
	if slot0.trialIDList_[table.keyof(slot0.heroIDList_, slot1)] == nil or slot3 == 0 then
		return HeroTools.HeroUsingSkinInfo(slot1).id
	else
		return HeroStandardSystemCfg[slot3].skin_id
	end
end

function slot0.GetSendSeverHeroID(slot0, slot1)
	if slot0.trialIDList_[table.keyof(slot0.heroIDList_, slot1)] and slot0.trialIDList_[slot2] ~= 0 then
		return slot0.trialIDList_[slot2]
	end

	return slot1
end

return slot0
