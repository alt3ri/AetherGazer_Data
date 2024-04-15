slot0 = class("FurnitureItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.startController = ControllerUtil.GetController(slot0.transform_, "itembglevel")
	slot0.selectController = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.interactController = ControllerUtil.GetController(slot0.transform_, "interact")
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.limitController = ControllerUtil.GetController(slot0.transform_, "upperlimit")
	slot0.furNumController = ControllerUtil.GetController(slot0.transform_, "furNum")
	slot0.screenController = ControllerUtil.GetController(slot0.transform_, "screening")
	slot0.infoController = ControllerUtil.GetController(slot0.transform_, "info")

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.onClickCom_ = slot0:FindCom("OnClickDownListener")

	slot0.onClickCom_.onValueChanged:AddListener(function ()
		if uv0.downFunc and not uv0.canClick then
			uv0.downFunc(uv0.id, uv0.index, uv0.furType, uv0.suitState)
		end
	end)
	slot0:AddBtnListener(slot0.clickBtn, nil, function ()
		if uv0.click and not uv0.canClick then
			uv0.click(uv0.id, uv0.index, uv0.furType, uv0.suitState, uv0.giftNum)
		end
	end)
	slot0:AddBtnListener(slot0.grayBtn, nil, function ()
		if uv0.grayBtnFunc then
			uv0.grayBtnFunc(uv0.id, uv0.index, uv0.furType, uv0.suitState, uv0.giftNum)
		end
	end)
	slot0:AddBtnListener(slot0.infoBtn, nil, function ()
		if uv0.itemInfoFunc then
			uv0.itemInfoFunc(uv0.id)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3, slot4, slot5, slot6)
	manager.redPoint:SetRedPointIndependent(slot0.transform_, false)

	if slot3 == DormEnum.FurItemType.Edit then
		slot0.id = slot1.furID
		slot0.furType = slot1.type

		slot0:RefreshFurInfo(slot1, slot2)
	elseif slot3 == DormEnum.FurItemType.Gift then
		slot0.id = slot1

		slot0:RefreshGiftInfo(slot1, slot2, slot3, slot4, slot5)
	elseif slot3 == DormEnum.FurItemType.SuitEdit then
		slot0.id = slot1.furID

		slot0:RefreshSuitInfo(slot1, slot2, slot6)
	elseif slot3 == DormEnum.FurItemType.SuitFurShow then
		slot0.id = slot1.furID

		slot0:RefreshSuitFurInfoList(slot1, slot2)
	elseif slot3 == DormEnum.FurItemType.StorageFurShow then
		slot0.id = slot1.furID

		slot0:RefreshStorageFurShow(slot1, slot2)
	elseif slot3 == DormEnum.FurItemType.TemplateShow then
		slot0.id = slot1.furID

		slot0:RefreshTemplateShow(slot1, slot2)
	end

	slot0.cfg = ItemCfg[slot0.id]

	if slot0.cfg then
		slot0.furName.text = ItemTools.getItemName(slot0.id)
		slot0.level = ItemCfg[slot0.id].rare
		slot0.iconImg_.sprite = ItemTools.getItemSprite(slot0.id)

		slot0.startController:SetSelectedState(slot0.level)

		slot0.index = slot5
	else
		print("家具" .. slot0.id .. "在item表内未找到")

		return
	end
end

function slot0.RefreshGiftInfo(slot0, slot1, slot2, slot3, slot4, slot5)
	if BackHomeFurniture[slot0.id].interact_max and BackHomeFurniture[slot0.id].interact_max > 0 then
		slot0.interactController:SetSelectedState("true")
	else
		slot0.interactController:SetSelectedState("false")
	end

	slot0.selectController:SetSelectedState("normal")
	slot0.stateController:SetSelectedState("gift")
	slot0.infoController:SetSelectedState("false")
	slot0.furNumController:SetSelectedState("one")

	slot0.comfortNum.text = BackHomeFurniture[slot0.id].dorm_exp or 0
	slot8 = DormData:GetHeroInfo(slot4)

	if not DormData:GetDormSceneData(DormRoomTools:GetDormIDViaArchive(slot4)).give_furnitures[slot0.id] then
		slot7.give_furnitures[slot0.id] = 0
	end

	slot9 = DormData:GetFurNumInfo(slot0.id)
	slot0.totalNum.text = slot9.num - slot9.give_num

	if slot8:GetCanGiftNum(slot0.id) <= 0 then
		slot0.limitController:SetSelectedState("gray")

		return
	else
		slot0.limitController:SetSelectedState("normal")
	end

	if slot2 then
		slot0.selID = slot2

		if slot0.id == slot0.selID then
			slot0.selectController:SetSelectedState("select")
			slot0.furNumController:SetSelectedState("two")

			slot0.placeNum.text = slot7.give_furnitures[slot0.id]
			slot0.total2Num.text = slot9.num - slot9.give_num
		else
			slot0.selectController:SetSelectedState("normal")
		end
	end
end

function slot0.RefreshFurInfo(slot0, slot1, slot2)
	if BackHomeFurniture[slot0.id].interact_max and BackHomeFurniture[slot0.id].interact_max > 0 then
		slot0.interactController:SetSelectedState("true")
	else
		slot0.interactController:SetSelectedState("false")
	end

	slot0.selectController:SetSelectedState("normal")
	slot0.infoController:SetSelectedState("false")
	slot0.stateController:SetSelectedState("edit")

	slot4 = DormData:GetCurrectSceneID()

	if DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot0.id) then
		slot0.furNumController:SetSelectedState("false")

		if slot1.type == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			slot0.screenController:SetSelectedState("CanPlace")
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			slot0.screenController:SetSelectedState("HadPlace")
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			slot0.screenController:SetSelectedState("OtherHadPlace")
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			slot0.screenController:SetSelectedState("NotPresented")
		end
	else
		slot0.furNumController:SetSelectedState("one")

		if slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.CanPlace then
			slot0.totalNum.text = DormFurEditStateData:GetCanUseFurNumInRoom(slot4, slot0.id)

			slot0.limitController:SetSelectedState("normal")
			slot0.screenController:SetSelectedState("CanPlace")
			slot0:ShowSelect(slot2)
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.OtherHadPlace then
			slot0.totalNum.text = DormFurnitureTools:GetRoomCanPlaceFurMaxNum(slot4, slot0.id) - DormFurEditStateData:GetCanUseFurNumInRoom(slot4, slot0.id) - DormRoomTools:GetHasPlaceFurInfoByRoom(slot4, slot0.id) - DormFurEditStateData:GetCacheFurNum(slot0.id)

			slot0.screenController:SetSelectedState("OtherHadPlace")
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.HadPlace then
			slot0.totalNum.text = DormRoomTools:GetHasPlaceFurInfoByRoom(slot4, slot0.id) + DormFurEditStateData:GetCacheFurNum(slot0.id)

			slot0.screenController:SetSelectedState("HadPlace")
		elseif slot3 == DormConst.DORM_FUR_EDITVIEW_TYPE.NotPresented then
			slot5 = DormData:GetFurNumInfo(slot0.id)

			if BackHomeCfg[slot4].type == DormConst.BACKHOME_TYPE.PublicDorm then
				slot0.totalNum.text = slot5.num - slot5.give_num
			elseif BackHomeCfg[slot4].type == DormConst.BACKHOME_TYPE.PrivateDorm then
				slot0.totalNum.text = DormData:GetHeroInfo(DormitoryData:GetArchiveIDViaRoomID(slot4)[1]):GetCanGiftNum(slot0.id)
			end

			slot0.screenController:SetSelectedState("NotPresented")
		end
	end
