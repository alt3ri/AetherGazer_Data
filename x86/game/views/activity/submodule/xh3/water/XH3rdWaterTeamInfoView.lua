slot1 = class("XH3rdWaterTeamInfoView", import("game.views.heroTeamInfo.HeroTeamInfoBaseView"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	slot0.filterView_:SetExtraSorter(handler(slot0, slot0.WaterSorter))
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	SetActive(slot0.filterGo_, false)
end

function slot1.RefreshInfoBtn(slot0)
	uv0.super.RefreshInfoBtn(slot0)
	SetActive(slot0.infoBtn_.gameObject, false)
end

function slot1.WaterSorter(slot0, slot1, slot2, slot3, slot4)
	return true, slot1.id < slot2.id
end

function slot1.ChangeTeam(slot0, slot1, slot2)
	SetHeroTeam(slot0.params_.stageType, slot0.params_.stageID, slot0.params_.activityID, slot1, slot2)
	ActivityWaterData:SetHeroTeam(ActivityWaterData:GetCurrentSchedule(slot0.params_.mainActivityID).selected_contestant_id, slot2)
end

function slot1.GetHeroList(slot0)
	return {}
end

return slot1
