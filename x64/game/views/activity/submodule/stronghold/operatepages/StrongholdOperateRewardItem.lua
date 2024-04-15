slot0 = class("StrongholdOperateRewardItem", ReduxView)

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

	slot0.rewardItems_ = {}
	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		StrongholdAction.QueryReward(uv0.activity_id, {
			uv0.reward_id
		})
	end)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activity_id = slot1
	slot0.reward_id = slot2
	slot3 = ActivityStrongholdRewardCfg[slot0.reward_id]
	slot5 = slot3.params[1]
	slot6 = nil

	for slot11, slot12 in ipairs(ActivityStrongholdLevelCfg.get_id_list_by_type[slot3.condition]) do
		if ActivityStrongholdLevelCfg[slot12].level == slot5 then
			slot6 = ActivityStrongholdLevelCfg[slot12]
		end
	end

	slot0.m_des.text = string.format(GetTips("ACTIVITY_STRONGHOLD_REWARD_TIP"), GetTips("ACTIVITY_STRONGHOLD_TYPE_NAME_" .. slot4), slot5, slot6.level_des)
	slot9, slot10, slot11, slot12 = StrongholdData:GetStrongholdLevel(slot4)
	slot0.m_processLab.text = math.min(slot10, slot5) .. "/" .. slot5
	slot0.m_process.fillAmount = math.min(slot10, slot5) / slot5

	for slot17, slot18 in ipairs(slot3.reward or {}) do
		if slot0.rewardItems_[slot17] == nil then
			slot0.rewardItems_[slot17] = RewardItem.New(slot0.m_rewardItem, slot0.m_rewardParent)

			slot0.rewardItems_[slot17]:UpdateCommonItemAni()
			slot0.rewardItems_[slot17].commonItem_:RegistCallBack(function ()
				OperationRecorder.Record("task", "task_item")
			end)
		end

		slot0.rewardItems_[slot17]:SetData(slot18)
	end

	for slot17 = #slot3.reward + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot17]:Show(false)
	end

	slot0.stateController:SetSelectedIndex(StrongholdData:GetRewardState(slot1, slot2))
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	uv0.super.Dispose(slot0)
end

return slot0
