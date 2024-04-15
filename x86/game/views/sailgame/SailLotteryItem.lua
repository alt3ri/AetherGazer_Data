slot0 = class("SailLotteryItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	SetActive(slot0.gameObject_, true)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.resultController_ = ControllerUtil.GetController(slot0.transform_, "result")
	slot0.selectController_ = ControllerUtil.GetController(slot0.transform_, "select")
	slot0.pointController_ = ControllerUtil.GetController(slot0.transform_, "point")
	slot0.originPos_ = slot0.transform_.localPosition
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if uv0.selectCallback_ then
			uv0.selectCallback_(uv0.index_)
		end
	end)
end

function slot0.Dispose(slot0)
	slot0.gameObject_ = nil
	slot0.transform_ = nil
	slot0.selectCallback_ = nil

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	if slot0.posLeanTween_ then
		slot0.posLeanTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.posLeanTween_.id)

		slot0.posLeanTween_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.index_ = slot1
	slot0.activityID_ = slot2

	slot0:Recover()
end

function slot0.SetActive(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)
end

function slot0.SetPoint(slot0, slot1, slot2)
	slot0.point_ = slot1
	slot0.isMine_ = slot2
	slot0.pointText_.text = slot1

	slot0.pointController_:SetSelectedState(slot1)
end

function slot0.Recover(slot0)
	slot0:SetActive(true)

	if slot0.originPos_ then
		slot0.transform_.localPosition = slot0.originPos_
	end

	slot0.statusController_:SetSelectedState("origin")
	slot0.resultController_:SetSelectedState("none")
	slot0.selectController_:SetSelectedState("false")
	slot0.animator_:Play("cardItem_normal", -1, 0)
	slot0.animator_:Update(0)
end

function slot0.SetResult(slot0, slot1)
	slot0.win_ = slot1
end

function slot0.SetSelecteCallback(slot0, slot1)
	slot0.selectCallback_ = slot1
end

function slot0.SetTargetPos(slot0, slot1)
	slot0.targetPos_ = slot1

	slot0:PlayMoveAnim()
end

function slot0.PlayExitAnim(slot0)
	slot0.animator_:Play("cardItem_ex", -1, 0)
	slot0.animator_:Update(0)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot0.timer_ = Timer.New(function ()
		if uv0.animator_:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv0.timer_ ~= nil then
				uv0.timer_:Stop()

				uv0.timer_ = nil
			end

			uv0:SetActive(false)
		end
	end, 0.033, -1)

	slot0.timer_:Start()
end

function slot0.PlayMoveAnim(slot0)
	slot0.posLeanTween_ = LeanTween.moveLocal(slot0.gameObject_, slot0.targetPos_, 0.25):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.posLeanTween_ then
			uv0.posLeanTween_:setOnComplete(nil)

			uv0.posLeanTween_ = nil
		end

		uv0:PlayRotaAnim()
	end))
end

function slot0.PlayRotaAnim(slot0)
	slot0.animator_:Play("cardItem", -1, 0)
	slot0.animator_:Update(0)

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end

	slot2 = false
	slot0.timer_ = Timer.New(function ()
		slot0 = uv0.animator_:GetCurrentAnimatorStateInfo(0)

		if slot0:IsName(uv1) then
			if not uv2 and slot0.normalizedTime >= 0.5 then
				uv2 = true

				uv0.statusController_:SetSelectedState(uv0.isMine_ and "selfPoint" or "oppositePoint")
				uv0.selectController_:SetSelectedState(uv0.isMine_ and "true" or "false")
			elseif slot1 >= 1 then
				if uv0.timer_ ~= nil then
					uv0.timer_:Stop()

					uv0.timer_ = nil
				end

				if uv0.isMine_ then
					uv0.resultController_:SetSelectedState(uv0.win_ and "victory" or "lose")
					manager.notify:CallUpdateFunc(SAIL_EVENT_LOTTERY_WAIT_END)
				end
			end
		end
	end, 0.033, -1)

	slot0.timer_:Start()

	if slot0.isMine_ == true then
		if slot0.win_ == true then
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_win", "")
		else
			manager.audio:PlayEffect("minigame_activity_2_2_summer_sea", "minigame_activity_2_2_summer_sea_fail", "")
		end
	end
end

return slot0
