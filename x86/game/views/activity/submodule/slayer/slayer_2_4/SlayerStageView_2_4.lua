slot1 = class("SplayerStageView_2_4", import("game.views.activity.Submodule.slayer.slayer_1_7.SlayerStageView_1_7"))

function slot1.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("ACTIVITY_SLAYER_DESCRIBE")
end

return slot1
