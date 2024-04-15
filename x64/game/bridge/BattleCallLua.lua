BattleCooperationCallLua = require("game/bridge/BattleCooperationCallLua")

local var_0_0 = require("game/bridge/BattleSettlementStrategy/BattleResultGotoHandler")

var_0_0:Init()

local var_0_1 = false

function ShowBattlePausePage(arg_1_0, arg_1_1)
	local var_1_0 = BattleController.GetInstance():GetBattleStageData()

	if not BattleFieldData:IsInBattle() and BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_1_0:GetType() then
		return
	end

	CheckManagers()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_1_0:GetType() then
		gameContext.oldRoutes_ = {}
	end

	local var_1_1 = BattleInstance.CaculateStarMission(var_1_0, arg_1_0)
	local var_1_2 = var_1_0:GetStageId()
	local var_1_3 = var_1_0:GetType()
	local var_1_4 = SettingConst.SETTING_TYPE.BATTLE_OTHER

	if BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT == var_1_3 then
		var_1_4 = SettingConst.SETTING_TYPE.BATTLE_MAIN
	end

	gameContext:Go("/setting", {
		setType = var_1_4,
		section = var_1_2,
		result = arg_1_0,
		starMissionData = var_1_1,
		newbie = arg_1_1,
		stageData = var_1_0
	})
	OperationRecorder.Record("BattleCallLua", "combat_pause")
end

local var_0_2 = 202005
local var_0_3 = 200005

_G.BATTLE_SERVER_ERROR_TIME = 0

function BattleServerConnectError(arg_2_0)
	if arg_2_0 == var_0_3 then
		LuaExchangeHelper.EndWaitReadyAck()
		CheckManagers()
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_NOT_JOIN_AFTER_OTHERS_READY"),
			OkCallback = function()
				gameContext:DestroyCurRoutes()

				local var_3_0 = BattleFieldData:GetServerBattleID()

				CooperationAction.LeaveCooperationBattle(function(arg_4_0)
					local var_4_0 = BattleController.GetInstance():GetBattleStageData()

					BattleInstance.QuitBattle(var_4_0, true)
				end, var_3_0)
			end
		})

		return
	end

	if arg_2_0 ~= var_0_2 then
		CheckManagers()

		function BattleCallLuaCallBack()
			print("与战斗服连接出现错误，玩家白打，返回登录界面")
		end
	end

	_G.BATTLE_SERVER_ERROR_TIME = _G.BATTLE_SERVER_ERROR_TIME + 1

	ConnectionHelper.OnBattleServerConnectError(arg_2_0, _G.BATTLE_SERVER_ERROR_TIME)
end

function ShowStory(arg_6_0, arg_6_1, arg_6_2)
	CheckManagers()

	gameContext.oldRoutes_ = {}

	manager.gc:Collect()
	Resources.UnloadUnusedAssets()
	manager.story:StartBattleStory(arg_6_0, function()
		gameContext:DestroyCurRoutes()
		LuaExchangeHelper.ActionInvoke(arg_6_2)
		manager.gc:Collect()
		Resources.UnloadUnusedAssets()
	end, arg_6_1)
end

function GetMardukePlane()
	return TowerGameData:GetCanUsePlane()
end

