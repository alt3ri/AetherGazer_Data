slot0 = class("ChatFriendsTabItem", ReduxView)

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

	slot0.selectStateController_ = slot0.itemControllerEx_:GetController("selectState")
	slot0.onlineStateController_ = slot0.itemControllerEx_:GetController("onlineState")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn_, nil, function ()
		if uv0.click_ then
			uv0.click_()
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.friendID_ = slot1
	slot0.index_ = slot2
	slot0.click_ = slot4

	slot0:SetSelectState(slot1 == slot3)

	if slot1 == USER_ID then
		slot5 = PlayerData:GetPlayerInfo()
		slot0.nickText_.text = GetI18NText(slot5.nick)
		slot0.headImg_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot5.portrait].icon)
		slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot5.icon_frame)
	else
		if FriendsData:GetInfoByID(slot1) == false then
			print("unfind friend data", slot1)
			slot0:Show(false)

			return
		end

		slot0.nickText_.text = GetI18NText(slot5.nick)
		slot0.headImg_.sprite = getSpriteViaConfig("HeroLittleIcon", ItemCfg[slot5.icon].icon)
		slot0.frameImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Frame/" .. slot5.icon_frame)

		slot0.onlineStateController_:SetSelectedState(slot5.online_state == 0 and "on" or "off")
	end
end

function slot0.SetSelectState(slot0, slot1)
	slot0.selectStateController_:SetSelectedState(slot1 and "select" or "cancel")
	slot0:RefreshRedPoint(slot1)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.RefreshRedPoint(slot0, slot1)
	if ChatFriendData:GetUnreadMsgCnt(slot0.friendID_) <= 0 or slot1 then
		SetActive(slot0.goNotice_, false)
	else
		SetActive(slot0.goNotice_, true)

		slot0.textNoticeCnt_.text = slot2
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
