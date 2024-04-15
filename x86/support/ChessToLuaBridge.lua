function OnEnterChessScene()
	LuaForUtil.UpdateCameraSetting()
	manager.uiInit()

	if _G.OnLoadedCallBackPre_ then
		_G.OnLoadedCallBackPre_()
	end

	if _G.OnLoadedCallBack_ then
		_G.OnLoadedCallBack_()

		_G.OnLoadedCallBack_ = nil
	end

	ChessLuaBridge.LookAtPlayer()

	manager.ChessManager = ChessMain.GetInstance()

	if ChapterCfg[WarChessData:GetCurrentWarChessMapData().mapId] and slot1.cue_sheet ~= "" then
		manager.audio:PlayBGM(slot1.cue_sheet, slot1.cue_name, slot1.awb)
	end

	SceneManager.SetActiveScene(SceneManager.GetSceneByName(WarchessLevelCfg[slot0.mapId].scene_id))
	manager.ChessManager:SetUp(slot0.mapId)
	gameContext:Go("/warHome", {
		mapId = slot0.mapId
	})
	manager.windowBar:SetWhereTag("chess")

	if WarChessData:IsAboutToStart() then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_START, {})
	end
end

function PreloadChessAsset()
	slot1 = nil

	for slot5, slot6 in pairs(BattleTeamData:GetSingleTeam(WarChessData:GetCurrentActivity())) do
		if slot6 ~= 0 then
			slot9 = manager.resourcePool:Get("Char/" .. HeroTools.HeroUsingSkinInfo(slot6).ui_modelId, ASSET_TYPE.TPOSE)

			Timer.New(function ()
				manager.resourcePool:DestroyOrReturn(uv0, ASSET_TYPE.TPOSE)
			end, 0.1, 1):Start()
		end
	end

	for slot6 = 1, #ViewCfg.chess.need_atlas do
		LuaForUtil.PreLoadAtlas(slot2.need_atlas[slot6])
	end
end

function GridClick(slot0, slot1, slot2)
	CheckManagers()

	if manager.ChessManager.forceBattle:IsForcingBattle() then
		manager.ChessManager.forceBattle:ForceEnterBossBattle()

		return
	end

	if not ChessTools.IsInteract(slot0.typeID, slot0.status) and not ChessTools.IsMove(slot0.typeID, slot0.status) then
		return
	end

	manager.ChessManager:SetGridSelectOutline(slot0.x, slot0.z, true)
	OperationRecorder.Record("chess", "grid")

	if not manager.ChessManager.current:IsDetector() and not slot2 and slot1.Length >= 1 then
		for slot6 = 0, slot1.Length - 1 do
			if ChessTools.WayFindingWeight(slot1[slot6].typeID, slot1[slot6].status) == 999 and slot6 ~= slot1.Length - 1 and slot6 ~= 0 then
				slot2 = true

				break
			end

			if slot9 == 999 and slot6 == slot1.Length - 1 and (slot1[slot6].x ~= slot0.x or slot1[slot6].z ~= slot0.z) then
				slot2 = true

				break
			end
		end
	end

	if manager.ChessManager.current:IsDetector() and not slot2 and slot1.Length >= 1 then
		slot6 = WarChessData:GetCurrentIndex()

		if ChessTools.IsMove(slot0.typeID, slot0.status) and not ChessTools.IsInRange(slot0.x - slot6.x, slot0.z - slot6.z, 1) then
			slot2 = true
		end
	end

	if not slot2 and slot1.Length >= 1 then
		for slot7 = 0, slot1.Length - 1 do
			table.insert({}, {
				x = slot1[slot7].x,
				z = slot1[slot7].z
			})
		end

		if manager.ChessManager.current:IsDetector() then
			WarChessData:SetDetectorPos(slot3[#slot3].x, slot3[#slot3].z)
		end

		manager.ChessManager:CachePath(slot3)
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CLICK, {
			gridData = slot0,
			pathList = slot1,
			isError = slot2
		})
	else
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CLICK, {
			gridData = slot0,
			pathList = slot1,
			isError = slot2
		})
	end
end

function ClickRole(slot0)
	print("ClickRole")
end

function SetUpChess()
	manager.ChessManager.current:ExtendSetup()
end

function WalkIntoNode(slot0)
	if manager.ChessManager.current:IsDetector() then
		return false
	end

	slot3 = nil

	if manager.ChessManager:SetPosition(slot0.x, slot0.z) then
		return manager.ChessManager:ExecuteChessTiming(manager.ChessManager.current:IsCurrentState() and ChessConst.TIMING_CURRENT or ChessConst.TIMING_WALK, {
			gridData = slot0
		})
	else
		return false
	end
end

function SlideEnd(slot0)
	if manager.ChessManager.current:IsAboutToSlide() then
		return manager.ChessManager.current:SlideByDirectionInCurrentState(slot1)
	end

	if slot0 and slot0.paramList.Length > 0 then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_CURRENT_HIT, {
			gridData = slot0
		})
	end

	manager.ChessManager.current:CurrentEnd()
	manager.ChessManager.current:AboutToDie(2)
