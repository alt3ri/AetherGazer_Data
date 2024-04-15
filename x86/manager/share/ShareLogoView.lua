slot0 = class("ShareLogoView")

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.logoParent_ = {
		[0] = slot0.ltLogo_,
		slot0.lbLogo_,
		slot0.rtLogo_,
		slot0.rbLogo_
	}
	slot0.cardParent_ = {
		[0] = slot0.ltCard_,
		slot0.lbCard_,
		slot0.rtCard_,
		slot0.rbCard_
	}
	slot0.logoController = ControllerUtil.GetController(slot0.gameObject_.transform, "logo")
end

function slot0.ShowLogo(slot0, slot1)
	slot2 = {}
	slot2 = (slot1 or {
		cardShowUID = true,
		cardShowLv = true,
		logoPos = 0,
		cardPos = 1,
		cardShow = true
	}) and slot1

	SetActive(slot0.goCardPanel_, slot2.cardShow)
	slot0.transformLogo_:SetParent(slot0.logoParent_[slot2.logoPos], false)
	slot0.logoController:SetSelectedIndex(GameToSDK.CURRENT_SERVER == "kr" and 1 or 0)

	if slot2.cardShow then
		slot0.transformCard_:SetParent(slot0.cardParent_[slot2.cardPos], false)

		slot0.textNick_.text = PlayerData:GetPlayerInfo().nick

		if slot2.cardShowLv then
			slot0.textLv_.text = GetTips("LEVEL") .. slot3.userLevel
		else
			slot0.textLv_.text = GetTips("LEVEL") .. "**"
		end

		if slot2.cardShowUID then
			slot0.textUID_.text = "UID：" .. USER_ID
		else
			slot0.textUID_.text = "UID：************"
		end
	end

	SetActive(slot0.gameObject_, true)
end

function slot0.HideLogo(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Dispose(slot0)
end

return slot0
