slot0 = class("HeroFileGiftPage", ReduxView)
slot1 = nil

function slot2()
	if not uv0 then
		uv0 = 0

		for slot3 = 1, HeroConst.HERO_LOVE_LV_MAX do
			uv0 = uv0 + GameLevelSetting[slot3].hero_love_exp
		end
	end

	return uv0
end

function slot3(slot0, slot1)
	slot3 = GameSetting.gift_value.value

	if slot1 == HeroRecordCfg[slot0].gift_like_id1[1] then
		return slot3[1]
	end

	return slot3[2]
end

function slot4(slot0, slot1)
	slot2, slot3, slot4 = ArchiveData:GetTrustLevel(slot0)
	slot5 = 1

	if HeroTrustMoodCfg[slot4] then
		slot5 = HeroTrustMoodCfg[slot4].trust_exp_rate / 1000
	end

	if ItemCfg[slot1].sub_type == 1 then
		return math.floor(GameSetting.hero_trust_favor_gift_add_exp.value[1] * slot5)
	elseif slot6.sub_type == 2 then
		return math.floor(slot6.param[1] * slot5)
	else
		return 0
	end
end

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.previewLvCB_ = slot2

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.curHeroID_ = 0
	slot0.curRecordID_ = 0
	slot0.curHeroLikeID_ = {}
	slot0.giftList_ = {}
	slot0.curGiftIndex_ = 0
	slot0.taskList_ = {}
	slot0.voiceCoolDown_ = false
	slot0.likePanelStateController_ = slot0.giftControllerEx_:GetController("likePanelState")
	slot0.likeStateController_ = slot0.giftControllerEx_:GetController("likeState")
	slot0.moodStateController_ = slot0.giftControllerEx_:GetController("moodIconState")
	slot0.giftLuaUIList_ = LuaList.New(handler(slot0, slot0.IndexGiftItem), slot0.giftUilist_, CommonItemView)
	slot0.trustLvUpTaskLuaUIList_ = LuaList.New(handler(slot0, slot0.IndexTaskItem), slot0.trustLvTaskUilist_, HeroFileGiftTrustLvUpTaskItem)
	slot0.contentSizeFitter_ = slot0.detailTrs_:GetComponent("ContentSizeFitter")
end

