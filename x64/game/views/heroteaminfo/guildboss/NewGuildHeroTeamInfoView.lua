slot1 = class("NewGuildHeroTeamInfoView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.UIName(slot0)
	return "Widget/System/Formation/GuildBoss/FormationGuildBossHeroUI"
end

function slot1.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1.Init(slot0)
	slot1 = slot0.gameObject_

	slot0:InitProxy()

	slot0.gameObject_ = slot0.realGo_
	slot0.transform_ = slot0.realGo_.transform

	slot0:InitUI()
	slot0:AddUIListener()

	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
end

function slot1.InitProxy(slot0)
	slot0:BindCfgUI()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.joinBtnController_ = slot0.btnPanelController_:GetController("join")
	slot0.infoBtnController_ = slot0.btnPanelController_:GetController("info")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.selfHeroList_ = LuaList.New(handler(slot0, slot0.indexSelfHeroItem), slot0.uiListGo_, SectionHeroTeamHeadItem)
	slot0.assistantHeroList_ = LuaList.New(handler(slot0, slot0.indexAssistantItem), slot0.assitUIListGo_, NewGuildBossAssistantHeadItemView)
	slot0.toggleController1_ = ControllerUtil.GetController(slot0.myHeroToggleBtn_.transform, "select")
	slot0.toggleController2_ = ControllerUtil.GetController(slot0.helpHeroToggleBtn_.transform, "select")
	slot0.filterView_ = NewHeroListFilterView.New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		if (uv0:IsInSelfTeam(slot0.id) and 1 or 0) ~= (uv0:IsInSelfTeam(slot1.id) and 1 or 0) then
			return true, slot5 < slot4
		end

		return false, false
	end)
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))

	slot0.assistFilterView_ = NewGuildBossAssistHeroFilterView.New(slot0.assistHeroFilterGo_)

	slot0.assistFilterView_:SetExtraSorter(function (slot0, slot1)
		if (GuildData:CheckCurrentHeroIDIsAssistant(slot0.assist_hero_id) and 1 or 0) ~= (GuildData:CheckCurrentHeroIDIsAssistant(slot1.assist_hero_id) and 1 or 0) then
			return true, slot3 < slot2
		end

		return false, false
	end)
	slot0.assistFilterView_:SetListChangeHandler(handler(slot0, slot0.OnAssistListChange))
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddEventListeners()
	slot0.assistFilterView_:OnEnter(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.FOREIGN))
end

function slot1.SubViewOnEnter(slot0)
	uv0.super.SubViewOnEnter(slot0)

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Reset(true)
	end
end

function slot1.RefreshHeroDataList(slot0)
	slot0.params_.heroList = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS):GetCurHeroInfoList()
end

function slot1.RefreshHeroList(slot0)
	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 then
		if slot1.type == 1 then
			slot0:SelectIndex(1)
		else
			slot0:SelectIndex(2)
		end
	else
		slot0:SelectIndex(1)
	end
end

function slot1.indexAssistantItem(slot0, slot1, slot2)
	slot2:SetSectionHeroData(slot0.assistantDataList_[slot1])
	slot2:SetSelected(slot0.selectedAssistHeroData_ ~= nil and slot2:GetHeroId() == slot0.selectedAssistHeroData_.assist_hero_id and slot2:GetOwnerId() == slot0.selectedAssistHeroData_.member_id)
	slot2:SetTeamMark(slot0:IsHeroInTeam(slot2:GetHeroId(), slot2:GetOwnerId()) > -1, GetTips("IN_TEAM"))
	slot2:RegisterClickListener(function ()
		uv0:SelectAssistantHero(uv1)
	end)
end

function slot1.indexSelfHeroItem(slot0, slot1, slot2)
	slot4 = slot0.heroDataList_[slot1].trialID

	slot2:SetSectionHeroData(slot0.heroDataList_[slot1], slot0.trialHeroList_)
	slot2:SetSelected(slot2.heroId_ == slot0.selectHeroData_.id and slot2.trialID_ == slot0.selectHeroData_.trialID)
	slot2:RegisterClickListener(function ()
		uv0:SelectSelfHero(uv0.heroDataList_[uv1])
	end)
	slot2:SetTeamMark(slot0:IsInSelfTeam(slot0.heroDataList_[slot1].id), GetTips("IN_TEAM"))
