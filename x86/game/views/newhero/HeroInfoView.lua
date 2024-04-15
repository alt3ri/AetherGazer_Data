slot0 = class("HeroInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.oldAtt_ = {}
	slot0.tweens_ = {}
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockController_ = slot0.controller_:GetController("lock")
	slot0.pieceEnoughController_ = slot0.controller_:GetController("pieceEnough")
	slot0.isSelfController_ = slot0.controller_:GetController("isSelf")
	slot0.levelStateController_ = slot0.controller_:GetController("levelState")
	slot0.moduleController_ = slot0.controller_:GetController("module")
	slot0.polyhedronController_ = slot0.controller_:GetController("polyhedron")
	slot0.propNames_ = {
		slot0.propName1_,
		slot0.propName2_,
		slot0.propName3_,
		slot0.propName4_
	}
	slot0.propItems_ = {
		slot0.propNum1_,
		slot0.propNum2_,
		slot0.propNum3_,
		slot0.propNum4_
	}
	slot0.propIcon_ = {
		slot0.propIcon1_,
		slot0.propIcon2_,
		slot0.propIcon3_,
		slot0.propIcon4_
	}
	slot0.propIndexes_ = {
		HeroConst.HERO_ATTRIBUTE.ATK,
		HeroConst.HERO_ATTRIBUTE.ARM,
		HeroConst.HERO_ATTRIBUTE.STA,
		HeroConst.HERO_ATTRIBUTE.CRITICAL
	}
	slot0.endfixes_ = {}

	for slot4 = 1, 4 do
		slot5, slot6, slot0.propIcon_[slot4].sprite = SkillTools.GetAttr({
			slot0.propIndexes_[slot4],
			0
		})
		slot0.propNames_[slot4].text = GetI18NText(slot5)
		slot0.endfixes_[slot4] = PublicAttrCfg[slot0.propIndexes_[slot4]].percent == 1 and "%" or ""
	end
end

function slot0.AddUIListener(slot0)
	if slot0.surpassBtn_ then
		slot0:AddBtnListener(slot0.surpassBtn_, nil, function ()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = uv0.heroInfo_.id
			})
		end)
	end

	if slot0.surpass01Btn_ then
		slot0:AddBtnListener(slot0.surpass01Btn_, nil, function ()
			JumpTools.OpenPageByJump("/heroSurpass", {
				heroId = uv0.heroInfo_.id
			})
		end)
	end

	slot0:AddBtnListener(slot0.checkBtn_, nil, function ()
		JumpTools.OpenPageByJump("/heroPreviewMain", {
			isEnter = true,
			hid = uv0.heroInfo_.id
		})
	end)
	slot0:AddBtnListener(slot0.getBtn_, nil, function ()
		if uv0:GetHeroPiece() < GameSetting.unlock_hero_need.value[uv0.heroCfg_.rare] then
			ShowPopItem(POP_SOURCE_ITEM, {
				ItemCfg[uv0.heroCfg_.id].fragment
			})
		else
			manager.net:SendWithLoadingNew(14016, {
				id = uv0.heroCfg_.id
			}, 14017, handler(uv0, uv0.OnUnlockHero))
		end
	end)

	if slot0.upgradeBtn_ then
		slot0:AddBtnListener(slot0.upgradeBtn_, nil, function ()
			JumpTools.OpenPageByJump("/heroUpgrade", {
				heroId = uv0.heroInfo_.id,
				proxy = uv0.heroViewProxy_
			})
		end)
	end

	slot0:AddBtnListener(slot0.campBgBtn_, nil, function ()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription")
	end)
	slot0:AddBtnListener(slot0.buttonHeroAttribute_, nil, function ()
		JumpTools.OpenPageByJump("heroAttribute", {
			heroID = uv0.heroInfo_.id,
			proxy = uv0.heroViewProxy_
		})
	end)
	slot0:AddBtnListener(slot0.moduleView_, nil, function ()
		OperationRecorder.RecordButtonTouch("hero_attribute_module")

		if not uv0.heroViewProxy_.isSelf then
			return
		end

		if WeaponModuleCfg[uv0.heroInfo_.id] then
			JumpTools.OpenPageByJump("/weaponModuleView", {
				heroID = uv0.heroInfo_.id
			})
		end
	end)
	slot0:AddBtnListener(slot0.proficiencyBtn_, nil, function ()
		if uv0.openContent_ then
			uv0.openContent_ = false
		else
			uv0.openContent_ = true
		end

		SetActive(uv0.comTipsGo_, uv0.openContent_)
		SetActive(uv0.proficiencyMaskBtn_.gameObject, uv0.openContent_)

		uv0.comTipsNumText_.text = HeroTools.GetHeroProficiency(uv0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
	end)
	slot0:AddBtnListener(slot0.proficiencyMaskBtn_, nil, function ()
		uv0.openContent_ = false

		SetActive(uv0.comTipsGo_, uv0.openContent_)
		SetActive(uv0.proficiencyMaskBtn_.gameObject, uv0.openContent_)
	end)
end

function slot0.OnUnlockHero(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		HeroAction.UnlockHeroSuccess(slot0.heroCfg_.id)
		gameContext:Go("obtainView", {
			itemList = {
				slot0.heroCfg_
			}
		})
	end
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.oldBattlePower_ = slot0.battlePower_ or 0
	slot0.oldAtt_ = slot0.att_ or {}
	slot0.heroInfo_ = slot1
	slot0.heroCfg_ = HeroCfg[slot1.id]
	slot0.curLv_ = slot0.heroInfo_.level
	slot0.curLvMax_ = HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_)
end

function slot0.UpdateView(slot0)
	slot0.openContent_ = false

	SetActive(slot0.comTipsGo_, slot0.openContent_)
	SetActive(slot0.proficiencyMaskBtn_.gameObject, slot0.openContent_)

	slot0.nameText_.text = GetI18NText(slot0.heroCfg_.name)
	slot0.subNameText_.text = GetI18NText(slot0.heroCfg_.suffix)

	slot0.lockController_:SetSelectedState(tostring(not (slot0.heroInfo_.unlock ~= 0 or slot0.type_ == HeroConst.HERO_DATA_TYPE.PREVIEW)))
	slot0.isSelfController_:SetSelectedState(tostring(not slot0.heroViewProxy_.isSelf))
	slot0.polyhedronController_:SetSelectedState(tostring(slot0.type_ == HeroConst.HERO_DATA_TYPE.POLYHEDRON))

	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(slot0.heroCfg_.race)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroCfg_.id)

	if slot0.heroInfo_.unlock == 0 then
		slot0:UpdateLockedView()
	else
		slot0:UpdateUnlockedView()

		if slot0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			ArchiveAction.CheckAllRelationRedPoint(slot0.heroCfg_.id)
		end
	end

	if slot0.heroViewProxy_.showRedPoint then
		if not isNil(slot0.moduleView_) and not isNil(slot0.moduleView_.transform) then
			manager.redPoint:bindUIandKey(slot0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroInfo_.id)
		end

		manager.redPoint:bindUIandKey(slot0.surpassBtn_.transform, RedPointConst.HERO_STAR_ID .. slot0.heroInfo_.id)
		manager.redPoint:bindUIandKey(slot0.upgradeBtn_.transform, RedPointConst.HERO_BREAK_ID .. slot0.heroInfo_.id)
	end
