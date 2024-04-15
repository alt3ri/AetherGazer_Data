slot0 = class("DormLinkGameItemTips", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/XuHeng2ndUI/XH2ndLinkGameUI/XH2ndLGTips"
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

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.bgmaskBtn_, nil, function ()
		JumpTools:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.itemID = slot0.params_.itemID

	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	if ActivityLinkGameGoodsCfg[slot0.itemID] then
		slot0.textText_.text = slot1.goods_des
	end
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
