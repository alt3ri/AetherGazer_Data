slot0 = class("CombineGameStep", ComponentStep)
slot1 = {
	[5919] = {
		1,
		3,
		1
	},
	[5924] = {
		3,
		2,
		3
	},
	[5930] = {
		3,
		3,
		2
	},
	[5935] = {
		0,
		0,
		0
	},
	[5939] = {
		4,
		0,
		0
	}
}

function slot0.Init(slot0)
	uv0.super.Init(slot0)

	slot0._eventName = GuideStepCfg[slot0._stepId].params[1]
end

function slot0.EventTrigger(slot0, slot1, slot2)
	if slot0._stepId == 5918 or slot0._stepId == 5923 or slot0._stepId == 5929 then
		CombineGameWorld.Instance.canDrag = true

		slot0:OnStepEnd()

		return
	end

	if (slot0._stepId == 5934 or slot0._stepId == 5938) and slot1 == "pointerDown" then
		CombineGameWorld.Instance.canDrag = true

		slot0:OnStepEnd()

		return
	end

	if slot0._stepId == 5943 then
		CombineGameWorld.Instance.isTeach = false
		CombineGameWorld.Instance.canDrag = true

		slot0:OnStepEnd()

		return
	end

	TimeTools.StartAfterSeconds(0.1, function ()
		if uv0._stepId == nil then
			return
		end

		if uv1[uv0._stepId] == nil then
			return
		end

		if CombineGameWorld.Instance:CheckBlock(slot0[1], slot0[2], slot0[3]) then
			CombineGameWorld.Instance.canDrag = false

			uv0:OnStepEnd()
		elseif uv0._stepId == 5935 or uv0._stepId == 5939 then
			if uv0._guide == nil then
				return
			end

			uv0._guide:AddNextStep(GuideStepCfg[uv0._stepId])
			uv0._guide:AddNextStep(GuideStepCfg[uv0._stepId - 1])
			uv0:OnStepEnd()
		end
	end, {})
end

return slot0