end

function slot0.GetHeroPiece(slot0)
	return slot0.heroInfo_.piece
end

function slot0.UpdateLockedView(slot0)
	slot1 = slot0:GetHeroPiece()
	slot3 = GameSetting.unlock_hero_need.value[slot0.heroCfg_.rare]
	slot4 = math.min(slot1, slot3)
	slot0.pieceCost_ = -slot3
	slot0.curPieceText_.text = tostring(slot1)
	slot0.needPieceText_.text = "/" .. tostring(slot3)

	if slot0.tweenValue_ then
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end

	slot0.tweenValue_ = LeanTween.value(0, 0.7, 0.7):setOnUpdate(LuaHelper.FloatAction(function (slot0)
		slot1 = 0

		if slot0 >= 0.2 then
			slot1 = (slot0 - 0.2) / 0.5
		end

		uv0.scheduleImage_.fillAmount = uv1 * slot1 / uv2
	end)):setOnComplete(LuaHelper.VoidAction(function ()
		if uv0.tweenValue_ then
			uv0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

			uv0.tweenValue_ = nil
		end

		uv0.scheduleImage_.fillAmount = uv1 / uv2
	end)):setEase(LeanTweenType.easeOutQuad)

	if slot3 <= slot1 then
		slot0.pieceEnoughController_:SetSelectedState("true")

		slot0.getText_.text = GetTips("DORM_CANTEEN_LEVEL_UNLOCK")
	else
		slot0.pieceEnoughController_:SetSelectedState("false")

		slot0.getText_.text = GetTips("TIP_GET")
	end
