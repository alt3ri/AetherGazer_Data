slot0 = class("SkillDescriptionView", ReduxView)

function slot0.SetActive(slot0, slot1)
	if slot0.gameObject_ then
		SetActive(slot0.gameObject_, slot1)
	end
end

function slot0.Ctor(slot0, slot1, slot2, slot3)
	slot0.hander_ = slot1
	slot0.transform_ = slot2.transform
	slot0.gameObject_ = slot2
	slot0.stageData = slot3

	slot0:Init()
end

function slot0.IsInTable(slot0, slot1, slot2)
	for slot6, slot7 in ipairs(slot2) do
		if slot7 == slot1 then
			return true, slot6
		end
	end

	return false
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
	slot0:OnEnter()
end

function slot0.GetSkills(slot0, slot1, slot2, slot3)
	slot6 = slot2.astrolabe
	slot7 = {
		[slot12[1]] = slot12[3]
	}

	for slot11, slot12 in ipairs(HeroCfg[slot1].equip_orange_skill) do
		if slot0:IsInTable(slot2.weaponEffectID, WeaponServantCfg[slot12[2]].effect) then
			-- Nothing
		end
	end

	for slot11, slot12 in ipairs(slot4.astrolabe_skill) do
		for slot16 = 0, slot6.Length - 1 do
			if slot12[2] == slot6[slot16] then
				slot7[slot12[1]] = slot12[3]

				break
			end
		end
	end

	slot8, slot9 = slot0.stageData:GetHeroTeam()
	slot10 = nil

	if slot9[1] ~= nil and slot9[1] > 0 then
		HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.TRIAL):SetTempHeroList({
			slot9[1]
		})
	elseif slot8[1] ~= nil and slot8[1] > 0 then
		HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT):SetTempHeroList({
			slot8[1]
		})
	end

	slot11 = {}

	for slot15, slot16 in ipairs(slot4.skills) do
		if slot16 ~= 0 then
			slot17 = {
				id = slot16,
				id = slot7[slot16]
			}

			if slot7[slot16] then
				-- Nothing
			end

			slot19 = 1

			if not SkillTools.GetIsDodgeSkill(slot17.id) then
				slot19 = slot2.skillLevel[slot15 - 1]
			end

			slot17.desc = slot10:GetSkillDesc(slot17.id, slot19, true)
			slot17.desc = string.gsub(slot17.desc, "\n\n", "\n")

			if not HeroSkillCfg[slot17.id] then
				CustomLog.Log(debug.traceback(string.format("nil")))
			end

			slot17.name = HeroSkillCfg[slot17.id].name
			slot17.ele = HeroSkillCfg[slot17.id].element_type
			slot17.sprite = getSprite("Atlas/" .. slot1, slot17.id)
			slot17.subType = PublicSkillCfg[slot17.id].skill_sub_type

			if slot17.subType == nil then
				slot17.subType = 0
			end

			slot17.subType = SkillSubTypeCfg[SkillSubTypeCfg.get_id_list_by_value[slot17.subType][1]].annotation
			slot17.type = slot4.skill_subhead[slot15]

			table.insert(slot11, slot17)
		end
	end

	return slot11
end

function slot0.RefreshSkills(slot0)
	for slot4, slot5 in ipairs(slot0.skills) do
		slot6 = Object.Instantiate(slot0.explainSkillTplGo_, slot0.suitcontentSkillTrs_)
		slot6.transform:Find("skill/bg/icon"):GetComponent("Image").sprite = slot5.sprite
		slot6.transform:Find("Adaptation/name/text"):GetComponent("Text").text = GetI18NText(slot5.type)
		slot6.transform:Find("Adaptation/nametext"):GetComponent("Text").text = GetI18NText(slot5.name)
		slot6.transform:Find("Adaptation/describetext"):GetComponent("Text").text = GetI18NText(slot5.desc)

		if slot5.ele ~= "" then
			if slot5.ele ~= nil then
				for slot14, slot15 in pairs(slot5.ele) do
					if slot6.transform:Find("Adaptation/nametext/element_icon_" .. slot14) and slot16:GetComponent("Image") and SkillElementCfg[slot15].icon and slot18 ~= "" then
						SetActive(slot16.gameObject, true)

						slot17.sprite = getSprite("Atlas/Hero_arrtAtlas", SkillElementCfg[slot15].icon)
					end
				end
			end
		end

		SetActive(slot6, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitcontentSkillTrs_)
	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitcontentSkillTrs_)

	slot0.timerSkill_ = FrameTimer.New(function ()
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentSkillTrs_)
		UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentSkillTrs_)
	end, 1, 1)

	slot0.timerSkill_:Start()
