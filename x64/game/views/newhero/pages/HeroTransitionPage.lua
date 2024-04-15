slot0 = class("HeroTransitionPage", HeroPageBase)

function slot0.OnCtor(slot0, slot1, slot2)
	slot0.handler_ = slot1
	slot0.gameObject_ = slot2
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.transitionDiscView_ = TransitionSkillSlotsModule.New(slot0.transitionDiscGo_)
	slot0.transitionDetailInfoView_ = HeroTransitionDetailInfoView.New(slot0.detailInfoViewGo_)
	slot0.transitionSimpleInfoView_ = HeroTransitionSimpleInfoView.New(slot0.simpleInfoViewGo_)
	slot0.infoController_ = slot0.controller_:GetController("info")

	slot0:InitModule()
end

function slot0.InitModule(slot0)
	slot0.transitionDiscView_:LockJumpAnim(true)
	slot0.transitionDiscView_:LockSelect(false)
	slot0.transitionDiscView_:SetShowLocked(false)
	slot0.transitionDiscView_:RegisterSlotClickCallback(function (slot0)
		uv0.selectInfo_ = slot0

		uv0.transitionDetailInfoView_:SetSlotInfo(slot0)
		uv0.infoController_:SetSelectedState("detail")
	end)
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0.infoController_:SetSelectedState("simple")
		uv0.transitionDiscView_:ClearSelect()
	end)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		7,
		0
	})
end

function slot0.OnEnter(slot0, slot1)
	slot0.infoController_:SetSelectedState("simple")

	slot0.heroViewProxy_ = slot1
	slot0.type_ = slot0.heroViewProxy_:GetViewDataType()

	slot0.transitionSimpleInfoView_:OnEnter(slot1)
	slot0.transitionDetailInfoView_:OnEnter(slot1)
	slot0:RegistEventListener(HERO_TRANSITION_CHANGE, function (slot0)
		if slot0.heroId == uv0.heroInfo_.id then
			uv0:UpdateView()
		end
	end)
end

function slot0.SetHeroInfo(slot0, slot1)
	slot0.heroInfo_ = slot1
	slot0.heroID_ = slot1.id

	slot0.transitionSimpleInfoView_:SetHeroInfo(slot1)
	slot0.transitionDetailInfoView_:SetHeroInfo(slot1)

	slot0.isAdd_ = HeroTools.GetHeroEquipSkillAddLevel(slot0.heroInfo_)

	slot0.infoController_:SetSelectedState("simple")
	SetActive(slot0.changeBtnGo_, slot0.heroViewProxy_:GetViewDataType() == HeroConst.HERO_DATA_TYPE.DEFAULT)
end

function slot0.UpdateView(slot0)
	slot0.transitionSimpleInfoView_:UpdateView()
	slot0.transitionDetailInfoView_:UpdateView()
	slot0.transitionDiscView_:RenderView({
		needRefresh = true,
		heroID = slot0.heroID_,
		proxy = slot0.heroViewProxy_
	})
	slot0.transitionDiscView_:RenderLock()
end

function slot0.Show(slot0)
	uv0.super.Show(slot0)
	slot0:UpdateView()
end

function slot0.OnTop(slot0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0.transitionDiscView_:Dispose()
	slot0.transitionDetailInfoView_:Dispose()
	slot0.transitionSimpleInfoView_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
