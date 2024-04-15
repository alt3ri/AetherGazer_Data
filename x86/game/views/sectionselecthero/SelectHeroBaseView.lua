slot0 = class("SelectHeroBaseView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.drag_ = {}
	slot0.dragPosition_ = {}

	for slot4 = 1, 3 do
		slot0.drag_[slot4] = slot0[string.format("drag_%s", slot4)]

		slot0:CreateDragListeners(slot4)

		slot0.dragPosition_[slot4] = slot0.drag_[slot4].transform.localPosition
	end

	slot0.heroInfoItemList_ = {}
	slot0.comboSkillView_ = nil
	slot0.mimirInfoView_ = nil
	slot0.raceEffectController_ = slot0.controllerExCollection_:GetController("raceEffect")
	slot0.raceActiveController_ = slot0.controllerExCollection_:GetController("raceActive")
	slot0.comboActiveController_ = slot0.controllerExCollection_:GetController("comboActive")
	slot0.mimirActiveController_ = slot0.controllerExCollection_:GetController("mimirActive")
	slot0.selectComboSkillHandler_ = handler(slot0, slot0.OnComboSkillSelect)
end

function slot0.SetProxy(slot0, slot1)
	slot0.sectionProxy_ = slot1
	slot0.canSwitchResctrictHeroList_ = {
		0,
		0,
		0
	}

	if slot0.sectionProxy_.stageType and slot0.sectionProxy_.stageID and slot0.sectionProxy_.stageID ~= 0 then
		slot2, slot3 = BattleStageTools.GetRestrictHeroList(slot0.sectionProxy_.stageType, slot0.sectionProxy_.stageID)

		if type(slot3) == "table" then
			slot0.canSwitchResctrictHeroList_ = slot3
		end
	end

	slot0.reserveParams_ = slot1:GetReserveParams()

	slot0:TryReload()
	slot0:UpdateSubViewParams()
end

function slot0.UpdateSubViewParams(slot0)
	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5:SetProxy(slot0.sectionProxy_)
	end

	slot0.comboSkillView_:SetProxy(slot0.sectionProxy_)
	slot0.mimirInfoView_:SetProxy(slot0.sectionProxy_)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(COMBO_SKILL_SELECT, slot0.selectComboSkillHandler_)
	slot0:SubViewOnEnter()
	slot0:RefreshUI()
end

function slot0.SubViewOnEnter(slot0)
	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5:OnEnter(slot4)
	end

	slot0.comboSkillView_:OnEnter()
	slot0.mimirInfoView_:OnEnter()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0:SubViewOnExit()

	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5:OnExit()
	end

	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	if slot0.talkCDTimer_ then
		slot0.talkCDTimer_:Stop()

		slot0.talkCDTimer_ = nil
	end

	HeroTools.StopTalk()
	slot0:DestroyHeroModels()
end

function slot0.SubViewOnExit(slot0)
	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5:OnExit()
	end

	slot0.comboSkillView_:OnExit()
	slot0.mimirInfoView_:OnExit()
end

function slot0.Dispose(slot0)
	slot0:RemoveTriggerListeners()

	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5:Dispose()
	end

	slot0.heroInfoItemList_ = nil

	slot0.comboSkillView_:Dispose()

	slot0.comboSkillView_ = nil

	slot0.mimirInfoView_:Dispose()

	slot0.mimirInfoView_ = nil

	uv0.super.Dispose(slot0)
end

function slot0.AddListener(slot0)
	slot0:AddBtnListener(slot0.raceBtn_, nil, function ()
		JumpTools.OpenPageByJump("sectionSelectRaceDescription", {
			raceID = uv0.maxRaceID_,
			sameCamp = uv0.sameCamp_
		})
	end)
end

function slot0.CreateDragListeners(slot0, slot1)
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.BeginDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		if uv0.lockStateList_[uv1] or uv0.sectionProxy_.canChangeTeam ~= nil and uv0.sectionProxy_.canChangeTeam == false then
			ShowTips("CAN_NOT_CHANGE_HERO")

			return
		end

		if uv0.canSwitchResctrictHeroList_[uv1] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			ShowTips("TEAM_ERROR_CHANGE")

			return
		end

		uv0.selectIndex_ = uv1
		uv0.cacheSelectIndex_ = uv1
		uv0.cacheHeroNumber_ = {
			1,
			2,
			3
		}
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.Drag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ ~= uv1 then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		if (slot0.transform.localPosition + Vector3((slot1.delta * manager.ui.canvasRate).x, 0, 0)).x > 530 then
			slot3.x = 530
		elseif slot3.x < -273 then
			slot3.x = -273
		end

		slot0.transform.localPosition = slot3

		if uv0.heroModel_[uv1] then
			uv0.heroModel_[uv1].transform.localPosition = SectionSelectHeroTools.HeroTransform[1].position + SectionSelectHeroTools.GetModelOffesetPosition(uv0.dragPosition_[1], slot0.transform.localPosition)

			if not uv0.lockStateList_[uv1] or uv0.sectionProxy_.canChangeTeam ~= nil and uv0.sectionProxy_.canChangeTeam == true or uv0.canSwitchResctrictHeroList_[uv1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
				uv0:TryModifyHeroPos()
			end
		end
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.EndDrag, LuaHelper.EventTriggerAction1(function (slot0, slot1)
		if uv0.selectIndex_ ~= uv1 then
			return
		end

		if #uv0.loadingList_ > 0 then
			return
		end

		slot0.transform.localPosition = uv0.dragPosition_[uv1]

		if not uv0.lockStateList_[uv1] or uv0.sectionProxy_.canChangeTeam ~= nil and uv0.sectionProxy_.canChangeTeam == true or uv0.canSwitchResctrictHeroList_[uv1] == ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
			uv0:EndDrag(uv1)
		end

		uv0.selectIndex_ = nil
	end))
	slot0.drag_[slot1]:AddListenerType1(UnityEngine.EventSystems.EventTriggerType.PointerUp, LuaHelper.EventTriggerAction1(handlerArg1(slot0, slot0.ClickHero, slot1)))
end

function slot0.RemoveTriggerListeners(slot0)
	for slot4 = 1, 3 do
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.BeginDrag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.Drag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.EndDrag)
		slot0.drag_[slot4]:RemoveListenerType(UnityEngine.EventSystems.EventTriggerType.PointerUp)
	end
