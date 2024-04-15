slot0 = class("DrawServantNormalPool", DrawBasePool)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("Widget/System/Pool/TreasurePool"), slot1)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.poolId = slot2
	slot0.showId = slot3
	slot0.detailBtnList_ = {}
	slot0.btnNameList_ = {}

	slot0:Init()
end

function slot0.AddUIListener(slot0)
end

function slot0.SetActive(slot0, slot1)
	uv0.super.SetActive(slot0, slot1)
end

return slot0
