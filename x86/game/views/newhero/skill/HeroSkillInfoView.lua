slot0 = class("HeroSkillInfoView", HeroPageBase)
slot1 = {
	additionEx = {
		showState = {
			select = "select",
			name = "showState",
			lock = "lock",
			normal = "normal"
		}
	},
	infoShowEx = {
		upState = {
			none = "none",
			name = "upState",
			up = "up",
			notUp = "notup",
			max = "max"
		}
	}
}
slot2 = {
	NORMAL = 1,
	DETAIL = 2
}
slot3 = {
	"hero_skill_skill_lv_up_spirit",
	"hero_skill_skill_lv_up_module",
	"hero_skill_skill_lv_up_astrolabe",
	"hero_skill_skill_lv_up_attribute"
}

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform
	slot0.skillAdditionType = slot0.handler_.skillAdditionType

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
	slot0:CreateCostList()
	slot0:InitSkillAddition()

	slot0.upStateController_ = slot0.infoControllerexcollection_:GetController(uv0.infoShowEx.upState.name)
	slot0.propertIconList = {}

	for slot4 = 1, slot0.properylistTrs_.childCount do
		slot0.propertIconList[slot4] = slot0[string.format("properyicon%sImg_", slot4)]
	end

	slot0.describeCanvas = slot0.describeTrs_:GetComponent(typeof(Canvas))
end

function slot0.CreateCostList(slot0)
	slot0.costItem = {}

	for slot4 = 1, 2 do
		slot0.costItem[slot4] = CommonItemView.New(slot0["costitem" .. slot4 .. "Go_"])
	end
end

function slot0.RefreshCost(slot0)
	slot0.costCfg = SkillCfg[slot0.level]["skill_cost" .. SkillTools.GetSkillIdIndex(slot0.skillId)]
	slot0.costEnough = true

	for slot5 = 1, 2 do
		if slot0.costCfg and slot0.costCfg[slot5] then
			slot0.costItem[slot5].gameObject_:SetActive(true)

			slot7 = slot0.costCfg[slot5][2]

			if slot0.tempAddLevel and slot0.tempAddLevel > 0 then
				slot8 = ItemTools.getItemNum(slot0.costCfg[slot5][1]) - SkillTools.GetSkillUpCostNum(slot0.skillId, slot0.skillLevel, slot0.tempAddLevel)[slot6]
			end

			if slot7 > slot8 then
				slot0.costEnough = false
			end

			slot9 = clone(ItemTemplateData)
			slot9.id = slot6

			function slot9.clickFun(slot0)
				ShowPopItem(POP_SOURCE_ITEM, {
					slot0.id,
					slot0.number
				})
			end

			slot0.costItem[slot5]:SetData(slot9)
			slot0.costItem[slot5]:RefreshBottomText({
				slot8,
				slot7
			})
			slot0.costItem[slot5]:RefreshBottomRightText(true)
		else
			slot0.costItem[slot5].gameObject_:SetActive(false)
		end
	end
end

function slot0.SetDescribeCanvasSort(slot0, slot1)
	slot0.describeCanvas.overrideSorting = slot1
end

function slot0.OpenAddTipsView(slot0, slot1, slot2)
	slot0:SetDescribeCanvasSort(true)

	if not gameContext:IsOpenRoute("skillAddTip") then
		JumpTools.OpenPageByJump("skillAddTip", {
			heroId = slot0.heroId,
			showType = slot1,
			showTextList = slot2,
			dataType = slot0.heroViewDataProxy:GetViewDataType(),
			backBtnCallback = function ()
				uv0:SetDescribeCanvasSort(false)
				uv0:ClearSkillAddSelect()
			end
		})
	else
		manager.notify:CallUpdateFunc(HERO_SKILL_ADD_VIEW_UPDATE, {
			heroId = slot0.heroId,
			showType = slot1,
			showTextList = slot2
		})
	end
end

