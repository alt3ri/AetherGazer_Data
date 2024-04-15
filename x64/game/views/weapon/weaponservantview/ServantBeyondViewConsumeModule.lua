slot0 = class("ServantBeyondViewConsumeModule", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.BuildContext(slot0)
	slot0.controller = {
		comps = slot0.controllerComps_,
		state = {
			select = {
				False = "false",
				name = "select",
				True = "true"
			}
		}
	}
	slot0.staticVar = {
		costItem_ = CommonItemView.New(slot0.resModuleObj_),
		commonData = clone(ItemTemplateData)
	}
	slot0.data = {}
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:BuildContext()
	slot0:AddUIListener()
end

function slot0.RefreshData(slot0, slot1)
	if slot1 then
		SetActive(slot0.resModuleObj_, true)

		slot0.staticVar.commonData = CommonTools.SetCommonData(slot0.staticVar.costItem_, slot1, slot0.staticVar.commonData)
		slot0.resName_.text = ItemTools.getItemName(slot1.id)
	else
		SetActive(slot0.resModuleObj_, false)
	end
end

function slot0.Dispose(slot0)
	if slot0.staticVar.costItem_ then
		slot0.staticVar.costItem_:Dispose()

		slot0.staticVar.costItem_ = nil
	end

	slot0:RemoveAllListeners()
	uv0.super.Dispose(slot0)
end

function slot0.SetSelect(slot0, slot1)
	if slot1 then
		slot0:SwitchControllerState(slot0.controller.state.select.name, slot0.controller.state.select.True)
	else
		slot0:SwitchControllerState(slot0.controller.state.select.name, slot0.controller.state.select.False)
	end
end

function slot0.SwitchControllerState(slot0, slot1, slot2)
	if slot0.controller.comps:GetController(slot1) then
		slot4:SetSelectedState(slot2)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.cellBtn_, nil, function ()
		if uv0.data.onClick then
			slot0()
		end
	end)
end

function slot0.RegisteBtnListener(slot0, slot1)
	slot0.data.onClick = slot1
end

return slot0
