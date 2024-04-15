slot0 = class("V210MusicRewardView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicRewardUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiPop.transform
end

function slot0.Init(slot0)
	slot0.rewardItemList = {}

	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_mask, nil, function ()
		uv0:Back()
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:SwitchBar({})
end

function slot0.OnEnter(slot0)
	slot0.activity_id = slot0.params_.activity_id

	slot0:UpdateMusicRewardList()
end

function slot0.GetState(slot0, slot1)
	for slot6, slot7 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot1]) do
		if ActivityMusicCfg[slot7].difficult == 1 or slot8.difficult == 2 then
			if MusicData:GetRewardState(slot7) == 1 then
				return 1
			elseif MusicData:GetRewardState(slot7) == 2 then
				return -1
			end
		end
	end

	return 0
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	for slot4, slot5 in pairs(slot0.rewardItemList) do
		slot5:Dispose()
	end

	uv0.super.Dispose(slot0)
end

function slot0.GetHeight(slot0, slot1)
	slot3 = 360.90999999999997
	slot4 = {}

	for slot8, slot9 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot1] or {}) do
		if ActivityMusicCfg[slot9] and #ActivityMusicCfg[slot9].reward > 0 then
			table.insert(slot4, slot9)
		end
	end

	if #slot4 == 1 then
		slot3 = slot3 - 130
	end

	return slot3
end

function slot0.UpdateMusicRewardList(slot0)
	slot0.musics = {}

	for slot5, slot6 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityCfg[slot6] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert(slot0.musics, slot6)
		end
	end

	table.sort(slot0.musics, function (slot0, slot1)
		if uv0:GetState(slot0) ~= uv0:GetState(slot1) then
			return slot3 < slot2
		else
			return slot0 < slot1
		end
	end)

	if #slot0.rewardItemList == 0 then
		slot2 = 0

		for slot6, slot7 in pairs(slot0.musics) do
			slot0:CreateRewardItem(slot6)

			slot0.rewardItemList[slot6].transform_.anchoredPosition = Vector2(0, -slot2)
			slot2 = slot2 + slot0:GetHeight(slot7)
		end

		slot0.contentTrs_.sizeDelta = Vector2(1221, slot2)
	end

	for slot5, slot6 in pairs(slot0.musics) do
		slot0:UpdateRewardItem(slot0.rewardItemList[slot5], slot6)
	end
end

function slot0.CreateRewardItem(slot0, slot1, slot2)
	slot3 = GameObject.Instantiate(slot0.songitemGo_, slot0.contentTrs_)

	SetActive(slot3, true)

	slot0.rewardItemList[slot1] = VolumeMusicSongItem.New(slot3)
end

function slot0.UpdateRewardItem(slot0, slot1, slot2)
	if not slot1 or not slot2 then
		return
	end

	slot1:SetData(slot2)
end

function slot0.OnMusicRewardUpdate(slot0)
	for slot4, slot5 in pairs(slot0.musics) do
		slot0:UpdateRewardItem(slot0.rewardItemList[slot4], slot5)
	end
end

return slot0