end

function slot0.ClickHero(slot0, slot1, slot2, slot3)
	if not slot3.dragging then
		if slot0.selectIndex_ then
			return
		end

		if #slot0.loadingList_ > 0 then
			return
		end

		BattleFieldData:SetCurrentSelectHeroData(slot0.cacheHeroTeam_[slot1], slot0.heroTrialList_[slot1])
		OperationRecorder.Record(slot0.class.__cname, "click_add")
		manager.notify:CallUpdateFunc(SECTION_CLICK_HERO, slot1)
	end
end

function slot0.ResetTempData(slot0)
	slot0.heroModel_ = {}
	slot0.loadAsyncIndex_ = {}
	slot0.loadingList_ = {}
	slot0.cacheHeroNumber_ = {
		1,
		2,
		3
	}
	slot0.cacheHeroTeam_ = {}
	slot0.heroTrialList_ = {}
end

function slot0.RefreshUI(slot0)
	slot0:RefreshHeroTeam()
	slot0:LoadHeroModels()
	slot0:RefreshMimir()
end

function slot0.RefreshHeroTeam(slot0)
	slot0:GetHeroTeam()
	slot0:RefreshHeroInfoItem()
	slot0:RefreshRace()
	slot0:RefreshCombo()
end

function slot0.RefreshHeroInfoItem(slot0)
	for slot4 = 1, 3 do
		slot0.heroInfoItemList_[slot4]:SetData(slot4)
	end
end

function slot0.ChangeHeroTeam(slot0, slot1)
	slot2 = slot1
	slot3 = {
		[slot7] = slot0.heroTrialList_[table.keyof(slot0.cacheHeroTeam_, slot8)]
	}

	for slot7, slot8 in ipairs(slot1) do
		-- Nothing
	end

	if slot2[1] ~= slot0.cacheHeroTeam_[1] then
		slot0:PlayHeroTalk(slot2[1])
	end

	slot0.sectionProxy_:ChangeHeroTeam(slot2, slot3)
	manager.notify:Invoke(SECTION_CHANGE_HERO_TEAM, slot2, slot3)
end

