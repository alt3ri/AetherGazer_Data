slot0 = class("HeroSkillPropertyView", HeroPageBase)
slot1 = {
	showState = {
		max = "max",
		up = "up",
		notup = "notup",
		none = "none"
	}
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:CreateCostList()
	slot0:AddUIListener()

	slot0.stateController_ = slot0.controllerexcollection_:GetController("state")
end

function slot0.CreateCostList(slot0)
	slot0.costItem = {}

	for slot4 = 1, 4 do
		slot0.costItem[slot4] = CommonItemView.New(slot0["costitem" .. slot4 .. "Go_"])
	end

	slot0.attrItemList = {}

	for slot4 = 1, 4 do
		slot0.attrItemList[slot4] = HeroSkillAttrItem.New(slot0["attr" .. slot4 .. "Go_"])
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddPressingByTimeListener(slot0.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function ()
		if not uv0:isCanUpSkill() or uv0.level + uv0.tempAddLevel_ == HeroConst.MAX_SKILL_ATTR_LEVEL then
			uv0:SendSkillAttrUpgrade()

			return false
		end

		if not uv0.costEnough then
			uv0:SendSkillAttrUpgrade()
			ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

			return false
		end

		uv0.tempAddLevel_ = (uv0.tempAddLevel_ or 0) + 1

		uv0:SendSkillAttrUpgrade()
		uv0:RefreshUi()

		return true
	end, handler(slot0, slot0.SendSkillAttrUpgrade))
	slot0:AddBtnListener(slot0.limitBtn_, nil, function ()
		ShowTips("NOTE_SKILL_ATTR_LIMIT")
	end)
end

function slot0.isCanUpSkill(slot0)
	if SkillTools.GetIsDodgeSkill(slot0.skillId) or not slot0.nextAttrCfg then
		return false
	end

	return true
end

function slot0.SendSkillAttrUpgrade(slot0)
	if slot0.tempAddLevel_ and slot0.tempAddLevel_ > 0 then
		HeroAction.HeroSkillAttrUpgrade(slot0.heroId, slot0.skillIndex, slot0.tempAddLevel_)
	end
end

function slot0.OnHeroSkillAttrUpgradeInView(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("SKILL_ATTR_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", slot0.level))
		SetActive(slot0.lvbgGo_, false)
		SetActive(slot0.lvbgGo_, true)
		slot0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	else
		ShowTips(slot1.result)
	end

	slot0.tempAddLevel_ = 0

	slot0:RefreshUi()
end

function slot0.UpdatePropertyData(slot0, slot1, slot2)
	slot0:InitData(slot1)

	if slot2 then
		slot0.switchIconAnimator_:Play("Fx_right_huan_change", -1, 0)
	end

	slot0.skilliconImg_.sprite = getSprite("Atlas/" .. slot0.heroId, slot0.realSkillId)

	if SkillTools.GetIsDodgeSkill(slot0.skillId) then
		slot0:RefreshAttrList()
		slot0.stateController_:SetSelectedState(uv0.showState.none)
	else
		slot0:RefreshUi()
	end
end

function slot0.InitData(slot0, slot1)
	slot2 = slot1.id
	slot3 = slot1.heroId
	slot0.skillId = slot2
	slot0.heroId = slot3
	slot0.realSkillId = slot0.heroViewDataProxy:GetRealSkillId(slot3, slot2)
	slot0.skillIndex = SkillTools.GetSkillIdIndex(slot2)
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewDataProxy = slot1
	slot0.tempAddLevel_ = 0
end

function slot0.RefreshUi(slot0)
	slot1 = slot0.heroViewDataProxy:GetSkillAttrLv(slot0.heroId, slot0.skillIndex) + slot0.tempAddLevel_
	slot0.level = slot1
	slot0.attrCfg = SkillTools.GetSkillAttrCfg(slot0.heroId, slot0.skillIndex, slot1)
	slot0.nextAttrCfg = SkillTools.GetSkillAttrCfg(slot0.heroId, slot0.skillIndex, slot1 + 1)

	slot0:RefreshCost()
	slot0:RefreshAttrList()
	slot0:UpdateUpStateController()

	slot0.lvNowText_.text = slot0.level
	slot0.lvLaterText_.text = slot0.level + 1
	slot0.sliderSlr_.value = slot0.heroViewDataProxy:GetSkillAtrrProgressValue(slot0.heroId, slot0.skillIndex, slot0.level)
end

function slot0.UpdateUpStateController(slot0)
	if not slot0.heroViewDataProxy:CheckIsSelf() then
		slot0.stateController_:SetSelectedState(uv0.showState.none)

		return
	end

	if slot0:RefreshCondition() then
		slot0.stateController_:SetSelectedState(uv0.showState.notup)
	elseif not slot0.nextAttrCfg then
		slot0.stateController_:SetSelectedState(uv0.showState.max)
	else
		slot0.stateController_:SetSelectedState(uv0.showState.up)
	end
end

function slot0.RefreshCondition(slot0)
	slot1 = slot0.skillIndex
	slot2 = slot0.heroViewDataProxy:GetHeroData(slot0.heroId)
	slot4 = false

	if slot0.heroViewDataProxy:GetSkillLv(slot0.heroId, slot0.skillId) < HeroConst.MAX_SKILL_LEVEL then
		slot0.conditiondescireText_.text = GetTips("NOTE_SKILL_ATTR_LIMIT")
		slot0.conditionvalueText_.text = string.format("%s/%s", slot3, HeroConst.MAX_SKILL_LEVEL)
		slot4 = true
	end

	return slot4
end

function slot0.RefreshCost(slot0)
	slot0.costCfg = slot0.nextAttrCfg and slot0.nextAttrCfg.cost or nil
	slot0.costEnough = true

	for slot4 = 1, 4 do
		if slot0.costCfg and slot0.costCfg[slot4] then
			slot0.costItem[slot4].gameObject_:SetActive(true)

			slot5 = slot0.costCfg[slot4][1]
			slot6 = slot0.costCfg[slot4][2]
			slot7 = ItemTools.getItemNum(slot5)
			slot8 = clone(ItemTemplateData)
			slot8.id = slot5
			slot8.number = slot6

			function slot8.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.costItem[slot4]:SetData(slot8)
			slot0.costItem[slot4]:RefreshBottomText({
				slot7,
				slot6
			})
			slot0.costItem[slot4]:RefreshBottomRightText(true)

			if slot7 < slot6 then
				slot0.costEnough = false
			end
		else
			slot0.costItem[slot4].gameObject_:SetActive(false)
		end
	end
end

function slot0.RefreshAttrList(slot0)
	slot6 = false
	slot2 = {}

	for slot6, slot7 in pairs(slot0:GetAttrDataList(slot0:GetAttrDataList({}, true), slot6)) do
		table.insert(slot2, slot7)
	end

	function slot6(slot0, slot1)
		return slot0.attrType < slot1.attrType
	end

	table.sort(slot2, slot6)

	for slot6, slot7 in pairs(slot0.attrItemList) do
		if slot2[slot6] then
			SetActive(slot7.gameObject_, true)
			slot7:RefreshUI(slot8, slot0.heroViewDataProxy:CheckIsSelf())
		else
			SetActive(slot7.gameObject_, false)
		end
	end
end

function slot0.GetAttrDataList(slot0, slot1, slot2)
	slot3 = nil

	if (not slot2 or slot0.attrCfg) and slot0.nextAttrCfg then
		for slot7, slot8 in pairs(slot3.attr) do
			slot10 = slot8[2]

			if not slot1[slot8[1]] then
				slot1[slot9] = {
					nowValue = 0,
					nextValue = 0,
					attrType = slot9
				}
			end

			if slot2 then
				slot1[slot9].nowValue = slot10
			else
				slot1[slot9].nextValue = slot10
			end
		end
	end

	return slot1
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.attrItemList or {}) do
		if slot5 then
			slot5:Dispose()
		end
	end

	for slot4, slot5 in pairs(slot0.costItem or {}) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
