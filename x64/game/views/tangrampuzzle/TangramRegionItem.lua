slot0 = class("TangramRegionItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()

	slot0.statusController_ = ControllerUtil.GetController(slot0.transform_, "status")
	slot0.rotateAxis_ = Vector3.New(0, 0, -1)
end

function slot0.OnExit(slot0)
	slot0:StopLeanTween()
	slot0:StopAnim()
end

function slot0.Dispose(slot0)
	slot0:StopLeanTween()
	slot0:StopAnim()
	uv0.super.Dispose(slot0)
end

function slot0.SetData(slot0, slot1)
	slot0.activityID_ = slot1

	slot0:StopAnim()
end

function slot0.GetPuzzleContent(slot0)
	return slot0.puzzleContentTrans_
end

function slot0.SetTransParent(slot0, slot1)
	slot0.originParent_ = slot0.transform_.parent

	slot0.transform_:SetParent(slot1)
end

function slot0.RecoverTrans(slot0)
	if slot0.originAngle_ then
		slot0.transform_:SetLocalEulerAngleOrigin(slot0.originAngle_)
	end

	slot0.originAngle_ = nil

	if slot0.originParent_ then
		slot0.transform_:SetParent(slot0.originParent_)

		slot0.originParent_ = nil
	end
end

function slot0.PlayAutoPutAnim(slot0, slot1)
	SetActive(slot0.rewardAnimGo_, true)
	slot0:PlayAnim(slot0.animator_, "JigsawPuzzleUI_regionItem", function ()
		SetActive(uv0.rewardAnimGo_, false)

		if uv1 then
			uv1()
		end
	end)
end

function slot0.PlayRewardAnim(slot0, slot1)
	SetActive(slot0.rewardAnimGo_, true)
	slot0:PlayAnim(slot0.animator_, "JigsawPuzzleUI_regionItem", function ()
		SetActive(uv0.rewardAnimGo_, false)

		if uv1 then
			uv1()
		end
	end)
end

function slot0.StopAnim(slot0)
	if slot0.animtimer_ then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end

	slot0.animator_.enabled = false

	SetActive(slot0.rewardAnimGo_, false)
end

function slot0.Rotate(slot0, slot1, slot2)
	slot0.originAngle_ = slot0.transform_:GetLocalEulerAngleOrigin()

	slot0:StopLeanTween()

	slot0.rotateLeanTween_ = LeanTween.rotateAroundLocal(slot0.gameObject_, slot0.rotateAxis_, slot1, 0.5):setEase(LeanTweenType.easeOutCubic):setOnComplete(LuaHelper.VoidAction(function ()
		uv0:StopLeanTween()

		if uv1 then
			uv1()
		end
	end))
end

function slot0.StopLeanTween(slot0)
	if slot0.rotateLeanTween_ then
		slot0.rotateLeanTween_:setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.rotateLeanTween_.id)

		slot0.rotateLeanTween_ = nil
	end
end

function slot0.PlayAnim(slot0, slot1, slot2, slot3)
	if not slot1 then
		if slot3 then
			slot3()
		end

		return
	end

	slot1.enabled = true

	slot1:Play(slot2, -1, 0)
	slot1:Update(0)

	if slot0.animtimer_ then
		slot0.animtimer_:Stop()

		slot0.animtimer_ = nil
	end

	slot0.animtimer_ = Timer.New(function ()
		if uv0:GetCurrentAnimatorStateInfo(0):IsName(uv1) and slot0.normalizedTime >= 1 then
			if uv2.animtimer_ ~= nil then
				uv2.animtimer_:Stop()

				uv2.animtimer_ = nil
			end

			SetActive(uv2.maskGo_, false)

			if uv3 then
				uv3()
			end
		end
	end, 0.033, -1)

	slot0.animtimer_:Start()
end

return slot0
