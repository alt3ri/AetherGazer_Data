function getSprite(arg_1_0, arg_1_1)
	return AtlasManager.GetSprite(arg_1_0, arg_1_1)
end

function getSpriteWithoutAtlas(arg_2_0)
	return AtlasManager.GetSpriteWithoutAtlas(arg_2_0)
end

function getSpriteWithoutAtlasAsync(arg_3_0, arg_3_1)
	AtlasManager.GetSpriteWithoutAtlasAsync(arg_3_0, arg_3_1)
end

function SetSpriteWithoutAtlasAsync(arg_4_0, arg_4_1)
	AtlasManager.GetSpriteWithoutAtlasAsync(arg_4_1, function(arg_5_0)
		if isNil(arg_4_0) then
			return
		end

		arg_4_0.sprite = arg_5_0
	end)
end

function getSpriteViaConfig(arg_6_0, arg_6_1)
	local var_6_0 = nullable(SpritePathCfg, arg_6_0, "path")

	if var_6_0 then
		return getSpriteWithoutAtlas(var_6_0 .. arg_6_1)
	end
end
