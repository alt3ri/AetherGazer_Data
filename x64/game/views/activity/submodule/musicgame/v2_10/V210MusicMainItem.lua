slot0 = class("V210MusicMainItem", ReduxView)

function slot0.OnCtor(slot0, slot1)
	slot0.gameObject_ = slot1
	slot0.transform_ = slot1.transform

	slot0:Init()
end

function slot0.Init(slot0)
	slot0:InitUI()
	slot0:AddUIListener()
end

function slot0.InitUI(slot0)
	slot0:BindCfgUI()

	slot0.stateController_ = ControllerUtil.GetController(slot0.transform_, "state")
	slot0.gradeController_ = ControllerUtil.GetController(slot0.transform_, "grade")
	slot0.difficultController_ = ControllerUtil.GetController(slot0.transform_, "difficult")
	slot0.selectDifficult = 0
end

function slot0.AddUIListener(slot0)
	slot0:AddBtnListener(slot0.m_easyBtn, nil, function ()
		uv0.selectDifficult = 0

		MusicData:SetDifficultIndex(uv0.music_id, uv0.selectDifficult)
		uv0:RefreshUI()
	end)
	slot0:AddBtnListener(slot0.m_difficult, nil, function ()
		if uv0.surpriseId ~= 0 then
			if uv0.surpriseTime < Time.realtimeSinceStartup - 5 then
				uv0.surpriseTime = slot0
				uv0.surpriseCount = 1
			else
				uv0.surpriseCount = uv0.surpriseCount + 1

				if uv0.surpriseCount >= 5 then
					if not uv0.surpriseHard then
						-- Nothing
					end

					uv0.surpriseHard = true
				end
			end
		end

		if uv0.surpriseHard then
			uv0.selectDifficult = 2

			MusicData:SetDifficultIndex(uv0.music_id, 2)
		else
			uv0.selectDifficult = 1

			MusicData:SetDifficultIndex(uv0.music_id, 1)
		end

		uv0:RefreshUI()
	end)
end

function slot0.SetData(slot0, slot1, slot2, slot3)
	slot0.index = slot1
	slot0.music_id = slot2
	slot0.isLookBack = slot3
	slot0.surpriseTime = 0
	slot0.surpriseCount = 0
	slot0.surpriseId = 0

	for slot8, slot9 in ipairs(ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id]) do
		if ActivityMusicCfg[slot9].difficult > 2 then
			slot0.surpriseId = slot9

			break
		end
	end

	slot0.surpriseHard = false
	slot0.selectDifficult = MusicData:GetDifficultyIndex(slot0.music_id)
	slot0.selectDifficult = math.min(slot0.selectDifficult, 1)

	MusicData:SetDifficultIndex(slot0.music_id, slot0.selectDifficult)
	slot0:RefreshUI()
end

function slot0.RefreshUI(slot0)
	slot0.selectDifficult = MusicData:GetDifficultyIndex(slot0.music_id)

	slot0.difficultController_:SetSelectedIndex(math.min(slot0.selectDifficult, 1))

	if slot0.surpriseHard then
		slot0.m_hardLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_3")
	else
		slot0.m_hardLab.text = GetTips("ACTIVITY_MUSIC_LEVEL_2")
	end

	slot4 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id][slot0.selectDifficult + 1]]
	slot0.m_title.text = GetI18NText(slot4.name)
	slot5 = slot4.icon
	slot0.m_icon.sprite = getSpriteWithoutAtlas("TextureConfig/Music/Music_icon/" .. slot5)
	slot0.m_bgIcon.sprite = getSpriteWithoutAtlas("TextureConfig/Music/Music1_icon/" .. slot5)
	slot0.m_author.text = GetI18NText(slot4.creator_name)

	slot0:RefreshActivity()
	slot0:RefrenTime()
end

function slot0.RefreshActivity(slot0)
	slot4 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id][slot0.selectDifficult + 1]]

	if ActivityData:GetActivityData(slot0.music_id) and slot5:IsActivitying() or slot0.isLookBack then
		slot6 = MusicData:GetScore(slot0.music_id, slot1)

		if MusicData:GetIsComplete(slot0.music_id, slot1) == 0 then
			slot0.stateController_:SetSelectedIndex(1)
			slot0.gradeController_:SetSelectedIndex(6)
		else
			slot0.stateController_:SetSelectedIndex(0)

			slot0.m_scoreLab.text = slot6
			slot14 = slot0:KeepDecimalPlace(slot6 / slot4.total_score * 100, 2)
			slot0.m_accuracyLab.text = string.format("%.2f%%", slot14)

			for slot14, slot15 in ipairs(GameSetting.attach_music_grade.value) do
				if slot15 <= slot8 then
					slot0.gradeController_:SetSelectedIndex(slot14 - 1)

					break
				end
			end
		end
	end
end

function slot0.KeepDecimalPlace(slot0, slot1, slot2)
	return math.floor(slot1 * 10^slot2) / 10^slot2
end

function slot0.RegistCallBack(slot0, slot1)
	slot0.callback_ = slot1
end

function slot0.RefrenTime(slot0)
	slot4 = ActivityMusicCfg[ActivityMusicCfg.get_id_list_by_activity_id[slot0.music_id][slot0.selectDifficult + 1]]
	slot5 = ActivityData:GetActivityData(slot0.music_id)

	if slot0.isLookBack then
		slot0:RefreshActivity()

		return
	end

	if slot5 then
		if not slot5:IsActivitying() then
			if slot5 and manager.time:GetServerTime() <= slot5.startTime + 1 then
				slot0.m_lockLab.text = string.format(GetTips("SLAYER_TIME_TO_START"), manager.time:GetLostTimeStr(slot5.startTime))
			else
				slot0.m_lockLab.text = GetTips("TIME_OVER")
			end

			slot0.stateController_:SetSelectedIndex(2)
			slot0.gradeController_:SetSelectedIndex(6)
		elseif slot0.stateController_:GetSelectedState() == "2" then
			slot0:RefreshActivity()
		end
	else
		slot0.m_lockLab.text = GetTips("TIME_OVER")

		slot0.stateController_:SetSelectedIndex(2)
	end
end

function slot0.UpdateScale(slot0, slot1)
	slot5 = 1 - math.abs(slot1:InverseTransformPoint(slot0.transform_:TransformPoint(Vector3(0, 0, 0))).x + slot0.transform_.rect.width / 2) / 8000
	slot0.m_content.localScale = Vector2.New(slot5, slot5)
end

function slot0.Dispose(slot0)
	uv0.super.Dispose(slot0)
end

function slot0.MoveAniEffect(slot0, slot1)
	if math.abs(slot1 - slot0.index) < 0.1 then
		slot2 = 0
	end

	slot0.m_content.localScale = Vector3.Lerp(Vector3.one, Vector3.one * 0.8, slot2)
	slot0.alphaCanvasgroup_.alpha = Mathf.Lerp(1, 0.8, slot2)

	if slot2 < 0.2 then
		slot0.alphaCanvasgroup_.blocksRaycasts = true
	else
		slot0.alphaCanvasgroup_.blocksRaycasts = false
	end
end

return slot0
