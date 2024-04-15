slot0 = class("DormHeroChangeSkinView", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/Dorm/ChangeClothesUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnCtor(slot0)
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.skinScroll = LuaList.New(handler(slot0, slot0.indexSkinList), slot0.skinListUilist_, DormHeroSkinItem)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.subtitleBubbleView = SubtitleBubbleView.MuteBubbleSubView.GetInstance()
end

function slot0.OnEnter(slot0)
	slot0.heroID = slot0.params_.heroID
	slot0.heroEID = slot0.params_.heroEID
	slot0.archiveID = DormData:GetHeroArchiveID(slot0.heroID)
	slot0.heroInfo = DormData:GetHeroTemplateInfo(slot0.heroID)
	slot0.skinID = slot0.heroInfo:GetHeroCurSkinID(slot0.heroID)

	slot0:RegisterEvent()
	slot0:RefreshDeriveHero()
	slot0.subtitleBubbleView:OnEnter()
	slot0:RefreshView()
end

function slot0.RefreshView(slot0)
	slot0:RefreshSkinView()
	slot0:UpdataHeroItemState()
end

function slot0.RegisterEvent(slot0)
	slot0:RegistEventListener(DORM_HERO_SKIN_CHANGE, function (slot0)
		uv0.skinID = slot0

		uv0.skinScroll:Refresh()
		uv0:ChangeHeroPrefab(slot0)
	end)
	slot0:RegistEventListener(DORM_REFRESH_HERO_DEPLOY_LIST, function ()
		ShowTips("DORM_CHANGE_DERIVE_SUCCESS")
		uv0:RefreshView()

		uv0.skinID = uv0.heroInfo:GetHeroCurSkinID(uv0.heroID)

		uv0:ChangeHeroPrefab(uv0.skinID)
	end)
end

function slot0.RefreshSkinView(slot0)
	slot0.skinList = {}
	slot0.skinList = DormHeroTools.GetCanUseDormHeroSkinList(slot0.heroID)

	slot0.skinScroll:StartScroll(#slot0.skinList)
end

function slot0.RefreshDeriveHero(slot0)
	if not slot0.heroItemList then
		slot0.heroItemList = {}

		for slot5, slot6 in ipairs(DormHeroTools:GetAllCanUseHeroIDInDorm(slot0.archiveID, true)) do
			slot7 = slot0.heroInfo:GetHeroCurSkinID(slot6)
			slot0.heroItemList[slot5] = DormCircleHeroItem.New(Object.Instantiate(slot0.herohead1Go_, slot0.heroitembgTrs_))

			slot0.heroItemList[slot5]:RefreshUI(slot6, slot0.heroID)
			slot0.heroItemList[slot5]:SetClickCallBack(handler(slot0, slot0.ClickHeroItem))
		end
	end
end

function slot0.ClickHeroItem(slot0, slot1)
	if not HeroTools.GetHeroIsUnlock(slot1) then
		ShowTips("DORM_HERO_LOCK")

		return
	end

	if slot0.heroID == slot1 then
		return
	end

	slot0.heroID = slot1
	slot4 = {}

	for slot9, slot10 in ipairs(DormitoryData:GetDormHerosByArchitecture(DormData:GetCurrectSceneID())) do
		if DormData:GetHeroArchiveID(slot10) ~= DormData:GetHeroArchiveID(slot1) then
			table.insert(slot4, slot10)
		end
	end

	table.insert(slot4, slot1)
	DormAction:DeployHeroInRoom(slot2, slot4, DormEnum.DormDeployType.Place)
end

function slot0.UpdataHeroItemState(slot0)
	if slot0.heroItemList then
		for slot4, slot5 in ipairs(slot0.heroItemList) do
			slot5:RefreshUI(slot5.heroID, slot0.heroID)
		end
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.closeBtn, nil, function ()
		JumpTools.Back(1, {
			heroEID = uv0.heroEID
		})
		Dorm.DormEntityManager.StopAllCmd(uv0.heroEID)
	end)
end

function slot0.indexSkinList(slot0, slot1, slot2)
	slot2:RegisterClickCallBack(function (slot0)
		if uv0.skinID == slot0 then
			return
		end

		DormAction:SetHeroSkin(slot0, DormConst.DORM_CHANGESKIN_TYPE.view)
	end)
	slot2:RefreshUI(slot0.skinList[slot1], slot0.heroID, slot0.skinID)
end

function slot0.ChangeHeroPrefab(slot0, slot1)
	slot3 = nil

	if DormUtils.GetEntityData(slot0.heroEID).cfgID ~= slot1 then
		slot4 = nil
		slot3, slot4 = DormCharacterManager.GetInstance():Generate(slot1, true)

		Dorm.DormEntityManager.PutEntityAt(slot3, slot2, "root")
		DormCharacterManager.FindAndRemove(slot2)

		slot0.heroEID = slot3
	else
		slot3 = slot2
	end

	DormHeroAI:SwitchControl(slot3, DormEnum.ControlType.Player)
	Dorm.DormEntityManager.SetPlayerEntityFaceToCam(slot3, true)
	Dorm.DormEntityManager.SendInteractToEntityCMD(slot3, slot3, false)
	DormUtils.SetEntityInteractContext(slot3, DormCharacterInteractBehaviour.MakeCtxForInternalAction(slot3, slot3, "change_skin_self", {
		onComplete = function (slot0)
		end
	}))

	slot6 = nullable(DormUtils.GetEntityData(slot3), "interactCtx", "dt") or 0
	slot7 = nullable(slot5, "interactCtx", "duration") or 0

	Timer.New(function ()
	end, 1, false, false):Start()
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
	slot0.subtitleBubbleView:OnExit()

	if slot0.heroItemList then
		for slot4, slot5 in pairs(slot0.heroItemList) do
			slot5:Dispose()
		end

		slot0.heroItemList = nil
	end
end

function slot0.Dispose(slot0)
	if slot0.skinScroll then
		slot0.skinScroll:Dispose()

		slot0.skinScroll = nil
	end

	if slot0.heroItemList then
		for slot4, slot5 in ipairs(slot0.heroItemList) do
			slot5:Dispose()
		end
	end

	uv0.super.Dispose(slot0)
end

return slot0
