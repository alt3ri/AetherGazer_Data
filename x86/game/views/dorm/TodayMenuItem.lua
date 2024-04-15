slot0 = class("todayMenuItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.listFlag = false

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.setdownBtn_, nil, function ()
		if BackHomeCanteenFoodCfg[uv0.ID_] then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = string.format(GetTips("CANTEEN_FOOD_REMOVE"), BackHomeCanteenFoodCfg[uv0.ID_].name),
				OkCallback = function ()
					CanteenAction:SendSignFoodInfo(uv0.ID_, 0)
				end,
				CancelCallback = function ()
				end
			})
		end
	end)
	slot0:AddBtnListener(slot0.shelvesbtnBtn_, nil, function ()
		CanteenAction:SendSignFoodInfo(uv0.ID_, 0)
	end)
end

function slot0.RefreshUI(slot0, slot1)
	slot0.ID_ = slot1
	slot0.titleText_.text = GetI18NText(BackHomeCanteenFoodCfg[slot1].name)
	slot0.foodiconImg_.sprite = CanteenTools.GetFoodSprite(slot0.ID_)
	slot0.awardnumText_.text = CanteenFoodData:GetSignFoodInfo(slot1).soldIncome or 0
	slot0.timeText_.text = DormTools:SecondSwitchTime(CanteenFoodData:GetSignFoodTime(slot0.ID_))
	slot5 = ""
	slot6 = GetTips("CANTEEN_FOOD_COST")

	for slot10, slot11 in ipairs(BackHomeCanteenFoodCfg[slot1].ingredient_list) do
		slot12 = ItemTools.getItemName(slot11[1])
		slot13 = slot11[2]
		slot14 = CanteenFoodData:GetCateenIngredient()[slot11[1]]
		slot15 = NumberTools.RetractNumberForWindBar(slot13)
		slot16 = NumberTools.RetractNumberForWindBar(slot14)
		slot5 = slot14 < slot13 and slot5 .. string.format("%s<color='#FF0000'>%s</color>/%s,", slot12, slot16, slot15) or slot5 .. string.format("%s<color='#FF0000'>%s</color>/%s,", slot12, slot16, slot15) .. string.format("%s%s/%s,", slot12, slot16, slot15)
	end

	slot0.materialtextText_.text = string.sub(string.format(slot6, slot5), 1, -2)
	slot7 = CanteenFoodData:GetSignFoodInfo(slot0.ID_)
	slot0.soldNumText_.text = string.format("<color='#5C8B60'>%d</color>/%d", slot7.soldNum, slot7.sellNum)

	if slot7.sellNum == slot7.soldNum then
		slot0.canvasGroup.alpha = GameDisplayCfg.canteen_canteen_food_item_diaphaneity.value[1]

		slot0.stateController:SetSelectedState("sellout")
	else
		slot0.canvasGroup.alpha = 1

		slot0.stateController:SetSelectedState("normal")
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.changeListFun = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
