slot0 = class("NewHeroTeamInfoBaseView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationHeroUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.autoClearFilter_ = true
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, slot0:GetHeroHeadClass())
	slot0.filterView_ = slot0:GetFilterClass().New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroInfoView_ = SectionHeroInfoView.New(slot0, slot0.heroInfoGo_)
	slot0.emptyController_ = slot0.controller_:GetController("empty")
	slot0.joinBtnController_ = slot0.btnPanelController_:GetController("join")
	slot0.infoBtnController_ = slot0.btnPanelController_:GetController("info")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		slot0 = {}

		if uv0.selectHeroData_.trialID ~= 0 then
			for slot4, slot5 in pairs(uv0.allTrialIDList_) do
				if HeroCfg[HeroStandardSystemCfg[slot5].hero_id].hide_info == 0 then
					table.insert(slot0, slot5)
				end
			end
		end

		uv0:Go("/newHero", {
			isEnter = true,
			hid = uv0.selectHeroData_.trialID ~= 0 and uv0.selectHeroData_.trialID or uv0.selectHeroData_.id,
			type = uv0.selectHeroData_.trialID ~= 0 and HeroConst.HERO_DATA_TYPE.TRIAL or uv0.heroDataType_,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, handler(slot0, slot0.OnJoinClick))
end

function slot0.OnEnter(slot0)
	slot0:ProcessCamera()
	slot0:UpdateBar()
	slot0:ParseParams()
	slot0:SubViewOnEnter()
	slot0:GetHeroTeam()
	slot0:RefreshHeroDataList()
	slot0:RefreshHeroList()
end

function slot0.OnTop(slot0)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot0.OnExit(slot0)
	slot0.params_.curSelectHeroData = slot0.selectHeroData_

	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()
	slot0:SubViewOnExit()
end

function slot0.Dispose(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.heroHeadList_ then
		slot0.heroHeadList_:Dispose()

		slot0.heroHeadList_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:Dispose()

		slot0.heroInfoView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.ProcessCamera(slot0)
	manager.ui:SetMainCamera("hero")
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.ParseParams(slot0)
	slot0.stageID_ = slot0.params_.stageID
	slot0.stageType_ = slot0.params_.stageType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	slot0.activityID_ = slot0.params_.activityID

	if not slot0.params_.reserveParams then
		slot0.params_.reserveParams = ReserveTools.GetReserveParams(slot0.stageType_, slot0.stageID_, slot0.activityID_)
	elseif not slot0.params_.reserveParams.customData.activityID then
		slot0.params_.reserveParams.customData.activityID = slot0.activityID_
	end

	slot0.reserveParams_ = slot0.params_.reserveParams
	slot0.params_.heroDataType = slot0.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.heroDataType_ = slot0.params_.heroDataType

	if not slot0.params_.sectionProxy then
		slot0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(slot0.params_, slot0.reserveParams_, slot0.heroDataType_)
	end

	slot0.sectionProxy_ = slot0.params_.sectionProxy
	slot0.heroViewProxy_ = slot0.sectionProxy_:GetHeroViewProxy()
	slot0.heroViewProxyDic_ = {
		[slot0.heroDataType_] = slot0.heroViewProxy_
	}
end

function slot0.SubViewOnEnter(slot0)
	slot0.heroAvatarView_:OnEnter()

	if not slot0.params_.isBack and slot0.filterView_ and slot0.autoClearFilter_ then
		slot0.filterView_:Reset(true)
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
	end

	slot0.filterView_:OnEnter(slot0.heroViewProxy_)

	if slot0.heroInfoView_ then
		slot0.heroInfoView_:OnEnter(slot0.heroViewProxy_)
	end
end

function slot0.SubViewOnExit(slot0)
	slot0.heroAvatarView_:OnExit()

	if slot0.filterView_ and slot0.filterView_.OnExit then
		slot0.filterView_:OnExit()
	end

	if #slot0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	slot0.heroInfoView_:OnExit()
end

function slot0.RefreshHeroDataList(slot0)
	slot1 = {}
	slot0.allTrialIDList_ = {}
	slot2 = {}
	slot3, slot4 = nil

	if slot0.params_.stageType and slot0.params_.stageID and slot0.params_.stageID ~= 0 then
		slot3, slot4 = BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)
	end

	slot5 = false

	if type(slot4) == "table" then
		slot0.canSwitchResctrictHeroList_ = slot4

		if slot0.canSwitchResctrictHeroList_[slot0.params_.selectHeroPos] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			slot5 = true
		end
	else
		slot0.canSwitchResctrictHeroList_ = {
			0,
			0,
			0
		}
	end

	if type(slot3) == "table" then
		for slot9, slot10 in ipairs(slot3) do
			if slot10[1] and slot10[1] ~= 0 and HeroCfg[slot11] and HeroCfg[slot11].private == 0 then
				slot2[slot11] = slot10[2]
			end
		end

		if slot5 == true then
			slot7 = slot3[slot0.params_.selectHeroPos][2]

			if slot2[slot3[slot0.params_.selectHeroPos][1]] then
				table.insert(slot1, {
					id = slot6,
					trialID = slot7,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
				})
				table.insert(slot0.allTrialIDList_, slot7)

				if HeroTools.GetHeroIsUnlock(slot6) then
					table.insert(slot1, {
						trialID = 0,
						id = slot6,
						type = HeroConst.HERO_DATA_TYPE.DEFAULT,
						heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.DEFAULT)
					})
				end
			end
		elseif slot0.lockStateList_[slot0.params_.selectHeroPos] then
			for slot9, slot10 in pairs(slot3) do
				slot12 = slot10[2]

				if slot2[slot10[1]] then
					table.insert(slot1, {
						id = slot11,
						trialID = slot12,
						type = HeroConst.HERO_DATA_TYPE.TRIAL,
						heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
					})

					slot2[slot11] = slot12

					table.insert(slot0.allTrialIDList_, slot12)
				end
			end
		end
	end

	slot0.trialHeroList_ = slot0:GetTrialHeroList()

	if not slot0.lockStateList_[slot0.params_.selectHeroPos] and not slot5 then
		for slot9, slot10 in pairs(slot0:GetHeroList()) do
			if not slot2[slot10] then
				table.insert(slot1, {
					trialID = 0,
					id = slot10,
					type = slot0.heroDataType_,
					heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
				})
			end
		end

		for slot9, slot10 in pairs(slot0.trialHeroList_) do
			if not table.keyof(slot2, slot10) then
				table.insert(slot1, {
					id = HeroStandardSystemCfg[slot10].hero_id,
					trialID = slot10,
					type = HeroConst.HERO_DATA_TYPE.TRIAL,
					heroViewProxy = slot0:GetHeroViewProxy(HeroConst.HERO_DATA_TYPE.TRIAL)
				})
				table.insert(slot0.allTrialIDList_, slot10)
			end
		end
	end

	for slot9, slot10 in pairs(slot0.heroViewProxyDic_) do
		slot10:SetTempHeroList(slot0.allTrialIDList_)
	end

	slot0.filterView_:SetHeroIdList(slot1)
