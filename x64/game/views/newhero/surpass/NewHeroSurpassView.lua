slot0 = class("NewHeroSurpassView", ReduxView)
slot1 = {
	showPreviewState = {
		name = "showPreview",
		hide = "hide",
		show = "show"
	}
}

function slot0.UIName(slot0)
	return "Widget/System/Hero_transition/HeroPrintUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.OnTop(slot0)
	slot0.surpassInfoView:OnTop()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	SetActive(slot0.root01Go_, false)

	slot0.showPreviewController = slot0.controllerexcollection_:GetController(uv0.showPreviewState.name)
	slot0.turnTableView = HeroSurpassTurntableView.New(slot0, slot0.leftRootGo_)
	slot0.surpassInfoView = HeroSurpassInfoView.New(slot0, slot0.root01Go_)
end

function slot0.ClosePreviewView(slot0)
	JumpTools.Back()
	slot0:IsShowPreviewState(false)
	slot0.turnTableView:AgainPalyNowAni()
end

function slot0.IsShowPreviewState(slot0, slot1)
	if slot1 then
		slot0.showPreviewController:SetSelectedState(uv0.showPreviewState.show)
	else
		slot0.showPreviewController:SetSelectedState(uv0.showPreviewState.hide)
	end
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.overviewbtnBtn_, nil, function ()
		uv0:IsShowPreviewState(true)
		JumpTools.OpenPageByJump("heroSurpassPreview", {
			heroID = uv0.heroID,
			heroInfo = uv0.heroInfo,
			backCallback = function ()
				uv0:ClosePreviewView()
			end
		})
	end)
end

function slot0.OnEnter(slot0)
	slot0:RegistEventListener(CURRENCY_UPDATE, handler(slot0, slot0.OnGoldChange))
	slot0:InitViewCallback()
	slot0:InitData()
	slot0:UpdateAvatarView()
	slot0.surpassInfoView:OnEnter()
	slot0.turnTableView:OnEnter()
end

function slot0.OnGoldChange(slot0, slot1)
	if slot1 == CurrencyConst.CURRENCY_TYPE_GOLD then
		slot0.surpassInfoView:OnGoldChange()
		slot0.turnTableView:OnGoldChange()
	end
end

function slot0.UpdateAvatarView(slot0)
	manager.heroRaiseTrack:SetModelState(slot0.dataProxy:GetHeroUsingSkinInfo(slot0.heroID).id)
end

function slot0.CameraEnter(slot0)
	manager.heroRaiseTrack:SetViewState(HeroRaiseTrackConst.ViewType.heroRaiseCommon, {
		1,
		1
	})
end

function slot0.InitData(slot0)
	slot0.heroID = slot0.params_.heroId
	slot0.dataProxy = HeroViewDataProxy.New(HeroConst.HERO_DATA_TYPE.DEFAULT)
	slot0.heroInfo = slot0.dataProxy:GetHeroData(slot0.heroID)

	slot0.surpassInfoView:SetDataProxy(slot0.dataProxy)
	slot0.surpassInfoView:SetHeroId(slot0.heroID)
	slot0.turnTableView:SetDataProxy(slot0.dataProxy)
	slot0.turnTableView:SetHeroId(slot0.heroID)
end

function slot0.InitViewCallback(slot0)
	slot0.turnTableView:SetInfoShowCallBack(function (slot0)
		SetActive(uv0.root01Go_, true)
		uv0.surpassInfoView:RefreshUi(slot0)
	end)
end

function slot0.ShowlvUpView(slot0)
	slot0.heroInfo = HeroData:GetHeroData(slot0.heroID)

	if HeroStarCfg[slot0.heroInfo.star].phase ~= 0 then
		JumpTools.OpenPageByJump("newHeroSurpassStarUp", {
			starID = slot1,
			heroID = slot0.heroInfo.id,
			dataProxy = slot0.dataProxy
		})
	else
		JumpTools.OpenPageByJump("newHeroSurpassPhaseUp", {
			starID = slot1,
			heroID = slot0.heroInfo.id
		})
	end
end

function slot0.OnHeroStarUp(slot0, slot1, slot2)
	if isSuccess(slot1.result) then
		slot0.turnTableView:RefreshSurpassData()
		slot0:ShowlvUpView()
	else
		ShowTips(slot1.result)
	end
end

function slot0.OnExit(slot0)
	SetActive(slot0.root01Go_, false)

	if slot0.backGround_ then
		manager.resourcePool:DestroyOrReturn(slot0.backGround_, ASSET_TYPE.SCENE)
	end

	slot0:RemoveAllEventListener()
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	if slot0.turnTableView then
		slot0.turnTableView:Dispose()

		slot0.turnTableView = nil
	end

	if slot0.surpassInfoView then
		slot0.surpassInfoView:Dispose()

		slot0.surpassInfoView = nil
	end

	uv0.super.Dispose(slot0)
end

function slot0.InitBackScene(slot0)
	slot0.backGround_ = manager.resourcePool:Get("UI/Common/BackgroundQuad", ASSET_TYPE.SCENE)
	slot0.backGroundTrs_ = slot0.backGround_.transform

	slot0.backGroundTrs_:SetParent(manager.ui.mainCamera.transform)

	slot2, slot3 = nil
	slot2 = GameDisplayCfg.collect_monster_background_pos.value
	slot0.backGroundTrs_.localPosition = Vector3(slot2[1], slot2[2], 10)
	slot0.backGroundTrs_.localEulerAngles = Vector3(0, 0, 0)
	slot4 = GameDisplayCfg.collect_monster_background_pos.scale
	slot0.backGroundTrs_.localScale = Vector3(slot4[1], slot4[2], slot4[3])
	slot0.backGroundTrs_:Find("pic_background1"):GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas(SpritePathCfg.Bg.path .. CameraCfg.enemyFile.pictureName)
end

return slot0
