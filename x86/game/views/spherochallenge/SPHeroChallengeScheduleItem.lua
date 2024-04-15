slot0 = class("SPHeroChallengeScheduleItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("State")
end

function slot0.RefreshUI(slot0, slot1)
	if SPHeroChallengeData:GetCurActivityInfo() then
		if slot2:GetStartListScheduleInfoByList(slot1) then
			slot4 = slot3.scheduleID
			slot0.imageImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(slot4)
			slot0.schedulenameText_.text = ActivityHeroChallengeScheduleCfg[slot4].name
			slot0.scheduledescText_.text = ActivityHeroChallengeScheduleCfg[slot4].linkgame_des

			if slot3.isFinish then
				slot0.stateController:SetSelectedState("Done")
			else
				slot0.stateController:SetSelectedState("Normal")
			end
		else
			slot0.stateController:SetSelectedState("add")
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.addBtn_, nil, function ()
		if uv0.state == "empty" then
			JumpTools.OpenPageByJump("/spHeroChallengeScheduleView")
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
