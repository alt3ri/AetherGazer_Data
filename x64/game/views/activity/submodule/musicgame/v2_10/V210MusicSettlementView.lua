slot0 = class("EnternalMusicSettlementView", ReduxView)

function slot0.UIName(slot0)
	return "UI/VersionUI/JapanRegionUI_2_10/JapanRegionMusicUI/MusicScoreUI"
end

function slot0.UIParent(slot0)
	return manager.ui.uiMain.transform
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.difficultController_ = ControllerUtil.GetController(slot0.transform_, "difficult")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.newController_ = ControllerUtil.GetController(slot0.transform_, "new")
	slot0.evaluateController_ = ControllerUtil.GetController(slot0.transform_, "evaluate")
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_restartBtn, nil, function ()
		if ActivityMusicCfg[MusicData:GetGameId()] then
			SDKTools.SendMessageToSDK("activity_music_start", {
				is_restart = false,
				activity_id = slot1.activity_id,
				difficulty_id = slot1.difficult,
				other_data = MusicData:GetSpectralAndVercialSDKKey()
			})
		end

		MusicLuaBridge.ReStartMusicGame()
		uv0:Back()
	end)
	slot0:AddBtnListener(slot0.m_backBtn, nil, function ()
		slot0 = MusicData:GetGameId()
		slot1 = MusicData:GetMusicViewPathList(activityId)

		DestroyLua()
		LuaExchangeHelper.GoToMain()
		OpenPageUntilLoaded(slot1.musicMain, {
			activity_id = slot1.activityID
		})
	end)
end

function slot0.OnTop(slot0)
	manager.windowBar:HideBar()
end

function slot0.OnEnter(slot0)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot2 = ActivityMusicCfg[MusicData:GetGameId()]
	slot0.m_name.text = GetI18NText(slot2.name)
	slot0.m_bg.sprite = getSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. slot2.icon)
	slot0.bgImg_.sprite = getSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. slot2.icon)

	if slot2.difficult == 2 then
		slot0.difficultController_:SetSelectedIndex(1)
	elseif slot2.difficult == 9 then
		slot0.difficultController_:SetSelectedIndex(2)
	else
		slot0.difficultController_:SetSelectedIndex(0)
	end

	slot3 = slot0.params_.cur
	slot0.m_curScoreLab.text = slot3
	slot0.m_maxScoreLab.text = slot0.params_.max
	slot0.m_comboLab.text = MusicData:GetMaxComboHit()
	slot0.m_accuracyLab.text = string.format("%.2f%%", slot0:KeepDecimalPlace(slot3 / slot2.total_score * 100, 2))
	slot8 = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Good)
	slot0.m_mistakeLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Miss)
	slot0.m_preciseLab.text = slot8
	slot0.m_perfectLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.Perfect)
	slot0.m_perfectPluasLab.text = MusicData:GetGameRecord(MusicConst.MusicNodeHitRating.PerfectPlus)

	if slot8 == 0 and slot7 == 0 then
		slot0.evaluateController_:SetSelectedIndex(2)
	elseif slot7 == 0 then
		slot0.evaluateController_:SetSelectedIndex(1)
	else
		slot0.evaluateController_:SetSelectedIndex(0)
	end

	slot0.newController_:SetSelectedIndex(slot0.params_.new and 1 or 0)

	for slot13, slot14 in ipairs(GameSetting.attach_music_grade.value) do
		if slot14 <= slot5 then
			slot0.gradeController_:SetSelectedIndex(slot13 - 1)

			break
		end
	end
end

function slot0.KeepDecimalPlace(slot0, slot1, slot2)
	return math.floor(slot1 * 10^slot2) / 10^slot2
end

function slot0.OnExit(slot0)
	manager.windowBar:HideBar()
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

return slot0
