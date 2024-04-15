slot0 = class("HeroTrammelsView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_coop/HeroCoopUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.select_net = 1
	slot0.comboId = 1
	slot0.threeTeamskillController = ControllerUtil.GetController(slot0.transform_, "threeTeamskill")
	slot0.pageController = ControllerUtil.GetController(slot0.transform_, "page")
	slot0.storyController = ControllerUtil.GetController(slot0.transform_, "story")
	slot0.showComboController = ControllerUtil.GetController(slot0.transform_, "showCombo")
	slot0.lvupController = ControllerUtil.GetController(slot0.m_comboInfoTrans, "lvup")
	slot0.comboMaxLvController = ControllerUtil.GetController(slot0.m_comboInfoTrans, "comboMaxLv")
	slot0.attrList = LuaList.New(handler(slot0, slot0.IndexAttrItem), slot0.m_attrList, HeroTrammelsAttrItem)
	slot0.netMissionList = LuaList.New(handler(slot0, slot0.IndexNetMissionItem), slot0.m_netMissionList, HeroTrammelsNetMissionItem)
	slot0.netPartnerList = LuaList.New(handler(slot0, slot0.IndexNetPartnerItem), slot0.m_netPartnerList, HeroTrammelsNetPartnerItem)
	slot5 = HeroTrammelsComboMissionItem
	slot0.comboMissionList = LuaList.New(handler(slot0, slot0.IndexComboMissionItem), slot0.m_comboMissionList, slot5)
	slot0.switchNetItems = {}

	for slot5 = 1, 5 do
		slot7 = HeroTrammelsSwitchNetItem.New(Object.Instantiate(slot0.m_netSwitchGo, slot0.m_netSwitchContent), slot5)

		slot7:RegistCallBack(handler(slot0, slot0.SwitchNetClick))
		table.insert(slot0.switchNetItems, slot7)
	end

	slot0.comboClickHanle = handler(slot0, slot0.ComboClick)
	slot0.comboItems = {}
	slot0.partnerClickHandle = handler(slot0, slot0.PartnerClick)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.m_netBtn, function ()
		uv0.pageController:SetSelectedIndex(0)
	end)
	slot0:AddBtnListener(nil, slot0.m_comboBtn, function ()
		uv0.pageController:SetSelectedIndex(1)
	end)
	slot0:AddBtnListener(nil, slot0.m_storyBtn, function ()
		manager.story:StartStoryById(uv0.storyId, function (slot0)
			if not ArchiveData:GetRelationStoryRead(uv0.relationId) then
				ArchiveAction.QueryRelationStoryReward(uv0.relationId)
			end
		end)
	end)
	slot0:AddBtnListener(nil, slot0.m_coopBtn, function ()
		if table.indexof(ComboSkillTools.GetHeroComboSkill(uv0.heroId), uv0:GetComboSkillId(uv0.heroId, uv0.targetId)) then
			uv0.comboId = slot1
		end

		uv0:RefreshCombo()
		uv0.pageController:SetSelectedIndex(1)
	end)
	slot0:AddBtnListener(nil, slot0.m_comboUpLevelBtn, function ()
		if uv0.comboId == 0 then
			return
		end

		if ComboSkillData:GetCurComboSkillLevel(uv0.comboId) < ComboSkillTools.GetMaxComboSkillLevel(uv0.comboId) then
			slot3 = true

			for slot7, slot8 in ipairs(ComboSkillLevelCfg.get_id_list_by_level[slot1]) do
				if not ComboSkillTools.CheckComboSkillUpContion(slot8, uv0.comboId) then
					slot3 = false

					break
				end
			end

			if slot3 then
				ComboSkillAction.QueryUpgradeComboSkillLevel(uv0.comboId)
			else
				ShowTips("HERO_COMBO_SKILL_LEVEL_UP_FAIL")
			end
		end
	end)
	slot0:AddBtnListener(nil, slot0.m_targetHeroBtn, function ()
		JumpTools.OpenPageByJump("/newHero", {
			isEnter = true,
			hid = uv0.targetId
		}, ViewConst.SYSTEM_ID.PLAYER_INFO)
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	HeroTools.SetHeroNewTagRed(slot0.params_.heroId, "unlockRelation", table.concat({
		RedPointConst.HERO_REALTION,
		"_",
		slot0.params_.heroId
	}), false)

	slot0.heroId = slot0.params_.heroId
	slot0.comboId = 0
	slot0.m_heroName.text = HeroCfg[slot0.heroId].name
	slot0.m_heroIcon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.heroId)
	slot2 = ArchiveData:GetTrustLevel(slot0.heroId)

	if slot0.select_net == nil then
		slot0.select_net = 1
	else
		slot0.select_net = math.min(slot2, slot0.select_net)
	end

	slot0.targetId = HeroRelationNetCfg[HeroRelationNetCfg.get_id_list_by_hero_id[slot0.heroId][slot0.select_net]].intimate[1]

	slot0.pageController:SetSelectedIndex(0)

	if slot0.params_.page then
		slot0.pageController:SetSelectedIndex(slot0.params_.page)

		slot0.params_.page = nil
	end

	if slot0.params_.comboId then
		slot0.comboId = slot0.params_.comboId
		slot0.params_.comboId = nil
	end

	slot0:RefreshAttr()
	slot0:Refresh()
	slot0:RefreshRedPoint()
	manager.redPoint:bindUIandKey(slot0.m_comboBtn.transform, string.format("%s_%s", RedPointConst.HERO_RELATION_COMBO_SKILL, slot0.heroId))
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	manager.redPoint:unbindUIandKey(slot0.m_comboBtn.transform)
end

