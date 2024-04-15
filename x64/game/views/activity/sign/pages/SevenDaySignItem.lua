slot0 = class("SevenDaySignItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.info_ = slot2

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.animator_ = slot0.receivedpanelGo_:GetComponent(typeof(Animator))

	if slot0.newItemGo_ then
		slot0.commonItem_ = CommonItemView.New(slot0.newItemGo_, true)
	else
		slot0.commonItem_ = CommonItem.New(slot0.commonitemGo_)

		slot0.commonItem_:RegistCallBack(function (slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
			OperationRecorder.Record(uv0.class.__cname, "signItem")
		end)
		slot0.commonItem_:ShowFloor(ItemConst.ITEM_FLOOR.LONG)
	end
end

function slot0.Refresh(slot0, slot1, slot2, slot3)
	slot4 = SignCfg[slot2]

	if slot0.newItemGo_ then
		slot5 = clone(ItemTemplateData)
		slot5.id = slot4.reward[1]
		slot5.number = slot4.reward[2]

		function slot5.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
			OperationRecorder.Record(uv0.class.__cname, "signItem")
		end

		slot0.commonItem_:SetData(slot5)
	else
		slot0.commonItem_:RefreshData(formatReward(slot4.reward))
	end

	slot5 = slot4.reward[1]

	if slot3 == ActivityConst.SIGN_STATE.NONE then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot6 == ActivityConst.SIGN_STATE.CAN_GET then
		SetActive(slot0.receivedpanelGo_, false)
	elseif slot6 == ActivityConst.SIGN_STATE.GETTED then
		SetActive(slot0.receivedpanelGo_, true)
	elseif slot6 == ActivityConst.SIGN_STATE.TOMORROW_GET then
		SetActive(slot0.receivedpanelGo_, false)
	end

	slot0.dayText_.text = string.format(GetTips("ACTIVITY_GREENHORN_TASK_STAGE"), slot1)

	SetActive(slot0.speciaBg_, slot1 == 7 or slot1 == 14)

	slot0.index = slot1
end

function slot0.StartPlayAnimator(slot0)
	slot0.timer_ = Timer.New(function ()
		SetActive(uv0.receivedpanelGo_, true)

		uv0.animator_.enabled = true

		manager.audio:PlayUIAudioByVoice("sign_in")

		if uv0.timer_ then
			uv0.timer_:Stop()

			uv0.timer_ = nil
		end
	end, 0.5, 1)

	slot0.timer_:Start()
end

function slot0.GetAnimator(slot0)
	return slot0.animator_
end

function slot0.Dispose(slot0)
	slot0.animator_ = nil

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.commonItem_:Dispose()

	slot0.commonItem_ = nil
	slot0.transform_ = nil
	slot0.gameObject_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
