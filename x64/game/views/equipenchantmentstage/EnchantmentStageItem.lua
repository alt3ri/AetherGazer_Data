slot0 = class("EnchantmentStageItem", ReduxView)
slot1 = {
	"icon_ee_boss_b",
	"icon_ee_boss_a",
	"icon_ee_boss_s"
}
slot2 = {
	"bg_ee_boss_b",
	"bg_ee_boss_a",
	"bg_ee_boss_s"
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.onClick_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selectBtn_, nil, function ()
		if uv0.onClick_ then
			uv0.onClick_()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.rareBgImg_.sprite = getSprite("Atlas/EnchantmentStageAtlas", uv0[slot2])
	slot0.bossImg_.sprite = getSpriteWithoutAtlas("TextureConfig/EnchantmentStage/" .. BattleEnchantmentStageCfg[slot1].hd_image)
	slot0.rareTagImg_.sprite = getSprite("Atlas/BattleStage", uv1[slot2] .. SettingData:GetCurrentLanguageKey())
	slot0.buff_ = getHeroAffixs(BattleEnchantmentStageCfg[slot1].affix_type)

	if slot0.buff_ and slot0.buff_ ~= "" and slot0.buff_[1] then
		slot0.buffImg_.sprite = getAffixSprite(slot0.buff_[1])
	else
		slot0.buffImg_.sprite = nil
	end

	slot0.debuff_ = BattleEnchantmentStageCfg[slot1].affix_type_in_map == "" and getMosterAffix(BattleEnchantmentStageCfg[slot1].affix_type) or BattleEnchantmentStageCfg[slot1].affix_type_in_map

	if slot0.debuff_ and slot0.debuff_ ~= "" and slot0.debuff_[1] then
		slot0.debuffImg_.sprite = getAffixSprite(slot0.debuff_[1])
	else
		slot0.debuffImg_.sprite = nil
	end

	slot0.stageID_ = slot1
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
