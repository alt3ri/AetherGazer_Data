slot0 = class("ChatSubTabItem", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.chatToggleID_ = slot3
	slot0.click_ = slot4

	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tabController_ = slot0.tabControllerEx_:GetController("state")
	slot0.titleText_.text = ChatToggleCfg[slot0.chatToggleID_].name
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.tabBtn_, nil, function ()
		if uv0:IsLock() then
			ShowTips("ACTIVITY_CLUB_NOT_JOIN")

			return
		end

		if uv0.click_ then
			uv0.click_()
		end
	end)
end

function slot0.IsLock(slot0)
	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY then
		return not GuildActivityData:HaveRegister()
	end

	if slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_4 or slot0.chatToggleID_ == ChatConst.CHAT_CHANNEL_GUILD_ACTIVITY_SP_2_8 then
		return not GuildActivitySPData:HaveRegister()
	end

	return false
end

function slot0.SetTabState(slot0, slot1)
	if slot1 then
		slot0.tabController_:SetSelectedState("select")
	else
		slot0.tabController_:SetSelectedState(slot0:IsLock() and "lock" or "unlock")
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

return slot0
