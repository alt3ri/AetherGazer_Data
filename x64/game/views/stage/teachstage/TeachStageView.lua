slot0 = class("TeachStageView", ReduxView)
slot1 = {
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING,
		redConst = RedPointConst.TEACH_BASE
	},
	{
		battleConst = BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING,
		redConst = RedPointConst.TEACH_CHARACTER
	}
}

function slot0.UIName(slot0)
	return "Widget/System/Teachinglevel/TeachinglevelUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0.switchBtn_ = {}
	slot0.contentView_ = {}

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})

	slot4 = "TEACH_STAGE_DESC"

	manager.windowBar:SetGameHelpKey(slot4)

	for slot4 = 1, 2 do
		slot0:AddBtnListener(slot0[string.format("btnTab%s_", slot4)], nil, function ()
			uv0:SelectTab(uv1)
		end)
	end

	slot1 = slot0.params_.switchType or BattleTeachData:GetSwitchType()

	BattleTeachData:SetSwitchType(slot1)

	slot0.lastSwitchType_ = slot1
	slot2 = 1

	for slot6, slot7 in ipairs(uv0) do
		if slot7.battleConst == slot1 then
			slot2 = slot6
		end

		manager.redPoint:bindUIandKey(slot0[string.format("buttle0%sTrs_", slot6)].transform, slot7.redConst)
	end

	slot0:SelectTab(slot2)
end

function slot0.SelectTab(slot0, slot1)
	slot0:OnGroupSelect(slot1)
	slot0.tabControl:SetSelectedState(string.format("state%s", slot1))
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
end

function slot0.OnUpdate(slot0)
	if slot0.lastSwitchType_ ~= BattleTeachData:GetSwitchType() then
		slot0.lastSwitchType_ = BattleTeachData:GetSwitchType()

		slot0:SwitchPage(slot0.lastSwitchType_, false)
	end

	slot0.contentView_[slot0.lastSwitchType_]:OnUpdate()
end

function slot0.OnClickTeachViewBtn(slot0)
	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnClickTeachViewBtn()
	end
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:OnExit()
	end

	for slot4, slot5 in ipairs(uv0) do
		manager.redPoint:unbindUIandKey(slot0[string.format("buttle0%sTrs_", slot4)].transform)
	end
end

function slot0.Dispose(slot0)
	slot0:RemoveListeners()

	for slot4, slot5 in pairs(slot0.contentView_) do
		slot5:Dispose()
	end

	slot0.contentView_ = nil
	slot0.basePanel_ = nil
	slot0.heroPanel_ = nill

	uv0.super.Dispose(slot0)
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.tabControl = slot0.tabControllerexcollection_:GetController("select")
	slot0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING] = TeachStageBaseView.New(slot0.basePanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_BASE_TEACHING)
	slot0.contentView_[BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING] = TeachStageHeroView.New(slot0.heroPanel_, BattleConst.STAGE_TYPE_NEW.STAGE_TYPE_HERO_TEACHING)
end

function slot0.RemoveListeners(slot0)
end

function slot0.OnGroupSelect(slot0, slot1)
	if uv0[slot1].battleConst == slot0.switchType_ and not slot0.params_.heroID then
		return
	end

	slot0:SwitchPage(slot2, slot0.params_.isBack)
	BattleTeachData:SetSwitchType(slot0.switchType_)

	slot7 = {
		switchType = slot0.switchType_
	}

	slot0:Go("teachStage", slot7)

	slot6 = CLICK_TEACH_BTN

	manager.notify:CallUpdateFunc(slot6)

	for slot6, slot7 in pairs(slot0.contentView_) do
		slot7:OnEnter()
	end
end

function slot0.GetCurView(slot0)
	if slot0.contentView_[slot0.switchType_] then
		return slot0.contentView_[slot0.switchType_]
	end
end

function slot0.SwitchPage(slot0, slot1, slot2)
	slot0.switchType_ = slot1

	if slot1 == 12 then
		OperationRecorder.Record("teachStage", "base")
	elseif slot1 == 13 then
		OperationRecorder.Record("teachStage", "role")
	end

	for slot6, slot7 in pairs(slot0.contentView_) do
		slot7:SwitchPageUI(slot1, slot0.params_.heroID, slot2 ~= true)
	end

	slot0.params_.heroID = nil
end

return slot0
