slot0 = class("NewChessTipsManager")

function slot0.Ctor(slot0)
	slot0.gameObject_ = Object.Instantiate(Asset.Load("UI/NewWarChess/NewWarChessTipsManager"), manager.ui.canvas.transform)

	ComponentBinder.GetInstance():BindCfgUI(slot0, slot0.gameObject_)

	slot0.tipsItems_ = {}
	slot0.tipsDispose_ = handler(slot0, slot0.OnTipsDispose)
end

function slot0.CreateTips(slot0, slot1)
	for slot5, slot6 in pairs(slot0.tipsItems_) do
		if not slot6:GetIsShow() then
			slot6:SetData(slot1)
			slot6:SetIsShow(true)
			LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)

			return
		end
	end

	slot3 = NewChessTipsItem.New(GameObject.Instantiate(slot0.tipsGo_, slot0.contentTrans_))

	slot3:SetDisposeHandler(slot0.tipsDispose_)
	slot3:SetData(slot1)
	slot3:SetIsShow(true)
	table.insert(slot0.tipsItems_, slot3)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.OnTipsDispose(slot0, slot1)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.contentTrans_)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.tipsItems_) do
		slot5:Dispose()
	end

	slot0.tipsItems_ = {}
	slot0.tipsDispose_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
end

return slot0
