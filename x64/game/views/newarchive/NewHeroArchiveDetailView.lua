slot0 = class("NewHeroArchiveDetailView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_chain/HeroChainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.bgController_ = ControllerUtil.GetController(slot0.transform_, "bg")

	slot0:AddUIListener()
	slot0:RegistEventListener(UPDATE_WALLPAPER, function ()
		uv0:RefreshBgUI()
	end)
	slot0:RegistEventListener(UPDATE_HEARTLIST, function ()
		uv0:RefreshPlotList()
	end)

	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexPlotItem), slot0.plotList_, NewHeroArchivePlotItemView)
	slot0.uiStoryList_ = LuaList.New(handler(slot0, slot0.IndexStoryItem), slot0.storyList_, NewHeroArchiveStoryItemView)
end

function slot0.IndexPlotItem(slot0, slot1, slot2)
	if slot1 == #slot0.plotIdList_ or slot1 == #slot0.superPlotIdList_ + #slot0.plotIdList_ then
		SetActive(slot2.nextLine_, false)
	else
		SetActive(slot2.nextLine_, true)
	end

	if slot1 <= #slot0.plotIdList_ then
		slot2:SetData(slot0.recordData_, slot0.recordData_.plot_id[slot1], slot0.data_.archive_id, slot1, 1)
	else
		slot2:SetData(slot0.recordData_, slot0.recordData_.super_plot_id[slot1 - #slot0.plotIdList_], slot0.data_.archive_id, slot1 - #slot0.plotIdList_, 2)
	end

	slot2:SetStoryCallBack(function ()
		saveData("ModuleList_" .. USER_ID, "PlotIndex_" .. uv0.data_.archive_id, uv1)

		uv0.index_ = uv1
	end)
end

function slot0.IndexStoryItem(slot0, slot1, slot2)
	slot2:SetData(HeroAnedoteCfg[slot0.storyList_[slot1]], slot0.data_.archive_id)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backgroundBtn_, nil, function ()
		JumpTools.GoToSystem("newHeroWallPaperPopView", {
			data = uv0.data_
		})
	end)
	slot0:AddBtnListener(slot0.giftBtn_, nil, function ()
		slot0 = uv0.recordData_.hero_id

		table.sort(slot0, function (slot0, slot1)
			slot4 = ArchiveData:GetTrustLevel(slot0)
			slot5 = ArchiveData:GetTrustLevel(slot1)

			if HeroData:GetHeroData(slot0).unlock == 1 and HeroData:GetHeroData(slot1).unlock == 0 then
				return true
			elseif slot2.unlock == 0 and slot3.unlock == 1 then
				return false
			elseif slot5 < slot4 then
				return true
			elseif slot4 < slot5 then
				return false
			else
				return slot0 < slot1
			end
		end)
		JumpTools.GoToSystem("/heroArchive", {
			pageID = 3,
			heroID = slot0[1]
		})
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.isBackHome_ = slot0.params_.isBackHome

	manager.windowBar:RegistBackCallBack(function ()
		if uv0.isBackHome_ then
			JumpTools.OpenPageByJump("/home")
		else
			JumpTools.Back()
		end
	end)

	slot0.id_ = slot0.params_.id
	slot0.data_ = ArchiveData:GetArchive(slot0.id_)
	slot0.recordData_ = HeroRecordCfg[slot0.data_.archive_id]
	slot0.index_ = getData("ModuleList_" .. USER_ID, "PlotIndex_" .. slot0.data_.archive_id) or 0
	slot0.plotIdList_ = slot0.recordData_.plot_id
	slot0.superPlotIdList_ = slot0.recordData_.super_plot_id

	slot0.uiList_:StartScroll(#slot0.plotIdList_ + #slot0.superPlotIdList_, slot0.index_, true, false)

	slot0.storyList_ = {}
	slot0.heroIdList_ = slot0.recordData_.hero_id
	slot1 = slot0.uiList_:GetScrolledPosition()
	slot0.timer = Timer.New(function ()
		uv0.filmAni_:SetFloat("floatSpeed", (uv0.uiList_:GetScrolledPosition().x - uv1.x) * 3)

		uv1 = uv0.uiList_:GetScrolledPosition()
	end, 0.1, -1, true)

	slot0.timer:Start()

	for slot5, slot6 in pairs(slot0.heroIdList_) do
		if HeroAnedoteCfg[slot6] then
			table.insert(slot0.storyList_, slot6)
		end
	end

	slot0.uiStoryList_:StartScroll(#slot0.storyList_)
	slot0:RefreshUI()

	slot2 = HeroTools.GetHeroOntologyID(slot0.id_)

	manager.redPoint:setTip(RedPointConst.HERO_STORY_ID .. slot2, 0)
	manager.redPoint:setTip(RedPointConst.HERO_SUPER_STORY_ID .. slot2, 0)
	manager.redPoint:setTip(RedPointConst.HERO_ANEDOTE_ID .. slot2, 0)

	slot4, slot5, slot6 = ArchiveData:GetUnlockHeartListInfoLengthByHeroId(slot0.id_)

	saveData("HearListRedPoint", "heartStroy_" .. PlayerData:GetPlayerInfo().userID .. "_" .. HeroRecordCfg.get_id_list_by_hero_id[slot0.id_][1], {
		slot4,
		slot5,
		slot6
	})
end

function slot0.RefreshUI(slot0)
	if not slot0.favorItemList_ then
		slot0.favorItemList_ = {}
	end

	for slot4, slot5 in ipairs(slot0.favorItemList_) do
		SetActive(slot5.gameObject_, false)
		slot5:ResetData()
	end

	slot1 = false

	for slot5, slot6 in ipairs(slot0.heroIdList_) do
		if ArchiveData:GetTrustLevel(slot6) > 0 then
			slot1 = true
		end
	end

	slot2 = 0

	for slot6, slot7 in ipairs(slot0.heroIdList_) do
		if HeroData:GetHeroData(slot0.heroIdList_[slot6]).unlock == 1 then
			if not slot0.favorItemList_[slot2 + 1] then
				slot10 = NewHeroArchiveHerofavorItemView.New(Object.Instantiate(slot0.favorabilityItem_), slot2)

				slot10.transform_:SetParent(slot0.favorabilityList_, false)
				table.insert(slot0.favorItemList_, slot10)
			end

			slot0.favorItemList_[slot2]:SetData(slot0.data_, slot8.id, slot2)
			SetActive(slot0.favorItemList_[slot2].gameObject_, true)
		end
	end

	for slot6, slot7 in ipairs(slot0.favorItemList_) do
		slot7:RefreshUI(slot1)
	end

	slot0.uiStoryList_:Refresh()
	slot0:RefreshBgUI()
end

function slot0.RefreshBgUI(slot0)
	slot0.bgController_:SetSelectedState("role")

	if table.isEmpty(ArchiveData:GetSelectPicture(slot0.data_.archive_id)) or slot1.type == 0 then
		for slot6, slot7 in ipairs(slot0.heroIdList_) do
			if HeroData:GetHeroData(slot7).unlock == 1 and not false then
				ArchiveAction.SendSetWallPaper(slot0.data_.archive_id, slot7, 1)

				slot0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot7)
				slot2 = true
			end
		end

		if not slot2 then
			slot0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.heroIdList_[1])
		end
	elseif slot1.type == 1 or slot1.type == 2 then
		slot0.bgController_:SetSelectedState("role")

		slot0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot1.id)
	elseif slot1.type == 3 then
		slot0.bgController_:SetSelectedState("plot")

		slot0.plotImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. CollectPictureCfg[slot1.id].picture)
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end
end

function slot0.OnReceiveIllustrationReward(slot0, slot1, slot2)
	getReward(mergeReward(formatRewardCfgList(slot1.item_list)))
	slot0:RefreshPlotList()
end

function slot0.OnReceiveIllustration(slot0)
	slot0:RefreshPlotList()
end

function slot0.RefreshPlotList(slot0)
	slot0.uiList_:Refresh()
	slot0.uiList_:ScrollToIndex(slot0.index_, true, false)
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	if slot0.uiStoryList_ then
		slot0.uiStoryList_:Dispose()

		slot0.uiStoryList_ = nil
	end

	if slot0.favorItemList_ then
		for slot4, slot5 in ipairs(slot0.favorItemList_) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
	slot0:RemoveAllEventListener()
end

return slot0
