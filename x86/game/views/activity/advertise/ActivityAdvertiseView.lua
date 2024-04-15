slot0 = class("ActvitiyAdvertiseView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Activity/ActivityAdvertiseParentUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	slot0:CreateItem()
end

function slot0.OnExit(slot0)
	slot0:DestroyItem()
end

function slot0.CreateItem(slot0)
	slot0.itemView_ = ActivityAdvertiseItem.New(slot0.itemParent_)
end

function slot0.DestroyItem(slot0)
	slot0.itemView_:Dispose()

	slot0.itemView_ = nil
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		slot0 = 0

		if uv0.itemView_ and uv0.itemView_.cfgID_ then
			slot0 = ActivityAdvertiseCfg[uv0.itemView_.cfgID_] and slot1.activity_id
		end

		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 2,
			activity_id = slot0
		})

		if ActivityAdvertiseTools.NeedShowAdvertise() then
			uv0:DestroyItem()
			uv0:CreateItem()
		else
			uv0:Back()
		end
	end)
end

function slot0.Cacheable(slot0)
	return false
end

return slot0