function slot0.RefreshAttr(slot0)
	slot3 = nil
	slot3, slot0.relationAttrData = HeroData:GetHeroData(slot0.heroId).relation:GetRelationNetAttr()

	table.sort(slot0.relationAttrData, function (slot0, slot1)
		return slot0[1] < slot1[1]
	end)
	slot0.attrList:StartScroll(#slot0.relationAttrData)
end

function slot0.Refresh(slot0)
	slot0.m_targetHeroName.text = HeroCfg[slot0.targetId].name
	slot0.m_targetHeroIcon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.targetId)
	slot0.m_relationLab.text = ArchiveTools.GetRelationConfig(slot0.heroId, slot0.targetId) and slot2.relation_des or ""

	if slot2 and slot2.story_id ~= 0 and IsConditionAchieved(slot2.story_condtion_id, {
		heroId = slot0.heroId
	}) then
		slot0.storyId = slot2.story_id
		slot0.relationId = slot2.id

		slot0.storyController:SetSelectedIndex(1)

		if not ArchiveData:GetRelationStoryRead(slot2.id) then
			manager.redPoint:SetRedPointIndependent(slot0.m_storyBtn.transform, true)
		else
			manager.redPoint:SetRedPointIndependent(slot0.m_storyBtn.transform, false)
		end
	else
		slot0.storyController:SetSelectedIndex(0)
	end

	slot0:RefreshNet()

	if slot0:GetComboSkillId(slot0.heroId, slot0.targetId) ~= 0 then
		slot0.m_skillLevel.text = GetTips("LEVEL") .. ComboSkillData:GetCurComboSkillLevel(slot3)

		if #ComboSkillCfg[slot3].cooperate_role_ids == 3 then
			slot9 = 1

			slot0.threeTeamskillController:SetSelectedIndex(slot9)

			for slot9, slot10 in ipairs(slot5.cooperate_role_ids) do
				if slot10 ~= slot0.heroId and slot10 ~= slot0.targetId then
					slot0.m_thirdHeroIcon.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot10)

					break
				end
			end
		else
			slot0.threeTeamskillController:SetSelectedIndex(0)
		end

		slot0.showComboController:SetSelectedIndex(1)
	else
		slot0.showComboController:SetSelectedIndex(0)
	end

	if #ComboSkillTools.GetHeroComboSkill(slot0.heroId) == 0 then
		slot0.pageController:SetSelectedIndex(0)
	else
		for slot9 = 1, slot5 do
			if not slot0.comboItems[slot9] then
				slot11 = HeroTrammelsComboItem.New(Object.Instantiate(slot0.m_comboSkillItem, slot0.m_comboSkillContent), slot9)

				slot11:RegistCallBack(slot0.comboClickHanle)

				slot0.comboItems[slot9] = slot11
			end

			slot0.comboItems[slot9]:SetActive(true)
			slot0.comboItems[slot9]:SetData(slot4[slot9])
		end

		for slot9 = slot5 + 1, #slot0.comboItems do
			slot0.comboItems[slot9]:SetActive(false)
		end

		slot0:RefreshCombo()
	end
