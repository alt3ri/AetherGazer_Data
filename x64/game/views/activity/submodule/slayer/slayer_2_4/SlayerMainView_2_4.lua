slot1 = class("SlayerMainView_2_4", import("game.views.activity.Main.toggle.ActivityMainBasePanel"))

function slot1.GetUIName(slot0)
	return SlayerTools.GetMainUIName(slot0.activityID_ or 0)
end

function slot1.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("slayerRewardView_1_7", {
			slayer_activity_id = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.m_entrustBtn, nil, function ()
		if not ActivityTools.GetActivityIsOpenWithTip(uv0.activityID_, true) then
			return
		end

		JumpTools.OpenPageByJump("/slayerStageView_2_4", {
			init_tag = true,
			slayer_activity_id = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.m_descBtn, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_SLAYER_DESCRIBE",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_SLAYER_DESCRIBE")
		})
	end)
end

function slot1.OnEnter(slot0)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.activityID_))
end

function slot1.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REWARD, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.m_entrustBtn.transform, string.format("%s_%s", RedPointConst.SLYAER_REGIONS, slot0.activityID_))
end

function slot1.RefreshTimeText(slot0)
	if slot0.m_timeLab then
		slot0.m_timeLab.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_, true)
	end
end

return slot1
