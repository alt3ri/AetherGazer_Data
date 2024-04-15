slot1 = class("NewGuildBossSetAssistantView", import("game.views.heroTeamInfo.NewHeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	slot0.filterView_:SetExtraSorter(function (slot0, slot1, slot2, slot3)
		if (GuildData:CheckCurrentHeroIDIsAssistant(slot0.id) and 1 or 0) ~= (GuildData:CheckCurrentHeroIDIsAssistant(slot1.id) and 1 or 0) then
			return true, slot5 < slot4
		end

		return false, false
	end)
end

function slot1.HeadRenderer(slot0, slot1, slot2)
	uv0.super.HeadRenderer(slot0, slot1, slot2)

	if GuildData:CheckCurrentHeroIDIsAssistant(slot0.heroDataList_[slot1].id) then
		slot2:SetTeamMarkBg("purple")
		slot2:SetTeamMark(true, GetTips("CURRENT_ASSISTANT"))
	else
		slot2:SetTeamMark(false)
	end
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	slot0:AddEventListeners()
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot1.AddEventListeners(slot0)
	slot0:RegistEventListener(GUILD_BOSS_ASSISTANT_HERO_CHANGE, function (slot0)
		uv0.heroHeadList_:Refresh()
		uv0:RefreshJoinBtn()
	end)
	slot0:RegistEventListener(GUILD_EXIT, function ()
		uv0:Go("/home")
	end)
end

function slot1.GetHeroTeam(slot0)
	slot0.lockStateList_ = {
		false,
		false,
		false
	}
end

function slot1.OnJoinClick(slot0)
	if GuildData:CheckCurrentHeroIDIsAssistant(slot0.selectHeroData_.id) then
		GuildAction.SetAssistHero(GuildData:GetGuildInfo().id, slot1, false)

		return
	end

	if GameSetting.club_boss_assist_max_num.value[1] <= #GuildData:GetCurrentBossAssistantHeroId() then
		ShowTips("CLUB_BOSS_ASSIST_MAX_NUM")
	else
		GuildAction.SetAssistHero(slot2, slot1, true)
	end
end

function slot1.RefreshJoinBtn(slot0)
	if GuildData:CheckCurrentHeroIDIsAssistant(slot0.selectHeroData_.id) then
		slot0.joinBtnController_:SetSelectedState("currentAssistant")

		slot0.joinBtn_.interactable = true
	else
		slot0.joinBtnController_:SetSelectedState("setAssistant")

		slot0.joinBtn_.interactable = true
	end
end

function slot1.IsInTeam(slot0, slot1, slot2)
	return GuildData:CheckCurrentHeroIDIsAssistant(slot1), false, -1
end

function slot1.GetDefaultHeroData(slot0)
	if GuildData:GetCurrentBossAssistantHeroId() and #slot1 > 0 then
		for slot5, slot6 in ipairs(slot0.heroDataList_) do
			if slot6.id == slot1[1] then
				return slot6
			end
		end
	end

	return slot0.heroDataList_[1]
end

return slot1
