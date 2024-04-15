slot0 = class("BattleCooperationFailedView", BattleFailedView)

function slot0.OnEnter(slot0)
	BattleInstance.hideBattlePanel()
	slot0:RecordThreeStar()

	slot0.startTime = Time.realtimeSinceStartup
	slot0.isEnd = false

	if slot0.params_.data_math_error then
		ShowMessageBox({
			ButtonType = "SingleBtn",
			isTop = true,
			content = GetTips("COOPERATION_DATA_ERROR"),
			OkCallback = function ()
				uv0:Quit()
			end
		})
	else
		slot0:RemoveTimer()

		slot0.timer_ = Timer.New(function ()
			uv0:Quit()
		end, slot0.stayTime, 1)

		slot0.timer_:Start()
	end

	slot0.battleTimeText_.text = slot0:GetBattleTime()

	slot0.animator_:Play("battleFailed")
end

function slot0.QuitUI(slot0)
	DestroyLua()
	LuaExchangeHelper.GoToMain()

	if CooperationData:GetRoomData() then
		CooperationTools.GotoCooperation()
	else
		CooperationTools.GotoCooperationEntry(slot0.params_.stageData:GetType(), slot0.params_.stageData:GetDest(), slot0.params_.stageData:GetActivityID())
	end
end

function slot0.RecordThreeStar(slot0)
end

return slot0
