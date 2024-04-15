slot0 = class("CultureGravureView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero/HeroCultureGravureUI"
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

	slot0.stateController_ = ControllerUtil.GetController(slot0.gameObject_.transform, "state")
	slot4 = "teach"
	slot0.teachController_ = ControllerUtil.GetController(slot0.gameObject_.transform, slot4)
	slot0.tabController_ = {}

	for slot4 = 1, 3 do
		slot0.tabController_[slot4] = ControllerUtil.GetController(slot0["tab_" .. slot4], "name")
	end

	slot0.btnController_ = slot0.recommendCon_:GetController("name")
	slot0.equiptList_ = LuaList.New(handler(slot0, slot0.IndexEquiptItem), slot0.equiptListGo_, CultureGravureEquiptItem)
	slot0.servantList_ = LuaList.New(handler(slot0, slot0.IndexServantItem), slot0.servanListGo_, CultureGravureServantItem)
	slot0.astroList_ = LuaList.New(handler(slot0, slot0.IndexAstroItem), slot0.astroListGo_, CultureGravureAstroItem)
	slot0.clickAstrohandler = handler(slot0, slot0.PopInfoLeft)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.recommendBtn_, nil, function ()
		uv0.recommendType_ = uv0.recommendType_ == 1 and 2 or 1

		if uv0.recommendType_ == 1 then
			uv0.equiptDataList_ = CultureGravureData:GetCommonEquiptListByID(uv0.heroID_)
			uv0.recommendText_.text = GetTips("OMEGA_RECOMMEND")
		else
			uv0.equiptDataList_ = CultureGravureData:GetOmegaEquiptListByID(uv0.heroID_)
			uv0.recommendText_.text = GetTips("EQUIP_RECOMMEND")
		end

		uv0.btnController_:SetSelectedState(uv0.recommendType_)
		uv0.equiptList_:StartScroll(#uv0.equiptDataList_)
	end)
	slot0:AddBtnListener(slot0.equiptBtn, nil, function ()
		uv0:ClickToggle(1)
	end)
	slot0:AddBtnListener(slot0.servantBtn, nil, function ()
		uv0:ClickToggle(2)
	end)
	slot0:AddBtnListener(slot0.astroBtn, nil, function ()
		uv0:ClickToggle(3)
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		SetActive(uv0.popInfoParentGo_, false)
	end)
	slot0:AddBtnListener(slot0.teachingBtn_, nil, function ()
		OperationRecorder.RecordButtonTouch("hero_teach_stage")
		HeroData:SetHeroStrategyRedPoint(uv0.heroID_)
		BattleTeachData:SetCacheTeachHeroID(uv0.heroID_)

		if HeroCfg[uv0.heroID_] and slot0.study_stage and slot0.study_stage[1] then
			JumpTools.OpenPageByJump("/teachStage", {
				switchType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				heroID = uv0.heroID_
			})
			JumpTools.OpenPageByJump("teachSectionInfo", {
				sectionType = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
				section = slot0.study_stage[1]
			})
		end
	end)
	slot0:AddBtnListener(slot0.forumBtn_, nil, function ()
		if _G.ChannelLoginInfo and _G.ChannelLoginInfo.channelToken then
			slot0 = {
				userId = PlayerData:GetPlayerInfo().userID,
				signUserId = PlayerData:GetPlayerInfo().signUserId,
				gameAppId = _G.ChannelLoginInfo.channelAppId,
				token = _G.ChannelLoginInfo.channelToken
			}

			if HeroCfg[uv0.heroID_] ~= nil then
				slot2 = string.format("%s·%s", GetI18NText(slot1.name), GetI18NText(slot1.suffix))

				if SettingData:GetCurrentLanguage() == "fr" or slot3 == "de" then
					slot2 = string.format("%s-%s", GetI18NText(slot1.name), GetI18NText(slot1.suffix))
				end

				slot0.heroName = slot2
			end

			OperationAction.OpenOperationUrl("FORUM_URL_HERO", slot0)
		end
	end)
end

function slot0.OnEnter(slot0)
	slot0.heroID_ = slot0.params_.heroID

	if slot0.params_.selectIndex then
		slot0.selectedListIndex_ = slot0.params_.selectIndex
		slot0.params_.selectIndex = nil
	end

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "CULTUREGRAVURE_DESC",
			iconColor = Color(1, 1, 1),
			title = GetTips("FUNCTION_DESC"),
			content = GetTips("CULTUREGRAVURE_DESC")
		})
	end)

	slot0.recommendType_ = slot0.recommendType_ or 1

	slot0:RefreshUI()
	manager.heroRaiseTrack:RefreshAstrolableState(AstrolabeConst.AnimationState.Commended)
end

function slot0.RefreshUI(slot0)
	slot1 = HeroCfg[slot0.heroID_]
	slot0.nameText_.text = slot1.name
	slot0.suffixText_.text = slot1.suffix
	slot0.roleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Icon/" .. slot0.heroID_)
	slot0.raceImg_.sprite = getSprite("Atlas/SystemGroupAtlas", string.format("com_white_icon_group_%s_c", slot1.race))
	slot0.rareImg_.sprite = getSprite("Atlas/SystemHeroGradeAtlas", "star_" .. slot1.rare)

	slot0.teachController_:SetSelectedState(tostring(HeroData:GetHeroStrategyRedPoint(slot0.heroID_)))
	slot0:RefreshList(slot0.selectedListIndex_)

	slot0.typeImg_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroID_)

	slot0:RefreshChargeType()
	slot0:RefreshRangeType()
	SetActive(slot0.astroBtn, not HeroTools.IsSpHero(slot0.heroID_))
end

