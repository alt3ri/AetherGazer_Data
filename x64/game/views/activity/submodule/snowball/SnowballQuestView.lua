slot0 = class("SnowballQuestView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_6/JapanRegionSnowballUI/SnowballQuestPopup"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot1(slot0)
	return AssignmentCfg[slot0.id].type == TaskConst.TASK_TYPE.SNOWBALL_TASK_CHALLENGE
end

function slot0.Init(slot0)
	slot0:BindCfgUI()

	slot0.questSubView = ActivityQuestSubView.New(slot0.gameObject_, SnowballGameData.activityID, uv0, SnowballQuestItem, true)

	slot0:AddBtnListener(slot0.maskBtn_, nil, JumpTools.Back)
end

function slot0.OnEnter(slot0)
	slot0.questSubView:OnEnter()
end

function slot0.OnExit(slot0)
	slot0.questSubView:OnExit()
end

function slot0.OnTop(slot0)
end

function slot0.OnBehind(slot0)
end

function slot0.Dispose(slot0)
	slot0.questSubView:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
