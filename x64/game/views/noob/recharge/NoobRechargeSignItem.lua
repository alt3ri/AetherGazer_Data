slot0 = class("ActivityNoobUpgradeView", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.rewardList_ = {}

	SetActive(slot0.gameObject_, true)
end

function slot0.AddListeners(slot0)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	for slot4, slot5 in ipairs(slot0.rewardList_) do
		slot5:Dispose()
	end

	slot0.rewardList_ = nil
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot6 = GetTips("ACTIVITY_GREENHORN_TASK_STAGE")
	slot7 = slot1
	slot0.textDay_.text = string.format(slot6, slot7)
	slot0.textDat2_.text = "0" .. slot1
	slot0.rewardCfg_ = {
		slot2[2],
		slot2[3]
	}

	for slot6, slot7 in ipairs(slot0.rewardCfg_) do
		if not slot0.rewardList_[slot6] then
			slot8 = clone(ItemTemplateData)
			slot8.id = slot7[1]
			slot8.number = slot7[2]

			function slot8.clickFun(slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.rewardList_[slot6] = CommonItemPool.New(slot0.rewardPanel_, slot8, true)
		end
	end

	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	slot1 = ActivityNewbieTools.GetFirstRechargeStatus()
	slot2 = slot1.signTimes
	slot3 = slot1.lastSignTimestamp

	if not slot1.secondGearStatus then
		slot0.controller_:SetSelectedState("normal")
	elseif slot0.index_ <= slot2 then
		slot0.controller_:SetSelectedState("received")
	elseif slot0.index_ == slot2 + 1 and slot3 < manager.time:GetTodayFreshTime() then
		slot0.controller_:SetSelectedState("complete")
	else
		slot0.controller_:SetSelectedState("normal")
	end
end

return slot0
