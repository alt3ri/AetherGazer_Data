slot0 = class("IdolTraineeBattleComparePop", ReduxView)

function slot0.UIName(slot0)
	return "Widget/BackHouseUI/IdolTrainee/IdolPropertyComparePopup"
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

	slot0.myInfoView = IdolTraineeTrainInfoPage.New(slot0.player1Info_, handler(slot0, slot0.ChangeContentProperty), handler(slot0, slot0.ChangeContentSkill))
	slot0.enemyInfoView = IdolTraineeTrainInfoPage.New(slot0.player2Info_, handler(slot0, slot0.ChangeContentProperty), handler(slot0, slot0.ChangeContentSkill))
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.maskBtn_, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnEnter(slot0)
	slot0.userID = slot0.params_.userID
	slot0.friendType = slot0.params_.friendType
	slot0.stageID = slot0.params_.stageID
	slot1, slot0.curHeroID_ = IdolTraineeData:GetCurAttackHeroInfo()

	slot0.myInfoView:RefreshUI(IdolTraineeTools:GetHeroBattleInfoTemplate(slot0.curHeroID_))
	slot0.enemyInfoView:RefreshUI(IdolTraineeTools:GetHeroBattleInfoTemplate(nil, slot0.userID, slot0.friendType, slot0.stageID))
end

function slot0.ChangeContentProperty(slot0)
	slot0.myInfoView:ChangeContent(1)
	slot0.enemyInfoView:ChangeContent(1)
end

function slot0.ChangeContentSkill(slot0)
	slot0.myInfoView:ChangeContent(2)
	slot0.enemyInfoView:ChangeContent(2)
end

function slot0.Dispose(slot0)
	slot0.myInfoView:Dispose()
	slot0.enemyInfoView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