function slot0.AddUIListener(slot0)
	slot0.giftNumSlr_.onValueChanged:AddListener(function (slot0)
		if slot0 < 1 then
			uv0.giftNumSlr_.value = 1
			slot0 = 1
		end

		uv0.giftNumText_.text = "选择数量:" .. slot0
		slot2 = uv0.giftList_[uv0.curGiftIndex_].id

		uv0:RefreshExpProcess((ArchiveData:GetTrustLevel(uv0.curHeroID_) > 0 and uv1(uv0.curHeroID_, slot2) or uv2(uv0.curRecordID_, slot2)) * slot0)

		uv0.giftReduceBtn_.interactable = slot0 > 1
		uv0.giftAddBtn_.interactable = slot0 < uv0.giftNumSlr_.maxValue
	end)
	slot0:AddBtnListener(slot0.giftReduceBtn_, nil, function ()
		slot0 = ItemTools.getItemNum(uv0.giftList_[uv0.curGiftIndex_].id)

		if uv0.giftNumSlr_.value > 1 then
			uv0.giftNumSlr_.value = uv0.giftNumSlr_.value - 1
		end
	end)
	slot0:AddBtnListener(slot0.giftAddBtn_, nil, function ()
		slot0 = ItemTools.getItemNum(uv0.giftList_[uv0.curGiftIndex_].id)

		if uv0.giftNumSlr_.value < uv0.giftNumSlr_.maxValue then
			uv0.giftNumSlr_.value = uv0.giftNumSlr_.value + 1
		end
	end)
	slot0:AddBtnListener(slot0.presentBtn_, nil, function ()
		if ArchiveData:GetTrustLevel(uv0.curHeroID_) > 0 then
			slot1 = uv0.giftList_[uv0.curGiftIndex_].id

			if uv0.giftNumSlr_.value == 0 then
				slot2 = 1
			end

			Debug.Log("角色的交心等级是" .. slot0)
			Debug.Log("要送的礼物id和数量是" .. slot1 .. " " .. slot2)
			ArchiveAction.QuerySendTrustItem(uv0.curHeroID_, {
				{
					id = slot1,
					num = slot2
				}
			})
		else
			slot1 = uv0.giftList_[uv0.curGiftIndex_].id

			if uv0.giftNumSlr_.value == 0 then
				slot2 = 1
			end

			if uv2() < ArchiveData:GetArchive(uv0.curRecordID_).exp + slot2 * uv1(uv0.curRecordID_, slot1) then
				slot3 = uv2() - slot4
			end

			HeroAction.SendGift(uv0.curRecordID_, {
				{
					id = slot1,
					num = slot2
				}
			}, slot3)
		end
	end)
	slot0:AddBtnListener(slot0.breakBtn_, nil, function ()
		ArchiveAction.QueryUnlockTrust(uv0.curHeroID_)
	end)
	slot0:AddBtnListener(slot0.trustLvBtn_, nil, function ()
		for slot3, slot4 in ipairs(uv0.taskList_) do
			if not IsConditionAchieved(slot4, {
				heroId = uv0.curHeroID_
			}) then
				ShowTips("HERO_TRUST_UP_LV_LOCK")

				return
			end
		end

		ArchiveAction.QueryUpgradeTrustLevel(uv0.curHeroID_)
	end)
	slot0:AddBtnListener(slot0.changeGiftBtn_, nil, function ()
		gameContext:Go("/heroTrustGiftDisplace")
	end)
	slot0:AddBtnListener(slot0.moodTipsBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("HERO_TRUST_MOOD_DESC")
		})
	end)
	slot0:AddBtnListener(slot0.m_listenBtn, nil, function ()
		JumpTools.GoToSystem("/newHeroDetailArchive", {
			id = uv0.curRecordID_
		})
	end)
end

function slot0.IndexGiftItem(slot0, slot1, slot2)
	slot3 = clone(ItemTemplateData)
	slot3.id = slot0.giftList_[slot1].id
	slot3.number = slot0.giftList_[slot1].num
	slot3.selectStyle = slot1 == slot0.curGiftIndex_
	slot3.favouriteFlag = table.indexof(slot0.curHeroLikeID_, slot3.id) ~= false

	function slot3.clickFun()
		if uv0 == uv1.curGiftIndex_ then
			return
		end

		if uv1.curGiftIndex_ ~= 0 and uv1.giftLuaUIList_:GetItemList()[uv1.curGiftIndex_] then
			slot0:RefreshSelectState(false)
		end

		uv2:RefreshSelectState(true)

		uv1.curGiftIndex_ = uv0

		uv1:RefreshGiftInfo()
	end

	slot2:SetData(slot3)
end

function slot0.IndexTaskItem(slot0, slot1, slot2)
	slot2:SetData(slot0.taskList_[slot1], slot0.curHeroID_)
end

function slot0.Show(slot0, slot1, slot2)
	slot0.curHeroID_ = slot2
	slot0.curRecordID_ = slot1
	slot0.curHeroLikeID_ = HeroRecordCfg[slot1].gift_like_id1

	slot0:UpdateGiftData()
	slot0:RefreshExpProcess()
	slot0:UpdatePageState()
	SetActive(slot0.gameObject_, true)
end

function slot0.Hide(slot0)
	slot0:StopVoice()

	if slot0.contentSizeTimer_ then
		slot0.contentSizeTimer_:Stop()

		slot0.contentSizeTimer_ = nil
	end

	SetActive(slot0.gameObject_, false)
end

