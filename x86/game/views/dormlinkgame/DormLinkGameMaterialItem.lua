slot0 = class("DormLinkGameMaterialItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.RefreshUI(slot0, slot1)
	slot0.itemID = slot1[1]
	slot0.iconImg_.sprite = ItemTools.getItemSprite(tonumber(ActivityLinkGameCellCfg[slot0.itemID].album_id))
	slot0.numText_.text = string.format("%d/%d", DormLinkGameData:GetDisposeMaterialNum(slot0.itemID), slot1[2])
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
