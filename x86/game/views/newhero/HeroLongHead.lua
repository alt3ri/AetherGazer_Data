local var_0_0 = class("HeroLongHead", ReduxView)

function var_0_0.OnCtor(arg_1_0, arg_1_1)
	arg_1_0.gameObject_ = arg_1_1
	arg_1_0.transform_ = arg_1_1.transform

	arg_1_0:Init()
end

function var_0_0.Init(arg_2_0)
	arg_2_0:InitUI()
	arg_2_0:AddUIListener()
end

function var_0_0.InitUI(arg_3_0)
	arg_3_0:BindCfgUI()

	arg_3_0.lockedController_ = arg_3_0.controller_:GetController("lock")
	arg_3_0.selectedController_ = arg_3_0.controller_:GetController("selected")
	arg_3_0.favorController_ = arg_3_0.controller_:GetController("favor")
	arg_3_0.favorabilityController_ = arg_3_0.controller_:GetController("favorability")
	arg_3_0.trialController_ = arg_3_0.controller_:GetController("trial")
	arg_3_0.hpController_ = arg_3_0.controller_:GetController("hp")
	arg_3_0.lableController_ = arg_3_0.controller_:GetController("label")
end

function var_0_0.SetRedPointEnable(arg_4_0, arg_4_1)
	SetActive(arg_4_0.noticePos_.gameObject, arg_4_1)
end

function var_0_0.SetProxy(arg_5_0, arg_5_1)
	arg_5_0.heroViewProxy_ = arg_5_1 or HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function var_0_0.SetHeroId(arg_6_0, arg_6_1, arg_6_2, arg_6_3)
	arg_6_0.heroDataType = arg_6_2

	if arg_6_2 == HeroConst.HERO_DATA_TYPE.TRIAL or heroDataType == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_6_1 = TempHeroData:GetHeroData(arg_6_1, arg_6_3).tempID
	end

	arg_6_0:SetHeroData(arg_6_1, arg_6_2)
end

function var_0_0.SetHeroData(arg_7_0, arg_7_1, arg_7_2)
	if arg_7_2 == HeroConst.HERO_DATA_TYPE.TRIAL or arg_7_2 == HeroConst.HERO_DATA_TYPE.CUSTOM then
		arg_7_0.trialID_ = arg_7_1
		arg_7_0.heroId_ = HeroStandardSystemCfg[arg_7_1].hero_id
		arg_7_1 = arg_7_0.heroId_
	else
		arg_7_0.heroId_ = arg_7_1
		arg_7_0.trialID_ = 0
	end

	arg_7_0.heroDataType_ = arg_7_2
	arg_7_0.heroCfg_ = HeroCfg[arg_7_1]
	arg_7_0.heroInfo_ = arg_7_0.heroViewProxy_:GetHeroData(arg_7_1)

	arg_7_0:UpdateView()

	if arg_7_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		local var_7_0 = RedPointConst.HERO_ID .. arg_7_1

		manager.redPoint:bindUIandKey(arg_7_0.noticePos_, var_7_0, {
			x = 0,
			y = 0
		})
	end

	if arg_7_0.favorController_ then
		if arg_7_0.heroViewProxy_.showfavorBtn then
			arg_7_0.favorController_:SetSelectedState(not HeroData:IsFavorite(arg_7_1) and "false" or "true")
		else
			arg_7_0.favorController_:SetSelectedState("false")
		end
	end
end

function var_0_0.UpdateView(arg_8_0)
	local var_8_0 = HeroCfg[arg_8_0.heroId_]
	local var_8_1 = arg_8_0.heroViewProxy_:GetHeroUsingSkinInfo(arg_8_0.heroId_).id

	arg_8_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_8_1)

	arg_8_0.headIcon_:SetNativeSize()

	arg_8_0.campLogo_.sprite = HeroTools.GetRaceIcon(var_8_0.race)
	arg_8_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_8_0.heroId_)

	arg_8_0:SetLevel(arg_8_0.heroInfo_.level or 1)
	arg_8_0:SetRareIcon()

	if arg_8_0:GetHeroUnLock() then
		arg_8_0.lockedController_:SetSelectedState("false")

		if arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.PREVIEW or arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DRAW then
			SetActive(arg_8_0.lvGo_, false)
		end

		arg_8_0.trialController_:SetSelectedState(arg_8_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.TRIAL and "true" or "false")
	else
		arg_8_0.lockedController_:SetSelectedState("true")
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_8_0.levelContent_)
end

function var_0_0.SetRareIcon(arg_9_0, arg_9_1)
	if arg_9_1 then
		arg_9_0.rareImg_.sprite = HeroTools.GetRareSprite(arg_9_1)
	else
		arg_9_0.rareImg_.sprite = HeroTools.GetRareSprite(math.floor(arg_9_0.heroInfo_.star / 100))
	end
