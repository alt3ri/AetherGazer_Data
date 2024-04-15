slot0 = class("HeroEquipPage", HeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.detailController_ = slot0.controller_:GetController("detail")
	slot0.isSelfController_ = slot0.controller_:GetController("isSelf")
	slot0.skillPopController_ = slot0.controller_:GetController("skill")
	slot0.equipDisc_ = EquipDisc.New(slot0.discGo_)

	slot0.equipDisc_:RegistItemButton(handler(slot0, slot0.OnClickItem))

	slot0.equipInfo_ = EquipInfoView.New(slot0.equipInfoGo_)

	slot0.equipInfo_:RegisterSkillClick(handler(slot0, slot0.SkillClick))
	slot0.equipInfo_:RegistHeroButton(handler(slot0, slot0.GoEquipBag), handler(slot0, slot0.GoEquipCulture))

	slot0.equipOverrall_ = EquipOverall.New(slot0.rightGo_)

	slot0.equipOverrall_:RegistSkillClick(handler(slot0, slot0.SkillClick))

	slot0.equipSkillPop_ = EquipNewSkillInfoView.New(slot0.equipSkillGo_)
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.btnPopMask_, nil, function ()
		uv0:HideMaskMessage()
	end)
	slot0:AddBtnListener(slot0.btnUnload_, nil, function ()
		slot0 = false

		for slot5, slot6 in ipairs(uv0.heroViewProxy_:GetEquipInfoList(uv0.heroInfo_.id) or {}) do
			if slot6.equip_id ~= 0 then
				slot0 = true

				break
			end
		end

		if not slot0 then
			ShowTips("ERROR_EQUIP_NOT")

			return
		end

		if not _G.SkipTip.SkipUninstallEquipTip and SettingData:GetRemindSettingData().uninstall_equip_reminder == 1 then
			ShowMessageBox({
				title = GetTips("PROMPT"),
				content = GetTips("EQUIP_ONE_CLICK_UNINSTALL_WARNING"),
				OkCallback = function ()
					_G.SkipTip.SkipUninstallEquipTip = uv0.SkipUninstallEquipTip

					HeroAction.EquipUnloadAll(uv0.heroInfo_.id)
				end,
				ToggleCallback = function (slot0)
					uv0.SkipUninstallEquipTip = slot0
				end
			})
		else
			HeroAction.EquipUnloadAll(uv0.heroInfo_.id)
		end
	end)
	slot0:AddBtnListener(slot0.btnOption_, nil, function ()
		uv0.isGoSubPanel = true

		uv0:Go("/EquipProposal", {
			heroID = uv0.heroInfo_.id,
			proxy = uv0.heroViewProxy_
		})
	end)
	slot0:AddBtnListener(slot0.mask_, nil, function ()
		uv0.detailController_:SetSelectedState("false")
		uv0.equipDisc_:Reset()
	end)
end

function slot0.CheckLocked(slot0)
	slot0.equipInfo_:CheckLocked()
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1

	slot0.detailController_:SetSelectedState("false")
	slot0.equipDisc_:Reset()
end

function slot0.UpdateView(slot0)
	slot0:RefreshEquipDisc()
	slot0.equipOverrall_:RefreshHeroInfo(slot0.heroInfo_)
	slot0.equipInfo_:RefreshData(slot0, slot1, nil, slot0.heroInfo_.id, slot0.equipDataList_[slot0.enterIndex_] and slot1.equip_id or 0)
	slot0:PlayAnim()
end

function slot0.OnClickItem(slot0, slot1, slot2)
	slot0.enterIndex_ = slot2

	if slot1 and slot1.equip_id ~= 0 then
		slot0.equipInfo_:RefreshData(slot0, slot1, nil, slot0.heroInfo_.id, slot1.equip_id)
		slot0.detailController_:SetSelectedState("true")
	else
		if not slot0.heroViewProxy_.isSelf then
			return
		end

		slot0:GoEquipBag()
	end
end

function slot0.SkillClick(slot0, slot1, slot2)
	slot0.equipSkillPop_:RefreshData(slot0, slot2, slot0.detailController_:GetSelectedState() == "false")
	slot0.skillPopController_:SetSelectedState("show")
end

function slot0.RefreshEquipDisc(slot0)
	if slot0.heroInfo_ then
		slot0.heroEquipList_ = slot0.heroViewProxy_:GetEquipInfoList(slot0.heroInfo_.id)
		slot0.equipDataList_ = slot0.heroViewProxy_:GetEquipDataList(slot0.heroInfo_.id)

		slot0.equipDisc_:RefreshItem(slot0.equipDataList_)
	end
end

function slot0.GoEquipBag(slot0)
	slot0.isGoSubPanel = true

	slot0:Go("/heroEquipBag", {
		isOpenInfo = false,
		heroId = slot0.heroInfo_.id,
		suitPos = slot0.enterIndex_,
		proxy = slot0.heroViewProxy_
	})
end

function slot0.GoEquipCulture(slot0)
	if slot0.heroEquipList_[slot0.enterIndex_] and slot1.equip_id ~= 0 then
		slot0.isGoSubPanel = true

		slot0:Go("/equipCultureView", {
			pageIndex = 2,
			rotateAnim = true,
			equipId = slot1.equip_id,
			proxy = slot0.heroViewProxy_
		})
	else
		ShowTips("NO_EQUIP")
	end
end

function slot0.HideMaskMessage(slot0)
	slot0.skillPopController_:SetSelectedState("hide")
	slot0.equipOverrall_:DeSelect()
	slot0.equipInfo_:DeSelect()
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		4,
		0
	})
end

function slot0.OnEnter(slot0, slot1)
	slot0:HideMaskMessage()

	slot0.heroViewProxy_ = slot1

	slot0.equipOverrall_:OnEnter(slot1)
	slot0.equipInfo_:OnEnter(slot1)
	slot0.equipDisc_:OnEnter({
		isShowDetail = true
	})
	slot0.isSelfController_:SetSelectedState(tostring(slot0.heroViewProxy_.isSelf))
	slot0:RegistEventListener(HERO_DATA_MODIFY, handler(slot0, slot0.UpdateView))
	slot0:CheckLocked()

	slot0.enterIndex_ = slot0.enterIndex_ or 1
end

function slot0.Show(slot0)
	uv0.super.Show(slot0)
	SetActive(slot0.gameObject_, true)
	slot0:UpdateView()
end

function slot0.PlayAnim(slot0)
	slot0.equipDisc_:PlayAnim(slot0.isGoSubPanel)

	slot0.isGoSubPanel = false
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0.equipOverrall_:OnExit()
end

function slot0.Dispose(slot0)
	slot0.equipSkillPop_:Dispose()
	slot0.equipInfo_:Dispose()
	slot0.equipDisc_:Dispose()
	slot0.equipOverrall_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
