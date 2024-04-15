ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("XuHeng3rdDemonHomeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/XuHeng3rdUI/XH3rdMindDemonUI/XuHeng3rdDemonUI"
end

function slot0.Init(slot0)
	slot0:BindCfgUI()
	slot0:AddUIListener()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.goBtn_, nil, function ()
		if not uv0:IsActivityTime() then
			return
		end

		JumpTools.OpenPageByJump("/xuHeng3rddreamDemonChallengeMain", {
			activityId = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelp", {
			icon = "icon_i",
			key = "ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2",
			iconColor = Color(1, 1, 1),
			title = GetTips("STAGE_DESCRIPE"),
			content = GetTips("ACTIVITY_DEMON_CHALLENGE_DESCRIPE_2_2")
		})
	end)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.Show(slot0, slot1)
	SetActive(slot0.gameObject_, slot1)

	if slot1 == true then
		manager.redPoint:bindUIandKey(slot0.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, slot0.activityID_))
		slot0:RegistEventListener(OSIRIS_TASK_UPDATE, slot0.taskUpdateHandler_)
	else
		manager.redPoint:unbindUIandKey(slot0.playBtnTrans_, string.format("%s_%s", RedPointConst.DEMON_CHALLENGE, slot0.activityID_))
		slot0:RemoveAllEventListener()
	end
end

function slot0.RefreshUI(slot0)
end

function slot0.RefreshTimeText(slot0)
	if slot0.timeText_ then
		slot0.timeText_.text = manager.time:GetLostTimeStrWith2Unit(slot0.stopTime_, true)
	end
end

return slot0
