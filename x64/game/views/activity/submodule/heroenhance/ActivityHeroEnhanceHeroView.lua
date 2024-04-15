slot0 = class("ActivityHeroEnhanceHeroView", ReduxView)

function slot0.UIName(slot0)
	return ActivityHeroEnhanceTools.GetHeroUIName(slot0.params_.activityID)
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.heroList_ = LuaList.New(handler(slot0, slot0.IndexHeroItem), slot0.heroUiListGo_, ActivityHeroEnhanceHeroItem)
	slot0.middleView_ = ActivityHeroEnhanceTalentView.New(slot0.talentUIGo_)
	slot0.detailView_ = ActivityHeroEnhanceTalentDetailView.New(slot0.talentDetailGo_)
	slot0.statusController_ = slot0.controller_:GetController("status")

	slot0.statusController_:SetSelectedState("main")
	SetActive(slot0.talentDetailGo_, false)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(nil, slot0.goBtn_, function ()
		uv0:OnClickGoBtn()
	end)
	slot0:AddBtnListener(nil, slot0.bgBtn_, function ()
		uv0:OnClickBgBtn()
	end)
	slot0.middleView_:SetClickTalentHandler(function (slot0, slot1, slot2, slot3, slot4, slot5)
		if slot2 then
			uv0:SelectGroup(slot1)
		else
			slot0:SelectIdx(slot5)
			uv0:SelectTalent(slot4)

			uv0.lastTalentIdx_ = slot5
		end
	end)
	slot0.detailView_:SetClickBtnHandler(function (slot0, slot1)
		if slot0 then
			uv0:OnClickUseTalent(slot1)
		else
			uv0:OnClickDropTalent(slot1)
		end
	end)
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR
	})
	manager.windowBar:RegistBackCallBack(function ()
		uv0:Back()
	end)

	slot0.activityId_ = slot0.params_.activityID
	slot0.cfgIdList_ = ActivityHeroEnhanceTools.GetCfgIdList(slot0.activityId_)

	if not slot0.cfgId_ then
		if uv0.enterBattleCfgId_ then
			slot0.cfgId_ = uv0.enterBattleCfgId_
			uv0.enterBattleCfgId_ = nil

			slot0:SelectHero(table.indexof(slot0.cfgIdList_, slot0.cfgId_))
		else
			slot0.cfgId_ = slot0.cfgIdList_[1]
		end
	end

	slot1 = slot0.params_.stageToView

	if slot0.params_.talentIdToView or slot1 then
		slot0.cfgId_ = slot0.params_.cfgId
		slot4 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceCfg[slot0.cfgId_], slot1)

		slot0:SelectGroup(slot1, table.indexof(slot4, slot2 or slot4[1]))

		slot0.params_.talentIdToView = nil
		slot0.params_.stageToView = nil
		slot0.params_.cfgId = nil
		slot0.section_CfgId_ = slot0.cfgId_
		slot0.cfgIdList_ = {
			slot0.section_CfgId_
		}
	else
		slot0:OnClickBgBtn()
	end

	slot0:RefreshUI()
	slot0.middleView_:OnEnter()
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
	slot0:UpdateRedPointUI(true)
	slot0.middleView_:OnExit()

	slot0.lastGroupIdx_ = nil
	slot0.lastTalentIdx_ = nil
end

