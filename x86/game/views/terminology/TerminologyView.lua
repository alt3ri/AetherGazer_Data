slot0 = class("TerminologyView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Terminology/TerminologyPopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.items_ = {}
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot1(slot0)
	slot1 = {}

	for slot5, slot6 in pairs(slot0) do
		if not table.indexof(slot1, slot6) then
			table.insert(slot1, slot6)
		end
	end

	return slot1
end

function slot0.OnEnter(slot0)
	slot0.idList_ = uv0(slot0.params_.terminologyIdList)

	slot0:RefreshUI()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.idList_[slot1])
end

function slot0.RefreshUI(slot0)
	slot1 = #slot0.idList_

	for slot5, slot6 in ipairs(slot0.items_) do
		SetActive(slot6.gameObject_, slot5 <= slot1)
	end

	for slot5 = 1, slot1 do
		if not slot0.items_[slot5] then
			slot7 = Object.Instantiate(slot0.templateGo_, slot0.contentTrans_)

			SetActive(slot7, true)

			slot0.items_[slot5] = TerminologyItem.New(slot7)
		end

		slot0:IndexItem(slot5, slot6)
	end
end

return slot0
