slot0 = class("SkinDrawInfoItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.commonItem_ = CommonItem.New(slot0.commonItemGo_)

	slot0.commonItem_:RegistCallBack(function (slot0)
		ShowPopItem(POP_ITEM, {
			uv0.id_
		})
	end)
end

function slot0.AddUIListeners(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.id_ = slot1

	slot0.commonItem_:RefreshData({
		id = slot1,
		number = slot2
	})
	slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.LONG)

	if ItemCfg[slot1].type == ItemConst.ITEM_TYPE.DYNAMIC_STICKER then
		slot0.commonItem_:ShowStar(false)
	else
		slot0.commonItem_:ShowStar(true)
	end
end

function slot0.SetBottomText(slot0, slot1)
	slot0.text_.text = slot1
end

function slot0.OnExit(slot0)
	slot0.commonItem_:OnExit()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.commonItem_:Dispose()
	slot0.super.Dispose(slot0)
end

return slot0
