slot0 = class("HeroEquipBagView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/System/Hero_equip/HeroEquipSwitchUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.equipBag_ = EquipBagView.New(slot0, slot0.equipBagGo_, {
		suitPos = slot0.params_.suitPos
	})

	slot0.equipBag_:RegisterItemClick(handler(slot0, slot0.ClickBagItem))

	slot0.equipInfoViewRight_ = EquipInfoView.New(slot0.rightInfo_)
	slot0.equipInfoViewMiddle_ = EquipInfoView.New(slot0.middleInfo_)

	slot0.equipInfoViewRight_:RegisterSkillClick(handler(slot0, slot0.SkillClick), false)
	slot0.equipInfoViewMiddle_:RegisterSkillClick(handler(slot0, slot0.SkillClick), true)
	slot0.equipInfoViewRight_:RegisterChange(function (slot0)
		uv0.equipInfoViewMiddle_:ChangeSelect(slot0)
	end)
	slot0.equipInfoViewMiddle_:RegisterChange(function (slot0)
		if slot0 == "suit" and uv0.popController_:GetSelectedState() ~= "onlyEquip" then
			uv0.popController_:SetSelectedState("onlyEquip")
		end

		uv0.equipInfoViewRight_:ChangeSelect(slot0)
	end)

	slot0.equipSkillView_ = EquipNewSkillInfoView.New(slot0.skillInfo_)
	slot0.popController_ = slot0.popCon_:GetController("popState")
	slot0.rightEmptyController_ = slot0.rightCon_:GetController("empty")

	slot0:InitEquipDiscNextFrame()

	slot0.leftPopTrans_ = slot0.swapGo_.transform
	slot0.rightRootTrans_ = slot0.rightCon_.transform
end

function slot0.InitEquipDiscNextFrame(slot0)
	slot1 = nil

	FrameTimer.New(function ()
		uv0:Stop()

		uv1.equipDiscGo_ = Object.Instantiate(Asset.Load("Widget/System/Hero_equip/EquipDisc"), uv1.discParent_, false)
		uv1.equipDiscGo_.transform.localScale = Vector3(1.2, 1.2, 1.2)
		uv1.equipDisc_ = EquipDisc.New(uv1.equipDiscGo_)

		uv1.equipDisc_:OnEnter({
			oldIndex = 5,
			newIndex = uv1.selectPos_
		})
		uv1.equipDisc_:RefreshItem(uv1.equipDataList)
	end, 1, 1):Start()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListenerScale(slot0.btnUnloadAll_, nil, function ()
		if not _G.SkipTip.SkipUninstallEquipTip and SettingData:GetRemindSettingData().uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function ()
					_G.SkipTip.SkipUninstallEquipTip = uv0.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(uv0.params_.heroId)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipUninstallEquipTip = slot0
				end
			})
		else
			HeroAction.EquipUnloadAll(uv0.params_.heroId)
		end
	end)
	slot0:AddBtnListenerScale(slot0.btnScheme_, nil, function ()
		uv0:Go("/EquipProposal", {
			heroID = uv0.params_.heroId,
			proxy = uv0.params_.proxy
		})
	end)
	slot0:AddBtnListener(slot0.btnMask1_, nil, function ()
		uv0.equipBag_:ClearSelect()
		uv0:HidePopView()
	end)
	slot0:AddBtnListener(slot0.btnDecompose_, nil, function ()
		JumpTools.GoToSystem("/equipDecompose")
	end)
end

function slot0.OnEnter(slot0)
	slot0.equipList_ = {}
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)
	slot0.heroViewDataProxy_ = slot0.params_.proxy

	slot0.equipInfoViewRight_:OnEnter(slot0.heroViewDataProxy_)
	slot0.equipInfoViewMiddle_:OnEnter(slot0.heroViewDataProxy_)

	slot0.selectPos_ = slot0.selectPos_ or slot0.params_.suitPos

	if slot0.equipDisc_ then
		if slot0.params_.translationAnim then
			slot0.equipDisc_:OnEnter({
				oldIndex = slot0.selectPos_,
				newIndex = slot0.selectPos_
			})
		else
			slot0.equipDisc_:OnEnter({
				oldIndex = 5,
				newIndex = slot0.selectPos_
			})
		end
	end

	slot0.lastPos_ = slot1

	slot0.enterAnim_:Play("Fx_Equip_change", -1, 0)
	slot0.enterAnim_:Update(0)
	slot0.equipBag_:OnEnter({
		heroId = slot0.params_.heroId,
		suitPos = slot0.selectPos_
	})
	slot0:RefreshHeroEquipS()
end

function slot0.OnTop(slot0)
	slot0:UpdateBar()

	if slot0.params_.needRefresh then
		slot0.equipBag_:RefreshData(slot0, {
			heroId = slot0.params_.heroId,
			suitPos = slot0.params_.suitPos,
			suit = slot0.params_.suit
		})
	end

	slot0.params_.suit = nil
	slot0.params_.needRefresh = nil
end

function slot0.RefreshHeroEquipS(slot0, slot1)
	slot0.equipBag_:Render()

	slot0.equipDataList = slot0.heroViewDataProxy_:GetEquipDataList(slot0.params_.heroId)

	for slot6, slot7 in ipairs(slot0.heroViewDataProxy_:GetEquipInfoList(slot0.params_.heroId)) do
		slot0.equipList_[slot7.pos] = slot7.equip_id
	end

	slot0:RefreshRightEquipInfo()

	if slot0.equipDisc_ then
		if slot1 and slot1.isShow then
			slot0.equipDisc_:ShowAnim(slot1.pos)
		end

		slot0.equipDisc_:RefreshItem(slot0.equipDataList)
	end
end

