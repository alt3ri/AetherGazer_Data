slot0 = class("HeroViewDataProxy")
slot1 = {
	[slot12] = slot13
}
slot3 = require("game/tools/HeroViewProxy/ProxyFuction/SkillProxyFunc")
slot4 = require("game/tools/HeroViewProxy/ProxyFuction/WeaponProxyFunc")
slot5 = require("game/tools/HeroViewProxy/ProxyFuction/ServantProxyFuc")
slot6 = require("game/tools/HeroViewProxy/ProxyFuction/EquiptProxyFunc")
slot7 = require("game/tools/HeroViewProxy/ProxyFuction/AstrolabeProxyFunc")
slot8 = require("game/tools/HeroViewProxy/ProxyFuction/TransitionProxyFunc")

for slot12, slot13 in pairs(require("game/tools/HeroViewProxy/ProxyFuction/ProPertyProxyFunc")) do
	-- Nothing
end

for slot12, slot13 in pairs(slot3) do
	slot1[slot12] = slot13
end

for slot12, slot13 in pairs(slot4) do
	slot1[slot12] = slot13
end

for slot12, slot13 in pairs(slot5) do
	slot1[slot12] = slot13
end

for slot12, slot13 in pairs(slot6) do
	slot1[slot12] = slot13
end

for slot12, slot13 in pairs(slot7) do
	slot1[slot12] = slot13
end

for slot12, slot13 in pairs(slot8) do
	slot1[slot12] = slot13
end

setmetatable(slot0, {
	__index = slot1
})

function slot0.Ctor(slot0, slot1)
	slot0:SetViewDataType(slot1)
end

function slot0.GetDataClassInstanceByType(slot0, slot1)
	if slot1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return ForeignInfoData
	elseif slot1 == HeroConst.HERO_DATA_TYPE.TRIAL or slot1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		return TempHeroData
	elseif slot1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return PolyhedronData
	elseif slot1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return AdvanceTestData
	elseif slot1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		return CooperationTools
	else
		return HeroData
	end
end

function slot0.GetHeroList(slot0)
	return slot0.dataClass:GetHeroList(slot0.tempHeroList)
end

function slot0.GetHeroData(slot0, slot1)
	slot2 = slot0.dataClass:GetHeroData(slot1, slot0.tempHeroList)

	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		slot3 = deepClone(slot2)
		slot3.star = HeroCfg[slot3.id].unlock_star

		return slot3
	end

	return slot2
end

function slot0.GetHeroIDList(slot0)
	return slot0.dataClass:GetHeroIDList(slot0.tempHeroList)
end

function slot0.GetEquipInfoList(slot0, slot1)
	return slot0.dataClass:GetEquipInfoList(slot1, slot0.tempHeroList)
end

function slot0.GetEquipDataList(slot0, slot1, slot2)
	slot3 = {}

	if not table.isEmpty(slot2) then
		for slot7, slot8 in ipairs(slot2) do
			table.insert(slot3, EquipData:GetEquipData(slot8.equip_id))
		end
	else
		slot3 = slot0.dataClass:GetEquipDataList(slot1, slot0.tempHeroList)
	end

	return slot3
end

function slot0.GetHeroServantInfo(slot0, slot1)
	return slot0.dataClass:GetHeroServantInfo(slot1, slot0.tempHeroList)
end

function slot0.GetHeroSkillInfoList(slot0, slot1)
	return slot0.dataClass:GetHeroSkillInfoList(slot1, slot0.tempHeroList)
end

function slot0.GetHeroTransitionInfoList(slot0, slot1)
	return slot0.dataClass:GetHeroTransitionInfoList(slot1, slot0.tempHeroList)
end

function slot0.GetHeroUsingSkinInfo(slot0, slot1)
	return slot0.dataClass:GetHeroUsingSkinInfo(slot1, slot0.tempHeroList)
end

function slot0.GetExFilterSorterFunc(slot0)
	return slot0.dataClass:GetExFilterSorterFunc()
end

function slot0.GetUIClassByType(slot0, slot1)
	return _G[ViewHeroConst.CLASS[slot1][slot0.viewDataType] or ViewHeroConst.CLASS[slot1][HeroConst.HERO_DATA_TYPE.DEFAULT]]
end

function slot0.GetUIPrefabByType(slot0, slot1)
	return ViewHeroConst.PREFAB[slot1][slot0.viewDataType] or ViewHeroConst.PREFAB[slot1][HeroConst.HERO_DATA_TYPE.DEFAULT]
end

function slot0.GetViewDataType(slot0)
	return slot0.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
end

function slot0.SetViewDataType(slot0, slot1)
	slot0.viewDataType = slot1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	slot0.dataClass = slot0:GetDataClassInstanceByType(slot0.viewDataType)

	slot0:SetViewPropertyByType(slot0.viewDataType)
end

function slot0.SetViewPropertyByType(slot0, slot1)
	slot0.unlockToggle = false
	slot0.showRedPoint = false
	slot0.showHeroHeadRedPoint = false
	slot0.showCurrencyWindowBar = false
	slot0.showInfoWindowBar = false
	slot0.disableSort = false
	slot0.showDetailBtn = false
	slot0.showfavorBtn = false
	slot0.hideChipToggle = false
	slot0.hideTransitionToggle = false
	slot0.hideModule = false
	slot0.hideCultureGrvureBtn = false
	slot0.hideServant = false
	slot0.hideFilterBtn = false
	slot0.isSelf = false
	slot0.isTemp = false
	slot0.notGotoAstrolabeAdjust = true
	slot0.isHideAstrolabeReset = false

	if slot1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		slot0.unlockToggle = true
		slot0.hideCultureGrvureBtn = true
		slot0.hideFilterBtn = true
		slot0.notGotoAstrolabeAdjust = false
		slot0.isHideAstrolabeReset = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		slot0.unlockToggle = true
		slot0.disableSort = true
		slot0.showDetailBtn = true
		slot0.hideChipToggle = true
		slot0.hideCultureGrvureBtn = true
		slot0.notGotoAstrolabeAdjust = false
		slot0.isTemp = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot0.unlockToggle = true
		slot0.disableSort = true
		slot0.showDetailBtn = true
		slot0.hideCultureGrvureBtn = true
		slot0.isTemp = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		slot0.showHeroHeadRedPoint = true
		slot0.unlockToggle = true
		slot0.showDetailBtn = true
		slot0.hideCultureGrvureBtn = true
		slot0.hideChipToggle = true
		slot0.hideTransitionToggle = true
		slot0.hideModule = true
		slot0.isTemp = true
		slot0.showRedPoint = false
	elseif slot1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		slot0.unlockToggle = true
		slot0.showDetailBtn = true
		slot0.hideCultureGrvureBtn = true
		slot0.isHideAstrolabeReset = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		slot0.unlockToggle = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
		slot0.hideServant = true
		slot0.isHideAstrolabeReset = true
	elseif slot1 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		slot0.showRedPoint = true
		slot0.showHeroHeadRedPoint = true
		slot0.showCurrencyWindowBar = false
		slot0.showInfoWindowBar = true
		slot0.showDetailBtn = true
		slot0.showfavorBtn = true
		slot0.isSelf = true
	end
end

function slot0.SetTempHeroList(slot0, slot1)
	slot0.tempHeroList = slot1
end

return slot0
