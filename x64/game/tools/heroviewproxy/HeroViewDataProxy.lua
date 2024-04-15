local var_0_0 = class("HeroViewDataProxy")
local var_0_1 = {}
local var_0_2 = require("game/tools/HeroViewProxy/ProxyFuction/ProPertyProxyFunc")
local var_0_3 = require("game/tools/HeroViewProxy/ProxyFuction/SkillProxyFunc")
local var_0_4 = require("game/tools/HeroViewProxy/ProxyFuction/WeaponProxyFunc")
local var_0_5 = require("game/tools/HeroViewProxy/ProxyFuction/ServantProxyFuc")
local var_0_6 = require("game/tools/HeroViewProxy/ProxyFuction/EquiptProxyFunc")
local var_0_7 = require("game/tools/HeroViewProxy/ProxyFuction/AstrolabeProxyFunc")
local var_0_8 = require("game/tools/HeroViewProxy/ProxyFuction/TransitionProxyFunc")

for iter_0_0, iter_0_1 in pairs(var_0_2) do
	var_0_1[iter_0_0] = iter_0_1
end

for iter_0_2, iter_0_3 in pairs(var_0_3) do
	var_0_1[iter_0_2] = iter_0_3
end

for iter_0_4, iter_0_5 in pairs(var_0_4) do
	var_0_1[iter_0_4] = iter_0_5
end

for iter_0_6, iter_0_7 in pairs(var_0_5) do
	var_0_1[iter_0_6] = iter_0_7
end

for iter_0_8, iter_0_9 in pairs(var_0_6) do
	var_0_1[iter_0_8] = iter_0_9
end

for iter_0_10, iter_0_11 in pairs(var_0_7) do
	var_0_1[iter_0_10] = iter_0_11
end

for iter_0_12, iter_0_13 in pairs(var_0_8) do
	var_0_1[iter_0_12] = iter_0_13
end

setmetatable(var_0_0, {
	__index = var_0_1
})

function var_0_0.Ctor(arg_1_0, arg_1_1)
	arg_1_0:SetViewDataType(arg_1_1)
end

function var_0_0.GetDataClassInstanceByType(arg_2_0, arg_2_1)
	if arg_2_1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		return ForeignInfoData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_2_1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		return TempHeroData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		return PolyhedronData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		return AdvanceTestData
	elseif arg_2_1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		return CooperationTools
	else
		return HeroData
	end
end

function var_0_0.GetHeroList(arg_3_0)
	return arg_3_0.dataClass:GetHeroList(arg_3_0.tempHeroList)
end

function var_0_0.GetHeroData(arg_4_0, arg_4_1)
	local var_4_0 = arg_4_0.dataClass:GetHeroData(arg_4_1, arg_4_0.tempHeroList)

	if arg_4_0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		local var_4_1 = deepClone(var_4_0)

		var_4_1.star = HeroCfg[var_4_1.id].unlock_star

		return var_4_1
	end

	return var_4_0
end

function var_0_0.GetHeroIDList(arg_5_0)
	return arg_5_0.dataClass:GetHeroIDList(arg_5_0.tempHeroList)
end

function var_0_0.GetEquipInfoList(arg_6_0, arg_6_1)
	return arg_6_0.dataClass:GetEquipInfoList(arg_6_1, arg_6_0.tempHeroList)
end

function var_0_0.GetEquipDataList(arg_7_0, arg_7_1, arg_7_2)
	local var_7_0 = {}

	if not table.isEmpty(arg_7_2) then
		for iter_7_0, iter_7_1 in ipairs(arg_7_2) do
			table.insert(var_7_0, EquipData:GetEquipData(iter_7_1.equip_id))
		end
	else
		var_7_0 = arg_7_0.dataClass:GetEquipDataList(arg_7_1, arg_7_0.tempHeroList)
	end

	return var_7_0
end

function var_0_0.GetHeroServantInfo(arg_8_0, arg_8_1)
	return arg_8_0.dataClass:GetHeroServantInfo(arg_8_1, arg_8_0.tempHeroList)
end

function var_0_0.GetHeroSkillInfoList(arg_9_0, arg_9_1)
	return arg_9_0.dataClass:GetHeroSkillInfoList(arg_9_1, arg_9_0.tempHeroList)
end

function var_0_0.GetHeroTransitionInfoList(arg_10_0, arg_10_1)
	return arg_10_0.dataClass:GetHeroTransitionInfoList(arg_10_1, arg_10_0.tempHeroList)
end

function var_0_0.GetHeroUsingSkinInfo(arg_11_0, arg_11_1)
	return arg_11_0.dataClass:GetHeroUsingSkinInfo(arg_11_1, arg_11_0.tempHeroList)