function slot0.RefreshRightEquipInfo(slot0)
	slot0.equipId_ = slot0.equipList_[slot0.selectPos_]
	slot0.equip_ = slot0.equipId_ ~= 0 and EquipData:GetEquipData(slot0.equipId_) or nil

	if slot0.equip_ then
		slot0.rightEmptyController_:SetSelectedState("notEmpty")
		slot0.equipInfoViewRight_:RefreshData(slot0, slot0.equip_, handler(slot0, slot0.RefreshEquipLock), slot0.params_.heroId, slot0.equip_.equip_id)
		slot0.equipInfoViewRight_:ShowRaceAdd(slot0.equip_.race == HeroCfg[slot0.params_.heroId].race or slot0.equip_.race == slot0.params_.heroId)
	else
		slot0.rightEmptyController_:SetSelectedState("empty")
	end
end

function slot0.RefreshPos(slot0, slot1)
	slot0:HidePopView()

	slot0.lastPos_ = slot0.selectPos_
	slot0.selectPos_ = slot1 or slot0.selectPos_

	slot0.equipDisc_:RotateServant(slot0.lastPos_, slot0.selectPos_)
	slot0:RefreshRightEquipInfo()
end

function slot0.ClickBagItem(slot0, slot1, slot2)
	slot3 = slot1.equip_info

	slot0.equipInfoViewMiddle_:RefreshData(slot0, slot3, handler(slot0, slot0.RefreshEquipLock), slot0.params_.heroId, slot0.heroInfo_.equip[EquipCfg[slot3.prefab_id].pos].equip_id)
	slot0.equipInfoViewMiddle_:ShowRaceAdd(slot3.race == HeroCfg[slot0.params_.heroId].race or slot3.race == slot0.params_.heroId)

	slot0.bagSelectItem_ = slot2

	if slot0.selectSkillItem_ then
		slot0.selectSkillItem_:ShowSelect(false)
	end

	slot0.popController_:SetSelectedState("onlyEquip")
end

function slot0.SkillClick(slot0, slot1, slot2, slot3)
	slot0.equipSkillView_:RefreshData(slot0, slot2)

	slot0.selectSkillItem_ = slot1

	if slot0.bagSelectItem_ then
		slot0.bagSelectItem_:RefreshSelectState2(false)
	end

	slot0.skillInfo_.transform.anchorMin = slot3 and Vector2.New(0, 0) or Vector2.New(1, 0)
	slot0.skillInfo_.transform.anchorMax = slot3 and Vector2.New(0, 1) or Vector2.New(1, 1)
	slot4 = slot3 and slot0.leftPopTrans_ or slot0.rightRootTrans_
	slot0.skillInfo_.transform.pivot = slot4.pivot
	slot0.skillInfo_.transform.anchoredPosition = Vector3.New(slot3 and slot4.anchoredPosition.x + 576 or slot4.anchoredPosition.x - 550, slot4.anchoredPosition.y, 0)

	slot0.popController_:SetSelectedState(slot3 and "equipAndSkill" or "onlySkill")
end

function slot0.RefreshEquipLock(slot0, slot1, slot2)
	slot0.equipBag_:RefreshEquipLock(slot1, slot2)
end

function slot0.OnEquipSwap(slot0, slot1, slot2)
	slot0.heroInfo_ = HeroData:GetHeroData(slot0.params_.heroId)
	slot3 = {
		pos = slot2.pos,
		isShow = slot2.equip_id ~= 0
	}

	if isSuccess(slot1.result) then
		if slot2.equip_id == 0 then
			ShowTips("EQUIP_UNBIND")
		else
			ShowTips("EQUIP_BIND")
		end

		slot0.equipBag_:ClearSelect()
		slot0:RefreshHeroEquipS(slot3)
		slot0.popController_:SetSelectedState("hide")
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnEquipUnloadAll(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		ShowTips("EQUIP_UNBIND")
		slot0:RefreshHeroEquipS()
	else
		ShowTips(slot1.result)
	end
end

function slot0.KeepFilter(slot0)
	slot0.keepFilter_ = true
end

function slot0.HidePopView(slot0)
	slot0.popController_:SetSelectedState("hide")
	slot0.equipInfoViewRight_:DeSelect()
	slot0.equipInfoViewMiddle_:DeSelect()

	if slot0.selectSkillItem_ then
		slot0.selectSkillItem_:ShowSelect(false)

		slot0.selectSkillItem_ = nil
	end

	if slot0.bagSelectItem_ then
		slot0.bagSelectItem_:RefreshSelectState2(false)

		slot0.bagSelectItem_ = nil
	end
end

function slot0.UpdateBar(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:SetGameHelpKey("EQUIP_EQUIP")
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	if not slot0.keepFilter_ then
		slot0.equipBag_:OnExit()
	else
		slot0.keepFilter_ = false
	end

	slot0.selectPos_ = nil

	slot0.equipBag_:ClearSelect()

	slot0.lastPos_ = nil

	slot0:HidePopView()
end

function slot0.Dispose(slot0)
	if slot0.equipBag_ then
		slot0.equipBag_:Dispose()

		slot0.equipBag_ = nil
	end

	if slot0.equipInfoViewRight_ then
		slot0.equipInfoViewRight_:Dispose()

		slot0.equipInfoViewRight_ = nil
	end

	if slot0.equipInfoViewMiddle_ then
		slot0.equipInfoViewMiddle_:Dispose()

		slot0.equipInfoViewMiddle_ = nil
	end

	if slot0.equipSkillView_ then
		slot0.equipSkillView_:Dispose()

		slot0.equipSkillView_ = nil
	end

	if slot0.equipDisc_ then
		slot0.equipDisc_:Dispose()

		slot0.equipDisc_ = nil
	end

	uv0.super.Dispose(slot0)
end

return slot0
