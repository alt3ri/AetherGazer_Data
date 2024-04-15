slot0 = class("ActivityPushBoxQuitView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionUI_2_10AnniversaryUI/BoxGamePausePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		PushBoxTool:SendSdk(uv0.params_.activityID, uv0.params_.id, 3)

		if uv0.params_.way == "back" then
			JumpTools.OpenPageByJump("/activityPushBoxMaterial", {
				activityID = uv0.params_.activityID
			})
		elseif uv0.params_.way == "home" then
			JumpTools.OpenPageByJump("/home")
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
