slot1 = {}
slot2 = nil
slot3 = ""
slot4 = {
	5,
	6,
	2,
	nil,
	5,
	1,
	3,
	4
}

return {
	SatisfyCondition = function (slot0)
		if type(slot0) ~= "table" then
			return true
		end

		for slot4, slot5 in pairs(slot0) do
			if slot5[1] == "stage" then
				if not BattleStageData:GetStageData()[slot5[2]] or slot7[slot6].clear_times < 1 then
					return false
				end
			elseif slot5[1] == "task" then
				if TaskData2:GetTask(slot5[2]) then
					if TaskData2:GetTask(slot5[2]).complete_flag ~= slot5[3] then
						return false
					end
				end
			elseif slot5[1] == "playerLevel" then
				if PlayerData:GetPlayerInfo().userLevel < slot5[2] then
					return false
				end
			elseif slot5[1] == "playerLevelLessThan" then
				if slot5[2] <= PlayerData:GetPlayerInfo().userLevel then
					return false
				end
			elseif slot5[1] == "whereTag" then
				if manager.windowBar:GetWhereTag() ~= slot5[2] then
					return false
				end
			elseif slot5[1] == "uiName" then
				if not gameContext:GetOpenPageHandler(slot5[2]) then
					return false
				end
			elseif slot5[1] == "uiNameList" then
				slot7 = false

				for slot11, slot12 in ipairs(slot5[2]) do
					if gameContext:GetOpenPageHandler(slot12) then
						slot7 = true
					end
				end

				if not slot7 then
					return false
				end
			elseif slot5[1] == "activityId" then
				if not ActivityData:GetActivityIsOpen(slot5[2]) then
					return false
				end
			elseif slot5[1] == "guide" then
				if not GuideData:IsFinish(slot5[2]) then
					return false
				end
			elseif slot5[1] == "storyId" then
				if not manager.story:IsStoryPlayed(slot5[2]) then
					return false
				end
			elseif slot5[1] == "drawNewHero" then
				if DrawData:GetNewHeroFlag() == false then
					return false
				end
			elseif slot5[1] == "anyEquipLevel" then
				slot7 = false

				for slot11, slot12 in pairs(EquipData:GetEquipList()) do
					if slot5[2] <= slot12:GetLevel() then
						slot7 = true

						break
					end
				end

				if slot7 == false then
					return false
				end
			elseif slot5[1] == "equip" then
				if not EquipData:GetEquipData(gameContext:GetOpenPageHandler("equipCultureView"):GetEquipId()) then
					return false
				end

				if slot5[2] == "equipLevel" then
					if slot7:GetLevel() < slot5[3] then
						return false
					end
				elseif slot5[2] == "cultureEquipStar" then
					if slot7.star < slot5[3] then
						return false
					end
				elseif slot5[2] == "cultureEquipReset" then
					if slot7.star < 5 or slot7.race ~= 0 and table.keyof(RaceEffectCfg.all, slot7.race) == nil then
						return false
					end
				elseif slot5[2] == "page" and slot6:GetCulturePage() ~= slot5[3] then
					return false
				end
			elseif slot5[1] == "heroFavorability" then
				if slot5[2][1] == 0 then
					slot9 = false

					for slot13, slot14 in pairs(HeroData:GetHeroList()) do
						if HeroTools.GetHeroIsUnlock(slot13) and slot5[2][2] <= ArchiveData:GetArchive(HeroRecordCfg.get_id_list_by_hero_id[slot13][1]).lv then
							slot9 = true

							break
						end
					end

					if not slot9 then
						return false
					end
				elseif slot6 and ArchiveData:GetArchive(slot6) then
					if ArchiveData:GetArchive(slot6).lv and slot7 < slot5[2][2] then
						return false
					end
				else
					print("档案id获取错误")
				end
			elseif slot5[1] == "canJump" then
				if whereami ~= "home" or LuaExchangeHelper.GetSceneIsHanding() or WarChessData:GetIsGoingChess() then
					return false
				end
			else
				print("未实现的条件类型:", slot5[1])
			end
		end

		return true
	end,
	FindComponent = function (slot0)
		if ComponentStep.New(nil, 101):AnalyzeComponentCfg(GuideTool.stringToTable(slot0)) then
			slot4 = slot3.gameObject

			LeanTween.scale(slot4, Vector3.New(1.2, 1.2, 1.2), 0.2)
			LeanTween.scale(slot4, Vector3.one, 0.2):setDelay(0.2)
			print("<color=#00ff00>找到了</color>")
		else
			print("<color=#ff0000>找不到</color>")
		end
	end,
	stringToTable = function (slot0)
		return loadstring("return " .. slot0)()
	end,
	Log = function (slot0)
		print("<color=#00ff00>" .. slot0 .. "</color>")
	end,
	GetGameContentUrl = function ()
		return gameContext:GetUrl()
	end,
	GetGameContextParams = function ()
		if not gameContext:GetOpenPageHandler(gameContext:GetLastOpenPage()) then
			return {}
		end

		uv0 = {}
		uv1 = slot1
		uv2 = slot0

		uv3.GetGuideComponent(slot1, "", 0)

		uv1 = nil

		return uv0
	end,
	GetListComponets = function (slot0, slot1, slot2)
		print("hjd" .. "GetListComponets")

		if not gameContext:GetOpenPageHandler(slot0) then
			return {}
		end

		if not slot3[slot1] then
			return {}
		end

		if not slot4:GetItemList() or not slot5[slot2] then
			return {}
		end

		slot6 = slot5[slot2]
		uv0 = {}
		uv1 = slot6
		uv2 = "LuaList_Item"

		uv3.GetGuideComponent(slot6, "", 0)

		return uv0
	end,
	GetGuideComponent = function (slot0, slot1, slot2)
		if slot2 > 2 then
			return
		end

		for slot6, slot7 in pairs(slot0) do
			if type(slot7) == "userdata" and not isNil(slot7) then
				table.insert(uv0, {
					uv1,
					slot1 .. slot6,
					slot7
				})
			elseif type(slot7) == "table" then
				if slot7.__cname == "LuaList" and slot7.uiList_ ~= nil then
					table.insert(uv0, {
						uv1,
						slot8,
						slot7.uiList_
					})
				elseif slot7 ~= uv2 then
					uv3.GetGuideComponent(slot7, slot8 .. "/", slot2 + 1)
				end
			end
		end
	end,
	CheckWeakGuide = function (slot0)
		if GuideWeakCfg.get_id_list_by_name[slot0] == nil then
			return false
		end

		for slot6, slot7 in pairs(slot1) do
			if not GuideData:IsWeakGuideFinish(slot7) and not (GuideWeakCfg[slot7].skipcondition[1] ~= nil and GuideTool.SatisfyCondition(slot8.skipcondition)) and ({
				priority = -9999
			}).priority < slot8.priority and GuideTool.SatisfyCondition(slot8.opencondition) then
				slot2 = slot8
			end
		end

		if slot2.priority == -9999 then
			return false
		end

		return true, slot2
	end,
	GetGuideComponentByRoute = function (slot0, slot1)
		slot3 = 1
		slot4 = nil

		while slot3 <= #slot1 do
			slot5 = slot1[slot3]
			slot6 = nil

			if (slot3 ~= 1 or slot0[slot5]) and slot4[slot5] then
				slot4 = slot6
				slot3 = slot3 + 1
			else
				return nil
			end
		end

		return slot4
	end,
	GetPoolIndex = function (slot0)
		slot2 = {}

		for slot6, slot7 in ipairs(uv0.GetPools()) do
			if slot2[uv1[DrawPoolCfg[slot7].pool_show_type]] == nil then
				slot2[slot9] = 1
			end

			slot2[slot9] = slot2[slot9] + 1
		end

		slot4 = 1

		for slot8 = 1, 8 do
			if slot2[slot8] then
				slot4 = slot4 + 1
			end
		end

		return ({
			[slot8] = slot4
		})[uv1[DrawPoolCfg[slot0].pool_show_type]]
	end,
	GetPools = function ()
		slot0 = {}

		for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.DRAW] or {}) do
			if ActivityData:GetActivityIsOpen(slot6) and ActivityDrawPoolCfg[slot6] then
				for slot11, slot12 in ipairs(slot7.config_list) do
					if DrawPoolCfg[slot12].pool_show_type == 8 then
						if not DrawData:GetNewbieChooseDrawFlag() then
							table.insert(slot0, slot12)
						end
					else
						table.insert(slot0, slot12)
					end
				end
			end
		end

		table.sort(slot0, function (slot0, slot1)
			return DrawPoolCfg[slot0].order < DrawPoolCfg[slot1].order
		end)

		return slot0
	end
}