end

function slot1.OnListChange(slot0, slot1, slot2)
	slot0.heroDataList_ = slot2

	if slot0.currentIndex_ ~= 1 then
		return
	end

	slot0.selfHeroList_:StartScroll(#slot0.heroDataList_)

	if #slot0.heroDataList_ > 0 then
		if slot0:ChooseSelfFirstSelectIndex() then
			slot0.selectHeroData_ = slot0.heroDataList_[slot3]
		else
			slot0.selectHeroData_ = slot0.heroDataList_[1]
		end

		slot0:SelectSelfHero(slot0.selectHeroData_)
	else
		slot0:SelectEmptyAssistHero()
	end
end

function slot1.OnAssistListChange(slot0, slot1)
	slot0.assistantDataList_ = slot1

	slot0.assistantHeroList_:StartScroll(#slot0.assistantDataList_)

	if slot0.selectedAssistHeroData_ == nil then
		if #slot0.assistantDataList_ > 0 then
			slot0:SelectAssistantHero(slot0:ChooseAssistFirstSelectIndex())
		else
			slot0:SelectEmptyAssistHero()
		end
	else
		slot2 = -1

		for slot6, slot7 in ipairs(slot0.assistantDataList_) do
			if slot7 ~= nil and slot7.assist_hero_id == slot0.selectedAssistHeroID_ and slot7.member_id == slot0.selectedAssistHeroData_.member_id then
				slot2 = slot6

				break
			end
		end

		if slot2 ~= -1 then
			slot0:SelectAssistantHero(slot2)
		else
			slot0:SelectEmptyAssistHero()
		end
	end
end

function slot1.ChooseSelfFirstSelectIndex(slot0)
	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 and slot1.type == 1 then
		for slot6, slot7 in ipairs(slot0.heroDataList_) do
			if slot7.id == slot1.heroId then
				return slot6
			end
		end

		return 1
	end

	for slot5, slot6 in ipairs(slot0.heroDataList_) do
		if not slot0:IsInSelfTeam(slot6.id) then
			return slot5
		end
	end

	return 1
end

function slot1.ChooseAssistFirstSelectIndex(slot0)
	if slot0.params_.heroList[slot0.params_.selectHeroPos] and slot1.heroId ~= 0 and slot1.type == 2 then
		slot2 = nil

		for slot6, slot7 in ipairs(slot0.assistantDataList_) do
			if slot1.info.assist_hero_id == slot7.assist_hero_id and slot1.info.member_id == slot7.member_id then
				slot2 = slot6

				break
			end
		end

		return slot2
	end

	return 1
end

function slot1.SelectSelfHero(slot0, slot1)
	slot0.selectHeroData_ = slot1
	slot4 = slot0.selfHeroList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		slot6:SetSelected(slot6.heroId_ == slot0.selectHeroData_.id)
	end

	slot0:UpdateSelfHeroView()
end

function slot1.SelectEmptyAssistHero(slot0)
	slot0.heroAvatarView_:ShowHeroModel(false)

	slot0.fightPowerText_.text = "--"
	slot0.nameText_.text = "--"
	slot0.subNameText_.text = "--"

	slot0.infoBtnController_:SetSelectedState("off")

	slot0.joinBtn_.interactable = false

	slot0.joinBtnController_:SetSelectedState("cantAdd")
end

function slot1.SelectAssistantHero(slot0, slot1)
	slot2 = slot0.assistantDataList_[slot1]
	slot0.selectedAssistHeroID_ = slot2.assist_hero_id
	slot0.selectedAssistHeroData_ = slot2

	slot0.assistantHeroList_:Refresh()
	slot0:UpdateAssistHeroView()
end

function slot1.UpdateSelfHeroView(slot0)
	slot1 = slot0.selectHeroData_.id

	slot0.heroAvatarView_:ShowHeroModel(true)
	slot0.heroAvatarView_:SetSkinId(slot0.selectHeroData_.heroViewProxy:GetHeroUsingSkinInfo(slot1, {
		slot0.selectHeroData_.trialID
	}).id)

	slot0.fightPowerText_.text = getHeroPower(slot1, false)
	slot3 = HeroCfg[slot1]
	slot0.nameText_.text = GetI18NText(slot3.name)
	slot0.subNameText_.text = GetI18NText(slot3.suffix)

	slot0.infoBtnController_:SetSelectedState("on")
	slot0:UpdateJoin(slot1)
end

function slot1.UpdateJoin(slot0, slot1, slot2)
	slot0.joinBtn_.interactable = true

	slot0.joinBtnController_:SetSelectedState("add")

	if slot0:IsOnlyCaptainToRemove() then
		slot0.joinBtn_.interactable = false

		slot0.joinBtnController_:SetSelectedState("cantRemove")
	elseif slot0:IsHeroInTeam(slot1, slot2) > -1 then
		slot0.joinBtnController_:SetSelectedState("out")
	end
end

function slot1.IsOnlyCaptainToRemove(slot0)
	if slot0.params_.selectHeroPos ~= 1 then
		return false
	end

	slot3 = nil

	if slot0.params_.heroList[1] ~= nil and slot1[2] == nil and slot1[3] == nil then
		if slot0.currentIndex_ ~= slot1[1].type then
			return false
		end

		if slot4.type == 1 then
			if slot0.selectHeroData_.id == slot4.heroId then
				return true
			end
		elseif slot4.type == 2 and slot0.selectedAssistHeroID_ == slot4.info.assist_hero_id and slot0.selectedAssistHeroData_.member_id == slot4.info.member_id then
			return true
		end
	end

	return false
end

function slot1.UpdateAssistHeroView(slot0)
	if slot0.selectedAssistHeroData_.assist_hero_skin == 0 then
		slot1 = slot0.selectedAssistHeroData_.assist_hero_id
	end

	slot0.heroAvatarView_:ShowHeroModel(true)
	slot0.heroAvatarView_:SetSkinId(slot1)

	slot0.fightPowerText_.text = slot0.selectedAssistHeroData_.fight_capacity
	slot3 = HeroCfg[slot0.selectedAssistHeroID_]
	slot0.nameText_.text = GetI18NText(slot3.name)
	slot0.subNameText_.text = GetI18NText(slot3.suffix)

	slot0.infoBtnController_:SetSelectedState("off")
	slot0:UpdateJoin(slot0.selectedAssistHeroData_.assist_hero_id, slot0.selectedAssistHeroData_.member_id)
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.currentIndex_ == 1 then
			uv0:Go("/newHero", {
				isEnter = true,
				isTemp = false,
				hid = uv0.selectHeroData_.id,
				tempHeroList = {}
			})
		else
			if uv0.selectedAssistHeroData_ == nil then
				return
			end

			ForeignInfoAction:TryToCheckForeignHeroInfo(uv0.selectedAssistHeroData_.member_id, uv0.selectedAssistHeroID_, 2, function ()
				JumpTools.OpenPageByJump("/newHero", {
					isEnter = true,
					isForeign = true,
					notShowBar = true,
					hid = uv0.selectedAssistHeroID_
				}, ViewConst.SYSTEM_ID.PLAYER_INFO)
			end)
		end
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		if uv0:IsOnlyCaptainToRemove() then
			return
		end

		if uv0.currentIndex_ == 1 then
			slot0 = nil
			slot2 = nil

			if uv0:IsHeroInTeam(uv0.selectHeroData_.id) > -1 then
				slot0 = nil
				slot2 = slot1
			else
				slot0 = uv0.selectHeroData_.id
				slot2 = uv0.params_.selectHeroPos
			end

			if slot0 and uv0:GetHeroIdPosOfTeam(slot0) ~= -1 and slot1 == -1 and slot3 ~= uv0.params_.selectHeroPos then
				ShowTips("TEAM_REPEAT_HERO")

				return
			end

			uv0:OnGuildBossSelfHeroChange(slot2, slot0)
		else
			if uv0.selectedAssistHeroData_ == nil then
				return
			end

			slot0 = nil
			slot2 = nil

			if uv0:IsHeroInTeam(uv0.selectedAssistHeroID_, uv0.selectedAssistHeroData_.member_id) > -1 then
				slot0 = nil
				slot2 = slot1
			else
				slot0 = uv0.selectedAssistHeroData_
				slot2 = uv0.params_.selectHeroPos
			end

			if slot0 ~= nil then
				for slot6, slot7 in ipairs(uv0.params_.heroList) do
					if slot6 ~= uv0.params_.selectHeroPos and slot7.type == 2 and slot7.assist_hero_id ~= slot0.assist_hero_id then
						ShowTips("CLUB_BOSS_ASSIST_MORE_THAN_ONE_TIP")

						return
					end
				end

				if uv0:GetHeroIdPosOfTeam(slot0.assist_hero_id) ~= -1 and slot1 == -1 and slot3 ~= uv0.params_.selectHeroPos then
					ShowTips("TEAM_REPEAT_HERO")

					return
				end
			end

			uv0:OnGuildBossAssistantHeroChange(slot2, slot0)
		end

		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.myHeroToggleBtn_, nil, function ()
		uv0:SelectIndex(1)
	end)
	slot0:AddBtnListener(slot0.helpHeroToggleBtn_, nil, function ()
		uv0:SelectIndex(2)
	end)
end

function slot1.SelectIndex(slot0, slot1)
	slot0.currentIndex_ = slot1

	if slot1 == 1 then
		SetActive(slot0.filterGo_, true)
		SetActive(slot0.assistHeroFilterGo_, false)
		slot0.toggleController1_:SetSelectedState("true")
		slot0.toggleController2_:SetSelectedState("false")
		slot0.assistFilterView_:SetAvailable(false)
		slot0.filterView_:SetAvailable(true)
		slot0.filterView_:Reset(true)
		slot0.filterView_:SetHeroIdList(HeroTools.Sort(HeroData:GetHeroListExcept({
			0
		})))
	else
		SetActive(slot0.filterGo_, false)
		SetActive(slot0.assistHeroFilterGo_, true)
		slot0.toggleController1_:SetSelectedState("false")
		slot0.toggleController2_:SetSelectedState("true")
		slot0.filterView_:SetAvailable(false)
		slot0.assistFilterView_:SetAvailable(true)
		slot0.assistFilterView_:Reset(true)
		slot0.assistFilterView_:SetHeroIdList(GuildData:GetAssistantBriefList())
	end
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_ASSIST_BRIEF_UPDATE, function ()
		if uv0.assistantHeroList_ == nil then
			return
		end

		if uv0.heroAvatarView_ then
			uv0.heroAvatarView_:OnEnter()
		end
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot1.OnTop(slot0)
	slot0:UpdateBar()
end

function slot1.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot1.UpdateBar(slot0)
	slot0:ShowDefaultBar()
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back(1, {
			isSorted = true
		})
	end)
