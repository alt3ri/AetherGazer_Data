local var_0_0 = class("HeroFileGiftPage", ReduxView)
local var_0_1

local function var_0_2()
	if not var_0_1 then
		var_0_1 = 0

		for iter_1_0 = 1, HeroConst.HERO_LOVE_LV_MAX do
			var_0_1 = var_0_1 + GameLevelSetting[iter_1_0].hero_love_exp
		end
	end

	return var_0_1
end

local function var_0_3(arg_2_0, arg_2_1)
	local var_2_0 = HeroRecordCfg[arg_2_0].gift_like_id1[1]
	local var_2_1 = GameSetting.gift_value.value

	if arg_2_1 == var_2_0 then
		return var_2_1[1]
	end

	return var_2_1[2]
end

local function var_0_4(arg_3_0, arg_3_1)
	local var_3_0, var_3_1, var_3_2 = ArchiveData:GetTrustLevel(arg_3_0)
	local var_3_3 = 1

	if HeroTrustMoodCfg[var_3_2] then
		var_3_3 = HeroTrustMoodCfg[var_3_2].trust_exp_rate / 1000
	end

	local var_3_4 = ItemCfg[arg_3_1]

	if var_3_4.sub_type == 1 then
		return math.floor(GameSetting.hero_trust_favor_gift_add_exp.value[1] * var_3_3)
	elseif var_3_4.sub_type == 2 then
		return math.floor(var_3_4.param[1] * var_3_3)
	else
		return 0
	end
end

function var_0_0.OnCtor(arg_4_0, arg_4_1, arg_4_2)
	arg_4_0.gameObject_ = arg_4_1
	arg_4_0.transform_ = arg_4_1.transform
	arg_4_0.previewLvCB_ = arg_4_2

	arg_4_0:Init()
end

function var_0_0.Init(arg_5_0)
	arg_5_0:InitUI()
	arg_5_0:AddUIListener()
end

function var_0_0.InitUI(arg_6_0)
	arg_6_0:BindCfgUI()

	arg_6_0.curHeroID_ = 0
	arg_6_0.curRecordID_ = 0
	arg_6_0.curHeroLikeID_ = {}
	arg_6_0.giftList_ = {}
	arg_6_0.curGiftIndex_ = 0
	arg_6_0.taskList_ = {}
	arg_6_0.voiceCoolDown_ = false
	arg_6_0.likePanelStateController_ = arg_6_0.giftControllerEx_:GetController("likePanelState")
	arg_6_0.likeStateController_ = arg_6_0.giftControllerEx_:GetController("likeState")
	arg_6_0.moodStateController_ = arg_6_0.giftControllerEx_:GetController("moodIconState")
	arg_6_0.giftLuaUIList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexGiftItem), arg_6_0.giftUilist_, CommonItemView)
	arg_6_0.trustLvUpTaskLuaUIList_ = LuaList.New(handler(arg_6_0, arg_6_0.IndexTaskItem), arg_6_0.trustLvTaskUilist_, HeroFileGiftTrustLvUpTaskItem)
	arg_6_0.contentSizeFitter_ = arg_6_0.detailTrs_:GetComponent("ContentSizeFitter")
end

