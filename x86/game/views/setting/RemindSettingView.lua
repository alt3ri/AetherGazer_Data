slot0 = class("RemindSettingView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
	slot0:OnEnter()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddToggleListener(slot0.fatigueFullReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("fatigue_full_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.signReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("activity_sign_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.monthCardReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("month_card_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.dailyFatigueReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("daily_fatigue_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.catExploreReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("cat_explore_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.canteenDispatchReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("canteen_dispatch_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.canteenFullReminderTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("canteen_full_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.diamondBuyItemTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("diamond_buy_item_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.coreEquipBuyItemTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("core_equip_buy_item_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.infoBadgeTopBuyItemTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("info_badge_top_buy_item_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.bossChallengeSBuyItemTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("boss_challenge_s_buy_item_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.diamondBuyFatigueTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("diamond_buy_fatigue_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.diamondBuyGoldTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("diamond_buy_gold_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.spiritRefineTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("spirit_refine_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.refreshEnchantmentTimesTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("refresh_enchantment_times_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.uninstallEquipTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("uninstall_equip_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.rebuildHeroEquipTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("rebuild_hero_equip_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.servantPromoteTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("servant_promote_reminder", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.battleLowFpsTgl_, function (slot0)
		slot1 = nil

		SettingAction.ChangeRemindSetting("battle_low_fps_tips", slot0 and 1 or 0)
	end)
	slot0:AddToggleListener(slot0.m_cooperationGuildTgl_, function (slot0)
		CooperationAction.SetInviteRestrict(2, CooperationData:GetInviteRestrict(2) and 2 or 1)
	end)
	slot0:AddToggleListener(slot0.m_cooperationFriendTgl_, function (slot0)
		CooperationAction.SetInviteRestrict(1, CooperationData:GetInviteRestrict(1) and 2 or 1)
	end)
	slot0:AddToggleListener(slot0.m_cooperationRecentTgl_, function (slot0)
		CooperationAction.SetInviteRestrict(3, CooperationData:GetInviteRestrict(3) and 2 or 1)
	end)
end

function slot0.OnEnter(slot0)
	slot0.settingData_ = SettingData:GetRemindSettingData()

	slot0:RefreshSignReminder()
	slot0:RefreshMonthCardReminder()
	slot0:RefreshFatigueFullReminder()
	slot0:RefreshDailyFatigueReminder()
	slot0:RefreshCatExploreReminder()
	slot0:RefreshCanteenDispatchReminder()
	slot0:RefreshCanteenFullReminder()
	slot0:RefreshDiamondBuyItemReminder()
	slot0:RefreshCoreEquipBuyItemReminder()
	slot0:RefreshInfoBadgeTopBuyItemReminder()
	slot0:RefreshBossChallengeSBuyItemReminder()
	slot0:RefreshDiamondBuyFatigueReminder()
	slot0:RefreshDiamondBuyGoldReminder()
	slot0:RefreshSpiritRefineReminder()
	slot0:RefreshServantPromoteReminder()
	slot0:RefreshRefreshEnchantmentTimesReminder()
	slot0:RefreshUninstallEquipReminder()
	slot0:RefreshRebuildHeroEquipReminder()
	slot0:RefreshBattleLowFpsTipReminder()

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)

	slot0:RefreshCooperationRestrict()
end

function slot0.OnExit(slot0)
end

function slot0.RefreshCooperationRestrict(slot0)
	slot1 = CooperationData:GetInviteRestrict(1) and 0 or 1
	slot0.m_cooperationFriendTgl_.isOn = slot1 == 1

	slot0.m_cooperationFriendCon_:GetController("default0"):SetSelectedIndex(slot1)

	slot3 = CooperationData:GetInviteRestrict(2) and 0 or 1
	slot0.m_cooperationGuildTgl_.isOn = slot3 == 1

	slot0.m_cooperationGuildCon_:GetController("default0"):SetSelectedIndex(slot3)

	slot5 = CooperationData:GetInviteRestrict(3) and 0 or 1
	slot0.m_cooperationRecentTgl_.isOn = slot5 == 1

	slot0.m_cooperationRecentCon_:GetController("default0"):SetSelectedIndex(slot5)
end

function slot0.OnCooperationRestrictUpdate(slot0)
	slot0:RefreshCooperationRestrict()
end

function slot0.OnRemindChange(slot0, slot1, slot2)
	if slot2.key == "allData" then
		slot0:RefreshSignReminder()
		slot0:RefreshMonthCardReminder()
		slot0:RefreshFatigueFullReminder()
		slot0:RefreshDailyFatigueReminder()
		slot0:RefreshCatExploreReminder()
		slot0:RefreshCanteenDispatchReminder()
		slot0:RefreshCanteenFullReminder()
		slot0:RefreshDiamondBuyItemReminder()
		slot0:RefreshCoreEquipBuyItemReminder()
		slot0:RefreshInfoBadgeTopBuyItemReminder()
		slot0:RefreshBossChallengeSBuyItemReminder()
		slot0:RefreshDiamondBuyFatigueReminder()
		slot0:RefreshDiamondBuyGoldReminder()
		slot0:RefreshSpiritRefineReminder()
		slot0:RefreshRefreshEnchantmentTimesReminder()
		slot0:RefreshUninstallEquipReminder()
		slot0:RefreshRebuildHeroEquipReminder()
		slot0:RefreshServantPromoteReminder()
		slot0:RefreshBattleLowFpsTipReminder()
	elseif slot2.key == "activity_sign_reminder" then
		slot0:RefreshSignReminder()
	elseif slot2.key == "month_card_reminder" then
		slot0:RefreshMonthCardReminder()
	elseif slot2.key == "fatigue_full_reminder" then
		slot0:RefreshFatigueFullReminder()
	elseif slot2.key == "daily_fatigue_reminder" then
		slot0:RefreshDailyFatigueReminder()
	elseif slot2.key == "cat_explore_reminder" then
		slot0:RefreshCatExploreReminder()
	elseif slot2.key == "canteen_dispatch_reminder" then
		slot0:RefreshCanteenDispatchReminder()
	elseif slot2.key == "canteen_full_reminder" then
		slot0:RefreshCanteenFullReminder()
	elseif slot2.key == "diamond_buy_item_reminder" then
		slot0:RefreshDiamondBuyItemReminder()
	elseif slot2.key == "core_equip_buy_item_reminder" then
		slot0:RefreshCoreEquipBuyItemReminder()
	elseif slot2.key == "info_badge_top_buy_item_reminder" then
		slot0:RefreshInfoBadgeTopBuyItemReminder()
	elseif slot2.key == "boss_challenge_s_buy_item_reminder" then
		slot0:RefreshBossChallengeSBuyItemReminder()
	elseif slot2.key == "diamond_buy_fatigue_reminder" then
		slot0:RefreshDiamondBuyFatigueReminder()
	elseif slot2.key == "diamond_buy_gold_reminder" then
		slot0:RefreshDiamondBuyGoldReminder()
	elseif slot2.key == "spirit_refine_reminder" then
		slot0:RefreshSpiritRefineReminder()
	elseif slot2.key == "refresh_enchantment_times_reminder" then
		slot0:RefreshRefreshEnchantmentTimesReminder()
	elseif slot2.key == "uninstall_equip_reminder" then
		slot0:RefreshUninstallEquipReminder()
	elseif slot2.key == "rebuild_hero_equip_reminder" then
		slot0:RefreshRebuildHeroEquipReminder()
	elseif slot2.key == "servant_promote_reminder" then
		slot0:RefreshServantPromoteReminder()
	elseif slot2.key == "battle_low_fps_tips" then
		slot0:RefreshBattleLowFpsTipReminder()
	end
end

function slot0.RefreshSignReminder(slot0)
	slot0.signReminderTgl_.isOn = slot0.settingData_.activity_sign_reminder == 1

	slot0.signReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.activity_sign_reminder)
end

function slot0.RefreshMonthCardReminder(slot0)
	slot0.monthCardReminderTgl_.isOn = slot0.settingData_.month_card_reminder == 1

	slot0.monthCardReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.month_card_reminder)
end

function slot0.RefreshFatigueFullReminder(slot0)
	slot0.fatigueFullReminderTgl_.isOn = slot0.settingData_.fatigue_full_reminder == 1

	slot0.fatigueFullReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.fatigue_full_reminder)
end

function slot0.RefreshDailyFatigueReminder(slot0)
	slot0.dailyFatigueReminderTgl_.isOn = slot0.settingData_.daily_fatigue_reminder == 1

	slot0.dailyFatigueReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.daily_fatigue_reminder)
end

function slot0.RefreshCatExploreReminder(slot0)
	slot0.catExploreReminderTgl_.isOn = slot0.settingData_.cat_explore_reminder == 1

	slot0.catExploreReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.cat_explore_reminder)
end

function slot0.RefreshCanteenDispatchReminder(slot0)
	slot0.canteenDispatchReminderTgl_.isOn = slot0.settingData_.canteen_dispatch_reminder == 1

	slot0.canteenDispatchReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.canteen_dispatch_reminder)
end

function slot0.RefreshCanteenFullReminder(slot0)
	slot0.canteenFullReminderTgl_.isOn = slot0.settingData_.canteen_full_reminder == 1

	slot0.canteenFullReminderCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.canteen_full_reminder)
end

function slot0.RefreshDiamondBuyItemReminder(slot0)
	slot0.diamondBuyItemTgl_.isOn = slot0.settingData_.diamond_buy_item_reminder == 1

	slot0.diamondBuyItemCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.diamond_buy_item_reminder)
end

function slot0.RefreshCoreEquipBuyItemReminder(slot0)
	slot0.coreEquipBuyItemTgl_.isOn = slot0.settingData_.core_equip_buy_item_reminder == 1

	slot0.coreEquipBuyItemCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.core_equip_buy_item_reminder)
