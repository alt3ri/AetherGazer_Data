slot0 = class("NewServerTaskSwitchItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform
	slot0.taskType_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.clickHandler_ then
			uv0.clickHandler_(uv0.taskType_)
		end
	end)
end

function slot0.SetClickCallBack(slot0, slot1)
	slot0.clickHandler_ = slot1
end

function slot0.RefreshSelect(slot0, slot1)
	slot0.selectController_:SetSelectedState(tostring(slot0.taskType_ == slot1))
end

return slot0
