local var_0_0 = class("HeroTrialView_2_0", ReduxView)

function var_0_0.Ctor(arg_1_0, arg_1_1, arg_1_2)
	local var_1_0 = Asset.Load(arg_1_0:UIName(arg_1_2))

	arg_1_0.gameObject_ = Object.Instantiate(var_1_0, arg_1_1.transform)
	arg_1_0.transform_ = arg_1_0.gameObject_.transform
	arg_1_0.activityID_ = arg_1_2

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:BindCfgUI()
	arg_2_0:AddListeners()

	arg_2_0.heroItemList_ = {}
	arg_2_0.rewardItemList_ = {}
	arg_2_0.itemDataList_ = {}
	arg_2_0.onClickTrialHandler_ = handler(arg_2_0, arg_2_0.OnClickTrial)
	arg_2_0.controller_ = ControllerUtil.GetController(arg_2_0.transformBtn_, "name")
	arg_2_0.adaptImg_ = arg_2_0:FindCom("AdaptImage", nil, arg_2_0.imageIcon_.transform)
	arg_2_0.attackTypeController_ = ControllerUtil.GetController(arg_2_0.transform_, "attackType")
end

function var_0_0.UIName(arg_3_0, arg_3_1)
	return HeroTrialTools.GetMainUIName(arg_3_1)
end

