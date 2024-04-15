slot0 = class("HeroSurpassPreview", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_transition/HeroPrintTipsUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.surpassScrollHelper_ = LuaList.New(handler(slot0, slot0.SurpassNodeItem), slot0.messagescrollGo_, HeroSurpassPreviewNodeItem)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnbgBtn_, nil, function ()
		uv0.messagescrollSr_.enabled = true

		uv0.tipsnodeGo_:SetActive(false)
	end)
	slot0:AddBtnListener(slot0.closeBtn_, nil, function ()
		if uv0.backCallback then
			uv0.backCallback()
		end
	end)
end

function slot0.ClickCheckBtn(slot0, slot1, slot2)
	slot0:RefreshTipsShow(slot2)
	slot0:SetTipsPosAndShow(slot1)

	slot0.messagescrollSr_.enabled = false
end

function slot0.RefreshTipsShow(slot0, slot1)
	slot2 = math.max(slot1 - 1, 0)
	slot0.atkvaluenowText_.text = slot0.heroCfg.atk_ratio[slot2]
	slot0.atkvalueafterText_.text = slot0.heroCfg.atk_ratio[slot1]
	slot0.armvaluenowText_.text = slot0.heroCfg.arm_ratio[slot2]
	slot0.armvalueafterText_.text = slot0.heroCfg.arm_ratio[slot1]
	slot0.stavaluenowText_.text = slot0.heroCfg.sta_ratio[slot2]
	slot0.stavalueafterText_.text = slot0.heroCfg.sta_ratio[slot1]
	slot0.atknodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[1].name))
	slot0.armnodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[2].name))
	slot0.stanodeText_.text = string.format(GetTips("EQUIP_UPGRADE_ATTR_DES"), GetI18NText(PublicAttrCfg[3].name))
end

function slot0.SetTipsPosAndShow(slot0, slot1)
	if slot0.tipsnodeTrs_.parent ~= slot1.transform_.parent then
		slot0.tipsnodeTrs_:SetParent(slot2)
	end

	slot0.tipsnodeTrs_:SetAsLastSibling()
	slot0.tipsnodeGo_:SetActive(true)

	slot0.tipsnodeTrs_.localPosition = Vector2(slot0.tipsnodeTrs_.localPosition.x, slot1.transform_.localPosition.y - 200)
end

function slot0.SurpassNodeItem(slot0, slot1, slot2)
	slot2:RefreshUI(slot0.starNodeList[slot1 + slot0.beginStarStage - 1])
	slot2:SetClickCheckCallback(function ()
		uv0:ClickCheckBtn(uv1, uv2[1].cfg.star)
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:HideBar()

	slot0.backCallback = slot0.params_.backCallback

	slot0:InitData()
	slot0:InitHeroStarData()
	slot0.tipsnodeGo_:SetActive(false)
end

function slot0.InitData(slot0)
	slot0.heroID = slot0.params_.heroID
	slot0.heroInfo = slot0.params_.heroInfo
	slot0.heroCfg = HeroCfg[slot0.heroID]
end

function slot0.InitHeroStarData(slot0)
	slot1 = {}
	slot0.beginStarStage = HeroStarCfg[slot0.heroCfg.unlock_star].star
	slot4 = 7

	SurpassTools.ChangeIconStarSpirte(slot0.iconImg_, HeroStarCfg[slot0.heroInfo.star].star)

	slot8 = HeroStarUpTemplateCfg.get_id_list_by_template[slot0.heroCfg.star_up_skill_template]

	for slot12 = table.indexof(HeroStarCfg.all, slot0.heroCfg.unlock_star), #HeroStarCfg.all do
		if HeroStarCfg[HeroStarCfg.all[slot12]] then
			slot16 = slot5 < slot13

			if not slot1[slot14.star] then
				slot1[slot15] = {}
			end

			table.insert(slot1[slot15], {
				cfg = slot14,
				isLock = slot16,
				isBeginStar = slot12 == slot3 and true or false,
				heroCfg = slot0.heroCfg
			})
		end
	end

	slot0.starNodeList = slot1
	slot0.starStageNum = slot4 - slot2

	slot0.surpassScrollHelper_:StartScroll(slot0.starStageNum, slot6 - slot2)
end

function slot0.OnExit(slot0)
	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end
end

function slot0.Dispose(slot0)
	if slot0.surpassScrollHelper_ then
		slot0.surpassScrollHelper_:Dispose()

		slot0.surpassScrollHelper_ = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2, slot3 = nil
	slot2 = GameDisplayCfg.collect_monster_background_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], 10)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot4 = GameDisplayCfg.collect_monster_background_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot4[1], slot4[2], slot4[3])
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

return slot0
