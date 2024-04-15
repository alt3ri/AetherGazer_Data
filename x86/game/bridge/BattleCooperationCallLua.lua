require("game/bridge/BattleCooperationSettlementStrategy/BattleCooperationGotoHandler"):Init()

return {
	GotoTeam = function (slot0, slot1, slot2, slot3)
		print("联机服务端战斗数据返回")
		print("联机收到服务器的消息，获取到新的战斗结果(0:战斗进行中,1:胜利,2:失败,3：主动退出, 4:不同步):", slot1.result)

		if BattleConst.BATTLE_RESULT.UNFINISHED < slot1.result and slot1.result <= BattleConst.BATTLE_RESULT.NOSYNC then
			slot4 = BattleController.GetInstance():GetBattleStageData()

			print("BattleCooperationCallLua.进入目标结算stage: " .. slot4:GetType())
			uv0.goToResult(slot1.result - 1, slot1.star_list, {
				oldPlayerEXPInfo = slot3,
				heroDataCollect = CollectHeroExpChange(slot4),
				errorCode = slot2
			})
		end
	end,
	goToResult = function (slot0, slot1, slot2)
		_G.PrintAllOpen_ = false

		print("关闭心跳包打印，用于监测网络状态")
		SetForceShowQuanquan(false)

		if _G.CannotConnectTimer then
			_G.CannotConnectTimer:Stop()

			_G.CannotConnectTimer = nil
		end

		uv0:GotoResult(BattleController.GetInstance():GetBattleStageData(), slot0, slot1, slot2)

		if isSuccess(slot0) then
			if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
				BattleCallLuaCallBack()

				function BattleCallLuaCallBack()
				end
			end
		elseif slot0 == 3 then
			function BattleCallLuaCallBack()
				gameContext:Go("/battleCooperationFailed", {
					data_math_error = true,
					stageData = uv0
				})
				EndBattleLogic(uv1)
			end

			if not BattleCallLuaCallBackWait and not BattleCallLuaWaitLoading then
				BattleCallLuaCallBack()

				function BattleCallLuaCallBack()
				end
			end
		else
			BattleCallLuaCallBackWait = false

			if not BattleCallLuaWaitLoading then
				BattleCallLuaCallBack()

				function BattleCallLuaCallBack()
				end
			end
		end
	end
}
