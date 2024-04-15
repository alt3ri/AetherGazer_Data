slot1 = class("ShopFurnitureContentView", import("game.views.shop.contentViews.ShopContentViewWithPoster"))

function slot1.GetAssetPath()
	return "Widget/System/Shop/contentViews/furnitureView"
end

function slot1.InitUI(slot0)
	uv0.super.InitUI(slot0)

	slot0.scrollRect = slot0.listGo_:GetComponent("ScrollRectEx")
	slot0.listController = ControllerUtil.GetController(slot0.listGo_.transform, "empty")

	slot0:AddUIListener()
end

function slot1.GetPoster(slot0)
	return DormTools.GetShopStyleImage(slot0.shopId_)
end

function slot1.OnEnter(slot0)
	slot0:RegistEventListener(COMMON_FILTER_OK, handler(slot0, slot0.UpdateDormList))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	slot0:RemoveAllEventListener()
	DormRedPointTools:CloseAllSuitGoodRedPoint(slot0.shopId_)
end

function slot1.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot1.UpdateDormList(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(Filter_Group_Define.DORM_FURNITURE_TYPE.tags) do
		if CommonFilterData:HasIndexFlag(Filter_Root_Define.DORM_SHOP_Filter_List.filter_id, Filter_Group_Define.DORM_FURNITURE_TYPE.groupID, slot6) then
			slot1 = slot6

			break
		end
	end

	if slot1 == Filter_Tags_Define.FURNITURETYPEALL then
		slot0.selectedPos = nil
	else
		slot0.selectedPos = slot1 + DormConst.DORM_FURTYPE_OFFSET
	end

	slot0.textText_.text = CommonFilterCfg[slot1].name
end

function slot1.ResetFilter(slot0)
	slot0.selectedPos = nil
end

function slot1.AddUIListener(slot0)
	slot0.scrollRect.onValueChanged:AddListener(function (slot0)
		if uv0.lastpos then
			uv0.goTrs_.localPosition = Vector3(uv0.goTrs_.localPosition.x, uv0.goTrs_.localPosition.y + uv0.contentTrs_.localPosition.y - uv0.lastpos, 0)
		end

		uv0.lastpos = uv0.contentTrs_.localPosition.y
	end)
	slot0:AddBtnListener(slot0.btnBtn_, nil, function ()
		JumpTools.OpenPageByJump("dormFurnitureImageView", {
			shopID = uv0.shopId_
		})
	end)
	slot0:AddBtnListener(slot0.filterBtn_, nil, function ()
		JumpTools.OpenPageByJump("commonFilterView", {
			filterGroup = Filter_Root_Define.DORM_SHOP_Filter_List
		})
	end)
end

function slot1.IndexItem(slot0, slot1, slot2)
	uv0.super.IndexItem(slot0, slot1, slot2)
	slot0:BindSuitRedPoint(slot0.shopDataList_[slot1], slot2)
end

function slot1.BindSuitRedPoint(slot0, slot1, slot2)
	slot4 = getShopCfg(slot1.id).give_id

	if manager.redPoint:getTipBoolean(DormRedPointTools.FurnitureItemRedPoint(slot0.shopId_, slot1.id)) then
		manager.redPoint:SetRedPointIndependent(slot2.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot2.transform_, false)
	end
end

function slot1.OnItemClick(slot0, slot1)
	if DormSuitData:CheckUnlockSuit(getShopCfg(slot1.id, slot0.shopId_).give_id) then
		if slot2.limit_num <= slot1.buyTime then
			return
		end

		ShowMessageBox({
			title = GetTips("PROMPT"),
			content = GetTips("DORM_BUY_SAME_FURNITURE_SUIT"),
			OkCallback = function ()
				uv0:OnShopClick(uv1)
			end,
			CancelCallback = function ()
			end
		})
	else
		slot0:OnShopClick(slot1)

		if DormSuitData:CheckIsConfigSuit(slot3) then
			DormRedPointTools:CloseSingleSuitGoodRedPoint(slot0.shopId_, slot1.id)
		end
	end
end

return slot1
