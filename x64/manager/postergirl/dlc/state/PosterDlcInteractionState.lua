slot0 = class("PosterDlcInteractionState", PosterDlcTimelineState)

function slot0.Ctor(slot0, slot1, slot2)
	uv0.super.Ctor(slot0, slot1, slot2)

	slot0.interactionKey = slot2
end

function slot0.Enter(slot0)
	uv0.super.Enter(slot0)
	slot0.actor:EnableEyeController(false)

	slot1 = HeroTools:GetUnlockInteractionCfg(slot0.actor:GetSkinId())
	slot3 = slot1[slot0.interactionKey .. "_talk"]
	slot4 = slot1[slot0.interactionKey .. "_delay"]
	slot5 = 1

	if #slot1[slot0.interactionKey] > 1 then
		slot5 = slot0:RandomIndexOfInteractionType(slot0.interactionKey)
	end

	slot6 = slot2[slot5]
	slot7 = slot3[slot5]
	slot8 = slot4[slot5]
	slot10 = manager.posterGirl:GetForceRandomIndex()

	if HeroInteractionCfg[slot0.actor:GetSkinId()][slot0.interactionKey] and slot10 and slot10 <= #slot11 then
		slot6 = slot11[slot10]
		slot13 = HeroInteractionCfg[slot9][slot0.interactionKey .. "delay"]
		slot7 = HeroInteractionCfg[slot9][slot0.interactionKey .. "_talk"] and slot12[slot5]
		slot8 = slot13 and slot13[slot5]
	end

	if slot6 then
		slot0:PlayAni(slot6)

		if slot7 and slot8 then
			slot0:PlaySpecialTalk(slot7, slot8)
		end
	end

	if slot0.interactionKey == PosterGirlConst.InteractionKey.mainTouch or slot0.interactionKey == PosterGirlConst.InteractionKey.mainQuickTouch or slot0.interactionKey == PosterGirlConst.InteractionKey.touch2 or slot0.interactionKey == PosterGirlConst.InteractionKey.touch3 then
		PlayerAction.TouchPosterGirl()
	end
end

function slot0.RandomIndexOfInteractionType(slot0, slot1)
	slot2 = slot1 .. "_talk"
	slot4 = slot0.lastIndex or 0
	slot5 = {}
	slot6 = {}

	if not HeroTools:GetUnlockInteractionCfg(slot0.actor:GetSkinId()) then
		error("RandomIndexOfInteractionType error")

		return 1
	end

	for slot10, slot11 in ipairs(slot3[slot2]) do
		if slot10 ~= slot4 then
			table.insert(slot5, slot11)
			table.insert(slot6, slot10)
		end
	end

	slot7 = 1

	if slot3[slot1 .. "_weight"] and #slot8 > 0 then
		for slot13, slot14 in ipairs(slot6) do
			slot9 = 0 + slot8[slot14]
		end

		slot14 = slot9

		for slot14, slot15 in ipairs(slot6) do
			if math.round(math.random(slot14)) <= slot8[slot15] then
				slot7 = slot14

				break
			else
				slot10 = slot10 - slot16
			end
		end
	else
		slot7 = math.round(math.random(#slot6))
	end

	slot9 = slot6[slot7]
	slot0.lastIndex = slot9

	return slot9
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

function slot0.Exit(slot0, slot1)
	uv0.super.Exit(slot0, slot1)

	if slot0.talkDelayTimer_ then
		slot0.talkDelayTimer_:Stop()

		slot0.talkDelayTimer_ = nil
	end
end

return slot0