end

function slot0.RefreshSuitFurInfoList(slot0, slot1, slot2)
	if BackHomeFurniture[slot0.id].interact_max and BackHomeFurniture[slot0.id].interact_max > 0 then
		slot0.interactController:SetSelectedState("true")
	else
		slot0.interactController:SetSelectedState("false")
	end

	slot0.limitController:SetSelectedState("normal")
	slot0.stateController:SetSelectedState("edit")
	slot0.furNumController:SetSelectedState("two")
	slot0.infoController:SetSelectedState("false")

	slot6 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(DormData:GetCurrectSceneID(), slot0.id), DormSuitData:GetFurNeedNumBySuitID(slot1.suitID, slot0.id))

	slot0:ShowSelect(slot2)
	slot0.screenController:SetSelectedState("CanPlace")

	slot0.suitState = "enough"

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(slot0.id) then
		if slot6 < slot5 then
			slot0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(slot6))
		else
			slot0.placeNum.text = slot6
		end

		slot0.total2Num.text = tostring(slot5)

		if slot6 < slot5 then
			if BackHomeFurniture[slot0.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				slot8 = DormRoomTools:GetCanGiftFurMaxNum(slot3, slot0.id)

				if DormRoomTools:GetCanGiftNumByRoomIDAndFurID(slot3, slot0.id) > 0 then
					slot0.screenController:SetSelectedState("NotPresented")

					slot0.suitState = "canGift"
					slot0.giftNum = math.min(slot5 - slot6, slot7)
				else
					slot0.limitController:SetSelectedState("gray")

					slot0.suitState = "noEnough"
					slot0.giftNum = math.min(slot5 - slot6, slot8)
				end
			else
				slot0.limitController:SetSelectedState("gray")

				slot0.suitState = "noEnough"
				slot0.giftNum = slot5 - slot6
			end
		end
	else
		slot0.placeNum.text = tostring(slot5)
		slot0.total2Num.text = tostring(slot5)
	end
end

function slot0.RefreshSuitInfo(slot0, slot1, slot2, slot3)
	slot0.screenController:SetSelectedState("CanPlace")
	slot0.limitController:SetSelectedState("normal")
	slot0.stateController:SetSelectedState("edit")
	slot0.interactController:SetSelectedState("false")
	slot0.furNumController:SetSelectedState("two")

	slot4, slot5 = DormSuitData:CheckIsSuit(slot0.id)

	if slot5 == DormSuitTools.DORM_SUIT_TYPE.FULL_SET then
		slot0.infoController:SetSelectedState("false")
	else
		slot0.infoController:SetSelectedState("true")
	end

	if DormSuitData:GetTotalCanUseFurNumBySuitInRoom(slot0.id, DormData:GetCurrectSceneID()) < DormSuitData:GetSuitNeedTotalFurNumList(slot0.id) then
		slot0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(slot8))
	else
		slot0.placeNum.text = slot8
	end

	slot0.total2Num.text = tostring(slot7)

	if slot8 < slot7 then
		slot0.screenController:SetSelectedState("suitNoFull")
	end

	slot0:ShowSelect(slot2)

	slot9 = nil

	if slot3 == 1 then
		if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.PublicDorm then
			slot9 = string.format("%s_%s", RedPointConst.DORM_FULL_PUBLIC_SUIT, tostring(slot0.id))
		elseif slot11 == DormConst.BACKHOME_TYPE.PrivateDorm then
			slot9 = string.format("%s_%s", RedPointConst.DORM_FULL_PRIVATE_SUIT, tostring(slot0.id))
		end
	else
		slot9 = string.format("%s_%s", RedPointConst.DORM_PART_SUIT, tostring(slot0.id))
	end

	if manager.redPoint:getTipBoolean(slot9) then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.RefreshStorageFurShow(slot0, slot1, slot2)
	slot0.screenController:SetSelectedState("CanPlace")
	slot0.limitController:SetSelectedState("normal")
	slot0.stateController:SetSelectedState("edit")
	slot0.interactController:SetSelectedState("false")
	slot0.furNumController:SetSelectedState("one")
	slot0.infoController:SetSelectedState("false")

	slot0.totalNum.text = slot1.canStorageNum
