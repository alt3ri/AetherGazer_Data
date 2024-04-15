slot0 = class("Guide_17", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 1702)
	table.insert(slot1, 1704)

	slot0._steps = {}

	for slot6 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot6]) then
			table.insert(slot0._steps, slot8)
		end
	end
end

function slot0.CheckGuide(slot0)
	return GuideTool.SatisfyCondition(slot0.open_condition) and (ActivityData:GetActivityIsOpen(240034) and not DrawData:GetNewbieChooseDrawFlag())
end

return slot0