function var_0_0.UpdateBar(arg_4_0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
end

function var_0_0.OnEnter(arg_5_0)
	arg_5_0.stopTime_ = ActivityData:GetActivityData(arg_5_0.activityID_).stopTime
end

function var_0_0.OnExit(arg_6_0)
	return
end

function var_0_0.AddListeners(arg_7_0)
	arg_7_0:AddBtnListener(arg_7_0.btnReceive_, nil, function()
		HeroTrialAction.GetTrialReward(arg_7_0.selectActivityHeroID_, function(arg_9_0)
			if isSuccess(arg_9_0.result) then
				getReward(formatRewardCfgList(ActivityHeroTrialCfg[arg_7_0.selectActivityHeroID_].reward_list))
				arg_7_0:RefreshReward(arg_7_0.selectActivityHeroID_)
			else
				ShowTips(arg_9_0.result)
			end
		end)
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnTrial_, nil, function()
		local var_10_0 = {}

		for iter_10_0, iter_10_1 in ipairs(arg_7_0.activityHeroIDList_) do
			local var_10_1 = HeroTrialTools.GetHeroStandardID(iter_10_1)

			table.insert(var_10_0, var_10_1)
		end

		arg_7_0:Go("/newHero", {
			isEnter = true,
			hid = HeroTrialTools.GetHeroStandardID(arg_7_0.selectActivityHeroID_),
			type = HeroConst.HERO_DATA_TYPE.TRIAL,
			tempHeroList = var_10_0
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.btnBattle_, nil, function()
		HeroTrialData:SaveStageID(arg_7_0.selectActivityHeroID_)
		arg_7_0:Go("/sectionSelectHero", {
			section = ActivityHeroTrialCfg[arg_7_0.selectActivityHeroID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.HERO_TRIAL,
			activityID = arg_7_0.activityID_
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.descBtn_, nil, function()
		local var_12_0 = GetTips("ACTIVITY_HERO_TRIAL_DESCRIPE")

		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_HERO_TRIAL_DESCRIPE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = var_12_0
		})
	end)
end

function var_0_0.Dispose(arg_13_0)
	var_0_0.super.Dispose(arg_13_0)

	arg_13_0.onClickTrialHandler_ = nil

	for iter_13_0, iter_13_1 in pairs(arg_13_0.rewardItemList_) do
		iter_13_1:Dispose()
	end

	arg_13_0.rewardItemList_ = nil
	arg_13_0.itemDataList_ = nil

	for iter_13_2, iter_13_3 in pairs(arg_13_0.heroItemList_) do
		iter_13_3:Dispose()
	end

	arg_13_0.heroItemList_ = nil

	Object.Destroy(arg_13_0.gameObject_)

	arg_13_0.transform_ = nil
	arg_13_0.gameObject_ = nil
end

function var_0_0.RefreshUI(arg_14_0)
	local var_14_0 = ActivityHeroTrialCfg.get_id_list_by_activity_id[arg_14_0.activityID_]

	arg_14_0.activityHeroIDList_ = var_14_0

	local var_14_1 = HeroTrialData:GetSelectActivityHeroID(arg_14_0.activityID_) or var_14_0[1]

	arg_14_0.selectActivityHeroID_ = var_14_1

	if var_14_1 == nil then
		return
	end

	HeroTrialData:SetSelectActivityHeroID(arg_14_0.activityID_, var_14_1)
	arg_14_0:RefreshHeroItem()

	local var_14_2 = HeroTrialTools.GetHeroStandardID(var_14_1)

	arg_14_0.heroID_ = HeroStandardSystemCfg[var_14_2].hero_id
	arg_14_0.heroCfg_ = HeroCfg[arg_14_0.heroID_]

	local var_14_3 = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[var_14_2].skin_id].picture_id)

	if var_14_3 ~= nil then
		arg_14_0.imageIcon_.sprite = var_14_3
	end

	arg_14_0.imageIcon_:SetNativeSize()

	if arg_14_0.adaptImg_ then
		arg_14_0.adaptImg_:AdaptImg()
	end

	local var_14_4 = string.format("%s·%s", arg_14_0.heroCfg_.name, arg_14_0.heroCfg_.suffix)

	arg_14_0:RefreshTextName(var_14_4)

	local var_14_5 = GetTips("COMPLETE_TRAIL_STAGE")

	arg_14_0.textTips_.text = string.format(var_14_5, GetI18NText(var_14_4))
	arg_14_0.imageRace_.sprite = getSprite("Atlas/CampItemAtlas", RaceEffectCfg[arg_14_0.heroCfg_.race].icon)

	arg_14_0:RefreshReward(var_14_1)

	arg_14_0.imageLv_.sprite = getSprite("Atlas/Common", "star_" .. arg_14_0.heroCfg_.rare)

	arg_14_0:RefreshRangeType()
	arg_14_0:RefreshChargeType()
	arg_14_0:RefreshAttackType()
end

function var_0_0.RefreshRangeType(arg_15_0)
	arg_15_0.rangeTypeText_.text = CharactorParamCfg[arg_15_0.heroID_].RangeType == 0 and GetTips("RANGETYPE_CLOSE") or GetTips("RANGETYPE_LONG")
end

function var_0_0.RefreshChargeType(arg_16_0)
	local var_16_0 = arg_16_0.heroCfg_.mechanism_type[1]

	if var_16_0 == HeroConst.HERO_CHARGE_TYPE.RAGE then
		arg_16_0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_1")
	elseif var_16_0 == HeroConst.HERO_CHARGE_TYPE.ENERGY then
		arg_16_0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_2")
	elseif var_16_0 == HeroConst.HERO_CHARGE_TYPE.TRACES then
		arg_16_0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_3")
	elseif var_16_0 == HeroConst.HERO_CHARGE_TYPE.DIVINE_GRACE then
		arg_16_0.chargeType_.text = GetTips("NOTE_ENERGYTYPE_4")
	end
end

function var_0_0.RefreshAttackType(arg_17_0)
	if #arg_17_0.heroCfg_.ATK_attribute > 1 then
		arg_17_0.attackTypeController_:SetSelectedState(-1)
	else
		local var_17_0 = arg_17_0.heroCfg_.ATK_attribute[1]

		arg_17_0.attackTypeController_:SetSelectedState(var_17_0)
	end
end

function var_0_0.RefreshTextName(arg_18_0, arg_18_1)
	local var_18_0 = string.split(arg_18_1, "·")

	arg_18_0.textName_.text = GetI18NText(var_18_0[1])
	arg_18_0.textSubName_.text = GetI18NText(var_18_0[2])
end

function var_0_0.GetRewardItem(arg_19_0, arg_19_1)
	return HeroTrialRewardItem_2_0.New(arg_19_0.goRewardPanel_, arg_19_0.rewardItemGo_, arg_19_1, true)
end

function var_0_0.RefreshHeroItem(arg_20_0)
	local var_20_0 = arg_20_0.selectActivityHeroID_
	local var_20_1 = arg_20_0.activityHeroIDList_

	for iter_20_0, iter_20_1 in ipairs(var_20_1) do
		if arg_20_0.heroItemList_[iter_20_0] then
			arg_20_0.heroItemList_[iter_20_0]:SetActivityHeroID(arg_20_0.activityID_, iter_20_1)
		else
			arg_20_0.heroItemList_[iter_20_0] = arg_20_0:GetHeroTrialSelectItemClass().New(arg_20_0.goItem_, arg_20_0.goItemParent_, iter_20_1, arg_20_0.activityID_)
		end
	end

	for iter_20_2 = #arg_20_0.heroItemList_, #var_20_1 + 1, -1 do
		arg_20_0.heroItemList_[iter_20_2]:Dispose()

		arg_20_0.heroItemList_[iter_20_2] = nil
	end

	for iter_20_3, iter_20_4 in pairs(var_20_1) do
		if iter_20_4 == var_20_0 then
			arg_20_0:RefreshSelectActivityHero(var_20_0)

			return
		end
	end

	arg_20_0:RefreshSelectActivityHero(var_20_1[1])
end

function var_0_0.RefreshReward(arg_21_0, arg_21_1)
	local var_21_0 = HeroTrialData:GetHeroTrialStateList()[arg_21_1]

	if var_21_0 then
		if var_21_0 == 1 then
			arg_21_0.controller_:SetSelectedState("receive")
		elseif var_21_0 == 2 then
			arg_21_0.controller_:SetSelectedState("complete")
		else
			arg_21_0.controller_:SetSelectedState("not")
		end
	else
		arg_21_0.controller_:SetSelectedState("not")
	end

	local var_21_1 = ActivityHeroTrialCfg[arg_21_1].reward_list

	for iter_21_0 = 1, 3 do
		local var_21_2 = var_21_1[iter_21_0]

		if not arg_21_0.itemDataList_[iter_21_0] then
			arg_21_0.itemDataList_[iter_21_0] = clone(ItemTemplateData)
			arg_21_0.itemDataList_[iter_21_0].clickFun = function(arg_22_0)
				ShowPopItem(POP_ITEM, {
					arg_22_0.id,
					arg_22_0.number
				})
			end
		end

		local var_21_3 = true

		if var_21_2 then
			arg_21_0.itemDataList_[iter_21_0].id = var_21_2[1]
			arg_21_0.itemDataList_[iter_21_0].number = var_21_2[2]
			arg_21_0.itemDataList_[iter_21_0].completedFlag = var_21_0 == 2
			var_21_3 = false
		end

		if arg_21_0.rewardItemList_[iter_21_0] == nil then
			arg_21_0.rewardItemList_[iter_21_0] = CommonItemPool.New(arg_21_0.goRewardPanel_, nil, true)
		end

		if not var_21_3 then
			arg_21_0.rewardItemList_[iter_21_0]:SetData(arg_21_0.itemDataList_[iter_21_0])
		else
			arg_21_0.rewardItemList_[iter_21_0]:SetData(nil)
		end
	end
end

function var_0_0.OnClickTrial(arg_23_0)
	arg_23_0:RefreshUI()
end

function var_0_0.GetHeroTrialSelectItemClass(arg_24_0)
	return HeroTrialSelectItem_2_0
end

function var_0_0.RefreshSelectActivityHero(arg_25_0, arg_25_1)
	for iter_25_0, iter_25_1 in pairs(arg_25_0.heroItemList_) do
		iter_25_1:OnSelect(arg_25_1)
	end
end

function var_0_0.Show(arg_26_0, arg_26_1)
	SetActive(arg_26_0.gameObject_, arg_26_1)

	if arg_26_1 == true then
		arg_26_0:RefreshUI()
		arg_26_0:AddTimer()
		manager.notify:RegistListener(HERO_TRIAL_CLICK, arg_26_0.onClickTrialHandler_)
	else
		arg_26_0:StopTimer()
		manager.notify:RemoveListener(HERO_TRIAL_CLICK, arg_26_0.onClickTrialHandler_)
	end
end

function var_0_0.AddTimer(arg_27_0)
	if manager.time:GetServerTime() >= arg_27_0.stopTime_ then
		arg_27_0.textTime_.text = GetTips("TIME_OVER")

		return
	end

	arg_27_0:StopTimer()

	arg_27_0.textTime_.text = manager.time:GetLostTimeStr(arg_27_0.stopTime_)
	arg_27_0.timer_ = Timer.New(function()
		if manager.time:GetServerTime() >= arg_27_0.stopTime_ then
			arg_27_0:StopTimer()

			arg_27_0.textTime_.text = GetTips("TIME_OVER")

			return
		end

		arg_27_0.textTime_.text = manager.time:GetLostTimeStr(arg_27_0.stopTime_)
	end, 1, -1)

	arg_27_0.timer_:Start()
end

function var_0_0.StopTimer(arg_29_0)
	if arg_29_0.timer_ then
		arg_29_0.timer_:Stop()

		arg_29_0.timer_ = nil
	end
end

return var_0_0
