slot0 = class("DormLinkGameBubbleItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(slot1, slot3)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.customerID = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.materialScroll = LuaList.New(handler(slot0, slot0.indexMaterialList), slot0.uilistGo_, DormLinkGameMaterialItem)

	slot0:InitSatiety()
	slot0:RefreshSatiety()

	slot0.animator = slot0.bubbleGo_:GetComponent("Animation")
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.InitSatiety(slot0)
	slot1 = ActivityLinkGameCustomerCfg[slot0.customerID].satiety_limit[2]
	slot0.slider.minValue = ActivityLinkGameCustomerCfg[slot0.customerID].satiety_limit[1]
	slot0.slider.maxValue = slot1
	slot0.image2Img_.fillAmount = (slot1 - ActivityLinkGameCustomerCfg[slot0.customerID].satiety_score_up[3][2][1]) / slot1
	slot0.image1Img_.fillAmount = (slot1 - ActivityLinkGameCustomerCfg[slot0.customerID].satiety_score_up[2][2][1]) / slot1

	slot0:RefreshSatiety()
end

function slot0.RefreshBubbleInfo(slot0, slot1)
	slot0.foodID = DormLinkGameData:GetCustomerInfo(slot0.customerID).curPreference
	slot0.materilaList = ActivityLinkGameComposeCfg[slot0.foodID].compose_list

	slot0.materialScroll:StartScroll(#slot0.materilaList)

	if slot1 then
		slot0.animator:Play()
	end
end

function slot0.RefreshSatiety(slot0)
	slot0.slider.value = DormLinkGameData:GetCustomerInfo(slot0.customerID).satietyNum
end

function slot0.RefreshTransPosition(slot0)
	DormLinkGameData:GetCustomerInfo(slot0.customerID):RefreshCustomerBubble(slot0.transform_)
end

function slot0.indexMaterialList(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.materilaList[slot1])
end

function slot0.SetActive(slot0, slot1)
	slot0.gameObject_:SetActive(slot1)
end

function slot0.Dispose(slot0)
	if slot0.materialScroll then
		slot0.materialScroll:Dispose()

		slot0.materialScroll = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
