slot0 = class("HeroPreviewInfoView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.rewardBtn_, nil, function ()
		JumpTools.OpenPageByJump("raceCollectReward", {})
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	manager.redPoint:bindUIandKey(slot0.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)

	slot0.heroInfo_ = slot1
	slot0.heroCfg_ = HeroCfg[slot1.id]
	slot0.curHeroId_ = slot1.id

	slot0:UpdateView()
end

function slot0.UpdateView(slot0)
	slot0.nameText_.text = GetI18NText(slot0.heroCfg_.name)
	slot0.subNameText_.text = GetI18NText(slot0.heroCfg_.suffix)
	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(slot0.heroCfg_.race)
	slot0.starImg_.sprite = getSprite("Atlas/Common", "star_" .. slot0.heroCfg_.rare)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroCfg_.id)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroInfo_.id].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
	slot0.infoText_.text = slot0.heroCfg_.hero_desc

	slot0:RefreshChargeType()
	SetActive(slot0.playBtnGo_, ObtainHeroMovieCfg[slot0.curHeroId_] ~= nil and slot0.heroInfo_.unlock == 1)
end

function slot0.RefreshChargeType(slot0)
	function uv0.RefreshChargeType(slot0)
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
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.rewardTrs_, RedPointConst.HERO_RACE_COLLECT_REWARD)
end

return slot0
