slot0 = class("HeroLongHead", ReduxView)

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

	slot0.lockedController_ = slot0.controller_:GetController("lock")
	slot0.selectedController_ = slot0.controller_:GetController("selected")
	slot0.favorController_ = slot0.controller_:GetController("favor")
	slot0.favorabilityController_ = slot0.controller_:GetController("favorability")
	slot0.trialController_ = slot0.controller_:GetController("trial")
	slot0.hpController_ = slot0.controller_:GetController("hp")
	slot0.lableController_ = slot0.controller_:GetController("label")
end

function slot0.SetRedPointEnable(slot0, slot1)
	SetActive(slot0.noticePos_.gameObject, slot1)
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function slot0.SetHeroId(slot0, slot1, slot2, slot3)
	slot0.heroDataType = slot2

	if slot2 == HeroConst.HERO_DATA_TYPE.TRIAL or heroDataType == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot1 = TempHeroData:GetHeroData(slot1, slot3).tempID
	end

	slot0:SetHeroData(slot1, slot2)
end

function slot0.SetHeroData(slot0, slot1, slot2)
	if slot2 == HeroConst.HERO_DATA_TYPE.TRIAL or slot2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		slot0.trialID_ = slot1
		slot0.heroId_ = HeroStandardSystemCfg[slot1].hero_id
		slot1 = slot0.heroId_
	else
		slot0.heroId_ = slot1
		slot0.trialID_ = 0
	end

	slot0.heroDataType_ = slot2
	slot0.heroCfg_ = HeroCfg[slot1]
	slot0.heroInfo_ = slot0.heroViewProxy_:GetHeroData(slot1)

	slot0:UpdateView()

	if slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		manager.redPoint:bindUIandKey(slot0.noticePos_, RedPointConst.HERO_ID .. slot1, {
			x = 0,
			y = 0
		})
	end

	if slot0.favorController_ then
		if slot0.heroViewProxy_.showfavorBtn then
			slot0.favorController_:SetSelectedState(not HeroData:IsFavorite(slot1) and "false" or "true")
		else
			slot0.favorController_:SetSelectedState("false")
		end
	end
end

function slot0.UpdateView(slot0)
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot0.heroViewProxy_:GetHeroUsingSkinInfo(slot0.heroId_).id)

	slot0.headIcon_:SetNativeSize()

	slot0.campLogo_.sprite = HeroTools.GetRaceIcon(HeroCfg[slot0.heroId_].race)
	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot0.heroId_)

	slot0:SetLevel(slot0.heroInfo_.level or 1)
	slot0:SetRareIcon()

	if slot0:GetHeroUnLock() then
		slot0.lockedController_:SetSelectedState("false")

		if slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(slot0.lvGo_, false)
		end

		slot0.trialController_:SetSelectedState(slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.TRIAL and "true" or "false")
	else
		slot0.lockedController_:SetSelectedState("true")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.levelContent_)
end

function slot0.SetRareIcon(slot0, slot1)
	if slot1 then
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(slot1)
	else
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(slot0.heroInfo_.star / 100))
	end
end

function slot0.ShowFavorability(slot0, slot1)
	if slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
		if ArchiveData:GetArchive(HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[slot0.heroInfo_.id][1]].id).lv > 1 then
			slot0.favorabilityText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), ArchiveData:GetArchive(slot2.id).lv)
		end

		slot0.favorabilityController_:SetSelectedState(tostring(slot1 and ArchiveData:GetArchive(slot2.id).lv > 1))
	end
end

function slot0.GetHeroUnLock(slot0)
	return slot0.heroInfo_.unlock == 1
end

function slot0.SetUnlockDisplay(slot0, slot1)
	slot0.lockedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetSelected(slot0, slot1)
	slot0.selectedController_:SetSelectedState(slot1 and "true" or "false")
end

function slot0.SetHp(slot0, slot1)
	slot0.hpText_.text = math.floor(slot1 * 100) .. "%"
	slot0.hpSlider_.fillAmount = slot1

	slot0.hpController_:SetSelectedState(slot1 ~= 0 and "true" or "false")
end

function slot0.SetLable(slot0, slot1)
	slot0.lableText_.text = slot1

	slot0.lableController_:SetSelectedState(slot1 ~= nil and "true" or "false")
end

function slot0.SetLevel(slot0, slot1)
	slot0.levelText_.text = tostring(slot1 or 1)
end

function slot0.SetHeroCfgData(slot0, slot1, slot2, slot3)
	slot0.heroCfg_ = HeroCfg[slot1]
	slot0.campLogo_.sprite = HeroTools.GetHeroRaceIcon(slot1)

	if slot3 == 0 then
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(slot4.rare or 0)
	else
		slot0.rareImg_.sprite = HeroTools.GetRareSprite(slot3)
	end

	slot0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(slot1)

	if slot2 then
		slot0.headIcon_.sprite = HeroTools.GetHeadSprite(SkinCfg[slot2].picture_id)

		slot0.headIcon_:SetNativeSize()
	end
end

function slot0.SetHeroSkin(slot0, slot1)
	slot0.headIcon_.sprite = HeroTools.GetHeadSprite(slot1)

	slot0.headIcon_:SetNativeSize()
end

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		if uv0.heroViewProxy_ and uv0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
			uv0:ClearNewHeroRed(uv0.heroCfg_.id)
		end

		if uv0.clickListener_ ~= nil and uv0.heroCfg_ then
			uv0.clickListener_(uv0.heroCfg_.id)
		end
	end)
end

function slot0.ClearNewHeroRed(slot0, slot1)
	if slot1 and slot0.heroViewProxy_ and slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(slot1, "unlockHero", RedPointConst.HERO_ID .. slot1, false)
	end
end

function slot0.Dispose(slot0)
	manager.redPoint:unbindUIandKey(slot0.noticePos_)
	slot0:RemoveAllEventListener()

	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
