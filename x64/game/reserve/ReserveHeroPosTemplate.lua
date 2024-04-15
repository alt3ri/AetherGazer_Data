slot0 = class("ReserveHeroPosTemplate")

function slot0.Ctor(slot0, slot1)
	slot0.pos = slot1
	slot0.hero_type = 1
	slot0.trial_id = 0
	slot0.hero_id = 0
end

function slot0.UpdateServerData(slot0, slot1, slot2)
	slot0.pos = slot2
	slot0.hero_type = slot1.hero_type or 1

	if slot0.hero_type == 1 then
		slot0.trial_id = 0
		slot0.hero_id = slot1.hero_id
	elseif slot0.hero_type == 2 then
		slot0.trial_id = slot1.hero_id
		slot0.hero_id = HeroStandardSystemCfg[slot1.hero_id].hero_id
	end
end

function slot0.GetHeroID(slot0)
	return slot0.hero_id
end

function slot0.SetHeroID(slot0, slot1)
	slot0.hero_id = slot1 or 0
end

function slot0.GetTrialID(slot0)
	return slot0.trial_id
end

function slot0.SetTrialID(slot0, slot1)
	slot0.trial_id = slot1 or 0
	slot0.hero_type = slot0.trial_id ~= 0 and 2 or 1
end

function slot0.GetHeroType(slot0)
	return slot0.hero_type
end

function slot0.ConvertToSendData(slot0)
	if slot0.hero_type == 1 then
		-- Nothing
	else
		slot1.hero_id = slot0.trial_id
	end

	return {
		hero_id = slot0.hero_id,
		hero_type = slot0.hero_type
	}
end

function slot0.Reset(slot0)
	slot0.hero_type = 1
	slot0.trial_id = 0
	slot0.hero_id = 0
end

return slot0
