slot0 = class("HeroShortHead", ReduxView)

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
end

function slot0.SetRedPointEnable(slot0, slot1)
	SetActive(slot0.noticePos_.gameObject, slot1)
end

function slot0.SetProxy(slot0, slot1)
	slot0.heroViewProxy_ = slot1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function slot0.SetHeroId(slot0, slot1, slot2, slot3)
	slot0.heroDataType = slot2

	if slot2 == HeroConst.HERO_DATA_TYPE.TRIAL then
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

	slot0.levelText_.text = tostring(slot0.heroInfo_.level or 1)

	if slot0:GetHeroUnLock() then
		slot0.lockedController_:SetSelectedState("false")

		if slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or slot0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(slot0.lvGo_, false)
		end
	else
		slot0.lockedController_:SetSelectedState("true")
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

function slot0.RegisterClickListener(slot0, slot1)
	slot0.clickListener_ = slot1
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.selfBtn_, nil, function ()
		uv0:ClearNewHeroRed(uv0.heroCfg_.id)

		if uv0.clickListener_ ~= nil then
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
	slot0:RemoveAllListeners()

	slot0.clickListener_ = nil

	uv0.super.Dispose(slot0)
end

return slot0
