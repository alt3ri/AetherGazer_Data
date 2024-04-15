slot0 = singletonClass("NewWarChessMain")

function slot0.Ctor(slot0)
	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil
	slot0.isSelectEventInteracting_ = false
	slot0.selectEventInteracChess_ = nil
	slot0.curChanceID_ = 0
	slot0.curChanceItemID_ = 0
	slot0.curDiceNumList_ = {}
	slot0.curAffixList_ = {}
	slot0.characterPos_ = nil
	slot0.eventQueueManager_ = NewChessEventQueue.New()
	slot0.buffManager_ = NewChessBuffManager.New()
	slot0.taskManager_ = NewChessTaskManager.New()
	slot0.globalManager_ = NewWarChessGlobalManager.New()
end

function slot0.SetUp(slot0, slot1)
	slot0:LoadMap(slot1)

	slot2 = NewWarChessData:GetCurrentIndex()
	slot0.characterPos_ = {
		slot2.x,
		slot2.z
	}
	slot3 = NewWarChessData:GetCurrentWarChessMapData()

	slot0.taskManager_:SetServerData(slot3.taskList)
	slot0.buffManager_:SetServerData(slot3.buffList)
	slot0.globalManager_:SetServerData(slot3.globalEventList)
end

function slot0.CreateSupportModule(slot0)
	if slot0.blockerManager_ == nil then
		slot0.blockerManager_ = NewWarChessBlockerManager.New(manager.ui.canvas)
	end

	if slot0.tipsManager_ == nil then
		slot0.tipsManager_ = NewChessTipsManager.New()
	end
end

function slot0.DisposeSupportModule(slot0)
	if slot0.blockerManager_ then
		slot0.blockerManager_:Dispose()

		slot0.blockerManager_ = nil
	end

	if slot0.tipsManager_ then
		slot0.tipsManager_:Dispose()

		slot0.tipsManager_ = nil
	end
end

function slot0.LoadMap(slot0, slot1)
	slot0.ChapterID = slot1
	slot0.map_ = NewChessTools.LoadMap(slot1)

	if not slot0.map_ then
		-- Nothing
	end

	for slot6, slot7 in pairs(slot0.map_.mapInfo) do
		-- Nothing
	end

	NewWarChessData:SetExtendMap(slot0.map_.extendInfo)
	NewWarChessData:SetExtendObjectMap(slot0.map_.extendThingInfo)
	NewWarChessData:SetJsonMap({
		[NewChessTools.TwoDToOneD(slot7.x, slot7.z)] = slot7
	})
end

function slot0.ShowPathEffect(slot0, slot1, slot2, slot3)
	slot0:ClearAllSelectEffect()
	NewChessLuaBridge.ShowGridSelectEffect()
	manager.audio:PlayEffect("ui_system", "button", "")
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.READY, slot1, slot2, slot3)
end

function slot0.ClearGridSelectEffect(slot0, slot1, slot2)
	NewChessLuaBridge.ClearGridSelectEffect(slot1, slot2)
end

function slot0.ClearAllSelectEffect(slot0)
	NewChessLuaBridge.ClearAllSelectEffect()
end

function slot0.StartMoveToCaChePath(slot0)
	slot0.blockerManager_:ShowMoveBlocker()
	NewChessLuaBridge.MoveToCachePos()
	manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, false)
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.MOVING)
end

