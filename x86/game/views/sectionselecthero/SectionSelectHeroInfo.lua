slot0 = class("SectionSelectHeroInfo")

function slot0.Ctor(slot0)
	slot0:Init()
end

function slot0.Init(slot0)
	slot0.heroID = 0
	slot0.trialID = 0
	slot0.isLock = false
	slot0.heroDataType = HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.heroViewProxy = HeroViewDataProxy.New(slot0.heroDataType)
	slot0.isAssistant = false
	slot0.assistantInfo = {}
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.heroID = slot1 or 0
	slot0.trialID = slot2 or 0
	slot0.isLock = slot3 or false
end

function slot0.SetHeroDataType(slot0, slot1, slot2)
	slot0.heroDataType = slot1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.heroViewProxy = slot2 or HeroViewDataProxy.New(slot0.heroDataType)
end

function slot0.SetAssistantInfo(slot0, slot1, slot2)
	slot0.isAssistant = slot1 == true
	slot0.assistantInfo = slot2
end

function slot0.GetHeroPower(slot0)
	return slot0.heroViewProxy:GetBattlePower(slot0.heroID)
end

function slot0.GetSkinCfg(slot0)
	return slot0.heroViewProxy:GetHeroUsingSkinInfo(slot0.heroID, {
		slot0.trialID
	})
end

function slot0.GetHeroHP(slot0, slot1, slot2, slot3)
	return 1, 100
end

return slot0
