slot0 = class("ActivityEntraceItem", ReduxView)

function slot0.Ctor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:BindCfgUI()
	slot0:AddListeners()
end

function slot0.OnEnter(slot0)
	if JumpTools.GetLinkIsLocked(ActivityEntraceCfg[slot0.activityID_].jump_system) then
		SetActive(slot0.redPointGo_, false)
	else
		SetActive(slot0.redPointGo_, true)
	end

	manager.redPoint:bindUIandKey(slot0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0.activityID_))
	slot0:RefreshUI()
end

function slot0.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.redPointGo_.transform, string.format("%s%s", RedPointConst.MAIN_ACTIVITY, slot0.activityID_))
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)

	slot0.transform_ = nil
	slot0.gameObject_ = nil
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.button_, nil, function ()
		if getData("SDK", "btn_homepage_activity" .. uv0.activityID_) == nil or not TimeMgr:IsSameDay(slot1, TimeMgr:GetServerTime()) then
			saveData("SDK", slot0, TimeMgr:GetServerTime())
			OperationRecorder.RecordButtonTouch("homepage_activity_" .. uv0.activityID_)
		end

		slot3 = ActivityEntraceCfg[uv0.activityID_]

		ActivityVersionData:SetReprintField(slot3.reprint_field)
		JumpTools.JumpToPage2(slot3.jump_system)
	end)
end

function slot0.SetData(slot0, slot1)
	if slot0.activityID_ then
		slot0:OnExit()
	end

	slot0.activityID_ = slot1

	slot0:OnEnter()
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityEntraceCfg[slot0.activityID_]
	slot3 = slot2.icon

	if ActivityData:GetActivityData(slot0.activityID_).startTime + slot2.delay_day * 24 * 3600 < manager.time:GetServerTime() then
		slot3 = slot2.icon2
	end

	slot0.image_.sprite = getSpriteViaConfig("ActivityBannerTextures", slot3 .. SettingData:GetCurrentLanguageKey())
end

return slot0
