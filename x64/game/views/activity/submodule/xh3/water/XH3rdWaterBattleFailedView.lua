BattleFailedView = import("game.views.battleFailed.BattleFailedView")
slot0 = class("XH3rdWaterBattleFailedView", BattleFailedView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1, slot2 = slot0.stageData_:GetIsCooperation()

	if slot1 then
		SetActive(slot0.btnBattleCount_.gameObject, false)
	else
		SetActive(slot0.btnBattleCount_.gameObject, true)
	end
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.GoToBattleStatistics(slot0)
	if slot0.isEnd then
		return
	end

	slot0.toStat_ = true

	slot0:RemoveTimer()
	JumpTools.OpenPageByJump("xH3rdWaterBattleStatistics", {
		stageData = slot0.stageData,
		battleTime = slot0:GetBattleTime()
	})
end

return slot0
