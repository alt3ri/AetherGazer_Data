slot0 = class("GuildFoundedManagerView", ReduxView)

function slot0.UIName(slot0)
	return "UI/ClubUI/CreateClubPanelTemplate"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.foundedViewList_ = {}
end

function slot0.OnTop(slot0)
	slot0:RefreshWinBar()
end

function slot0.OnEnter(slot0)
	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:OnEnter()
	end

	slot0:RefreshToggle()
end

function slot0.RefreshWinBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		CurrencyConst.CURRENCY_TYPE_DIAMOND,
		CurrencyConst.GetPlatformDiamondId()
	})
	manager.windowBar:SetBarCanAdd(CurrencyConst.CURRENCY_TYPE_DIAMOND, true)
	manager.windowBar:SetBarCanAdd(CurrencyConst.GetPlatformDiamondId(), true)
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back()
	end)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:OnExit()
	end
end

function slot0.OnUpdate(slot0)
	slot0:RefreshToggle()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	for slot4, slot5 in pairs(slot0.toggleList_) do
		slot5:Dispose()
	end

	slot0.toggleList_ = nil
	slot0.goButtonList_ = nil

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:Dispose()
	end

	slot0.foundedViewList_ = nil
end

function slot0.AddListeners(slot0)
end

function slot0.RefreshToggle(slot0)
	for slot4, slot5 in pairs(slot0.toggleList_) do
		slot5:RefreshSelectType(slot0.selectType_)
	end

	if not slot0.foundedViewList_[slot0.selectType_] then
		if slot0.selectType_ == GuildConst.FOUNDED_TYPE.RECOMMEND then
			slot0.foundedViewList_[slot0.selectType_] = GuildRecommendView.New(slot0.goRecommendPanel_)
		else
			slot0.foundedViewList_[slot0.selectType_] = GuildFoundedView.New(slot0.goFoundedPanel_)
		end
	end

	for slot4, slot5 in pairs(slot0.foundedViewList_) do
		slot5:Show(slot4 == slot0.selectType_)
	end
end

return slot0
