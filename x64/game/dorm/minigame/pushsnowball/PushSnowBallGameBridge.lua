function slot1()
	JumpTools.OpenPageByJump(PushSnowBallData:GetGoViewStr())
end

function PushSnowBallGoToMain()
	DestroyLua()
	gameContext:ClearHistoryByName("setting")
	LuaExchangeHelper.GoToMain()
end

return {
	Enter = function (slot0)
		manager.ui:SetMainCamera("pushSnowBall")
		DormMinigame.AdjustCameraFOV(0.5625)

		slot0.listener = EventListener.New()
		slot1 = PushSnowBallGameMgr.GetInstance()

		slot1:Init()
		slot1:SetPlayer(PushSnowBallData:GetSelectedHeroID())
		uv0()
	end,
	Exit = function (slot0)
		slot0.listener:RemoveAll()
		PushSnowBallGameMgr.GetInstance():Dispose()
	end
}
