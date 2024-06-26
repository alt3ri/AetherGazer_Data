slot0 = class("HeroTrialSelectItem_2_0", ReduxView)

function slot0.Ctor(slot0, slot1, slot2, slot3, slot4)
	slot0.gameObject_ = Object.Instantiate(slot1, slot2.transform)
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.controller_ = ControllerUtil.GetController(slot0.transform_, "name")

	slot0:SetActivityHeroID(slot4, slot3)
	SetActive(slot0.gameObject_, true)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot1 = ActivityHeroTrialCfg[slot0.acitvityTrialID_]
	slot2 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot1.activity_id, slot1.id)

	manager.redPoint:unbindUIandKey(slot0.transformBtn1_, slot2)
	manager.redPoint:unbindUIandKey(slot0.transformBtn2_, slot2)
	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		HeroTrialData:SetSelectActivityHeroID(uv0.activityID_, uv0.acitvityTrialID_)
		manager.notify:Invoke(HERO_TRIAL_CLICK)
	end)
end

function slot0.SetActivityHeroID(slot0, slot1, slot2)
	if slot0.acitvityTrialID_ == nil then
		slot3 = ActivityHeroTrialCfg[slot2]
		slot4 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot3.activity_id, slot3.id)

		manager.redPoint:bindUIandKey(slot0.transformBtn1_, slot4)
		manager.redPoint:bindUIandKey(slot0.transformBtn2_, slot4)
	elseif slot0.acitvityTrialID_ ~= slot2 then
		slot3 = ActivityHeroTrialCfg[slot0.acitvityTrialID_]
		slot4 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot3.activity_id, slot3.id)

		manager.redPoint:unbindUIandKey(slot0.transformBtn1_, slot4)
		manager.redPoint:unbindUIandKey(slot0.transformBtn2_, slot4)

		slot5 = ActivityHeroTrialCfg[slot2]
		slot6 = string.format("%s_%s_%s", RedPointConst.HERO_TRIAL, slot5.activity_id, slot5.id)

		manager.redPoint:bindUIandKey(slot0.transformBtn1_, slot6)
		manager.redPoint:bindUIandKey(slot0.transformBtn2_, slot6)
	end

	slot0.acitvityTrialID_ = slot2
	slot0.activityID_ = slot1

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = HeroTrialTools.GetHeroStandardID(slot0.acitvityTrialID_)
	slot2 = SkinCfg[HeroStandardSystemCfg[slot1].skin_id].picture_id
	slot0.imageSelect_.sprite = getSpriteViaConfig("HeroIcon", slot2)
	slot0.imageIcon_.sprite = getSpriteViaConfig("HeroIcon", slot2)
	slot3 = HeroCfg[HeroStandardSystemCfg[slot1].hero_id].race
	slot0.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot3].icon)
	slot0.imageRaceSelect_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot3].icon)
end

function slot0.OnSelect(slot0, slot1)
	if slot0.acitvityTrialID_ == slot1 then
		slot0.controller_:SetSelectedState("Select")
	else
		slot0.controller_:SetSelectedState("no")
	end
end

return slot0