function slot0.ClearEndPoint(slot0)
	slot0:ClearAllSelectEffect()

	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil

	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function slot0.ExecuteChessTiming(slot0, slot1, slot2)
	slot3 = slot2.gridData
	slot4 = slot2.cost
	slot5 = slot2.isTelePort
	slot6 = slot2.dir
	slot7 = slot2.screenPos

	if slot1 == NewChessConst.TIMING_START then
		NewWarChessData:SetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN", 1)

		slot8 = NewWarChessLevelCfg[NewWarChessData:GetCurrentWarChessMapID()].eventpool_id

		slot0:ExecutChess(slot1, nil, NewWarChessData:GetServerEvent(slot1, {}))
	elseif slot1 == NewChessConst.TIMING_WALK_OUT then
		if slot3.exitParamList and slot3.exitParamList.Length > 0 then
			slot0:ExecutChess(slot1, slot3, NewWarChessData:GetServerEvent(slot1, {
				slot3.x,
				slot3.z
			}))
		end
	elseif slot1 == NewChessConst.TIMING_WALK_INTO then
		if slot3.enterParamList and slot3.enterParamList.Length > 0 then
			slot0:ExecutChess(slot1, slot3, NewWarChessData:GetServerEvent(slot1, {
				slot3.x,
				slot3.z
			}))
		end

		if not slot5 then
			NewWarChessData:SubAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT", math.floor(-NewWarChessHexCfg[slot3.typeID].penalty * NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_MOVE_POINT_COST_TIMES") / 1000))
			slot0:UpdateBuff()
		end

		if slot0.eventQueueManager_:IsEmpty() then
			slot0.globalManager_:CheckSettlementGlobalEventList()
		end
	elseif slot1 == NewChessConst.TIMING_INTERACT then
		if slot0.ExecutingChess_.clickParamList and slot3.clickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[slot3.clickParamList[0]] == nil then
				error("clickParamList触发的eventPoolID不存在！", slot3.clickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(slot3.x, slot3.z, false, function ()
				if NewWarChessEventPoolCfg[uv0.clickParamList[0]].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					uv2:ExecutChess(uv1, uv0, NewWarChessData:GetServerEvent(uv1, {
						uv0.x,
						uv0.z
					}))
					uv2:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, uv0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
					uv2:ClearInteractChess()
				end
			end)
		end
	elseif slot1 == NewChessConst.TIMING_WALK_OUT_OBJECT then
		if slot3.objectExitParamList and slot3.objectExitParamList.Length > 0 then
			slot0:ExecutChess(slot1, slot3, NewWarChessData:GetServerEvent(slot1, {
				slot3.x,
				slot3.z
			}))
		end
	elseif slot1 == NewChessConst.TIMING_WALK_INTO_OBJECT then
		if slot3.objectEnterParamList and slot3.objectEnterParamList.Length > 0 then
			slot0:ExecutChess(slot1, slot3, NewWarChessData:GetServerEvent(slot1, {
				slot3.x,
				slot3.z
			}))
		end
	elseif slot1 == NewChessConst.TIMING_INTERACT_OBJECT then
		if slot0.ExecutingChess_.objectClickParamList and slot3.objectClickParamList.Length > 0 then
			if NewWarChessEventPoolCfg[slot3.objectClickParamList[0]] == nil then
				error("objectClickParamList触发的eventPoolID不存在！", slot3.objectClickParamList[0])

				return
			end

			NewWarChessAction.ClickGrid(slot3.x, slot3.z, false, function ()
				if NewWarChessEventPoolCfg[uv0.objectClickParamList[0]].type == NewChessConst.EVENTPOOL_TYPE.NEWWARCHESS_EVENT then
					uv2:ExecutChess(uv1, uv0, NewWarChessData:GetServerEvent(uv1, {
						uv0.x,
						uv0.z
					}))
					uv2:StartExecuteEvent()
				else
					manager.NewChessManager:SetChanceInteract(true, uv0)
					JumpTools.OpenPageByJump("/newWarChessChanceView", {
						chanceID = NewWarChessData:GetServerChanceID()
					})
				end
			end)
		end
	elseif slot1 == NewChessConst.TIMING_FARCLICK_OBJECT and slot3.objectFarClickParamList and slot3.objectFarClickParamList.Length > 0 then
		slot0:ExecutChess(slot1, slot3, NewWarChessData:GetServerEvent(slot1, {
			slot3.x,
			slot3.z
		}))
	end
end

function slot0.SetInteractChess(slot0, slot1)
	slot0.IsExecuting_ = true
	slot0.ExecutingChess_ = slot1
end

function slot0.ClearInteractChess(slot0)
	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil
end

function slot0.IsExecuting(slot0)
	return slot0.IsExecuting_
end

function slot0.EventsEnd(slot0)
	if slot0.eventQueueManager_:CurEventTiming() == NewChessConst.TIMING_INTERACT then
		slot0.IsExecuting_ = false
		slot0.ExecutingChess_ = nil
	end

	slot0.taskManager_:CheckTask()

	if slot0.eventQueueManager_:PromoteToNextEvent() then
		slot0:DoNextEvent()
	else
		slot0.eventQueueManager_:Clear()
		slot0.globalManager_:CheckSettlementGlobalEventList()
		slot0.globalManager_:CheckStartGlobalEventList()
	end
end

function slot0.ExecutChess(slot0, slot1, slot2, slot3)
	if slot3 ~= nil then
		slot0:CreateEventQueue(slot2, slot3, slot1)
	end
end

function slot0.StartExecuteEvent(slot0)
	if slot0.eventQueueManager_:CurEventTiming() then
		return
	end

	if slot0.eventQueueManager_:PromoteToNextEvent() then
		slot0:DoNextEvent()
	else
		slot0:EventsEnd()
	end
end

function slot0.CreateEventQueue(slot0, slot1, slot2, slot3)
	slot0.eventQueueManager_:InsertNewEventQueue(slot2, slot3, slot1)
end

function slot0.DoNextEvent(slot0)
	if slot0.eventQueueManager_:IsEventEnd() then
		slot0:EventsEnd()

		return
	end

	slot1, slot2 = slot0.eventQueueManager_:GetCurFunc()

	slot0.eventQueueManager_:PromoteCurEventProgress()

	return slot1(unpack(slot2))
end

function slot0.GetExecutingChess(slot0)
	return slot0.eventQueueManager_:GetExecutingChess()
end

function slot0.SetPosition(slot0, slot1, slot2)
	if slot0.characterPos_ and slot0.characterPos_[1] == slot1 and slot0.characterPos_[2] == slot2 then
		return false
	end

	NewWarChessData:SetCurrentIndex(slot1, slot2)

	slot0.characterPos_ = {
		slot1,
		slot2
	}

	return true
end

function slot0.GetPosition(slot0)
	return slot0.characterPos_
end

function slot0.SetChanceInteract(slot0, slot1, slot2)
	slot0.isSelectEventInteracting_ = slot1
	slot0.selectEventInteracChess_ = slot2
end

function slot0.GetChanceInteracChess(slot0)
	return slot0.selectEventInteracChess_
end

function slot0.JumpBoard(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:ShowBlock()
	NewChessLuaBridge.JumpBoard(slot1, slot2, slot3, slot4, slot5)
end

function slot0.BattleStart(slot0, slot1, slot2, slot3, slot4)
	slot0.battleStart_ = true
	slot0.battleResult_ = nil
	slot0.curChanceID_ = slot1
	slot0.curChanceItemID_ = slot2
	slot0.curDiceNumList_ = slot3
	slot0.curAffixList_ = slot4

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot0.originShadowRotationImmediately = slot5.shadowRotationImmediately
		slot5.shadowRotationImmediately = true
	end

	NewChessLuaBridge.SetCameraControlEnable(false)
	NewWarChessData:SetCharacterDirection(NewChessLuaBridge.GetPlayerDirection())
end

function slot0.GetCurBattleAffix(slot0)
	return slot0.curAffixList_
end

function slot0.BattleSuccess(slot0)
	slot0.battleResult_ = true
end

function slot0.IsBattleBack(slot0)
	return slot0.battleStart_
end

function slot0.BattleFinish(slot0)
	if slot0.battleStart_ then
		slot1 = {}

		for slot5 = 1, #slot0.curDiceNumList_ do
			table.insert(slot1, slot0.curDiceNumList_[slot5])
		end

		NewWarChessData:RemoveDice(slot1)

		if slot0.battleResult_ then
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = slot0.curChanceID_,
				chanceItemID = slot0.curChanceItemID_
			})
		else
			JumpTools.OpenPageByJump("/newWarChessChanceView", {
				chanceID = NewWarChessData:GetServerChanceID()
			})
		end
	end

	if not slot0.battleStart_ then
		return
	end

	slot0:ClearBattleData()