end

function slot0.UpdateModuleView(slot0)
	SetActive(slot0.moduleView_.gameObject, WeaponModuleCfg[slot0.heroInfo_.id] and not slot0.heroViewProxy_.hideModule)

	if WeaponModuleCfg[slot0.heroInfo_.id] then
		if slot0.heroInfo_.moduleLevel == 0 then
			slot0.moduleController_:SetSelectedState("lock")
		else
			slot0.moduleController_:SetSelectedState("unlock")

			slot0.moduleNameText_.text = WeaponModuleCfg[slot0.heroInfo_.id].name
			slot0.moduleImg_.sprite = getSpriteWithoutAtlas("TextureConfig/WeaponModule/" .. slot0.heroInfo_.id)
			slot0.moduleLevelText_.text = "Lv." .. slot1
		end
	end
end

function slot0.UpdateUnlockedView(slot0)
	if slot0.type_ ~= HeroConst.HERO_DATA_TYPE.PREVIEW then
		if slot0.type_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
			slot0.proficiencyText_.text = HeroTools.GetHeroProficiency(slot0.heroInfo_.id) .. "/" .. GameSetting.mastery_level_max.value[1]
		end

		slot1 = slot0.heroInfo_.level
		slot2 = slot0.heroInfo_.exp
		slot0.battlePower_ = slot0.heroViewProxy_:GetBattlePower(slot0.heroInfo_.id, slot0.heroInfo_.tempID)

		if slot0.battlePowerTween_ then
			LeanTween.cancel(slot0.battlePowerTween_.id)

			slot0.battlePowerTween_ = nil
		end

		if slot0.oldBattlePower_ ~= slot0.battlePower_ then
			slot3 = slot0.oldBattlePower_ or 0
			slot4 = slot0.battlePower_
			slot0.battlePowerTween_ = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
				slot1 = uv0
				uv2.fightPowerText_.text = math.floor(slot1 + (uv1 - slot1) * slot0)
			end)):setOnComplete(LuaHelper.VoidAction(function ()
				if uv0.battlePowerTween_ then
					uv0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

					uv0.battlePowerTween_ = nil
				end

				uv0.fightPowerText_.text = uv1
			end)):setEase(LeanTweenType.easeOutQuad)
			slot0.oldBattlePower_ = slot0.battlePower_
		else
			slot0.fightPowerText_.text = slot0.oldBattlePower_
		end

		slot3 = HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_)
		slot4 = slot2 - LvTools.LevelToExp(slot1, "hero_level_exp1")
		slot0.att_ = slot0.heroViewProxy_:GetHeroAllAttribute(slot0.heroInfo_.id)

		for slot8, slot9 in pairs(slot0.propItems_) do
			slot10 = PublicAttrCfg[slot0.propIndexes_[slot8]].percent == 1

			if slot0.oldAtt_[slot0.propIndexes_[slot8]] ~= slot0.att_[slot0.propIndexes_[slot8]] then
				slot11 = slot0.oldAtt_[slot0.propIndexes_[slot8]] or 0
				slot12 = slot0.att_[slot0.propIndexes_[slot8]]

				if slot0.tweens_[slot8] then
					LeanTween.cancel(slot0.tweens_[slot8].id)

					slot0.tweens_[slot8] = nil
				end

				slot0.tweens_[slot8] = LeanTween.value(0, 1, 0.5):setOnUpdate(LuaHelper.FloatAction(function (slot0)
					slot1 = uv0

					if uv2 then
						uv3.text = string.format("%.2f", math.floor(slot1 + (uv1 - slot1) * slot0) / 10) .. uv4.endfixes_[uv5]
					else
						uv3.text = math.floor(slot3)
					end
				end)):setOnComplete(LuaHelper.VoidAction(function ()
					if uv0.tweens_[uv1] then
						uv0.tweens_[uv1]:setOnUpdate(nil):setOnComplete(nil):setEase(nil)

						uv0.tweens_[uv1] = nil
					end

					if uv2 then
						uv3.text = string.format("%.2f", uv4 / 10) .. uv0.endfixes_[uv1]
					else
						uv3.text = math.floor(uv4)
					end
				end)):setEase(LeanTweenType.easeOutQuad)
				slot0.oldAtt_[slot0.propIndexes_[slot8]] = slot0.att_[slot0.propIndexes_[slot8]]
			end
		end

		slot0.nowLevelText_.text = tostring(slot1)
		slot0.topLevelText_.text = "/" .. slot3

		if slot1 < slot3 then
			slot5 = GameLevelSetting[slot1].hero_level_exp1
			slot0.expProgressBar_.value = math.floor(slot4 / slot5 * 1000) / 1000
			slot0.expText_.text = string.format("%d/%d", slot4, slot5)
		elseif LvTools.GetIsMaxLv(slot1, "hero") then
			slot0.expProgressBar_.value = 1
			slot0.expText_.text = "-/-"
		else
			slot5 = GameLevelSetting[slot1].hero_level_exp1
			slot0.expProgressBar_.value = math.floor(slot4 / slot5 * 1000) / 1000
			slot0.expText_.text = string.format("%d/%d", slot4, slot5)
		end
	end

	slot0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. HeroStarCfg[slot0.heroInfo_.star].star)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")

	slot0:UpdateUnlockBtnState()
	slot0:RefreshChargeType()
	slot0:UpdateModuleView()
