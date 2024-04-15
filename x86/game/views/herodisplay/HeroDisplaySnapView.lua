slot0 = class("HeroDisplaySnapView", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

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
end

function slot0.Snap(slot0, slot1, slot2)
	SetActive(slot0.gameObject_, true)

	slot3 = slot2 or HeroDisplayData:GetSetting()

	SetActive(slot0.goCardPanel_, slot3.cardShow)
	slot0.transformLogo_:SetParent(slot0.logoParent_[slot3.logoPos], false)

	if slot3.cardShow then
		slot0.transformCard_:SetParent(slot0.cardParent_[slot3.cardPos], false)

		slot0.textNick_.text = GetI18NText(PlayerData:GetPlayerInfo().nick)

		if slot3.cardShowLv then
			slot0.textLv_.text = GetTips("LEVEL") .. slot4.userLevel
		else
			slot0.textLv_.text = GetTips("LEVEL") .. "**"
		end

		if slot3.cardShowUID then
			slot0.textUID_.text = "UID：" .. USER_ID
		else
			slot0.textUID_.text = "UID：************"
		end
	end

	manager.ui:ShowScreenTap(false)
	WaitRenderFrameUtil.inst.StartScreenShot(function ()
		manager.ui:ShowScreenTap(true)
		SetActive(uv0.gameObject_, false)
		uv1()
	end)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
end

return slot0
