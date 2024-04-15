slot0 = class("DormLinkGameFailView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGPlayResult2"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.restartBtn_, nil, function ()
		DormLinkGameData:ResetRunGameInfo()
		manager.notify:Invoke(LIANLIANKAN_GAME_RESET)
		JumpTools.OpenPageByJump("/dormLinkGamePlayView")
	end)
	slot0:AddBtnListenerScale(slot0.backBtn_, nil, function ()
		DormLinkGameTools:ExitGame()
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
