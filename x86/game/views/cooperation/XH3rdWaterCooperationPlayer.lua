slot1 = class("XH3rdWaterCooperationPlayer", import("game.views.cooperation.CooperationPlayer"))

function slot1.Init(slot0)
	uv0.super.Init(slot0)
	SetActive(slot0.m_heroInfoBtn.gameObject, false)
end

function slot1.GotoTeamInfo(slot0)
	slot0:Go("/xH3rdWaterCooperationTeamInfo", {
		mainActivityID = ActivityCfg.get_id_list_by_sub_activity_list[CooperationData:GetRoomData().activity_id][1]
	})
end

return slot1
