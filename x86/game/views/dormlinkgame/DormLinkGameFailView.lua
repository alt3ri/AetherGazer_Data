local var_0_0 = class("DormLinkGameFailView", ReduxView)

function var_0_0.UIName(arg_1_0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGPlayResult2"
end

function var_0_0.UIParent(arg_2_0)
	return manager.ui.uiMain.transform
end

function var_0_0.OnCtor(arg_3_0)
	return
end

function var_0_0.Init(arg_4_0)
	arg_4_0:InitUI()
	arg_4_0:AddUIListener()
end

function var_0_0.InitUI(arg_5_0)
	arg_5_0:BindCfgUI()
end

function var_0_0.AddUIListener(arg_6_0)
	arg_6_0:AddBtnListenerScale(arg_6_0.restartBtn_, nil, function()
		DormLinkGameData:ResetRunGameInfo()
		manager.notify:Invoke(LIANLIANKAN_GAME_RESET)
		JumpTools.OpenPageByJump("/dormLinkGamePlayView")
	end)
	arg_6_0:AddBtnListenerScale(arg_6_0.backBtn_, nil, function()
		DormLinkGameTools:ExitGame()
	end)
end

function var_0_0.OnEnter(arg_9_0)
	return
end

function var_0_0.OnExit(arg_10_0)
	return
end

function var_0_0.Dispose(arg_11_0)
	var_0_0.super.Dispose(arg_11_0)
end

return var_0_0