end

function slot0.RefreshHeroList(slot0)
	if #slot0.heroDataList_ <= 0 then
		return
	end

	slot0.selectHeroData_ = slot0:GetDefaultHeroData()
	slot1 = 1

	for slot5, slot6 in ipairs(slot0.heroDataList_) do
		if slot6.id == slot0.selectHeroData_.id and slot6.trialID == slot0.selectHeroData_.trialID then
			slot1 = slot5

			break
		end
	end

	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_, slot1)
	slot0:SelectHero(slot0.selectHeroData_)
end

function slot0.SelectHero(slot0, slot1)
	slot0.selectHeroData_ = slot1

	for slot5, slot6 in pairs(slot0.heroHeadList_:GetItemList()) do
		slot6:SetSelected(slot6.heroId_ == slot0.selectHeroData_.id and slot6.trialID_ == slot0.selectHeroData_.trialID)
	end

	slot0:RefreshInfoBtn()
	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot0.RefreshInfoBtn(slot0)
	if slot0.params_.hideInfoBtn or HeroCfg[slot0.selectHeroData_.id].private ~= 0 then
		slot0.infoBtnController_:SetSelectedState("off")
	else
		slot0.infoBtnController_:SetSelectedState(HeroCfg[slot0.selectHeroData_.id].hide_info == 0 and "on" or "off")
	end