end

function slot1.IsInSelfTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.params_.heroList) do
		if slot6.type == 1 and slot6.heroId == slot1 then
			return true
		end
	end

	return false
end

function slot1.IsHeroInTeam(slot0, slot1, slot2)
	if slot2 then
		for slot6, slot7 in pairs(slot0.params_.heroList) do
			if slot7.type == 2 and slot7.info.assist_hero_id == slot1 and slot7.info.member_id == slot2 then
				return slot6
			end
		end

		return -1
	else
		for slot6, slot7 in pairs(slot0.params_.heroList) do
			if slot7.type == 1 and slot7.heroId == slot1 then
				return slot6
			end
		end

		return -1
	end
end

function slot1.GetHeroIdPosOfTeam(slot0, slot1)
	for slot5, slot6 in pairs(slot0.params_.heroList) do
		if slot6.type == 2 then
			if slot6.info.assist_hero_id == slot1 then
				return slot5
			end
		elseif slot6.heroId == slot1 then
			return slot5
		end
	end

	return -1
end

function slot1.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	if slot0.currentIndex_ == 1 then
		slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	else
		slot0.assistFilterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
	end

	HeroData:SaveSortValue(slot1, slot2, slot3, slot4, slot5)
end

function slot1.OnExit(slot0)
	if slot0.filterView_ and slot0.filterView_.OnExit then
		slot0.filterView_:OnExit()
	end

	slot0:RemoveAllEventListener()
	manager.ui:ResetMainCamera()
	manager.windowBar:HideBar()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if slot0.heroDataList_ and #slot0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end

	if slot0.assistantDataList_ and #slot0.assistantDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.assistFilterView_:Reset()
	end
