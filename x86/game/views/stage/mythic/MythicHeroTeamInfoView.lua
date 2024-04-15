slot1 = class("MythicHeroTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.OnEnter(slot0)
	slot0.teamLength_ = slot0.params_.teamLength

	uv0.super.OnEnter(slot0)
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()

	slot0.emptyController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "empty")
	slot0.contorller_ = ControllerUtil.GetController(slot0.joinBtn_.transform, "upgradeBtn")
	slot0.heroAvatarView_ = HeroAvatarView.New(slot0, slot0.displayGo_)
	slot0.heroHeadList_ = LuaList.New(handler(slot0, slot0.HeadRenderer), slot0.uiListGo_, MythicHeroTeamHeadItem)
	slot0.filterView_ = slot0:GetFilterClass().New(slot0.filterGo_)

	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.ExtraSorter))
	slot0.filterView_:SetListChangeHandler(handler(slot0, slot0.OnListChange))
end

function slot1.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
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

function slot1.HeadRenderer(slot0, slot1, slot2)
	slot2:SetProxy(HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT))
	uv0.super.HeadRenderer(slot0, slot1, slot2)
	slot2:RefreshTeamTag(slot0.params_.reserveParams.teamIndex, slot0.teamLength_)
	slot2:SetHeroLock(table.keyof(slot0.lockHeroList_, slot0.heroDataList_[slot1].id) ~= nil)
end

function slot1.SelectHero(slot0, slot1, slot2)
	slot0.selectID_ = slot1
	slot0.selectTrialID_ = slot2

	for slot6, slot7 in pairs(slot0.heroHeadList_:GetItemList()) do
		slot7:SetSelected(slot7.heroId_ == slot1)
	end

	slot0:UpdateHeroView()
	slot0:RefreshJoinBtn()
end

function slot1.GetDefaultHeroData(slot0)
	if (slot0.heroTeam_[slot0.params_.selectHeroPos] or 0) == 0 then
		for slot5, slot6 in pairs(slot0.heroDataList_) do
			if not slot0:IsInTeam(slot6.id) and not table.keyof(slot0.lockHeroList_, slot7) then
				return slot7, 0
			end
		end
	end

	if slot1 == 0 then
		for slot5, slot6 in pairs(slot0.heroDataList_) do
			return slot6.id, 0
		end
	end

	return slot1, 0
end

function slot1.IsInTeam(slot0, slot1)
	for slot5 = 1, #slot0.heroTeam_ do
		if slot0.heroTeam_[slot5] == slot1 then
			return true
		end
	end

	return false
end

function slot1.GetTextAndImage(slot0)
	if slot0.lockStateList_[slot0.params_.selectHeroPos] == true then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if table.keyof(slot0.lockHeroList_, slot0.selectID_) or table.keyof(slot0.lockHeroList_, slot0.selectTrialID_) then
		slot0.joinBtn_.interactable = false

		return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
	end

	if slot0:IsSameHeroInTeam(slot0.selectID_) and not slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		if slot0.heroTeam_[slot0.params_.selectHeroPos] ~= slot0.selectID_ then
			slot0.joinBtn_.interactable = false

			return string.format("<color=#222222>%s</color>", GetTips("IS_LOCK")), "1"
		else
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		end
	end

	if slot0.heroTeam_[slot0.params_.selectHeroPos] == 0 then
		if slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
			return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
		else
			return string.format("<color=#222222>%s</color>", GetTips("JOIN_TEAM")), "0"
		end
	end

	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] then
		for slot5, slot6 in pairs(slot0.heroTeam_) do
			if slot6 ~= 0 then
				slot1 = 0 + 1
			end
		end

		return string.format("<color=#EBEBEB>%s</color>", GetTips("REMOVE_FROM_TEAM")), "2"
	end

	return string.format("<color=#222222>%s</color>", GetTips("CHANGE_MEMBER")), "0"
end