end

function slot0.UpdateHeroView(slot0)
	slot1, slot2, slot3 = nil
	slot2 = slot0.selectHeroData_.id

	slot0.heroAvatarView_:SetSkinId(slot0.selectHeroData_.heroViewProxy:GetHeroUsingSkinInfo(slot2, {
		slot0.selectHeroData_.trialID
	}).id)
	slot0.heroInfoView_:SetProxy(slot0.selectHeroData_.heroViewProxy)
	slot0.heroInfoView_:SetHeroInfo(slot0.selectHeroData_.heroViewProxy:GetHeroData(slot2, {
		slot0.selectHeroData_.trialID
	}))
	slot0.heroInfoView_:UpdateView()
end

function slot0.RefreshJoinBtn(slot0)
	slot0.joinBtn_.interactable = true

	if slot0.lockStateList_[slot0.params_.selectHeroPos] == true then
		slot0.joinBtnController_:SetSelectedState("lock")

		slot0.joinBtn_.interactable = false
	elseif table.keyof(slot0.lockHeroList_, slot0.selectHeroData_.id) or table.keyof(slot0.lockHeroList_, slot0.selectHeroData_.trialID) then
		slot0.joinBtnController_:SetSelectedState("lock")

		slot0.joinBtn_.interactable = false
	elseif slot0:IsSameHeroInTeam(slot0.selectHeroData_.id) and not slot0:IsInTeam(slot0.selectHeroData_.id, slot0.selectHeroData_.trialID) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectHeroData_.id then
			slot0.joinBtnController_:SetSelectedState("lock")

			slot0.joinBtn_.interactable = false
		else
			slot0.joinBtnController_:SetSelectedState("change")
		end
	elseif slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectHeroData_.id, slot0.selectHeroData_.trialID) then
			slot0.joinBtnController_:SetSelectedState("change")
		else
			slot0.joinBtnController_:SetSelectedState("add")
		end
	elseif slot0.selectHeroData_.id == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		for slot5, slot6 in pairs(slot0.heroTeam_) do
			if slot6 ~= 0 then
				slot1 = 0 + 1
			end
		end

		if slot1 == 1 and not slot0.params_.canCleanTeam then
			slot0.joinBtn_.interactable = false

			slot0.joinBtnController_:SetSelectedState("cantRemove")
		else
			slot0.joinBtnController_:SetSelectedState("out")
		end
	else
		slot0.joinBtnController_:SetSelectedState("change")
	end
end

function slot0.GetHeroTeam(slot0)
	slot0.heroTeam_, slot0.lockStateList_, slot0.lockHeroList_, slot0.heroTrialList_ = slot0.sectionProxy_:CustomGetTeamData()
end

function slot0.GetHeroList(slot0)
	if slot0.params_.stageType == BattleConst.STAGE_TYPE_NEW.DESTROY_BOX_GAME then
		return {}
	end

	return HeroTools.Sort(HeroData:GetHeroList())
end

function slot0.GetCustomHeroList(slot0)
	slot1 = {}

	if type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table" then
		for slot6, slot7 in pairs(slot2) do
			if slot7[1] ~= 0 and HeroCfg[slot7[1]] and HeroCfg[slot7[1]].private == 0 then
				table.insert(slot1, slot7[2])
			end
		end
	end

	return slot1
end

