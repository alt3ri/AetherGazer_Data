return {
	Init = function (slot0)
		slot0.palyerPrefsPrefix = "playerRedPoint"
	end,
	SetStickerUnlock = function (slot0, slot1)
		for slot7, slot8 in ipairs(getData(slot0.palyerPrefsPrefix, "stickerUnlock") or {}) do
			-- Nothing
		end

		if not ({
			[slot8] = slot7
		})[slot1] then
			table.insert(slot2, slot1)
			saveData(slot0.palyerPrefsPrefix, "stickerUnlock", slot2)
			manager.redPoint:setTip(RedPointConst.STICKER_UNLOCK .. "_" .. slot1, 1)
		end
	end,
	CancelStickerUnlock = function (slot0, slot1)
		for slot7, slot8 in ipairs(getData(slot0.palyerPrefsPrefix, "stickerUnlock") or {}) do
			-- Nothing
		end

		if ({
			[slot8] = slot7
		})[slot1] then
			table.remove(slot2, slot3[slot1])
			saveData(slot0.palyerPrefsPrefix, "stickerUnlock", slot2)
			manager.redPoint:setTip(RedPointConst.STICKER_UNLOCK .. "_" .. slot1, 0)
		end
	end,
	DispatchAllStickerUnlock = function (slot0)
		for slot5, slot6 in ipairs(getData(slot0.palyerPrefsPrefix, "stickerUnlock") or {}) do
			manager.redPoint:setTip(RedPointConst.STICKER_UNLOCK .. "_" .. slot6, 1)
		end
	end
}
