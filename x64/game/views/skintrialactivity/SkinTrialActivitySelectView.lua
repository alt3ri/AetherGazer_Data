slot0 = class("SkinTrialActivitySelectView", ReduxView)

function slot0.UIName(slot0)
	return "UI/OsirisUI/OsirisSkinTrialUI_101"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.activityID_ = slot0.params_.activityID
	slot0.skinTrialID_ = slot0.params_.skinTrialID
	slot0.popType_ = POP_ITEM
	slot0.receivedControllerList_ = {}
	slot0.itemList_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.itemListGo_, slot0:GetRewardItem())
	slot0.adaptImg_ = slot0:FindCom("AdaptImage", nil, slot0.skinImageTras_)

	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})

	slot0.activityID_ = slot0.params_.activityID
	slot0.skinTrialID_ = slot0.params_.skinTrialID

	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
	slot0.itemList_:Dispose()

	slot0.itemList_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.btnBattle_, nil, function ()
		SkinTrialData:SaveStageID(uv0.skinTrialID_)

		if not ActivityData:GetActivityData(uv0.activityID_):IsActivitying() then
			ShowTips("TIME_OVER")

			return
		end

		uv0:SaveRoute()
		uv0:Go("/sectionSelectHero", {
			section = ActivitySkinTrialCfg[uv0.skinTrialID_].stage_id,
			sectionType = BattleConst.STAGE_TYPE_NEW.SKIN_TRIAL,
			activityID = uv0.activityID_
		})
	end)
end

function slot0.RefreshUI(slot0)
	slot2 = SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)
	slot3 = HeroStandardSystemCfg[slot2].skin_id
	slot4 = HeroStandardSystemCfg[slot2].hero_id
	slot0.heroNameText_.text = string.format("%s·%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))

	if SettingData:GetCurrentLanguage() == "fr" or slot5 == "de" then
		slot0.heroNameText_.text = string.format("%s-%s", GetI18NText(HeroCfg[slot4].name), GetI18NText(HeroCfg[slot4].suffix))
	end

	slot0.skinDescText_.text = GetI18NText(SkinCfg[slot3].desc)

	slot0:RefreshRoleImage()
	slot0:RefreshReward()
end

function slot0.RefreshRoleImage(slot0)
	if getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. SkinCfg[HeroStandardSystemCfg[SkinTrialTools.GetHeroStandardID(slot0.skinTrialID_)].skin_id].picture_id) ~= nil then
		slot0.skinImage_.sprite = slot2

		slot0.adaptImg_:AdaptImg()
	end
end

function slot0.RefreshReward(slot0)
	slot0.rewardCfg_ = getRewardFromDropCfg(BattleSkinTrialStageCfg[ActivitySkinTrialCfg[slot0.skinTrialID_].stage_id].drop_lib_id, true)

	slot0.itemList_:StartScroll(#slot0.rewardCfg_)
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot4 = slot0:GetCommonItem(slot2)

	slot4:RefreshData(rewardToItemTemplate(slot0.rewardCfg_[slot1]))
	slot4:RegistCallBack(function (slot0)
		if uv0.clickCallback_ then
			if uv0.clickCallback_() then
				ShowPopItem(uv0.popType_, slot0)
			end
		else
			ShowPopItem(uv0.popType_, slot0)
		end
	end)

	if slot0.receivedControllerList_[slot1] == nil then
		slot0.receivedControllerList_[slot1] = ControllerUtil.GetController(slot4.transform_, "received")
	end

	if SkinTrialData:IsCompleted(slot0.skinTrialID_) then
		slot0.receivedControllerList_[slot1]:SetSelectedState("true")
	end

	slot4:Show(true)
end

function slot0.GetRewardItem(slot0)
	return CommonItem
end

function slot0.GetCommonItem(slot0, slot1)
	return slot1
end

function slot0.SaveRoute(slot0)
	SkinTrialData:SaveRoute({
		name = "skinTrialSelect",
		activityID = slot0.activityID_,
		skinTrialID = slot0.skinTrialID_
	})
end

return slot0
