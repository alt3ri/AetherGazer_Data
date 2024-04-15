slot0 = class("DormLinkGameSuccessView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGPlayResult1"
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
	slot0:AddBtnListenerScale(slot0.confirmBtn_, nil, function ()
		DormLinkGameTools:ExitGame()
	end)
end

function slot0.OnEnter(slot0)
	slot0:RefreshView(slot0.params_.data)
end

function slot0.RefreshView(slot0, slot1)
	if slot1 then
		slot0.scoreText_.text = string.format(GetTips("ACTIVITY_LINKGAME_SCORE") .. "<color=#76c844>(+%d)</color>", slot1.totalPoint, slot1.extendPoint)
		slot0.timeText_.text = string.format(GetTips("ACTIVITY_LINKGAME_TIME"), manager.time:DescCDTime(slot1.time))
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
