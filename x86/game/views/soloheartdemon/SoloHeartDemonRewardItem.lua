slot0 = {
	"SOLO_HEART_DEMON_EASY",
	"SOLO_HEART_DEMON_HARD",
	"SOLO_HEART_DEMON_NIGHTMARE"
}
slot1 = class("SoloHeartDemonRewardItem", ReduxView)

function slot1.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.receiveBtn_, nil, function ()
		if uv0.type ~= 1 then
			return
		end

		SoloHeartDemonAction.GetReward({
			reward_list = {
				uv0.data
			}
		})
	end)
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.controller = slot0.allBtnController_:GetController("all")
	slot0.rewardItems_ = {}

	SetActive(slot0[string.format("awardItem%dObj_", 3)], false)
end

function slot1.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot2
	slot0.data = slot1
	slot0.type = slot3

	slot0:UpdateView()
end

function slot1.UpdateView(slot0)
	slot0.rewardCfg = SoloHeartDemonRewardCfg[slot0.data]
	slot0.conditionCfg = ConditionCfg[slot0.rewardCfg.condition]
	slot0.rewardList = SoloHeartDemonData:GetDataByPara("rewardList")[slot0.data]
	slot0.taskData = SoloHeartDemonData:GetDataByPara("taskData")[slot0.data]

	for slot4, slot5 in ipairs(slot0.rewardCfg.reward_list) do
		if slot0.rewardItems_[slot4] == nil then
			slot0.rewardItems_[slot4] = CommonItemView.New(slot0[string.format("awardItem%dObj_", slot4)])
		end

		slot6 = clone(ItemTemplateData)
		slot6.id = slot5[1]
		slot6.number = slot5[2]
		slot6.completedFlag = slot0.rewardList and true or false

		function slot6.clickFun(slot0)
			ShowPopItem(POP_ITEM, {
				slot0.id,
				slot0.number
			})
		end

		slot0.rewardItems_[slot4]:SetData(slot6)
	end

	for slot4 = #slot0.rewardCfg.reward_list + 1, #slot0.rewardItems_ do
		slot0.rewardItems_[slot4]:SetData(nil)
	end

	if slot0.type == 1 then
		SetActive(slot0[string.format("awardItem%dObj_", 2)], true)
	else
		SetActive(slot0[string.format("awardItem%dObj_", 2)], false)
	end

	slot0[slot0.type == 1 and "UpdateNormalView" or "UpdateRankView"](slot0)
end

function slot1.UpdateRankView(slot0)
	slot1 = nil
	slot0.titleText_.text = string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS"), (slot0.data ~= 1001 or string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS2"), slot0.rewardCfg.reward_rank[1])) and string.format(GetTips("SOLO_HEART_DEMON_REWARD_TIPS1"), slot0.rewardCfg.reward_rank[1], slot0.rewardCfg.reward_rank[2]))
end

function slot1.UpdateNormalView(slot0)
	if slot0.rewardList then
		slot0.controller:SetSelectedState("complete")
	elseif slot0.taskData[2] <= slot0.taskData[1] then
		slot0.controller:SetSelectedState("receive")
	else
		slot0.controller:SetSelectedState("lock")
	end

	SetActive(slot0.progressBar_.gameObject, slot0.conditionCfg.progress_show == 1)

	slot0.progressBar_.value = slot0.taskData[1] / slot0.taskData[2]
	slot0.progressText_.text = slot0.taskData[1] .. "/" .. slot0.taskData[2]

	if slot0.conditionCfg.type == 11001 then
		slot0.titleText_.text = string.format(GetI18NText(slot0.conditionCfg.desc), tostring(GetTips(uv0[slot0.conditionCfg.params[1]])))
	elseif slot0.conditionCfg.type == 11002 then
		slot0.titleText_.text = string.format(GetI18NText(slot0.conditionCfg.desc), tostring(GetTips(uv0[slot0.conditionCfg.params[1]])))
	elseif slot0.conditionCfg.type == 11003 then
		slot0.titleText_.text = string.format(GetI18NText(slot0.conditionCfg.desc), tostring(slot0.conditionCfg.params[1]))
	elseif slot0.conditionCfg.type == 11004 then
		slot0.titleText_.text = string.format(GetI18NText(slot0.conditionCfg.desc), tostring(slot0.conditionCfg.params[1]))
	elseif slot0.conditionCfg.type == 11005 then
		slot0.titleText_.text = string.format(GetI18NText(slot0.conditionCfg.desc), tostring(slot0.conditionCfg.params[1]))
	end
end

function slot1.OnEnter(slot0)
	slot0:UpdateView()
end

function slot1.Dispose(slot0)
	if slot0.list then
		slot0.list:Dispose()

		slot0.list = nil
	end

	for slot4, slot5 in pairs(slot0.rewardItems_) do
		slot5:Dispose()
	end

	slot0.rewardItems_ = {}

	uv0.super.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)
end

return slot1
