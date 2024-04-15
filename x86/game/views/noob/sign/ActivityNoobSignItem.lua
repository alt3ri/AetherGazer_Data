slot0 = class("ActivityNoobSignItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:BindCfgUI()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "conName")

	slot0:AddListeners()

	slot0.refreshHandler_ = handler(slot0, slot0.ZeroTimeRefresh)

	manager.notify:RegistListener(ZERO_REFRESH, slot0.refreshHandler_)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		uv0:OnSign()
	end)
end

function slot0.OnSign(slot0)
	if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), slot0.id_) then
		ActivityNoobAction.NoobSignIn(function (slot0)
			if isSuccess(slot0.result) then
				ActivityNoobData:SignIn()
				getReward2(slot0.reward_list)
				uv0.controller_:SetSelectedState("2")
				manager.notify:CallUpdateFunc(NOOB_SIGN)
			else
				ShowTips(slot0.result)
			end
		end)
	end
end

function slot0.ZeroTimeRefresh(slot0)
	slot0:RefreshUI(slot0.id_, slot0.pageIndex_, slot0.index_)
end

function slot0.RefreshUI(slot0, slot1, slot2, slot3)
	if slot0.id_ ~= slot1 then
		slot4 = SignCfg[slot1].reward
		slot0.itemData_ = clone(ItemTemplateData)
		slot0.itemData_.id = slot4[1]
		slot0.itemData_.number = slot4[2]

		function slot0.itemData_.clickFun(slot0)
			if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == table.keyof(ActivityNewbieTools.GetSignCfg(), uv0) then
				uv1:OnSign()
			else
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot0.id_ = slot1
	end

	if not slot0.rewardGo_ then
		slot0.rewardGo_ = CommonItemView.New(slot0.itemGo_)
	end

	slot0.rewardGo_:SetData(slot0.itemData_)

	slot4 = (slot2 - 1) * 7 + slot3
	slot0.index_ = slot3
	slot0.pageIndex_ = slot2
	slot0.textDay_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), slot4)

	if slot4 < 10 then
		slot0.textDat2_.text = "0" .. slot4
	else
		slot0.textDat2_.text = slot4
	end

	if slot4 <= ActivityNoobData:GetSignDay() then
		slot0.controller_:SetSelectedState("2")
	else
		slot0.controller_:SetSelectedState("0")
	end

	if ActivityNoobData:GetSignTimestamp() < manager.time:GetTodayFreshTime() and ActivityNoobData:GetSignDay() + 1 == slot4 then
		slot0.controller_:SetSelectedState("1")
	end
end

function slot0.Dispose(slot0)
	manager.notify:RemoveListener(ZERO_REFRESH, slot0.refreshHandler_)

	slot0.refreshHandler_ = nil

	if slot0.rewardGo_ then
		slot0.rewardGo_:Dispose()

		slot0.rewardGo_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
