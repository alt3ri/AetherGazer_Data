slot0 = class("PosterDlcInteractionState", PosterCommonAnimatorState)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.interactionKey = slot2
end

function slot0.Enter(slot0)
	slot0:CheckInsteraction()
end

function slot0.CheckInsteraction(slot0)
	slot0.actor:EnableEyeController(false)

	slot3 = HeroTools:GetUnlockInteractionCfg(SkinCfg[slot0.actor:GetSkinId()].hero)
	slot5 = slot3[slot0.interactionKey .. "_talk"]
	slot6 = slot3[slot0.interactionKey .. "_delay"]
	slot7 = 1

	if #slot3[slot0.interactionKey] > 1 then
		slot7 = slot0:RandomIndexOfInteractionType(slot0.interactionKey)
	end

	slot8 = slot4[slot7]
	slot9 = slot5[slot7]
	slot10 = slot6[slot7]
	slot11 = manager.posterGirl:GetForceRandomIndex()

	if HeroInteractionCfg[slot2][slot0.interactionKey] and slot11 and slot11 <= #slot12 then
		slot8 = slot12[slot11]
		slot14 = HeroInteractionCfg[slot2][slot0.interactionKey .. "_delay"]
		slot9 = HeroInteractionCfg[slot2][slot0.interactionKey .. "_talk"] and slot13[slot11]
		slot10 = slot14 and slot14[slot11]
	end

	if slot8 then
		slot0:PlayAni(slot8)

		if slot9 and slot10 then
			slot0:PlaySpecialTalk(slot9, slot10)
		end
	end

	if slot0.interactionKey == PosterGirlConst.InteractionKey.mainTouch or slot0.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch then
		PlayerAction.TouchPosterGirl()
	end
end

function slot0.RandomIndexOfInteractionType(slot0, slot1)
	slot2 = slot1 .. "_talk"
	slot6 = slot0.lastIndex or 0
	slot7 = {}
	slot8 = {}

	if not HeroTools:GetUnlockInteractionCfg(SkinCfg[slot0.actor:GetSkinId()].hero) then
		error("RandomIndexOfInteractionType error")

		return 1
	end

	for slot12, slot13 in ipairs(slot5[slot2]) do
		if slot12 ~= slot6 then
			table.insert(slot7, slot13)
			table.insert(slot8, slot12)
		end
	end

	slot9 = 1

	if slot5[slot1 .. "_weight"] and #slot10 > 0 then
		for slot15, slot16 in ipairs(slot8) do
			slot11 = 0 + slot10[slot16]
		end

		slot16 = slot11

		for slot16, slot17 in ipairs(slot8) do
			if math.round(math.random(slot16)) <= slot10[slot17] then
				slot9 = slot16

				break
			else
				slot12 = slot12 - slot18
			end
		end
	else
		slot9 = math.round(math.random(#slot8))
	end

	slot11 = slot8[slot9]
	slot0.lastIndex = slot11

	return slot11
end

function slot0.PlaySpecialTalk(slot0, slot1, slot2)
	if #string.split(slot1, "_") < 2 then
		return
	end

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end

	if slot2 > 0 then
		slot0.talkDelayTimer_ = Timer.New(function ()
			uv0.actor:PlayHeroTalk(uv1[1], uv1[2], nil)
		end, slot2 / 1000)

		slot0.talkDelayTimer_:Start()
	else
		slot0.actor:PlayHeroTalk(slot3[1], slot3[2], nil)
	end
end

function slot0.Exit(slot0)
	uv0.super.Exit(slot0)

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end
end

return slot0
