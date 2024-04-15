slot0 = class("NewSectionSelectHeroBaseView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Formation/FormationMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.selectHeroView_ = nil
	slot0.stageInfoView_ = nil
	slot0.reserveBtnController_ = slot0.controllerExCollection_:GetController("reserveActive")
	slot0.totalEnergyController_ = slot0.controllerExCollection_:GetController("totalEnergy")
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.startBtn_, nil, function ()
		uv0:OnClickStartBattle()
	end)
	slot0:AddBtnListener(slot0.reservesBtn_, nil, function ()
		if not uv0.sectionProxy_.canChangeReserveProposal then
			return
		end

		uv0:GotoReservesProposalUI()
	end)
end

function slot0.GotoReservesProposalUI(slot0)
	slot0.sectionProxy_:GotoReservesProposalUI()
end

function slot0.OnEnter(slot0)
	slot0:UpdateDefaultParams()
	slot0:UpdateSubViewParams()
	slot0:UpdateBar()
	slot0:UpdateCamera()
	slot0:ResetTempData()
	slot0:SubViewOnEnter()
	slot0:RefreshUI()
	slot0:RefreshCustomUI()
	print(slot0.stageID_)
end

function slot0.UpdateSubViewParams(slot0)
	slot0.selectHeroView_:SetProxy(slot0.sectionProxy_)
	slot0.stageInfoView_:SetProxy(slot0.sectionProxy_)
end

function slot0.SubViewOnEnter(slot0)
	slot0.sectionProxy_:OnSectionSelectEnter()
	slot0.selectHeroView_:OnEnter()
	slot0.stageInfoView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:SubViewOnExit()

	slot0.params_.isSorted = false

	manager.windowBar:HideBar()
	manager.ui:ResetMainCamera()
end

function slot0.SubViewOnExit(slot0)
	slot0.sectionProxy_:OnSectionSelectExit()
	slot0.selectHeroView_:OnExit()
	slot0.stageInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.selectHeroView_:Dispose()

	slot0.selectHeroView_ = nil

	slot0.stageInfoView_:Dispose()

	slot0.stageInfoView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.UpdateCamera(slot0)
	manager.ui:SetMainCamera("battleHeroSelect")
	manager.ui:AdaptUIByFOV()
end

function slot0.UpdateBar(slot0)
	slot0.sectionProxy_:UpdateBar()
	manager.windowBar:RegistBackCallBack(function ()
		CommonFilterData:ClearFilter(Filter_Root_Define.Hero_Filter_List.filter_id)
		uv0:Back()
	end)
end

function slot0.UpdateDefaultParams(slot0)
	slot0.multiple_ = slot0.params_.multiple or 1
	slot0.stageID_ = slot0.params_.section
	slot0.stageType_ = slot0.params_.sectionType or BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_UNDEFINED
	slot0.activityID_ = slot0.params_.activityID

	if not slot0.params_.reserveParams then
		slot0.params_.reserveParams = ReserveTools.GetReserveParams(slot0.stageType_, slot0.stageID_, slot0.activityID_)
	elseif not slot0.params_.reserveParams.customData.activityID then
		slot0.params_.reserveParams.customData.activityID = slot0.activityID_
	end

	slot0.reserveParams_ = slot0.params_.reserveParams

	if not slot0.params_.sectionProxy then
		slot0.params_.sectionProxy = SectionSelectHeroTools.GetProxy(slot0.params_, slot0.reserveParams_, slot0.params_.heroDataType or HeroConst.HERO_DATA_TYPE.DEFAULT)
	end

	slot0.sectionProxy_ = slot0.params_.sectionProxy

	slot0:TryReload()
end

function slot0.ResetTempData(slot0)
	slot0.selectHeroView_:ResetTempData()
end

function slot0.RefreshUI(slot0)
	slot0:RefreshReservesBtn()
	slot0:RefreshSortType()
end

function slot0.RefreshCustomUI(slot0)
end

function slot0.RefreshSortType(slot0)
	if not slot0.params_.isSorted then
		HeroData:ResetSortValue()
	end
end

function slot0.RefreshReservesBtn(slot0)
	slot1 = true

	for slot6 = 1, 3 do
		if (slot0.sectionProxy_:GetLockStateList() or {})[slot6] then
			slot1 = false
		end
	end

	if slot0.sectionProxy_.canChangeTeam == false then
		slot1 = false
	end

	slot0.sectionProxy_.needReserveProposalPanel = slot1
	slot0.sectionProxy_.canChangeReserveProposal = slot1

	slot0.reserveBtnController_:SetSelectedState(tostring(slot0.sectionProxy_.needReserveProposalPanel))
end

function slot0.OnSectionClickHero(slot0, slot1)
	slot0.sectionProxy_:GotoHeroInfoUI(slot1)
end

function slot0.OnClickStartBattle(slot0)
	slot1, slot2 = slot0.selectHeroView_:CheckCanStartBattle()

	if slot1 then
		slot0:StartBattle()
	elseif slot2 then
		ShowTips(slot2)
	end
end

function slot0.StartBattle(slot0)
	slot0.sectionProxy_:StartBattle()
end

function slot0.GetStageInfoClass(slot0)
	return slot0.sectionProxy_:GetStageInfoClass()
end

function slot0.GetSelectHeroViewClass(slot0)
	return slot0.sectionProxy_:GetSelectHeroViewClass()
end

function slot0.TryReload(slot0)
	if not slot0.createdSubview_ then
		slot0.createdSubview_ = true
		slot0.selectHeroView_ = slot0:GetSelectHeroViewClass().New(slot0.selectHeroGo_)
		slot0.stageInfoView_ = slot0:GetStageInfoClass().New(slot0.stageInfoGo_)
	end

	slot0.selectHeroView_ = SectionSelectHeroTools.ReloadView(slot0.selectHeroView_, slot0.sectionProxy_:GetSelectHeroViewClass())
	slot0.stageInfoView_ = SectionSelectHeroTools.ReloadView(slot0.stageInfoView_, slot0.sectionProxy_:GetStageInfoClass())
end

return slot0
