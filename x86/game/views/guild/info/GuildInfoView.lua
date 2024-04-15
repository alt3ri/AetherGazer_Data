slot0 = class("GuildInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Club/ClubSharePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = slot0.btnController:GetController("btn")
	slot0.emptyController = slot0.btnController:GetController("empty")
	slot0.clearController = slot0.controller:GetController("clear")
	slot0.refreshHandler_ = handler(slot0, slot0.RefreshBtn)
	slot0.enterGuildHandler_ = handler(slot0, slot0.EnterGuild)
end

function slot0.OnEnter(slot0)
	slot0.guildID_ = slot0.params_.guildID

	slot0:RefreshUI()
	manager.notify:RegistListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RegistListener(GUILD_REQUIRE, slot0.refreshHandler_)
end

function slot0.OnExit(slot0)
	manager.notify:RemoveListener(GUILD_ENTER, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_EXIT, slot0.refreshHandler_)
	manager.notify:RemoveListener(GUILD_REQUIRE, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.joinBtn_, nil, function ()
		if GuildData:GetGuildInfo().id then
			return
		end

		if table.keyof(ChatGuildRecruitData:GetRequireGuild(), uv0.guildID_) then
			return
		end

		SDKTools.SendMessageToSDK("club_member_manage_jump", {
			source = uv0.params_.source
		})
		manager.notify:RegistListener(GUILD_ENTER, uv0.enterGuildHandler_)
		GuildAction.GuildRequestJoin(uv0.guildID_, function (slot0)
			manager.notify:RemoveListener(GUILD_ENTER, uv0.enterGuildHandler_)
		end)
	end)
end

function slot0.RefreshUI(slot0)
	slot1 = GuildData:GetCacheGuildInfo(slot0.guildID_)
	slot0.iconBg_.sprite = getSpriteViaConfig("ClubHeadIcon", ClubHeadIconCfg[slot1.icon].bg)
	slot0.idText_.text = string.format("ID:%s", slot1.id)
	slot0.nameText_.text = GetI18NText(slot1.name)
	slot0.levelText_.text = string.format(GetTips("CLUB_LEVEL"), slot1.level)
	slot0.activePointText_.text = GetI18NText(slot1.contribute)
	slot0.memberText_.text = string.format("%s/%s", slot1.memberCnt, slot1.maxMemberCnt)
	slot0.captainNameText_.text = GetI18NText(slot1.captain)

	if slot1.notice and slot1.notice ~= "" then
		slot0.emptyController:SetSelectedState("full")

		slot0.noticeText_.text = GetI18NText(slot1.notice)
	else
		slot0.emptyController:SetSelectedState("empty")
	end

	slot0:RefreshLevelLimitInfo()

	for slot8 = slot1.level - 1, 1, -1 do
		slot4 = slot1.exp - ClubLevelCfg[slot8].club_level_exp
	end

	slot5 = ClubLevelCfg[slot3].club_level_exp

	if GameSetting.club_max_level.value[1] <= slot3 then
		-- Nothing
	end

	slot0:RefreshBtn()
end

function slot0.RefreshLevelLimitInfo(slot0)
	slot1 = GuildData:GetCacheGuildInfo(slot0.guildID_)

	if GuildData:GetGuildInfo().id == slot0.guildID_ then
		slot0.clearController:SetSelectedState("clear")

		slot0.joinTxt_.text = GetI18NText(GetTips("CLUB_SHARE_TIPS_5"))
	else
		slot0.joinTxt_.text = string.format(GetTips("CLUB_LEVEL_LIMIT"), slot1.limitLevel)

		if PlayerData:GetPlayerInfo().userLevel < slot1.limitLevel then
			slot0.clearController:SetSelectedState("notclear")
		else
			slot0.clearController:SetSelectedState("clear")
		end
	end
end

function slot0.RefreshBtn(slot0)
	slot1 = slot0.guildID_

	if GuildData:GetGuildInfo().id then
		slot0.controller_:SetSelectedState("cannot")

		if slot2.id == slot0.guildID_ then
			slot0.controller_:SetSelectedState("self")
		end
	elseif table.keyof(ChatGuildRecruitData:GetRequireGuild(), slot1) then
		slot0.controller_:SetSelectedState("applyed")
	else
		slot0.controller_:SetSelectedState("apply")
	end
end

function slot0.EnterGuild(slot0)
	slot0:Back()
	JumpTools.OpenPageByJump("/guildEntrace/guildMain")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.refreshHandler_ = nil
	slot0.enterGuildHandler_ = nil
end

return slot0