end

function slot0.RefreshInfoBadgeTopBuyItemReminder(slot0)
	slot0.infoBadgeTopBuyItemTgl_.isOn = slot0.settingData_.info_badge_top_buy_item_reminder == 1

	slot0.infoBadgeTopBuyItemCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.info_badge_top_buy_item_reminder)
end

function slot0.RefreshBossChallengeSBuyItemReminder(slot0)
	slot0.bossChallengeSBuyItemTgl_.isOn = slot0.settingData_.boss_challenge_s_buy_item_reminder == 1

	slot0.bossChallengeSBuyItemCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.boss_challenge_s_buy_item_reminder)
end

function slot0.RefreshDiamondBuyFatigueReminder(slot0)
	slot0.diamondBuyFatigueTgl_.isOn = slot0.settingData_.diamond_buy_fatigue_reminder == 1

	slot0.diamondBuyFatigueCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.diamond_buy_fatigue_reminder)
end

function slot0.RefreshDiamondBuyGoldReminder(slot0)
	slot0.diamondBuyGoldTgl_.isOn = slot0.settingData_.diamond_buy_gold_reminder == 1

	slot0.diamondBuyGoldCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.diamond_buy_gold_reminder)
end

function slot0.RefreshSpiritRefineReminder(slot0)
	slot0.spiritRefineTgl_.isOn = slot0.settingData_.spirit_refine_reminder == 1

	slot0.spiritRefineCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.spirit_refine_reminder)
