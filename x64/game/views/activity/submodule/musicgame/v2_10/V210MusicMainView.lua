slot0 = class("V210MusicMainView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicMainUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()

	slot0.pageIndex = 1
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.list_ = LuaList.New(handler(slot0, slot0.IndexItem), slot0.m_list, V210MusicMainItem)
	slot0.lockController = ControllerUtil.GetController(slot0.transform_, "lock")
	slot0.openToggleController = ControllerUtil.GetController(slot0.toggleTrs_, "open")
	slot0.useShowToggleController = ControllerUtil.GetController(slot0.toggleTrs_, "useShow")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_rewardBtn, nil, function ()
		JumpTools.OpenPageByJump("V210MusicReward")
	end)
	slot0:AddBtnListener(slot0.m_settingBtn, nil, function ()
		JumpTools.OpenPageByJump("/V210MusicSetting")
	end)
	slot0:AddBtnListener(slot0.m_palyBtn, nil, function ()
		slot0 = uv0.musics[uv0.pageIndex]

		MusicAction.Play(ActivityMusicCfg.get_id_list_by_activity_id[slot0][MusicData:GetDifficultyIndex(slot0) + 1])
	end)
	slot0:AddBtnListener(slot0.nowmusicBtn_, nil, function ()
		uv0:UpdateMusicListShow(0)
	end)
	slot0:AddBtnListener(slot0.backmusicBtn_, nil, function ()
		uv0:UpdateMusicListShow(1)
	end)
	slot0:AddBtnListener(slot0.togglebtnBtn_, nil, function ()
		uv0.openToggleController:SetSelectedIndex(uv0.openToggleController:GetSelectedState() == "true" and 0 or 1)
	end)
	slot0:AddBtnListener(slot0.togglerootclosebtnBtn_, nil, function ()
		uv0.openToggleController:SetSelectedIndex(0)
	end)
	slot0.list_:SetPageChangeHandler(handler(slot0, slot0.OnPageChange))
	slot0.m_scroller.onValueChanged:AddListener(function ()
		uv0:OnScrollerMove()
	end)
end

function slot0.GetScrollContentValue(slot0)
	return -slot0.contentTrs_.anchoredPosition.x / 1182 + 1
end

function slot0.OnScrollerMove(slot0)
	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:MoveAniEffect(slot0:GetScrollContentValue())
	end
end

function slot0.OnTop(slot0)
	slot1 = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}

	manager.windowBar:SwitchBar({
		BACK_BAR,
		HOME_BAR,
		INFO_BAR
	})
	manager.windowBar:RegistInfoCallBack(function ()
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = uv0
		})
	end)
end

function slot0.UpdateMusicListShow(slot0, slot1)
	if (slot0.useShowToggleController:GetSelectedState() == "false" and 0 or 1) == slot1 then
		return
	end

	slot0.openToggleController:SetSelectedIndex(0)
	slot0:UpdateMusicDataByActId(slot1 == 1)
end

function slot0.UpdateMusicDataByActId(slot0, slot1)
	slot0.useShowToggleController:SetSelectedIndex(slot1 and 1 or 0)

	slot0.musics = {}

	for slot7, slot8 in ipairs(ActivityCfg[slot0.activity_id].sub_activity_list) do
		if ActivityCfg[slot8] and ActivityTemplateConst.ACTIVITY_MUSIC_GAME then
			table.insert({}, slot8)
		end
	end

	if slot1 then
		slot4 = {
			[slot9] = true
		}

		for slot8, slot9 in pairs(slot3) do
			-- Nothing
		end

		for slot8, slot9 in pairs(ActivityMusicCfg.get_id_list_by_activity_id) do
			if not slot4[slot8] then
				table.insert(slot0.musics, slot8)
			end
		end

		table.sort(slot0.musics, function (slot0, slot1)
			return slot0 < slot1
		end)
	else
		slot0.musics = slot3
	end

	slot0.isLookBack = slot1

	slot0.list_:StartScroll(#slot0.musics, slot0.pageIndex, true, false)
	slot0.list_:SwitchToPage(slot0.pageIndex)
	slot0.musicmainuiAni_:Play("MusicGameUI 1", 0, 0)
end

function slot0.OnEnter(slot0)
	if SettingData:GetSoundSettingData() and slot1.music then
		manager.audio:SetVolume("music", slot1.music / 100)
	end

	slot0.activity_id = slot0.params_.activity_id
	slot0.isLookBack = slot0.isLookBack or MusicData:GetLookBackState()
	slot0.pageIndex = MusicData:GetSelectIndex(slot0.activity_id)

	slot0:UpdateMusicDataByActId(slot0.isLookBack)

	slot0.BGMID = 0
	slot2 = slot0.musics[slot0.pageIndex]

	MusicData:SetDifficultIndex(slot2, math.min(MusicData:GetDifficultyIndex(slot2), 1))
	slot0:OnPageChange(slot0.pageIndex)
	slot0:RefrenTime()

	slot0.timer = Timer.New(function ()
		uv0:RefrenTime()
		uv0:RefrenBGM()
	end, 1, -1)

	slot0.timer:Start()
	MusicAction.SetMusicRead(slot0.activity_id)
	manager.redPoint:bindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activity_id))

	if not getData("EnternalMusic", "showHelp") then
		JumpTools.OpenPageByJump("gameHelpPro", {
			isPrefab = true,
			pages = GameSetting.v210_music_describe and GameSetting.v210_music_describe.value or {}
		})
		saveData("EnternalMusic", "showHelp", 1)
	end
