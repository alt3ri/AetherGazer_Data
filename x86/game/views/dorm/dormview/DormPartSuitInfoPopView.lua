slot0 = class("DormPartSuitInfoPopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormFurnitureSuitInfoPopUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, FurnitureItem)
end

function slot0.OnEnter(slot0)
	slot0.suitID = slot0.params_.suitID

	slot0:RefreshView()
end

function slot0.OnTop(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Refresh()
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.getAllBtn_, nil, function ()
		JumpTools.OpenPageByJump("dormSuitGetFurListView", {
			furEidList = uv0.canStorageList,
			callBack = handler(uv0, function ()
				uv0:RefreshFurInfoList()
				uv0:RefreshCanRestorageState()
			end)
		})
	end)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.RefreshView(slot0)
	slot0:RefreshSuitInfo()
	slot0:RefreshCanRestorageState()
	slot0:RefreshFurInfoList()
end

function slot0.RefreshCanRestorageState(slot0)
	slot1, slot2 = slot0:CheckCanRecycleFur()
	slot0.canStorageFlag = slot1

	if not slot1 then
		slot0.canStorageList = nil
	else
		slot0.canStorageList = slot2
	end
end

function slot0.RefreshSuitInfo(slot0)
	if ItemCfg[slot0.suitID] then
		slot0.suitName.text = ItemTools.getItemName(slot0.suitID)
		slot0.furNum.text = DormSuitData:GetSuitNeedTotalFurNumList(slot0.suitID)

		for slot7, slot8 in ipairs(BackHomeSuitCfg[slot0.suitID].suit_num) do
			slot3 = 0 + BackHomeFurniture[slot8[1]].dorm_exp * slot8[2]
		end

		slot0.comfortNum.text = slot3
		slot0.suitImg.sprite = DormSuitTools:GetSuitHighDefinitionIcon(slot0.suitID)
	end
end

function slot0.RefreshFurInfoList(slot0)
	slot0.furInfoList = {}

	for slot5, slot6 in ipairs(DormSuitData:GetNeedUseFurNumInfoBySuitID(slot0.suitID)) do
		table.insert(slot0.furInfoList, {
			furID = slot6[1],
			suitID = slot0.suitID
		})
	end

	slot0.scrollHelper_:StartScroll(#slot0.furInfoList)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.furInfoList[slot1], nil, DormEnum.FurItemType.SuitFurShow, nil, slot1)
	slot2:OnClickBtn(function (slot0, slot1, slot2, slot3, slot4)
		slot5 = DormData:GetFurNumInfo(slot0)
		slot6 = 0

		if slot3 == "enough" then
			if slot5 then
				slot6 = slot5.num
			end

			ShowPopItem(POP_ITEM, {
				slot0,
				slot6
			})
		elseif slot3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = slot0,
				needNum = slot4,
				defaultNum = slot4
			})
		elseif slot3 == "noEnough" then
			for slot12, slot13 in ipairs(ShopListCfg.all) do
				if ShopListCfg[slot13].display_group == ShopListCfg[ShopConst.SHOP_ID.FURNITURE_SHOP].display_group then
					table.insert({}, slot13)
				end
			end

			slot10 = false
			slot11 = nil

			for slot15, slot16 in ipairs(getGoodListByGiveID(slot0)) do
				for slot20, slot21 in ipairs(slot7) do
					if ShopTools.IsGoodCanBuy(slot21, slot16) then
						slot10 = true
						slot11 = slot16

						break
					end
				end
			end

			if slot10 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = slot0,
					needNum = slot4,
					defaultNum = slot4
				})
			else
				ShowPopItem(POP_ITEM, {
					slot0,
					slot6
				})
			end
		end
	end)
	slot2:GrayCallBack(function (slot0, slot1, slot2, slot3, slot4)
		slot5 = DormData:GetFurNumInfo(slot0)
		slot6 = 0

		if slot3 == "enough" then
			if slot5 then
				slot6 = slot5.num
			end

			ShowPopItem(POP_ITEM, {
				slot0,
				slot6
			})
		elseif slot3 == "canGift" then
			JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
				state = "gift",
				furID = slot0,
				needNum = slot4,
				defaultNum = slot4
			})
		elseif slot3 == "noEnough" then
			for slot12, slot13 in ipairs(ShopListCfg.all) do
				if ShopListCfg[slot13].display_group == ShopListCfg[ShopConst.SHOP_ID.DORM_SHOP].display_group then
					table.insert({}, slot13)
				end
			end

			slot10 = false
			slot11 = nil

			for slot15, slot16 in ipairs(getGoodListByGiveID(slot0)) do
				for slot20, slot21 in ipairs(slot7) do
					if ShopTools.IsGoodCanBuy(slot21, slot16) then
						slot10 = true
						slot11 = slot16

						break
					end
				end
			end

			if slot10 then
				JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
					state = "buy",
					furID = slot0,
					needNum = slot4,
					defaultNum = slot4
				})
			else
				ShowPopItem(POP_ITEM, {
					slot0,
					slot6
				})
			end
		end
	end)
end

function slot0.CheckCanRecycleFur(slot0)
	slot2 = {}
	slot3 = DormData:GetCurrectSceneID()

	if DormSuitData:GetSuitFurInfo(slot0.suitID) then
		for slot9, slot10 in ipairs(slot1.suit_num) do
			slot11 = slot10[1]
			slot12 = DormSuitData:GetFurNeedNumBySuitID(slot0.suitID, slot11)
			slot14 = math.min(DormRoomTools:GetHasPlaceFurInfoByRoom(DormData:GetCurrectSceneID(), slot11) + DormFurEditStateData:GetCacheFurNum(slot11), slot12)

			if math.min(DormFurEditStateData:GetCanUseFurNumInRoom(slot3, slot11), slot12) < slot12 and slot14 > 0 then
				table.insert(slot2, {
					furID = slot11,
					num = math.min(slot12 - slot13, slot14)
				})
			end
		end
	end

	slot5 = false

	for slot9, slot10 in ipairs(slot2) do
		if DormLuaBridge.GetCanRestoreFur(slot10.furID, slot10.num).Length > 0 then
			slot5 = true
		end
	end

	return slot5, {
		[slot10.furID] = {},
		[slot10.furID] = slot11
	}
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
