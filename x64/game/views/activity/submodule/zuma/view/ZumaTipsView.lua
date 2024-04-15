slot0 = class("ZumaTipsView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_ZumaUI/NorseUI_3_0_ZumaTipsPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.selectTalentID = 0

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		if uv0.cancelCallback then
			uv0.cancelCallback()
		end
	end)
	slot0:AddBtnListener(slot0.btn_noBtn_, nil, function ()
		if uv0.cancelCallback then
			uv0.cancelCallback()
		end
	end)
	slot0:AddBtnListener(slot0.btn_yesBtn_, nil, function ()
		if uv0.sureCallback then
			uv0.sureCallback()
		end
	end)
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_
	slot0.sureCallback = slot1.sureCallback
	slot0.cancelCallback = slot1.cancelCallback
	slot0.descText_.text = slot1.textContent
	slot0.tittleText_.text = slot1.titleContent
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
