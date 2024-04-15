slot0 = class("HeroSurpassPlanNode", ReduxView)
slot1 = {
	lockState = {
		selectLock = "SelectLock",
		name = "lock",
		lock = "2",
		unlock = "1"
	},
	selectState = {
		name = "select",
		use = "state1",
		unUse = "state0"
	},
	upState = {
		unUp = "state0",
		name = "up",
		canUp = "state1"
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:InitPlanList()
	slot0:ShowView(false)
end

function slot0.ShowView(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
	slot0:CancelSelect()

	slot0.selectIndex = nil
end

function slot0.ShowAndNotCancelSelect(slot0)
	slot0.gameObject_:SetActive(true)
end

function slot0.GetSelectIndex(slot0)
	return slot0.selectIndex
end

function slot0.GetSelectStar(slot0)
	return slot0.selectIndex and slot0.planStarList[slot0.selectIndex] or nil
end

function slot0.InitPlanList(slot0)
	slot0.planList = {}

	for slot4 = 1, 4 do
		slot0.planList[slot4] = slot0:CreatePlanItem(slot4)
	end
end

function slot0.CreatePlanItem(slot0, slot1)
	slot2 = {}
	slot3 = slot0["planbtn" .. slot1 .. "Go_"]

	ComponentBinder.GetInstance():BindCfgUI(slot2, slot3)

	slot2.gameObject = slot3
	slot2.lockController = slot2.Controllerexcollection_:GetController(uv0.lockState.name)
	slot2.selectController = slot2.Controllerexcollection_:GetController(uv0.selectState.name)
	slot2.upController = slot2.Controllerexcollection_:GetController(uv0.upState.name)

	slot0:AddBtnListener(slot2.planBtn_, nil, function ()
		uv0:ClickPlanItem(uv1)
	end)

	return slot2
end

function slot0.CancelSelect(slot0)
	if slot0.selectIndex then
		slot0.planList[slot0.selectIndex].selectController:SetSelectedState(uv0.selectState.unUse)
	end
end

function slot0.ClickPlanItem(slot0, slot1)
	if slot0.selectIndex == slot1 then
		return
	end

	slot0:CancelSelect()
	slot0.planList[slot1].selectController:SetSelectedState(uv0.selectState.use)

	slot0.selectIndex = slot1

	if slot0.clickCallBack then
		slot0.clickCallBack(slot0.planStarList[slot1])
	end
end

function slot0.ClickPlanItemByStarID(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.planStarList) do
		if slot6 == slot1 then
			slot0:ClickPlanItem(slot5)

			break
		end
	end
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickCallBack = slot1
end

function slot0.RefreshUi(slot0, slot1, slot2)
	slot4 = SurpassTools.GetNextSurpassStarID(slot2.star)
	slot0.planStarList = {}

	for slot10, slot11 in ipairs(HeroStarCfg.get_id_list_by_star[slot1]) do
		if HeroStarCfg[slot11] and slot12.phase > 0 then
			table.insert(slot0.planStarList, slot11)

			slot6 = 0 + 1
			slot13 = uv0.upState.noUp

			if checkGold(slot12.gold_cost, false) and slot4 and slot12.star_up <= slot2.piece and slot4 == slot11 then
				slot13 = uv0.upState.canUp
			end

			slot0.planList[slot6].upController:SetSelectedState(slot13)

			slot15 = nil

			slot0.planList[slot6].lockController:SetSelectedState((not slot4 or slot4 ~= slot11 or uv0.lockState.selectLock) and (slot4 and slot11 < slot4 and uv0.lockState.unlock or uv0.lockState.lock))
		end
	end

	for slot10, slot11 in pairs(slot0.planList) do
		SetActive(slot11.gameObject, slot10 <= slot6 and true or false)
	end

	SetActive(slot0.lineGo_, slot6 ~= 0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