end

function slot0.RefreshRedPoint(slot0)
	for slot5, slot6 in ipairs(slot0.switchNetItems) do
		slot8 = HeroRelationNetCfg.get_id_list_by_hero_id[slot0.heroId][slot5]

		if slot5 <= ArchiveData:GetTrustLevel(slot0.heroId) and slot8 then
			slot10 = false

			for slot14, slot15 in ipairs(HeroRelationNetCfg[slot8].intimate) do
				if ArchiveTools.GetRelationConfig(slot0.heroId, slot15) and slot16.story_id ~= 0 and not ArchiveData:GetRelationStoryRead(slot16.id) and IsConditionAchieved(slot16.story_condtion_id, {
					heroId = slot0.heroId
				}) then
					slot10 = true

					break
				end
			end

			if not slot10 then
				slot11 = HeroData:GetHeroData(slot0.heroId)

				for slot16, slot17 in ipairs(HeroRelationNetCfg.get_id_list_by_hero_id[slot0.heroId] or {}) do
					if HeroRelationNetCfg[slot17].index == slot5 then
						for slot22, slot23 in ipairs(slot18.relation_upgrade_group) do
							if not slot11.relation:GetIsUnlock(slot18.index, slot22) and ArchiveTools.CheckRelationUpgradeCondition(HeroRelationUpgradeCfg[slot23].condition_id, slot18.intimate) then
								slot10 = true

								break
							end
						end
					end
				end
			end

			manager.redPoint:SetRedPointIndependent(slot6.transform_, slot10)
		else
			manager.redPoint:SetRedPointIndependent(slot6.transform_, false)
		end
	end
end

