slot0 = class("DormSuitRelievePopView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/DormRedactPopUI"
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
end

function slot0.OnEnter(slot0)
	slot0.suitEid = slot0.params_.suitEid
end

function slot0.OnExit(slot0)
	slot0.suitEid = nil
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.confirmBtn, nil, function ()
		if uv0.suitEid then
			DormSuitTools:RelieveSuit(uv0.suitEid)
			JumpTools.Back(2)
		end
	end)
end

return slot0
