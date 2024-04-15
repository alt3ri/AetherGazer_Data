slot0 = class("WeaponServantSortModule", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_servant/HeroServantSortUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.OnExit(slot0)
end

function slot0.OnEnter(slot0)
end

function slot0.OnDispose(slot0)
	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
		uv0:OnBackBtnClick()
	end)
end

function slot0.OnBackBtnClick(slot0)
	slot0:Back()
end

return slot0