function var_0_0.AddUIListener(arg_7_0)
	arg_7_0.giftNumSlr_.onValueChanged:AddListener(function(arg_8_0)
		if arg_8_0 < 1 then
			arg_7_0.giftNumSlr_.value = 1
			arg_8_0 = 1
		end

		arg_7_0.giftNumText_.text = "选择数量:" .. arg_8_0

		local var_8_0 = ArchiveData:GetTrustLevel(arg_7_0.curHeroID_)
		local var_8_1 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
		local var_8_2 = var_8_0 > 0 and var_0_4(arg_7_0.curHeroID_, var_8_1) or var_0_3(arg_7_0.curRecordID_, var_8_1)

		arg_7_0:RefreshExpProcess(var_8_2 * arg_8_0)

		arg_7_0.giftReduceBtn_.interactable = arg_8_0 > 1
		arg_7_0.giftAddBtn_.interactable = arg_8_0 < arg_7_0.giftNumSlr_.maxValue
	end)
	arg_7_0:AddBtnListener(arg_7_0.giftReduceBtn_, nil, function()
		local var_9_0 = ItemTools.getItemNum(arg_7_0.giftList_[arg_7_0.curGiftIndex_].id)

		if arg_7_0.giftNumSlr_.value > 1 then
			arg_7_0.giftNumSlr_.value = arg_7_0.giftNumSlr_.value - 1
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.giftAddBtn_, nil, function()
		local var_10_0 = ItemTools.getItemNum(arg_7_0.giftList_[arg_7_0.curGiftIndex_].id)

		if arg_7_0.giftNumSlr_.value < arg_7_0.giftNumSlr_.maxValue then
			arg_7_0.giftNumSlr_.value = arg_7_0.giftNumSlr_.value + 1
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.presentBtn_, nil, function()
		local var_11_0 = ArchiveData:GetTrustLevel(arg_7_0.curHeroID_)

		if var_11_0 > 0 then
			local var_11_1 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
			local var_11_2 = arg_7_0.giftNumSlr_.value

			if var_11_2 == 0 then
				var_11_2 = 1
			end

			Debug.Log("角色的交心等级是" .. var_11_0)
			Debug.Log("要送的礼物id和数量是" .. var_11_1 .. " " .. var_11_2)
			ArchiveAction.QuerySendTrustItem(arg_7_0.curHeroID_, {
				{
					id = var_11_1,
					num = var_11_2
				}
			})
		else
			local var_11_3 = arg_7_0.giftList_[arg_7_0.curGiftIndex_].id
			local var_11_4 = arg_7_0.giftNumSlr_.value

			if var_11_4 == 0 then
				var_11_4 = 1
			end

			local var_11_5 = var_11_4 * var_0_3(arg_7_0.curRecordID_, var_11_3)
			local var_11_6 = ArchiveData:GetArchive(arg_7_0.curRecordID_).exp

			if var_11_6 + var_11_5 > var_0_2() then
				var_11_5 = var_0_2() - var_11_6
			end

			HeroAction.SendGift(arg_7_0.curRecordID_, {
				{
					id = var_11_3,
					num = var_11_4
				}
			}, var_11_5)
		end
	end)
	arg_7_0:AddBtnListener(arg_7_0.breakBtn_, nil, function()
		ArchiveAction.QueryUnlockTrust(arg_7_0.curHeroID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.trustLvBtn_, nil, function()
		for iter_13_0, iter_13_1 in ipairs(arg_7_0.taskList_) do
			if not IsConditionAchieved(iter_13_1, {
				heroId = arg_7_0.curHeroID_
			}) then
				ShowTips("HERO_TRUST_UP_LV_LOCK")

				return
			end
		end

		ArchiveAction.QueryUpgradeTrustLevel(arg_7_0.curHeroID_)
	end)
	arg_7_0:AddBtnListener(arg_7_0.changeGiftBtn_, nil, function()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	arg_7_0:AddBtnListener(arg_7_0.moodTipsBtn_, nil, function()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("HERO_TRUST_MOOD_DESC")
		})
	end)
	arg_7_0:AddBtnListener(arg_7_0.m_listenBtn, nil, function()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = arg_7_0.curRecordID_
		})
	end)
end

function var_0_0.IndexGiftItem(arg_17_0, arg_17_1, arg_17_2)
	local var_17_0 = clone(ItemTemplateData)

	var_17_0.id = arg_17_0.giftList_[arg_17_1].id
	var_17_0.number = arg_17_0.giftList_[arg_17_1].num
	var_17_0.selectStyle = arg_17_1 == arg_17_0.curGiftIndex_
	var_17_0.favouriteFlag = table.indexof(arg_17_0.curHeroLikeID_, var_17_0.id) ~= false

	function var_17_0.clickFun()
		if arg_17_1 == arg_17_0.curGiftIndex_ then
			return
		end

		if arg_17_0.curGiftIndex_ ~= 0 then
			local var_18_0 = arg_17_0.giftLuaUIList_:GetItemList()[arg_17_0.curGiftIndex_]

			if var_18_0 then
				var_18_0:RefreshSelectState(false)
			end
		end

		arg_17_2:RefreshSelectState(true)

		arg_17_0.curGiftIndex_ = arg_17_1

		arg_17_0:RefreshGiftInfo()
	end

	arg_17_2:SetData(var_17_0)
