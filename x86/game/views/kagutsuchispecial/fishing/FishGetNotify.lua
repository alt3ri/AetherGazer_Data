slot0 = class("FishGetNotify", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingUpPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.closeBtn_, nil, JumpTools.Back)

	slot0.cardItem = HanafudaCardView.New(slot0.card_)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.fishID
	slot5 = KagutsuchiFishingEventData:GetRarity(slot1)
	slot6, slot7 = KagutsuchiFishingEventData:GetNextRarity(slot1)
	slot0.tips_.text = slot6 and GetTipsF("ACTIVITY_KAGUTSUCHI_CARD_LEVEL_UP", slot7, RareFishCfg[HanafudaCardCfg[slot1].desc].name, slot6.name) or ""

	slot0.cardItem:SetData(1, {
		id = slot1,
		race = slot3.race,
		desc = slot3.desc,
		placeType = HanafudaData.CARD_PLACE_TYPE.COLLECTION,
		rarity = slot5.order
	})
	slot0.cardItem:RefreshUI(0)

	if slot0.params_.lastRarity ~= slot5 then
		slot0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_CARD_LEVEL_UP", slot4.name)
		slot0.prevRarityImg_.sprite = getSprite("Atlas/Common", "star_" .. slot2.order)

		slot0.upgrade_:Play("upgrade")

		if slot5 == KagutsuchiFishingEventData.EnumFishRarity.S then
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptos", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_6_1158", "minigame_activity_2_6_1158_fish_uptoa", "")
		end
	else
		slot0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", slot4.name)
		slot0.prevRarityImg_.sprite = slot0.cardItem.rarityImg_.sprite

		slot0.upgrade_:Play("wait")
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.cardItem:Dispose()
end

return slot0
