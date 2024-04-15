return {
	Play103903001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903001
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			if uv0.bgs_.ST03 == nil then
				slot4 = Object.Instantiate(uv0.paintGo_)
				slot4:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot3)
				slot4.name = slot3
				slot4.transform.parent = uv0.stage_.transform
				slot4.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot3] = slot4
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				slot5 = manager.ui.mainCamera.transform.localPosition
				slot7 = uv0.bgs_.ST03
				slot7.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot5.x, slot5.y, 0)
				slot7.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot7:GetComponent("SpriteRenderer") and slot8.sprite then
					slot11 = manager.ui.mainCameraCom_
					slot12 = 2 * (slot7.transform.localPosition - slot5).z * Mathf.Tan(slot11.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot18 = slot12 * slot11.aspect / slot8.sprite.bounds.size.x > slot12 / slot8.sprite.bounds.size.y and slot16 or slot17
					slot7.transform.localScale = Vector3.New(slot18, slot18, 0)
				end

				for slot12, slot13 in pairs(uv0.bgs_) do
					if slot12 ~= "ST03" then
						slot13.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot6 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot7 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot7:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot7:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(103903001).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 + 0.3 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = math.max(slot6, uv0.talkMaxDuration)

			if slot5 + 0.3 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				uv0.typewritter.percent = (uv0.time_ - slot5) / slot6

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903002
		slot1.duration_ = 3.7

		if ({
			ja = 3.7,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_mood_daily", "bgm_story_mood_daily", "bgm_story_mood_daily")
			end

			if uv0.actors_["1039ui_story"] == nil then
				slot4 = Object.Instantiate(Asset.Load("Char/" .. slot3), uv0.stage_.transform)
				slot4.name = slot3
				slot4.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot3] = slot4
				slot4:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot4, typeof(DynamicBoneHelper)) then
					slot6:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot5.transform, false)

				uv0.var_[slot3 .. "Animator"] = slot5.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot3 .. "Animator"].applyRootMotion = true
				uv0.var_[slot3 .. "LipSync"] = slot5.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			slot13 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903002).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903002", slot21)
						uv0:RecordAudio("103903002", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903002", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903003
		slot1.duration_ = 4.6

		if ({
			ja = 4.6,
			ko = 3.366,
			zh = 3.366,
			en = 4.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot3 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903003).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903003", slot11)
						uv0:RecordAudio("103903003", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903003", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903004
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903004).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903005
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903005).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903006
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903006).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903007
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903007).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903008
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903008).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903009
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(103903009).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903010
		slot1.duration_ = 7.9

		if ({
			ja = 7.9,
			ko = 7.866,
			zh = 7.866,
			en = 5.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action424")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot7 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903010).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903010", slot15)
						uv0:RecordAudio("103903010", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903010", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903011).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (6 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -1.06, -5.3)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903012).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903013
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPosST03 = uv0.bgs_.ST03.transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST03, Vector3.New(0, -100, 10), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST02 == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.ST02
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "ST02" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot7 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(103903013).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot6 then
						uv0.duration_ = slot12 + slot6
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903014
		slot1.duration_ = 4.933

		if ({
			ja = 4.933,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1027ui_story"] == nil then
				slot2 = Object.Instantiate(Asset.Load("Char/" .. slot1), uv0.stage_.transform)
				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot1] = slot2
				slot2:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot2, typeof(DynamicBoneHelper)) then
					slot4:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot3.transform, false)

				uv0.var_[slot1 .. "Animator"] = slot3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot1 .. "Animator"].applyRootMotion = true
				uv0.var_[slot1 .. "LipSync"] = slot3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -0.922, -5.1)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot11 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(103903014).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903014", slot19)
						uv0:RecordAudio("103903014", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903014", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = math.max(slot11, uv0.talkMaxDuration)

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				uv0.typewritter.percent = (uv0.time_ - slot10) / slot11

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903015
		slot1.duration_ = 4.033

		if ({
			ja = 3.466,
			ko = 4.033,
			zh = 4.033,
			en = 3.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1148ui_story"] == nil then
				slot2 = Object.Instantiate(Asset.Load("Char/" .. slot1), uv0.stage_.transform)
				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot1] = slot2
				slot2:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot2, typeof(DynamicBoneHelper)) then
					slot4:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot3.transform, false)

				uv0.var_[slot1 .. "Animator"] = slot3.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot1 .. "Animator"].applyRootMotion = true
				uv0.var_[slot1 .. "LipSync"] = slot3.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -0.922, -5.1)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot16 = 0.001

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot14.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot15) / slot16)
				slot20 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot14.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot14.localEulerAngles = slot21
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot14.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot19 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot14.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot14.localEulerAngles = slot20
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			slot20 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot23 = uv0:FormatText(uv0:GetWordFromCfg(103903015).content)
				uv0.text_.text = slot23

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot20 or slot20 * utf8.len(slot23) / slot24) > 0 and slot20 < slot26 then
					uv0.talkMaxDuration = slot26

					if uv0.duration_ < slot26 + slot19 then
						uv0.duration_ = slot26 + slot19
					end
				end

				uv0.text_.text = slot23
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb") / 1000 + slot19 then
						uv0.duration_ = slot27 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						slot28 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903015", slot28)
						uv0:RecordAudio("103903015", slot28)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903015", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot20 = math.max(slot20, uv0.talkMaxDuration)

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				uv0.typewritter.percent = (uv0.time_ - slot19) / slot20

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903016
		slot1.duration_ = 4.6

		if ({
			ja = 4.6,
			ko = 3.7,
			zh = 3.7,
			en = 3.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action424")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot10 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903016).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903016", slot18)
						uv0:RecordAudio("103903016", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903016", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[113].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903017).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903018
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903018).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903019
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903019).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903020
		slot1.duration_ = 8.8

		if ({
			ja = 8.8,
			ko = 6,
			zh = 6,
			en = 7.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -0.85, -5.6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -1.06, -5.3)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot16 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(103903020).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903020", slot24)
						uv0:RecordAudio("103903020", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903020", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = math.max(slot16, uv0.talkMaxDuration)

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903021
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903021).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903022
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903022).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot7 then
						uv0.duration_ = slot13 + slot7
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903023
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903023).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903024
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(103903024).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903025
		slot1.duration_ = 7.033

		if ({
			ja = 2.333,
			ko = 7.033,
			zh = 7.033,
			en = 5.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot10 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903025).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903025", slot18)
						uv0:RecordAudio("103903025", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903025", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903026
		slot1.duration_ = 2.766

		if ({
			ja = 2.533,
			ko = 2.433,
			zh = 2.433,
			en = 2.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.85, -5.6)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot16 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(103903026).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903026", slot24)
						uv0:RecordAudio("103903026", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903026", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = math.max(slot16, uv0.talkMaxDuration)

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903027
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			slot5 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903027).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903028
		slot1.duration_ = 7.833

		if ({
			ja = 7.833,
			ko = 4.9,
			zh = 4.9,
			en = 4.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.85, -5.6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot13 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903028).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903028", slot21)
						uv0:RecordAudio("103903028", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903028", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903029
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903029).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903030
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -1.06, -5.3)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903030).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903031
		slot1.duration_ = 5.266

		if ({
			ja = 5.266,
			ko = 4.9,
			zh = 4.9,
			en = 4.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot10 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903031).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903031", slot18)
						uv0:RecordAudio("103903031", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903031", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903032
		slot1.duration_ = 9.9

		if ({
			ja = 8.833,
			ko = 8.233,
			zh = 8.233,
			en = 9.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot13 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903032).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903032", slot21)
						uv0:RecordAudio("103903032", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903032", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903033
		slot1.duration_ = 3.6

		if ({
			ja = 3.6,
			ko = 2.2,
			zh = 2.2,
			en = 3.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action442")
			end

			slot9 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(103903033).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903033", slot17)
						uv0:RecordAudio("103903033", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903033", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = math.max(slot9, uv0.talkMaxDuration)

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				uv0.typewritter.percent = (uv0.time_ - slot8) / slot9

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903034
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			slot5 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903034).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903035
		slot1.duration_ = 2.5

		if ({
			ja = 1.999999999999,
			ko = 2.5,
			zh = 2.5,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot9 = 0.1

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(10, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(10, -0.85, -5.6)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot18 = 0.001

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot16.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot17) / slot18)
				slot22 = manager.ui.mainCamera.transform.position - slot16.position
				slot16.forward = Vector3.New(slot22.x, slot22.y, slot22.z)
				slot23 = slot16.localEulerAngles
				slot23.z = 0
				slot23.x = 0
				slot16.localEulerAngles = slot23
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 then
				slot16.localPosition = Vector3.New(0, -1.06, -5.3)
				slot21 = manager.ui.mainCamera.transform.position - slot16.position
				slot16.forward = Vector3.New(slot21.x, slot21.y, slot21.z)
				slot22 = slot16.localEulerAngles
				slot22.z = 0
				slot22.x = 0
				slot16.localEulerAngles = slot22
			end

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot20 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot22 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot25 = uv0:FormatText(uv0:GetWordFromCfg(103903035).content)
				uv0.text_.text = slot25

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot22 or slot22 * utf8.len(slot25) / slot26) > 0 and slot22 < slot28 then
					uv0.talkMaxDuration = slot28

					if uv0.duration_ < slot28 + slot21 then
						uv0.duration_ = slot28 + slot21
					end
				end

				uv0.text_.text = slot25
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb") / 1000 + slot21 then
						uv0.duration_ = slot29 + slot21
					end

					if slot24.prefab_name ~= "" and uv0.actors_[slot24.prefab_name] ~= nil then
						slot30 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot24.prefab_name].transform, "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903035", slot30)
						uv0:RecordAudio("103903035", slot30)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903035", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = math.max(slot22, uv0.talkMaxDuration)

			if slot21 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
				uv0.typewritter.percent = (uv0.time_ - slot21) / slot22

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot21 + slot22 and uv0.time_ < slot21 + slot22 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903036
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903036).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903037
		slot1.duration_ = 7.9

		if ({
			ja = 7.9,
			ko = 4.233,
			zh = 4.233,
			en = 4.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action424")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot4 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903037).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903037", slot12)
						uv0:RecordAudio("103903037", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903037", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903038
		slot1.duration_ = 10.466

		if ({
			ja = 10.466,
			ko = 6.6,
			zh = 6.6,
			en = 10.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot3 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903038).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903038", slot11)
						uv0:RecordAudio("103903038", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903038", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903039
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903039).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot7 then
						uv0.duration_ = slot13 + slot7
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903040
		slot1.duration_ = 4.2

		if ({
			ja = 4.2,
			ko = 2.866,
			zh = 2.866,
			en = 3.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot10 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903040).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903040", slot18)
						uv0:RecordAudio("103903040", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903040", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903041
		slot1.duration_ = 4.3

		if ({
			ja = 4.3,
			ko = 4.233,
			zh = 4.233,
			en = 3.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0, -0.85, -5.6), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.85, -5.6)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1303cva")
			end

			slot16 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(103903041).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903041", slot24)
						uv0:RecordAudio("103903041", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903041", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = math.max(slot16, uv0.talkMaxDuration)

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903042
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.85, -5.6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot9 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(103903042).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot9 or slot9 * utf8.len(slot11) / slot12) > 0 and slot9 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot8 then
						uv0.duration_ = slot14 + slot8
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = math.max(slot9, uv0.talkMaxDuration)

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				uv0.typewritter.percent = (uv0.time_ - slot8) / slot9

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903043
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action9_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot17 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot20 = uv0:FormatText(uv0:GetWordFromCfg(103903043).content)
				uv0.text_.text = slot20

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot17 or slot17 * utf8.len(slot20) / slot21) > 0 and slot17 < slot23 then
					uv0.talkMaxDuration = slot23

					if uv0.duration_ < slot23 + slot16 then
						uv0.duration_ = slot23 + slot16
					end
				end

				uv0.text_.text = slot20
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb") / 1000 + slot16 then
						uv0.duration_ = slot24 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						slot25 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903043", slot25)
						uv0:RecordAudio("103903043", slot25)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903043", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = math.max(slot17, uv0.talkMaxDuration)

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				uv0.typewritter.percent = (uv0.time_ - slot16) / slot17

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903044
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903044).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903045
		slot1.duration_ = 4.1

		if ({
			ja = 4.1,
			ko = 3.566,
			zh = 3.566,
			en = 3.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot9 = 0.1

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(10, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(10, -0.85, -5.6)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot18 = 0.001

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot16.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot17) / slot18)
				slot22 = manager.ui.mainCamera.transform.position - slot16.position
				slot16.forward = Vector3.New(slot22.x, slot22.y, slot22.z)
				slot23 = slot16.localEulerAngles
				slot23.z = 0
				slot23.x = 0
				slot16.localEulerAngles = slot23
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 then
				slot16.localPosition = Vector3.New(0, -1.06, -5.3)
				slot21 = manager.ui.mainCamera.transform.position - slot16.position
				slot16.forward = Vector3.New(slot21.x, slot21.y, slot21.z)
				slot22 = slot16.localEulerAngles
				slot22.z = 0
				slot22.x = 0
				slot16.localEulerAngles = slot22
			end

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot20 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot22 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot25 = uv0:FormatText(uv0:GetWordFromCfg(103903045).content)
				uv0.text_.text = slot25

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot22 or slot22 * utf8.len(slot25) / slot26) > 0 and slot22 < slot28 then
					uv0.talkMaxDuration = slot28

					if uv0.duration_ < slot28 + slot21 then
						uv0.duration_ = slot28 + slot21
					end
				end

				uv0.text_.text = slot25
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb") / 1000 + slot21 then
						uv0.duration_ = slot29 + slot21
					end

					if slot24.prefab_name ~= "" and uv0.actors_[slot24.prefab_name] ~= nil then
						slot30 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot24.prefab_name].transform, "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903045", slot30)
						uv0:RecordAudio("103903045", slot30)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903045", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = math.max(slot22, uv0.talkMaxDuration)

			if slot21 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
				uv0.typewritter.percent = (uv0.time_ - slot21) / slot22

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot21 + slot22 and uv0.time_ < slot21 + slot22 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903046
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -1.06, -5.3)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903046).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903047
		slot1.duration_ = 3

		if ({
			ja = 2.766,
			ko = 3,
			zh = 3,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0.83, -0.85, -5.6), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0.83, -0.85, -5.6)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			slot17 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot20 = uv0:FormatText(uv0:GetWordFromCfg(103903047).content)
				uv0.text_.text = slot20

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot17 or slot17 * utf8.len(slot20) / slot21) > 0 and slot17 < slot23 then
					uv0.talkMaxDuration = slot23

					if uv0.duration_ < slot23 + slot16 then
						uv0.duration_ = slot23 + slot16
					end
				end

				uv0.text_.text = slot20
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb") / 1000 + slot16 then
						uv0.duration_ = slot24 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						slot25 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903047", slot25)
						uv0:RecordAudio("103903047", slot25)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903047", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = math.max(slot17, uv0.talkMaxDuration)

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				uv0.typewritter.percent = (uv0.time_ - slot16) / slot17

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903048
		slot1.duration_ = 1.2

		if ({
			ja = 1.133,
			ko = 1.033,
			zh = 1.033,
			en = 1.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot3 = 0.025

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[114].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903048).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (1 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903048", slot11)
						uv0:RecordAudio("103903048", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903048", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903049
		slot1.duration_ = 3.866

		if ({
			ja = 3.7,
			ko = 3.166,
			zh = 3.166,
			en = 3.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action423")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot7 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903049).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903049", slot15)
						uv0:RecordAudio("103903049", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903049", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903050
		slot1.duration_ = 5.966

		if ({
			ja = 5.233,
			ko = 5.4,
			zh = 5.4,
			en = 5.966
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148actionlink/1148action437")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot10 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903050).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903050", slot18)
						uv0:RecordAudio("103903050", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903050", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903051
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -0.922, -5.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(10, -0.85, -5.6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.85, -5.6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903051).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot7 then
						uv0.duration_ = slot13 + slot7
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903052
		slot1.duration_ = 6.166

		if ({
			ja = 6.166,
			ko = 2.1,
			zh = 2.1,
			en = 2.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPosST02 = uv0.bgs_.ST02.transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST02, Vector3.New(0, -100, 10), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				slot8 = manager.ui.mainCamera.transform.localPosition
				slot10 = uv0.bgs_.ST03
				slot10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot8.x, slot8.y, 0)
				slot10.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot10:GetComponent("SpriteRenderer") and slot11.sprite then
					slot14 = manager.ui.mainCameraCom_
					slot15 = 2 * (slot10.transform.localPosition - slot8).z * Mathf.Tan(slot14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot21 = slot15 * slot14.aspect / slot11.sprite.bounds.size.x > slot15 / slot11.sprite.bounds.size.y and slot19 or slot20
					slot10.transform.localScale = Vector3.New(slot21, slot21, 0)
				end

				for slot15, slot16 in pairs(uv0.bgs_) do
					if slot15 ~= "ST03" then
						slot16.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, -1.06, -5.3)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot14 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(103903052).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903052", slot22)
						uv0:RecordAudio("103903052", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903052", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = math.max(slot14, uv0.talkMaxDuration)

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				uv0.typewritter.percent = (uv0.time_ - slot13) / slot14

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903053
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903053).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903054
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_side_1039", "se_story_1039_run", "")
			end

			slot4 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903054).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot4 or slot4 * utf8.len(slot6) / slot7) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot3 then
						uv0.duration_ = slot9 + slot3
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903055
		slot1.duration_ = 3.7

		if ({
			ja = 3.7,
			ko = 3.666,
			zh = 3.666,
			en = 2.033
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot13 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903055).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903055", slot21)
						uv0:RecordAudio("103903055", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903055", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903056
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903056).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903057
		slot1.duration_ = 7.633

		if ({
			ja = 7.633,
			ko = 4.366,
			zh = 4.366,
			en = 3.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action426")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot4 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903057).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903057", slot12)
						uv0:RecordAudio("103903057", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903057", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903058
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903058).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903059
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903059).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903060
		slot1.duration_ = 5.7

		if ({
			ja = 5.7,
			ko = 5.233,
			zh = 5.233,
			en = 4.266
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_pausebgm", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.1

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action463")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot9 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(103903060).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903060", slot17)
						uv0:RecordAudio("103903060", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903060", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot9 = math.max(slot9, uv0.talkMaxDuration)

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				uv0.typewritter.percent = (uv0.time_ - slot8) / slot9

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903061
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903061).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903062
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903062).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903063
		slot1.duration_ = 8

		if ({
			ja = 1.8,
			ko = 3.6,
			zh = 3.6,
			en = 8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot6 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(103903063).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb") / 1000 + slot5 then
						uv0.duration_ = slot13 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						slot14 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903063", slot14)
						uv0:RecordAudio("103903063", slot14)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903063", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = math.max(slot6, uv0.talkMaxDuration)

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				uv0.typewritter.percent = (uv0.time_ - slot5) / slot6

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903064
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903064).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903065
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903066(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903065).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903066 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903066
		slot1.duration_ = 3.1

		if ({
			ja = 2.666,
			ko = 2.533,
			zh = 2.533,
			en = 3.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903067(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot13 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903066).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903066", slot21)
						uv0:RecordAudio("103903066", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903066", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903067 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903067
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903068(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903067).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903068 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903068
		slot1.duration_ = 6.2

		if ({
			ja = 4.933,
			ko = 6.2,
			zh = 6.2,
			en = 5.966
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903069(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot3 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903068).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903068", slot11)
						uv0:RecordAudio("103903068", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903068", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903069 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903069
		slot1.duration_ = 6.266

		if ({
			ja = 6.266,
			ko = 4.7,
			zh = 4.7,
			en = 5.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903070(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(-0.85, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-0.85, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -1.06, -5.3)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0.92, -0.922, -5.1), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0.92, -0.922, -5.1)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot19 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(103903069).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903069", slot27)
						uv0:RecordAudio("103903069", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903069", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = math.max(slot19, uv0.talkMaxDuration)

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				uv0.typewritter.percent = (uv0.time_ - slot18) / slot19

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903070 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903070
		slot1.duration_ = 7.9

		if ({
			ja = 6.066,
			ko = 7.9,
			zh = 7.9,
			en = 4.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903071(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action424")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot10 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903070).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903070", slot18)
						uv0:RecordAudio("103903070", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903070", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903071 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903071
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903072(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903071).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903072 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903072
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903073(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903072).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903073 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903073
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903074(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPosST03 = uv0.bgs_.ST03.transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST03, Vector3.New(0, -100, 10), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.D04a == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.D04a
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "D04a" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot7) / slot8)
				slot12 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot6.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot6.localEulerAngles = slot13
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(10, -1.06, -5.3)
				slot11 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot6.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot6.localEulerAngles = slot12
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(10, -0.922, -5.1)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			slot13 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(103903073).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot13 or slot13 * utf8.len(slot15) / slot16) > 0 and slot13 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot12 then
						uv0.duration_ = slot18 + slot12
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903074 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903074
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903075(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903074).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903075 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903075
		slot1.duration_ = 6.333

		if ({
			ja = 6.233,
			ko = 4.9,
			zh = 4.9,
			en = 6.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903076(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot10 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903075).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903075", slot18)
						uv0:RecordAudio("103903075", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903075", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903076 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903076
		slot1.duration_ = 10.266

		if ({
			ja = 10.266,
			ko = 6.666,
			zh = 6.666,
			en = 7.5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903077(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot3 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903076).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903076", slot11)
						uv0:RecordAudio("103903076", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903076", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903077 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903077
		slot1.duration_ = 7.866

		if ({
			ja = 7.866,
			ko = 6.6,
			zh = 6.6,
			en = 5.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903078(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot3 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903077).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903077", slot11)
						uv0:RecordAudio("103903077", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903077", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903078 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903078
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903079(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903078).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903079 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903079
		slot1.duration_ = 6.833

		if ({
			ja = 6.833,
			ko = 5.2,
			zh = 5.2,
			en = 6.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903080(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.92, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-0.92, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0.85, -1.06, -5.3), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0.85, -1.06, -5.3)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot19 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(103903079).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903079", slot27)
						uv0:RecordAudio("103903079", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903079", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = math.max(slot19, uv0.talkMaxDuration)

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				uv0.typewritter.percent = (uv0.time_ - slot18) / slot19

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903080 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903080
		slot1.duration_ = 9

		if ({
			ja = 9,
			ko = 7.033,
			zh = 7.033,
			en = 6.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903081(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action432")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot10 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903080).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903080", slot18)
						uv0:RecordAudio("103903080", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903080", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903081 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903081
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903082(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903081).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903082 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903082
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903083(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			slot5 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903082).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903083 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903083
		slot1.duration_ = 7.233333333331

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903084(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0.85, -1.06, -5.3), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0.85, -1.06, -5.3)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action426")
			end

			slot15 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(103903083).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot15 or slot15 * utf8.len(slot17) / slot18) > 0 and slot15 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot14 then
						uv0.duration_ = slot20 + slot14
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot15 = math.max(slot15, uv0.talkMaxDuration)

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				uv0.typewritter.percent = (uv0.time_ - slot14) / slot15

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903084 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903084
		slot1.duration_ = 7.533

		if ({
			ja = 7.533,
			ko = 4.966,
			zh = 4.966,
			en = 4.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903085(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action464")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot4 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903084).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903084", slot12)
						uv0:RecordAudio("103903084", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903084", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903085 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903085
		slot1.duration_ = 5.9

		if ({
			ja = 5.4,
			ko = 5.9,
			zh = 5.9,
			en = 3.5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903086(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot3 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903085).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903085", slot11)
						uv0:RecordAudio("103903085", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903085", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903086 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903086
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903087(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(10, -1.06, -5.3)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.922, -5.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot16 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(103903086).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903086", slot24)
						uv0:RecordAudio("103903086", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903086", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = math.max(slot16, uv0.talkMaxDuration)

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				uv0.typewritter.percent = (uv0.time_ - slot15) / slot16

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903087 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903087
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903088(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903087).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot7 then
						uv0.duration_ = slot13 + slot7
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903088 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903088
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903089(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903088).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903089 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903089
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903090(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(103903089).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903090 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903090
		slot1.duration_ = 4.866

		if ({
			ja = 4.866,
			ko = 3.5,
			zh = 3.5,
			en = 4.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903091(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot10 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903090).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903090", slot18)
						uv0:RecordAudio("103903090", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903090", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903091 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903091
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903092(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903091).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903092 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903092
		slot1.duration_ = 2.366

		if ({
			ja = 2.366,
			ko = 2.3,
			zh = 2.3,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903093(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action432")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			slot4 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903092).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903092", slot12)
						uv0:RecordAudio("103903092", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903092", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903093 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903093
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903094(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903093).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903094 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903094
		slot1.duration_ = 2.8

		if ({
			ja = 2.8,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903095(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action425")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			slot4 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903094).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903094", slot12)
						uv0:RecordAudio("103903094", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903094", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903095 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903095
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903096(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903095).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903096 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903096
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903097(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903096).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903097 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903097
		slot1.duration_ = 4.6

		if ({
			ja = 4.6,
			ko = 2.5,
			zh = 2.5,
			en = 2.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903098(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.922, -5.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -0.922, -5.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			slot13 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[56].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(103903097).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903097", slot21)
						uv0:RecordAudio("103903097", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903097", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				uv0.typewritter.percent = (uv0.time_ - slot12) / slot13

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903098 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903098
		slot1.duration_ = 6.916666666665

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903099(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_resumebgm", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027actionlink/1027action427")
			end

			slot5 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903098).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903099 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903099
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903100(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1027ui_story == nil then
				uv0.var_.characterEffect1027ui_story = uv0.actors_["1027ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1027ui_story then
					uv0.var_.characterEffect1027ui_story.fillFlat = true
					uv0.var_.characterEffect1027ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1027ui_story then
				uv0.var_.characterEffect1027ui_story.fillFlat = true
				uv0.var_.characterEffect1027ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(10, -0.922, -5.1), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(10, -0.922, -5.1)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903099).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot7 then
						uv0.duration_ = slot13 + slot7
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903100 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903100
		slot1.duration_ = 6.233

		if ({
			ja = 6.233,
			ko = 4.6,
			zh = 4.6,
			en = 6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903101(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot10 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903100).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903100", slot18)
						uv0:RecordAudio("103903100", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903100", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903101 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903101
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903102(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903101).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903102 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903102
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903103(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -1.06, -5.3)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903102).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903103 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903103
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903104(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(103903103).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903104 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903104
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903105(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903104).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903105 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903105
		slot1.duration_ = 2.3

		if ({
			ja = 2.3,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903106(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			slot10 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903105).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903105", slot18)
						uv0:RecordAudio("103903105", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903105", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903106 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903106
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903107(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903106).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903107 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903107
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903108(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903107).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903108 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903108
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903109(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903108).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903109 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903109
		slot1.duration_ = 1.933

		if ({
			ja = 1.8,
			ko = 1.133,
			zh = 1.133,
			en = 1.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903110(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.1

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			slot8 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(103903109).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903109", slot16)
						uv0:RecordAudio("103903109", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903109", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				uv0.typewritter.percent = (uv0.time_ - slot7) / slot8

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903110 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903110
		slot1.duration_ = 2.633

		if ({
			ja = 2.333,
			ko = 2.633,
			zh = 2.633,
			en = 2.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903111(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_mood_warm", "bgm_story_mood_warm", "bgm_story_mood_warm")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action426")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot6 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(103903110).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb") / 1000 + slot5 then
						uv0.duration_ = slot13 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						slot14 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903110", slot14)
						uv0:RecordAudio("103903110", slot14)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903110", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = math.max(slot6, uv0.talkMaxDuration)

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				uv0.typewritter.percent = (uv0.time_ - slot5) / slot6

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903111 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903111
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903112(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903111).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903112 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903112
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903113(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPosD04a = uv0.bgs_.D04a.transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPosD04a, Vector3.New(0, -100, 10), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.ST01 == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.ST01
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "ST01" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot7) / slot8)
				slot12 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot6.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot6.localEulerAngles = slot13
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(10, -1.06, -5.3)
				slot11 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot6.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot6.localEulerAngles = slot12
			end

			slot10 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903112).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903113 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903113
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903114(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903113).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (50 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903114 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903114
		slot1.duration_ = 6.233

		if ({
			ja = 6.233,
			ko = 1.999999999999,
			zh = 1.999999999999,
			en = 2.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903115(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot10 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903114).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903114", slot18)
						uv0:RecordAudio("103903114", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903114", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903115 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903115
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903116(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903115).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903116 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903116
		slot1.duration_ = 4.233

		if ({
			ja = 4.033,
			ko = 3.666,
			zh = 3.666,
			en = 4.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903117(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action424")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			slot4 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903116).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903116", slot12)
						uv0:RecordAudio("103903116", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903116", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903117 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903117
		slot1.duration_ = 17

		if ({
			ja = 14,
			ko = 13.8,
			zh = 13.8,
			en = 17
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903118(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot3 = 1.425

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903117).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (57 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903117", slot11)
						uv0:RecordAudio("103903117", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903117", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903118 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903118
		slot1.duration_ = 10.9

		if ({
			ja = 10.9,
			ko = 8.8,
			zh = 8.8,
			en = 10.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903119(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action445")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot4 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903118).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903118", slot12)
						uv0:RecordAudio("103903118", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903118", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903119 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903119
		slot1.duration_ = 8.166

		if ({
			ja = 8.166,
			ko = 7.8,
			zh = 7.8,
			en = 8.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903120(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot3 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903119).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903119", slot11)
						uv0:RecordAudio("103903119", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903119", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903120 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903120
		slot1.duration_ = 8.533

		if ({
			ja = 8.533,
			ko = 4.366,
			zh = 4.366,
			en = 3.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903121(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action472")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot4 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903120).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903120", slot12)
						uv0:RecordAudio("103903120", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903120", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot4 = math.max(slot4, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				uv0.typewritter.percent = (uv0.time_ - slot3) / slot4

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903121 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903121
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903122(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPosST01 = uv0.bgs_.ST01.transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPosST01, Vector3.New(0, -100, 10), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -100, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				slot8 = manager.ui.mainCamera.transform.localPosition
				slot10 = uv0.bgs_.D04a
				slot10.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot8.x, slot8.y, 0)
				slot10.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot10:GetComponent("SpriteRenderer") and slot11.sprite then
					slot14 = manager.ui.mainCameraCom_
					slot15 = 2 * (slot10.transform.localPosition - slot8).z * Mathf.Tan(slot14.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot21 = slot15 * slot14.aspect / slot11.sprite.bounds.size.x > slot15 / slot11.sprite.bounds.size.y and slot19 or slot20
					slot10.transform.localScale = Vector3.New(slot21, slot21, 0)
				end

				for slot15, slot16 in pairs(uv0.bgs_) do
					if slot15 ~= "D04a" then
						slot16.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(10, -1.06, -5.3)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot12 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(103903121).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = math.max(slot12, uv0.talkMaxDuration)

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				uv0.typewritter.percent = (uv0.time_ - slot11) / slot12

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903122 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903122
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903123(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(103903122).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903123 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903123
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903124(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903123).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903124 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903124
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903125(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			slot5 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903124).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903125 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903125
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903126(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903125).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903126 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903126
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903127(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903126).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903127 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903127
		slot1.duration_ = 6.933

		if ({
			ja = 6.933,
			ko = 4.366,
			zh = 4.366,
			en = 4.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903128(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot10 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903127).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903127", slot18)
						uv0:RecordAudio("103903127", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903127", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903128 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903128
		slot1.duration_ = 9.3

		if ({
			ja = 9.3,
			ko = 7.166,
			zh = 7.166,
			en = 5.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903129(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot3 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903128).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903128", slot11)
						uv0:RecordAudio("103903128", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903128", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903129 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903129
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903130(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903129).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903130 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903130
		slot1.duration_ = 7.066

		if ({
			ja = 7.066,
			ko = 4.366,
			zh = 4.366,
			en = 6.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903131(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action456")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot7 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903130).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903130", slot15)
						uv0:RecordAudio("103903130", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903130", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903131 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903131
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903132(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903131).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903132 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903132
		slot1.duration_ = 5.366

		if ({
			ja = 5.366,
			ko = 3.4,
			zh = 3.4,
			en = 1.5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903133(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot3 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903132).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903132", slot11)
						uv0:RecordAudio("103903132", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903132", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903133 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903133
		slot1.duration_ = 0.100000001489

		SetActive(slot1.tipsGo_, true)

		slot1.tipsText_.text = StoryTipsCfg[103901].name

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
			slot3 = true

			SetActive(uv0.choicesGo_, slot3)

			for slot3, slot4 in ipairs(uv0.choices_) do
				SetActive(slot4.go, slot3 <= 2)
			end

			uv0.choices_[1].txt.text = uv0:FormatText(StoryChoiceCfg[76].name)
			uv0.choices_[2].txt.text = uv0:FormatText(StoryChoiceCfg[77].name)
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				PlayerAction.UseStoryTrigger(1039012, 210390103, 103903133, 1)
				uv0:Play103903134(uv1)
			end

			if slot0 == 2 then
				uv0:Play103903137(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end
		end
	end,
	Play103903134 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903134
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903135(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(10, -1.06, -5.3), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(10, -1.06, -5.3)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(103903134).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903135 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903135
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903136(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903135).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903136 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903136
		slot1.duration_ = 7.149999999998

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903142(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action468")
			end

			slot3 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(103903136).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot3 = math.max(slot3, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				uv0.typewritter.percent = (uv0.time_ - slot2) / slot3

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903142 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903142
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903143(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903142).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903143 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903143
		slot1.duration_ = 7.5

		if ({
			ja = 7.5,
			ko = 3.466,
			zh = 3.466,
			en = 4.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903144(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, -1.06, -5.3), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.06, -5.3)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action484")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot10 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(103903143).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903143", slot18)
						uv0:RecordAudio("103903143", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903143", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot10 = math.max(slot10, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				uv0.typewritter.percent = (uv0.time_ - slot9) / slot10

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903144 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903144
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903145(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903144).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903145 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903145
		slot1.duration_ = 4.833

		if ({
			ja = 4.833,
			ko = 3.733,
			zh = 3.733,
			en = 4.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
			uv0.auto_ = false
		end

		function slot1.playNext_(slot0)
			uv0.onStoryFinished_()
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action442")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1203cva")
			end

			slot6 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(103903145).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb") / 1000 + slot5 then
						uv0.duration_ = slot13 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						slot14 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903145", slot14)
						uv0:RecordAudio("103903145", slot14)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903145", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot6 = math.max(slot6, uv0.talkMaxDuration)

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				uv0.typewritter.percent = (uv0.time_ - slot5) / slot6

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903137 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903137
		slot1.duration_ = 3.6

		if ({
			ja = 2.266,
			ko = 2.533,
			zh = 2.533,
			en = 3.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903138(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action463")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot7 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903137).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903137", slot15)
						uv0:RecordAudio("103903137", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903137", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903138 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903138
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903139(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903138).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903139 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903139
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903140(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot5 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[7].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(103903139).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot5 = math.max(slot5, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				uv0.typewritter.percent = (uv0.time_ - slot4) / slot5

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903140 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903140
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903141(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(103903140).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
					uv0.talkMaxDuration = slot7

					if uv0.duration_ < slot7 + slot1 then
						uv0.duration_ = slot7 + slot1
					end
				end

				uv0.text_.text = slot4
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot2 = math.max(slot2, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				uv0.typewritter.percent = (uv0.time_ - slot1) / slot2

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play103903141 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 103903141
		slot1.duration_ = 5.366

		if ({
			ja = 5.366,
			ko = 3.933,
			zh = 3.933,
			en = 3.433
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play103903142(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action438")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1103cva")
			end

			slot7 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[9].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(103903141).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")

						uv0:RecordAudio("103903141", slot15)
						uv0:RecordAudio("103903141", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_side_old_103903", "103903141", "story_v_side_old_103903.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot7 = math.max(slot7, uv0.talkMaxDuration)

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				uv0.typewritter.percent = (uv0.time_ - slot6) / slot7

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST03",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST02",
		"Assets/UIResources/UI_AB/TextureConfig/Background/D04a",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST01"
	},
	voices = {
		"story_v_side_old_103903.awb"
	}
}
