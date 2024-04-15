slot0 = class("ActivityAdvertiseItem", ReduxView)

function slot0.UIName(slot0)
	slot0.cfgID_ = ActivityAdvertiseTools.GetOpenActivityCfgIDList()[1] or ActivityAdvertiseCfg.all[#ActivityAdvertiseCfg.all]

	return ActivityAdvertiseCfg[slot0.cfgID_].prefab_path
end

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName()), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.rewardItemList_ = {}
	slot2 = ActivityAdvertiseData:GetDefaultPrompt()
	slot0.promptToggle_.isOn = slot2

	saveData("activityAdvertise", "prompt" .. slot0.cfgID_, slot2)
	ActivityAdvertiseData:SetOpenAdvertiseFlag(slot0.cfgID_, true)

	if slot0.cfgID_ then
		saveData("activityAdvertise", tostring(slot0.cfgID_), manager.time:GetServerTime())
	end

	slot0:RefreshUI()
	slot0:AddTimer()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()

	for slot4, slot5 in ipairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil

	slot0.promptToggle_.onValueChanged:RemoveAllListeners()
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		slot1, slot2 = JumpTools.GetSystemLockedText(ActivityAdvertiseCfg[uv0.cfgID_].jump_system)

		OperationRecorder.RecordButtonTouch("homepage_jump_" .. ActivityAdvertiseCfg[uv0.cfgID_].activity_id)
		SDKTools.SendMessageToSDK("activity_post_trigger", {
			oper = slot1 and 2 or 1
		})

		if slot1 then
			ShowTips(slot2)

			return
		end

		uv0:Back()
		SDKTools.SendMessageToSDK("activity_publicize_page_jump", {
			opt = 1,
			activity_id = slot3.activity_id
		})
		JumpTools.JumpToPage2(slot0)
		ActivityAdvertiseTools.StopAllAdvertise()
	end)
	slot0.promptToggle_.onValueChanged:AddListener(function (slot0)
		saveData("activityAdvertise", "prompt" .. uv0.cfgID_, slot0)
		ActivityAdvertiseData:SetDefaultPrompt(slot0)
		SDKTools.SendMessageToSDK("activity_post_shield", {
			opt = slot0 and 1 or 0
		})
	end)
end

function slot0.RefreshUI(slot0)
	for slot5, slot6 in ipairs(ActivityAdvertiseCfg[slot0.cfgID_].reward_list) do
		if slot0.rewardItemList_[slot5] == nil then
			slot0.rewardItemList_[slot5] = RewardPoolItem.New(slot0.rewardPanel_, {
				slot6,
				0
			}, true)

			slot0.rewardItemList_[slot5]:ShowFloor(ItemConst.ITEM_FLOOR.SHORT)
			slot0.rewardItemList_[slot5]:HideNum()
		else
			slot0.rewardItemList_[slot5]:SetData(slot7)
		end
	end

	for slot5 = #slot0.rewardItemList_, #slot1.reward_list + 1, -1 do
		slot0.rewardItemList_[slot5]:Dispose()

		slot0.rewardItemList_[slot5] = nil
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(ActivityData:GetActivityData(ActivityAdvertiseCfg[slot0.cfgID_].activity_id).stopTime, true)
	slot0.timer_ = Timer.New(function ()
		uv0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(uv1.stopTime, true)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
