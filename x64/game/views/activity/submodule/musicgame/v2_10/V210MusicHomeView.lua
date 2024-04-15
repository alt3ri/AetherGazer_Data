ActivityMainBasePanel = import("game.views.activity.Main.toggle.ActivityMainBasePanel")
slot0 = class("V210MusicHomeView", ActivityMainBasePanel)

function slot0.GetUIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicHomeUI"
end

function slot0.AddListeners(slot0)
	slot0:AddBtnListener(slot0.m_enterBtn, nil, function ()
		JumpTools.OpenPageByJump("/V210MusicMain", {
			activity_id = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("V210MusicReward", {
			activity_id = uv0.activityID_
		})
	end)
	slot0:AddBtnListener(slot0.descbtnBtn_, nil, function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}
		})
	end)
end

function slot0.OnEnter(slot0)
	MusicData:SetPageActivityId(slot0.activityID_)
	uv0.super.OnEnter(slot0)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activityID_))
	manager.redPoint:bindUIandKey(slot0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0.activityID_))

	slot0.textcontentText_.text = GetTips("ACTIVITY_MUSIC_2_10_CONTENT")
end

function slot0.OnExit(slot0)
	uv0.super.OnExit(slot0)
	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activityID_))
	manager.redPoint:unbindUIandKey(slot0.m_enterBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_OPEN, slot0.activityID_))
end

return slot0
