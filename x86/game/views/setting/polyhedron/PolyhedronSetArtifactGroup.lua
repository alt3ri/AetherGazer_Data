slot0 = class("PolyhedronSetArtifactGroup", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.itemList = {}
end

function slot0.AddUIListener(slot0)
end

function slot0.RegistCallBack(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.itemList) do
		slot6:RegistCallBack(slot1)
	end
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.m_title.text = PolyhedronTools.GetPolyhedronArtifactSubTypeDes(slot1)
	slot0.group = slot2

	for slot6, slot7 in ipairs(slot0.group) do
		if not slot0.itemList[slot6] then
			slot0.itemList[slot6] = PolyhedronSetArtifactItem.New(slot0.m_item, slot0.m_content)
		end

		slot0.itemList[slot6]:SetActive(true)
		slot0.itemList[slot6]:SetData(slot7)
	end

	for slot7 = #slot0.group + 1, #slot0.itemList do
		slot0.itemList[slot7]:SetActive(false)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_content)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.itemList) do
		slot5:Dispose()
	end

	slot0.itemList = nil

	uv0.super.Dispose(slot0)
end

function slot0.RefreshContentHeight(slot0)
	slot1 = slot0.m_content:GetComponent("VerticalLayoutGroup").spacing
	slot4 = nil

	for slot8 = 1, slot0.m_content.childCount do
		slot2 = 0 + slot0.m_content:GetChild(slot8 - 1):GetSizeDeltaY(nil) + slot1
	end

	slot0.m_content:SetSizeDeltaY(slot2 - slot1)
end

function slot0.RefreshHeight(slot0)
	slot1 = slot0.transform_:GetComponent("VerticalLayoutGroup").spacing
	slot4 = nil

	for slot8 = 1, slot0.transform_.childCount do
		slot2 = 0 + slot0.transform_:GetChild(slot8 - 1):GetSizeDeltaY(nil) + slot1
	end

	slot0.transform_:SetSizeDeltaY(slot2 - slot1)
end

return slot0
