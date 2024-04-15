slot0 = class("DormVisitFurTemplateItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.chooseBtn, nil, function ()
		if uv0.clickCallBack then
			uv0.clickCallBack(uv0.templateID, uv0.pos)
		end
	end)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	slot0.templateID = slot1
	slot4 = 0

	if slot0.templateID >= 0 then
		slot5 = DormFurnitureTemplateData:GetDormTemplateInfo(slot1)
		slot0.name.text = slot5.name
		slot4 = slot5:GetDormTemplateFurNumInfo()
	else
		slot0.name.text = string.format(GetTips("DORM_MOULD_DEFAULT_NAME"), slot3)
	end

	slot0.num.text = string.format(GetTips("DORM_MOULD_FURNITURE_NUM"), slot4)
	slot0.pos = slot3

	if slot0.pos == slot2 then
		if slot4 <= 0 then
			slot0.stateController:SetSelectedState("select1_0")
		else
			slot0.stateController:SetSelectedState("select_1")
		end
	elseif slot4 <= 0 then
		slot0.stateController:SetSelectedState("normal_0")
	else
		slot0.stateController:SetSelectedState("normal_1")
	end
end

function slot0.ClickCallBack(slot0, slot1)
	if slot1 then
		slot0.clickCallBack = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
