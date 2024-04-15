slot0 = class("SPHeroChallengeEntrustWaitItem", ReduxView)

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

	slot0.stateController = slot0.controller:GetController("state")
	slot0.rankController = slot0.controller:GetController("rank")
end

function slot0.RefreshUI(slot0, slot1)
	if slot1 then
		slot0.showiIndex = slot1.showiIndex

		if slot1.state then
			if slot1.state == "lock" then
				slot0.stateController:SetSelectedState("lock")

				slot2 = SPHeroChallengeData:GetActivityID()
				slot4 = SPHeroChallengeData.activityCfg[slot2].waitEntrustListOpenCondition[slot0.showiIndex - SPHeroChallengeTools:GetMaxStartEntrustPosNum(slot2)][2]
				slot5, slot6 = SPHeroChallengeTools:GetConditionDesc(slot4)
				slot0.lockdescText_.text = GetTips("RETURN_MATERIAL_MAX_POINT")
				slot0.currencyiconImg_.sprite = ItemTools.getItemSprite(slot6)
				slot7, slot8, slot9 = IsConditionAchieved(slot4)
				slot0.locknumText_.text = string.format("<color='#FF000B'>%d</color>", slot8) .. "/" .. slot9
			elseif slot1.state == "empty" then
				slot0.stateController:SetSelectedState("empty")
			end
		else
			slot2 = slot1.entrustIndex

			slot0:RefreshBaseInfo(slot2)

			if SPHeroChallengeData:GetCurActivityInfo():GetEntrustEndTime(slot2) then
				slot0.stateController:SetSelectedState("end")
			else
				slot0.stateController:SetSelectedState("start")
			end
		end
	end
end

function slot0.RefreshBaseInfo(slot0, slot1)
	slot5 = ActivityHeroChallengeTaskCfg[SPHeroChallengeData:GetCurActivityInfo():GetEntrustInfoByIndex(slot1).entrustID]
	slot0.entrustnameText_.text = slot5.name

	slot0.rankController:SetSelectedState(tostring(slot5.task_level))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.emptyBtn_, nil, function ()
		if uv0.clickEmptyFunc then
			uv0.clickEmptyFunc(uv0.showIndex)
		end
	end)
	slot0:AddBtnListener(slot0.cancelBtn, nil, function ()
		if SPHeroChallengeData:GetCurActivityInfo():GetShowIndexEntrustInfo(uv0.showiIndex) then
			SPHeroChallengeAction:CancelEntrust({
				index = slot1.index,
				entrustID = uv0.id
			})
		end
	end)
end

function slot0.ClickEmptyFunc(slot0, slot1)
	if slot1 then
		slot0.clickEmptyFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
