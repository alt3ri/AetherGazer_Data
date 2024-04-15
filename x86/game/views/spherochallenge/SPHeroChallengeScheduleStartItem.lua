slot0 = class("SPHeroChallengeScheduleStartItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = slot0.controller:GetController("state")
end

function slot0.RefreshUI(slot0, slot1)
	slot0.scheduleID = slot1.scheduleID

	if not slot0.scheduleID then
		slot0.state = "empty"
		slot0.index = slot1.index

		slot0.stateController:SetSelectedState("empty")
	else
		slot0.stateController:SetSelectedState("start")

		slot0.index = slot1.index
		slot0.iconImg_.sprite = SPHeroChallengeTools:GetScheduleIcon(slot0.scheduleID)
		slot0.nameText_.text = ActivityHeroChallengeScheduleCfg[slot0.scheduleID].name
		slot0.descText_.text = ActivityHeroChallengeScheduleCfg[slot0.scheduleID].linkgame_des
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.reduceBtn_, nil, function ()
		if SPHeroChallengeData:GetCurActivityInfo() and uv0.scheduleID then
			slot0:RemoveScheduleInDailyList(uv0.scheduleID, uv0.index)
		end

		if uv0.cancelFunc then
			uv0.cancelFunc()
		end
	end)
end

function slot0.RegisterCancelCallBack(slot0, slot1)
	if slot1 then
		slot0.cancelFunc = slot1
	end
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
