slot1 = class("ChatToggleGuildActivitySPView", import(".ChatToggleBaseView"))

function slot1.Show(slot0, slot1)
	uv0.super.Show(slot0, slot1)

	if slot1 then
		slot0:RefreshGuildActivityToggle(toggle)
	end
end

function slot1.RefreshGuildActivityToggle(slot0, slot1)
	SetActive(slot0.gameObject_, ActivityData:GetActivityIsOpen(GuildActivitySPData:GetCurRunActivityID()) or slot0.toggle_.isOn == slot0.chatToggleID_ or manager.windowBar:GetWhereTag() == "guildActivitySP")
end

function slot1.OnClickToggle(slot0)
	if slot0:IsLock() then
		ShowTips("ACTIVITY_CLUB_NOT_JOIN")
		manager.notify:Invoke(CHAT_REVERT_TOGGLE)

		return
	end

	slot0:Go("chat", {
		chatToggleID = slot0.chatToggleID_
	})
end

function slot1.IsLock(slot0)
	return not GuildActivitySPData:HaveRegister()
end

return slot1