function slot0.RefreshNet(slot0)
	slot1 = ArchiveData:GetTrustLevel(slot0.heroId)

	for slot5, slot6 in ipairs(slot0.switchNetItems) do
		slot7 = 1

		if slot5 == slot0.select_net then
			slot7 = 2
		elseif slot1 < slot5 then
			slot7 = 0
		end

		slot6:SetData(slot7)
	end

	slot0.m_indexLab.text = "0" .. slot0.select_net

	if HeroRelationNetCfg.get_id_list_by_hero_id[slot0.heroId][slot0.select_net] then
		slot4 = HeroRelationNetCfg[slot3]
		slot0.netMissionData = slot4.relation_upgrade_group
		slot0.netPartnerData = slot4.intimate

		slot0.netMissionList:StartScroll(#slot0.netMissionData)
		slot0.netPartnerList:StartScroll(#slot0.netPartnerData)
	else
		slot0.netMissionList:StartScroll(0)
		slot0.netPartnerList:StartScroll(0)
	end
end

function slot0.RefreshCombo(slot0)
	slot1 = 0

	for slot5, slot6 in ipairs(slot0.comboItems) do
		slot6:RefreshState(slot0.comboId)

		if slot0.comboId == slot6:GetComboId() then
			slot1 = slot5
		end
	end

	if slot0.comboId == 0 then
		SetActive(slot0.m_comboSkillInfoGo, false)
	else
		SetActive(slot0.m_comboSkillInfoGo, true)

		slot3 = ComboSkillData:GetCurComboSkillLevel(slot0.comboId)
		slot4 = ComboSkillCfg[slot0.comboId]
		slot0.m_comboDes.text = GetCfgDescription(HeroSkillCfg[slot4.skill_id].desc[1], slot3, 2, slot4.maxLevel)

		if slot3 < ComboSkillTools.GetMaxComboSkillLevel(slot0.comboId) then
			slot0.comboMissionData = ComboSkillLevelCfg.get_id_list_by_level[slot3]

			slot0.comboMissionList:StartScroll(#slot0.comboMissionData)
			slot0.comboMaxLvController:SetSelectedIndex(1)
			slot0.lvupController:SetSelectedIndex(1)

			slot0.m_comboUpLevelDes.text = GetTipsF("HERO_COMBO_SKILL_LEVEL_UP_BUTTON_LAB", "")
		else
			slot0.comboMaxLvController:SetSelectedIndex(0)
			slot0.lvupController:SetSelectedIndex(0)
		end

		slot0.m_comboSkillInfoGo.transform:SetSiblingIndex(slot1 + 1)
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_comboSkillContent)
end

function slot0.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.switchNetItems) do
		slot5:Dispose()
	end

	slot0.switchNetItems = {}

	for slot4, slot5 in ipairs(slot0.comboItems) do
		slot5:Dispose()
	end

	slot0.comboItems = {}

	slot0.attrList:Dispose()
	slot0.netMissionList:Dispose()
	slot0.netPartnerList:Dispose()
	slot0.comboMissionList:Dispose()
	uv0.super.Dispose(slot0)
end

function slot0.SwitchNetClick(slot0, slot1)
	if slot1 == slot0.select_net then
		return
	end

	if ArchiveData:GetTrustLevel(slot0.heroId) < slot1 then
		ShowTips(GetTipsF("HERO_RELATION_UNLOCK_TRUST_LV", ArchiveTools.GetTrustLvDes(slot1)))

		return
	end

	slot0.select_net = slot1

	slot0:RefreshNet()
end

function slot0.PartnerClick(slot0, slot1)
	if slot1 == slot0.targetId then
		return
	end

	slot0.targetId = slot1

	slot0:Refresh()
end

function slot0.ComboClick(slot0, slot1)
	if slot1 == slot0.comboId then
		slot0.comboId = 0
	else
		slot0.comboId = slot1
	end

	slot0:RefreshCombo()
end

function slot0.GetComboSkillId(slot0, slot1, slot2)
	for slot7, slot8 in ipairs(ComboSkillTools.GetHeroComboSkill(slot1) or {}) do
		if table.keyof(ComboSkillCfg[slot8].cooperate_role_ids, slot2) then
			return slot8
		end
	end

	return 0
end

function slot0.IndexAttrItem(slot0, slot1, slot2)
	slot2:SetData(slot0.relationAttrData[slot1])
end

function slot0.IndexNetMissionItem(slot0, slot1, slot2)
	slot2:SetData(slot0.netMissionData[slot1], slot0.select_net, slot1, slot0.heroId, slot0.netPartnerData)
end

function slot0.IndexNetPartnerItem(slot0, slot1, slot2)
	slot2:SetData(slot0.netPartnerData[slot1], slot0.targetId, slot0.heroId)
	slot2:RegistCallBack(slot0.partnerClickHandle)
end

function slot0.IndexComboMissionItem(slot0, slot1, slot2)
	slot2:SetData(slot0.comboMissionData[slot1], slot0.comboId)
end

function slot0.OnHeroRelationNetUnlock(slot0)
	slot0.netMissionList:Refresh()
	slot0:RefreshAttr()
	slot0:RefreshRedPoint()
end

function slot0.OnHeroComboSkillLevelUp(slot0)
	slot0:Refresh()
	ArchiveAction.CheckComboSkillRedPoint(slot0.heroId)
end

function slot0.OnHeroRelationStoryReward(slot0)
	manager.redPoint:SetRedPointIndependent(slot0.m_storyBtn.transform, false)
	slot0:RefreshRedPoint()
	slot0.netPartnerList:Refresh()
end

return slot0
