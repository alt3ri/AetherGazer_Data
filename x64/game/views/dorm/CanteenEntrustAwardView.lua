slot0 = class("CanteenEntrustAwardView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/canteen/EmptyDreamTaskToCompletePop"
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

	slot0.awardListScroll_ = LuaList.New(handler(slot0, slot0.indexAwardItem), slot0.awardviewuilistUilist_, CanteenEntrustAwardItem)
end

function slot0.AddUIListener(slot0)
	slot0.awardListScroll_:SetPageChangeHandler(handler(slot0, slot0.UpdataButton))
	slot0:AddBtnListener(slot0.leftbtnBtn_, nil, function ()
		uv0.index = uv0.index - 1

		uv0:UpdataButton(uv0.index)
		uv0.awardListScroll_:ScrollToIndex(uv0.index, true, false)
	end)
	slot0:AddBtnListener(slot0.rightbtnBtn_, nil, function ()
		uv0.index = uv0.index + 1

		uv0:UpdataButton(uv0.index)
		uv0.awardListScroll_:ScrollToIndex(uv0.index, true, false)
	end)
	slot0:AddBtnListener(slot0.okbtnBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.flag = slot0.params_.flag
	slot0.index = 1

	slot0:UpdataView()
end

function slot0.UpdataButton(slot0, slot1)
	slot0.index = slot1

	if slot1 == 1 then
		SetActive(slot0.leftbtnGo_, false)
	else
		SetActive(slot0.leftbtnGo_, true)
	end

	if slot1 == #slot0.awardList then
		SetActive(slot0.rightbtnGo_, false)
	else
		SetActive(slot0.rightbtnGo_, true)
	end
end

function slot0.UpdataView(slot0)
	slot0.awardList = CanteenEntrustData:GetEntrustFinishAwardList()

	slot0.awardListScroll_:StartScroll(#slot0.awardList)
	slot0:UpdataButton(slot0.index)
end

function slot0.indexAwardItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.awardList[slot1], slot0.flag)
end

function slot0.Dispose(slot0)
	if slot0.awardListScroll_ then
		slot0.awardListScroll_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
