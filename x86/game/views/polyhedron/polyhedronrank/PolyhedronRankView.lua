slot0 = class("PolyhedronRankView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Polyhedron/PolyhedronRankUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.subTypeController = ControllerUtil.GetController(slot0.m_subTypeController, "subType")
	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, PolyhedronRankItem)
	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.heroListGo_, PolyhedronRankHeroItem)
	slot0.heroClickHandler_ = handler(slot0, slot0.OnClickHero)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_scoreBtn, nil, function ()
		if uv0.subType == PolyhedronConst.RANK_SUB_TYPE.SCORE then
			return
		end

		uv0:SwitchRank(uv0.rankType, PolyhedronConst.RANK_SUB_TYPE.SCORE, uv0.heroID)
	end)
	slot0:AddBtnListener(slot0.m_heroBtn, nil, function ()
		if uv0.subType == PolyhedronConst.RANK_SUB_TYPE.HERO then
			return
		end

		if uv0.heroIDList_ == nil then
			PolyhedronAction.QueryCurRank(PolyhedronConst.RANK_SUB_TYPE.HERO, function ()
				uv0:SelectHeroRank()
			end)
		else
			uv0:SelectHeroRank()
		end
	end)
	slot0:AddBtnListener(slot0.m_guildBtn, nil, function ()
		if uv0.rankType == PolyhedronConst.RANK_TYPE.GUILD then
			return
		end

		uv0:SwitchRank(PolyhedronConst.RANK_TYPE.GUILD, uv0.subType, uv0.heroID)
	end)
	slot0:AddBtnListener(slot0.m_allBtn, nil, function ()
		if uv0.rankType == PolyhedronConst.RANK_TYPE.ALL then
			return
		end

		uv0:SwitchRank(PolyhedronConst.RANK_TYPE.ALL, uv0.subType, uv0.heroID)
	end)
end

