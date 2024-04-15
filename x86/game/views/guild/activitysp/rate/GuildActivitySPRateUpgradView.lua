slot0 = class("GuildActivitySPRateUpgradView", ReduxView)

function slot0.UIName(slot0)
	return "UI/GuildActivitySPUI/GuildActivitySPUpgradeSuccessUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.rateID_ = slot0.params_.rateID
	slot1 = ActivityClubSPLevelSettingCfg[slot0.rateID_]
	slot0.rateText_.text = slot1.user_level
	slot0.domainMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_CAT"), #slot1.dispatch or 0)
	slot0.heroMaxCount_.text = string.format(GetTips("CLUB_ACTIVITY_MAX_HERO"), slot1.max_hero)
end

return slot0
