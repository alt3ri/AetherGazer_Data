return {
	SortChatSticker = function (slot0)
		return uv0.SortFunction(clone(ChatStickerCfg.get_id_list_by_category[slot0]))
	end,
	SortAllChatSticker = function ()
		slot0 = clone(ChatStickerCfg.all)

		table.removebyvalue(slot0, 0)

		return uv0.SortFunction(slot0)
	end,
	SortFunction = function (slot0)
		table.sort(slot0, function (slot0, slot1)
			if (ChatStickerCfg[slot0].free == 0 and ChatStickerData:IsLockSticker(slot0)) == (ChatStickerCfg[slot1].free == 0 and ChatStickerData:IsLockSticker(slot1)) then
				return slot0 < slot1
			end

			return slot5 and true or false
		end)

		return slot0
	end
}
