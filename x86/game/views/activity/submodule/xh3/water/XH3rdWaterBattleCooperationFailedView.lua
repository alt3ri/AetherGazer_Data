BattleFailedView = import("game.views.battleFailed.BattleFailedView")
slot0 = class("XH3rdWaterBattleCooperationFailedView", BattleFailedView)

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot1, slot2 = slot0.params_.stageData:GetIsCooperation()

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

function slot0.Quit(slot0)
	slot0.isEnd = true

	slot0:RemoveTimer()

	slot0.timer_ = Timer.New(function ()
		DestroyLua()
		LuaExchangeHelper.GoToMain()

		if CooperationData:GetRoomData() then
			CooperationTools.GotoCooperation()
		else
			CooperationTools.GotoCooperationEntry(uv0.params_.stageData:GetType(), uv0.params_.stageData:GetDest(), uv0.params_.stageData:GetActivityID())
		end
	end, 1, 1)

	slot0.timer_:Start()
	slot0.animator_:Play("battleFailed_out")
end

function slot0.RecordThreeStar(slot0)
end

return slot0
