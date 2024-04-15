slot1 = class("HeroTrialView_1_7", import("game.views.heroTrialActivity.HeroTrialActivityView"))

function slot1.UIName(slot0)
	return "UI/VersionUI/DarkFlameUI/DFHeroTrialUI/DFHeroTrialUI"
end

function slot1.AddListeners(slot0)
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
			isTemp = true,
			hid = HeroTrialTools.GetHeroStandardID(uv0.selectActivityHeroID_),
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
end

function slot1.RefreshTextName(slot0, slot1)
	slot2 = string.split(slot1, "·")
	slot0.textName_.text = string.format("<size=46>%s</size><size=32>·%s</size>", GetI18NText(slot2[1]), GetI18NText(slot2[2]))
end

function slot1.GetRewardItem(slot0, slot1)
	return HeroTrialRewardItem_1_7.New(slot0.goRewardPanel_, slot0.rewardItemGo_, slot1, true)
end

function slot1.RefreshReward(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityHeroTrialCfg[slot1].reward_list) do
		if slot0.rewardItemList_[slot6] then
			slot0.rewardItemList_[slot6]:SetData(slot7, false)
		else
			slot0.rewardItemList_[slot6] = slot0:GetRewardItem(slot7)
		end
	end

	for slot6 = #slot2 + 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot6]:Show(false)
	end

	if HeroTrialData:GetHeroTrialStateList()[slot1] then
		if slot3 == 1 then
			slot0.controller_:SetSelectedState("receive")
		elseif slot3 == 2 then
			slot0.controller_:SetSelectedState("complete")
		else
			slot0.controller_:SetSelectedState("not")
		end
	else
		slot0.controller_:SetSelectedState("not")
	end

	for slot7 = 1, #slot0.rewardItemList_ do
		slot0.rewardItemList_[slot7]:RefreshReceive(slot3 == 2 and true or false)
	end
end

return slot1
