slot0 = class("AdminCatExploreFirstPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/ExploreUI/ExploCalculusGoUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBg_, nil, function ()
		uv0:Back()
	end)
end

function slot0.UpdateBar(slot0)
end

function slot0.UpdateView(slot0)
end

function slot0.OnEnter(slot0)
	slot0:UpdateView()
end

function slot0.OnExit(slot0)
end

function slot0.Hide(slot0)
	SetActive(slot0.gameObject_, false)
end

function slot0.Show(slot0)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot0
