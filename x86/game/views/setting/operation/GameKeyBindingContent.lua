slot0 = class("GameKeyBindingContent", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()

	slot0.items_ = {}
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.templateItem_, false)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot0.layoutName_, slot0.groupData_.items[slot1], slot0.gamepadType_)
	slot2:RefreshUI()
	slot2:SetKeyChangedCallback(function (slot0, slot1)
		slot1.controlType = uv0.groupData_.controlType
		slot1.conflictGroup = uv0.groupData_.conflictGroup

		if uv0.onKeyChanged_ then
			uv0:onKeyChanged_(slot0, slot1)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.layoutName_ = slot1
	slot0.title_ = slot2
	slot0.groupData_ = slot3
	slot0.gamepadType_ = slot4
end

function slot0.SetKeyChangedCallback(slot0, slot1)
	slot0.onKeyChanged_ = slot1
end

function slot0.OnExit(slot0)
	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:OnExit()
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.items_) do
		slot5:Dispose()
	end

	slot0.super.Dispose(slot0)
end

function slot0.RefreshUI(slot0)
	SetActive(slot0.gameObject_, #slot0.groupData_.items ~= 0)

	if slot1 == 0 then
		return
	end

	for slot5, slot6 in ipairs(slot0.items_) do
		SetActive(slot6.gameObject_, slot5 <= slot1)
	end

	for slot5 = 1, slot1 do
		if not slot0.items_[slot5] then
			slot7 = Object.Instantiate(slot0.templateItem_, slot0.contentTrans_)

			SetActive(slot7, true)

			slot0.items_[slot5] = GameKeyBindingItem.New(slot7)
		end

		slot0:IndexItem(slot5, slot6)
	end
end

return slot0
