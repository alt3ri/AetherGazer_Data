manager.net:Bind(73001, function (slot0)
	ComboSkillData:InitLevelData(slot0)
end)
manager.net:Bind(73003, function (slot0)
	ComboSkillData:UpdateLevelData(slot0)

	for slot6, slot7 in ipairs(ComboSkillCfg[slot0.skill.id].cooperate_role_ids) do
		ArchiveAction.CheckComboSkillRedPoint(slot7)
	end
end)

return {
	QueryUpgradeComboSkillLevel = function (slot0)
		manager.net:SendWithLoadingNew(73018, {
			cooperate_unique_skill_id = slot0
		}, 73019, uv0.OnUpgradeComboSkillLevelBack)
	end,
	OnUpgradeComboSkillLevelBack = function (slot0, slot1)
		if isSuccess(slot0.result) then
			manager.notify:CallUpdateFunc(HERO_COMBO_SKILL_LEVEL_UP)
			ShowTips(GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_SUCCESS", "LV." .. ComboSkillData:GetCurComboSkillLevel(slot1.cooperate_unique_skill_id)))
		else
			ShowTips(slot0.result)
		end
	end
}