function slot0.UpdateGiftData(slot0)
	slot0.giftList_ = {}
	slot1, slot2 = ArchiveData:GetTrustLevel(slot0.curHeroID_)
	slot3 = 1

	for slot7 = 1, #slot0.curHeroLikeID_ do
		if ItemTools.getItemNum(slot0.curHeroLikeID_[slot7]) > 0 then
			slot0.giftList_[slot3] = {
				id = slot8,
				num = slot9
			}
			slot3 = slot3 + 1
		end
	end

	if slot1 > 0 then
		for slot9, slot10 in ipairs(HeroTrustLevelCfg[slot1] and slot4.gift_list or {}) do
			if ItemTools.getItemNum(slot10) > 0 and not table.indexof(slot0.curHeroLikeID_, slot10) then
				slot0.giftList_[slot3] = {
					id = slot10,
					num = slot11
				}
				slot3 = slot3 + 1
			end
		end
	else
		for slot8, slot9 in ipairs(ItemCfg.get_id_list_by_type[ItemConst.ITEM_TYPE.ARCHIVE_GIFT]) do
			if ItemCfg[slot9] and ItemCfg[slot9].sub_type == 1 and ItemTools.getItemNum(slot9) > 0 and not table.indexof(slot0.curHeroLikeID_, slot9) then
				slot0.giftList_[slot3] = {
					id = slot9,
					num = slot10
				}
				slot3 = slot3 + 1
			end
		end
	end
end

function slot0.UpdatePageState(slot0)
	slot1, slot2, slot3 = ArchiveData:GetTrustLevel(slot0.curHeroID_)

	if slot1 > 0 then
		slot0.likeStateController_:SetSelectedState("trust")

		if HeroTrustMoodCfg[slot3] then
			slot0.moodTitleText_.text = slot4.name
			slot0.moodBuffText_.text = slot4.desc

			slot0.moodStateController_:SetSelectedState(slot3)
		end
	else
		slot0.likeStateController_:SetSelectedState("like")
	end

	if slot1 > 0 then
		if HeroConst.HERO_TRUST_LV_MAX <= slot1 then
			slot0.likePanelStateController_:SetSelectedState("max")

			slot0.impressionText_.text = HeroCfg[slot0.curHeroID_].impression
		elseif HeroTrustLevelCfg[slot1].exp <= slot2 then
			slot0.likePanelStateController_:SetSelectedState("levelup")
			slot0.likeStateController_:SetSelectedState("like")

			slot0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(slot1)
			slot0.trustNextText_.text = ArchiveTools.GetTrustLvDes(slot1 + 1)
			slot6 = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[slot0.curHeroID_][slot1]]
			slot0.taskList_ = slot6.condition_list

			slot0.trustLvUpTaskLuaUIList_:StartScroll(#slot0.taskList_)

			if slot6.reward_item_list[1] then
				slot8 = slot7[1]
				slot0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(slot1 + 1))
				slot0.trustLvRewardText_.text = ItemTools.getItemName(slot8) .. " X" .. slot7[2]
				slot0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(slot8)
			end
		elseif #slot0.giftList_ > 0 then
			slot0.likePanelStateController_:SetSelectedState("gift")

			slot0.curGiftIndex_ = 1

			slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
			slot0:RefreshGiftInfo()
		else
			slot0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif HeroRelationNetCfg.get_id_list_by_hero_id[slot0.curHeroID_] then
		if uv0() <= ArchiveData:GetArchive(slot0.curRecordID_).exp then
			if HeroTools.GetHeroIsUnlock(slot0.curHeroID_) then
				slot0.likePanelStateController_:SetSelectedState("canbreak")
			else
				slot0.likePanelStateController_:SetSelectedState("notbreak")

				slot4 = HeroCfg[slot0.curHeroID_]
				slot0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", slot4.name, slot4.suffix))
			end
		elseif #slot0.giftList_ > 0 then
			slot0.likePanelStateController_:SetSelectedState("gift")

			slot0.curGiftIndex_ = 1

			slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
			slot0:RefreshGiftInfo()
		else
			slot0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif uv0() <= ArchiveData:GetArchive(slot0.curRecordID_).exp then
		slot0.likePanelStateController_:SetSelectedState("max")
	elseif #slot0.giftList_ > 0 then
		slot0.likePanelStateController_:SetSelectedState("gift")

		slot0.curGiftIndex_ = 1

		slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
		slot0:RefreshGiftInfo()
	else
		slot0.likePanelStateController_:SetSelectedState("empty")
	end
end

