function slot1()
	gameContext:Go("/snowballGameLevelUI")
end

return {
	Enter = function (slot0)
		manager.ui:SetMainCamera("snowball")
		DormMinigame.AdjustCameraFOV(0.5625)

		slot0.listener = EventListener.New()
		slot1 = SnowballGameMgr.GetInstance()

		slot1:Init()
		SnowballGameTargetAI.GetInstance():Init()
		slot1:SetPlayer(SnowballGameData:GetLastSelectedPlayer())
		slot0.listener:Register(DORM_FRAME_TICK, handler(SnowballGameTargetAI.GetInstance(), SnowballGameTargetAI.Update))
		slot0.listener:Register(ON_FINISH_STORY, uv0.OnFinishStory)

		Dorm.globalSubtitleView = SubtitleBubbleView.New()
		Dorm.overrideSubtitleGetContentFunc = SubtitleBubbleView.UseRawContent

		Dorm.globalSubtitleView:OnEnter()

		if SnowballGameData:IsFirstEnterGame() and not nullable(GameSetting.activity_snowball_first_enter_story.value2, 1) then
			SnowballGameData:SetAlreadyEnter()
			Dorm.LuaBridge.MiniGameBridge.PlayStory(GameSetting.activity_snowball_first_enter_story.value[1], GameSetting.activity_snowball_story_actor.value)

			uv0.OnFinishStoryCallback = uv1
		else
			uv1()
		end
	end,
	Exit = function (slot0)
		Dorm.globalSubtitleView:OnExit()

		Dorm.overrideSubtitleGetContentFunc = nil
		Dorm.globalSubtitleView = Dorm.globalSubtitleView:Dispose()

		slot0.listener:RemoveAll()
		SnowballGameTargetAI.GetInstance():Dispose()
		SnowballGameMgr.GetInstance():Dispose()
	end,
	OnFinishStory = function ()
		Dorm.LuaBridge.MiniGameBridge.StopStory()

		if uv0.OnFinishStoryCallback then
			uv0.OnFinishStoryCallback()

			uv0.OnFinishStoryCallback = nil
		end
	end
}