function slot0.TryModifyHeroPos(slot0)
	for slot6 = 1, 3 do
		if math.abs(SectionSelectHeroTools.HeroTransform[slot6].position.x - slot0.heroModel_[slot0.selectIndex_].transform.localPosition.x) <= 0.6 and slot6 ~= slot0.cacheSelectIndex_ then
			if slot0.cacheHeroTeam_[slot0.cacheHeroNumber_[slot6]] == 0 or slot0.canSwitchResctrictHeroList_[slot0.cacheHeroNumber_[slot6]] ~= ReserveConst.RESTRICT_HERO_SWITCH_MODE.FORBID then
				break
			end

			if slot0.lockStateList_[slot0.selectIndex_] or slot0.lockStateList_[slot6] then
				return
			end

			if slot0.heroModel_[slot0.cacheHeroNumber_[slot6]] then
				slot0.heroModel_[slot0.cacheHeroNumber_[slot6]].transform.localPosition = SectionSelectHeroTools.HeroTransform[slot0.cacheSelectIndex_].position
				slot0.heroModel_[slot0.cacheHeroNumber_[slot6]].transform.localEulerAngles = SectionSelectHeroTools.HeroTransform[slot0.cacheSelectIndex_].rotation
			end

			slot0.cacheHeroNumber_[slot6] = slot0.cacheHeroNumber_[slot0.cacheSelectIndex_]
			slot0.cacheHeroNumber_[slot0.cacheSelectIndex_] = slot0.cacheHeroNumber_[slot6]
			slot0.cacheSelectIndex_ = slot6

			break
		end
	end
end

function slot0.EndDrag(slot0, slot1)
	for slot6 = 1, 3 do
	end

	slot3 = {}

	for slot7, slot8 in pairs({
		[slot6] = slot0.cacheHeroTeam_[slot0.cacheHeroNumber_[slot6]]
	}) do
		slot9 = 1

		for slot13 = 1, 3 do
			if slot0.cacheHeroTeam_[slot13] == slot8 then
				slot9 = slot13

				break
			end
		end

		slot3[slot7] = slot0.heroModel_[slot9]

		if slot3[slot7] then
			slot3[slot7].transform.localPosition = SectionSelectHeroTools.HeroTransform[slot7].position
			slot3[slot7].transform.localEulerAngles = SectionSelectHeroTools.HeroTransform[slot7].rotation
		end
	end

	slot0.heroModel_ = slot3

	slot0:ChangeHeroTeam(slot2)
	slot0:RefreshHeroTeam()
	OperationRecorder.Record(slot0.class.__cname, "endDrag")
end

function slot0.LoadHeroModels(slot0)
	for slot4, slot5 in ipairs(slot0.cacheHeroTeam_) do
		if slot5 ~= 0 and slot5 then
			table.insert(slot0.loadingList_, slot5)

			slot0.loadAsyncIndex_[slot4] = manager.resourcePool:AsyncLoad("Char/" .. slot0:GetSkinCfg(slot4).ui_modelId, ASSET_TYPE.TPOSE, function (slot0)
				uv0.heroModel_[uv1] = slot0
				uv0.heroModel_[uv1].transform.localEulerAngles = SectionSelectHeroTools.HeroTransform[uv1].rotation
				uv0.heroModel_[uv1].transform.localPosition = SectionSelectHeroTools.HeroTransform[uv1].position
				uv0.heroModel_[uv1].transform.localScale = SectionSelectHeroTools.HeroTransform[uv1].scale

				if table.keyof(uv0.loadingList_, uv2) then
					table.remove(uv0.loadingList_, slot1)
				end
			end)
		end
	end
end

function slot0.DestroyHeroModels(slot0)
	for slot4, slot5 in pairs(slot0.heroModel_) do
		manager.resourcePool:DestroyOrReturn(slot5, ASSET_TYPE.TPOSE)
	end

	for slot4, slot5 in pairs(slot0.loadAsyncIndex_) do
		manager.resourcePool:StopAsyncQuest(slot0.loadAsyncIndex_[slot4])
	end

	slot0.loadAsyncIndex_ = nil
	slot0.heroModel_ = nil
end

function slot0.GetSkinCfg(slot0, slot1)
	return slot0.sectionProxy_:CustomGetSkinCfg(slot1, slot0.cacheHeroTeam_[slot1], slot0.heroTrialList_[slot1])
end

function slot0.PlayHeroTalk(slot0, slot1)
	if slot0.talkTimer_ then
		slot0.talkTimer_:Stop()

		slot0.talkTimer_ = nil
	end

	HeroTools.StopTalk()

	if slot0.talkCDTimer_ then
		return
	end

	slot0.talkTimer_ = Timer.New(function ()
		HeroTools.PlayTalk(uv0, "leader")

		uv1.talkTimer_ = nil
		uv1.talkCDTimer_ = Timer.New(function ()
			uv0.talkCDTimer_:Stop()

			uv0.talkCDTimer_ = nil
		end, HeroConst.SET_LEADER_VOICE_CD, 1)

		uv1.talkCDTimer_:Start()
	end, HeroConst.TALK_DELAY_TIME, 1)

	slot0.talkTimer_:Start()
end

function slot0.RefreshRace(slot0)
	slot0.raceActiveController_:SetSelectedState(tostring(slot0.sectionProxy_.needRacePanel))

	if slot0.sectionProxy_.needRacePanel then
		slot0:RefreshRaceUI()
	end
