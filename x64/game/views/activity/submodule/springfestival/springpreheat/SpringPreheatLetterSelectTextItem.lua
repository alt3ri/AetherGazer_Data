slot0 = class("SpringPreheatLetterSelectTextItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selController = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.letterBtn_, nil, function ()
		if uv0.onClickHandler_ then
			uv0:onClickHandler_(uv0.textId)
		end
	end)
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.SetSelected(slot0, slot1)
	slot0.selected_ = slot1

	return slot0.selected_
end

function slot0.SetLetterTextId(slot0, slot1)
	slot0.textId = slot1
end

function slot0.RefreshUI(slot0)
	slot0.letterText_.text = GetTips(slot0.textId)

	slot0.selController:SetSelectedState(slot0.selected_ and "true" or "false")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
