slot1 = class("MoonCakeChatJumpItemView", import("game.views.chat.chatItem.ChatJumpItemView"))

function slot1.JumpFunc(slot0)
	if not ActivityData:GetActivityIsOpen(JumpTools.GetSystemActivityID(slot0.jumpLink_)) then
		ShowTips("TIME_OVER")

		return
	end

	if manager.time:GetNextTime(GameSetting.refresh_time1.value[1][1], 0, 0) - slot0.itemData_.timestamp >= 86400 then
		ShowTips("MID_AUTUMN_FESTIVAL_PARTY_END")

		return
	end

	if slot0.itemData_.id ~= USER_ID then
		MoonCakeAction.RequirePartyOwnerData(slot1, slot0.itemData_.id, function ()
			JumpTools.JumpToPage2(uv0.jumpLink_)
		end)
	else
		JumpTools.JumpToPage2(slot0.jumpLink_)
	end
end

return slot1
