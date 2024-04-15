function getSprite(slot0, slot1)
	return AtlasManager.GetSprite(slot0, slot1)
end

function getSpriteWithoutAtlas(slot0)
	return AtlasManager.GetSpriteWithoutAtlas(slot0)
end

function getSpriteWithoutAtlasAsync(slot0, slot1)
	AtlasManager.GetSpriteWithoutAtlasAsync(slot0, slot1)
end

function SetSpriteWithoutAtlasAsync(slot0, slot1)
	AtlasManager.GetSpriteWithoutAtlasAsync(slot1, function (slot0)
		if isNil(uv0) then
			return
		end

		uv0.sprite = slot0
	end)
end

function getSpriteViaConfig(slot0, slot1)
	if nullable(SpritePathCfg, slot0, "path") then
		return getSpriteWithoutAtlas(slot2 .. slot1)
	end
end
