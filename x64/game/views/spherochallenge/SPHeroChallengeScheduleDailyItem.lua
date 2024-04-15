slot0 = class("SPHeroChallengeScheduleDailyItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2, slot3)
	slot0.gameObject_ = GameObject.Instantiate(slot1, slot2)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.scheduleID = slot3

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
	slot0.sliderController = slot0.controller:GetController("infinite")
	slot0.selectController = slot0.controller:GetController("Selected")
end

function slot0.RefreshUI(slot0)
	slot0.selectController:SetSelectedState("Unselected")

	slot1 = slot0.scheduleID

	slot0:RefreshBaseInfo(slot1)

	slot2, slot3, slot0.state = SPHeroChallengeTools:CheckScheduleCanAddInlist(slot0.scheduleID)
	slot5, slot6 = SPHeroChallengeTools:GetScheduleProgress(slot1)

	slot0.sliderController:SetSelectedState("normal")

	if slot5 < 0 then
		slot0.sliderController:SetSelectedState("infinite")

		slot0.progressText_.text = GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_INFINITE")
	else
		slot0.sliderSlr_.value = math.min(slot5 / slot6, 1)
		slot0.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CHALLENGE_SCHEDULE_PROGRESS"), slot5, slot6)
	end

	if slot0.state == "finish" then
		slot0.stateController:SetSelectedState("finish")

		return true
	elseif slot0.state == "unlock" then
		slot0.stateController:SetSelectedState("unlock")
	elseif slot0.state == "lock" then
		slot0.lockdescText_.text = slot3

		slot0.stateController:SetSelectedState("lock")
	end
end

function slot0.RefreshBaseInfo(slot0, slot1)
	slot0.scheduleID = slot1
	slot0.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(slot1)
	slot0.name.text = ActivityHeroChallengeScheduleCfg[slot1].name
	slot0.desc.text = ActivityHeroChallengeScheduleCfg[slot1].linkgame_des

	if SPHeroChallengeTools:GetSameScheduleNum(slot1) > 0 then
		slot0.selectController:SetSelectedState("Selected")

		slot0.numText_.text = "x" .. slot2
	else
		slot0.numText_.text = ""
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.itemBtn, nil, function ()
		slot0, slot1 = SPHeroChallengeTools:CheckScheduleCanAddInlist(uv0.scheduleID)

		if slot0 then
			if SPHeroChallengeData:GetCurActivityInfo(uv0.scheduleID) then
				slot2:AddScheduleInDailyList(uv0.scheduleID)
			end
		elseif slot1 then
			ShowTips(slot1)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.scheduleID = nil

	uv0.super.Dispose(slot0)
end

return slot0
