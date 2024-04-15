slot1 = class("FactoryHeroTrialView", import("game.views.heroTrialActivity.HeroTrialActivityView"))

function slot1.UIName(slot0)
	return "UI/MardukUI/HeroTrial/MardukHeroTrialUI"
end

function slot1.RefreshTextName(slot0, slot1)
	slot0.textName_.text = GetI18NText(string.format("<size=46>%s</size>", slot1))
end

function slot1.GetRewardItem(slot0, slot1)
	return RewardPoolFactoryItem.New(slot0.goRewardPanel_, slot1, true)
end

function slot1.GetActiviteHeroIDList(slot0)
	slot1 = {}
	slot2 = {}

	if SDKTools.GetIsOverSea() then
		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_HERO_TRIAL_1_OVERSEA) then
			slot2[#slot2 + 1] = ActivityConst.FACTORY_HERO_TRIAL_1_OVERSEA
		end

		if ActivityData:GetActivityIsOpen(ActivityConst.FACTORY_HERO_TRIAL_2_OVERSEA) then
			slot2[#slot2 + 1] = ActivityConst.FACTORY_HERO_TRIAL_2_OVERSEA
		end
	else
		slot2[#slot2 + 1] = slot0.activiteID_
	end

	for slot6, slot7 in ipairs(slot2) do
		for slot11, slot12 in pairs(ActivityHeroTrialCfg.get_id_list_by_activity_id[slot7]) do
			table.insert(slot1, slot12)
		end
	end

	return slot1
end

return slot1