function slot0.GetDefaultHeroData(slot0)
	if slot0.params_.curSelectHeroData and slot0.params_.curSelectHeroData.id ~= 0 then
		for slot4, slot5 in ipairs(slot0.heroDataList_) do
			if slot5.id == slot0.params_.curSelectHeroData.id and slot5.trialID == slot0.params_.curSelectHeroData.trialID then
				return slot0.params_.curSelectHeroData
			end
		end
	end

	if not slot0.params_.isBack then
		slot2 = slot0.heroTrialList_[slot0.params_.selectHeroPos] or 0

		if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) ~= 0 then
			for slot6, slot7 in ipairs(slot0.heroDataList_) do
				if slot7.id == slot1 and slot7.trialID == slot2 then
					return slot7
				end
			end

			return {
				id = slot1,
				trialID = slot2,
				type = slot0.heroDataType_,
				heroViewProxy = slot0:GetHeroViewProxy(slot0.heroDataType_)
			}
		end
	end

	for slot4, slot5 in ipairs(slot0.heroDataList_) do
		if not slot0:IsInTeam(slot5.id, slot5.trialID) and not table.keyof(slot0.lockHeroList_, slot6) and not table.keyof(slot0.lockHeroList_, slot5.trialID) then
			return slot5
		end
	end

	if #slot0.heroDataList_ > 0 then
		return slot0.heroDataList_[1]
	end

	return nil
end

function slot0.OnJoinClick(slot0)
	slot2 = slot0.heroTrialList_

	if slot0.selectHeroData_.id == slot0.heroTeam_[slot0.params_.selectHeroPos] and slot0.selectHeroData_.trialID == slot2[slot0.params_.selectHeroPos] and slot0:IsSameHeroInTeam(slot0.selectHeroData_.id) then
		slot1[slot0.params_.selectHeroPos] = 0
		slot2[slot0.params_.selectHeroPos] = 0
	elseif slot3 then
		slot4 = 1

		for slot8, slot9 in pairs(slot1) do
			if slot9 == slot0.selectHeroData_.id then
				slot4 = slot8

				break
			end
		end

		if slot1[slot4] == slot0.selectHeroData_.id and slot2[slot4] ~= slot0.selectHeroData_.trialID then
			slot1[slot4] = slot0.selectHeroData_.id
			slot2[slot4] = slot0.selectHeroData_.trialID
		end

		slot1[slot4] = slot1[slot0.params_.selectHeroPos]
		slot1[slot0.params_.selectHeroPos] = slot1[slot4]
		slot2[slot4] = slot2[slot0.params_.selectHeroPos]
		slot2[slot0.params_.selectHeroPos] = slot2[slot4]

		HeroTools.PlayTalk(slot0.selectHeroData_.id, "team")
	else
		slot1[slot0.params_.selectHeroPos] = slot0.selectHeroData_.id
		slot2[slot0.params_.selectHeroPos] = slot0.selectHeroData_.trialID

		HeroTools.PlayTalk(slot0.selectHeroData_.id, "team")
	end

	if slot0.canSwitchResctrictHeroList_[slot0.params_.selectHeroPos] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and (slot0.params_.reorder == nil or slot0.params_.reorder == true) then
		slot4 = 1
		slot5 = 2

		while slot4 <= 3 and slot5 <= 3 do
			if slot1[slot4] == 0 then
				if slot0.canSwitchResctrictHeroList_[slot5] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID and slot1[slot5] ~= 0 then
					slot1[slot4] = slot1[slot5]
					slot2[slot4] = slot2[slot5]
					slot1[slot5] = 0
					slot2[slot5] = 0
					slot4 = slot5
				end
			else
				slot4 = slot4 + 1
			end

			slot5 = slot5 + 1
		end
	end

	slot0:TryToChangeTeam(slot1, slot2)
end

function slot0.TryToChangeTeam(slot0, slot1, slot2)
	slot0:ChangeTeam(slot1, slot2)
	slot0:OnChangeTeamSuccess()
end

function slot0.ChangeTeam(slot0, slot1, slot2)
	slot0.sectionProxy_:ChangeHeroTeam(slot1, slot2)
end