end

function var_0_0.IndexTaskItem(arg_19_0, arg_19_1, arg_19_2)
	local var_19_0 = arg_19_0.taskList_[arg_19_1]

	arg_19_2:SetData(var_19_0, arg_19_0.curHeroID_)
end

function var_0_0.Show(arg_20_0, arg_20_1, arg_20_2)
	arg_20_0.curHeroID_ = arg_20_2
	arg_20_0.curRecordID_ = arg_20_1
	arg_20_0.curHeroLikeID_ = HeroRecordCfg[arg_20_1].gift_like_id1

	arg_20_0:UpdateGiftData()
	arg_20_0:RefreshExpProcess()
	arg_20_0:UpdatePageState()
	SetActive(arg_20_0.gameObject_, true)
end

function var_0_0.Hide(arg_21_0)
	arg_21_0:StopVoice()

	if arg_21_0.contentSizeTimer_ then
		arg_21_0.contentSizeTimer_:Stop()

		arg_21_0.contentSizeTimer_ = nil
	end

	SetActive(arg_21_0.gameObject_, false)
end

function var_0_0.UpdateGiftData(arg_22_0)
	arg_22_0.giftList_ = {}

	local var_22_0, var_22_1 = ArchiveData:GetTrustLevel(arg_22_0.curHeroID_)
	local var_22_2 = 1

	for iter_22_0 = 1, #arg_22_0.curHeroLikeID_ do
		local var_22_3 = arg_22_0.curHeroLikeID_[iter_22_0]
		local var_22_4 = ItemTools.getItemNum(var_22_3)

		if var_22_4 > 0 then
			arg_22_0.giftList_[var_22_2] = {
				id = var_22_3,
				num = var_22_4
			}
			var_22_2 = var_22_2 + 1
		end
	end

	if var_22_0 > 0 then
		local var_22_5 = HeroTrustLevelCfg[var_22_0]
		local var_22_6 = var_22_5 and var_22_5.gift_list or {}

		for iter_22_1, iter_22_2 in ipairs(var_22_6) do
			local var_22_7 = ItemTools.getItemNum(iter_22_2)

			if var_22_7 > 0 and not table.indexof(arg_22_0.curHeroLikeID_, iter_22_2) then
				arg_22_0.giftList_[var_22_2] = {
					id = iter_22_2,
					num = var_22_7
				}
				var_22_2 = var_22_2 + 1
			end
		end
	else
		local var_22_8 = ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]

		for iter_22_3, iter_22_4 in ipairs(var_22_8) do
			if ItemCfg[iter_22_4] and ItemCfg[iter_22_4].sub_type == 1 then
				local var_22_9 = ItemTools.getItemNum(iter_22_4)

				if var_22_9 > 0 and not table.indexof(arg_22_0.curHeroLikeID_, iter_22_4) then
					arg_22_0.giftList_[var_22_2] = {
						id = iter_22_4,
						num = var_22_9
					}
					var_22_2 = var_22_2 + 1
				end
			end
		end
	end
end