end

function var_0_0.GetExFilterSorterFunc(arg_12_0)
	return (arg_12_0.dataClass:GetExFilterSorterFunc())
end

function var_0_0.GetUIClassByType(arg_13_0, arg_13_1)
	return _G[ViewHeroConst.CLASS[arg_13_1][arg_13_0.viewDataType] or ViewHeroConst.CLASS[arg_13_1][HeroConst.HERO_DATA_TYPE.DEFAULT]]
end

function var_0_0.GetUIPrefabByType(arg_14_0, arg_14_1)
	return ViewHeroConst.PREFAB[arg_14_1][arg_14_0.viewDataType] or ViewHeroConst.PREFAB[arg_14_1][HeroConst.HERO_DATA_TYPE.DEFAULT]
end

function var_0_0.GetViewDataType(arg_15_0)
	return arg_15_0.viewDataType or HeroConst.HERO_DATA_TYPE.DEFAULT
end

function var_0_0.SetViewDataType(arg_16_0, arg_16_1)
	arg_16_0.viewDataType = arg_16_1 or HeroConst.HERO_DATA_TYPE.DEFAULT
	arg_16_0.dataClass = arg_16_0:GetDataClassInstanceByType(arg_16_0.viewDataType)

	arg_16_0:SetViewPropertyByType(arg_16_0.viewDataType)
end

function var_0_0.SetViewPropertyByType(arg_17_0, arg_17_1)
	arg_17_0.unlockToggle = false
	arg_17_0.showRedPoint = false
	arg_17_0.showHeroHeadRedPoint = false
	arg_17_0.showCurrencyWindowBar = false
	arg_17_0.showInfoWindowBar = false
	arg_17_0.disableSort = false
	arg_17_0.showDetailBtn = false
	arg_17_0.showfavorBtn = false
	arg_17_0.hideChipToggle = false
	arg_17_0.hideTransitionToggle = false
	arg_17_0.hideModule = false
	arg_17_0.hideCultureGrvureBtn = false
	arg_17_0.hideServant = false
	arg_17_0.hideFilterBtn = false
	arg_17_0.isSelf = false
	arg_17_0.isTemp = false
	arg_17_0.notGotoAstrolabeAdjust = true
	arg_17_0.isHideAstrolabeReset = false

	if arg_17_1 == HeroConst.HERO_DATA_TYPE.FOREIGN then
		arg_17_0.unlockToggle = true
		arg_17_0.hideCultureGrvureBtn = true
		arg_17_0.hideFilterBtn = true
		arg_17_0.notGotoAstrolabeAdjust = false
		arg_17_0.isHideAstrolabeReset = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.TRIAL then
		arg_17_0.unlockToggle = true
		arg_17_0.disableSort = true
		arg_17_0.showDetailBtn = true
		arg_17_0.hideChipToggle = true
		arg_17_0.hideCultureGrvureBtn = true
		arg_17_0.notGotoAstrolabeAdjust = false
		arg_17_0.isTemp = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_17_0.unlockToggle = true
		arg_17_0.disableSort = true
		arg_17_0.showDetailBtn = true
		arg_17_0.hideCultureGrvureBtn = true
		arg_17_0.isTemp = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		arg_17_0.showHeroHeadRedPoint = true
		arg_17_0.unlockToggle = true
		arg_17_0.showDetailBtn = true
		arg_17_0.hideCultureGrvureBtn = true
		arg_17_0.hideChipToggle = true
		arg_17_0.hideTransitionToggle = true
		arg_17_0.hideModule = true
		arg_17_0.isTemp = true
		arg_17_0.showRedPoint = false
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.ADVANCETEST then
		arg_17_0.unlockToggle = true
		arg_17_0.showDetailBtn = true
		arg_17_0.hideCultureGrvureBtn = true
		arg_17_0.isHideAstrolabeReset = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.COOPERATION then
		arg_17_0.unlockToggle = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.PREVIEW then
		arg_17_0.hideServant = true
		arg_17_0.isHideAstrolabeReset = true
	elseif arg_17_1 == HeroConst.HERO_DATA_TYPE.DEFAULT then
		arg_17_0.showRedPoint = true
		arg_17_0.showHeroHeadRedPoint = true
		arg_17_0.showCurrencyWindowBar = false
		arg_17_0.showInfoWindowBar = true
		arg_17_0.showDetailBtn = true
		arg_17_0.showfavorBtn = true
		arg_17_0.isSelf = true
	end
end

function var_0_0.SetTempHeroList(arg_18_0, arg_18_1)
	arg_18_0.tempHeroList = arg_18_1
end

return var_0_0
