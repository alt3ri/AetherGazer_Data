slot0 = class("DormTemplateView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormEditschemeUI"
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

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexTemplate), slot0.uilistUilist_, DormFurTemplateItem)
	slot0.templateID = nil
	slot0.choiceController = ControllerUtil.GetController(slot0.shareswitchTrs_, "choice")
	slot0.switchController = ControllerUtil.GetController(slot0.shareswitchTrs_, "switch")
end

function slot0.OnEnter(slot0)
	slot0.canPreview = slot0.params_.canPreview

	if slot0.canPreview == nil then
		slot0.canPreview = true
	end

	slot0.pos = slot0.params_.pos or slot0.pos
	slot0.params_.pos = nil

	slot0:RefreshDormFurTemplateList()
	slot0:RegisterEvents()

	slot0.switchFlag = false

	slot0:RefreshCanSaveView()
	slot0:RefreshCanSaveFlag()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListenerScale(slot0.infoBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			content = GetTips("DORM_TEMPLATE_GAME_HELP"),
			title = GetTips("DORM_TEMPLATE_GAME_TITLE")
		})
	end)

	slot4 = nil

	slot0:AddBtnListener(slot0.switchBtn, slot4, function ()
		uv0.switchFlag = not uv0.switchFlag

		uv0:RefreshCanSaveFlag()
	end)

	for slot4 = 1, 2 do
		slot0:AddToggleListener(slot0["label_" .. slot4 .. "Tgl_"], function (slot0)
			if slot0 then
				uv0:SelectSaveType(uv1)
			end
		end)
	end
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_TEMPLATE_CHANGE, function ()
		uv0:RefreshDormFurTemplateList()
	end)
	slot0:RegistEventListener(DOMR_RENAME_TEMPLATE_SUCCESS, function ()
		uv0:RefreshDormFurTemplateList()
	end)
	slot0:RegistEventListener(DOMR_SAVE_FLAG_CHANGE, function ()
		if DormFurnitureTemplateData:GetOtherCanSave() then
			uv0.saveText.text = GetTips("DORM_TEMPLATE_SHAREABLE")
		else
			uv0.saveText.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
		end

		ShowTips("DORM_SUCCESS_SET")
	end)
end

function slot0.indexTemplate(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.templateData[slot1], slot1, slot0.canPreview)
	slot2:RegisterUseTemplateCallBack(function (slot0)
		if not uv0.canPreview or slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		slot2 = DormFurnitureTemplateData:GetDormTemplateInfo(slot0)
		slot3, slot4 = DormFurnitureTemplateData:CheckFurNumSuitTemplate(slot0, DormData:GetCurrectSceneID())

		DormHeroTools.HideAllCharacter()

		if not slot3 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_NOT_ENOUGH"),
				OkCallback = function ()
					slot0, slot1 = DormFurnitureTemplateData:ReduceTemplateLackFurInfoS(uv0, uv1)

					DormFurnitureTools:GenFurListInCurRoom(slot0)
					DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot1)
					DormFurnitureTemplateData:ConfirmUseTemplateInRoom(uv0, uv2, uv3, {
						furInfoList = slot0,
						specialInfo = slot1
					})
					ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
					JumpTools.OpenPageByJump("/dorm")
					DormHeroTools:GenerateHeroWhenEnterScene()
				end,
				CancelCallback = function ()
				end
			})
		else
			if slot2 then
				DormFurnitureTools:GenFurListInCurRoom(slot2.furnitureInfoS)
				DormSpecialFurnitureTools:ChangeDormFloorOrWallData(slot2.specialFur)
				DormFurnitureTemplateData:ConfirmUseTemplateInRoom(slot0, slot1, slot3)
				ShowTips(GetTips("DORM_MOULD_SET_SUCCESS"))
				JumpTools.OpenPageByJump("/dorm")
			else
				print("未找到模板信息,id为" .. slot0)
			end

			DormHeroTools:GenerateHeroWhenEnterScene()
		end
	end)
	slot2:RegisterPreviewCallBack(function (slot0, slot1)
		if not uv0.canPreview then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_CANT_USE"))

			return
		end

		uv0.pos = slot1

		DormFurnitureTemplateData:PreviewDormSceneTemplate(slot0)
		JumpTools.OpenPageByJump("/dormSuitFurInfoView", {
			templateID = slot0
		})
	end)
	slot2:SaveTemplateCallBack(function (slot0, slot1)
		slot3 = DormitoryData:GetDormSceneData(DormData:GetCurrectSceneID())

		if slot1 then
			uv0.pos = slot1

			if slot0 > 0 then
				ShowMessageBox({
					isTop = true,
					content = GetTips("DORM_MOULD_COVER"),
					OkCallback = function ()
						DormFurnitureTemplateData:SaveDormSceneTemplate(uv1, BackHomeCfg[uv0].type, DormFurnitureTemplateData:GetDormTemplateInfo(uv1):GetTemplateName(), uv0, uv2)
					end,
					CancelCallback = function ()
					end
				})
			else
				DormFurnitureTemplateData:SaveDormSceneTemplate(DormFurnitureTemplateData:GetCanUseTemplateID(), BackHomeCfg[slot2].type, string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(slot1)), slot2, slot1)
			end
		end
	end)
	slot2:ReviseNameCallBack(function (slot0, slot1)
		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		uv0.pos = slot1

		JumpTools.OpenPageByJump("dormChangeTemplateNameView", {
			callBack = function (slot0)
				DormAction:ReviseFurTemplateName(uv0, slot0)
			end,
			template_ID = slot0,
			oldName = DormFurnitureTemplateData:GetDormTemplateInfo(slot0).name,
			showText = GetTips("DORM_MOULD_NAME_SET_TIPS")
		})
	end)
	slot2:DelTemplateCallBack(function (slot0, slot1)
		if slot0 < 0 then
			ShowTips(GetTips("DORM_MOULD_DATA_NULL"))

			return
		end

		ShowMessageBox({
			isTop = true,
			content = GetTips("DORM_DELETE_TEMPLATE"),
			OkCallback = function ()
				uv0.pos = uv1

				DormAction:DeleteFurTemplate(uv2)
			end,
			CancelCallback = function ()
			end
		})
	end)