function slot0.RefreshUI(slot0)
	slot0.heroList_:StartScroll(#slot0.cfgIdList_)
end

function slot0.IndexHeroItem(slot0, slot1, slot2)
	slot2:SetData(slot0.cfgIdList_[slot1])
	slot2:SetClickHandler(function (slot0)
		uv0:OnClickHero(uv1, uv2, slot0)
	end)

	slot4, slot5 = slot0.heroList_:GetHeadAndTail()
	slot6 = slot1 == slot5

	if slot0:GetHeroSelectIdx() == nil and slot1 == 1 then
		slot6 = false

		slot0:SelectHero(1)
	end

	slot2:SetSelected(slot0:GetHeroSelectIdx() == slot1)
	slot2:RefreshUI()

	if slot6 then
		slot0:UpdateRedPointUI(false)
	end
end

function slot0.OnClickHero(slot0, slot1, slot2, slot3)
	if ActivityHeroEnhanceTools.IsCfgHeroLock(ActivityHeroEnhanceCfg[slot0.cfgIdList_[slot1]]) then
		return
	end

	slot0:SelectHero(slot1)

	if slot0.lastGroupIdx_ and slot0.lastTalentIdx_ then
		slot0:SelectGroup(slot0.lastGroupIdx_, slot0.lastTalentIdx_)
	end
end

function slot0.SelectHero(slot0, slot1)
	slot0:SetHeroSelectIdx(slot1)

	slot2 = slot0.cfgIdList_[slot1]
	slot0.cfgId_ = slot2
	slot0.heroId_ = ActivityHeroEnhanceCfg[slot2].hero_id
	slot7 = slot2

	slot0.middleView_:SetData(slot7)
	slot0.middleView_:RefreshUI()

	slot6 = slot0.heroList_
	slot8 = slot6

	for slot7, slot8 in pairs(slot6.GetItemList(slot8)) do
		slot8:SetSelected(slot0:GetHeroSelectIdx() == slot7)
		slot8:RefreshUI()
	end

	slot0:UpdateRedPointUI(false)
end

function slot0.OnClickUseTalent(slot0, slot1)
	ActivityHeroEnhanceAction.ActivateTalent(slot0.activityId_, slot0.heroId_, slot1, function ()
		uv0.middleView_:RefreshUI()
		uv0.detailView_:RefreshUI()
	end)
end

function slot0.OnClickDropTalent(slot0, slot1)
	ActivityHeroEnhanceAction.DeactivateTalent(slot0.activityId_, slot1, function ()
		uv0.middleView_:RefreshUI()
		uv0.detailView_:RefreshUI()
	end)
end

function slot0.SelectGroup(slot0, slot1, slot2)
	slot4 = ActivityHeroEnhanceTools.GetCfgTalentListByStage(ActivityHeroEnhanceCfg[slot0.cfgId_], slot1)

	if slot2 == nil then
		slot2 = ActivityHeroEnhanceTools.GetTalentListActivatedIdx(slot0.activityId_, slot4) > 0 and slot2 or 1
	end

	slot0.middleView_:SelectGroupIdx(slot1, slot2)
	slot0.middleView_:RefreshUI_SelectState()
	slot0:SelectTalent(slot4[slot2])

	slot0.lastGroupIdx_ = slot1
	slot0.lastTalentIdx_ = slot2
end

function slot0.SelectTalent(slot0, slot1)
	slot0.detailView_:SetData(slot0.activityId_, slot1)
	slot0.detailView_:RefreshUI()
	slot0:PlayEnterAni()
end

function slot0.OnClickBgBtn(slot0)
	slot0.middleView_:SelectGroupIdx(0)
	slot0.middleView_:RefreshUI_SelectState()
	slot0:PlayExitAni()

	slot0.lastGroupIdx_ = nil
	slot0.lastTalentIdx_ = nil
end

function slot0.OnClickGoBtn(slot0)
	slot1 = slot0.cfgIdList_[slot0:GetHeroSelectIdx()]

	slot0:JumpToSection(slot1)

	slot2 = slot0.activityId_

	ActivityHeroEnhanceAction.BanRedPoint(slot2, string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, ActivityHeroEnhanceCfg[slot1].hero_id, ActivityTools.GetRedPointKey(slot2) .. slot2))
end

function slot0.JumpToSection(slot0, slot1)
	slot0.section_CfgId_ = nil

	JumpTools.OpenPageByJump("/activityHeroEnhanceSection", {
		activityID = slot0.params_.activityID,
		cfgId = slot1
	})
end

function slot0.PlayEnterAni(slot0)
	slot0.isEntered_ = true

	slot0.statusController_:SetSelectedState("detail")
	SetActive(slot0.talentDetailGo_, true)
end

function slot0.PlayExitAni(slot0)
	slot0.isEntered_ = false

	slot0.statusController_:SetSelectedState("main")
	SetActive(slot0.talentDetailGo_, false)
end

function slot0.Back(slot0)
	if slot0.isEntered_ then
		slot0:OnClickBgBtn()
	elseif slot0.section_CfgId_ then
		slot0:JumpToSection(slot0.section_CfgId_)
	else
		uv0.super.Back(slot0)
	end
end

function slot0.UpdateRedPointUI(slot0, slot1)
	if slot0.redPointHistory_ then
		for slot5, slot6 in pairs(slot0.redPointHistory_) do
			manager.redPoint:unbindUIandKey(slot5, slot6)
		end
	end

	slot0.redPointHistory_ = {}

	if slot1 then
		return
	end

	slot2 = slot0.activityId_

	for slot8, slot9 in ipairs(ActivityHeroEnhanceCfg.get_id_list_by_activity_id[slot2]) do
		slot11 = ActivityHeroEnhanceCfg[slot9].hero_id

		if slot11 == slot0.heroId_ then
			slot0.redPointHistory_[slot0.goBtn_.transform] = string.format("%s_%d_%s", RedPointConst.ACTIVITY_HERO_ENHANCE_STAGE_REWARD, slot11, ActivityTools.GetRedPointKey(slot2) .. slot2)
		end

		if slot0:GetHeroItemByCfgId(slot9) then
			slot0.redPointHistory_[slot13:GetRedPointTransform()] = slot12
		end
	end

	for slot8, slot9 in pairs(slot0.redPointHistory_) do
		manager.redPoint:bindUIandKey(slot8, slot9)
	end
end

function slot0.GetHeroItemByCfgId(slot0, slot1)
	slot4 = slot0.heroList_
	slot6 = slot4

	for slot5, slot6 in pairs(slot4.GetItemList(slot6)) do
		if slot6:GetCfgId() == slot1 then
			return slot6
		end
	end

	return nil
end

function slot0.GetHeroSelectIdx(slot0)
	if slot0.section_CfgId_ and slot0.heroSelectIdx_ then
		return 1
	end

	return slot0.heroSelectIdx_
end

function slot0.SetHeroSelectIdx(slot0, slot1)
	if slot0.section_CfgId_ then
		if not slot0.heroSelectIdx_ then
			slot0.heroSelectIdx_ = table.indexof(ActivityHeroEnhanceTools.GetCfgIdList(slot0.activityId_), slot0.section_CfgId_)
		end

		return
	end

	slot0.heroSelectIdx_ = slot1
end

function slot0.Dispose(slot0)
	slot0.middleView_:Dispose()
	slot0.detailView_:Dispose()
	slot0.heroList_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