end

function slot1.OnMainHomeViewTop(slot0)
	if slot0.filterView_ then
		slot0.filterView_:Reset(true)
	end

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Reset(true)
	end
end

function slot1.Dispose(slot0)
	if slot0.assistantHeroList_ then
		slot0.assistantHeroList_:Dispose()

		slot0.assistantHeroList_ = nil
	end

	if slot0.selfHeroList_ then
		slot0.selfHeroList_:Dispose()

		slot0.selfHeroList_ = nil
	end

	if slot0.filterView_ then
		slot0.filterView_:Dispose()

		slot0.filterView_ = nil
	end

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:Dispose()

		slot0.heroAvatarView_ = nil
	end

	if slot0.assistFilterView_ then
		slot0.assistFilterView_:Dispose()

		slot0.assistFilterView_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot1.OnGuildBossSelfHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		slot2 = 0
	end

	if slot2 == 0 then
		for slot6 = slot1, 2 do
			slot0.params_.heroList[slot6] = slot0.params_.heroList[slot6 + 1]
		end

		slot0.params_.heroList[3] = nil
	else
		if slot0.params_.heroList[1] ~= nil and slot3.type == 1 and slot3.heroId == slot2 and slot0.params_.heroList[slot1] == nil then
			return
		end

		if slot2 ~= nil and slot2 > 0 then
			slot0.params_.heroList[slot1] = {
				type = 1,
				heroId = slot2
			}
		else
			slot0.params_.heroList[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.params_.heroList)