function SendQuitBattle(arg_9_0, arg_9_1)
	var_0_1 = arg_9_1

	manager.uiInit()

	gameContext.oldRoutes_ = {}

	print("客户端战斗结束，准备向服务端请求战斗结果")

	local var_9_0 = BattleController.GetInstance():GetBattleStageData()

	if BattleConst.STAGE_TYPE_NEW.POLYHEDRON ~= var_9_0:GetType() then
		BattleInstance.hideBattlePanel()
	end

	gameContext:SetSystemLayer("battleResult")

	_G.PrintAllOpen_ = true

	print("开启心跳包打印，用于监测网络状态")
	print("网络连接状态是否可用：", Application.internetReachability ~= UnityEngine.NetworkReachability.NotReachable)
	print("网络连接状态是否为局域网：", Application.internetReachability == UnityEngine.NetworkReachability.ReachableViaLocalAreaNetwork)

	local var_9_1 = BattleFieldData:GetServerBattleID()
	local var_9_2 = var_9_0:GetStageId()
	local var_9_3 = arg_9_0.loadMilliseconds

	SDKTools.SendMessageToSDK("load_time_before_battle", {
		combat_id = var_9_2,
		battle_id = var_9_1,
		use_milliseconds = var_9_3,
		battle_version = LuaForUtil.GetBattleVersion()
	})
	manager.achievementTips:FliteAchievementType({
		AchievementConst.AchievementType.MISSION,
		AchievementConst.AchievementType.BATTLE
	})

	local var_9_4 = GetOldPlayerExp()

	if var_9_0:GetIsCooperation() then
		manager.net:SendWithLoadingNew(54110, {
			battle_id = var_9_1
		}, 54111, function(arg_10_0, arg_10_1)
			BattleFieldData:FishCooperationBattle(arg_10_0)
			gameContext:DestroyCurRoutes()
			BattleCooperationCallLua.GotoTeam(var_9_1, arg_10_0.battle_result, arg_10_0.result, var_9_4)
		end)
	else
		manager.net:SendWithLoadingNew(54032, {
			battle_id = var_9_1
		}, 54033, function(arg_11_0, arg_11_1)
			BattleFieldData:FinishBattle(arg_11_0)
			gameContext:DestroyCurRoutes()
			GotoTeam(var_9_1, arg_11_0.battle_result, arg_11_0.result, var_9_4)
		end)
	end

	BattleCallLuaWaitLoading = true

	local var_9_5 = {
		["Atlas/BattleSettlement"] = 20,
		["Atlas/NewBattleSettlement"] = 20
	}

	PreLoadAsset(var_9_5, 0, function()
		for iter_12_0, iter_12_1 in pairs(var_9_5) do
			LuaForUtil.PreLoadAtlas(iter_12_0)
		end

		BattleCallLuaWaitLoading = false

		if BattleCallLuaCallBack and not BattleCallLuaCallBackWait then
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil
		end
	end, true)
end

function GotoTeam(arg_13_0, arg_13_1, arg_13_2, arg_13_3)
	print("服务端战斗数据返回")
	print("收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出):", arg_13_1.result)

	if arg_13_1.result > BattleConst.BATTLE_RESULT.UNFINISHED and arg_13_1.result <= BattleConst.BATTLE_RESULT.QUIT then
		local var_13_0 = BattleController.GetInstance():GetBattleStageData()

		print("BattleCallLua.进入目标结算stage: " .. var_13_0:GetType())

		local var_13_1 = CollectHeroExpChange(var_13_0)

		goToResult(arg_13_1.result - 1, arg_13_1.star_list, {
			challengedNumber = arg_13_1.clear_times,
			clear_times = arg_13_1.clear_times,
			oldPlayerEXPInfo = arg_13_3,
			heroDataCollect = var_13_1,
			errorCode = arg_13_2
		}, var_13_0)
	end
end

function goToResult(arg_14_0, arg_14_1, arg_14_2, arg_14_3)
	_G.PrintAllOpen_ = false

	print("关闭心跳包打印，用于监测网络状态")
	SetForceShowQuanquan(false)

	if _G.CannotConnectTimer then
		_G.CannotConnectTimer:Stop()

		_G.CannotConnectTimer = nil
	end

	ViewAnimationManager.isReturnFromBattle = true

	var_0_0:GotoResult(arg_14_3, arg_14_0, arg_14_1, arg_14_2, var_0_1)

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
		var_0_0:SnapShot()

		if var_0_0.shotTimer then
			var_0_0.shotTimer:Stop()

			var_0_0.shotTimer = nil
		end

		var_0_0.shotTimer = FrameTimer.New(function()
			BattleCallLuaCallBack()

			BattleCallLuaCallBack = nil

			manager.achievementTips:Hide(false)
		end, 1, 1)

		var_0_0.shotTimer:Start()
	else
		CheckManagers()

		if not ConnectionHelper.GetIsDealWithError() then
			SetForceShowQuanquan(true)
		end

		_G.CannotConnectTimer = Timer.New(function()
			ConnectionHelper.ShowReturnToLoginTip()
		end, 600, 1)

		_G.CannotConnectTimer:Start()
	end
end

function GetResultReward()
	local var_18_0 = {}
	local var_18_1 = {}

	for iter_18_0, iter_18_1 in ipairs(BattleFieldData:GetBattleResultData().dropList) do
		var_18_1[iter_18_1.battleTimes] = {}

		for iter_18_2, iter_18_3 in ipairs(iter_18_1.rewardItems) do
			print(string.format("服务端发下第%s次物品数据id:", iter_18_1.battleTimes), iter_18_3.id, "num:", iter_18_3.num)
			table.insert(var_18_1[iter_18_1.battleTimes], {
				iter_18_3.id,
				iter_18_3.num
			})
			table.insert(var_18_0, {
				iter_18_3.id,
				iter_18_3.num
			})
		end
	end

	return var_18_0, var_18_1