function slot0.SelectHeroRank(slot0)
	slot0.heroIDList_ = PolyhedronData:GetSortRankHeroIDList()

	slot0:SwitchRank(slot0.rankType, PolyhedronConst.RANK_SUB_TYPE.HERO, slot0.heroID or slot0.heroIDList_[1])
	slot0.heroList_:StartScroll(#slot0.heroIDList_)
end

function slot0.SwitchRank(slot0, slot1, slot2, slot3)
	slot4 = true

	if slot0.initCache[slot1] and slot0.initCache[slot1][slot2] then
		if slot2 == PolyhedronConst.RANK_SUB_TYPE.HERO and not slot0.initCache[slot1][slot2][slot3] then
			slot4 = false
		end
	else
		slot4 = false
	end

	if slot4 == true then
		slot0:Refresh(slot1, slot2, slot3)
	elseif slot1 == PolyhedronConst.RANK_TYPE.GUILD then
		PolyhedronAction.QueryGuildRankList(slot2, slot3)
	else
		PolyhedronAction.QueryRankList(slot2, slot3)
	end
end

function slot0.OnClickHero(slot0, slot1)
	if slot0.heroID == slot1 then
		return
	end

	for slot6, slot7 in pairs(slot0.heroList_:GetItemList()) do
		slot7:SetSelect(slot1)
	end

	slot0:SwitchRank(slot0.rankType, slot0.subType, slot1)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnUpdate(slot0)
	if slot0.params_.type == nil then
		return
	end

	slot0.params_.type = nil
	slot0.params_.subType = nil
	slot0.params_.heroID = nil

	slot0:Refresh(slot0.params_.type, slot0.params_.subType, slot0.params_.heroID)
end

function slot0.OnEnter(slot0)
	slot0.panelAnim_:Update(0)

	slot0.initCache = {}
	slot0.heroCache = {}

	if slot0.params_.subType ~= PolyhedronConst.RANK_SUB_TYPE.HERO then
		slot0.heroIDList_ = nil
	else
		slot0.heroList_:StartScroll(#slot0.heroIDList_, table.indexof(slot0.heroIDList_, slot0.heroID) or 1)
	end

	slot0:RefreshGuildRankGo()
	slot0:OnUpdate()
	slot0:AddTimer()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
	manager.windowBar:HideBar()
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot0.initCache[slot1] = slot0.initCache[slot1] or {}

	if slot2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		slot0.initCache[slot1][slot2] = true
	else
		slot0.initCache[slot1][slot2] = slot0.initCache[slot1][slot2] or {}
		slot0.initCache[slot1][slot2][slot3] = true
	end

	slot0.rankType = slot1
	slot0.subType = slot2

	if slot2 == PolyhedronConst.RANK_SUB_TYPE.HERO then
		slot0.heroID = slot3 or slot0.heroIDList_[1]
	end

	slot4 = 0

	if slot0.rankType == PolyhedronConst.RANK_TYPE.ALL then
		slot0.rankList = RankData:GetCommonRank(RankConst.RANK_ID.POLYHERON, (slot0.subType ~= PolyhedronConst.RANK_SUB_TYPE.HERO or slot0.heroID) and 0) and slot5.rankList or {}

		if slot5 then
			slot0.m_rank.text, slot0.m_score.text = slot5:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	else
		slot0.rankList = RankData:GetGuildCommonRank(RankConst.RANK_ID.POLYHERON, slot4) and slot5.rankList or {}

		if slot5 then
			slot0.m_rank.text, slot0.m_score.text = slot5:GetCurRankDes()
		else
			slot0.m_rank.text = ""
			slot0.m_score.text = ""
		end
	end

	slot0.list_:StartScroll(#slot0.rankList)

	if slot2 == PolyhedronConst.RANK_SUB_TYPE.SCORE then
		slot0.m_icon.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo() and slot5.portrait)
		slot0.m_frame.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot5.icon_frame)

		if slot0.playerAnimator_ then
			SetActive(slot0.playerIconGo_, false)
			slot0.playerAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	else
		slot5 = HeroCfg[slot3]
		slot0.m_heroIcon.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroLittleIcon.path .. PolyhedronData:GetHeroUsingSkinInfo(slot3).id)
		slot0.m_heroNameText_.text = string.format("%s·%s", GetI18NText(slot5.name), GetI18NText(slot5.suffix))

		if slot0.heroAnimator_ then
			SetActive(slot0.heroIconGo_, false)
			slot0.heroAnimator_:Play("PolyhedronRankUI_Hero", -1, 0)
		end
	end

	if slot0.tabConState_ == nil then
		slot0.tabConState_ = {
			"all",
			"club"
		}
	end

	slot0.tabController_:SetSelectedState(slot0.tabConState_[slot0.rankType])
	slot0.subTypeController:SetSelectedIndex(slot0.subType - 1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:Refresh(slot0.rankList[slot1])
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()

	slot0.list_ = nil

	slot0.heroList_:Dispose()

	slot0.heroList_ = nil
	slot0.heroClickHandler_ = nil

	PolyhedronAction.ResetRankCache()
	uv0.super.Dispose(slot0)
end

function slot0.RefreshGuildRankGo(slot0)
	if GuildData:GetGuildInfo().id == nil then
		slot0.tabNumController_:SetSelectedState("01")
	else
		slot0.tabNumController_:SetSelectedState("02")
	end
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot2:SetData(slot0.heroIDList_[slot1])
	slot2:SetClickHandler(slot0.heroClickHandler_)
	slot2:SetSelect(slot0.heroID)
end

function slot0.AddTimer(slot0)
	slot0.activityID_ = PolyhedronData:GetActivityID()
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

function slot0.AdaptLeft(slot0)
	if slot0.leftTrs_ == nil then
		slot0.leftGo_ = slot0:FindGo("RankList_01/panel/left")
		slot0.leftTrs_ = slot0.leftGo_:GetComponent(typeof(RectTransform))
		slot0.needAdaptLeft_ = false
	end

	uv0.super.AdaptLeft(slot0)
end

function slot0.AdaptRight(slot0)
	if slot0.rightTrs_ == nil then
		slot0.rightGo_ = slot0:FindGo("RankList_01/panel/right_adapt")
		slot0.rightTrs_ = slot0.rightGo_:GetComponent(typeof(RectTransform))
		slot0.needAdaptRight_ = true
	end

	uv0.super.AdaptRight(slot0)
end

return slot0
