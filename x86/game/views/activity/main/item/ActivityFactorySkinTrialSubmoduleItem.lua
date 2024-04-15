ActivitySubmoduleItem = import("game.views.activity.Main.item.ActivitySubmoduleItem")
slot0 = class("ActivityFactorySkinTrialSubmoduleItem", ActivitySubmoduleItem)

function slot0.Ctor(slot0, slot1, slot2)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform
	slot0.activityId_ = slot2
	slot0.theme_ = ActivityTools.GetActivityTheme(slot0.activityId_)
	slot0.refreshSkinTrialBtnHandler = handler(slot0, slot0.RefreshSkinTrialBtn)

	slot0:InitUI()
end

function slot0.OnEnter(slot0)
	manager.notify:RegistListener(SKIN_TRIAL_UPDATE, slot0.refreshSkinTrialBtnHandler)
	slot0:RefreshSkinTrialBtn()
	slot0.super.OnEnter(slot0)
end

function slot0.OnExit(slot0)
	slot0.super.OnExit(slot0)
	manager.notify:RemoveListener(SKIN_TRIAL_UPDATE, slot0.refreshSkinTrialBtnHandler)
end

function slot0.RefreshSkinTrialBtn(slot0)
	slot1 = nil

	for slot5, slot6 in ipairs(ActivityCfg.get_id_list_by_activity_template[ActivityTemplateConst.SKIN_TRIAL]) do
		if ActivityData:GetActivityIsOpen(slot6) and ActivityTools.GetActivityTheme(slot6) == slot0.theme_ then
			slot0.activityId_ = slot6
		end
	end

	if manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.FACTORY_SKIN_TRIAL_1_OVERSEA)) or manager.redPoint:getTipBoolean(string.format("%s_%s", RedPointConst.SKIN_TRIAL, ActivityConst.FACTORY_SKIN_TRIAL_2_OVERSEA)) then
		manager.redPoint:SetRedPointIndependent(slot0.transform_, true)
	else
		manager.redPoint:SetRedPointIndependent(slot0.transform_, false)
	end
end

function slot0.BindRedPoint(slot0)
end

function slot0.UnBindRedPoint(slot0)
end

return slot0