end

function EndBattleLogic(arg_19_0)
	manager.guide:OnBattleFinish(arg_19_0)
	manager.achievementTips:FliteAchievementType({})
end

function GetAbyssBossPhase()
	return AbyssData:GetCurrentBossPhase()
end

function OnQuitBattleSuccess()
	manager.notify:Invoke(BULLETIN_QUITBATTLE)
end

function GetOldPlayerExp()
	local var_22_0 = PlayerData:GetPlayerInfo()

	if var_22_0 then
		return {
			userLevel = var_22_0.userLevel or 0,
			remain_exp = var_22_0.remain_exp or 0,
			total_exp = var_22_0.total_exp or 0
		}
	else
		return {
			userLevel = 0,
			total_exp = 0,
			remain_exp = 0
		}
	end
end

function CollectHeroExpChange(arg_23_0)
	local var_23_0, var_23_1 = arg_23_0:GetHeroTeam()
	local var_23_2 = arg_23_0:GetSystemHeroTeam()
	local var_23_3 = {}
	local var_23_4 = {}

	if var_23_0[2] == 0 then
		table.remove(var_23_0, 2)
		table.remove(var_23_1, 2)
		table.insert(var_23_0, 0)
		table.insert(var_23_1, 0)
	end

	for iter_23_0 = 1, 3 do
		var_23_4[iter_23_0] = {}

		if not var_23_0[iter_23_0] or var_23_0[iter_23_0] == 0 then
			var_23_4[iter_23_0] = nil
		else
			local var_23_5 = arg_23_0:GetHeroDataByPos(iter_23_0)

			if var_23_5 and not var_23_2[iter_23_0] and var_23_1[iter_23_0] == 0 and NeedAddExpWithoutBlack(arg_23_0) then
				local var_23_6 = var_23_5.level
				local var_23_7 = var_23_5.exp - LvTools.LevelToExp(var_23_6, "hero_level_exp1")
				local var_23_8 = LvTools.GetMaxTotalExp("hero_level_exp1") - var_23_5.exp

				if var_23_8 < 0 then
					var_23_8 = 0
				end

				local var_23_9 = arg_23_0:GetMultiple()
				local var_23_10 = arg_23_0:GetAddHeroExp() * var_23_9
				local var_23_11 = arg_23_0:GetActivityID()
				local var_23_12 = ActivityData:GetActivityData(var_23_11)

				if var_23_11 ~= 0 and (not var_23_12 or not var_23_12:IsActivitying()) then
					var_23_10 = 0
				end

				local var_23_13 = math.min(var_23_10, var_23_8)
				local var_23_14 = HeroTools.GetHeroCurrentMaxLevel(var_23_5)
				local var_23_15, var_23_16, var_23_17, var_23_18, var_23_19 = LvTools.CheckHeroExp(var_23_6, var_23_5.exp + var_23_13, var_23_14)
				local var_23_20 = var_23_13 - var_23_19
				local var_23_21 = {
					id = var_23_5.id,
					newLv = var_23_15,
					newExp = var_23_5.exp + var_23_20
				}

				table.insert(var_23_3, var_23_21)

				local var_23_22 = math.min(math.floor(var_23_7 / GameLevelSetting[var_23_6].hero_level_exp1 * 1000) / 1000, 0.9999)
				local var_23_23 = math.min(math.floor(var_23_16 / GameLevelSetting[var_23_15].hero_level_exp1 * 1000) / 1000, 0.9999)

				var_23_4[iter_23_0] = {
					oldLv = var_23_6,
					newLv = var_23_15,
					oldPersent = var_23_22,
					newPersent = var_23_23
				}
			else
				var_23_4[iter_23_0] = nil
			end
		end
	end

	if var_23_3 then
		for iter_23_1, iter_23_2 in ipairs(var_23_3) do
			HeroAction.AddHeroExpSuccess(iter_23_2.id, iter_23_2.newLv, iter_23_2.newExp)
		end
	end

	return var_23_4 or {}
end

function NeedAddExpWithoutBlack(arg_24_0)
	if not arg_24_0 then
		return false
	end

	local var_24_0 = arg_24_0:GetType()

	if var_24_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_PLOT or var_24_0 == BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_SUB_PLOT then
		return BattleInstance.NeedAddExp(arg_24_0)
	end

	return true
end

function GetBattleResultSnapShot()
	return var_0_0:GetSnapShot()
end

function ReleaseBattleResultSnapshot()
	pcall(function()
		if var_0_0 ~= nil then
			var_0_0:ReleaseSnapShot()
		end
	end)
end