function slot1.OnJoinClick(slot0)
	if slot0.selectID_ == slot0.heroTeam_[slot0.params_.selectHeroPos] and slot0:IsInTeam(slot0.selectID_, slot0.selectTrialID_) then
		clone(slot0.heroTeam_)[slot0.params_.selectHeroPos] = 0
		clone(slot0.heroTrialList_)[slot0.params_.selectHeroPos] = 0
	elseif slot3 then
		slot4 = 1

		for slot8, slot9 in pairs(slot0.heroTeam_) do
			if slot9 == slot0.selectID_ then
				slot4 = slot8

				break
			end
		end

		slot1[slot4] = slot0.heroTeam_[slot0.params_.selectHeroPos]
		slot1[slot0.params_.selectHeroPos] = slot1[slot4]
		slot2[slot4] = slot0.heroTrialList_[slot0.params_.selectHeroPos]
		slot2[slot0.params_.selectHeroPos] = slot2[slot4]

		HeroTools.PlayTalk(slot0.selectID_, "team")
	else
		slot1[slot0.params_.selectHeroPos] = slot0.selectID_
		slot2[slot0.params_.selectHeroPos] = slot0.selectTrialID_

		HeroTools.PlayTalk(slot0.selectID_, "team")
	end

	if slot0.params_.reorder == nil or slot0.params_.reorder == true then
		if slot0:IsCustomTeamStage() then
			slot5 = 1
			slot6 = {
				[slot11] = slot12[1]
			}
			slot7 = {
				[slot11] = slot12[2]
			}

			for slot11, slot12 in pairs(BattleStageTools.GetRestrictHeroList(slot0.params_.stageType, slot0.params_.stageID)) do
				if slot12[1] then
					-- Nothing
				else
					slot6[slot11] = slot1[slot11]
					slot7[slot11] = slot2[slot11]
				end
			end

			for slot11 = 1, 3 do
				if not slot6[slot11] then
					for slot15, slot16 in pairs(slot1) do
						slot17 = table.keyof(slot6, slot16)

						if slot16 ~= 0 and not slot17 then
							slot6[slot11] = slot16
							slot7[slot11] = slot7[slot17]

							break
						end
					end

					slot6[slot11] = slot6[slot11] or 0
					slot7[slot11] = slot7[slot11] or 0
				end
			end

			slot1 = slot6
			slot2 = slot7
		else
			for slot7 = 3, 1, -1 do
				if slot1[slot7] == 0 then
					table.remove(slot1, slot7)
					table.remove(slot2, slot7)
				end
			end

			for slot7 = 1, 3 do
				if not slot1[slot7] then
					slot1[slot7] = 0
					slot2[slot7] = 0
				end
			end
		end
	end

	slot4, slot5, slot6 = nil

	for slot10 = 1, 2 do
		if slot0.params_.reserveParams.teamIndex ~= slot10 then
			slot16 = slot0.params_.stageID

			for slot16, slot17 in ipairs(ReserveTools.GetHeroList(ReserveParams.New(nil, slot0.params_.reserveParams.contID, slot10, {
				stageType = slot0.params_.stageType,
				stageID = slot16
			}))) do
				if slot17 ~= 0 then
					for slot21 = 1, 3 do
						if slot17 == slot1[slot21] then
							slot4 = slot10
							slot5 = slot12
							slot6 = slot16
						end
					end
				end
			end
		end
	end

	if slot4 then
		ShowMessageBox({
			content = string.format(GetTips("CURHERO_USED"), GetTips("NUM_" .. slot4)),
			OkCallback = function ()
				uv0[uv1] = 0

				for slot3 = 1, 2 do
					for slot7 = slot3 + 1, 3 do
						if uv0[slot3] == 0 then
							uv0[slot3] = uv0[slot7]
							uv0[slot7] = 0
						end
					end
				end

				ReserveTools.SetHeroList(ReserveParams.New(nil, uv2.params_.reserveParams.contID, uv3, {
					stageType = uv2.params_.stageType,
					stageID = uv2.params_.stageID
				}), uv0, {
					0,
					0,
					0
				})
				uv2:ExitFunc(uv4, uv5)
			end
		})
	else
		slot0:ExitFunc(slot1, slot2)
	end
end

function slot1.ExitFunc(slot0, slot1, slot2)
	slot0:ChangeTeam(slot1, slot2)

	if slot0.heroAvatarView_ then
		slot0.heroAvatarView_:RemoveTween()
	end

	slot0:Back()
end

function slot1.ChangeTeam(slot0, slot1, slot2)
	slot3 = {}

	for slot7 = 1, 3 do
		if slot1[slot7] ~= 0 then
			slot3[#slot3 + 1] = slot1[slot7]
		end
	end

	for slot7 = #slot3 + 1, 3 do
		slot3[slot7] = 0
	end

	slot5, slot6 = ReserveTools.GetMimirData(slot0.params_.reserveParams)

	ReserveTools.SetTeam(slot0.params_.reserveParams, slot3, slot2 or {}, ComboSkillTools.GetRecommendSkillID(slot3, true), slot5, slot6)
end

return slot1
