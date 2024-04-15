slot0 = class("HeroTrialView_2_0", ReduxView)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = Object.Instantiate(Asset.Load(slot0:UIName(slot2)), slot1.transform)
	slot0.transform_ = slot0.gameObject_.transform
	slot0.activityID_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddListeners()

	slot0.heroItemList_ = {}
	slot0.rewardItemList_ = {}
	slot0.itemDataList_ = {}
	slot0.onClickTrialHandler_ = handler(slot0, slot0.OnClickTrial)
	slot0.controller_ = ControllerUtil.GetController(slot0.transformBtn_, "name")
	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.imageIcon_.transform)
	slot0.attackTypeController_ = ControllerUtil.GetController(slot0.transform_, "attackType")
end

function slot0.UIName(slot0, slot1)
	return HeroTrialTools.GetMainUIName(slot1)
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function slot0.OnEnter(slot0)
	slot0.stopTime_ = ActivityData:GetActivityData(slot0.activityID_).stopTime
end

function slot0.OnExit(slot0)
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnReceive_, nil, function ()
		HeroTrialAction.GetTrialReward(uv0.selectActivityHeroID_, function (slot0)
			if isSuccess(slot0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[uv0.selectActivityHeroID_].reward_list))
				uv0:RefreshReward(uv0.selectActivityHeroID_)
			else
				ShowTips(slot0.result)
			end
		end)
	end)
	slot0:AddBtnListener(slot0.btnTrial_, nil, function ()
		slot0 = {}

		for slot4, slot5 in ipairs(uv0.activityHeroIDList_) do
			table.insert(slot0, HeroTrialTools.GetHeroStandardID(slot5))
		end

		uv0:Go("/newHero", {
			isEnter = true,
			hid = HeroTrialTools.GetHeroStandardID(uv0.selectActivityHeroID_),
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			tempHeroList = slot0
		})
	end)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		HeroTrialData:SaveStageID(uv0.selectActivityHeroID_)
		uv0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[uv0.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")
		})
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.onClickTrialHandler_ = nil

	for slot4, slot5 in pairs(slot0.rewardItemList_) do
		slot5:Dispose()
	end

	slot0.rewardItemList_ = nil
	slot0.itemDataList_ = nil

	for slot4, slot5 in pairs(slot0.heroItemList_) do
		slot5:Dispose()
	end

	slot0.heroItemList_ = nil

	Object.Destroy(slot0.gameObject_)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.RefreshUI(slot0)
	slot0.activityHeroIDList_ = ActivityHeroTrialCfg.get_id_list_by_activity_id[slot0.activityID_]
	slot2 = HeroTrialData:GetSelectActivityHeroID(slot0.activityID_) or slot1[1]
	slot0.selectActivityHeroID_ = slot2

	if slot2 == nil then
		return
	end

	HeroTrialData:SetSelectActivityHeroID(slot0.activityID_, slot2)
	slot0:RefreshHeroItem()

	slot3 = HeroTrialTools.GetHeroStandardID(slot2)
	slot0.heroID_ = HeroStandardSystemCfg[slot3].hero_id
	slot0.heroCfg_ = HeroCfg[slot0.heroID_]

	if getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[slot3].skin_id].picture_id) ~= nil then
		slot0.imageIcon_.sprite = slot4
	end

	slot0.imageIcon_:SetNativeSize()

	if slot0.adaptImg_ then
		slot0.adaptImg_:AdaptImg()
	end

	slot5 = string.format("%s·%s", slot0.heroCfg_.name, slot0.heroCfg_.suffix)

	slot0:RefreshTextName(slot5)

	slot0.textTips_.text = string.format(GetTips("COMPLETE_TRAIL_STAGE"), GetI18NText(slot5))
	slot0.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[slot0.heroCfg_.race].icon)

	slot0:RefreshReward(slot2)

	slot0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. slot0.heroCfg_.rare)

	slot0:RefreshRangeType()
	slot0:RefreshChargeType()
	slot0:RefreshAttackType()
end

