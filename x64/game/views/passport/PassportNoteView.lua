slot0 = class("PassportNoteView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Passport/PassportNoteUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.OnTop(slot0)
end

function slot0.OnExitInput(slot0)
	JumpTools.Back()

	return true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
