slot0 = class("CanteenSignFoodInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)

	SetActive(slot0.gameObject_, true)

	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot3 = CanteenFoodData:GetSignFoodInfo(slot1)

	if BackHomeCanteenFoodCfg[slot1] and slot3 then
		slot0.foodName.text = slot2.name
		slot0.soldNum.text = slot3.soldNum .. "/" .. slot3.sellNum
		slot0.soldIncom.text = slot3.soldIncome or 0
		slot0.foodIcon.sprite = CanteenTools.GetFoodSprite(slot1)
	end
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
	uv0.super.Dispose(slot0)
end

return slot0
