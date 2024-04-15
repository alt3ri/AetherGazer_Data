slot0 = class("SpringPreheatPrayBubbleView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.lockController_ = ControllerUtil.GetController(slot0.transform_, "locked")
	slot0.itemUiList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.listGo_, SpringPreheatPrayRewardItem)
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
end

function slot0.Dispose(slot0)
	slot0.itemUiList_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.AddListeners(slot0)
	if slot0.bgBtn_ then
		slot0:AddBtnListener(slot0.bgBtn_, nil, function ()
			uv0:OnClick(true, uv0.day_)
		end)
	end
end

function slot0.RefreshUI(slot0)
	slot0.itemUiList_:StartScroll(#slot0.itemIdList_)
	slot0:SwitchController(slot0:GetDayState())
	slot0:RefreshDayText()
end

function slot0.RefreshDayText(slot0, slot1)
	slot0.dayText_.text = slot1 or GetTips(string.format("SPRING_PREHEAT_DAY_%d", slot0.day_))
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetClickHandler(function (slot0)
		uv0:OnClick(false, uv0.day_, slot0, uv1)
	end)
	slot2:SwitchToGoSelect()
	slot2:SetData(slot0.itemIdList_[slot1])
end

function slot0.OnClick(slot0, slot1, slot2, slot3, slot4)
	if slot0.onClickHandler_ then
		slot0.onClickHandler_(slot1, slot2, slot3, slot4)
	end
end

function slot0.SetClickHandler(slot0, slot1)
	if slot1 then
		slot0.onClickHandler_ = slot1
	end
end

function slot0.RefreshItemUiList(slot0)
	slot0.itemUiList_:Refresh()
end

function slot0.UpdateItemIdList(slot0, slot1)
	if slot1 then
		slot0.itemIdList_ = slot1
	else
		slot0.itemIdList_ = slot0:GetPraySelectionList()
	end
end

function slot0.SwitchController(slot0, slot1)
	if not slot0.selectController_ or not slot0.lockController_ then
		return
	end

	if slot1 == 1 then
		slot0.selectController_:SetSelectedState("notready")
		slot0.lockController_:SetSelectedState("true")
	elseif slot1 == 2 then
		slot0.selectController_:SetSelectedState("notready")
		slot0.lockController_:SetSelectedState("false")
	elseif slot1 == 3 then
		slot0.selectController_:SetSelectedState("selecting")
	elseif slot1 == 4 then
		slot0.selectController_:SetSelectedState("selected")
	end
end

function slot0.SetData(slot0, slot1)
	slot0.day_ = slot1

	slot0:UpdateItemIdList()
end

function slot0.GetDayText(slot0)
	return slot0.dayText_.text
end

function slot0.GetDayState(slot0)
	return SpringPreheatData:GetDayState(slot0.day_)
end

function slot0.GetPraySelectionList(slot0)
	return SpringPreheatData:GetPraySelectionList(slot0.day_)
end

return slot0
