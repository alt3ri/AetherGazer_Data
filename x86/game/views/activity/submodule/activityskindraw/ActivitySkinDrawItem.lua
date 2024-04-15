slot0 = class("ActivitySkinDrawItem", ReduxView)

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

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		ShowPopItem(POP_ITEM, {
			uv0.itemID_
		})
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.id_ = slot2[1]
	slot0.iconID_ = slot2[2]
	slot0.activityID_ = slot1
	slot0.cfg_ = ActivityLimitedDrawPoolCfg[slot0.id_]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.itemID_ = slot0.cfg_.reward[1][1]
	slot0.icon_.sprite = ItemTools.getItemSprite(slot0.iconID_)
	slot0.data_ = ActivitySkinDrawData:GetDrawInfo(slot0.activityID_, slot0.id_)

	slot0.typeCon_:SetSelectedState((slot0.data_ and slot0.data_.num or slot0.cfg_.total) > 0 and "false" or "true")
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
