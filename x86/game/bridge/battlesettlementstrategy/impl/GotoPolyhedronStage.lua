slot0 = class("GotoPolyhedronStage", BattleSettlementStrategyBase)

function slot0.OnGotoSettlement(slot0, slot1)
	slot0:OnGotoPolyhedron(slot1.num, slot1.stageData, slot1.starMissionData, slot1.battleResult)
end

function slot0.OnGotoPolyhedron(slot0, slot1, slot2, slot3, slot4)
	slot5, slot6 = GetResultReward()

	if isSuccess(slot1) then
		if slot4.errorCode == 12000 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})

			return
		end

		if PolyhedronConst.STATE_TYPE.STARTED == PolyhedronData:GetPolyhedronInfo():GetState() then
			DoPolyhedronNextTrigger()
		elseif PolyhedronConst.STATE_TYPE.SETTLEMENT == slot8 then
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronOver", {})
		else
			DestroyLua()
			LuaExchangeHelper.GoToMain()
			OpenPageUntilLoaded("/polyhedronBlank/polyhedronLobby", {})
		end
	else
		function BattleCallLuaCallBack()
			gameContext:Go("/battlePolyhedronFailed", {
				stageData = uv0,
				starMissionData = uv1,
				battleResult = uv2
			})
			manager.story:RemovePlayer()
			EndBattleLogic(uv3)
		end
	end
end

return slot0