end

function slot1.OnGuildBossAssistantHeroChange(slot0, slot1, slot2)
	if slot2 == nil then
		for slot6 = slot1, 2 do
			slot0.params_.heroList[slot6] = slot0.params_.heroList[slot6 + 1]
		end

		slot0.params_.heroList[3] = nil
	else
		if slot0.params_.heroList[1] ~= nil and slot3.type == 2 and slot3.info.assist_hero_id == slot2.assist_hero_id and slot3.info.member_id == slot2.member_id and slot0.params_.heroList[slot1] == nil then
			return
		end

		if slot2 ~= nil then
			slot0.params_.heroList[slot1] = {
				type = 2,
				info = slot2
			}
		else
			slot0.params_.heroList[slot1] = nil
		end
	end

	slot0:GuildBossChangeHeroTeam(slot0.params_.heroList)
end

function slot1.GuildBossChangeHeroTeam(slot0, slot1)
	slot3 = {
		0,
		0,
		0
	}
	slot4 = {}
	slot5 = 1

	for slot9 = 1, 3 do
		if slot1[slot9] and slot1[slot9].heroId ~= 0 then
			if slot1[slot9].type == 1 then
				-- Nothing
			elseif slot10.type == 2 then
				slot2[slot5] = slot10.info.assist_hero_id
				slot4[slot5] = slot10.info.member_id
			end

			slot5 = slot5 + 1
		end
	end

	slot6 = ReserveTools.GetReserveTemplateByReserveType(ReserveConst.RESERVE_TYPE.GUILD_BOSS)

	slot6:SetHeroList(slot0.params_.reserveParams, {
		[slot5] = slot10.heroId
	}, slot3)
	slot6:SetOwnerID(slot4)
end

return slot1
