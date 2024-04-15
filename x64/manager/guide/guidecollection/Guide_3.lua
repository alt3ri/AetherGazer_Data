slot0 = class("Guide_3", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 301)
	table.insert(slot1, 302)

	if HeroData:GetHeroList()[1084] and slot0:HaveAddHeroExpMaterial() then
		table.insert(slot1, 304)
		table.insert(slot1, 305)
		table.insert(slot1, 306)
		table.insert(slot1, 307)
	end

	table.insert(slot1, 308)
	table.insert(slot1, 309)

	slot0._steps = {}

	for slot7 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot7]) then
			table.insert(slot0._steps, slot9)
		end
	end
end

function slot0.HaveAddHeroExpMaterial(slot0)
	for slot4, slot5 in ipairs(GameSetting.hero_exp_props_id_list.value) do
		if ItemTools.getItemNum(slot5) > 0 then
			return true
		end
	end

	return false
end

return slot0
