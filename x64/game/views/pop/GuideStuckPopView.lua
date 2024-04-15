slot0 = class("GuideStuckPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/GuideNewUI/GuideStuckPopView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiTips.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddListeners(slot0)
	slot0.okBtn_.onClick:AddListener(function ()
		uv0:OnClickOk()
	end)
	slot0.cancelBtn_.onClick:AddListener(function ()
		uv0:OnClickCancel()
	end)
	slot0.maskBtn_.onClick:AddListener(function ()
		uv0:OnClickCancel()
	end)
end

function slot0.OnClickOk(slot0)
	if slot0.info_.OkCallback then
		slot0.info_.OkCallback()
	end

	slot0:Back()
end

function slot0.OnClickCancel(slot0)
	if slot0.info_.CancelCallback then
		slot0.info_.CancelCallback()
	end

	slot0:Back()
end

function slot0.RemoveListeners(slot0)
	slot0.okBtn_.onClick:RemoveAllListeners()
	slot0.cancelBtn_.onClick:RemoveAllListeners()
	slot0.tipsBtn_.onClick:RemoveAllListeners()
end

function slot0.OnEnter(slot0)
	slot0.info_ = slot0.params_
	slot0.tipContent_.text = slot0.info_.content
end

function slot0.SetGaussionBg(slot0)
	manager.ui:SetUISeparateRender(true)
end

function slot0.Hide(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
