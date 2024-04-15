slot0 = class("M", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_4/JapanRegionMidautumnUI/MoonCakeBagUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.needAdaptRight_ = true

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tree_ = LuaTree.New(slot0.treeGo_)

	slot0.tree_:SetSelectedHandler(handler(slot0, slot0.OnGroupSelect))

	slot0.normalList_ = LuaList.New(handler(slot0, slot0.IndexNormalItem), slot0.normalListGo_, MoonCakeBagNormalItem)
	slot0.moonCakeList_ = LuaList.New(handler(slot0, slot0.IndexExtraItem), slot0.groupListGo_, MoonCakeBagGroupItem)
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.clickNormalItemHandler_ = handler(slot0, slot0.OnClickNormalItem)
end

function slot0.OnEnter(slot0)
	slot0.mainActivityID_ = slot0.params_.mainActivityID
	slot0.activityID_ = slot0.params_.activityID

	slot0.tree_:SelectGroup(1)
	slot0:BindRedPoint()
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	if slot0.curSelectNormalItemIndex_ then
		slot0.normalList_:GetItemList()[slot0.curSelectNormalItemIndex_]:SetData(slot0.normalIdList_[slot0.curSelectNormalItemIndex_], slot0.curSelectNormalItemIndex_)

		slot0.curSelectNormalItemIndex_ = nil
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	slot0.curGroupIndex = nil
	slot0.curSelectNormalItemIndex_ = nil

	slot0:UnBindRedPoint()
end

function slot0.Dispose(slot0)
	slot0.tree_:Dispose()

	slot0.tree_ = nil

	slot0.normalList_:Dispose()

	slot0.normalList_ = nil

	slot0.moonCakeList_:Dispose()

	slot0.moonCakeList_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.OnGroupSelect(slot0, slot1, slot2, slot3, slot4)
	if slot0.curGroupIndex == slot2 then
		return
	end

	slot0.curGroupIndex = slot2

	if slot2 == MoonCakeConst.BAG_TYPE.MOON_CAKE then
		slot0.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(slot0.activityID_)

		slot0.moonCakeList_:StartScroll(#slot0.moonCakeGroupList_)
		slot0.typeController_:SetSelectedState("extra")
	else
		if slot2 == MoonCakeConst.BAG_TYPE.FILLING then
			slot0.normalIdList_ = MoonCakeTools.GetFillingItemIdList(slot0.mainActivityID_)
		elseif slot2 == MoonCakeConst.BAG_TYPE.MATERIAL then
			slot0.normalIdList_ = MoonCakeTools.GetMaterialItemIdList(slot0.mainActivityID_)
		elseif slot2 == MoonCakeConst.BAG_TYPE.GIFT then
			slot0.normalIdList_ = MoonCakeTools.GetGiftItemIdList(slot0.activityID_)
		end

		slot0.normalList_:StartScroll(#slot0.normalIdList_)
		slot0.typeController_:SetSelectedState("normal")
	end
end

function slot0.IndexNormalItem(slot0, slot1, slot2)
	slot2:SetData(slot0.normalIdList_[slot1], slot1)
	slot2:SetClickHandler(slot0.clickNormalItemHandler_)
end

function slot0.IndexExtraItem(slot0, slot1, slot2)
	slot2:SetData(slot0.moonCakeGroupList_[slot1], slot0.activityID_)
end

function slot0.OnReCeiveCakeCollectReward(slot0)
	slot0.moonCakeGroupList_ = MoonCakeTools.GetSortedCakeGroupList(slot0.activityID_)

	slot0.moonCakeList_:StartScroll(#slot0.moonCakeGroupList_)
end

function slot0.OnClickNormalItem(slot0, slot1, slot2)
	if slot1.number > 0 then
		ShowPopItem(POP_OPERATE_ITEM, {
			slot1.id,
			slot1.number
		})
	else
		ShowPopItem(POP_ITEM, {
			slot1.id,
			slot1.number
		})
	end

	slot0.curSelectNormalItemIndex_ = slot2
end

function slot0.BindRedPoint(slot0)
	manager.redPoint:bindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0.activityID_))
end

function slot0.UnBindRedPoint(slot0)
	manager.redPoint:unbindUIandKey(slot0.tree_:GetGroupRedPointContainerById(1), string.format("%s_%s", RedPointConst.MOON_CAKE_COLLECT_TASK, slot0.activityID_))
end

return slot0
