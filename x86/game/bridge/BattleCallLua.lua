BattleCooperationCallLua = require("game/bridge/BattleCooperationCallLua")

require("game/bridge/BattleSettlementStrategy/BattleResultGotoHandler"):Init()

slot1 = false

function ShowBattlePausePage(slot0, slot1)
	slot2 = BattleController.GetInstance():GetBattleStageData()

	if not BattleFieldData:IsInBattle() and BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= slot2:GetType() then
		return
	end

	CheckManagers()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= slot2:GetType() then
		gameContext.oldRoutes_ = {}
	end

	slot3 = BattleInstance.CaculateStarMission(slot2, slot0)
	slot4 = slot2:GetStageId()
	slot6 = SettingConst.SETTING_TYPE.BATTLE_OTHER

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == slot2:GetType() then
		slot6 = SettingConst.SETTING_TYPE.BATTLE_MAIN
	end

	gameContext:Go("/setting", {
		setType = slot6,
		section = slot4,
		result = slot0,
		starMissionData = slot3,
		newbie = slot1,
		stageData = slot2
	})
	OperationRecorder.Record("BattleCallLua", "combat_pause")
end

slot2 = 202005
slot3 = 200005
_G.BATTLE_SERVER_ERROR_TIME = 0

function BattleServerConnectError(slot0)
	if slot0 == uv0 then
		LuaExchangeHelper.EndWaitReadyAck()
		CheckManagers()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_NOT_JOIN_AFTER_OTHERS_READY"),
			OkCallback = function ()
				gameContext:DestroyCurRoutes()
				CooperationAction.LeaveCooperationBattle(function (slot0)
					BattleInstance.QuitBattle(BattleController.GetInstance():GetBattleStageData(), true)
				end, BattleFieldData:GetServerBattleID())
			end
		})

		return
	end

	if slot0 ~= uv1 then
		CheckManagers()

		function BattleCallLuaCallBack()
			print("与战斗服连接出现错误，玩家白打，返回登录界面")
		end
	end

	_G.BATTLE_SERVER_ERROR_TIME = _G.BATTLE_SERVER_ERROR_TIME + 1

	ConnectionHelper.OnBattleServerConnectError(slot0, _G.BATTLE_SERVER_ERROR_TIME)
end

function ShowStory(slot0, slot1, slot2)
	CheckManagers()

	gameContext.oldRoutes_ = {}

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
	manager.story:StartBattleStory(slot0, function ()
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ActionInvoke(uv0)
		manager.gc:Collect()
		Resources.UnloadUnusedAssets()
	end, slot1)
end

function GetMardukePlane()
	return TowerGameData:GetCanUsePlane()
end

function SendQuitBattle(slot0, slot1)
	uv0 = slot1

	manager.uiInit()

	gameContext.oldRoutes_ = {}

	print("客户端战斗结束，准备向服务端请求战斗结果")

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= BattleController.GetInstance():GetBattleStageData():GetType() then
		BattleInstance.hideBattlePanel()
	end

	gameContext:SetSystemLayer("battleResult")

	_G.PrintAllOpen_ = true

	print("开启心跳包打印，用于监测网络状态")
	print("网络连接状态是否可用：", Application.internetReachability ~= UnityEngine.NetworkReachability.NotReachable)
	print("网络连接状态是否为局域网：", Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)
	SDKTools.SendMessageToSDK("load_time_before_battle", {
		combat_id = slot2:GetStageId(),
		battle_id = BattleFieldData:GetServerBattleID(),
		use_milliseconds = slot0.loadMilliseconds,
		battle_version = LuaForUtil.GetBattleVersion()
	})
	manager.achievementTips:FliteAchievementType({
		AchievementConst.AchievementType.MISSION,
		AchievementConst.AchievementType.BATTLE
	})

	slot6 = GetOldPlayerExp()

	if slot2:GetIsCooperation() then
		manager.net:SendWithLoadingNew(54110, {
			battle_id = slot3
		}, 54111, function (slot0, slot1)
			BattleFieldData:FishCooperationBattle(slot0)
			gameContext:DestroyCurRoutes()
			BattleCooperationCallLua.GotoTeam(uv0, slot0.battle_result, slot0.result, uv1)
		end)
	else
		manager.net:SendWithLoadingNew(54032, {
			battle_id = slot3
		}, 54033, function (slot0, slot1)
			BattleFieldData:FinishBattle(slot0)
			gameContext:DestroyCurRoutes()
			GotoTeam(uv0, slot0.battle_result, slot0.result, uv1)
		end)
	end

	BattleCallLuaWaitLoading = true

	PreLoadAsset({
		["Atlas/BattleSettlement"] = 20,
		["Atlas/NewBattleSettlement"] = 20
	}, 0, function ()
		for slot3, slot4 in pairs(uv0) do
			LuaForUtil.PreLoadAtlas(slot3)
		end

		BattleCallLuaWaitLoading = false

		if BattleCallLuaCallBack and not BattleCallLuaCallBackWait then
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil
		end
	end, true)
end

function GotoTeam(slot0, slot1, slot2, slot3)
	print("服务端战斗数据返回")
	print("收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出):", slot1.result)

	if BattleConst.BATTLE_RESULT.UNFINISHED < slot1.result and slot1.result <= BattleConst.BATTLE_RESULT.QUIT then
		slot4 = BattleController.GetInstance():GetBattleStageData()

		print("BattleCallLua.进入目标结算stage: " .. slot4:GetType())
		goToResult(slot1.result - 1, slot1.star_list, {
			challengedNumber = slot1.clear_times,
			clear_times = slot1.clear_times,
			oldPlayerEXPInfo = slot3,
			heroDataCollect = CollectHeroExpChange(slot4),
			errorCode = slot2
		}, slot4)
	end
