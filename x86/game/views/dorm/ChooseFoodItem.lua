slot0 = class("ChooseFoodItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemController = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setupBtn_, nil, function ()
		if CanteenFoodData:CheckIsSignFood(uv0.ID_) then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CANTEEN_FOOD_REMOVE"), BackHomeCanteenFoodCfg[uv0.ID_].name),
				OkCallback = function ()
					CanteenAction:SendSignFoodInfo(uv0.ID_, 0)
				end,
				CancelCallback = function ()
				end
			})

			return
		end

		if uv0.changeListFun then
			if uv0.flag then
				uv0.changeListFun(uv0.ID_, uv0.transform_)
			else
				ShowTips(GetTips("DORM_CANTEEN_INGREDIENTS_NOT_ENOUGH"))
			end
		end
	end)
end

function slot0.RefreshUI(slot0, slot1)
	if CanteenFoodData:CheckIsSignFood(slot1) then
		slot0.itemController:SetSelectedState("sign")
	else
		slot0.itemController:SetSelectedState("normal")
	end

	slot2 = BackHomeCanteenFoodCfg[slot1]
	slot0.ID_ = slot2.id
	slot0.titleText_.text = GetI18NText(slot2.name)
	slot0.priceText_.text = CanteenFoodData:GetFoodUnitCost(slot2.id)
	slot0.iconImg_.sprite = CanteenTools.GetFoodSprite(slot0.ID_)
	slot3 = BackHomeCanteenFoodCfg[slot1].ingredient_list
	slot4 = ""
	slot0.flag = true

	if CanteenFoodData:CalculateFoodCanCookNum(slot1) <= 0 then
		slot0.flag = false
	end

	slot5 = nil
	slot5 = (not slot0.flag or string.format("<color='#FFFFFF'>%s</color>", GetTips("CANTEEN_FOOD_COST"))) and string.format("<color='#CBD2D9'>%s</color>", GetTips("CANTEEN_FOOD_COST"))

	for slot9, slot10 in ipairs(slot3) do
		slot11 = ItemTools.getItemName(slot10[1])
		slot12 = slot10[2]
		slot13 = CanteenFoodData:GetCateenIngredientNum(slot10[1])
		slot14 = NumberTools.RetractNumberForWindBar(slot12)
		slot15 = NumberTools.RetractNumberForWindBar(slot13)
		slot4 = slot13 < slot12 and slot4 .. string.format("%s<color='#FF0000'>%s</color>/%s,", slot11, slot15, slot14) or slot0.flag and slot4 .. string.format("%s<color='#FF0000'>%s</color>/%s,", slot11, slot15, slot14) .. string.format("%s%s/%s,", slot11, slot15, slot14) or slot4 .. string.format("%s<color='#FF0000'>%s</color>/%s,", slot11, slot15, slot14) .. string.format("%s%s/%s,", slot11, slot15, slot14) .. string.format("<color='#CBD2D9'>%s%s</color>/%s,", slot11, slot15, slot14)
	end

	slot0.materialtextText_.text = string.format(slot5, string.sub(slot4, 1, -2))
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.RegisterLackCallBack(slot0, slot1)
	slot0.lackBtnFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
