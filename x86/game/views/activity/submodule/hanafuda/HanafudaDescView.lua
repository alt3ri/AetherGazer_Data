slot0 = class("HanafudaDescView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionKagutsuchiUI/JapanRegionHanafudaUI/JapanRegionHanafudaScorePopUI"
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

	slot0.pageController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "page")
	slot0.rulePageController_ = ControllerUtil.GetController(slot0.ruleTrs_, "description")
	slot0.uiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.combineList_, HanafudaCombineItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backBtn_, nil, function ()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.ruleBtn_, nil, function ()
		uv0.pageController_:SetSelectedState("1")
	end)
	slot0:AddBtnListener(slot0.combineBtn_, nil, function ()
		uv0.pageController_:SetSelectedState("2")
		uv0.uiList_:StartScroll(#uv0.combineCfgList_)
	end)
	slot0:AddBtnListener(slot0.nextBtn_, nil, function ()
		if uv0.descIndex == 4 then
			return
		end

		uv0.descIndex = uv0.descIndex + 1

		uv0:RefreshDesc()
	end)
	slot0:AddBtnListener(slot0.forwardBtn_, nil, function ()
		if uv0.descIndex == 1 then
			return
		end

		uv0.descIndex = uv0.descIndex - 1

		uv0:RefreshDesc()
	end)
end

function slot0.OnEnter(slot0)
	slot0.callback_ = slot0.params_.callback
	slot0.combineCfgList_ = HanafudaData:GetCombineList()
	slot0.descIndex = 1

	slot0:RefreshDesc()
	slot0:RefreshLiner()
end

function slot0.RefreshDesc(slot0)
	SetActive(slot0.forwardBtn_.gameObject, slot0.descIndex ~= 1)
	SetActive(slot0.nextBtn_.gameObject, slot0.descIndex ~= 4)
	slot0.rulePageController_:SetSelectedState(slot0.descIndex)
	slot0.selectItem_.transform:SetSiblingIndex(slot0.descIndex - 1)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.combineCfgList_[slot1])
end

function slot0.RefreshLiner(slot0)
	slot0:SetBarPosition(0)

	for slot7 = 1, slot0.sliderBg_.transform.childCount > 4 and slot1 or slot2 do
		if slot7 <= slot1 then
			if slot7 <= slot2 then
				SetActive(slot0.sliderBg_.transform:GetChild(slot7 - 1).gameObject, true)
			else
				SetActive(slot8.gameObject, false)
			end
		else
			SetActive(Object.Instantiate(slot0.barTemp_, slot0.sliderBg_.transform), true)
		end
	end
end

function slot0.SetBarPosition(slot0, slot1)
	slot0.selectItem_.transform:SetSiblingIndex(slot1)
end

function slot0.OnExit(slot0)
	if slot0.callback_ then
		slot0.callback_()
	end
end

function slot0.Dispose(slot0)
	if slot0.uiList_ then
		slot0.uiList_:Dispose()

		slot0.uiList_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