function slot0.GetAdditionValue(slot0, slot1)
	slot2, slot3 = slot0.heroViewDataProxy:GetAdditionShowTextByType(slot0.skillId, slot0.heroId, slot1)

	return slot2, slot3
end

function slot0.OnClickSkillAdditionItem(slot0, slot1)
	slot0:ClearSkillAddSelect()
	slot0:OpenAddTipsView(slot1, slot0.additionControDataList[slot1].value)
	slot0.additionControDataList[slot1].controller:SetSelectedState(uv0.additionEx.showState.select)

	slot0.selectAdditionIndex = slot1
end

function slot0.ClearSkillAddSelect(slot0)
	if slot0.selectAdditionIndex then
		slot0.additionControDataList[slot0.selectAdditionIndex].controller:SetSelectedState(uv0.additionEx.showState.normal)
	end

	slot0.selectAdditionIndex = nil
end

function slot0.InitSkillAddition(slot0)
	slot0.additionControDataList = {}

	for slot4 = 1, 4 do
		slot5 = slot0["addition" .. slot4 .. "Btn_"]
		slot0.additionControDataList[slot4] = {
			controller = slot0["addition" .. slot4 .. "Controllerexcollection_"]:GetController(uv0.additionEx.showState.name),
			value = nil,
			obj = slot5.gameObject
		}

		slot0:AddBtnListener(slot5, nil, function ()
			OperationRecorder.RecordButtonTouch(uv0[uv1])
			uv2:OnClickSkillAdditionItem(uv1)
		end)
	end
end

function slot0.SendSkillUpgrade(slot0)
	if slot0.tempAddLevel and slot0.tempAddLevel > 0 then
		HeroAction.HeroSkillUpgrade(slot0.heroId, slot0.skillId, slot0.tempAddLevel)
	end
end

function slot0.isCanUpSkill(slot0)
	if SkillTools.GetIsDodgeSkill(slot0.skillId) or slot0.level == HeroConst.MAX_SKILL_LEVEL then
		slot0:SendSkillUpgrade()

		return false
	end

	if slot0.heroViewDataProxy:GetHeroData(slot0.heroId).break_level < SkillCfg[slot0.level]["skill_limit" .. SkillTools.GetSkillIdIndex(slot0.skillId)] then
		slot0:SendSkillUpgrade()

		return false
	end

	if not slot0.costEnough then
		slot0:SendSkillUpgrade()
		ShowTips("ERROR_HERO_NO_SKILL_UP_MAT")

		return false
	end

	slot0.tempAddLevel = (slot0.tempAddLevel or 0) + 1

	slot0:tempRefreshUi()

	return true
end

function slot0.SetTempRefreshCallback(slot0, slot1)
	slot0.tempRefreshCallback = slot1
end

function slot0.tempRefreshUi(slot0)
	slot0:RefreshUi()

	slot1 = slot0:GetSkillLv()

	if slot0.tempRefreshCallback then
		slot0.tempRefreshCallback(slot0.skillId, slot0.tempAddLevel, SkillTools.GetSkillUpCostNum(slot0.skillId, slot0.skillLevel, slot0.tempAddLevel))
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddPressingByTimeListener(slot0.upbtnBtn_.gameObject, 1.4, 0.2, 0.1, function ()
		return uv0:isCanUpSkill()
	end, handler(slot0, slot0.SendSkillUpgrade))
	slot0:AddBtnListener(slot0.recommendBtn_, nil, function ()
		uv0:ChangeSkillDescState()
	end)
	slot0:AddBtnListener(slot0.breakUpBtn_, nil, function ()
		if uv0.upStateController_:GetSelectedState() == uv1.infoShowEx.upState.notUp then
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = uv0.heroId,
				proxy = uv0.heroViewDataProxy
			})
		end
	end)
	TerminologyTools.AddTerminologyHandler(slot0, slot0.describetextText_, nil, )
end

