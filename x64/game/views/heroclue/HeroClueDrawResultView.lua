slot0 = class("HeroClueDrawResultView", ReduxView)

function slot0.UIName(slot0)
	return HeroClueTools.GetDrawResultViewUIName(slot0.params_.activtiyID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.backMask_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.rewardList_ = slot0.params_.rewardList
	slot0.clueID_ = slot0.rewardList_[1]

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = HeroClueCfg[slot0.clueID_]
	slot0.clueIcon_.sprite = getSpriteWithoutAtlas(slot1.icon_path)
	slot0.clueName_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_UNLOCK"), slot1.name)
	slot0.progressText_.text = string.format(GetTips("ACTIVITY_HERO_CLUE_COLLECT"), HeroClueData:GetUnlockClueDataDic()[slot0.clueID_].level, #slot1.level)
end

return slot0
