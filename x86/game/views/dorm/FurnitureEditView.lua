slot0 = class("FurnitureEditView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/FurnitureEditorUI"
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

	slot0.rotateController_ = ControllerUtil.GetController(slot0.transform_, "rotate")
	slot0.storageController_ = ControllerUtil.GetController(slot0.transform_, "storage")
	slot0.suitController = ControllerUtil.GetController(slot0.transform_, "suit")
	slot0.canResetController = ControllerUtil.GetController(slot0.transform_, "canReset")
	slot0.furDescController = ControllerUtil.GetController(slot0.transform_, "descState")
end

function slot0.OnEnter(slot0)
	DormFurnitureTools:SetEditFurFlag(true)

	slot0.roomID = DormData:GetCurrectSceneID()
	slot0.itemID = slot0.params_.itemId
	slot0.furEntityID = slot0.params_.furEntityID
	slot1 = DormFurnitureManager.GetInstance()

	if slot0.params_.type == "drag" then
		slot2, slot3 = DormSuitData:CheckIsSuit(slot0.itemID)

		if slot2 then
			slot4 = DormSuitTools:GenerateFurSuit(slot0.itemID)

			DormLuaBridge.ChangeFurnitureSuitState(slot4, DormFurnitureManager.FurnitureState.Editing, false)
			DormLuaBridge.AddFurnitureToWallDitherAlphaControl(slot4)
			DormLuaBridge.BeginDragFurniture(slot4)
			slot0:EnterSuitEditMode(slot4, false)
		elseif DormSpecialFurnitureTools:JudgeFurIsSpecialType(slot0.itemID) then
			DormSpecialFurnitureTools:ChangeDormSpeicalFur(slot0.itemID)
		else
			slot4 = slot1:Generate(slot0.itemID)

			DormLuaBridge.ChangeFurnitureState(slot4, DormFurnitureManager.FurnitureState.Editing)
			DormLuaBridge.AddFurnitureToWallDitherAlphaControl(slot4)
			DormLuaBridge.BeginDragFurniture(slot4)

			slot0.furEntityID = slot4
			slot0.originalSelFurnitureEID = slot4

			slot0:HightlightAllFurnitureInSuit(true)
		end
	elseif slot0.params_.type == "edit" then
		slot0.originalSelFurnitureEID = slot0.furEntityID

		slot0:HightlightAllFurnitureInSuit(true)
	end

	slot0:RefreshFurInfo()
end

function slot0.OnTop(slot0)
	slot0:RegisterEvents()
end

function slot0.EnterSuitEditMode(slot0, slot1, slot2)
	if DormLuaBridge.CheckSuitEditModeAvailabel(slot1) then
		DormLuaBridge.EnterSuitEditMode(slot1, slot2)

		return true
	end

	return false
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_ENTER_SUIT_EDIT_MODE, function (slot0, slot1, slot2)
		uv0:HightlightAllFurnitureInSuit(false)

		uv0.itemID = slot0
		uv0.originalSelFurnitureEID = uv0.furEntityID
		uv0.furEntityID = slot1
		uv0.suitOriID = slot2
		uv0.params_.furSuitEid = nil

		uv0:RefreshFurInfo()
	end)
	slot0:RegistEventListener(DORM_EXIT_SUIT_EDIT_MODE, function (slot0)
		uv0.furEntityID = nil
	end)
end

function slot0.RefreshFurInfo(slot0)
	slot1 = ItemCfg[slot0.itemID]
	slot2, slot3 = DormSuitData:CheckIsSuit(slot0.itemID)

	if slot2 then
		slot0.furDescController:SetSelectedState("suit")
	else
		slot0.furDescController:SetSelectedState("single")

		if slot1 then
			slot0.furnameText_.text = ItemTools.getItemName(slot0.itemID)
		end
	end

	slot0:ShowCanUseButton()
end

function slot1(slot0, slot1, slot2)
	slot3, slot4 = DormLuaBridge.CheckFurnitureBelongSuit(slot0, nil)

	for slot8, slot9 in pairs(DormFurnitureManager.GetInstance():GetAllFurniture()) do
		if slot0 ~= slot9 then
			slot10, slot11 = DormLuaBridge.CheckFurnitureBelongSuit(slot9, nil)

			if slot3 then
				if slot10 and slot4 == slot11 then
					Dorm.DormEntityManager.SetHighlighted(slot9, slot1, slot1 and (slot2 or DormEnum.HighlightLayer.Suit) or DormEnum.HighlightLayer.Available)
				end
			else
				Dorm.DormEntityManager.SetHighlighted(slot9, false)
			end
		end
	end
end

function slot0.OnExit(slot0)
	slot0:HightlightAllFurnitureInSuit(false)

	slot0.params_.type = nil
	slot0.suitOriID = nil
	slot0.cacheCustomFur = nil
	slot0.originalSelFurnitureEID = nil

	DormLuaBridge.ClearEditingFurniture()
	slot0:RemoveAllEventListener()
end