function slot0.RefreshGiftInfo(slot0)
	slot1, slot2 = ArchiveData:GetTrustLevel(slot0.curHeroID_)
	slot3 = slot0.giftList_[slot0.curGiftIndex_].id
	slot0.giftNameText_.text = ItemTools.getItemName(slot3)
	slot0.giftDescText_.text = ItemTools.getItemDesc(slot3)
	slot0.giftPointText_.text = (slot1 > 0 and "交心值" or "好感度") .. "+" .. (slot1 > 0 and uv0(slot0.curHeroID_, slot3) or uv1(slot0.curRecordID_, slot3))

	slot0.detailTrs_:SetAnchoredPositionY(0)

	slot0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.Unconstrained
	slot0.contentSizeTimer_ = Timer.New(function ()
		uv0.contentSizeFitter_.verticalFit = ContentSizeFitter.FitMode.PreferredSize

		if uv0.contentSizeTimer_ then
			uv0.contentSizeTimer_:Stop()

			uv0.contentSizeTimer_ = nil
		end
	end, 0.2, 1)

	slot0.contentSizeTimer_:Start()

	slot0.giftNumSlr_.minValue = 0

	if slot1 > 0 then
		slot0.giftNumSlr_.maxValue = math.min(slot0.giftList_[slot0.curGiftIndex_].num, math.ceil(HeroTrustLevelCfg[slot1].exp - slot2) / slot4)
	else
		slot0.giftNumSlr_.maxValue = math.min(slot0.giftList_[slot0.curGiftIndex_].num, math.ceil(uv2() - ArchiveData:GetArchive(slot0.curRecordID_).exp) / slot4)
	end

	if slot0.giftNumSlr_.value == 1 then
		slot0.giftNumText_.text = "选择数量:" .. 1

		slot0:RefreshExpProcess(slot4)

		slot0.giftReduceBtn_.interactable = false
		slot0.giftAddBtn_.interactable = slot0.giftNumSlr_.maxValue > 1
	else
		slot0.giftNumSlr_.value = 1
	end
end

function slot0.RefreshExpProcess(slot0, slot1)
	slot2, slot3 = ArchiveData:GetTrustLevel(slot0.curHeroID_)

	if slot2 > 0 then
		slot4 = HeroTrustLevelCfg[slot2].exp

		if slot1 and slot1 > 0 then
			if slot4 < slot3 + slot1 then
				slot1 = slot4 - slot3
			end

			slot0.currlevelText_.text = slot3 + slot1 .. "/" .. slot4
			slot0.addlevelText_.text = "+" .. slot1
			slot0.processbarImg_.fillAmount = slot3 / slot4
			slot0.processaddImg_.fillAmount = (slot3 + slot1) / slot4
		elseif slot2 == HeroConst.HERO_TRUST_LV_MAX then
			slot0.currlevelText_.text = HeroTrustLevelCfg[slot2 - 1].exp .. "/" .. HeroTrustLevelCfg[slot2 - 1].exp
			slot0.addlevelText_.text = "[MAX]"
			slot0.processbarImg_.fillAmount = 1
			slot0.processaddImg_.fillAmount = 0
		else
			slot0.currlevelText_.text = slot3 .. "/" .. slot4
			slot0.addlevelText_.text = ""
			slot0.processbarImg_.fillAmount = slot3 / slot4
			slot0.processaddImg_.fillAmount = 0
		end
	else
		slot5, slot6 = LvTools.LoveExpToLevel(ArchiveData:GetArchive(slot0.curRecordID_).exp)
		slot7 = GameLevelSetting[slot5].hero_love_exp

		if slot1 and slot1 > 0 then
			if uv0() <= slot4 + slot1 then
				slot1 = uv0() - slot4
			end

			slot8, slot9 = LvTools.LoveExpToLevel(slot4 + slot1)
			slot10 = GameLevelSetting[slot8].hero_love_exp

			if slot8 == HeroConst.HERO_LOVE_LV_MAX then
				slot0.currlevelText_.text = GameLevelSetting[slot8 - 1].hero_love_exp .. "/" .. GameLevelSetting[slot8 - 1].hero_love_exp
				slot0.addlevelText_.text = "+" .. slot1

				if slot5 < slot8 - 1 then
					slot0.processbarImg_.fillAmount = 0
					slot0.processaddImg_.fillAmount = 1
				else
					slot0.processbarImg_.fillAmount = slot6 / slot7
					slot0.processaddImg_.fillAmount = 1
				end
			else
				slot0.currlevelText_.text = slot9 .. "/" .. slot10
				slot0.addlevelText_.text = "+" .. slot1

				if slot5 < slot8 then
					slot0.processbarImg_.fillAmount = 0
					slot0.processaddImg_.fillAmount = slot9 / slot10
				else
					slot0.processbarImg_.fillAmount = slot6 / slot7
					slot0.processaddImg_.fillAmount = slot9 / slot10
				end
			end

			slot0.previewLvCB_(slot8)
		elseif slot5 == HeroConst.HERO_LOVE_LV_MAX then
			slot0.currlevelText_.text = GameLevelSetting[slot5 - 1].hero_love_exp .. "/" .. GameLevelSetting[slot5 - 1].hero_love_exp
			slot0.addlevelText_.text = "[MAX]"
			slot0.processbarImg_.fillAmount = 1
			slot0.processaddImg_.fillAmount = 0
		else
			slot0.currlevelText_.text = slot6 .. "/" .. slot7
			slot0.addlevelText_.text = ""
			slot0.processbarImg_.fillAmount = slot6 / slot7
			slot0.processaddImg_.fillAmount = 0
		end
	end
