slot0 = require("cjson")
slot1 = {
	[0] = {
		1,
		1
	},
	{
		0,
		1
	},
	{
		-1,
		0
	},
	{
		-1,
		-1
	},
	{
		0,
		-1
	},
	{
		1,
		0
	}
}
slot2 = false

return {
	EnterChessMap = function (slot0, slot1)
		slot2, slot3 = gameContext:GetLastHistoryAndParams()

		NewWarChessData:SetTemporaryData("url", slot2)
		NewWarChessData:SetTemporaryData("urlParams", slot3)
		NewWarChessData:SetTemporaryData("playEnterAni", true)
		NewWarChessAction.EnterNewWarChess(slot0)
	end,
	LoadMap = function (slot0)
		slot1 = nil

		return uv0.decode(AssetEx.LoadText("Map/NewChess/JsonMap/" .. slot0 .. ".json"))
	end,
	GetInteractStyle = function (slot0)
		return 0
	end,
	ParseParameter = function (slot0)
		if slot0.Length <= 0 then
			return {}
		end

		for slot5 = 0, slot0.Length - 1 do
			slot6 = nil

			if NewWarChessEventPoolCfg[slot0[slot5]] then
				if not slot6 then
					-- Nothing
				else
					slot7 = nil

					if NewWarChessEventPoolCfg[slot6].params then
						if slot7 ~= "" then
							slot1[slot5] = uv0.ParseEventPollCfg(slot7)
						end
					end
				end
			end
		end

		return {
			[slot5] = {}
		}
	end,
	ParseParameterLua = function (slot0)
		if NewWarChessEventPoolCfg[slot0] then
			if not slot0 then
				-- Nothing
			else
				slot1 = nil

				if NewWarChessEventPoolCfg[slot0].params then
					if slot1 ~= "" then
						return uv0.ParseEventPollCfg(slot1)
					end
				end
			end
		end
	end,
	ParseEventPollCfg = function (slot0)
		slot1 = {
			[slot5] = {}
		}

		for slot5, slot6 in ipairs(slot0) do
			slot1[slot5].params = {}

			table.insert(slot1[slot5].params, {})

			for slot10 = 1, #slot6 do
				if slot10 == 1 then
					slot1[slot5].eventID = slot6[slot10]
				else
					slot1[slot5].params[#slot1[slot5].params + 1] = slot6[slot10]
				end
			end
		end

		return slot1
	end,
	CreateChessData = function (slot0, slot1, slot2, slot3)
		return {
			objecttag = 0,
			tag = 0,
			pos = {
				x = slot0,
				z = slot1
			},
			direction = (slot2[slot3].rotationY or 0) / 60,
			status = slot2[slot3].status,
			objectdirection = (slot2[slot3].ObjectRotationY or 0) / 60,
			attribute = {}
		}
	end,
	TwoDToOneD = function (slot0, slot1)
		return slot1 * 1000 + slot0
	end,
	GetMovePointText = function (slot0)
		if slot0 then
			return string.format("%d<color=#949494>/%d</color>", slot0, NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max)
		else
			return string.format("%d<color=#949494>/%d</color>", 0, NewWarChessAttributeCfg.GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT.max)
		end
	end,
	GetDiceEventDes = function (slot0, slot1, slot2)
		if NewWarChessDiceEventTypeCfg[slot0.diceevent_type] then
			if slot2 then
				slot4 = NewWarChessDiceEventTypeCfg[slot0.diceevent_type].param

				return string.format(slot0.des, unpack(NewChessEventConfig.DiceTypeFunc[slot4[1]](slot4, slot1)), "%")
			else
				return string.format(slot3, NewWarChessDiceEventTypeCfg[slot0.diceevent_type].description, "")
			end
		end

		return slot0.des
	end,
	GetChanceDes = function (slot0)
		slot1 = slot0.description

		if type(slot0.des_params) == "table" and slot0.des_params[1] then
			slot2 = {}

			for slot6, slot7 in pairs(slot0.des_params) do
				table.insert(slot2, NewWarChessData:GetAttribute(slot7))
			end

			return string.format(slot1, unpack(slot2))
		end

		return slot1
	end,
	GetBuffDes = function (slot0)
		slot1 = NewWarChessBuffPoolCfg[slot0.buffPoolID]
		slot2 = slot1.description

		if type(slot1.des_params) == "table" and slot1.des_params[1] then
			slot3 = {}

			for slot7, slot8 in pairs(slot1.des_params) do
				if slot8 == 1 then
					table.insert(slot3, slot0.CurUpdateRound)
				elseif slot8 == 2 then
					table.insert(slot3, slot0.CurRemainRound)
				end
			end

			return string.format(slot2, unpack(slot3))
		end

		return slot2
	end,
	ExitNewChessScene = function (slot0)
		manager.windowBar:ClearWhereTag()
		NewWarChessData:SaveDataToSystem()
		NewWarChessAction.UpdateNewWarChessRedPoint()
		manager.audio:StopEffect()
		NewChessLuaBridge.ExitNewWarChess()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if slot0 then
			OpenPageUntilLoaded("/home", {})
		else
			OpenPageUntilLoaded(NewWarChessData:GetTemporaryData("url"), NewWarChessData:GetTemporaryData("urlParams"))
		end

		if manager.NewChessManager then
			manager.NewChessManager:Dispose()

			manager.NewChessManager = nil
		end
	end,
	GetNewWarChessGameSetting = function (slot0, slot1)
		if slot1 == nil or NewWarChessGameSettingCfg[slot1] == nil then
			slot1 = NewChessConst.NEW_WARCHESS_TEMPLATE_DEFULT
		end

		return NewWarChessGameSettingCfg[slot1][slot0]
	end,
	InitNewChessConfig = function ()
		if uv0 == false then
			slot0 = {}

			for slot4, slot5 in pairs(NewWarChessHexCfg) do
				if slot5.id then
					slot6 = NewGridConfig.New()
					slot6.id = slot5.id
					slot6.walkable = slot5.walkable

					if slot5.penalty < 0 then
						slot6.penalty = 0
					else
						slot6.penalty = slot5.penalty
					end

					slot6.height = slot5.height
					slot6.fogAddRange = slot5.foglength
					slot6.mapLayer = slot5.maplayer
					slot6.isHide = slot5.ishide

					table.insert(slot0, slot6)
				end
			end

			NewWarChessHexCfg.AllGridConfig = slot0
			slot1 = {}

			for slot5, slot6 in pairs(NewWarChessThingCfg.all) do
				slot7 = NewWarChessThingCfg[slot6]
				slot8 = NewWarChessThingConfig.New()
				slot8.thingID = slot7.id
				slot8.walkable = slot7.walkable

				table.insert(slot1, slot8)
			end

			NewWarChessThingCfg.AllThingConfig = slot1
			slot2 = NewChessConfigData.New()
			slot2.GridConfig = NewWarChessHexCfg.AllGridConfig
			slot2.ThingConfig = NewWarChessThingCfg.AllThingConfig

			if type(uv1.GetNewWarChessGameSetting("new_warchess_conveyor_list", NewWarChessData:GetCurrentActivity())) == "table" and #slot4 > 0 then
				slot2.ConveyorIDList = slot4
			else
				slot2.ConveyorIDList = {
					0
				}
			end

			if type(uv1.GetNewWarChessGameSetting("new_warchess_reverse_conveyor_list", slot3)) == "table" and #slot5 > 0 then
				slot2.ReverseConveyorIDList = slot5
			else
				slot2.ReverseConveyorIDList = {
					0
				}
			end

			NewChessLuaBridge.InitNewChessConfigData(slot2)

			uv0 = true
		end
	end
}
