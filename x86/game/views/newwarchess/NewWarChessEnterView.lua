slot0 = class("NewWarChessEnterView", ReduxView)

function slot0.UIName(slot0)
	return "UI/NewWarChess/NewWarChessGo"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
end

function slot0.OnEnter(slot0)
	slot0.timer_ = Timer.New(function ()
		uv0:StopTimer()

		if NewWarChessData:GetAttribute("GAME_NEWCHESS_ATTRIBUTE_FIRST_IN") == 0 then
			manager.NewChessManager:ExecuteChessTiming(NewChessConst.TIMING_START, {})
			manager.NewChessManager:StartExecuteEvent()
		end

		gameContext:Go("/newWarChessHome")
	end, 1.2, 1)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	slot0:StopTimer()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

function slot0.Dispose(slot0)
	slot0:StopTimer()
	uv0.super.Dispose(slot0)
end

return slot0
