slot0 = class("NewChessMenu", ReduxView)

function slot0.UIName(slot0)
	return "UI/WarChess/WarChessMenu"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:BindCfgUI(slot0.summercontextTrs_)

	slot0.themeCon_ = ControllerUtil.GetController(slot0.transform_, "name")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cancelbtnBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("CONFIRM_TO_QUIT_CHESS"),
			OkCallback = function ()
				NewChessTools.ExitNewChessScene(true)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		NewChessTools.ExitNewChessScene(false)
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		uv0:Back()

		if uv0.callback_ then
			uv0.callback_()
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshUI(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