function slot0.HightlightAllFurnitureInSuit(slot0, slot1, slot2)
	if slot0.originalSelFurnitureEID then
		uv0(slot0.originalSelFurnitureEID, slot1, slot2)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.cancelBtn_, nil, function ()
		if DormSpecialFurnitureTools:JudgeFurIsSpecialType(uv0.itemID) then
			DormSpecialFurnitureTools:ChangeDormSpeicalFur(DormFurEditStateData:GetCacheWallAndFloorInfo(BackHomeFurniture[uv0.itemID].type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(DormData:GetCurrectSceneID(), slot0.type))
		else
			slot0, slot1 = DormSuitData:CheckIsSuit(uv0.itemID)
			slot2, slot3 = nil

			if slot0 then
				slot2, slot3 = DormLuaBridge.CancelSuitChange(nil)
			else
				slot2, slot3 = DormLuaBridge.CancelChange(nil)
			end

			if slot2 then
				DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(slot3)

				if slot0 then
					uv0:RemoveFurnitureSuit(slot3)
				else
					DormUtils.GetEntityData(slot3).noOccupy = true

					uv0:RemoveFurniture(slot3)
				end
			elseif uv0.params_.type == "edit" and not slot0 and uv0.itemID then
				DormLuaBridge.RecoverRoomFurnitureOccupyByLua(uv0.furEntityID, BackHomeFurniture[uv0.itemID].title[1], BackHomeFurniture[uv0.itemID].title[2], BackHomeFurniture[uv0.itemID].title[3])
			end
		end

		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.rotateBtn_, nil, function ()
		slot0, slot1 = DormSuitData:CheckIsSuit(uv0.itemID)

		if slot0 then
			DormLuaBridge.RotateSuitFurniture()
		else
			DormLuaBridge.RotateFurniture()
		end
	end)
	slot0:AddBtnListenerScale(slot0.saveBtn_, nil, function ()
		if not uv0:CheckFurOccurpy() then
			ShowTips(GetTips("DORM_FUR_VOLUME_MAX"))

			return
		end

		if not DormSpecialFurnitureTools:JudgeFurIsSpecialType(uv0.itemID) then
			slot0, slot1 = DormSuitData:CheckIsSuit(uv0.itemID)
			slot2 = nil

			if (not slot0 or DormLuaBridge.SaveSuitChange()) and DormLuaBridge.SaveChange() then
				if uv0.params_.type == "drag" then
					if slot0 then
						DormFurEditStateData:ReveseFurSuitNumInEidtRoom(uv0.itemID, 1)
					else
						DormFurEditStateData:ReviseFurNumInEditRoom(uv0.itemID, 1)
					end
				end

				JumpTools.Back()
			else
				ShowTips("DORM_FURNITURE_CANNOT_SET")
			end
		else
			if uv0.params_.type == "drag" then
				DormFurEditStateData:ReviseFurNumInEditRoom(uv0.itemID, 1)
				DormFurEditStateData:ReviseFurNumInEditRoom(DormFurEditStateData:GetCacheWallAndFloorInfo(BackHomeFurniture[uv0.itemID].type) or DormSpecialFurnitureTools:GetSpecialFurIDByRoom(uv0.roomID, slot0.type), -1)
			end

			JumpTools.Back()
		end
	end)
	slot0:AddBtnListenerScale(slot0.storageBtn_, nil, function ()
		slot0, slot1 = nil
		slot2, slot3 = DormSuitData:CheckIsSuit(uv0.itemID)

		if not slot2 and uv0.params_.furSuitEid then
			ShowMessageBox({
				content = GetTips("DORM_STORAGE_CANT_SUIT"),
				OkCallback = function ()
					uv0 = DormLuaBridge.StorageFurniture()

					DormSuitTools:RelieveSuit(uv1.params_.furSuitEid)

					if uv0 ~= Dorm.DormEntityManager.INVALID_ENTITY_ID then
						DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(uv0)

						DormUtils.GetEntityData(uv0).noOccupy = true

						uv1:RemoveFurniture(uv0)
					end

					if uv1.params_.type == "edit" then
						DormFurEditStateData:ReviseFurNumInEditRoom(uv1.itemID, -1)
					end

					uv1.params_.furSuitEid = nil

					JumpTools.Back()
				end,
				CancelCallback = function ()
				end
			})
		elseif slot2 then
			ShowMessageBox({
				content = GetTips("DORM_STORAGE_SUIT"),
				OkCallback = function ()
					uv0 = DormLuaBridge.StorageSuitFurniture(nil)

					uv1:RemoveFurnitureSuit(uv0, uv1.params_.type == "edit")
					JumpTools.Back()
				end,
				CancelCallback = function ()
				end
			})
		else
			if DormLuaBridge.StorageFurniture() >= 0 then
				DormLuaBridge.RemoveFurnitureFromWallDitherAlphaControl(slot0)

				DormUtils.GetEntityData(slot0).noOccupy = true

				uv0:RemoveFurniture(slot0)
			end

			if uv0.params_.type == "edit" then
				DormFurEditStateData:ReviseFurNumInEditRoom(uv0.itemID, -1)

				uv0.cacheCustomFur = uv0.itemID
			end

			JumpTools.Back()
		end
	end)
	slot0:AddBtnListener(slot0.infoBtn_, nil, function ()
		if uv0.itemID and uv0.itemID > 0 and ItemCfg[uv0.itemID] then
			ShowPopItem(POP_ITEM, {
				uv0.itemID
			})
		end
	end)
	slot0:AddBtnListener(slot0.enterSuit, nil, function ()
		if uv0:EnterSuitEditMode(uv0.furEntityID, true) then
			uv0:HightlightAllFurnitureInSuit(true, DormEnum.HighlightLayer.Available)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
	slot0:AddBtnListener(slot0.relievesuitBtn_, nil, function ()
		if uv0.furEntityID then
			if DormLuaBridge.GetSuitOrFurnitureCanPlace(uv0.furEntityID) then
				JumpTools.OpenPageByJump("dormSuitRelievePopView", {
					suitEid = uv0.furEntityID
				})
			else
				ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
			end
		end
	end)
	slot0:AddBtnListener(slot0.resetsuitBtn_, nil, function ()
		ShowMessageBox({
			content = GetTips("DORM_SUTI_RESET"),
			OkCallback = function ()
				DormSuitEditData:ResetSuitPosition(uv0.furEntityID, uv0.itemID)
			end,
			CancelCallback = function ()
			end
		})
	end)
	slot0:AddBtnListener(slot0.customsuitBtn_, nil, function ()
		if DormLuaBridge.CheckSuitEditModeAvailabel(uv0.furEntityID) then
			DormLuaBridge.EnterCustomeEditMode(uv0.furEntityID)
		else
			ShowTips("DORM_CANT_ENTER_SUIT_EDIT")
		end
	end)
end

function slot0.RemoveFurniture(slot0, slot1)
	if slot0.originalSelFurnitureEID == slot1 then
		slot0:HightlightAllFurnitureInSuit(false)

		slot0.originalSelFurnitureEID = nil
	end

	DormFurnitureManager.GetInstance().FindAndRemove(slot1)
end

function slot0.RemoveFurnitureSuit(slot0, slot1, slot2)
	if slot0.originalSelFurnitureEID then
		slot3, slot4 = DormLuaBridge.CheckFurnitureBelongSuit(slot0.originalSelFurnitureEID, nil)

		if slot4 == slot1 then
			slot0:HightlightAllFurnitureInSuit(false)

			slot0.originalSelFurnitureEID = nil
		end
	end

	DormSuitTools:DestoryFurSuitObject(slot1, true, slot2)
end

function slot0.CheckFurOccurpy(slot0)
	slot1 = DormRoomTools:GetDormFurOccupy(slot0.roomID)
	slot3 = 0

	if BackHomeCfg[slot0.roomID].type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot3 = GameDisplayCfg.lobby_volume_max.value[1]
	elseif slot2 == DormConst.BACKHOME_TYPE.PrivateDorm then
		slot3 = GameDisplayCfg.dorm_volume_max.value[1]
	end

	if slot3 < slot1 then
		return false
	end

	return true
end

function slot0.ShowCanUseButton(slot0)
	slot1, slot2 = DormSuitData:CheckIsSuit(slot0.itemID)

	slot0.canResetController:SetSelectedState("false")

	if slot1 then
		if slot2 == DormSuitTools.DORM_SUIT_TYPE.PART_SET then
			if slot0.params_.type == "drag" then
				slot0.suitController:SetSelectedState("false")
			else
				slot0.suitController:SetSelectedState("partSuit")
			end
		else
			slot0.suitController:SetSelectedState("custom")
		end

		if slot0.suitOriID and slot0.suitOriID ~= 0 then
			slot0.canResetController:SetSelectedState("true")
		else
			slot0.canResetController:SetSelectedState("false")
		end

		slot0.storageController_:SetSelectedState("true")
		slot0.rotateController_:SetSelectedState("true")
	else
		slot5 = true

		for slot9, slot10 in ipairs(BackHomeFurniture[slot0.itemID].is_rotate) do
			if BackHomeCfg[slot0.roomID].type == slot10 then
				slot0.rotateController_:SetSelectedState("false")

				slot5 = false

				break
			end
		end

		if slot5 then
			slot0.rotateController_:SetSelectedState("true")
		end

		slot7 = true

		for slot11, slot12 in ipairs(BackHomeFurniture[slot0.itemID].is_storage) do
			if slot3 == slot12 then
				slot0.storageController_:SetSelectedState("false")

				slot7 = false

				break
			end
		end

		if slot7 then
			slot0.storageController_:SetSelectedState("true")
		end

		if slot0.params_.type == "edit" then
			if slot0.params_.furSuitEid then
				slot0.suitController:SetSelectedState("true")
			elseif slot0:CheckFurCanEnterCustomeSuitMode(slot0.itemID) then
				slot0.suitController:SetSelectedState("establish")
			else
				slot0.suitController:SetSelectedState("false")
			end
		else
			slot0.suitController:SetSelectedState("false")
		end
	end
end

function slot0.CheckFurCanEnterCustomeSuitMode(slot0, slot1)
	if BackHomeFurniture[slot1] and slot2.display_type == 0 then
		return true
	end

	return false
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