function slot0.OnHeroSkillUpgrade(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("SKILL_UPGRATE_SUCCESS", string.format("LEVEL\n<size=60>%s</size>", slot0.level))
		slot0:PlayHeroTalk(slot0.heroId)
	else
		ShowTips(slot1.result)
	end

	slot0.skillLevel = nil
	slot0.tempAddLevel = 0

	slot0:RefreshUi()
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.isTalkCD_ then
		return
	end

	HeroTools.PlayTalk(slot1, "skillup")

	slot0.isTalkCD_ = true
	slot0.talkCDTimer_ = Timer.New(function ()
		uv0.isTalkCD_ = false
	end, HeroConst.SKILL_UPGRADE_VOICE_CD, 1)

	slot0.talkCDTimer_:Start()
end

function slot0.UpdateSkillData(slot0, slot1, slot2)
	slot3 = slot1.id
	slot4 = slot1.heroId
	slot0.skillId = slot3
	slot0.heroId = slot4
	slot0.realSkillId = slot0.heroViewDataProxy:GetRealSkillId(slot4, slot3)
	slot0.addSkillLv = slot1.addSkillLv
	slot0.addEquipSkillLv = slot1.addEquipSkillLv or 0
	slot0.tempAddLevel = 0
	slot0.skillLevel = 0

	slot0:RefreshUi()
	slot0:RefreshAddition()

	if slot2 then
		slot0.rootAnimator_:Play("Fx_Common_right_cx", -1, 0)
	end
end

function slot0.RefreshUi(slot0)
	slot0.skillnameText_.text = HeroSkillCfg[slot0.realSkillId].name
	slot0.subnameText_.text = HeroCfg[slot0.heroId].skill_subhead[SkillTools.GetSkillIdIndex(slot0.skillId)]
	slot0.level = slot0:GetSkillLv()

	if slot0.addEquipSkillLv > 0 then
		slot0.lvText_.text = string.format("%d<color=#484C51>+</color>%d", slot0.level + slot0.addSkillLv, slot0.addEquipSkillLv)
	else
		slot0.lvText_.text = string.format("<color=#484C51>%d</color>", slot4 + slot0.addSkillLv)
	end

	slot0:UpdateUpStateController()
	slot0:RefreshCost()
	slot0:UpdateElemShow(slot1)
	slot0:UpdateSkillDescShow()
end

function slot0.OnEnter(slot0, slot1)
	slot0.heroViewDataProxy = slot1
	slot0.descType_ = uv0.NORMAL
	slot0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")

	slot0:SetDescribeCanvasSort(false)
end

function slot0.UpdateUpStateController(slot0)
	if not slot0.heroViewDataProxy:CheckIsSelf() or SkillTools.GetIsDodgeSkill(slot0.skillId) then
		slot0.upStateController_:SetSelectedState(uv0.infoShowEx.upState.none)

		return
	end

	if slot0:RefreshCondition() then
		slot0.upStateController_:SetSelectedState(uv0.infoShowEx.upState.notUp)
	elseif HeroConst.MAX_SKILL_LEVEL <= slot0.level then
		slot0.upStateController_:SetSelectedState(uv0.infoShowEx.upState.max)
	else
		slot0.upStateController_:SetSelectedState(uv0.infoShowEx.upState.up)
	end
end

function slot0.UpdateElemShow(slot0, slot1)
	slot2 = slot1.element_type

	if slot1.cd == 0 then
		slot0.cdvalueText_.text = " - "
	else
		slot0.cdvalueText_.text = slot1.cd / 1000 .. "s"
	end

	slot0.costGo_:SetActive(false)
	slot0.skilltypeGo_:SetActive(false)

	for slot6, slot7 in pairs(slot0.propertIconList) do
		if slot2[slot6] then
			slot7.enabled = true
			slot7.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[slot8].icon)
		else
			slot7.enabled = false
		end
	end

	if slot1.EnergyChange < 0 then
		slot0.costvalueText_.text = math.abs(slot1.EnergyChange) .. " " .. GetTips("NOTE_ENERGYTYPE_" .. CharactorParamCfg[slot0.heroId].EnergyType)

		slot0.costGo_:SetActive(true)

		slot3 = 2 + 1
	end

	if PublicSkillCfg[slot0.skillId].skill_sub_type == nil then
		slot4 = 0
	end

	if slot4 ~= 0 then
		slot0.skilltypevalueText_.text = GetI18NText(SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[slot4][1]].annotation)

		slot0.skilltypeGo_:SetActive(true)

		slot3 = slot3 + 1
	end

	slot5 = -187

	if slot3 == 3 then
		slot5 = -237
	elseif slot3 == 4 then
		slot5 = -287
	end

	slot0.descviewTrs_.sizeDelta = Vector2(slot0.descviewTrs_.sizeDelta.x, slot0.infonodeTrs_.rect.height + slot5)
