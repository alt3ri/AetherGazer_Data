slot0 = class("FishGetNewNotify", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingSuccessPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.detail = FishCollectionDetailItem.New(slot0.detailPanel_)

	slot0.detail:SetClickOnMask(handler(slot0, slot0.CloseNotify))
end

function slot0.OnEnter(slot0)
	slot0.closeCallback = slot0.params_.callback

	slot0.detail:SetData(slot0.params_.fishID)

	slot0.staminaRecover_.text = string.format("+%d", slot0.params_.staminaRecover or 0)
	slot0.title_.text = GetTipsF("ACTIVITY_KAGUTSUCHI_FISH_GET", slot0.detail.name)
	slot0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Fishing/FishPortrait/" .. HanafudaCardCfg[slot1].picture_name)
	slot0.staminaIcon_.sprite = ItemTools.getItemLittleSprite(CurrencyIdMapCfg.CURRENCY_TYPE_ACTIVITY_KAGUTSUCHI_FATIGUE.item_id)
end

function slot0.CloseNotify(slot0)
	JumpTools.Back()

	if slot0.closeCallback then
		slot0.closeCallback()
	end
end

return slot0
