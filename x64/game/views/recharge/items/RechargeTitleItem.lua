slot0 = class("RechargeTitleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = ControllerUtil.GetController(slot0.gameObject_.transform, "select")
	slot0.selectLock = ControllerUtil.GetController(slot0.gameObject_.transform, "select_lock")
	slot0.upSelectLock = ControllerUtil.GetController(slot0.gameObject_.transform, "upselect_lock")
end

function slot0.SetData(slot0, slot1, slot2, slot3, slot4)
	slot0.data = slot1
	slot0.index = slot2
	slot0.callback = slot3
	slot0.shopId = slot4

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.clickBtn_, nil, function ()
		if uv0.callback then
			uv0.callback(uv0.index)
		end
	end)
end

function slot0.UpdateView(slot0)
	slot0.nameTxt1_.text = slot0.data.remark
	slot0.nameTxt2_.text = slot0.data.remark
	slot1 = ShopTools.IsPC() and ShopConst.PC_LOCK_SHOP[slot0.shopId] or not ShopTools.CheckShopIsUnLock(slot0.shopId)

	slot0.selectLock:SetSelectedState(slot1 and "on" or "off")
	slot0.upSelectLock:SetSelectedState(slot1 and "on" or "off")
end

return slot0
