slot0 = class("SailUpgradeIslandPremissItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
end

function slot0.Dispose(slot0)
	Object.Destroy(slot0.gameObject_)

	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.ID_ = slot1
	slot0.activityID_ = slot2

	if ConditionCfg[slot0.ID_].type == 2508 then
		slot0.needNum_ = 1
		slot0.curNum_ = SailGameData:GetUnLockBuilding(slot0.activityID_)[slot3.params[1]] == true and 1 or 0
		slot0.descText_.text = string.format(ConditionCfg[slot0.ID_].desc, SailGameBuildingCfg[slot3.params[1]].name)
	elseif slot3.type == 2509 then
		slot0.needNum_ = slot3.params[1]
		slot0.curNum_ = SailGameData:GetCompleteSailTimes(slot0.activityID_)
		slot0.descText_.text = string.format(ConditionCfg[slot0.ID_].desc, slot3.params[1])
	end

	slot0.progressText_.text = string.format("%d/%d", slot0.curNum_, slot0.needNum_)

	slot0.statusController_:SetSelectedState(slot0.needNum_ <= slot0.curNum_ and "on" or "off")
	slot0:SetActive(true)
end

function slot0.IsComplete(slot0)
	return slot0.needNum_ <= slot0.curNum_
end

return slot0