end

function slot0.RefreshServantPromoteReminder(slot0)
	slot0.servantPromoteTgl_.isOn = slot0.settingData_.servant_promote_reminder == 1

	slot0.servantPromoteCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.servant_promote_reminder)
end

function slot0.RefreshRefreshEnchantmentTimesReminder(slot0)
	slot0.refreshEnchantmentTimesTgl_.isOn = slot0.settingData_.refresh_enchantment_times_reminder == 1

	slot0.refreshEnchantmentTimesCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.refresh_enchantment_times_reminder)
end

function slot0.RefreshUninstallEquipReminder(slot0)
	slot0.uninstallEquipTgl_.isOn = slot0.settingData_.uninstall_equip_reminder == 1

	slot0.uninstallEquipCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.uninstall_equip_reminder)
end

function slot0.RefreshRebuildHeroEquipReminder(slot0)
	slot0.rebuildHeroEquipTgl_.isOn = slot0.settingData_.rebuild_hero_equip_reminder == 1

	slot0.rebuildHeroEquipCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.rebuild_hero_equip_reminder)
end

function slot0.RefreshBattleLowFpsTipReminder(slot0)
	slot0.battleLowFpsTgl_.isOn = slot0.settingData_.battle_low_fps_tips == 1

	slot0.battleLowFpsCon_:GetController("default0"):SetSelectedIndex(slot0.settingData_.battle_low_fps_tips)
end

function slot0.CheckDataChange(slot0, slot1)
	if slot0.tmpSettingData_ and not table.equal(slot0.tmpSettingData_, slot0.settingData_, "all") then
		return true
	end

	return false
end

function slot0.SaveData(slot0)
	if slot0:CheckDataChange() then
		SDKTools.SendMessageToSDK("remind_setting", {
			signin_push_setting = slot0.settingData_.activity_sign_reminder,
			insider_push_setting = slot0.settingData_.month_card_reminder,
			dundun_push_setting = slot0.settingData_.fatigue_full_reminder
		})

		if slot0.settingData_.fatigue_full_reminder == 0 then
			TimerReminderData:CancelReminder(TimerReminderConst.FATIGUE)
		end

		ReminderAction:SettingMotify(slot0.settingData_.activity_sign_reminder, slot0.settingData_.month_card_reminder)
	end

	slot0.tmpSettingData_ = deepClone(slot0.settingData_)
end

function slot0.RecoverTmpData(slot0)
	if slot0:CheckDataChange() then
		SettingAction.ChangeRemindSetting("allData", slot0.tmpSettingData_)
	end
end

function slot0.Dispose(slot0)
	slot0.hander_ = nil

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
