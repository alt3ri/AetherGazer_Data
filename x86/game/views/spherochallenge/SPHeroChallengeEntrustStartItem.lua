slot0 = class("SPHeroChallengeEntrustStartItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.showIndex = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
	slot0.rankController = slot0.controller:GetController("rank")
	slot0.commonItemView = CommonItemView.New(slot0.commonItem)

	slot0:AddUIListener()
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.showIndex = slot1.showIndex

		if slot1.state == "lock" then
			slot0.stateController:SetSelectedState("lock")

			slot2, slot0.lockDesc.text = SPHeroChallengeTools:GetEntrustLockDesc(slot0.showIndex)
		elseif slot1.state == "empty" then
			slot0.stateController:SetSelectedState("empty")
		elseif slot1.state == "start" then
			slot0.stateController:SetSelectedState("start")
			slot0:RefreshBaseInfo()
			slot0:RefreshStartInfo()
		elseif slot1.state == "end" then
			slot0.stateController:SetSelectedState("end")
			slot0:RefreshBaseInfo()
			slot0:RefreshEndInfo()
		end
	end
end

function slot0.RefreshBaseInfo(slot0)
	if SPHeroChallengeData:GetCurActivityInfo() then
		slot0.info = slot1:GetShowIndexEntrustInfo(slot0.showIndex)
		slot2 = ActivityHeroChallengeTaskCfg[slot0.info.entrustID]
		slot0.nameText.text = slot2.name

		slot0.rankController:SetSelectedState(tostring(slot2.task_level))
		slot0.commonItemView:SetData({
			id = slot2.reward_list[1][1],
			number = slot2.reward_list[1][2],
			clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		})
	end
end

function slot0.RefreshStartInfo(slot0)
	slot0.curIcon.sprite = ItemTools.getItemSprite(SpHeroChallengeConst.accelerateID)

	slot0:RefreshTime()
end

function slot0.RefreshTime(slot0)
	if slot0.stateController:GetSelectedState() == "start" then
		slot3, slot4 = SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(slot0.info.index)

		if not slot3 and slot4 then
			slot0.timeText_.text = GetTips("REMAINING_TIME") .. manager.time:DescCdTime3(slot4)
			slot0.accDesc.text = SPHeroChallengeTools:GetAcceleratorNumByIndex(slot0.info.index)
		else
			slot2:EntrustFinish(slot0.showIndex)
		end
	end
end

function slot0.RefreshEndInfo(slot0)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.endbtnBtn_, nil, function ()
		if SPHeroChallengeData:GetAccelerateNum() < SPHeroChallengeTools:GetAcceleratorNumByIndex(uv0.info.index) then
			ShowTips(GetTips("ACTIVITY_HERO_CHALLENGE_ACCELERATOR_LACK"))

			return
		end

		SPHeroChallengeAction:UseEntrustAccelerator(slot1, uv0.info.index)
	end)
	slot0:AddBtnListener(slot0.emptyBtn_, nil, function ()
		if uv0.clickEmptyFunc then
			uv0.clickEmptyFunc(uv0.showIndex)
		end
	end)
	slot0:AddBtnListener(slot0.reciveBtn, nil, function ()
		if SPHeroChallengeData:GetCurActivityInfo() then
			if #slot0:GetCanGetRewardEntrustIndexList() > 0 then
				SPHeroChallengeAction:GetEntrustAward(slot1)
			else
				ShowTips("ACTIVITY_HERO_CHALLENGE_NONE_ENTRUST_FINISH")
			end
		end
	end)
end

function slot0.ClickEmptyFunc(slot0, slot1)
	if slot1 then
		slot0.clickEmptyFunc = slot1
	end
end

function slot0.Dispose(slot0)
	if slot0.commonItemView then
		slot0.commonItemView:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
