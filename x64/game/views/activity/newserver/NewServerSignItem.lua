slot0 = class("NewServerSignItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = slot0.controllerEx_:GetController("state")
	slot0.commonItem_ = CommonItemView.New(slot0.commonItemGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.callback_ then
			uv0.callback_(uv0.index_)
		end
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.descText_.text = string.format(GetTips("NEW_SERVER_SIGN_DAY"), slot1)

	if SignCfg[slot2] then
		if not slot0.itemData_ then
			slot0.itemData_ = clone(ItemTemplateData)

			function slot0.itemData_.clickFun(slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot0.itemData_.id = slot3.reward[1]
		slot0.itemData_.number = slot3.reward[2]

		slot0.commonItem_:SetData(slot0.itemData_)
	end

	slot0:Refresh()
end

function slot0.Refresh(slot0)
	slot2 = NewServerData:GetSignIndex()

	if NewServerData:IsSignReward(slot0.index_) then
		slot0.stateController_:SetSelectedIndex(2)
	elseif slot0.index_ <= slot2 then
		slot0.stateController_:SetSelectedIndex(1)
	else
		slot0.stateController_:SetSelectedIndex(0)
	end
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.OnSign(slot0)
	if not NewServerData:IsSignReward(slot0.index_) and slot0.index_ <= NewServerData:GetSignIndex() then
		slot0.commonItem_:GetData().highLight = true
	else
		slot1.highLight = false
	end

	slot0.commonItem_:SetData(slot1)
	slot0:Refresh()
end

function slot0.Dispose(slot0)
	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
