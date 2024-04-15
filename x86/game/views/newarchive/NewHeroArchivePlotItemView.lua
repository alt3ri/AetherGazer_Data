slot0 = class("NewHeroArchivePlotItemView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.picController_ = ControllerUtil.GetController(slot0.transform_, "plot")
	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "item")
	slot0.plotPiccontroller_ = ControllerUtil.GetController(slot0.plotBtn_.transform, "get")
	slot0.redPointController_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if not uv0.isUnlock then
			if uv0.type_ == 1 then
				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_LOVE"), uv0.all))
			elseif uv0.type_ == 2 then
				ShowTips(string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_1"), uv0.trustTips, GetTips("HERO_TRUST_LEVEL_DES_" .. uv0.all)))
			end

			return
		end

		if uv0.needViewedFrontPlot or uv0.needViewedFrontSuperPlot then
			ShowTips(GetTips("ERROR_HERO_ARCHIVES_PREVIOUS_PLOT_NOT_VIEWED"))

			return
		end

		if uv0.needViewedNormalPlot then
			ShowTips(GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP"))

			return
		end

		manager.story:StartStoryById(uv0.plotID_, function (slot0)
			HeroAction.ReadStory(uv0.archiveID_, uv0.plotID_, uv0.type_, uv0.index_)

			if uv0.stroyCallBack then
				uv0.stroyCallBack()
			end
		end)
	end)
	slot0:AddBtnListener(slot0.plotBtn_, nil, function ()
		if uv0.isLock then
			ShowTips(GetTips("ERROR_NO_UNLOCK_INBETWEENING"))

			return
		end

		if uv0.plotIsViewed == 0 then
			for slot3, slot4 in ipairs(uv0.collectPicList_) do
				IllustratedAction.ViewIllustration(slot4, CollectConst.ILLUSTRATION)
			end

			IllustratedAction.ReceiveIllustrationReward(uv0.collectPicList_)
			uv0:RefreshUI()
		else
			uv0:Go("/illuIllustrationDetail", {
				ID = uv0.collectPicList_[1]
			})
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.data_ = slot1
	slot0.plotID_ = slot2
	slot0.archiveID_ = slot3
	slot0.index_ = slot4
	slot0.type_ = slot5
	slot0.needViewedNormalPlot = false
	slot0.needViewedFrontPlot = false
	slot0.needViewedFrontSuperPlot = false
	slot0.recordData_ = HeroRecordCfg[slot0.archiveID_]
	slot0.archiveData_ = ArchiveData:GetArchive(slot3)
	slot0.collectPicList_ = CollectPictureCfg.get_id_list_by_additional_parameter[slot0.plotID_]

	slot0:RefreshUI()
end

function slot0.SetStoryCallBack(slot0, slot1)
	slot0.stroyCallBack = slot1
end

function slot0.SetPlotCallBack(slot0, slot1)
	slot0.callPlotback = slot1
end

function slot0.RefreshUI(slot0)
	slot0.title_.text = StoryCfg[slot0.plotID_].name

	slot0:RefreshPlotPicUI()
	slot0:RefreshPlotUI()
end

function slot0.RefreshPlotUI(slot0)
	slot0:CheckIsUnlock()

	if slot0.isUnlock and not slot0.needViewedFrontPlot and not slot0.needViewedNormalPlot and not slot0.needViewedFrontSuperPlot then
		slot0:RefreshUnLockUI()
	else
		slot0:RefreshLockText()
	end
end

function slot0.CheckIsUnlock(slot0)
	slot1, slot2 = nil

	for slot7, slot8 in pairs(slot0.archiveData_.video_list) do
		slot3 = 0 + 1
	end

	if slot0.type_ == 1 then
		slot0.gameSettingCfgID = GameSetting.hero_plot_unlock_condition.value[slot0.index_]
		slot0.isUnlock, slot1, slot2 = IsConditionAchieved(slot0.gameSettingCfgID, {
			heroId = slot0.archiveID_
		})
		slot0.needViewedFrontPlot = slot3 < slot0.index_ - 1
	elseif slot0.type_ == 2 then
		slot0.gameSettingCfgID = GameSetting.hero_super_plot_unlock_condition.value[slot0.index_]
		slot0.isUnlock = false
		slot0.trustTips = HeroCfg[slot0.recordData_.hero_id[1]].name

		for slot7, slot8 in pairs(slot0.recordData_.hero_id) do
			slot9 = nil
			slot10, slot1, slot2 = IsConditionAchieved(slot0.gameSettingCfgID, {
				heroId = slot8
			})

			if slot10 then
				slot0.isUnlock = true
			end

			if slot7 > 1 then
				slot0.trustTips = string.format(GetTips("HERO_HEART_CHAIN_UNLOCK_TRUST_2"), slot0.trustTips, HeroCfg[slot8].name)
			end
		end

		slot0.needViewedFrontSuperPlot = #ArchiveData:GetHasViewedSuperHeartList(slot0.archiveID_) < slot0.index_ - 1
		slot0.needViewedNormalPlot = slot3 < #slot0.recordData_.plot_id
	end

	slot0.all = slot2

	slot0.redPointController_:SetSelectedState("no")
end

function slot0.RefreshUnLockUI(slot0)
	slot1 = nil

	if slot0.type_ == 1 then
		slot0.controller_:SetSelectedState("1")

		slot1 = ArchiveData:IsStoryRead(slot0.archiveID_, slot0.plotID_)
	elseif slot0.type_ == 2 then
		slot0.controller_:SetSelectedState("3")

		slot1 = ArchiveData:IsSuperHeartRead(slot0.archiveID_, slot0.index_)
	end

	if slot1 then
		slot0.redPointController_:SetSelectedState("no")
	else
		slot0.redPointController_:SetSelectedState("yes")
	end
end

function slot0.RefreshLockText(slot0)
	slot0.lockText_.text = ConditionCfg[slot0.gameSettingCfgID].desc

	if slot0.type_ == 1 then
		slot0.controller_:SetSelectedState("2")

		if slot0.needViewedFrontPlot and slot0.isUnlock then
			slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_PREVIOUS_PLOT_NOT_VIEWED")
		end
	elseif slot0.type_ == 2 then
		slot0.controller_:SetSelectedState("4")

		if slot0.needViewedNormalPlot and slot0.isUnlock then
			slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_COMMON_PLOT_NOT_VIEWED_TIP")
		elseif slot0.needViewedFrontSuperPlot then
			slot0.lockText_.text = GetTips("HERO_HEART_CHAIN_PLOT_UNLOCK_PREVIOUS_PLOT_NOT_VIEWED")
		end
	end
end

function slot0.RefreshPlotPicUI(slot0)
	if slot0.collectPicList_ then
		slot0.picController_:SetSelectedState("yes")
	else
		slot0.picController_:SetSelectedState("no")

		return
	end

	slot0.plotIcon_.sprite = getSpriteWithoutAtlas("TextureConfig/IllustratedHandbook/Collect_s/" .. CollectPictureCfg[slot0.collectPicList_[1]].picture)

	slot0.overLappingGo_:SetActive(#slot0.collectPicList_ > 1)

	for slot6, slot7 in pairs(slot0.collectPicList_) do
		slot2 = 0 + CollectPictureCfg[slot7].reward[1][2]

		if IllustratedData:GetIllustrationInfo()[slot7] then
			slot0.plotIsViewed = slot9.is_receive or 0
		else
			slot0.plotIsViewed = 0
		end
	end

	slot0.rewardCount_.text = "x" .. slot2
	slot0.isLock = false

	for slot6, slot7 in pairs(slot0.collectPicList_) do
		if IllustratedData:GetIllustrationInfo()[slot7] == nil then
			slot0.plotPiccontroller_:SetSelectedState("lock")

			slot0.isLock = true

			return
		end
	end

	if slot0.plotIsViewed == 1 then
		slot0.plotPiccontroller_:SetSelectedState("yes")
	else
		slot0.plotPiccontroller_:SetSelectedState("no")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
