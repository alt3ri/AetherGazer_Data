slot0 = class("NorseSurpriseGiftChooseAgainPage", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Version/NorseUI_3_0/NorseUI_3_0_SurpriseGiftUI/NorseSurpriseGiftChooseAgainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btn_no, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.btn_yes, nil, function ()
		uv0:Back()
		uv0:Back()
		NorseSurpriseGiftReceiveAction.ChooseHeartList(242832, uv0.heartList)
	end)
end

function slot0.OnEnter(slot0)
	uv0.super.OnEnter(slot0)

	slot0.sortList = slot0.params_.sortList

	slot0:RefreshView()
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.sortList then
		slot0.sortList = nil
	end

	if slot0.heartList then
		slot0.heartList = nil
	end
end

function slot0.RefreshView(slot0)
	slot0.tipsTxt_.text = GetTips("PROMPT")
	slot4 = "ACTIVITY_OPTIONAL_RANDOM_WINDOW_TIPS_1"
	slot0.infoTxt_.text = GetTips(slot4)
	slot0.heartList = {}

	for slot4, slot5 in ipairs(slot0.sortList) do
		table.insert(slot0.heartList, slot5.id)
	end
end

return slot0