function slot0.RefreshRangeType(slot0)
	slot0.rangeTypeText_.text = CharactorParamCfg[slot0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
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

function slot0.RefreshAttackType(slot0)
	if #slot0.heroCfg_.ATK_attribute > 1 then
		slot0.attackTypeController_:SetSelectedState(-1)
	else
		slot0.attackTypeController_:SetSelectedState(slot0.heroCfg_.ATK_attribute[1])
	end
end

function slot0.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = GetI18NText(slot2[1])
	slot0.textSubName_.text = GetI18NText(slot2[2])
end

function slot0.GetRewardItem(slot0, slot1)
	return HeroTrialRewardItem_2_0.New(slot0.goRewardPanel_, slot0.rewardItemGo_, slot1, true)
end

function slot0.RefreshHeroItem(slot0)
	slot1 = slot0.selectActivityHeroID_

	for slot6, slot7 in ipairs(slot0.activityHeroIDList_) do
		if slot0.heroItemList_[slot6] then
			slot0.heroItemList_[slot6]:SetActivityHeroID(slot0.activityID_, slot7)
		else
			slot0.heroItemList_[slot6] = slot0:GetHeroTrialSelectItemClass().New(slot0.goItem_, slot0.goItemParent_, slot7, slot0.activityID_)
		end
	end

	for slot6 = #slot0.heroItemList_, #slot2 + 1, -1 do
		slot0.heroItemList_[slot6]:Dispose()

		slot0.heroItemList_[slot6] = nil
	end

	for slot6, slot7 in pairs(slot2) do
		if slot7 == slot1 then
			slot0:RefreshSelectActivityHero(slot1)

			return
		end
	end

	slot0:RefreshSelectActivityHero(slot2[1])
end

function slot0.RefreshReward(slot0, slot1)
	if HeroTrialData:GetHeroTrialStateList()[slot1] then
		if slot2 == 1 then
			slot0.controller_:SetSelectedState("receive")
		elseif slot2 == 2 then
			slot0.controller_:SetSelectedState("complete")
		else
			slot0.controller_:SetSelectedState("not")
		end
	else
		slot0.controller_:SetSelectedState("not")
	end

	for slot7 = 1, 3 do
		slot8 = ActivityHeroTrialCfg[slot1].reward_list[slot7]

		if not slot0.itemDataList_[slot7] then
			slot0.itemDataList_[slot7] = clone(ItemTemplateData)

			slot0.itemDataList_[slot7].clickFun = function (slot0)
				ShowPopItem(POP_ITEM, {
					slot0.id,
					slot0.number
				})
			end
		end

		slot9 = true

		if slot8 then
			slot0.itemDataList_[slot7].id = slot8[1]
			slot0.itemDataList_[slot7].number = slot8[2]
			slot0.itemDataList_[slot7].completedFlag = slot2 == 2
			slot9 = false
		end

		if slot0.rewardItemList_[slot7] == nil then
			slot0.rewardItemList_[slot7] = CommonItemPool.New(slot0.goRewardPanel_, nil, true)
		end

		if not slot9 then
			slot0.rewardItemList_[slot7]:SetData(slot0.itemDataList_[slot7])
		else
			slot0.rewardItemList_[slot7]:SetData(nil)
		end
	end
end

function slot0.OnClickTrial(slot0)
	slot0:RefreshUI()
end

function slot0.GetHeroTrialSelectItemClass(slot0)
	return HeroTrialSelectItem_2_0
end

function slot0.RefreshSelectActivityHero(slot0, slot1)
	for slot5, slot6 in pairs(slot0.heroItemList_) do
		slot6:OnSelect(slot1)
	end
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		slot0:RefreshUI()
		slot0:AddTimer()
		manager.notify:RegistListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)
	else
		slot0:StopTimer()
		manager.notify:RemoveListener(HERO_TRIAL_CLICK, slot0.onClickTrialHandler_)
	end
end

function slot0.AddTimer(slot0)
	if slot0.stopTime_ <= manager.time:GetServerTime() then
		slot0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	slot0:StopTimer()

	slot0.textTime_.text = manager.time:GetLostTimeStr(slot0.stopTime_)
	slot0.timer_ = Timer.New(function ()
		if uv0.stopTime_ <= manager.time:GetServerTime() then
			uv0:StopTimer()

			uv0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		uv0.textTime_.text = manager.time:GetLostTimeStr(uv0.stopTime_)
	end, 1, -1)

	slot0.timer_:Start()
end

function slot0.StopTimer(slot0)
	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
	end
end

return slot0
