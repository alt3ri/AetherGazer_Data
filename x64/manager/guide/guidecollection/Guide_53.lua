slot0 = class("Guide_53", BaseGuide)

function slot0.CheckGuide(slot0)
	if not GuideTool.SatisfyCondition(slot0.open_condition) then
		return false
	end

	if DormSkillData:GetCanSignFoodNum() <= (#CanteenFoodData:GetChooseFoodList() or 0) then
		return false
	end

	slot4 = {}

	for slot8, slot9 in pairs(BackHomeCanteenFoodCfg.all) do
		if DormEnum.FurnitureTypeNum.Pan == BackHomeCanteenFoodCfg[slot9].cook_type then
			if BackHomeCanteenFoodCfg[slot9].unlock > 0 then
				if CanteenTools:CheckFoodUnLock(slot9) then
					table.insert(slot4, slot9)
				end
			else
				table.insert(slot4, slot9)
			end
		end
	end

	CommonTools.UniversalSortEx(slot4, {
		map = function (slot0)
			return slot0
		end
	})

	if #slot4 > 0 then
		if CanteenFoodData:CheckIsSignFood(slot4[1]) then
			return false
		end

		for slot10, slot11 in ipairs(BackHomeCanteenFoodCfg[slot5].ingredient_list) do
			if CanteenFoodData:GetCateenIngredientNum(slot11[1]) < slot11[2] then
				return false
			end
		end
	else
		return false
	end

	return true
end

return slot0
