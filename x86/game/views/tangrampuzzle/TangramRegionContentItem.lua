slot0 = class("TangramRegionContentItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.regionType_ = slot2
	slot0.regionIdList_ = slot3
end

function slot0.OnExit(slot0)
	slot0:StopAnimTimer()
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshStatus()
end

function slot0.RefreshStatus(slot0)
	slot0.unlock_ = true

	for slot5, slot6 in ipairs(slot0.regionIdList_) do
		if not TangramPuzzleData:GetUnlockRegionDic(slot0.activityID_)[slot6] then
			slot0.unlock_ = false

			break
		end
	end

	if not slot0.unlock_ then
		slot0.statusController_:SetSelectedState("lock")
	elseif slot0:IsAllReceived() and TangramPuzzleTools.CheckRegionAllRightByType(slot0.activityID_, slot0.regionType_) then
		slot0:SetActive(false)
	else
		slot0.statusController_:SetSelectedState("normal")
	end
end

function slot0.IsAllReceived(slot0)
	for slot5, slot6 in ipairs(slot0.regionIdList_) do
		if not TangramPuzzleData:GetRegionReceivedDic(slot0.activityID_)[slot6] then
			return false
		end
	end

	return true
end

function slot0.GetRegionContentTrans(slot0)
	return slot0.regionContentTrans_
end

function slot0.PlayCompletedAnim(slot0, slot1)
	slot0:PlayAnim(slot0.animator_, "regionContentTemplate", slot1)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.StopAnimTimer(slot0)
	if slot0.animtimer_ then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end
end

function slot0.PlayAnim(slot0, slot1, slot2, slot3)
	if not slot1 then
		if slot3 then
			slot3()
		end

		return
	end

	slot0:StopAnimTimer()

	slot1.enabled = true

	slot1:Play(slot2, -1, 0)
	slot1:Update(0)

	slot0.animtimer_ = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			uv2:StopAnimTimer()

			uv0.enabled = false

			if uv3 then
				uv3()
			end
		end
	end, 0.033, -1)

	slot0.animtimer_:Start()
end

return slot0
