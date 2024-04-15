slot0 = class("DormFurnitureImageView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Shop/contentViews/furnitureImageView"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.imageBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshUI(slot0)
	slot0.shopID = slot0.params_.shopID
	slot0.imageImg_.sprite = DormTools.GetShopStyleImage(slot0.shopID)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