end

function slot0.PlayVoice(slot0)
	if slot0.voiceCoolDown_ then
		return
	end

	slot0.voiceCoolDown_ = true

	SDKTools.SendMessageToSDK("hero_sound", {
		hero_id = slot0.curHeroID_,
		sound_id = HeroVoiceCfg.get_id_list_by_file.emotion[1]
	})
	slot0:StopVoice()

	slot0.delayPlayTimer_ = Timer.New(function ()
		if manager.audio:IsStoppedOfVoice() then
			uv0.delayPlayTimer_:Stop()

			uv0.delayPlayTimer_ = nil
			slot0 = uv0.curHeroID_

			if HeroVoiceCfg[uv1].use_skin_id and HeroVoiceCfg[uv1].use_skin_id ~= 0 then
				slot0 = HeroVoiceCfg[uv1].use_skin_id
			end

			HeroTools.PlayVoice(slot0, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type)

			uv0.timer_ = TimeTools.StartAfterSeconds(math.max(HeroTools.GetTalkLength(slot0, HeroVoiceCfg[uv1].file, HeroVoiceCfg[uv1].type), 0.017) / 1000, function ()
				uv0:StopVoice()
			end, {})
		end
	end, 0.033, -1)

	slot0.delayPlayTimer_:Start()
end

function slot0.StopVoice(slot0)
	if slot0.delayPlayTimer_ then
		slot0.delayPlayTimer_:Stop()

		slot0.delayPlayTimer_ = nil
	end

	manager.audio:StopVoiceImmediate()

	if slot0.timer_ then
		slot0.timer_:Stop()

		slot0.timer_ = nil
		slot0.voiceCoolDown_ = false
	end
end