end

function slot0.RefreshAddition(slot0)
	for slot4 = 1, 4 do
		if slot0:UpdateTargetCondition(slot4) then
			isShowNode = slot5
		end
	end
end

function slot0.RefreshCondition(slot0)
	slot2 = SkillCfg[slot0.level]["skill_limit" .. SkillTools.GetSkillIdIndex(slot0.skillId)]
	slot3 = slot0.heroViewDataProxy:GetHeroData(slot0.heroId)
	slot4 = false

	if slot0.level and slot2 and slot0.level < HeroConst.MAX_SKILL_LEVEL and slot3.break_level < slot2 then
		slot0.conditiondescireText_.text = string.format(GetTips("NOTE_SKILL_LIMIT"), slot2)
		slot0.conditionvalueText_.text = string.format("%s/%s", slot3.break_level, slot2)
		slot4 = true
	end

	return slot4
end

function slot0.UpdateTargetCondition(slot0, slot1)
	slot3, slot4 = slot0:GetAdditionValue(slot1)

	SetActive(slot0.additionControDataList[slot1].obj, slot4)

	if slot3 then
		slot0.additionControDataList[slot1].controller:SetSelectedState(uv0.additionEx.showState.normal)
	else
		slot2:SetSelectedState(uv0.additionEx.showState.lock)
	end

	slot0.additionControDataList[slot1].value = slot3

	return slot4
end

function slot0.GetSkillLv(slot0)
	if not slot0.skillLevel or slot0.skillLevel == 0 then
		slot0.skillLevel = slot0.heroViewDataProxy:GetSkillLv(slot0.heroId, slot0.skillId)
	end

	return slot0.skillLevel + (slot0.tempAddLevel or 0)
end

function slot0.ChangeSkillDescState(slot0, slot1)
	if slot1 then
		slot0.descType_ = slot1
	elseif slot0.descType_ == uv0.NORMAL then
		slot0.descType_ = uv0.DETAIL
		slot0.detailTxt_.text = GetTips("SERVANT_DETAIL_SIMPLE")
	else
		slot0.descType_ = uv0.NORMAL
		slot0.detailTxt_.text = GetTips("SERVANT_DETAIL_FULL")
	end

	slot0:UpdateSkillDescShow()
end

function slot0.UpdateSkillDescShow(slot0)
	slot1 = ""
	slot0.describetextText_.text = string.format("%s%s", (slot0.descType_ ~= uv0.NORMAL or HeroSkillCfg[slot0.realSkillId].simpleDesc) and slot0.heroViewDataProxy:GetSkillDesc(slot0.realSkillId, slot0.level + slot0.addSkillLv + slot0.addEquipSkillLv, SkillTools.GetIsDodgeSkill(slot0.skillId)), "\n")

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.describetextText_.transform)
end

function slot0.Dispose(slot0)
	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	for slot4, slot5 in pairs(slot0.costItem or {}) do
		if slot5 then
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
