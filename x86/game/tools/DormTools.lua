slot1 = {}

function dump_value_(slot0)
	if type(slot0) == "string" then
		slot0 = "\"" .. slot0 .. "\""
	end

	return tostring(slot0)
end

function split(slot0, slot1)
	slot0 = tostring(slot0)

	if tostring(slot1) == "" then
		return false
	end

	slot3 = {}

	for slot7, slot8 in function ()
		return string.find(uv0, uv1, uv2, true)
	end, nil,  do
		table.insert(slot3, string.sub(slot0, 0, slot7 - 1))

		slot2 = slot8 + 1
	end

	table.insert(slot3, string.sub(slot0, slot2))

	return slot3
end

function trim(slot0)
	return string.gsub(slot0, "^%s*(.-)%s*$", "%1")
end

function slot2(slot0)
	for slot4, slot5 in ipairs(slot0) do
		print(slot5)
	end
end

function dump(slot0, slot1, slot2, slot3)
	if type(slot2) ~= "number" then
		slot2 = 7
	end

	slot4 = {}
	slot6 = split(debug.traceback("", 2), "\n")

	function (slot0, slot1, slot2, slot3, slot4)
		slot5 = ""

		if type(slot4) == "number" then
			slot5 = string.rep(" ", slot4 - string.len(dump_value_(slot1 or "<var>")))
		end

		if type(slot0) ~= "table" then
			uv0[#uv0 + 1] = string.format("%s%s%s = %s", slot2, dump_value_(slot1), slot5, dump_value_(slot0))
		elseif uv1[tostring(slot0)] then
			uv0[#uv0 + 1] = string.format("%s%s%s = *REF*", slot2, dump_value_(slot1), slot5)
		else
			uv1[tostring(slot0)] = true

			if uv2 < slot3 then
				uv0[#uv0 + 1] = string.format("%s%s = *MAX NESTING*", slot2, dump_value_(slot1))
			else
				uv0[#uv0 + 1] = string.format("%s%s = {", slot2, dump_value_(slot1))
				slot6 = slot2 .. "    "
				slot7 = {}
				slot9 = {}

				for slot13, slot14 in pairs(slot0) do
					slot7[#slot7 + 1] = slot13

					if 0 < string.len(dump_value_(slot13)) then
						slot8 = slot16
					end

					slot9[slot13] = slot14
				end

				table.sort(slot7, function (slot0, slot1)
					if type(slot0) == "number" and type(slot1) == "number" then
						return slot0 < slot1
					else
						return tostring(slot0) < tostring(slot1)
					end
				end)

				for slot13, slot14 in ipairs(slot7) do
					uv3(slot9[slot14], slot14, slot6, slot3 + 1, slot8)
				end

				uv0[#uv0 + 1] = string.format("%s}", slot2)
			end
		end
	end(slot0, slot1, "- ", 1)

	return slot3 or uv0({})
end

return {
	GetDormAdditionByHeroID = function (slot0, slot1, slot2, slot3)
		if not slot2 and not table.indexof(DormHeroTools:GetCanUseHeroInDorm(), DormData:GetHeroArchiveID(slot1)) then
			return {
				attribute = {},
				voice = {}
			}
		end

		slot8 = 0

		if not slot3 then
			slot8 = slot2 or DormHeroTools:GetDormLevelByHeroID(DormHeroTools:GetTemplateIDInDorm(slot5))
		end

		for slot12 = 1, slot8 do
			for slot17, slot18 in ipairs(BackHomeHeroCfg[slot7].level_reward[slot12]) do
				if BackHomeDormLevelRewardCfg[slot18].type == 1 then
					if not slot4.attribute[slot19.reward[1]] then
						slot4.attribute[slot19.reward[1]] = 0
					end

					slot4.attribute[slot19.reward[1]] = slot4.attribute[slot19.reward[1]] + slot19.reward[2]
				elseif slot19.type == 2 then
					table.insert(slot4.voice, slot19.reward[1])
				end
			end
		end

		return slot4
	end,
	SecondSwitchTime = function (slot0, slot1)
		slot2 = math.ceil(slot1 / 60)

		return string.format("%d%s%02d%s", math.modf(slot2 / 60), GetTips("HOUR"), slot2 % 60, GetTips("MINUTE"))
	end,
	MinSwitchTime = function (slot0, slot1)
		if slot1 then
			slot2, slot3 = math.modf(slot1 / 60)

			return string.format("%02d:%02d:%02d", slot2, slot3, 0)
		end
	end,
	GetRoomTypeName = function (slot0, slot1)
		if slot1 == DormConst.BACKHOME_TYPE.PublicDorm then
			return GetTips("DORM_FUR_INFO_TAG5")
		elseif slot1 == DormConst.BACKHOME_TYPE.PrivateDorm then
			return GetTips("DORM_FUR_INFO_TAG6")
		end
	end,
	GetAllDormShopIDList = function (slot0)
		return ShopTools.CollectShopInGroup(GameSetting.dorm_shop_display_group_furniture.value)
	end,
	GetShopStyleImage = function (slot0)
		return getSpriteViaConfig("DormShopPreview", slot0)
	end,
	GetFurLable = function (slot0, slot1)
		slot2 = {}
		slot3 = BackHomeFurniture[slot1]

		table.insert(slot2, "is_give")
		table.insert(slot2, "dorm_exp")
		table.insert(slot2, "hero_id")
		table.insert(slot2, "scene_id")

		return slot2
	end,
	GetFurLableDesc = function (slot0, slot1, slot2)
		slot3 = ""

		if slot2 == "is_give" then
			if BackHomeFurniture[slot1].is_give == 1 then
				slot3 = string.format(GetTips("DORM_FUR_INFO_TAG2"), BackHomeFurniture[slot1].give_max)
			else
				slot3 = GetTips("DORM_FUR_INFO_TAG1")
			end
		elseif slot2 == "dorm_exp" then
			slot3 = string.format(GetTips("DORM_FUR_INFO_TAG7"), BackHomeFurniture[slot1].dorm_exp)
		elseif slot2 == "hero_id" then
			if HeroRecordCfg[BackHomeFurniture[slot1].hero_id] then
				slot3 = string.format(GetTips("DORM_FUR_INFO_TAG3"), HeroRecordCfg[slot4].name)
			end
		elseif slot2 == "scene_id" then
			for slot8, slot9 in ipairs(BackHomeFurniture[slot1].scene_id) do
				slot3 = GetTips("DORM_FUR_INFO_TAG4") .. slot0:GetRoomTypeName(slot9) .. " "
			end

			string.sub(slot3, 1, -2)
		end

		return slot3
	end,
	GetFurGiftTypeDesc = function (slot0, slot1)
		slot2 = ""

		if BackHomeFurniture[slot1].is_give == 1 then
			slot3 = BackHomeFurniture[slot1].give_max
			slot2 = GetTips("DORM_FUR_INFO_CAN_GIFT")
		elseif BackHomeFurniture[slot1].is_give == 0 then
			slot2 = GetTips("DORM_FUR_INFO_TAG1")
		elseif BackHomeFurniture[slot1].is_give == 3 and HeroRecordCfg[BackHomeFurniture[slot1].hero_id] then
			slot2 = string.format(GetTips("DORM_FUR_INFO_TAG3"), HeroRecordCfg[slot3].name)
		end

		return slot2
	end,
	GetFurPlaceSceneDesc = function (slot0, slot1)
		slot2 = ""

		for slot7, slot8 in ipairs(BackHomeFurniture[slot1].scene_id) do
			slot2 = GetTips("DORM_FUR_INFO_TAG4") .. slot0:GetRoomTypeName(slot8) .. " "
		end

		string.sub(slot2, 1, -2)

		return slot2
	end,
	GetFurGiftMaxDesc = function (slot0, slot1)
		if BackHomeFurniture[slot1].give_max > 0 then
			return tostring(BackHomeFurniture[slot1].give_max)
		else
			return GetTips("DORM_FUR_GIFT_NUM_NONE")
		end
	end,
	GetFurComfortDesc = function (slot0, slot1)
		if BackHomeFurniture[slot1].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.NO_GIFT then
			return GetTips("DORM_FUR_COMFORT_NONE")
		else
			return tostring(BackHomeFurniture[slot1].dorm_exp)
		end
	end,
	PlayDormAudioEffect = function (slot0, slot1)
		manager.audio:PlayEffect("ui_dorm", slot1, "")
	end,
	ShouldShowBirthdayBtn = function (slot0, slot1)
		return false
	end,
	SystemStayTime = function (slot0, slot1, slot2)
		if not uv0 then
			uv0 = {}
		end

		if slot2 == true then
			if uv0[slot1] then
				SDKTools.SendMessageToSDK("backhome_dorm_opt", {
					backhome_type = slot1,
					opt_time = manager.time:GetServerTime() - uv0[slot1]
				})

				uv0[slot1] = nil
			else
				CustomLog.log("未记录系统开始时间")
			end
		else
			uv0[slot1] = manager.time:GetServerTime()

			SDKTools.SendMessageToSDK("backhome_dorm_opt", {
				opt_time = -1,
				backhome_type = slot1
			})
		end
	end
}
