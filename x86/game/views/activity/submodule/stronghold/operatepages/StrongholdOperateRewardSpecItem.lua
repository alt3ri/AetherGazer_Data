slot0 = class("StrongholdOperateSpecRewardItem", ReduxView)

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

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "state")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_rewardBtn, function ()
		if StrongholdData:GetRewardState(uv0.activity_id, uv0.reward_id) == 0 then
			StrongholdAction.QueryReward(uv0.activity_id, {
				uv0.reward_id
			})
		elseif slot0 == 1 then
			ShowTips("ACTIVITY_STRONGHOLD_REWARD_FAIL")
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_iconBtn, function ()
		ShowPopItem(POP_SOURCE_ITEM, {
			uv0.item_id,
			1
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

	slot0.stateController:SetSelectedIndex(StrongholdData:GetRewardState(slot1, slot2))

	slot11 = slot3.reward[1][1]
	slot0.item_id = slot11

	if ItemCfg[slot11] then
		slot0.m_icon.sprite = ItemTools.getItemSprite(slot11)
		slot0.m_title.text = ItemTools.getItemName(slot11)
	end
end

return slot0
