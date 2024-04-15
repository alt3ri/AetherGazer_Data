slot0 = class("DormVisitTemplateView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormCollectionSchemePopUI"
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

	slot0.curFurNumController = ControllerUtil.GetController(slot0.transform_, "curState")
	slot0.showListController = ControllerUtil.GetController(slot0.transform_, "pulldown")
	slot0.templateScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormVisitFurTemplateItem)
end

function slot0.OnEnter(slot0)
	slot0:RegisterEvents()

	slot0.type = BackHomeCfg[DormData:GetCurrectSceneID()].type

	if slot0.type == DormConst.BACKHOME_TYPE.VISITPUBLICDORM then
		slot0.type = DormConst.BACKHOME_TYPE.PublicDorm
	elseif slot0.type == DormConst.BACKHOME_TYPE.VISITPRIVATEDORM then
		slot0.type = DormConst.BACKHOME_TYPE.PrivateDorm
	end

	slot0.maxNum = 0

	if slot0.type == DormConst.BACKHOME_TYPE.PublicDorm then
		slot0.maxNum = DormConst.DORM_TEMPLATE_NUM_MAX
	else
		slot0.maxNum = DormConst.DORM_TEMPLATE_PRIVATE_NUM_MAX
	end

	slot0.showFlag = false

	slot0:UpdataView()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0.showListController:SetSelectedState("off")

	slot0.showFlag = false
	slot0.selTemplateID = nil
	slot0.selectedPos = nil
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.bgmaskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.confirmBtn_, nil, function ()
		slot1 = {
			layout_uid = DormVisitTools:GetLayoutID(),
			user_id = DormVisitTools:GetVisitUserID()
		}

		if uv0.selTemplateID >= 0 then
			ShowMessageBox({
				isTop = true,
				content = GetTips("DORM_MOULD_COVER"),
				OkCallback = function ()
					slot0 = DormData:GetCurrectSceneID()

					DormFurnitureTemplateData:SaveDormSceneTemplate(uv0.selTemplateID, BackHomeCfg[slot0].type, DormFurnitureTemplateData:GetDormTemplateInfo(uv0.selTemplateID):GetTemplateName(), slot0, uv0.selectedPos, uv1)
				end,
				CancelCallback = function ()
				end
			})
		else
			slot2 = DormData:GetCurrectSceneID()

			DormFurnitureTemplateData:SaveDormSceneTemplate(DormFurnitureTemplateData:GetCanUseTemplateID(), BackHomeCfg[slot2].type, string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), tostring(uv0.selectedPos)), slot2, uv0.selectedPos, slot1)
		end
	end)
	slot0:AddBtnListener(slot0.chooseBtn, nil, function ()
		if uv0.showFlag then
			uv0.showFlag = false

			uv0.showListController:SetSelectedState("off")
		else
			uv0.showFlag = true

			uv0.showListController:SetSelectedState("on")
			uv0:RefreshList()
		end
	end)
end

function slot0.UpdataView(slot0)
	slot1 = 0

	if not slot0.selectedPos then
		slot0.selectedPos = 1
		slot0.selTemplateID = DormFurnitureTemplateData:GetDormTemplateInfoByPosID(1, slot0.type) or -1
	end

	if slot0.selTemplateID > 0 then
		slot2 = DormFurnitureTemplateData:GetDormTemplateInfo(slot0.selTemplateID)
		slot1 = slot2:GetDormTemplateFurNumInfo()
		slot0.curTemplateName.text = slot2.name
	else
		slot0.curTemplateName.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), slot0.selectedPos)
	end

	slot0.curFurNum.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), slot1)

	if slot1 <= 0 then
		slot0.curFurNumController:SetSelectedState("false")
	else
		slot0.curFurNumController:SetSelectedState("true")
	end
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.templateData[slot1], slot0.selectedPos, slot1)
	slot2:ClickCallBack(function (slot0, slot1)
		uv0.selTemplateID = slot0
		uv0.selectedPos = slot1
		uv0.showFlag = false

		uv0.showListController:SetSelectedState("off")
		uv0:UpdataView()
	end)
end

function slot0.RefreshList(slot0)
	slot0.templateData = {}

	for slot4 = 1, slot0.maxNum do
		if DormFurnitureTemplateData:GetDormTemplateInfoByPosID(slot4, slot0.type) then
			table.insert(slot0.templateData, slot5)
		else
			table.insert(slot0.templateData, -1)
		end
	end

	slot0.templateScroll:StartScroll(#slot0.templateData)
end

function slot0.RegisterEvents(slot0)
	slot0:RegistEventListener(DORM_TEMPLATE_CHANGE, function ()
		JumpTools.Back()
	end)
end

function slot0.Dispose(slot0)
	if slot0.templateScroll then
		slot0.templateScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
