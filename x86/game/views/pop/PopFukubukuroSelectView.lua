slot0 = class("PopFukubukuroSelectView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/Common/Pop/UIInquirepopup14"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.scrollHelper_ = LuaList.New(handler(slot0, slot0.indexItem), slot0.uiList_, CommonItemView)
	slot0.okBtnController_ = slot0.controllerEx_:GetController("btn")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.okBtn_, nil, function ()
		if uv0.selectIndex_ == 0 then
			ShowTips("LUCKILYBAG_NOT_SELECT")
		else
			uv0:Back()
			FukubukuroAction.QuseryUseItem(uv0.instance_id, uv0.selectIndex_)
		end
	end)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		JumpTools.Back()
	end)
	slot0:AddBtnListener(slot0.cancelBtn_, nil, function ()
		JumpTools.Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.instance_id = slot0.params_.instance_id

	slot0:SetSelectIndex(0)

	if FukubukuroData:GetFukubukuroByInstanceId(slot0.instance_id) then
		slot0.select_list = slot1.select_list

		slot0.scrollHelper_:StartScroll(#slot0.select_list)
	else
		slot0.scrollHelper_:StartScroll(0)
	end
end

function slot0.SetSelectIndex(slot0, slot1)
	slot0.selectIndex_ = slot1

	if slot0.selectIndex_ ~= 0 then
		slot0.tipText_.text = string.format(GetTips("TIP_SELECT"), ItemTools.getItemName(slot0.select_list[slot1].id))

		slot0.okBtnController_:SetSelectedState("state1")
	else
		slot0.tipText_.text = GetTips("SELECT_CURRENT")

		slot0.okBtnController_:SetSelectedState("state0")
	end
end

function slot0.Dispose(slot0)
	slot0.scrollHelper_:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot5 = clone(ItemTemplateData)
	slot5.id = slot0.select_list[slot1].id
	slot5.number = slot0.select_list[slot1].number
	slot5.selectStyle = slot1 == slot0.selectIndex_

	function slot5.clickFun()
		uv0:ItemClick(uv1)
	end

	slot2:SetData(slot5)
end

function slot0.ItemClick(slot0, slot1)
	slot0:SetSelectIndex(slot1)
	slot0.scrollHelper_:Refresh()
end

return slot0
