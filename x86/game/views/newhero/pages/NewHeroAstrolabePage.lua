slot1 = class("NewHeroAstrolabePage", import("game.views.newHero.HeroPageBase"))

function slot1.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot2.transform

	slot0:Init()
end

function slot1.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot1.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.infoSGo_ = {}
	slot0.desItemList = {}
	slot0.isSelfController_ = slot0.controller_:GetController("isSelf")
	slot0.isPreviewController_ = slot0.controller_:GetController("isPreview")
end

function slot1.AddUIListener(slot0)
	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:SetClickAnimaton(true)
	end

	slot0:AddBtnListenerScale(slot0.adjustBtn_, nil, function ()
		JumpTools.OpenPageByJump("/astrolabeAdjust", {
			heroId = uv0.heroInfo_.id,
			selectPos = {
				0
			},
			astrolabe = uv0.astrolabeInfoView_,
			heroProxy = uv0.heroViewProxy_
		})
	end)
end

function slot1.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1

	slot0:UpdateView()
end

function slot1.HideMaskMessage(slot0)
end

function slot1.Show(slot0, slot1)
	slot0.super.Show(slot0)
	slot0:UpdateView()
end

function slot1.IsCanBackAnimation(slot0)
	if gameContext:GetLastOpenPage() ~= "astrolabeAdjust" then
		return false
	end

	if slot0.viewDataType == HeroConst.HERO_DATA_TYPE.PREVIEW then
		return gameContext:IsBack("/heroPreviewChange") > 0
	else
		return gameContext:IsBack("/newHero") > 0
	end
end

function slot1.ShowBackAnimation(slot0)
	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.HeroInfo)
	end
end

function slot1.UpdateView(slot0)
	if slot0.heroInfo_ and slot0.heroViewProxy_ then
		slot0:RefreshAstrolabeInfo()
		slot0:ShowBackAnimation()

		slot0.viewDataType = slot0.heroViewProxy_:GetViewDataType()

		slot0:RefreshAstrolabeEffect()
	end
end

function slot1.SelectItem(slot0, slot1)
	if slot0.heroViewProxy_ and not slot0.heroViewProxy_.notGotoAstrolabeAdjust then
		return
	end

	slot2 = slot1:GetItemInfo()

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:SetClickAnimaton(true)
	end

	JumpTools.OpenPageByJump("/astrolabeAdjust", {
		heroId = slot0.heroInfo_.id,
		selectPos = {
			slot2.posX,
			slot2.posY
		},
		heroProxy = slot0.heroViewProxy_,
		astrolabe = slot0.astrolabeInfoView_
	})
end

function slot1.RefreshAstrolabeInfo(slot0)
	if slot0.heroInfo_ and slot0.heroViewProxy_ then
		slot0.currentHeroID = slot0.heroInfo_ and slot0.heroInfo_.id or 1
		slot1 = false

		if slot0.astrolabeInfoView_ and slot0.lastHeroID ~= slot0.currentHeroID then
			slot1 = true

			slot0.astrolabeInfoView_:OnExit()
		end

		if not slot0.astrolabeInfoView_ then
			slot1 = true
			slot0.astrolabeInfoView_ = manager.heroRaiseTrack.astrolableController
		end

		if slot0.astrolabeInfoView_ then
			if slot1 then
				slot0.astrolabeInfoView_:LoadAstrolabeByPath(AstrolabeTools.GetAstrolabePrafabName(slot0.heroInfo_.id), slot0.heroInfo_.id)

				slot0.lastHeroID = slot0.currentHeroID

				slot0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.none)
			end

			slot0.astrolabeInfoView_:SetNodeNameIsHide(true)
			slot0.astrolabeInfoView_:SetProxy(slot0.heroViewProxy_)
			slot0.astrolabeInfoView_:RegistCallBack(handler(slot0, slot0.SelectItem))
			slot0.astrolabeInfoView_:RefreshData(slot0.heroInfo_, slot0:GetAstrolabeInfo(slot0.heroInfo_.id))
		end

		slot0:UpdateNotice()
	end
end

function slot1.GetHeroAstrolabeInfoView(slot0)
	return HeroAstrolabeInfoView
end

function slot1.GetAstrolabeInfo(slot0, slot1)
	if slot0.heroViewProxy_ then
		return slot0.heroViewProxy_:GetHeroAstrolabeS(slot1)
	end

	return {}
end

function slot1.RefreshAstrolabeEffect(slot0)
	if not slot0.heroInfo_ then
		return
	end

	slot1 = clone(slot0.heroViewProxy_:GetUsingAstrolabe(slot0.heroInfo_.id) or {})

	table.sort(slot1, function (slot0, slot1)
		return slot0 < slot1
	end)

	slot3 = #slot1 > 0
	slot4 = ""

	for slot8 = 1, slot2 do
		if not slot0.desItemList[slot8] then
			slot0.desItemList[slot8] = AstrolabeSuitDesItem.New(Object.Instantiate(slot0.messageGo_, slot0.contentTrs_))
		end

		slot0.desItemList[slot8]:SetProxy(slot0.heroViewProxy_)
		slot0.desItemList[slot8]:SetData(slot1[slot8], slot0.heroInfo_, slot0.viewDataType)
		slot0.desItemList[slot8]:SetActive(true)
	end

	for slot8 = slot2 + 1, #slot0.desItemList do
		slot0.desItemList[slot8]:SetActive(false)
	end

	SetActive(slot0.nullGo_, not slot3)
	TimeTools.StartAfterSeconds(0.1, function ()
		LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.contentTrs_)
	end, {})
end

function slot1.OnTop(slot0)
	slot0:UpdateNotice()

	if slot0.astrolabeInfoView_ then
		slot0.astrolabeInfoView_:RegistCallBack(handler(slot0, slot0.SelectItem))
	end
end

function slot1.UpdateNotice(slot0)
	if slot0.heroViewProxy_.showRedPoint then
		manager.redPoint:bindUIandKey(slot0.adjustBtn_.transform, RedPointConst.ASTROLABE_UNLOCK)
	end
end

function slot1.OnEnter(slot0, slot1, slot2)
	slot0.heroViewProxy_ = slot1
	slot0.isHided = true
	slot0.params_ = slot2

	if slot0.heroViewProxy_:GetViewDataType() ~= HeroConst.HERO_DATA_TYPE.POLYHEDRON then
		slot0.isSelfController_:SetSelectedState(tostring(slot0.heroViewProxy_.isSelf))
	else
		slot0.isSelfController_:SetSelectedState("true")
	end

	slot0.isPreviewController_:SetSelectedState(tostring(slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.PREVIEW))
end

function slot1.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		5,
		0
	})
	manager.heroRaiseTrack:RefreshAstrolabeColor(true)
end

function slot1.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.adjustBtn_.transform)
	slot0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
end

function slot1.Hide(slot0)
	manager.heroRaiseTrack:RefreshAstrolabeColor(false)
	uv0.super.Hide(slot0)
	slot0.astrolabeInfoView_:RefreshAnimationState(AstrolabeConst.AnimationState.Hide)
	HeroTools.StopTalk()
end

function slot1.Dispose(slot0)
	for slot4, slot5 in ipairs(slot0.desItemList or {}) do
		if slot5 then
			slot5:Dispose()
		end
	end

	slot0.desItemList = nil

	uv0.super.Dispose(slot0)
end

return slot1
