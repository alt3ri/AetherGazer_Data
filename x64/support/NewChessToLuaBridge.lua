function PreloadNewChessAsset()
	slot1 = nil
	slot5 = NewWarChessData:GetCurrentActivity()

	for slot5, slot6 in pairs(BattleTeamData:GetSingleTeam(slot5)) do
		if slot6 ~= 0 then
			slot9 = manager.resourcePool:Get("Char/" .. HeroTools.HeroUsingSkinInfo(slot6).ui_modelId, ASSET_TYPE.TPOSE)

			Timer.New(function ()
				manager.resourcePool:DestroyOrReturn(uv0, ASSET_TYPE.TPOSE)
			end, 0.1, 1):Start()
		end
	end
end

function OnEnterNewChessScene()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()

	if _G.OnLoadedCallBackPre_ then
		_G.OnLoadedCallBackPre_()
	end

	if _G.OnLoadedCallBack_ then
		_G.OnLoadedCallBack_()

		_G.OnLoadedCallBack_ = nil
	end

	NewChessLuaBridge.LookAtPlayer()
	SceneManager.SetActiveScene(SceneManager.GetSceneByName(NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapData().mapId].scene_id))
	manager.windowBar:SetWhereTag("newchess")

	if manager.NewChessManager == nil then
		manager.NewChessManager = NewWarChessMain.GetInstance()

		manager.NewChessManager:SetUp(slot0.mapId)
	end

	manager.NewChessManager:CreateSupportModule()

	if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN") == 0 then
		gameContext:Go("/newWarChessEnterView")
	else
		slot2, slot3, slot4 = NewWarChessData:GetCurChanceID()

		if slot2 ~= 0 then
			manager.NewChessManager:SetChanceInteract(true, NewChessLuaBridge.GetNewGridData(slot3, slot4))
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = slot2
			})
		elseif manager.NewChessManager:IsBattleBack() then
			manager.NewChessManager:BattleFinish()
		else
			gameContext:Go("/newWarChessHome")
		end
	end
end

function NewChessWantToMove(slot0, slot1)
	NewWarChessAction.RoleMoveByPos({
		x = slot0,
		z = slot1
	}, function (slot0)
		if slot0 then
			NewChessLuaBridge.MoveRoleLogicPosition(uv0, uv1)
		else
			manager.NewChessManager:ClearEndPoint()
			NewChessLuaBridge.FixRolePositon()
		end
	end)
end

function NewChessWalkOutNode(slot0)
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_OUT, {
		gridData = slot0
	})
end

function NewChessWalkIntoNode(slot0, slot1, slot2)
	manager.NewChessManager:ClearGridSelectEffect(slot0.x, slot0.z)
	manager.NewChessManager:SetPosition(slot0.x, slot0.z)
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_INTO_OBJECT, {
		gridData = slot0
	})
	manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_WALK_INTO, {
		gridData = slot0,
		isTelePort = slot1,
		dir = slot2
	})
	manager.NewChessManager:StartExecuteEvent()
end

function NewChessWalkEnd()
	manager.NewChessManager:OnMoveEnd()

	if manager.NewChessManager:IsExecuting() then
		if manager.NewChessManager:GetPosition()[1] == manager.NewChessManager.ExecutingChess_.x and manager.NewChessManager:GetPosition()[2] == slot0.z then
			slot1 = slot0.typeID

			if slot0.objectTypeID ~= 0 and NewWarChessThingCfg[slot2].walkable == 1 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[slot1].walkable == 1 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end
		else
			slot1 = slot0.typeID

			if slot0.objectTypeID ~= 0 and NewWarChessThingCfg[slot2].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[slot1].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end
		end
	end
end

function NewChessFogOpen(slot0, slot1, slot2, slot3)
	slot4 = {}

	if slot2 ~= nil then
		for slot8 = 0, slot2.Length - 1 do
			table.insert(slot4, {
				x = slot2[slot8],
				z = slot3[slot8]
			})
		end
	end

	NewWarChessAction.OpenFogByPos({
		x = slot0,
		z = slot1
	}, slot4)
end

function NewChessGridClick(slot0, slot1, slot2, slot3, slot4)
	slot5 = false

	CheckManagers()

	if slot4 then
		manager.NewChessManager:SetInteractChess(slot0)

		slot6 = slot0.typeID

		if slot0.objectTypeID ~= 0 and NewWarChessThingCfg[slot7].walkable == 1 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
		end

		if NewWarChessHexCfg[slot6].walkable == 1 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
		end

		manager.NewChessManager:StartExecuteEvent()
	else
		if slot5 or slot1 == nil then
			manager.NewChessManager:ClearEndPoint()
			ShowTips("ACTIVITY_NEW_WARCHESS_CAN_NOT_ARRIVE")

			return
		end

		if slot1.Length > 1 then
			for slot11 = 0, slot1.Length - 1 do
				table.insert({}, {
					x = slot1[slot11].x,
					z = slot1[slot11].z
				})

				if slot11 > 0 then
					slot7 = 0 + NewWarChessHexCfg[slot1[slot11].typeID].penalty
				end
			end

			if slot0.objectClickParamList and slot0.objectClickParamList.Length > 0 or slot0.clickParamList and slot0.clickParamList.Length > 0 then
				manager.NewChessManager:SetInteractChess(slot0)
				manager.NewChessManager:ShowPathEffect(slot7, slot2.x, slot2.y)
			else
				manager.NewChessManager:ClearInteractChess()
				manager.NewChessManager:ShowPathEffect(slot7, slot2.x, slot2.y)
			end
		elseif slot1.Length == 1 then
			manager.NewChessManager:ClearEndPoint()
			manager.NewChessManager:SetInteractChess(slot0)

			slot6 = slot0.typeID

			if slot0.objectTypeID ~= 0 and NewWarChessThingCfg[slot7].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT_OBJECT, {})
			end

			if NewWarChessHexCfg[slot6].walkable == 0 then
				manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_INTERACT, {})
			end

			manager.NewChessManager:StartExecuteEvent()
		elseif slot0.objectClickParamList and slot0.objectClickParamList.Length > 0 or slot0.clickParamList and slot0.clickParamList.Length > 0 then
			manager.NewChessManager:SetInteractChess(slot0)
			manager.NewChessManager:ShowPathEffect(cost, slot2.x, slot2.y)
		else
			manager.NewChessManager:ClearInteractChess()
			manager.NewChessManager:ShowPathEffect(cost, slot2.x, slot2.y)
		end
	end
end

function NewChessGridFarClick(slot0, slot1)
	manager.NewChessManager:ClearEndPoint()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.FARCLICK, 0, slot1.x, slot1.y, function ()
		NewWarChessAction.ClickGrid(uv0.x, uv0.z, true, function ()
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_FARCLICK_OBJECT, {
				gridData = uv0
			})
			manager.NewChessManager:StartExecuteEvent()
		end)
	end)
end

function OnNewChessCameraMove()
	manager.NewChessManager:ClearEndPoint()
	manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, true)
end

function GetPlayerOpenFogLength()
	return NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FOG_LENGTH")
end

function OnExitNewChessScene()
	if manager.NewChessManager then
		manager.NewChessManager:DisposeSupportModule()
	end
end
