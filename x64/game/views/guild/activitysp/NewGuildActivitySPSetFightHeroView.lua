slot1 = class("NewGuildActivitySPSetFightHeroView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.ExtraSorter(slot0, slot1, slot2, slot3, slot4)
	slot5 = slot0.params_.heroId or 0

	if (slot1.id == slot5 and 1 or 0) ~= (slot2.id == slot5 and 1 or 0) then
		return true, slot7 < slot6
	end

	return false, false
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.energyItem_ = GuildActivitySPTeamInfoEnergyItemView.New(Object.Instantiate(Asset.Load("UI/GuildActivitySPUI/items/spenergy"), slot0.extensionContainer_))
end

function slot1.UpdateHeroView(slot0)
	uv0.super.UpdateHeroView(slot0)
	slot0.energyItem_:SetCurrent(slot0:IsHeroInTeam(slot0.selectHeroData_.id))

	slot1 = GameSetting.activity_club_sp_hero_fatigue_max.value[1]
	slot2 = nil

	slot0.energyItem_:SetData(slot1, GuildActivitySPData:IsFirstConfigFightRole() and slot1 or table.indexof(slot0.params_.putOffList, slot0.selectHeroData_.id) and 0 or GuildActivitySPData:GetHeroFatigue(slot0.selectHeroData_.id))
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot1.RefreshInfoBtn(slot0)
	SetActive(slot0.infoBtn_.gameObject, false)
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot1.GetHeroTeam(slot0)
end

function slot1.OnJoinClick(slot0)
	if slot0.params_.heroId ~= nil and slot0.params_.heroId > 0 then
		if slot0.selectHeroData_.id == slot0.params_.heroId then
			if not GuildActivitySPData:IsFirstConfigFightRole() then
				ShowMessageBox({
					content = GetTips("ACTIVITY_CLUB_REMOVE_TEAM_TIP"),
					OkCallback = function ()
						if uv0.params_.callback then
							uv0.params_.callback(uv0.params_.index, uv0.params_.heroId, 0)
						end

						uv0:Back()
					end,
					CancelCallback = function ()
					end
				})
			else
				if slot0.params_.callback then
					slot0.params_.callback(slot0.params_.index, slot0.params_.heroId, 0)
				end

				slot0:Back()
			end
		elseif not GuildActivitySPData:IsFirstConfigFightRole() then
			ShowMessageBox({
				content = GetTips("ACTIVITY_CLUB_JOIN_ZERO_VITALITY_TIP"),
				OkCallback = function ()
					if uv0.params_.callback then
						uv0.params_.callback(uv0.params_.index, uv0.params_.heroId, uv0.selectHeroData_.id)
					end

					uv0:Back()
				end,
				CancelCallback = function ()
				end
			})
		else
			if slot0.params_.callback then
				slot0.params_.callback(slot0.params_.index, slot0.params_.heroId, slot0.selectHeroData_.id)
			end

			slot0:Back()
		end
	else
		if slot0.params_.callback then
			slot0.params_.callback(slot0.params_.index, 0, slot0.selectHeroData_.id)
		end

		slot0:Back()
	end
end

function slot1.RefreshJoinBtn(slot0)
	slot0.joinBtn_.interactable = true

	if slot0.params_.heroId ~= nil and slot0.params_.heroId > 0 then
		if slot0.selectHeroData_.id == slot0.params_.heroId then
			slot0.joinBtnController_:SetSelectedState("out")
		else
			slot0.joinBtnController_:SetSelectedState("change")
		end
	else
		slot0.joinBtnController_:SetSelectedState("add")
	end
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return slot1 == slot0.params_.heroId, false, -1
end

function slot1.GetDefaultHeroData(slot0)
	return slot0.heroDataList_[1]
end

function slot1.GetHeroList(slot0)
	for slot6, slot7 in pairs(HeroData:GetHeroList()) do
		if not slot0:IsHeroInTeam(slot7.id) or slot7.id == slot0.params_.heroId then
			-- Nothing
		end
	end

	return HeroTools.Sort({
		[slot7.id] = slot7
	})
end

function slot1.ChangeTeam(slot0, slot1, slot2)
end

function slot1.IsHeroInTeam(slot0, slot1)
	for slot6, slot7 in ipairs(slot0.params_.heroList) do
		if slot7.id == slot1 then
			return true
		end
	end

	return false
end

function slot1.Dispose(slot0)
	if slot0.energyItem_ then
		slot0.energyItem_:Dispose()

		slot0.energyItem_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot1
