slot0 = class("FishCollectionDetailItem", BaseView)

function slot0.Ctor(slot0, slot1)
	uv0.super.Ctor(slot0)

	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	if slot0.card_ then
		slot0.cardItem = HanafudaCardView.New(slot0.card_)
	end

	slot0:AddBtnListener(slot0.detailMaskBtn_, nil, function ()
		if uv0.clickOnMaskFunc then
			uv0.clickOnMaskFunc()
		end
	end)

	slot0.controller = ControllerUtil.GetController(slot0.transform_, "rarity")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.cardItem then
		slot0.cardItem:Dispose()
	end
end

function slot0.SetData(slot0, slot1)
	slot2 = HanafudaCardCfg[slot1]
	slot0.name = RareFishCfg[slot2.desc].name
	slot0.name_.text = slot0.name

	if slot0.cardItem then
		slot0.cardItem:SetData(1, {
			id = slot1,
			race = slot2.race,
			desc = slot2.desc,
			placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
			rarity = KagutsuchiFishingEventData:GetRarity(slot1).order
		})
	end

	if slot4 == KagutsuchiFishingEventData.EnumFishRarity.B then
		slot0.descText_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_UNLOCK_TIPS", slot3.name)
	else
		slot0.descText_.text = slot3.desc
	end

	slot0.descText2_.text = slot3.talk

	if slot0.controller then
		slot6, slot7 = KagutsuchiFishingEventData:GetNextRarity(slot1)

		slot0.controller:SetSelectedState(slot4.name)

		slot0.tips_.text = slot6 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", slot7, slot3.name, slot6.name) or ""
	end
end

function slot0.SetClickOnMask(slot0, slot1)
	slot0.clickOnMaskFunc = slot1
end

return slot0
