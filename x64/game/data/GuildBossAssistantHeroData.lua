slot0 = singletonClass("GuildBossAssistantHeroData", BaseHeroViewData)

function slot0.GetHeroList(slot0)
	return GuildData:GetAssistantBriefList()
end

function slot0.GetHeroIDList(slot0)
	return slot0.dataClass:GetHeroIDList(slot0.tempHeroList)
end

function slot0.GetHeroUsingSkinInfo(slot0, slot1)
	return slot0.dataClass:GetHeroUsingSkinInfo(slot1, slot0.tempHeroList)
end

return slot0
