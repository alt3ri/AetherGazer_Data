slot0 = class("HeroClueDetailView", ReduxView)

function slot0.UIName(slot0)
	return HeroClueTools.GetClueDetailViewUIName(slot0.params_.activtiyID)
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

	slot0.clueInfoController_ = ControllerUtil.GetController(slot0.transform_, "level")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.exitBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.activityID_ = slot0.params_.activityID
	slot0.clueID_ = slot0.params_.clueID

	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot1 = HeroClueCfg[slot0.clueID_]

	if HeroClueData:GetUnlockClueDataDic()[slot0.clueID_] then
		if slot2.level == 1 then
			slot0.clueNameText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
			slot0.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		elseif slot2.level == 2 then
			slot0.clueNameText_.text = slot1.name
			slot0.clueDescText_.text = GetTips("ACTIVITY_HERO_CLUE_NICK_TITLE")
		else
			slot0.clueNameText_.text = slot1.name
			slot0.clueDescText_.text = slot1.desc
		end

		slot0.clueInfoController_:SetSelectedState(slot2.level)
	end
end

return slot0
