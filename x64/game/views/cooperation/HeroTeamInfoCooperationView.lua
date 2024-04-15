slot0 = class("HeroTeamInfoCooperationView", ReduxView)

function slot0.UIName(slot0)
	return "UI/Cooperation/HeroTeamInfoCooperationUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, HeroTeamHeadItem)
	slot0.filterView_ = HeroListFilterWithTrialView.New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		if uv0:CheckInTeam(slot0.id, slot0.trialID) ~= uv0:CheckInTeam(slot1.id, slot1.trialID) then
			return true, slot4
		end

		if slot0.trialID ~= 0 or slot1.trialID ~= 0 then
			if slot0.trialID ~= 0 and slot1.trialID ~= 0 then
				if slot2 == 0 and slot0.star ~= slot1.star then
					if uv0.curOrder_ == "desc" then
						return true, slot1.star < slot0.star
					else
						return true, slot0.star < slot1.star
					end
				end

				if getHeroPower(slot0.trialID, true) ~= getHeroPower(slot1.trialID, true) then
					if slot3 == "desc" then
						return true, slot7 < slot6
					else
						return true, slot6 < slot7
					end
				else
					return true, slot1.trialID < slot0.trialID
				end
			else
				return true, slot1.trialID < slot0.trialID
			end
		end

		return false, false
	end)
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		uv0:OnJoinClick()
	end)
end

function slot0.OnJoinClick(slot0)
	slot1 = slot0.selectID_
	slot2 = 1

	if slot0.selectTrialID_ ~= 0 then
		slot1 = slot0.selectTrialID_
		slot2 = 2
	end

	CooperationAction.ChangeHero({
		{
			hero_id = slot1,
			hero_type = slot2,
			owner_id = BattleTeamData.NO_OWNER
		}
	})
end

function slot0.OnListChange(slot0, slot1)
	slot0.heroDataList_ = slot1

	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_)

	if #slot0.heroDataList_ > 0 then
		slot0:SelectHero(slot0.heroDataList_[1].id, slot0.heroDataList_[1].trialID)
	end
end

function slot0.OnEnter(slot0)
	manager.ui:SetMainCamera("hero")

	slot0.heroViewProxy_ = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.COOPERATION)

	if slot0.params_.isEnter then
		if slot0.filterView_ then
			slot0.filterView_:Reset()
		end

		slot0.params_.isEnter = false
	end

	manager.windowBar:SwitchBar({
		BACK_BAR
	})

	slot0.room = CooperationData:GetRoomData()

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnEnter()
	end

	slot1 = CooperationTools.GetCooperationTeamHeroList(slot0.room.type, slot0.room.dest, slot0.room.activity_id)

	if slot0.room then
		slot0.selectID_, slot0.selectTrialID_ = slot0.room:GetSelfHero()
	else
		slot2 = slot1[1]
		slot0.selectTrialID_ = slot2.trialID
		slot0.selectID_ = slot2.id
	end

	slot0.filterView_:SetHeroDataList(slot1)
	slot0:SelectHero(slot0.selectID_, slot0.selectTrialID_)
	slot0.heroHeadList_:StartScroll(#slot0.heroDataList_, table.keyof(slot0.heroDataList_, slot0.selectID_))
end

function slot0.OnExit(slot0)
	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:OnExit()
	end

	if #slot0.heroDataList_ <= 0 then
		HeroData:ResetSortValue()
		slot0.filterView_:Reset()
	end
end

function slot0.UpdateHeroView(slot0)
	slot1 = slot0.selectID_
	slot2 = nil
	slot2 = (not slot0.selectTrialID_ or slot0.selectTrialID_ == 0 or HeroStandardSystemCfg[slot0.selectTrialID_].skin_id) and HeroTools.HeroUsingSkinInfo(slot0.selectID_).id

	if slot0.selectTrialID_ and slot0.selectTrialID_ ~= 0 then
		slot0.fightPowerText_.text = getHeroPower(slot0.selectTrialID_, true)
	else
		slot0.fightPowerText_.text = getHeroPower(slot1, false)
	end

	slot0.heroAvatarView_:SetSkinId(slot2)

	slot3 = HeroCfg[slot1]
	slot0.nameText_.text = GetI18NText(slot3.name)
	slot0.subNameText_.text = GetI18NText(slot3.suffix)
end

function slot0.HeadRenderer(slot0, slot1, slot2)
	slot2:SetRedPointEnable(false)

	slot2.gameObject_.name = tostring(slot0.heroDataList_[slot1].id)

	if slot0.heroDataList_[slot1].trialID == 0 then
		slot2:SetHeroData(slot3, HeroConst.HERO_DATA_TYPE.DEFAULT, {
			tempHeroList = {
				slot4
			}
		})
		slot2:SetTrial(false)
	else
		slot2:SetHeroData(slot4, HeroConst.HERO_DATA_TYPE.TRIAL, {
			tempHeroList = {
				slot4
			}
		})
		slot2:SetTrial(true)
	end

	slot2:SetSelected(slot2.heroId_ == slot0.selectID_ and slot2.trialID_ == slot0.selectTrialID_)
	slot2:SetInTeamFlag(slot0:CheckInTeam(slot3, slot4), false)
	slot2:RegisterClickListener(function ()
		uv0:SelectHero(uv1.heroId_, uv1.trialID_)
	end)
end

function slot0.SelectHero(slot0, slot1, slot2)
	slot0.selectID_ = slot1
	slot0.selectTrialID_ = slot2
	slot5 = slot0.heroHeadList_
	slot7 = slot5

	for slot6, slot7 in pairs(slot5.GetItemList(slot7)) do
		slot7:SetSelected(slot7.heroId_ == slot1 and slot7.trialID_ == slot2)
	end

	if HeroData:GetHeroData(slot1) then
		slot0.heroViewProxy_:GetHeroAllAttribute(slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot0.RefreshJoinBtn(slot0)
	if slot0:CheckRepeatHero(slot0.selectID_, slot0.selectTrialID_) then
		slot0.joinBtn_.interactable = false
		slot0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("COOPERATION_TEAM_REPEAT_HERO"))

		slot0.contorller_:SetSelectedState("1")
	else
		slot0.joinBtn_.interactable = true
		slot0.joinText_.text = string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER"))

		slot0.contorller_:SetSelectedState("0")
	end
end

function slot0.CheckRepeatHero(slot0, slot1)
	if not CooperationData:GetRoomData() then
		return false
	end

	for slot7, slot8 in ipairs(slot2:GetRoomPlayerIdList()) do
		if slot2:GetRoomPlayerData(slot8).is_ready == 1 then
			for slot13, slot14 in ipairs(slot9.heroList) do
				if slot1 == slot14.id then
					return true
				end
			end
		end
	end

	return false
end

function slot0.CheckInTeam(slot0, slot1, slot2)
	if not CooperationData:GetRoomData() then
		return false
	end

	slot4, slot5 = slot3:GetSelfHero()

	return slot1 == slot4 and slot2 == slot5
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

	uv0.super.Dispose(slot0)
end

function slot0.OnHeroSort(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.filterView_:RefreshSort(slot1, slot2, slot3, slot4, slot5)
end

function slot0.OnCooperationRoomInit(slot0)
	slot0.heroHeadList_:Refresh()
	slot0:RefreshJoinBtn()
end

function slot0.OnCooperationRoomUpdate(slot0)
	slot0.heroHeadList_:Refresh()
	slot0:RefreshJoinBtn()
end

return slot0
