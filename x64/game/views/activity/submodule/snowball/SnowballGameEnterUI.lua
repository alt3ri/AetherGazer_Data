slot0 = class("SnowballGameEnterUI", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballGameEnterUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.startBtn_, nil, handler(slot0, slot0.StartGame))

	slot0.modeController = ControllerUtil.GetController(slot0.transform_, "mode")
end

slot1 = {
	"normal",
	"hard",
	"infinite"
}

function slot0.OnEnter(slot0)
	slot0.level = slot0.params_.level
	slot1 = SnowballGameCfg[slot0.level]
	slot0.title_.text = slot1.level_desc
	slot0.levelTime_.text = GetTipsF("%d s", slot1.time_limit)

	slot0.modeController:SetSelectedState(uv0[slot1.level_mode])
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnBehind(slot0)
	manager.windowBar:HideBar()
end

function slot2(slot0)
	gameContext:Go("/snowballGameControlUI", {
		playerEID = SnowballGameMgr.GetInstance():GetPlayerEID(),
		level = slot0
	}, nil, true)
end

function slot0.StartGame(slot0)
	SnowballGameAction.EnterGameAction(slot0.level, uv0)
end

return slot0
