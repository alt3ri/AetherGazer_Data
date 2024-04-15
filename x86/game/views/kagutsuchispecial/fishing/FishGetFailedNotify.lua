slot0 = class("FishGetFailedNotify", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionFishingUI/JapanRegionFishingLosePopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddBtnListener(slot0.okBtn_, nil, JumpTools.Back)
end

function slot0.OnEnter(slot0)
end

return slot0