end

function goToResult(slot0, slot1, slot2, slot3)
	_G.PrintAllOpen_ = false

	print("关闭心跳包打印，用于监测网络状态")
	SetForceShowQuanquan(false)

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	ViewAnimationManager.isReturnFromBattle = true

	uv0:GotoResult(slot3, slot0, slot1, slot2, uv1)

	if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
		BattleCallLuaCallBack()

		BattleCallLuaCallBack = nil
	end
end

function ShowSettlement()
	print("收到允许弹出结算界面通知（因为可能在播放胜利动作中）")

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	BattleCallLuaCallBackWait = false

	if BattleCallLuaCallBack and not BattleCallLuaWaitLoading then
		manager.achievementTips:Hide(true)
		uv0:SnapShot()

		if uv0.shotTimer then
			uv0.shotTimer:Stop()

			uv0.shotTimer = nil
		end

		uv0.shotTimer = FrameTimer.New(function ()
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil

			manager.achievementTips:Hide(false)
		end, 1, 1)

		uv0.shotTimer:Start()
	else
		CheckManagers()

		if not ConnectionHelper.GetIsDealWithError() then
			SetForceShowQuanquan(true)
		end

		_G.CannotConnectTimer = Timer.New(function ()
			ConnectionHelper.ShowReturnToLoginTip()
		end, 600, 1)

		_G.CannotConnectTimer:Start()
	end
end

function GetResultReward()
	slot0 = {}

	for slot5, slot6 in ipairs(BattleFieldData:GetBattleResultData().dropList) do
		for slot10, slot11 in ipairs(slot6.rewardItems) do
			print(string.format("服务端发下第%s次物品数据id:", slot6.battleTimes), slot11.id, "num:", slot11.num)
			table.insert(slot1[slot6.battleTimes], {
				slot11.id,
				slot11.num
			})
			table.insert(slot0, {
				slot11.id,
				slot11.num
			})
		end
	end

	return slot0, {
		[slot6.battleTimes] = {}
	}
end

function EndBattleLogic(slot0)
	manager.guide:OnBattleFinish(slot0)
	manager.achievementTips:FliteAchievementType({})
end

function GetAbyssBossPhase()
	return AbyssData:GetCurrentBossPhase()
end

function OnQuitBattleSuccess()
	manager.notify:Invoke(BULLETIN_QUITBATTLE)
end

function GetOldPlayerExp()
	if PlayerData:GetPlayerInfo() then
		return {
			userLevel = slot0.userLevel or 0,
			remain_exp = slot0.remain_exp or 0,
			total_exp = slot0.total_exp or 0
		}
	else
		return {
			userLevel = 0,
			total_exp = 0,
			remain_exp = 0
		}
	end
end

function CollectHeroExpChange(slot0)
	slot1, slot2 = slot0:GetHeroTeam()
	slot3 = slot0:GetSystemHeroTeam()
	slot4 = {}
	slot5 = {}

	if slot1[2] == 0 then
		table.remove(slot1, 2)
		table.remove(slot2, 2)
		table.insert(slot1, 0)
		table.insert(slot2, 0)
	end

	for slot9 = 1, 3 do
		slot5[slot9] = {}

		if not slot1[slot9] or slot1[slot9] == 0 then
			slot5[slot9] = nil
		elseif slot0:GetHeroDataByPos(slot9) and not slot3[slot9] and slot2[slot9] == 0 and NeedAddExpWithoutBlack(slot0) then
			slot12 = slot10.exp - LvTools.LevelToExp(slot10.level, "hero_level_exp1")

			if LvTools.GetMaxTotalExp("hero_level_exp1") - slot10.exp < 0 then
				slot14 = 0
			end

			slot16 = slot0:GetAddHeroExp() * slot0:GetMultiple()
			slot17 = slot0:GetActivityID()
			slot18 = ActivityData:GetActivityData(slot17)

			if slot17 ~= 0 and (not slot18 or not slot18:IsActivitying()) then
				slot16 = 0
			end

			slot19 = math.min(slot16, slot14)
			slot21, slot22, slot23, slot24, slot25 = LvTools.CheckHeroExp(slot11, slot10.exp + slot19, HeroTools.GetHeroCurrentMaxLevel(slot10))

			table.insert(slot4, {
				id = slot10.id,
				newLv = slot21,
				newExp = slot10.exp + slot19 - slot25
			})

			slot5[slot9] = {
				oldLv = slot11,
				newLv = slot21,
				oldPersent = math.min(math.floor(slot12 / GameLevelSetting[slot11].hero_level_exp1 * 1000) / 1000, 0.9999),
				newPersent = math.min(math.floor(slot22 / GameLevelSetting[slot21].hero_level_exp1 * 1000) / 1000, 0.9999)
			}
		else
			slot5[slot9] = nil
		end
	end

	if slot4 then
		for slot9, slot10 in ipairs(slot4) do
			HeroAction.AddHeroExpSuccess(slot10.id, slot10.newLv, slot10.newExp)
		end
	end

	return slot5 or {}
end

function NeedAddExpWithoutBlack(slot0)
	if not slot0 then
		return false
	end

	if slot0:GetType() == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or slot1 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		return BattleInstance.NeedAddExp(slot0)
	end

	return true
end

function GetBattleResultSnapShot()
	return uv0:GetSnapShot()
end

function ReleaseBattleResultSnapshot()
	pcall(function ()
		if uv0 ~= nil then
			uv0:ReleaseSnapShot()
		end
	end)
end
