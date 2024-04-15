slot0 = class("SectionSelectHeroIndiaNianView", SectionSelectHeroBaseView)

function slot0.OnEnter(slot0)
	if IndiaNianCfg[slot0.params_.destID].stage_type == 0 then
		slot0:AddHpTimer()
	end

	manager.windowBar:RegistBackCallBack(function ()
		JumpTools.OpenPageByJump("/indiaNianMain")
	end)
	slot0.super.OnEnter(slot0)
end

function slot0.AddHpTimer(slot0)
	slot0.timer_ = Timer.New(function ()
		if IndiaNianData:GetCurrentHpByID(uv0.params_.destID) == 0 then
			uv0:Back()
		end
	end, 1, -1, true)

	slot0.timer_:Start()
end

function slot0.OnExit(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	uv0.super.OnExit(slot0)
end

return slot0
