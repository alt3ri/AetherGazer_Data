slot0 = class("HeroSurpassPreviewNodeItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.surpassItemList = {}

	for slot4 = 1, slot0.transform_.childCount do
		slot0.surpassItemList[slot4] = HeroSurpaasPreviewItem.New(slot0["messagebg" .. slot4 .. "Go_"], slot4 == 1)
	end
end

function slot0.SetClickCheckCallback(slot0, slot1)
	slot0.surpassItemList[1]:SetClickCheckCallback(slot1)
end

function slot0.RefreshUI(slot0, slot1)
	for slot5, slot6 in pairs(slot0.surpassItemList) do
		if slot1[slot5] then
			slot6:SetActive(true)
			slot6:RefreshUI(slot7)
		else
			slot6:SetActive(false)
		end
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.surpassItemList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