function slot0.OnHeroTrustUpdate(slot0)
	slot0:UpdateGiftData()
	slot0:RefreshExpProcess()

	slot1, slot2, slot3 = ArchiveData:GetTrustLevel(slot0.curHeroID_)

	Debug.Log("角色的交心等级是和经验是" .. slot1 .. " " .. slot2)
	slot0:PlayVoice()

	if HeroConst.HERO_TRUST_LV_MAX <= slot1 then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if slot1 > 0 then
		slot0.likeStateController_:SetSelectedState("trust")

		if HeroTrustMoodCfg[slot3] then
			slot0.moodTitleText_.text = slot4.name
			slot0.moodBuffText_.text = slot4.desc

			slot0.moodStateController_:SetSelectedState(slot3)
		end
	else
		slot0.likeStateController_:SetSelectedState("like")
	end

	if HeroConst.HERO_TRUST_LV_MAX <= slot1 then
		slot0.likePanelStateController_:SetSelectedState("max")

		slot0.impressionText_.text = HeroCfg[slot0.curHeroID_].impression
	elseif HeroTrustLevelCfg[slot1].exp <= slot2 then
		slot0.likePanelStateController_:SetSelectedState("levelup")
		slot0.likeStateController_:SetSelectedState("like")

		slot0.trustPriorText_.text = ArchiveTools.GetTrustLvDes(slot1)
		slot0.trustNextText_.text = ArchiveTools.GetTrustLvDes(slot1 + 1)
		slot6 = HeroTrustCfg[HeroTrustCfg.get_id_list_by_hero_id[slot0.curHeroID_][slot1]]
		slot0.taskList_ = slot6.condition_list

		slot0.trustLvUpTaskLuaUIList_:StartScroll(#slot0.taskList_)

		if slot6.reward_item_list[1] then
			slot8 = slot7[1]
			slot0.trustLvTipsText_.text = GetTipsF("HERO_TRUST_UP_LV_REWARD", ArchiveTools.GetTrustLvDes(slot1 + 1))
			slot0.trustLvRewardText_.text = ItemTools.getItemName(slot8) .. " X" .. slot7[2]
			slot0.trustLvRewardImg_.sprite = ItemTools.getItemSprite(slot8)
		end
	elseif #slot0.giftList_ > 0 then
		slot0.likePanelStateController_:SetSelectedState("gift")

		if slot0.curGiftIndex_ > #slot0.giftList_ then
			slot0.curGiftIndex_ = #slot0.giftList_
		elseif slot0.curGiftIndex_ < 1 then
			slot0.curGiftIndex_ = 1
		end

		slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
		slot0:RefreshGiftInfo()
	else
		slot0.likePanelStateController_:SetSelectedState("empty")
	end
end

function slot0.OnSendGift(slot0)
	slot0:UpdateGiftData()
	slot0:RefreshExpProcess()
	slot0:PlayVoice()

	if uv0() <= ArchiveData:GetArchive(slot0.curRecordID_).exp then
		ShowTips("HERO_LOVE_LEVEL_MAX")
	else
		ShowTips("HERO_LOVE_EXP_UP")
	end

	if HeroRelationNetCfg.get_id_list_by_hero_id[slot0.curHeroID_] then
		if uv0() <= ArchiveData:GetArchive(slot0.curRecordID_).exp then
			if HeroTools.GetHeroIsUnlock(slot0.curHeroID_) then
				slot0.likePanelStateController_:SetSelectedState("canbreak")
			else
				slot0.likePanelStateController_:SetSelectedState("notbreak")

				slot1 = HeroCfg[slot0.curHeroID_]
				slot0.notbreakTipText_.text = GetTipsF("HERO_TRUST_BREAK_HERO_LOCK", string.format("%s·%s", slot1.name, slot1.suffix))
			end
		elseif #slot0.giftList_ > 0 then
			slot0.likePanelStateController_:SetSelectedState("gift")

			if slot0.curGiftIndex_ > #slot0.giftList_ then
				slot0.curGiftIndex_ = #slot0.giftList_
			elseif slot0.curGiftIndex_ < 1 then
				slot0.curGiftIndex_ = 1
			end

			slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
			slot0:RefreshGiftInfo()
		else
			slot0.likePanelStateController_:SetSelectedState("empty")
		end
	elseif uv0() <= ArchiveData:GetArchive(slot0.curRecordID_).exp then
		slot0.likePanelStateController_:SetSelectedState("max")
	elseif #slot0.giftList_ > 0 then
		slot0.likePanelStateController_:SetSelectedState("gift")

		if slot0.curGiftIndex_ > #slot0.giftList_ then
			slot0.curGiftIndex_ = #slot0.giftList_
		elseif slot0.curGiftIndex_ < 1 then
			slot0.curGiftIndex_ = 1
		end

		slot0.giftLuaUIList_:StartScroll(#slot0.giftList_)
		slot0:RefreshGiftInfo()
	else
		slot0.likePanelStateController_:SetSelectedState("empty")
	end
end

function slot0.Dispose(slot0)
	slot0.giftLuaUIList_:Dispose()
	slot0.trustLvUpTaskLuaUIList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
