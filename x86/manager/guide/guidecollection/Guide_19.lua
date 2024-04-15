slot0 = class("Guide_19", BaseGuide)

function slot0.InitSteps(slot0)
	slot1 = {}

	slot0:OnGuideStart()
	table.insert(slot1, 1901)
	table.insert(slot1, 1902)
	table.insert(slot1, 1903)
	table.insert(slot1, 1904)
	table.insert(slot1, 1905)

	if not table.keyof(ChipData:GetUnlockChipManagerIDList(), 6) then
		table.insert(slot1, 1906)
	end

	table.insert(slot1, 1907)
	table.insert(slot1, 1908)
	table.insert(slot1, 1909)

	if not table.keyof(ChipData:GetUnlockChipIDList(), 105) then
		table.insert(slot1, 1910)
	end

	table.insert(slot1, 1911)
	table.insert(slot1, 1912)
	table.insert(slot1, 1913)
	table.insert(slot1, 1914)
	table.insert(slot1, 1915)
	table.insert(slot1, 1916)

	if not ChipData:GetChipManagerList() or not slot2[6] or not table.indexof(slot2[6], 105) then
		table.insert(slot1, 1917)
		table.insert(slot1, 1918)
		table.insert(slot1, 1919)
		table.insert(slot1, 1920)
		table.insert(slot1, 1921)
		table.insert(slot1, 1922)
	end

	table.insert(slot1, 1923)

	slot0._steps = {}

	for slot7 = 1, #slot1 do
		if slot0:ProduceStep(slot1[slot7]) then
			table.insert(slot0._steps, slot9)
		end
	end
end

return slot0
