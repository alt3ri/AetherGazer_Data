slot0 = class("SoloHeartDemonRankView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Challenge_SoloHeartDemonUI/SoloHeartDemonRankUI"
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

	slot0.tabController_ = slot0.toggleConEx:GetController("tab")
	slot0.tabNumController_ = slot0.toggleConEx:GetController("num")
	slot0.list = LuaList.New(handler(slot0, slot0.SetListItem), slot0.list_, SoloHeartDemonListItem)
	slot0.nothingController_ = slot0.conExCollection_:GetController("stage")
end

function slot0.SetListItem(slot0, slot1, slot2)
	slot2:SetData(slot0.rankData[slot1], slot1, 2)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.GoToSystem("/soloHeartDemonReward", {
			selectIndex = 2,
			activityId = uv0.activityId
		})
	end)
	slot0:AddBtnListener(slot0.clubBtn_, nil, function ()
		uv0:SwitchPageIfDiff(1)
	end)
	slot0:AddBtnListener(slot0.allBtn_, nil, function ()
		uv0:SwitchPageIfDiff(2)
	end)
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
	slot0.rankData = slot0:GetListFromIndex(slot1)

	slot0:UpdateView()
end

function slot0.SwitchPageIfDiff(slot0, slot1)
	if slot0.curPage_ ~= slot1 then
		slot0:SwitchPage(slot1)
	end
end

function slot0.IsShowRank(slot0)
	return manager.time:GetServerTime() < slot0.remainTime - 86400 and slot0.challengeStage == 1
end

function slot0.UpdateView(slot0)
	slot0.remainTime = ActivityData:GetActivityRefreshTime(ActivityConst.SOLO_HEART_DEMON)
	slot0.challengeStage = SoloHeartDemonData:GetDataByPara("challengeStage")

	slot0.list:StartScroll(slot0:IsShowRank() and 0 or #slot0.rankData)
	SetActive(slot0.rewardBtn_.gameObject, slot0.curPage_ == 2)

	if RankData[slot0.curPage_ == 1 and "GetGuildCommonRank" or "GetCommonRank"](RankData, RankConst.RANK_ID.SOLOHEARTDEMON) then
		slot0.rankTxt_.text, slot0.gradeTxt_.text = slot1:GetCurRankDes()
	else
		slot0.gradeTxt_.text = ""
		slot0.rankTxt_.text = ""
	end

	slot0.nothingController_:SetSelectedState(slot0.challengeStage == 0 and "challenge" or "refresh")
end

function slot0.OnEnter(slot0)
	slot0.isInit_ = false
	slot0.activityId = slot0.params_.activityId
	slot0.nameTxt_.text = PlayerData:GetPlayerInfo().nick
	slot0.headIconImg_.sprite = ItemTools.getItemSprite(PlayerData:GetPlayerInfo().portrait)
	slot0.headFrameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. PlayerData:GetPlayerInfo().icon_frame)

	RankAction.QueryCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)

	slot1 = true

	if GuildData:GetGuildInfo().id == nil or GuildData:GetGuildInfo().id == 0 then
		slot1 = false
	end

	slot0.tabNumController_:SetSelectedState(slot1 and "02" or "01")

	if slot1 then
		RankAction.QueryGuildCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON)
	end
end

function slot0.GetListFromIndex(slot0, slot1)
	if slot1 == 1 then
		return RankData:GetGuildCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON) and slot2.rankList or {}
	else
		return RankData:GetCommonRank(RankConst.RANK_ID.SOLOHEARTDEMON) and slot2.rankList or {}
	end
end

function slot0.OnRankUpdate(slot0)
	if not slot0.isInit_ then
		slot0:SwitchPage(2)

		slot0.isInit_ = true
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnSoloDemonHeartUpdate(slot0)
	if not slot0.isInit_ then
		slot0:SwitchPage(2)

		slot0.isInit_ = true
	end
end

function slot0.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