end

function slot0.ClearBattleData(slot0)
	slot0.battleStart_ = false
	slot0.battleResult_ = nil
	slot0.curChanceID_ = 0
	slot0.curChanceItemID_ = 0
	slot0.curDiceNumList_ = {}
	slot0.curAffixList_ = {}

	if manager.ui.mainCamera:GetComponent("CameraExtension") then
		slot1.shadowRotationImmediately = slot0.originShadowRotationImmediately
	end

	NewChessLuaBridge.SetCameraControlEnable(true)
end

function slot0.ChangeGridByExtentID(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:ShowBlock()
	NewChessLuaBridge.ChangeGridByIndex(slot1, slot2, slot3, slot4, function ()
		uv0:CloseBlock()

		if uv1 then
			NewWarChessData:ChangeGridLuaInheritDir(uv2, uv3, uv4)
		else
			NewWarChessData:ChangeGridLua(uv2, uv3, uv4)
		end

		if uv5 then
			uv5()
		end
	end)
end

function slot0.ChangeObjectByExtentID(slot0, slot1, slot2, slot3, slot4)
	slot0:ShowBlock()
	NewChessLuaBridge.ChangeObjectByIndex(slot1, slot2, slot3, function ()
		uv0:CloseBlock()
		NewWarChessData:ChangeObjectLua(uv1, uv2, uv3)

		if uv4 then
			uv4()
		end
	end)
end

function slot0.DeleteObject(slot0, slot1, slot2, slot3)
	slot0:ShowBlock()
	NewChessLuaBridge.DeleteObject(slot1, slot2, function ()
		uv0:CloseBlock()
		NewWarChessData:DeleteObjectLua(uv1, uv2)

		if uv3 then
			uv3()
		end
	end)
end

function slot0.ChangeGridDirection(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0:ShowBlock()
	NewChessLuaBridge.RotateGrid(slot1, slot2, slot3 * 60, slot4, function ()
		uv0:CloseBlock()
		NewWarChessData:ChangeGridDirection(uv1, uv2, uv3)

		if uv4 then
			uv4()
		end
	end)
end

function slot0.LookAtPlayerWithCurPos(slot0, slot1, slot2, slot3)
	slot4 = NewWarChessData:GetCurrentIndex()

	if math.abs(slot4.x - slot1) + math.abs(slot4.z - slot2) > 2 then
		NewChessLuaBridge.LookAtPlayer(function ()
			if uv0 then
				uv0()
			end
		end)
	elseif slot3 then
		slot3()
	end
end

function slot0.MoveToTarget(slot0, slot1, slot2, slot3)
	slot0:ShowBlock()
	slot0:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
	NewChessLuaBridge.MoveTargetSmooth(slot1, slot2, function ()
		manager.notify:CallUpdateFunc(NEWWARCHESS_CAMERA_MOVE, true)
		uv0:CloseBlock()

		if uv1 then
			uv1()
		end
	end, true)
end

function slot0.PlayGridAnimation(slot0, slot1, slot2, slot3, slot4, slot5)
	slot0.blockerManager_:ShowBlocker()
	NewChessLuaBridge.PlayGridAnimation(slot1, slot2, slot3, slot4, function ()
		uv0.blockerManager_:HideBlocker()
		uv1()
	end)
end

function slot0.OnMoveEnd(slot0)
	slot0.blockerManager_:HideMoveBlocker()
	slot0:ClearAllSelectEffect()
	manager.notify:CallUpdateFunc(NEWCHESSHOME_UPDATESTATE, NewChessConst.HOME_STATUS.NORMAL)
end

function slot0.ShowBlock(slot0)
	slot0.blockerManager_:ShowBlocker()
end

function slot0.CloseBlock(slot0)
	slot0.blockerManager_:HideBlocker()
end

function slot0.CreateTips(slot0, slot1)
	slot0.tipsManager_:CreateTips(slot1)
end

function slot0.AddBuff(slot0, slot1)
	slot0.buffManager_:AddBuff(slot1)
end

function slot0.UpdateBuff(slot0)
	slot0.buffManager_:UpdateBuff()
end

function slot0.RemoveBuff(slot0, slot1)
	slot0.buffManager_:RemoveBuff(slot1)
end

function slot0.Dispose(slot0)
	manager.windowBar:ClearWhereTag()

	slot0.characterPos_ = nil
	slot0.map_ = nil
	slot0.IsExecuting_ = false
	slot0.ExecutingChess_ = nil
	slot0.isSelectEventInteracting_ = false
	slot0.selectEventInteracChess_ = nil
	slot0.curChanceID_ = 0
	slot0.curChanceItemID_ = 0
	slot0.curDiceNumList_ = {}
	slot0.curAffixList_ = {}

	slot0.eventQueueManager_:Clear()
	slot0.buffManager_:Dispose()
	slot0.taskManager_:Dispose()
	slot0.globalManager_:Dispose()
	slot0:DisposeSupportModule()
end

return slot0
