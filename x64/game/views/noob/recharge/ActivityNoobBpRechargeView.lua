slot0 = class("ActivityNoobBpRechargeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:GetUIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.type_ = slot2

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.typeController_ = ControllerUtil.GetController(slot0.transform_, "type")
end

function slot0.GetUIName(slot0, slot1)
	if slot1 == 0 then
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI"
	else
		return "Widget/System/Activitynewbie/NewbieBpRechargeUI_old"
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.sourceBtn_, nil, function ()
		if TimeMgr.GetInstance():GetServerTime() < PassportData:GetStartTimestamp() then
			ShowTips("SYSTEM_LOCK")

			return
		end

		if PassportData:GetEndTimestamp() <= TimeMgr.GetInstance():GetServerTime() then
			ShowTips("NO_ACTIVE_BATTLEPASS")

			return
		end

		JumpTools.JumpToPage2(GameSetting.first_battle_pass_reward.value[2])
	end)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		ActivityNewbieTools.ReceiveRechargeReward(3, 0, function (slot0)
			uv0:RefreshStatus()
		end)
	end)
end

function slot0.SetData(slot0)
	slot0.rewardCfg_ = GameSetting.first_battle_pass_reward.value[1]

	if not slot0.commonItem_ then
		slot1 = clone(ItemTemplateData)
		slot1.id = slot0.rewardCfg_[1]
		slot1.number = slot0.rewardCfg_[2]

		function slot1.clickFun(slot0)
			ShowPopItem(POP_ITEM, uv0.rewardCfg_)
		end

		slot0.commonItem_ = CommonItemView.New(slot0.commonGo_)

		slot0.commonItem_:SetData(slot1)
	end

	slot0:RefreshStatus()

	if slot0.typeController_ then
		slot0.typeController_:SetSelectedIndex(slot0.type_)
	end

	ActivityNewbieTools.SetSelectBpRecharge()
end

function slot0.RefreshStatus(slot0)
	slot0.status_ = ActivityNewbieTools.GetBpRewardStatus()

	slot0.statusController_:SetSelectedIndex(slot0.status_)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

return slot0