function slot0.ClickToggle(slot0, slot1)
	if slot1 == slot0.selectedListIndex_ then
		return
	end

	slot0:RefreshList(slot1)
end

function slot0.RefreshList(slot0, slot1)
	if slot1 == 1 then
		PlayerAction.CheckRecommendEquip(slot0.heroID_)
	end

	slot5 = slot1

	slot0.stateController_:SetSelectedState(slot5)

	for slot5 = 1, 3 do
		slot0.tabController_[slot5]:SetSelectedState(tostring(slot5 == slot1))
	end

	if slot1 == 3 then
		slot0.astroDataList_ = deepClone(CultureGravureData:GetAstroListByID(slot0.heroID_))

		slot0.astroList_:StartScroll(#slot0.astroDataList_)
	elseif slot1 == 2 then
		slot0.servantDataList_ = CultureGravureData:GetServantListByID(slot0.heroID_)

		slot0.servantList_:StartScroll(#slot0.servantDataList_)
	else
		slot0.btnController_:SetSelectedState(slot0.recommendType_)

		slot0.recommendText_.text = slot0.recommendType_ == 1 and GetTips("OMEGA_RECOMMEND") or GetTips("EQUIP_RECOMMEND")

		if slot0.recommendType_ == 2 then
			slot0.equiptDataList_ = CultureGravureData:GetOmegaEquiptListByID(slot0.heroID_)
		else
			slot0.equiptDataList_ = CultureGravureData:GetCommonEquiptListByID(slot0.heroID_)
		end

		slot0.equiptList_:StartScroll(#slot0.equiptDataList_)
		slot0.stateController_:SetSelectedState(1)

		slot1 = 1
	end

	slot0.selectedListIndex_ = slot1

	SetActive(slot0.descTextGo_, slot0.selectedListIndex_ ~= 2)
end

function slot0.IndexEquiptItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.equiptDataList_[slot1], slot0.heroID_)
end

function slot0.IndexServantItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.servantDataList_[slot1], slot0.heroID_)

	if slot1 == 1 then
		slot2:SetRecommendController(2)
	end
end

function slot0.IndexAstroItem(slot0, slot1, slot2)
	slot2:SetClickCallBack(slot0.clickAstrohandler)
	slot2:SetData(slot1, slot0.astroDataList_[slot1], slot0.heroID_)
end

function slot0.OnEquipSwap(slot0, slot1, slot2)
	slot0.equiptList_:StartScroll(#slot0.equiptDataList_)
end

function slot0.OnEquipQuickDressOn(slot0, slot1, slot2)
	for slot6 = 1, 6 do
		if slot2.use_equip_list[slot6] then
			HeroAction.HeroChangeEquip(slot2.hero_id, slot2.use_equip_list[slot6].equip_id, slot2.use_equip_list[slot6].pos)
		end
	end

	slot0.equiptList_:StartScroll(#slot0.equiptDataList_)
	ShowTips("SUCCESS_EQUIP_PROPOSAL")
end

function slot0.OnServantReplace(slot0)
	ShowTips("SUCCESS_EQUIP_SERVANT")
	slot0.servantList_:StartScroll(#slot0.servantDataList_)
end

function slot0.RefreshRangeType(slot0)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function slot0.RefreshChargeType(slot0)
	if HeroCfg[slot0.heroID_].mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function slot0.OnAstrolabeEquip(slot0)
	ShowTips("ASTROLABE_BIND")
	slot0.astroList_:StartScroll(#slot0.astroDataList_)
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	SetActive(slot0.popInfoParentGo_, false)
	manager.redPoint:unbindUIandKey(slot0.teachingBtn_.transform)
end

function slot0.Dispose(slot0)
	if slot0.astroList_ then
		slot0.astroList_:Dispose()
	end

	if slot0.servantList_ then
		slot0.servantList_:Dispose()
	end

	if slot0.equiptList_ then
		slot0.equiptList_:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.PopInfoLeft(slot0, slot1, slot2, slot3, slot4)
	SetActive(slot0.popInfoParentGo_, true)

	slot0.popNameText_.text = GetI18NText(slot1)
	slot0.popDescText_.text = GetI18NText(slot2)
	slot0.textViewTrs_.gameObject:GetComponent(typeof(ContentSizeFitter)).enabled = true

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.popDescText_.transform)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textContentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textViewTrs_)

	if 700 < slot0.popDescText_.transform.sizeDelta.y then
		slot6.enabled = false
		slot0.textParentTrs_.gameObject:GetComponent(typeof(ScrollRect)).enabled = true
		slot0.textViewTrs_.transform.sizeDelta = Vector2(slot0.textContentTrs_.sizeDelta.x, slot5)
	else
		slot6.enabled = true
		slot8.enabled = false
	end

	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.textParentTrs_)
	LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.popContentTrs_)

	slot9 = slot0.middleTrs_:InverseTransformPoint(slot3)
	slot0.popInfoTrs_.localPosition = slot0.popInfoParentTrs_:InverseTransformPoint(slot0.middleTrs_:TransformPoint(Vector3(slot9.x, slot9.y, 0)))
	slot16 = slot0.textParentTrs_.rect.width / 4
	slot17 = slot0.popInfoParentTrs_:InverseTransformPoint(slot0.astroRightTrs_.position).x
	slot18 = 0

	if slot0.safePlaceTrs_.rect.height / 2 < -slot0.popInfoParentTrs_:InverseTransformPoint(slot0.popBottomTrs_:TransformPoint(Vector3(0, 0, 0))).y then
		slot18 = -slot14.y - slot15
	end

	slot0.popInfoTrs_.localPosition = Vector3(slot17 + slot16, slot12.y + slot18, slot12.z)
end

return slot0
