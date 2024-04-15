NewBattleFailedWithButtonView = import("game.views.battleFailed.newBattleFailed.NewBattleFailedWithButtonView")
slot0 = class("SoloHeartDemonFailView", NewBattleFailedWithButtonView)

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)

	slot4 = 0

	if LuaExchangeHelper.GetBattleStatisticsData().dataForLua.recordDatas:TryGetValue(8, nil) then
		slot4 = slot2[8] or 0
	end

	SoloHeartDemonData:UpdateBattleFinishData(1, nil, , , slot4, nil, slot0.params_.stageData:GetDest())
end

return slot0