function var_0_0.UpdatePageState(arg_23_0)
	local var_23_0, var_23_1, var_23_2 = ArchiveData:GetTrustLevel(arg_23_0.curHeroID_)

	if var_23_0 > 0 then
		arg_23_0.likeStateController_:SetSelectedState("trust")

		local var_23_3 = HeroTrustMoodCfg[var_23_2]

		if var_23_3 then
			arg_23_0.moodTitleText_.text = var_23_3.name
			arg_23_0.moodBuffText_.text = var_23_3.desc

			arg_23_0.moodStateController_:SetSelectedState(var_23_2)
		end
	else
		arg_23_0.likeStateController_:SetSelectedState("like")
	end

	if var_23_0 > 0 then
		if var_23_0 >= HeroConst.HERO_TRUST_LV_MAX then
			arg_23_0.likePanelStateController_:SetSelectedState("max")

			arg_23_0.impressionText_.text = HeroCfg[arg_23_0.curHeroID_].impression
		elseif var_23_1 >= HeroTrustLevelCfg[var_23_0].exp then
			arg_23_0.likePanelStateController_:SetSelectedState("levelup")
			arg_23_0.likeStateController_:SetSelectedState("like")

			arg_23_0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_23_0)
			arg_23_0.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_23_0 + 1)

			local var_23_4 = HeroTrustCfg.get_id_list_by_hero_id[arg_23_0.curHeroID_][var_23_0]
			local var_23_5 = HeroTrustCfg[var_23_4]

			arg_23_0.taskList_ = var_23_5.condition_list

			arg_23_0.trustLvUpTaskLuaUIList_:StartScroll(#arg_23_0.taskList_)

			local var_23_6 = var_23_5.reward_item_list[1]

			if var_23_6 then
				local var_23_7 = var_23_6[1]
				local var_23_8 = var_23_6[2]

				arg_23_0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_23_0 + 1))
				arg_23_0.trustLvRewardText_.text = ItemTools.getItemName(var_23_7) .. " X" .. var_23_8
				arg_23_0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(var_23_7)
			end
		elseif #arg_23_0.giftList_ > 0 then
			arg_23_0.likePanelStateController_:SetSelectedState("gift")

			arg_23_0.curGiftIndex_ = 1

			arg_23_0.giftLuaUIList_:StartScroll(#arg_23_0.giftList_)
			arg_23_0:RefreshGiftInfo()
		else
			arg_23_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif HeroRelationNetCfg.get_id_list_by_hero_id[arg_23_0.curHeroID_] then
		if ArchiveData:GetArchive(arg_23_0.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(arg_23_0.curHeroID_) then
				arg_23_0.likePanelStateController_:SetSelectedState("canbreak")
			else
				arg_23_0.likePanelStateController_:SetSelectedState("notbreak")

				local var_23_9 = HeroCfg[arg_23_0.curHeroID_]

				arg_23_0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", var_23_9.name, var_23_9.suffix))
			end
		elseif #arg_23_0.giftList_ > 0 then
			arg_23_0.likePanelStateController_:SetSelectedState("gift")

			arg_23_0.curGiftIndex_ = 1

			arg_23_0.giftLuaUIList_:StartScroll(#arg_23_0.giftList_)
			arg_23_0:RefreshGiftInfo()
		else
			arg_23_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(arg_23_0.curRecordID_).exp >= var_0_2() then
		arg_23_0.likePanelStateController_:SetSelectedState("max")
	elseif #arg_23_0.giftList_ > 0 then
		arg_23_0.likePanelStateController_:SetSelectedState("gift")

		arg_23_0.curGiftIndex_ = 1

		arg_23_0.giftLuaUIList_:StartScroll(#arg_23_0.giftList_)
		arg_23_0:RefreshGiftInfo()
	else
		arg_23_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.RefreshGiftInfo(arg_24_0)
	local var_24_0, var_24_1 = ArchiveData:GetTrustLevel(arg_24_0.curHeroID_)
	local var_24_2 = arg_24_0.giftList_[arg_24_0.curGiftIndex_].id
	local var_24_3 = var_24_0 > 0 and var_0_4(arg_24_0.curHeroID_, var_24_2) or var_0_3(arg_24_0.curRecordID_, var_24_2)

	arg_24_0.giftNameText_.text = ItemTools.getItemName(var_24_2)
	arg_24_0.giftDescText_.text = ItemTools.getItemDesc(var_24_2)
	arg_24_0.giftPointText_.text = (var_24_0 > 0 and "交心值" or "好感度") .. "+" .. var_24_3

	arg_24_0.detailTrs_:SetAnchoredPositionY(0)

	arg_24_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	arg_24_0.contentSizeTimer_ = Timer.New(function()
		arg_24_0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if arg_24_0.contentSizeTimer_ then
			arg_24_0.contentSizeTimer_:Stop()

			arg_24_0.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	arg_24_0.contentSizeTimer_:Start()

	arg_24_0.giftNumSlr_.minValue = 0

	if var_24_0 > 0 then
		local var_24_4 = HeroTrustLevelCfg[var_24_0].exp
		local var_24_5 = math.min(arg_24_0.giftList_[arg_24_0.curGiftIndex_].num, math.ceil(var_24_4 - var_24_1) / var_24_3)

		arg_24_0.giftNumSlr_.maxValue = var_24_5
	else
		local var_24_6 = ArchiveData:GetArchive(arg_24_0.curRecordID_).exp
		local var_24_7 = math.min(arg_24_0.giftList_[arg_24_0.curGiftIndex_].num, math.ceil(var_0_2() - var_24_6) / var_24_3)

		arg_24_0.giftNumSlr_.maxValue = var_24_7
	end

	if arg_24_0.giftNumSlr_.value == 1 then
		arg_24_0.giftNumText_.text = "选择数量:" .. 1

		arg_24_0:RefreshExpProcess(var_24_3)

		arg_24_0.giftReduceBtn_.interactable = false
		arg_24_0.giftAddBtn_.interactable = arg_24_0.giftNumSlr_.maxValue > 1
	else
		arg_24_0.giftNumSlr_.value = 1
	end
end

function var_0_0.RefreshExpProcess(arg_26_0, arg_26_1)
	local var_26_0, var_26_1 = ArchiveData:GetTrustLevel(arg_26_0.curHeroID_)

	if var_26_0 > 0 then
		local var_26_2 = HeroTrustLevelCfg[var_26_0].exp

		if arg_26_1 and arg_26_1 > 0 then
			if var_26_2 < var_26_1 + arg_26_1 then
				arg_26_1 = var_26_2 - var_26_1
			end

			arg_26_0.currlevelText_.text = var_26_1 + arg_26_1 .. "/" .. var_26_2
			arg_26_0.addlevelText_.text = "+" .. arg_26_1
			arg_26_0.processbarImg_.fillAmount = var_26_1 / var_26_2
			arg_26_0.processaddImg_.fillAmount = (var_26_1 + arg_26_1) / var_26_2
		elseif var_26_0 == HeroConst.HERO_TRUST_LV_MAX then
			arg_26_0.currlevelText_.text = HeroTrustLevelCfg[var_26_0 - 1].exp .. "/" .. HeroTrustLevelCfg[var_26_0 - 1].exp
			arg_26_0.addlevelText_.text = "[MAX]"
			arg_26_0.processbarImg_.fillAmount = 1
			arg_26_0.processaddImg_.fillAmount = 0
		else
			arg_26_0.currlevelText_.text = var_26_1 .. "/" .. var_26_2
			arg_26_0.addlevelText_.text = ""
			arg_26_0.processbarImg_.fillAmount = var_26_1 / var_26_2
			arg_26_0.processaddImg_.fillAmount = 0
		end
	else
		local var_26_3 = ArchiveData:GetArchive(arg_26_0.curRecordID_).exp
		local var_26_4, var_26_5 = LvTools.LoveExpToLevel(var_26_3)
		local var_26_6 = GameLevelSetting[var_26_4].hero_love_exp

		if arg_26_1 and arg_26_1 > 0 then
			if var_26_3 + arg_26_1 >= var_0_2() then
				arg_26_1 = var_0_2() - var_26_3
			end

			local var_26_7, var_26_8 = LvTools.LoveExpToLevel(var_26_3 + arg_26_1)
			local var_26_9 = GameLevelSetting[var_26_7].hero_love_exp

			if var_26_7 == HeroConst.HERO_LOVE_LV_MAX then
				arg_26_0.currlevelText_.text = GameLevelSetting[var_26_7 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_26_7 - 1].hero_love_exp
				arg_26_0.addlevelText_.text = "+" .. arg_26_1

				if var_26_4 < var_26_7 - 1 then
					arg_26_0.processbarImg_.fillAmount = 0
					arg_26_0.processaddImg_.fillAmount = 1
				else
					arg_26_0.processbarImg_.fillAmount = var_26_5 / var_26_6
					arg_26_0.processaddImg_.fillAmount = 1
				end
			else
				arg_26_0.currlevelText_.text = var_26_8 .. "/" .. var_26_9
				arg_26_0.addlevelText_.text = "+" .. arg_26_1

				if var_26_4 < var_26_7 then
					arg_26_0.processbarImg_.fillAmount = 0
					arg_26_0.processaddImg_.fillAmount = var_26_8 / var_26_9
				else
					arg_26_0.processbarImg_.fillAmount = var_26_5 / var_26_6
					arg_26_0.processaddImg_.fillAmount = var_26_8 / var_26_9
				end
			end

			arg_26_0.previewLvCB_(var_26_7)
		elseif var_26_4 == HeroConst.HERO_LOVE_LV_MAX then
			arg_26_0.currlevelText_.text = GameLevelSetting[var_26_4 - 1].hero_love_exp .. "/" .. GameLevelSetting[var_26_4 - 1].hero_love_exp
			arg_26_0.addlevelText_.text = "[MAX]"
			arg_26_0.processbarImg_.fillAmount = 1
			arg_26_0.processaddImg_.fillAmount = 0
		else
			arg_26_0.currlevelText_.text = var_26_5 .. "/" .. var_26_6
			arg_26_0.addlevelText_.text = ""
			arg_26_0.processbarImg_.fillAmount = var_26_5 / var_26_6
			arg_26_0.processaddImg_.fillAmount = 0
		end
	end
end

function var_0_0.PlayVoice(arg_27_0)
	if arg_27_0.voiceCoolDown_ then
		return
	end

	arg_27_0.voiceCoolDown_ = true

	local var_27_0 = HeroVoiceCfg.get_id_list_by_file.emotion[1]

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = arg_27_0.curHeroID_,
		sound_id = var_27_0
	})
	arg_27_0:StopVoice()

	arg_27_0.delayPlayTimer_ = Timer.New(function()
		if manager.audio:IsStoppedOfVoice() then
			arg_27_0.delayPlayTimer_:Stop()

			arg_27_0.delayPlayTimer_ = nil

			local var_28_0 = arg_27_0.curHeroID_

			if HeroVoiceCfg[var_27_0].use_skin_id and HeroVoiceCfg[var_27_0].use_skin_id ~= 0 then
				var_28_0 = HeroVoiceCfg[var_27_0].use_skin_id
			end

			HeroTools.PlayVoice(var_28_0, HeroVoiceCfg[var_27_0].file, HeroVoiceCfg[var_27_0].type)

			local var_28_1 = HeroTools.GetTalkLength(var_28_0, HeroVoiceCfg[var_27_0].file, HeroVoiceCfg[var_27_0].type)
			local var_28_2 = math.max(var_28_1, 0.017)

			arg_27_0.timer_ = TimeTools.StartAfterSeconds(var_28_2 / 1000, function()
				arg_27_0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	arg_27_0.delayPlayTimer_:Start()
end

function var_0_0.StopVoice(arg_30_0)
	if arg_30_0.delayPlayTimer_ then
		arg_30_0.delayPlayTimer_:Stop()

		arg_30_0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if arg_30_0.timer_ then
		arg_30_0.timer_:Stop()

		arg_30_0.timer_ = nil
		arg_30_0.voiceCoolDown_ = false
	end
end

function var_0_0.OnHeroTrustUpdate(arg_31_0)
	arg_31_0:UpdateGiftData()
	arg_31_0:RefreshExpProcess()

	local var_31_0, var_31_1, var_31_2 = ArchiveData:GetTrustLevel(arg_31_0.curHeroID_)

	Debug.Log("角色的交心等级是和经验是" .. var_31_0 .. " " .. var_31_1)
	arg_31_0:PlayVoice()

	if var_31_0 >= HeroConst.HERO_TRUST_LV_MAX then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if var_31_0 > 0 then
		arg_31_0.likeStateController_:SetSelectedState("trust")

		local var_31_3 = HeroTrustMoodCfg[var_31_2]

		if var_31_3 then
			arg_31_0.moodTitleText_.text = var_31_3.name
			arg_31_0.moodBuffText_.text = var_31_3.desc

			arg_31_0.moodStateController_:SetSelectedState(var_31_2)
		end
	else
		arg_31_0.likeStateController_:SetSelectedState("like")
	end

	if var_31_0 >= HeroConst.HERO_TRUST_LV_MAX then
		arg_31_0.likePanelStateController_:SetSelectedState("max")

		arg_31_0.impressionText_.text = HeroCfg[arg_31_0.curHeroID_].impression
	elseif var_31_1 >= HeroTrustLevelCfg[var_31_0].exp then
		arg_31_0.likePanelStateController_:SetSelectedState("levelup")
		arg_31_0.likeStateController_:SetSelectedState("like")

		arg_31_0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(var_31_0)
		arg_31_0.trustNextText_.text = ArchiveTools.GetTrustLvDes(var_31_0 + 1)

		local var_31_4 = HeroTrustCfg.get_id_list_by_hero_id[arg_31_0.curHeroID_][var_31_0]
		local var_31_5 = HeroTrustCfg[var_31_4]

		arg_31_0.taskList_ = var_31_5.condition_list

		arg_31_0.trustLvUpTaskLuaUIList_:StartScroll(#arg_31_0.taskList_)

		local var_31_6 = var_31_5.reward_item_list[1]

		if var_31_6 then
			local var_31_7 = var_31_6[1]
			local var_31_8 = var_31_6[2]

			arg_31_0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(var_31_0 + 1))
			arg_31_0.trustLvRewardText_.text = ItemTools.getItemName(var_31_7) .. " X" .. var_31_8
			arg_31_0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(var_31_7)
		end
	elseif #arg_31_0.giftList_ > 0 then
		arg_31_0.likePanelStateController_:SetSelectedState("gift")

		if arg_31_0.curGiftIndex_ > #arg_31_0.giftList_ then
			arg_31_0.curGiftIndex_ = #arg_31_0.giftList_
		elseif arg_31_0.curGiftIndex_ < 1 then
			arg_31_0.curGiftIndex_ = 1
		end

		arg_31_0.giftLuaUIList_:StartScroll(#arg_31_0.giftList_)
		arg_31_0:RefreshGiftInfo()
	else
		arg_31_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.OnSendGift(arg_32_0)
	arg_32_0:UpdateGiftData()
	arg_32_0:RefreshExpProcess()
	arg_32_0:PlayVoice()

	if ArchiveData:GetArchive(arg_32_0.curRecordID_).exp >= var_0_2() then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if HeroRelationNetCfg.get_id_list_by_hero_id[arg_32_0.curHeroID_] then
		if ArchiveData:GetArchive(arg_32_0.curRecordID_).exp >= var_0_2() then
			if HeroTools.GetHeroIsUnlock(arg_32_0.curHeroID_) then
				arg_32_0.likePanelStateController_:SetSelectedState("canbreak")
			else
				arg_32_0.likePanelStateController_:SetSelectedState("notbreak")

				local var_32_0 = HeroCfg[arg_32_0.curHeroID_]

				arg_32_0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", var_32_0.name, var_32_0.suffix))
			end
		elseif #arg_32_0.giftList_ > 0 then
			arg_32_0.likePanelStateController_:SetSelectedState("gift")

			if arg_32_0.curGiftIndex_ > #arg_32_0.giftList_ then
				arg_32_0.curGiftIndex_ = #arg_32_0.giftList_
			elseif arg_32_0.curGiftIndex_ < 1 then
				arg_32_0.curGiftIndex_ = 1
			end

			arg_32_0.giftLuaUIList_:StartScroll(#arg_32_0.giftList_)
			arg_32_0:RefreshGiftInfo()
		else
			arg_32_0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif ArchiveData:GetArchive(arg_32_0.curRecordID_).exp >= var_0_2() then
		arg_32_0.likePanelStateController_:SetSelectedState("max")
	elseif #arg_32_0.giftList_ > 0 then
		arg_32_0.likePanelStateController_:SetSelectedState("gift")

		if arg_32_0.curGiftIndex_ > #arg_32_0.giftList_ then
			arg_32_0.curGiftIndex_ = #arg_32_0.giftList_
		elseif arg_32_0.curGiftIndex_ < 1 then
			arg_32_0.curGiftIndex_ = 1
		end

		arg_32_0.giftLuaUIList_:StartScroll(#arg_32_0.giftList_)
		arg_32_0:RefreshGiftInfo()
	else
		arg_32_0.likePanelStateController_:SetSelectedState("empty")
	end
end

function var_0_0.Dispose(arg_33_0)
	arg_33_0.giftLuaUIList_:Dispose()
	arg_33_0.trustLvUpTaskLuaUIList_:Dispose()
	var_0_0.super.Dispose(arg_33_0)
end

return var_0_0