end

function slot0.GetRecommendCombo(slot0, slot1)
	slot3 = {}

	for slot7, slot8 in ipairs(HeroCfg[slot1].recommend_combo) do
		table.insert(slot3, SkillComboRecommenderCfg[slot8])
	end

	return slot3
end

function slot0.RefreshCombos(slot0, slot1)
	for slot5, slot6 in ipairs(slot0.combos) do
		slot7 = Object.Instantiate(slot0.explainComboTplGo_, slot0.suitcontentComboTrs_)
		slot8 = slot7.transform:Find("nametext"):GetComponent("Text")
		slot10 = slot7.transform:Find("panel")
		slot11 = slot7.transform:Find("panel/skill").gameObject

		if slot6.desc and slot6.desc ~= "" then
			slot7.transform:Find("describetext"):GetComponent("Text").text = GetI18NText(slot6.desc)
		else
			slot9.gameObject:SetActive(false)
		end

		slot8.text = GetI18NText(slot6.name)

		if slot6.list_icon[1] then
			for slot16, slot17 in ipairs(slot6.list_icon) do
				slot18 = Object.Instantiate(slot11, slot10)
				slot18.transform:Find("bg/icon"):GetComponent("Image").sprite = getSprite("Atlas/" .. slot1, slot6.list_icon[slot16])
				slot18.transform:Find("name/text"):GetComponent("Text").text = GetI18NText(slot6.list_name[slot16])

				SetActive(slot18, true)

				if #slot6.list_icon ~= slot16 then
					if slot6.combine_char[slot16] == "或" then
						slot18.transform:Find("sign"):GetComponent("Image").enabled = false
						slot18.transform:Find("text"):GetComponent("Text").text = GetTips("TIP_OR")
					else
						slot21.enabled = true
						slot21.sprite = getSprite("Atlas/Setting", slot6.combine_char[slot16])
						slot22.text = ""
					end
				else
					slot21.enabled = false
					slot22.text = ""
				end
			end
		else
			slot10.gameObject:SetActive(false)
		end

		SetActive(slot7, true)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.suitcontentSkillTrs_)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.explainController = ControllerUtil.GetController(slot0.explainGo_.transform, "name")
	slot0.technicController = ControllerUtil.GetController(slot0.technicGo_.transform, "name")
	slot0.nType = 1

	if SkinCfg[GetSceneDataForExcehange().roleDataInLua[0].ID].hero == 10079 or slot3 == 10025 then
		return
	end

	if slot0.stageData and slot0.stageData:GetIsCooperation() then
		for slot9, slot10 in ipairs(slot0.stageData:GetRoleDatas()) do
			if tostring(slot10.UID) == tostring(PlayerData:GetPlayerInfo().userID) then
				slot3 = SkinCfg[slot10.ID].hero
			end
		end
	end

	slot0.skills = slot0:GetSkills(slot3, slot2)

	slot0:RefreshSkills()

	slot0.combos = slot0:GetRecommendCombo(slot3)

	slot0:RefreshCombos(slot3)
end

function slot0.AddUIListener(slot0)
	slot0:AddToggleListener(slot0.explainTgl_, function (slot0)
		SetActive(uv0.skillpanelGo_, slot0)
		uv0.explainController:SetSelectedIndex(slot0 and 0 or 1)
		uv0.technicController:SetSelectedIndex(slot0 and 1 or 0)

		if slot0 then
			OperationRecorder.Record("battle", "skillExplain")

			if uv0.hander_.RecordStaySkill then
				uv0.hander_:RecordStaySkill(2)
			end

			uv0.nType = 1
		end
	end)
	slot0:AddToggleListener(slot0.technicTgl_, function (slot0)
		SetActive(uv0.recommendpanelGo_, slot0)
		uv0.explainController:SetSelectedIndex(slot0 and 1 or 0)
		uv0.technicController:SetSelectedIndex(slot0 and 0 or 1)

		if slot0 then
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentComboTrs_)
			UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.suitcontentComboTrs_)
			OperationRecorder.Record("battle", "recommend")

			if uv0.hander_.RecordStaySkill then
				uv0.hander_:RecordStaySkill(1)
			end

			uv0.nType = 2
		end
	end)
end

function slot0.OnEnter(slot0)
	slot3 = SkinCfg[GetSceneDataForExcehange().roleDataInLua[0].ID].hero
	slot0.explainTgl_.isOn = true
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	if slot0.timerSkill_ then
		slot0.timerSkill_:Stop()
	end

	slot0.hander_ = nil
	slot0.data = nil
end

return slot0
