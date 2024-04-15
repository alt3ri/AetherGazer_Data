slot0 = class("ActivityHeroLetterItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot0.gameObject_.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListeners()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.lockCon_ = slot0.conCollecter_:GetController("lock")
	slot0.rewardCon_ = slot0.conCollecter_:GetController("reward")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		manager.redPoint:setTip(RedPointConst.ACTIVITY_HERO_LETTER_UNCOMPLETE .. "_" .. uv0.activityID_, 0)

		if uv0.startTime_ <= manager.time:GetServerTime() and slot0 < uv0.stopTime_ then
			JumpTools.OpenPageByJump("/activityHeroLetterTask", {
				id = uv0.id_,
				activityID = uv0.cfg_.main_activity_id
			})
		end
	end)
end

function slot0.OnEnter(slot0)
end

function slot0.Refresh(slot0, slot1)
	slot0.id_ = slot1
	slot0.cfg_ = ActivityHeroTaskCfg[slot0.id_]

	slot0:RefreshData()
	slot0:RefreshUI()
end

function slot0.RefreshData(slot0)
	slot0.activityID_ = slot0.cfg_.activity_id
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime
end

function slot0.RefreshUI(slot0)
	slot1 = slot0.cfg_.hero_id
	slot0.name_.text = HeroCfg[slot1].suffix
	slot0.icon_.sprite = getSpriteWithoutAtlas(SpritePathCfg.HeroIcon.path .. slot1)

	if ActivityHeroLetterTools.IsReward(slot0.id_) then
		slot0.rewardCon_:SetSelectedState("on")
	else
		slot0.taskID_ = slot0.cfg_.task_id

		if TaskData2:GetTask(slot0.taskID_) and AssignmentCfg[slot0.taskID_].need <= slot4.progress then
			slot0.rewardCon_:SetSelectedState("off")
		else
			slot0.rewardCon_:SetSelectedState("none")
		end
	end

	SetActive(slot0.redGo_, manager.redPoint:getTipValue(RedPointConst.ACTIVITY_HERO_LETTER_ITEM .. "_" .. slot0.activityID_) > 0)
end

function slot0.RefreshTime(slot0, slot1)
	if slot1 < slot0.startTime_ then
		slot0.lockCon_:SetSelectedState("off")

		slot0.timeLable_.text = string.format(GetTips("UNLOCK"), manager.time:GetLostTimeStr2(slot0.startTime_))
	elseif slot0.stopTime_ <= slot1 then
		slot0.lockCon_:SetSelectedState("off")

		slot0.timeLable_.text = GetTips("TIME_OVER")
	else
		slot0.lockCon_:SetSelectedState("on")
	end
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
