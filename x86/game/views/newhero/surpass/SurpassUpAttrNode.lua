slot0 = class("SurpassUpAttrNode", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.attrList = {}

	for slot4 = 1, 3 do
		slot0.attrList[slot4] = SurpassUpAttrItem.New(slot0["attr" .. slot4 .. "Go_"])
	end
end

function slot0.RefreshUi(slot0, slot1, slot2)
	slot0.texttittleText_.text = GetTips("BASE_PROPERTY_UP")
	slot3 = slot1.params

	for slot7 = 1, 3 do
		slot0.attrList[slot7]:SetActive(false)
	end

	for slot7, slot8 in pairs(slot3) do
		slot9 = slot8[1]

		slot0.attrList[slot7]:RefreshUi(slot9, slot8[2], slot2[slot9])
	end
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attrList) do
		slot5:Dispose()

		slot5 = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