end

function slot0.UpdateUnlockBtnState(slot0)
	if HeroConst.HERO_LV_MAX <= slot0.heroInfo_.level then
		slot0.levelStateController_:SetSelectedState("maxLevel")
	elseif HeroTools.GetHeroCurrentMaxLevel(slot0.heroInfo_) <= slot0.heroInfo_.level then
		slot0.levelStateController_:SetSelectedState("break")

		slot0.upgradeBtnText_.text = GetTips("TIP_BREAK")
	else
		slot0.levelStateController_:SetSelectedState("addExp")

		slot0.upgradeBtnText_.text = GetTips("TEXT_UPGRADE")
	end
end

function slot0.RefreshChargeType(slot0)
	if slot0.heroCfg_.mechanism_type[1] == HeroConst.HERO_CHARGE_TYPE.RAGE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif slot1 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		slot0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function slot0.OnEnter(slot0, slot1)
	slot0:SetProxy(slot1)
	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.OnHeroModify))
end

function slot0.OnExit(slot0)
	if slot0.heroViewProxy_.showRedPoint then
		if not isNil(slot0.moduleView_) and not isNil(slot0.moduleView_.transform) then
			manager.redPoint:unbindUIandKey(slot0.moduleView_.transform, RedPointConst.WEAPON_MODULE_UNLOCK .. "_" .. slot0.heroInfo_.id)
		end

		manager.redPoint:unbindUIandKey(slot0.surpassBtn_.transform, RedPointConst.HERO_STAR_ID .. slot0.heroInfo_.id)
		manager.redPoint:unbindUIandKey(slot0.upgradeBtn_.transform, RedPointConst.HERO_BREAK_ID .. slot0.heroInfo_.id)
	end

	slot0:RemoveAllEventListener()
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1
	slot0.type_ = slot0.heroViewProxy_:GetViewDataType()
end

function slot0.OnHeroModify(slot0, slot1)
	if slot1 == slot0.heroInfo_.id then
		slot0:UpdateView()
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()

	if slot0.tweenValue_ then
		slot0.tweenValue_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.tweenValue_.id)

		slot0.tweenValue_ = nil
	end

	if slot0.battlePowerTween_ then
		slot0.battlePowerTween_:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
		LeanTween.cancel(slot0.battlePowerTween_.id)

		slot0.battlePowerTween_ = nil
	end

	if slot0.tweens_ then
		for slot4, slot5 in pairs(slot0.tweens_) do
			slot5:setOnUpdate(nil):setOnComplete(nil):setEase(nil)
			LeanTween.cancel(slot5.id)
		end

		slot0.tweens_ = nil
	end

	slot0.handler_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
