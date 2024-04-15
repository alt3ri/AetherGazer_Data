slot0 = class("StageArchiveView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Operation/OperationDiaryUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.clueController_ = slot0.controllerEx_:GetController("verClue")
end

function slot0.OnEnter(slot0)
	slot1 = slot0.params_.archiveID

	if slot0.params_.isClue then
		slot0.clueController_:SetSelectedState("state1")
	else
		slot0.clueController_:SetSelectedState("state0")
	end

	slot2 = StageArchiveCfg[slot1]
	slot0.nameText_.text = formatText(slot2.name)
	slot0.archiveText_.text = formatText(slot2.desc)

	if slot0.iconImage_ then
		slot0.iconImage_.sprite = getSpriteWithoutAtlas(slot2.iconPath)
	end

	slot0.scrollView_.verticalNormalizedPosition = 1
end

function slot0.OnExit(slot0)
	if slot0.iconImage_ then
		slot0.iconImage_.sprite = nil
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

return slot0