end

function slot0.OnExit(slot0)
	MusicData:SetLookBackState(slot0.isLookBack)
	manager.windowBar:HideBar()

	if slot0.timer then
		slot0.timer:Stop()

		slot0.timer = nil
	end

	manager.redPoint:unbindUIandKey(slot0.m_rewardBtn.transform, string.format("%s_%s", RedPointConst.MUSIC_REWARD, slot0.activity_id))
end

function slot0.RefrenTime(slot0)
	if ActivityData:GetActivityData(slot0.activity_id) and slot1:IsActivitying() then
		slot0.m_timeLab.text = manager.time:GetLostTimeStr(slot1.stopTime)
	else
		slot0.m_timeLab.text = GetTips("TIME_OVER")

		JumpTools.Back()

		return
	end

	UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(slot0.m_timeLab.transform)

	for slot6, slot7 in pairs(slot0.list_:GetItemList()) do
		slot7:RefrenTime()
	end

	if ActivityData:GetActivityIsOpen(slot0.musics[slot0.pageIndex]) or slot0.isLookBack then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end
end

function slot0.IndexItem(slot0, slot1, slot2)
	slot2:SetData(slot1, slot0.musics[slot1], slot0.isLookBack)
	slot2:MoveAniEffect(slot0:GetScrollContentValue())
end

function slot0.OnPageChange(slot0, slot1)
	if slot1 > #slot0.musics then
		slot1 = #slot0.musics
	end

	slot0.pageIndex = slot1

	MusicData:SetSelectIndex(slot0.pageIndex)

	if ActivityData:GetActivityIsOpen(slot0.musics[slot1]) or slot0.isLookBack then
		slot0.lockController:SetSelectedIndex(1)
	else
		slot0.lockController:SetSelectedIndex(0)
	end

	slot0:PlayBg()
end

function slot0.PlayBg(slot0)
	manager.audio:ClearBGMFlag()

	if not slot0.musics[slot0.pageIndex] then
		return
	end

	if (not ActivityData:GetActivityData(slot1) or not slot2:IsActivitying()) and not slot0.isLookBack then
		manager.audio:StopBgmImmediate()

		return
	end

	if ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot1][MusicData:GetDifficultyIndex(slot1) + 1] or slot3[1]].aisacKey ~= "" then
		AudioManager.Instance:SetAisacControlOfCategory("music", slot6.aisacKey, slot6.aisacValue)
	end

	slot0.BGMID = slot5

	manager.audio:PlayBGM(slot6.cueSheetName, slot6.cueName, slot6.awbFile)
end

function slot0.RefrenBGM(slot0)
	if not slot0.musics[slot0.pageIndex] then
		return
	end

	if slot0.BGMID == (ActivityMusicCfg.get_id_list_by_activity_id[slot1][MusicData:GetDifficultyIndex(slot1) + 1] or slot2[1]) then
		return
	end

	slot0:PlayBg()
end

function slot0.Dispose(slot0)
	slot0.list_:Dispose()
	uv0.super.Dispose(slot0)
end

return slot0
