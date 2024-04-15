slot0 = class("PopsoureceItem", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.itemStateControll = slot0.accessbtnControllerexcollection_:GetController("btnState")
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0:StopTimer()
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if uv0.state == 3 then
			if uv0.callback_ ~= nil then
				uv0.callback_()
			end

			JumpTools.JumpToPage2(uv0.data_)
		end
	end)
end

function slot0.RemoveListeners(slot0)
	slot0.button_.onClick:RemoveAllListeners()
end

function slot0.SetJumpCallback(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.RefreshUI(slot0, slot1, slot2)
	slot0.data_ = slot2

	if slot2[1] == 0 then
		slot0.state = 1
		slot0.frontText_.text = GetI18NText(slot0.data_[2])
		slot0.nameText_.text = GetI18NText(slot0.data_[3])

		slot0.itemStateControll:SetSelectedState("display")
	elseif SystemLinkCfg[slot2[1]].text_invalid ~= 0 then
		slot0.state = 2
		slot0.nameText_.text, slot0.frontText_.text = JumpTools.GetName(slot0.data_)

		slot0.itemStateControll:SetSelectedState("display")
	else
		slot0.state = 3
		slot0.nameText_.text, slot0.frontText_.text = JumpTools.GetName(slot0.data_)
		slot3 = SystemLinkCfg[slot0.data_[1]]
		slot4 = slot3.activity_id

		if type(slot3.paramName) == "table" and (table.keyof(slot3.paramName, "activityId") or table.keyof(slot3.paramName, "activityID")) then
			slot4 = slot0.data_[slot5 + 1]
		end

		if slot4 and slot4 ~= 0 then
			slot0.startTime_, slot6, slot7 = JumpTools.GetActivityTime(slot4)
			slot0.stopTime_ = slot6

			if manager.time:GetServerTime() < slot6 then
				slot0:AddTimer()
			end
		end

		slot0:RefreshLock()
	end
end

function slot0.RefreshLock(slot0)
	if JumpTools.GetLinkIsLocked(slot0.data_) then
		slot0.itemStateControll:SetSelectedState("locked")
	else
		slot0.itemStateControll:SetSelectedState("unlocked")
	end
end

function slot0.AddTimer(slot0)
	slot0:StopTimer()

	slot0.timer_ = not slot0.timer_ and Timer.New(function ()
		uv0:RefreshLock()

		if uv0.stopTime_ < manager.time:GetServerTime() then
			uv0:StopTimer()
		end
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
