SPHeroChallengeEntrusTemplate = class("SPHeroChallengeEntrustTemplate")

function SPHeroChallengeEntrustTemplate.InitSingleEntrust(slot0, slot1)
	slot0.entrustID = slot1.id
	slot0.state = slot1.state
end