end

function WalkEnd()
	if manager.ChessManager.current:IsCurrentState() then
		return
	end

	manager.ChessManager:OnMoveEnd()

	if manager.ChessManager.current:IsAboutToSlide() then
		return manager.ChessManager.current:SlideByDirection(slot0)
	end

	if manager.ChessManager:IsExecuting() then
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_INTERACT, {})
	end

	manager.ChessManager.current:AboutToDie(2)
end

function FogOpen(slot0)
	WarChessData:ChangeFogInfo(slot0)
end

function OnExitChessScene(slot0)
	manager.windowBar:ClearWhereTag()
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	slot1 = WarChessData:GetChapterClientID()

	OpenPageUntilLoaded(WarChessData:GetTemporaryData("url"), WarChessData:GetTemporaryData("urlParams"))

	if slot0 then
		WarChessAction.FinishExplore()
	else
		slot4 = WarChessData:GetCurrentWarChessMapData()

		for slot9, slot10 in pairs(WarChessData:GetItemData()) do
			table.insert({}, {
				slot9,
				slot10
			})
		end

		for slot10, slot11 in pairs(WarChessData:GetHeroList()) do
			table.insert({}, {
				slot10,
				slot11
			})
		end

		for slot11, slot12 in pairs(WarChessData:GetArtifactData()) do
			table.insert({}, slot11)
		end

		slot8 = {}

		for slot12, slot13 in ipairs(slot4.log) do
			table.insert(slot8, slot13.log)
		end

		SDKTools.SendMessageToSDK("chess_leave", {
			map_id = slot4.mapId,
			location_id = {
				slot4.bronPos.x,
				slot4.bronPos.z
			},
			log = slot8,
			smallbox = WarChessData:GetBoxNum(slot4.mapId, ChessConst.BOX.SMALL),
			bigbox = WarChessData:GetBoxNum(slot4.mapId, ChessConst.BOX.BIG),
			key_own = slot5,
			hero_blood = slot6,
			relic_exsiting = slot7,
			progress = ChessTools.GetProgress(slot4.mapId),
			use_seconds = manager.time:GetServerTime() - WarChessData:GetStartTime()
		})
	end

	manager.ChessManager:Dispose()

	manager.ChessManager = nil
end

function OnCameraMove()
	manager.notify:CallUpdateFunc(CAMERA_MOVE, true)
end

function OnBulletHit(slot0, slot1, slot2, slot3)
	if not slot3 then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	if slot3.paramList.Length <= 0 then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	if not WarchessEventPoolCfg[slot3.paramList[0]] then
		-- Nothing
	end

	if WarchessEventPoolCfg[slot4].event_group_second == "" then
		manager.ChessManager:OnBulletEnd()
		ChessLuaBridge.LookAtPlayer()

		return
	end

	manager.ChessManager:SetBulletDirection(slot2)
	manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_HIT, {
		gridData = slot3
	})
	manager.ChessManager:OnBulletEnd()
end

function OnStoneInteract(slot0, slot1)
	if ChessTools.IsStoneInteract(slot1.typeID, slot1.status, slot0.status) then
		WarChessData:CacheGridData(slot0)
		manager.ChessManager:ExecuteChessTiming(ChessConst.TIMING_STONE_MOVE, {
			gridData = slot1
		})
	else
		ChessLuaBridge.StoneContinueMove()
	end
end

function OnStoneMoveEnd(slot0, slot1)
	manager.ChessManager:HideBlocker()
	ChessLuaBridge.LookAtPlayer()

	if slot1 ~= nil then
		slot2 = WarChessData:GetGridAttribute(slot0.x, slot0.z)
		slot3 = WarChessData:GetGridLua(slot1.x, slot1.z).tag
		slot4 = ChessTools.GetExtendIDByStoneStatus(slot0.status)

		if slot1.typeID == ChessConst.HOLE_GRID_ID then
			slot4 = WarChessData:GetCacheExtendID("stoneAndHole")
		end

		WarChessData:ChangeGridLua(slot1.x, slot1.z, slot4)
		ChessLuaBridge.ChangeGridByIndex(slot1.x, slot1.z, slot4)

		if slot2[1] == nil and slot2[2] == nil then
			WarChessData:SetGridAttribute(slot1.x, slot1.z, {
				slot0.x,
				slot0.z,
				slot3
			})
		else
			WarChessData:SetGridAttribute(slot1.x, slot1.z, {
				slot2[1],
				slot2[2],
				slot3
			})
		end

		if slot2[3] and slot2[3] ~= 0 then
			WarChessData:ChangeGridLua(slot0.x, slot0.z, slot2[3])
			ChessLuaBridge.ChangeGridByIndex(slot0.x, slot0.z, slot2[3])
		else
			WarChessData:ChangeGridLua(slot0.x, slot0.z, 0)
			ChessLuaBridge.ChangeGrid(slot0.x, slot0.z, ChessTools.CreateChessDataViaJson(WarChessData:GetJsonData(slot0.x, slot0.z)))
		end
	end

	WarChessData:ClearCacheGridData()
end
