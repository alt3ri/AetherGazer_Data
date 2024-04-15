slot0 = class("DormSuitFurInfoView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormSuitPreviewUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
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
	slot0.templateID = slot0.params_.templateID

	slot0:RefreshView()
	slot0:RegisterEvents()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.useBtn_, nil, function ()
		if uv0.suitID then
			uv0:UseSuit()
		elseif uv0.templateID then
			uv0:UseTemplate()
		end

		uv0.params_.suitID = nil
		uv0.params_.templateID = nil
	end)
	slot0:AddBtnListenerScale(slot0.cancelBtn_, nil, function ()
		if uv0.suitID then
			DormSuitEditData:RecoverSceneBeforeEdit()
		elseif uv0.templateID then
			DormFurnitureTemplateData:CancelPreviewDormSceneTemplate(DormData:GetCurrectSceneID())
		end

		JumpTools.Back()

		uv0.params_.suitID = nil
		uv0.params_.templateID = nil
	end)
end

function slot0.UseSuit(slot0)
	if DormSuitData:CheckSuitCanUseInRoom(slot0.suitID, DormData:GetCurrectSceneID()) then
		slot3 = DormSuitData:GetSuitFurInfo(slot0.suitID)

		DormAction:SetFurListInMap(DormData:GetCurrectSceneID(), nil, {
			furInfoList = slot3.furList,
			specialInfo = slot3.specialFur
		})
		DormLuaBridge.ChangeCameraMode(0, true)
		DormFurEditStateData:ExitEditState()
		DormSuitEditData:ExitFullSuitEditMode()
		DormHeroTools:GenerateHeroWhenEnterScene()
		JumpTools.OpenPageByJump("/dorm")
		SDKTools.SendMessageToSDK("backhome_dorm_edit", {
			suit_list = {
				slot0.suitID
			}
		})
		ShowTips("DORM_SUIT_USE_SUCCEED")
	else
		ShowTips("DORM_SUIT_FURNTTURE_NUM_LACK")
	end
end

function slot0.UseTemplate(slot0)
	slot2, slot3 = DormFurnitureTemplateData:CheckFurNumSuitTemplate(slot0.templateID, DormData:GetCurrectSceneID())

	if not slot2 then
		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_MOULD_NOT_ENOUGH"),
			OkCallback = function ()
				slot0, slot1 = DormFurnitureTemplateData:ReduceTemplateLackFurInfoS(uv0.templateID, uv1)

				DormFurnitureTools:GenFurListInCurRoom(slot0)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot1)
				DormFurnitureTemplateData:ConfirmUseTemplateInRoom(uv0.templateID, uv2, uv3, {
					furInfoList = slot0,
					specialInfo = slot1
				})
				JumpTools.OpenPageByJump("/dorm")
				DormHeroTools:GenerateHeroWhenEnterScene()
				ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
			end,
			CancelCallback = function ()
			end
		})
	else
		DormFurnitureTemplateData:ConfirmUseTemplateInRoom(slot0.templateID, slot1, slot2)
		JumpTools.OpenPageByJump("/dorm")
		DormHeroTools:GenerateHeroWhenEnterScene()
		ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
	end
end

function slot0.RefreshView(slot0)
	slot0:RefreshFurInfoList()
end

function slot0.OnTop(slot0)
	slot0.scrollHelper_:Refresh()
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_REFRESH_GIFT_FUR_LIST, function (slot0)
		if uv0.selIndex then
			if uv0.suitID then
				uv0.scrollHelper_:GetItemByIndex(uv0.selIndex):RefreshUI(uv0.furInfoList[uv0.selIndex], nil, DormEnum.FurItemType.SuitFurShow, nil, uv0.selIndex)
			elseif uv0.templateID then
				slot1:RefreshUI(uv0.furInfoList[uv0.selIndex], nil, DormEnum.FurItemType.TemplateShow, nil, uv0.selIndex)
			end
		end
	end)
end

function slot0.RefreshFurInfoList(slot0)
	slot1 = DormData:GetCurrectSceneID()
	slot0.furInfoList = {}

	if slot0.suitID then
		for slot6, slot7 in ipairs(BackHomeSuitCfg[slot0.suitID].suit_num) do
			table.insert(slot0.furInfoList, {
				furID = slot7[1],
				suitID = slot0.suitID
			})
		end

		slot0.scrollHelper_:StartScroll(#slot0.furInfoList)

		slot0.suitName.text = ItemCfg[slot0.suitID].name or ""
	elseif slot0.templateID then
		slot4 = {}

		for slot8 = 0, DormFurnitureTemplateData:GetDormTemplateInfo(slot0.templateID).furnitureInfoS.Length - 1 do
			slot4[slot3[slot8].id] = slot4[slot3[slot8].id] or 0
			slot4[slot3[slot8].id] = slot4[slot3[slot8].id] + 1
		end

		for slot9, slot10 in pairs(slot2.specialFur) do
			slot4[slot10] = slot4[slot10] or 0
			slot4[slot10] = slot4[slot10] + 1
		end

		for slot9, slot10 in pairs(slot4) do
			table.insert(slot0.furInfoList, {
				furID = slot9,
				needNum = slot10
			})
		end

		slot0.scrollHelper_:StartScroll(#slot0.furInfoList)

		slot0.suitName.text = slot2:GetTemplateName() or ""
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	if slot0.suitID then
		slot2:RefreshUI(slot0.furInfoList[slot1], nil, DormEnum.FurItemType.SuitFurShow, nil, slot1)
	elseif slot0.templateID then
		slot2:RefreshUI(slot0.furInfoList[slot1], nil, DormEnum.FurItemType.TemplateShow, nil, slot1)
	end

	slot2:OnClickBtn(function (slot0, slot1, slot2, slot3, slot4)
		slot5 = DormData:GetFurNumInfo(slot0)
		uv0.selIndex = slot1
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
		uv0.selIndex = slot1

		JumpTools.OpenPageByJump("dormFurBuyAndGiftView", {
			state = "gift",
			furID = slot0,
			needNum = slot4,
			defaultNum = slot4
		})
	end)
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