end

function slot0.RefreshDormFurTemplateList(slot0)
	if BackHomeCfg[DormData:GetCurrectSceneID()].type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot2 = DormConst.BACKHOME_TYPE.PublicDorm
	elseif slot2 == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot2 = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	slot0.templateData = {}
	slot3 = nil

	for slot7 = 1, (slot2 ~= DormConst.BACKHOME_TYPE.PublicDorm or DormConst.DORM_TEMPLATE_NUM_MAX) and DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX do
		if DormFurnitureTemplateData:GetDormTemplateInfoByPosID(slot7, slot2) then
			table.insert(slot0.templateData, slot8)
		else
			table.insert(slot0.templateData, -1)
		end
	end

	slot0.scrollHelper_:StartScroll(#slot0.templateData)

	if slot0.pos then
		slot0.scrollHelper_:ScrollToIndex(slot0.pos, true, false)
	end
end

function slot0.RefreshCanSaveView(slot0)
	slot0.tgl1.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
	slot0.tgl2.text = GetTips("DORM_TEMPLATE_SHAREABLE")
end

function slot0.RefreshCanSaveFlag(slot0)
	if DormFurnitureTemplateData:GetOtherCanSave() then
		slot0.saveText.text = GetTips("DORM_TEMPLATE_SHAREABLE")
	else
		slot0.saveText.text = GetTips("DORM_TEMPLATE_CANNOT_SHAREABLE")
	end

	if slot0.switchFlag then
		slot0.switchController:SetSelectedState("on")

		if slot1 then
			slot0["label_" .. 2 .. "Tgl_"].isOn = true
		else
			slot0["label_" .. 1 .. "Tgl_"].isOn = true
		end
	else
		slot0.switchController:SetSelectedState("off")
	end
end

function slot0.SelectSaveType(slot0, slot1)
	if slot1 == 1 and DormFurnitureTemplateData:GetOtherCanSave() then
		DormAction.SetFurnitureTemplatCanSave(false)
	elseif slot1 == 2 and not slot2 then
		DormAction.SetFurnitureTemplatCanSave(true)
	end
end

function slot0.Dispose(slot0)
	if slot0.scrollHelper_ then
		slot0.scrollHelper_:Dispose()

		slot0.scrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