end

function slot0.RefreshRaceUI(slot0)
	slot1, slot2, slot3 = nil

	if slot0.sectionProxy_.forceRace == -1 then
		slot0.maxRaceID_, slot2, slot0.sameCamp_ = slot0:GetRaceEffect()
	else
		slot1 = slot0.sectionProxy_.forceRace

		for slot7, slot8 in ipairs(slot0.cacheHeroTeam_) do
			if slot8 ~= 0 then
				slot2 = 0 + 1
			end
		end
	end

	slot0.maxRaceID_ = slot1
	slot0.sameCamp_ = slot3

	if slot1 == 0 then
		slot0.raceEffectController_:SetSelectedState("none")
	else
		slot0.raceIcon_.sprite = HeroTools.GetRaceIcon(slot1)

		if slot2 > 1 then
			slot0.raceEffectController_:SetSelectedState(tostring(slot2 <= 3 and slot2 or 3))
		end
	end
end

function slot0.RefreshCombo(slot0)
	slot0.comboActiveController_:SetSelectedState(tostring(slot0.sectionProxy_.needComboSkillPanel))

	if slot0.sectionProxy_.needComboSkillPanel then
		slot0:RefreshComboSkillUI()
	end
end

function slot0.RefreshComboSkillUI(slot0)
	slot0.comboSkillView_:SetData()
end

function slot0.OnComboSkillSelect(slot0)
	slot0.comboSkillView_:OnComboSkillSelect()
end

function slot0.RefreshMimir(slot0)
	if JumpTools.IsSystemLocked(ViewConst.SYSTEM_ID.CHIP_MANAGER) then
		slot0.mimirActiveController_:SetSelectedState("false")

		return
	end

	slot0.mimirActiveController_:SetSelectedState(tostring(slot0.sectionProxy_.needMimirPanel))

	if slot0.sectionProxy_.needMimirPanel then
		slot0:RefreshMimirUI()
	end
end

function slot0.RefreshMimirUI(slot0)
	slot0.mimirInfoView_:SetData()
end

function slot0.GetHeroTeam(slot0)
	slot0.cacheHeroTeam_, slot0.lockStateList_, slot0.lockList_, slot0.heroTrialList_ = slot0.sectionProxy_:GetHeroTeam()
end

function slot0.GetRaceEffect(slot0)
	return slot0.sectionProxy_:GetRaceEffect()
end

function slot0.CheckCanStartBattle(slot0)
	slot1 = true
	slot2 = nil

	if #slot0.loadingList_ > 0 then
		slot1 = false
	end

	return slot1, slot2
end

function slot0.GetHeroInfoItemClass(slot0)
	return slot0.sectionProxy_:GetHeroInfoItemClass()
end

function slot0.GetMimirInfoViewClass(slot0)
	return slot0.sectionProxy_:GetMimirInfoViewClass()
end

function slot0.GetComboSkillViewClass(slot0)
	return slot0.sectionProxy_:GetComboSkillViewClass()
end

function slot0.TryReload(slot0)
	if not slot0.createdSubview_ then
		slot0.createdSubview_ = true
		slot0.heroInfoItemList_ = {}

		for slot5 = 1, slot0.heroInfoItemContentTrans_.childCount do
			slot0.heroInfoItemList_[slot5] = slot0:GetHeroInfoItemClass().New(slot0.heroInfoItemContentTrans_:GetChild(slot5 - 1).gameObject, slot5)
		end

		slot0.comboSkillView_ = slot0:GetComboSkillViewClass().New(slot0.comboSkillGo_)
		slot0.mimirInfoView_ = slot0:GetMimirInfoViewClass().New(slot0.mimirInfoGo_)
	end

	for slot4, slot5 in ipairs(slot0.heroInfoItemList_) do
		slot5 = slot0:ReloadView(slot5, slot0.sectionProxy_:GetHeroInfoItemClass())
	end

	slot0.comboSkillView_ = SectionSelectHeroTools.ReloadView(slot0.comboSkillView_, slot0.sectionProxy_:GetComboSkillViewClass())
	slot0.mimirInfoView_ = SectionSelectHeroTools.ReloadView(slot0.mimirInfoView_, slot0.sectionProxy_:GetMimirInfoViewClass())
end

function slot0.ReloadView(slot0, slot1, slot2)
	if slot1.__cname ~= slot2.__cname then
		slot5 = slot1.transform.parent

		slot1:Dispose()

		return slot2.New(Object.Instantiate(slot1.gameObject, slot5), slot5)
	else
		return slot1
	end
end

return slot0