end

function slot0.RefreshTemplateShow(slot0, slot1, slot2)
	if BackHomeFurniture[slot0.id].interact_max and BackHomeFurniture[slot0.id].interact_max > 0 then
		slot0.interactController:SetSelectedState("true")
	else
		slot0.interactController:SetSelectedState("false")
	end

	slot0.limitController:SetSelectedState("normal")
	slot0.stateController:SetSelectedState("edit")
	slot0.furNumController:SetSelectedState("two")
	slot0.infoController:SetSelectedState("false")

	slot5 = math.min(DormFurEditStateData:GetCanUseFurNumInRoom(DormData:GetCurrectSceneID(), slot0.id), slot1.needNum)

	slot0:ShowSelect(slot2)
	slot0.screenController:SetSelectedState("CanPlace")

	slot0.suitState = "enough"
	slot6 = DormData:GetCurrectSceneID()

	if not DormSpecialFurnitureTools:JudgeIsOriSpecialFur(slot0.id) then
		if slot5 < slot3 then
			slot0.placeNum.text = string.format("<color=#FA7577>%s</color>", tostring(slot5))
		else
			slot0.placeNum.text = slot5
		end

		slot0.total2Num.text = tostring(slot3)

		if slot5 < slot3 then
			if BackHomeFurniture[slot0.id].is_give == DormConst.BACKHOME_FUR_GIVE_TYPE.GIFT then
				if slot3 <= DormRoomTools:GetCanGiftNumByRoomIDAndFurID(slot6, slot0.id) + slot5 then
					slot0.screenController:SetSelectedState("NotPresented")

					slot0.suitState = "canGift"
					slot0.giftNum = slot3 - slot5
				else
					slot0.limitController:SetSelectedState("gray")

					slot0.suitState = "noEnough"
					slot0.giftNum = slot3 - slot5
				end
			else
				slot0.limitController:SetSelectedState("gray")

				slot0.suitState = "noEnough"
				slot0.giftNum = slot3 - slot5
			end
		end
	else
		slot0.placeNum.text = tostring(slot3)
		slot0.total2Num.text = tostring(slot3)
	end
end

function slot0.ShowSelect(slot0, slot1)
	if slot1 and not slot0.showSel then
		if slot0.id == slot1 then
			slot0.selectController:SetSelectedState("select")
		else
			slot0.selectController:SetSelectedState("normal")
		end
	else
		slot0.selectController:SetSelectedState("normal")
	end
end

function slot0.SetItemShow(slot0, slot1)
	slot0.canClick = slot1.canClick
	slot0.showSel = slot1.showSel
end

function slot0.OnPointerDown(slot0, slot1)
	slot0.downFunc = slot1
end

function slot0.OnClickBtn(slot0, slot1)
	slot0.click = slot1
end

function slot0.GrayCallBack(slot0, slot1)
	slot0.grayBtnFunc = slot1
end

function slot0.ItemInfoCallBack(slot0, slot1)
	slot0.itemInfoFunc = slot1
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.onClickCom_.onValueChanged:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

return slot0