function slot0.OnChangeTeamSuccess(slot0)
	slot0.heroAvatarView_:RemoveTween()
	slot0:Back(1, {
		isSorted = true
	})
end

function slot0.IsInTeam(slot0, slot1, slot2)
	for slot6, slot7 in pairs(slot0.heroTeam_) do
		if slot1 == slot7 and slot2 == slot0.heroTrialList_[slot6] then
			return true, slot6 == 1, slot6
		end
	end

	return false, false, -1
end

function slot0.IsSameHeroInTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroTeam_) do
		if slot1 == slot6 then
			return true
		end
	end

	return false
end

function slot0.IsCustomTeamStage(slot0)
	return type(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) == "table"
end

function slot0.GetHeroHeadClass(slot0)
	return SectionHeroTeamHeadItem
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot3 = slot0.heroDataList_[slot1].id
	slot4 = slot0.heroDataList_[slot1].trialID

	slot2:SetSectionHeroData(slot0.heroDataList_[slot1])
	slot2:SetSelected(slot2.heroId_ == slot0.selectHeroData_.id and slot2.trialID_ == slot0.selectHeroData_.trialID)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv0.heroDataList_[uv1])
	end)
	slot2:SetInTeamFlag(slot0:IsInTeam(slot3, slot4))
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot3) ~= nil or table.keyof(slot0.lockHeroList_, slot4) ~= nil)
end

function slot0.GetHeroViewProxy(slot0, slot1)
	if not slot0.heroViewProxyDic_[slot1] then
		slot0.heroViewProxyDic_[slot1] = HeroViewDataProxy.New(slot1)
	end

	return slot0.heroViewProxyDic_[slot1]
end

function slot0.GetFilterClass(slot0)
	return NewHeroListFilterView
end

function slot0.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot7 = {
		[slot11] = {
			id = slot12,
			trialID = slot0.heroTrialList_[slot11]
		}
	}

	for slot11, slot12 in pairs(slot0.heroTeam_) do
		-- Nothing
	end

	if slot0:indexof(slot7, slot1) ~= slot0:indexof(slot7, slot2) then
		return true, slot8 < slot9
	end

	if slot1.trialID ~= 0 or slot2.trialID ~= 0 then
		if slot1.trialID ~= 0 and slot2.trialID ~= 0 then
			if slot3 == 0 and slot1.star ~= slot2.star then
				if slot0.curOrder_ == "desc" then
					return true, slot2.star < slot1.star
				else
					return true, slot1.star < slot2.star
				end
			end

			if getHeroPower(slot1.trialID, true) ~= getHeroPower(slot2.trialID, true) then
				if slot4 == "desc" then
					return true, slot11 < slot10
				else
					return true, slot10 < slot11
				end
			else
				return true, slot2.trialID < slot1.trialID
			end
		else
			return true, slot2.trialID < slot1.trialID
		end
	end

	return false, false
end

function slot0.OnListChange(slot0, slot1, slot2)
	slot0.heroDataList_ = slot2
	slot0.selectHeroData_ = slot0.heroDataList_[1]

	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_)

	if #slot0.heroDataList_ == 0 then
		slot0.emptyController_:SetSelectedState("true")
		slot0.heroAvatarView_:ShowHeroModel(false)
	else
		slot0.emptyController_:SetSelectedState("false")
		slot0.heroAvatarView_:ShowHeroModel(true)

		if not slot0.params_.isEnter then
			slot0:SelectHero(slot0.heroDataList_[1])
		else
			slot0.params_.isEnter = false
		end
	end
end

function slot0.indexof(slot0, slot1, slot2)
	for slot6 = 1, #slot1 do
		if slot1[slot6].id == slot2.id and slot1[slot6].trialID == slot2.trialID then
			return slot6
		end
	end

	return 9999
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	HeroData:SaveSortValue(slot1, slot2, slot3, slot4, slot5)
end

function slot0.GetTrialHeroList(slot0)
	return GetTrialHeroList(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID)
end

return slot0
