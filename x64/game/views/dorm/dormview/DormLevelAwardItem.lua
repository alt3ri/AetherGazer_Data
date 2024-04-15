slot0 = class("DormLevelAwardItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.selController = ControllerUtil.GetController(slot0.transform_, "selectItem")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.index = slot2
	slot9 = "DORM_LEVEL_TIPS"
	slot8 = slot2
	slot0.levelText.text = string.format(GetTips(slot9), slot8)
	slot0.rewardItemList_ = {}
	slot4 = ""

	for slot8, slot9 in ipairs(slot1) do
		if BackHomeDormLevelRewardCfg[slot9].type == 3 then
			table.insert(slot0.rewardItemList_, BackHomeDormLevelRewardCfg[slot9].reward)
		elseif BackHomeDormLevelRewardCfg[slot9].type == 1 then
			slot4 = slot4 .. string.format(GetTips("DORM_LEVEL_AWARD_ATTRIB"), PublicAttrCfg[slot10[1]].name, slot10[2]) .. "\n"
		elseif BackHomeDormLevelRewardCfg[slot9].type == 2 then
			slot4 = slot4 .. string.format(GetTips("DORM_LEVEL_AWARD_VOICE"), HeroVoiceCfg[slot10[1]].title) .. "\n"
		end
	end

	slot0.decText.text = slot4 .. string.format(GetTips("DORM_FATIGUE_BASE_INFO"), GameSetting.dorm_fatigue_increase.value[slot2][2] / 100 * 3600 / GameSetting.dorm_fatigue_time.value[1])

	if slot0.index == slot3 then
		slot0.selController:SetSelectedState("select")
	else
		slot0.selController:SetSelectedState("normal")
	end
end

function slot0.Dispose(slot0)
	if slot0.itemList then
		for slot4, slot5 in ipairs(slot0.itemList) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
