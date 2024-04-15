slot0 = class("ActivityHeroEnhanceTalentDetailView", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:InitUI()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()

	slot0.talentItem_ = ActivityHeroEnhanceTalentItem.New(slot0.talentGo_)
	slot0.useController_ = slot0.controller_:GetController("use")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.useBtn_, nil, function ()
		if uv0.onClickBtnHandler_ then
			uv0.onClickBtnHandler_(true, uv0.talentId_)
		end
	end)
	slot0:AddBtnListener(slot0.dropBtn_, nil, function ()
		if uv0.onClickBtnHandler_ then
			uv0.onClickBtnHandler_(false, uv0.talentId_)
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.OnExit(slot0)
end

function slot0.SetData(slot0, slot1, slot2)
	slot0.activityId_ = slot1
	slot0.talentId_ = slot2
end

function slot0.SetClickBtnHandler(slot0, slot1)
	slot0.onClickBtnHandler_ = slot1
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.activityId_
	slot2 = slot0.talentId_

	slot0.talentItem_:SetData(slot1, slot2)
	slot0.talentItem_:RefreshUI()

	slot0.descText_.text = GetI18NText(TalentTreeCfg[slot2].desc)

	if ActivityHeroEnhanceTools.GetTalentLockConditionId(slot1, slot2) then
		slot0.useController_:SetSelectedState("lock")

		slot0.lockText_.text = ConditionCfg[slot4].desc
	else
		slot0.useController_:SetSelectedState(ActivityHeroEnhanceData:IsTalentActivated(slot1, slot2) and "used" or "use")
	end
end

function slot0.Dispose(slot0)
	slot0.talentItem_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
