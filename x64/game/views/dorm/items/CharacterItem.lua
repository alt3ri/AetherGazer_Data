slot0 = class("CharacterItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.flag = false

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController = ControllerUtil.GetController(slot0.transform_, "name")
	slot0.fatigueComtroller = ControllerUtil.GetController(slot0.transform_, "fatigue")
	slot0.skillComtroller = ControllerUtil.GetController(slot0.transform_, "skill")
	slot0.typeScroll = LuaList.New(handler(slot0, slot0.indexItem), slot0.uilistGo_, DormRecommendSmallItem)
	slot0.sameNameController = ControllerUtil.GetController(slot0.transform_, "sameName")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.characterbuttonBtn_, nil, function ()
		if uv0.chooseFunc and uv0.stateController:GetSelectedState() ~= "full" then
			uv0.chooseFunc(uv0.uid_, uv0.stateController, uv0.fatigueComtroller)
		end
	end)
end

function slot0.indexItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.attributeList[slot1], slot0.flag)
end

function slot0.RegistCallBack(slot0, slot1)
	if slot1 then
		slot0.chooseFunc = slot1
	end
end

function slot0.RegistFullListCallBack(slot0, slot1)
	if slot1 then
		slot0.fullListFunc = slot1
	end
end

function slot0.RefreshUI(slot0, slot1)
	slot0.entrustPosID = CanteenEntrustData:GetCurDispatchTask().pos
	slot0.uid_ = slot1

	if #slot0:CheckSkillCanOpen() > 0 then
		slot0.skillIcon.sprite = CanteenTools.GetCanteenSkillSprite(slot2[1])

		slot0.skillComtroller:SetSelectedState("true")
	else
		slot0.skillComtroller:SetSelectedState("false")
	end

	slot0.maxText_.text = "/" .. GameSetting.canteen_hero_fatigue_max.value[1]
	slot3 = DormData:GetHeroFatigue(slot1)
	slot0.curText_.text = slot3
	slot0.headiconImg_.sprite = DormHeroTools.GetBackHomeHeadSprite(slot0.uid_)
	slot0.progressImg_.fillAmount = 1 - math.min(slot3 / GameSetting.canteen_hero_fatigue_max.value[1], 1)

	if slot3 <= GameDisplayCfg.dorm_hero_fatigue_level.value[1] then
		slot0.fatigueComtroller:SetSelectedState("lack")
	elseif slot4[1] < slot3 and slot3 <= slot4[2] then
		slot0.fatigueComtroller:SetSelectedState("middle")
	else
		slot0.fatigueComtroller:SetSelectedState("full")
	end

	slot0:RefreshHeroAttributes(slot1)

	if CanteenEntrustData:CheckHasChooseEntrustCharacter(slot1) or DormData:GetHeroTemplateInfo(slot1).jobType ~= nil then
		slot0.stateController:SetSelectedState("full")

		return
	end

	slot0.sameNameController:SetSelectedState("false")

	if CanteenEntrustData:CheckDispatchCharacterArchiveList(slot1) and not CanteenEntrustData:CheckDispatchCharacterList(slot1) then
		slot0.sameNameController:SetSelectedState("true")
	end

	if CanteenEntrustData:CheckDispatchCharacterList(slot1) then
		slot0.stateController:SetSelectedState("select")

		slot0.flag = true
	else
		slot0.flag = false
	end

	slot0.fullListFunc(slot0.uid_, slot0.stateController)
end

function slot0.CheckSkillCanOpen(slot0)
	slot3 = {}

	for slot8 = 1, #BackHomeHeroCfg[slot0.uid_].skill_list do
		if GameSetting.dorm_hero_skill_unlock.value[slot8] <= HeroData:GetHeroData(slot0.uid_).level then
			table.insert(slot3, slot1[slot8])
		end
	end

	slot5 = {}

	for slot9, slot10 in ipairs(slot3) do
		if BackHomeHeroSkillCfg[slot10].condition and #slot12 > 0 then
			if slot12[1] == 3 then
				table.insert(slot5, slot10)
			end
		else
			table.insert(slot5, slot10)
		end
	end

	return slot5
end

function slot0.RefreshHeroAttributes(slot0, slot1)
	slot0.attributeList = {}
	slot2 = CanteenEntrustData:GetEntrustByPos(slot0.entrustPosID).tags
	slot0.attributeList = {
		{
			type = 1,
			tag = CharactorParamCfg[slot1].RangeType
		},
		{
			type = 2,
			tag = HeroCfg[slot1].race
		},
		{
			type = 3,
			tag = HeroCfg[slot1].ATK_attribute[1]
		},
		{
			type = 4,
			tag = HeroCfg[slot1].mechanism_type[1]
		}
	}

	slot0.typeScroll:StartScroll(#slot0.attributeList)

	slot0.uilistGo_:GetComponent("ScrollRectEx").vertical = false
end

function slot0.Dispose(slot0)
	if slot0.typeScroll then
		slot0.typeScroll:Dispose()
	end

	uv0.super.Dispose(slot0)
end

return slot0