end

function var_0_0.ShowFavorability(arg_10_0, arg_10_1)
	if arg_10_0.heroDataType_ == HeroConst.HERO_DATA_TYPE.DEFAULT then
		local var_10_0 = HeroRecordCfg[HeroRecordCfg.get_id_list_by_hero_id[arg_10_0.heroInfo_.id][1]]

		if ArchiveData:GetArchive(var_10_0.id).lv > 1 then
			arg_10_0.favorabilityText_.text = string.format(GetTips("HERO_HEART_CHAIN_LOVE_TIP"), ArchiveData:GetArchive(var_10_0.id).lv)
		end

		arg_10_0.favorabilityController_:SetSelectedState(tostring(arg_10_1 and ArchiveData:GetArchive(var_10_0.id).lv > 1))
	end
end

function var_0_0.GetHeroUnLock(arg_11_0)
	return arg_11_0.heroInfo_.unlock == 1
end

function var_0_0.SetUnlockDisplay(arg_12_0, arg_12_1)
	arg_12_0.lockedController_:SetSelectedState(arg_12_1 and "true" or "false")
end

function var_0_0.SetSelected(arg_13_0, arg_13_1)
	arg_13_0.selectedController_:SetSelectedState(arg_13_1 and "true" or "false")
end

function var_0_0.SetHp(arg_14_0, arg_14_1)
	arg_14_0.hpText_.text = math.floor(arg_14_1 * 100) .. "%"
	arg_14_0.hpSlider_.fillAmount = arg_14_1

	arg_14_0.hpController_:SetSelectedState(arg_14_1 ~= 0 and "true" or "false")
end

function var_0_0.SetLable(arg_15_0, arg_15_1)
	arg_15_0.lableText_.text = arg_15_1

	arg_15_0.lableController_:SetSelectedState(arg_15_1 ~= nil and "true" or "false")
end

function var_0_0.SetLevel(arg_16_0, arg_16_1)
	arg_16_0.levelText_.text = tostring(arg_16_1 or 1)
end

function var_0_0.SetHeroCfgData(arg_17_0, arg_17_1, arg_17_2, arg_17_3)
	local var_17_0 = HeroCfg[arg_17_1]

	arg_17_0.heroCfg_ = var_17_0
	arg_17_0.campLogo_.sprite = HeroTools.GetHeroRaceIcon(arg_17_1)

	if arg_17_3 == 0 then
		arg_17_0.rareImg_.sprite = HeroTools.GetRareSprite(var_17_0.rare or 0)
	else
		arg_17_0.rareImg_.sprite = HeroTools.GetRareSprite(arg_17_3)
	end

	arg_17_0.attackType_.sprite = HeroTools.GetHeroSkillAttributeIcon(arg_17_1)

	if arg_17_2 then
		local var_17_1 = SkinCfg[arg_17_2]

		arg_17_0.headIcon_.sprite = HeroTools.GetHeadSprite(var_17_1.picture_id)

		arg_17_0.headIcon_:SetNativeSize()
	end
end

function var_0_0.SetHeroSkin(arg_18_0, arg_18_1)
	arg_18_0.headIcon_.sprite = HeroTools.GetHeadSprite(arg_18_1)

	arg_18_0.headIcon_:SetNativeSize()
end

function var_0_0.RegisterClickListener(arg_19_0, arg_19_1)
	arg_19_0.clickListener_ = arg_19_1
end

function var_0_0.AddUIListener(arg_20_0)
	arg_20_0:AddBtnListener(arg_20_0.selfBtn_, nil, function()
		if arg_20_0.heroViewProxy_ and arg_20_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
			arg_20_0:ClearNewHeroRed(arg_20_0.heroCfg_.id)
		end

		if arg_20_0.clickListener_ ~= nil and arg_20_0.heroCfg_ then
			arg_20_0.clickListener_(arg_20_0.heroCfg_.id)
		end
	end)
end

function var_0_0.ClearNewHeroRed(arg_22_0, arg_22_1)
	if arg_22_1 and arg_22_0.heroViewProxy_ and arg_22_0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT then
		HeroTools.SetHeroNewTagRed(arg_22_1, "unlockHero", RedPointConst.HERO_ID .. arg_22_1, false)
	end
end

function var_0_0.Dispose(arg_23_0)
	manager.redPoint:unbindUIandKey(arg_23_0.noticePos_)
	arg_23_0:RemoveAllEventListener()

	arg_23_0.clickListener_ = nil

	var_0_0.super.Dispose(arg_23_0)
end

return var_0_0
