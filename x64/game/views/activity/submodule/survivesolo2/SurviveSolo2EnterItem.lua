slot0 = class("SurviveSolo2EnterItem", ReduxView)

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

	slot0.typeCon_ = ControllerUtil.GetController(slot0.transform_, "type")
	slot0.stateCon_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.clearCon_ = ControllerUtil.GetController(slot0.transform_, "clear")
end

function slot0.AddUIListeners(slot0)
	slot0:AddBtnListener(slot0.btn_, nil, function ()
		if manager.time:GetServerTime() < uv0.startTime_ then
			ShowTips(string.format(GetTips("OPEN_TIME"), manager.time:GetLostTimeStr(uv0.startTime_)))
		elseif uv0.stopTime_ <= slot0 then
			ShowTips("TIME_OVER")
		else
			manager.redPoint:setTip(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. uv0.activityID_, 0)

			slot1 = {
				isSorted = true,
				isHideEffect = true,
				section = ActivitySoloSlayerCfg[uv0.activityID_].stage_id,
				sectionType = BattleConst.STAGE_TYPE_NEW.SURVIVE_SOLO,
				activityID = uv0.activityID_
			}
			slot4 = {}
			slot5 = {}

			if ActivitySoloSlayerCfg[uv0.activityID_].limit_type[1] == 1 then
				table.insert({}, slot2.limit_type[2])
			elseif slot6 == 2 then
				table.insert(slot4, slot2.limit_type[2])

				slot1.recommend_type = slot2.limit_type[2]
			elseif slot6 == 3 then
				table.insert(slot5, slot2.limit_type[2])
			end

			HeroData:SaveSortValue(false, 0, slot5, slot4, slot3)
			uv0:Go("/sectionSelectHero", slot1)
		end
	end)
end

function slot0.RefreshData(slot0, slot1, slot2)
	slot0.mainActivityID_ = slot1
	slot0.activityID_ = slot2
	slot0.activityData_ = ActivityData:GetActivityData(slot0.activityID_)
	slot0.startTime_ = slot0.activityData_.startTime
	slot0.stopTime_ = slot0.activityData_.stopTime

	slot0:RefreshUI()
end

function slot0.RefreshTime(slot0, slot1)
	if slot1 < slot0.startTime_ then
		slot0.stateCon_:SetSelectedState("off")

		slot0.timeLable_.text = GetTips("SOLO_NOT_OPEN")
	elseif slot1 < slot0.stopTime_ then
		slot0.stateCon_:SetSelectedState("on")

		slot0.timeLable_.text = manager.time:GetLostTimeStr2(slot0.stopTime_)
	else
		slot0.stateCon_:SetSelectedState("off")

		slot0.timeLable_.text = GetTips("TIME_OVER")
	end
end

function slot0.RefreshUI(slot0)
	slot0.levelText_.text = BattleSoloSlayerCfg[ActivitySoloSlayerCfg[slot0.activityID_].stage_id].name

	slot0.clearCon_:SetSelectedState(SurviveSoloData:GetData(slot0.activityID_) and slot1.time > 0 and "true" or "false")
	slot0.typeCon_:SetSelectedState(ActivitySoloSlayerCfg[slot0.activityID_].limit_type[2])
	SetActive(slot0.redGo_, manager.redPoint:getTipValue(RedPointConst.SOLO_SURVIVE_OPEN .. "_" .. slot0.activityID_) > 0)
end

function slot0.OnExit(slot0)
	slot0:RemoveAllEventListener()
end

function slot0.Dispose(slot0)
	slot0:RemoveAllListeners()
	slot0.super.Dispose(slot0)
end

return slot0
