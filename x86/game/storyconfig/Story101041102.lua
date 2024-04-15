return {
	Play104112001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112001
		slot1.duration_ = 11.966

		if ({
			ja = 11.966,
			ko = 9.7,
			zh = 8.433,
			en = 8.633
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
				uv0:Play104112002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2")
			end

			if uv0.actors_["1148ui_story"] == nil then
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

			if 2 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
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

			if uv0.bgs_.B14 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if uv0.bgs_.B14:GetComponent("SpriteRenderer") then
					slot10.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot11 = slot10.material
					uv0.var_.alphaOldValueB14 = slot11:GetColor("_Color").a
					uv0.var_.alphaMatValueB14 = slot11
				end

				uv0.var_.alphaOldValueB14 = 0
			end

			slot10 = 1.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				if uv0.var_.alphaMatValueB14 then
					slot13 = uv0.var_.alphaMatValueB14
					slot14 = slot13:GetColor("_Color")
					slot14.a = Mathf.Lerp(uv0.var_.alphaOldValueB14, 1, (uv0.time_ - slot9) / slot10)

					slot13:SetColor("_Color", slot14)
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValueB14 then
				slot11 = uv0.var_.alphaMatValueB14
				slot12 = slot11:GetColor("_Color")
				slot12.a = 1

				slot11:SetColor("_Color", slot12)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				slot12 = manager.ui.mainCamera.transform.localPosition
				slot14 = uv0.bgs_.B14
				slot14.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot12.x, slot12.y, 0)
				slot14.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot14:GetComponent("SpriteRenderer") and slot15.sprite then
					slot18 = manager.ui.mainCameraCom_
					slot19 = 2 * (slot14.transform.localPosition - slot12).z * Mathf.Tan(slot18.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot25 = slot19 * slot18.aspect / slot15.sprite.bounds.size.x > slot19 / slot15.sprite.bounds.size.y and slot23 or slot24
					slot14.transform.localScale = Vector3.New(slot25, slot25, 0)
				end

				for slot19, slot20 in pairs(uv0.bgs_) do
					if slot19 ~= "B14" then
						slot20.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1.79999995231628 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(-0.7, -0.8, -6.2), (uv0.time_ - slot13) / slot14)
				slot18 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot12.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot12.localEulerAngles = slot19
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				slot17 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot12.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot12.localEulerAngles = slot18
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/1148/1148action/1148action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot16 + 2 and uv0.time_ < slot16 + slot17 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1148ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot20 = 0.875

			if 2 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot21 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot21:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot21:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[8].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot24 = uv0:FormatText(uv0:GetWordFromCfg(104112001).content)
				uv0.text_.text = slot24

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot20 or slot20 * utf8.len(slot24) / slot25) > 0 and slot20 < slot27 then
					uv0.talkMaxDuration = slot27

					if uv0.duration_ < slot27 + slot19 + 0.3 then
						uv0.duration_ = slot27 + slot19
					end
				end

				uv0.text_.text = slot24
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112001", "story_v_out_104112.awb") / 1000 + slot19 then
						uv0.duration_ = slot28 + slot19
					end

					if slot23.prefab_name ~= "" and uv0.actors_[slot23.prefab_name] ~= nil then
						slot29 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot23.prefab_name].transform, "story_v_out_104112", "104112001", "story_v_out_104112.awb")

						uv0:RecordAudio("104112001", slot29)
						uv0:RecordAudio("104112001", slot29)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112001", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112001", "story_v_out_104112.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot20 = math.max(slot20, uv0.talkMaxDuration)

			if slot19 + 0.3 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
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
	Play104112002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112002
		slot1.duration_ = 10.4

		if ({
			ja = 8.533,
			ko = 7,
			zh = 10.4,
			en = 8.7
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
				uv0:Play104112003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1059ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = uv0.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1148ui_story == nil then
				uv0.var_.characterEffect1148ui_story = uv0.actors_["1148ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1148ui_story then
					uv0.var_.characterEffect1148ui_story.fillFlat = true
					uv0.var_.characterEffect1148ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1148ui_story then
				uv0.var_.characterEffect1148ui_story.fillFlat = true
				uv0.var_.characterEffect1148ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1059ui_story = uv0.actors_["1059ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0.7, -1.05, -6), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.7, -1.05, -6)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059action/1059action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot14 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(104112002).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112002", "story_v_out_104112.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_104112", "104112002", "story_v_out_104112.awb")

						uv0:RecordAudio("104112002", slot22)
						uv0:RecordAudio("104112002", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112002", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112002", "story_v_out_104112.awb")
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
	Play104112003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112003
		slot1.duration_ = 11.566

		if ({
			ja = 11.566,
			ko = 9.766,
			zh = 11.1,
			en = 10.433
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
				uv0:Play104112004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059actionlink/1059action434")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3204cva")
			end

			slot4 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(104112003).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112003", "story_v_out_104112.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_104112", "104112003", "story_v_out_104112.awb")

						uv0:RecordAudio("104112003", slot12)
						uv0:RecordAudio("104112003", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112003", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112003", "story_v_out_104112.awb")
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
	Play104112004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112004
		slot1.duration_ = 6.3

		if ({
			ja = 6.3,
			ko = 3.8,
			zh = 5.566,
			en = 4.4
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
				uv0:Play104112005(uv1)
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

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = uv0.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = true
					uv0.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = true
				uv0.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1059ui_story = uv0.actors_["1059ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 100, 0)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1148ui_story = uv0.actors_["1148ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, 100, 0)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot16 = 0.001

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot14.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (uv0.time_ - slot15) / slot16)
				slot20 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot14.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot14.localEulerAngles = slot21
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot14.localPosition = Vector3.New(-0.7, -0.81, -5.8)
				slot19 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot14.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot14.localEulerAngles = slot20
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action3_1")
			end

			if uv0.actors_["1080ui_story"] == nil then
				slot19 = Object.Instantiate(Asset.Load("Char/" .. slot18), uv0.stage_.transform)
				slot19.name = slot18
				slot19.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot18] = slot19
				slot19:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot19, typeof(DynamicBoneHelper)) then
					slot21:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot20.transform, false)

				uv0.var_[slot18 .. "Animator"] = slot20.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot18 .. "Animator"].applyRootMotion = true
				uv0.var_[slot18 .. "LipSync"] = slot20.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/1080/1080action/1080action7_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot20 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			slot22 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
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

				slot25 = uv0:FormatText(uv0:GetWordFromCfg(104112004).content)
				uv0.text_.text = slot25

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot22 or slot22 * utf8.len(slot25) / slot26) > 0 and slot22 < slot28 then
					uv0.talkMaxDuration = slot28

					if uv0.duration_ < slot28 + slot21 then
						uv0.duration_ = slot28 + slot21
					end
				end

				uv0.text_.text = slot25
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112004", "story_v_out_104112.awb") / 1000 + slot21 then
						uv0.duration_ = slot29 + slot21
					end

					if slot24.prefab_name ~= "" and uv0.actors_[slot24.prefab_name] ~= nil then
						slot30 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot24.prefab_name].transform, "story_v_out_104112", "104112004", "story_v_out_104112.awb")

						uv0:RecordAudio("104112004", slot30)
						uv0:RecordAudio("104112004", slot30)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112004", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112004", "story_v_out_104112.awb")
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
	Play104112005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112005
		slot1.duration_ = 8.966

		if ({
			ja = 8.966,
			ko = 6.5,
			zh = 5.233,
			en = 6.066
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
				uv0:Play104112006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = uv0.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = false
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
				uv0.var_.moveOldPos1080ui_story = uv0.actors_["1080ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(0.7, -1.01, -6.05), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -1.01, -6.05)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1080ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot12 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(104112005).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112005", "story_v_out_104112.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_104112", "104112005", "story_v_out_104112.awb")

						uv0:RecordAudio("104112005", slot20)
						uv0:RecordAudio("104112005", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112005", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112005", "story_v_out_104112.awb")
				end

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
	Play104112006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112006
		slot1.duration_ = 3.8

		if ({
			ja = 3.133,
			ko = 2.7,
			zh = 3.8,
			en = 2.966
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
				uv0:Play104112007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = uv0.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1080ui_story == nil then
				uv0.var_.characterEffect1080ui_story = uv0.actors_["1080ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1080ui_story then
					uv0.var_.characterEffect1080ui_story.fillFlat = true
					uv0.var_.characterEffect1080ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1080ui_story then
				uv0.var_.characterEffect1080ui_story.fillFlat = true
				uv0.var_.characterEffect1080ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1080ui_story = uv0.actors_["1080ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1080ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
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
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1059ui_story = uv0.actors_["1059ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0, -1.05, -6), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -1.05, -6)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/1059/1059action/1059action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1204cva")
			end

			slot19 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(104112006).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112006", "story_v_out_104112.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_104112", "104112006", "story_v_out_104112.awb")

						uv0:RecordAudio("104112006", slot27)
						uv0:RecordAudio("104112006", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112006", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112006", "story_v_out_104112.awb")
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
	Play104112007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112007
		slot1.duration_ = 9.6

		if ({
			ja = 9.6,
			ko = 4.5,
			zh = 4.933,
			en = 4.7
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
				uv0:Play104112008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1059ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot3 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[28].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(104112007).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112007", "story_v_out_104112.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_104112", "104112007", "story_v_out_104112.awb")

						uv0:RecordAudio("104112007", slot11)
						uv0:RecordAudio("104112007", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112007", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112007", "story_v_out_104112.awb")
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
	Play104112008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112008
		slot1.duration_ = 3.7

		if ({
			ja = 3.7,
			ko = 2.3,
			zh = 2.533,
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
				uv0:Play104112009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			if uv0.actors_["3005_tpose"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3005_tpose == nil then
				uv0.var_.characterEffect3005_tpose = uv0.actors_["3005_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect3005_tpose then
					uv0.var_.characterEffect3005_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3005_tpose then
				uv0.var_.characterEffect3005_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1059ui_story == nil then
				uv0.var_.characterEffect1059ui_story = uv0.actors_["1059ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot9 = 0.1

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect1059ui_story then
					uv0.var_.characterEffect1059ui_story.fillFlat = true
					uv0.var_.characterEffect1059ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1059ui_story then
				uv0.var_.characterEffect1059ui_story.fillFlat = true
				uv0.var_.characterEffect1059ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1059ui_story = uv0.actors_["1059ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1059ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos3005_tpose = uv0.actors_["3005_tpose"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3005_tpose, Vector3.New(0, -1.95, -2.63), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -1.95, -2.63)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("3005_tpose", "StoryTimeline/CharAction/story3005/story3005action/3005action1_1")
			end

			slot18 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[58].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(104112008).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 then
						uv0.duration_ = slot24 + slot17
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112008", "story_v_out_104112.awb") / 1000 + slot17 then
						uv0.duration_ = slot25 + slot17
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						slot26 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_104112", "104112008", "story_v_out_104112.awb")

						uv0:RecordAudio("104112008", slot26)
						uv0:RecordAudio("104112008", slot26)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112008", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112008", "story_v_out_104112.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = math.max(slot18, uv0.talkMaxDuration)

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				uv0.typewritter.percent = (uv0.time_ - slot17) / slot18

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play104112009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112009
		slot1.duration_ = 6.233

		if ({
			ja = 5.466,
			ko = 3.9,
			zh = 4.666,
			en = 6.233
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
				uv0:Play104112010(uv1)
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

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3005_tpose == nil then
				uv0.var_.characterEffect3005_tpose = uv0.actors_["3005_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect3005_tpose then
					uv0.var_.characterEffect3005_tpose.fillFlat = true
					uv0.var_.characterEffect3005_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3005_tpose then
				uv0.var_.characterEffect3005_tpose.fillFlat = true
				uv0.var_.characterEffect3005_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos3005_tpose = uv0.actors_["3005_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3005_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/1027/1027action/1027action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, -0.81, -5.8), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -0.81, -5.8)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			slot16 = 0.55

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

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(104112009).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112009", "story_v_out_104112.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_104112", "104112009", "story_v_out_104112.awb")

						uv0:RecordAudio("104112009", slot24)
						uv0:RecordAudio("104112009", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112009", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112009", "story_v_out_104112.awb")
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
	Play104112010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112010
		slot1.duration_ = 2.3

		if ({
			ja = 2.3,
			ko = 1,
			zh = 1.5,
			en = 1.033
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
				uv0:Play104112011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(104112010).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112010", "story_v_out_104112.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_104112", "104112010", "story_v_out_104112.awb")

						uv0:RecordAudio("104112010", slot13)
						uv0:RecordAudio("104112010", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112010", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112010", "story_v_out_104112.awb")
				end

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
	Play104112011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112012(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(104112011).content)
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
	Play104112012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112012
		slot1.duration_ = 7.7

		if ({
			ja = 7.7,
			ko = 5.066,
			zh = 6.433,
			en = 7.166
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
				uv0:Play104112013(uv1)
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
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(-0.7, -0.81, -5.8), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-0.7, -0.81, -5.8)
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
				uv0:PlayTimeline("1027ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot10 = 0.75

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112012).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112012", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112012", "story_v_out_104112.awb")

						uv0:RecordAudio("104112012", slot18)
						uv0:RecordAudio("104112012", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112012", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112012", "story_v_out_104112.awb")
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
	Play104112013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112013
		slot1.duration_ = 1.733

		if ({
			ja = 1.733,
			ko = 1.1,
			zh = 1.466,
			en = 0.7
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
				uv0:Play104112014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1027ui_story = uv0.actors_["1027ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1027ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			slot5 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[55].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1080")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(104112013).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112013", "story_v_out_104112.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_104112", "104112013", "story_v_out_104112.awb")

						uv0:RecordAudio("104112013", slot13)
						uv0:RecordAudio("104112013", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112013", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112013", "story_v_out_104112.awb")
				end

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
	Play104112014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112014
		slot1.duration_ = 9

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot2 = 2

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				slot4 = Color.New(0, 0, 0)
				slot4.a = Mathf.Lerp(0, 1, (uv0.time_ - slot1) / slot2)
				uv0.mask_.color = slot4
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				slot3 = Color.New(0, 0, 0)
				slot3.a = 1
				uv0.mask_.color = slot3
			end

			if 2 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot4 = 2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot6 = Color.New(0, 0, 0)
				slot6.a = Mathf.Lerp(1, 0, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot5.a = 0
				uv0.mask_.color = slot5
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot6 = 0.375

			if 4 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(104112014).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
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
	Play104112015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112015
		slot1.duration_ = 8.5

		if ({
			ja = 8.5,
			ko = 5.9,
			zh = 6.8,
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
				uv0:Play104112016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["3008ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = uv0.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = false
			end

			if uv0.actors_["1035ui_story"] == nil then
				slot6 = Object.Instantiate(Asset.Load("Char/" .. slot5), uv0.stage_.transform)
				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot5] = slot6
				slot6:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot6, typeof(DynamicBoneHelper)) then
					slot8:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot7.transform, false)

				uv0.var_[slot5 .. "Animator"] = slot7.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot5 .. "Animator"].applyRootMotion = true
				uv0.var_[slot5 .. "LipSync"] = slot7.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1035ui_story == nil then
				uv0.var_.characterEffect1035ui_story = uv0.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.1

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect1035ui_story then
					uv0.var_.characterEffect1035ui_story.fillFlat = true
					uv0.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1035ui_story then
				uv0.var_.characterEffect1035ui_story.fillFlat = true
				uv0.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos3008ui_story = uv0.actors_["3008ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3008ui_story, Vector3.New(0.7, -1.51, -4.3), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0.7, -1.51, -4.3)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos1035ui_story = uv0.actors_["1035ui_story"].transform.localPosition
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1035ui_story, Vector3.New(-0.7, -1.05, -5.6), (uv0.time_ - slot13) / slot14)
				slot18 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot12.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot12.localEulerAngles = slot19
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(-0.7, -1.05, -5.6)
				slot17 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot12.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot12.localEulerAngles = slot18
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/3008/3008action/3008action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/1035/1035action/1035action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot19 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(104112015).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112015", "story_v_out_104112.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_104112", "104112015", "story_v_out_104112.awb")

						uv0:RecordAudio("104112015", slot27)
						uv0:RecordAudio("104112015", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112015", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112015", "story_v_out_104112.awb")
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
	Play104112016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112016
		slot1.duration_ = 9.2

		if ({
			ja = 7.1,
			ko = 4.533,
			zh = 9.2,
			en = 6.733
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
				uv0:Play104112017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = uv0.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = true
					uv0.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = true
				uv0.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1035ui_story == nil then
				uv0.var_.characterEffect1035ui_story = uv0.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1035ui_story then
					uv0.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1035ui_story then
				uv0.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/1035/1035action/1035action9_1")
			end

			slot9 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(104112016).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112016", "story_v_out_104112.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_104112", "104112016", "story_v_out_104112.awb")

						uv0:RecordAudio("104112016", slot17)
						uv0:RecordAudio("104112016", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112016", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112016", "story_v_out_104112.awb")
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
	Play104112017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112017
		slot1.duration_ = 9.1

		if ({
			ja = 9.1,
			ko = 4.3,
			zh = 5.833,
			en = 5
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
				uv0:Play104112018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = uv0.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1035ui_story == nil then
				uv0.var_.characterEffect1035ui_story = uv0.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1035ui_story then
					uv0.var_.characterEffect1035ui_story.fillFlat = true
					uv0.var_.characterEffect1035ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1035ui_story then
				uv0.var_.characterEffect1035ui_story.fillFlat = true
				uv0.var_.characterEffect1035ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/3008/3008actionlink/3008action442")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("3008ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot10 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[20].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112017).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112017", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112017", "story_v_out_104112.awb")

						uv0:RecordAudio("104112017", slot18)
						uv0:RecordAudio("104112017", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112017", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112017", "story_v_out_104112.awb")
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
	Play104112018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112018
		slot1.duration_ = 3.266

		if ({
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 3.266,
			en = 2.366
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
				uv0:Play104112019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3008ui_story == nil then
				uv0.var_.characterEffect3008ui_story = uv0.actors_["3008ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect3008ui_story then
					uv0.var_.characterEffect3008ui_story.fillFlat = true
					uv0.var_.characterEffect3008ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3008ui_story then
				uv0.var_.characterEffect3008ui_story.fillFlat = true
				uv0.var_.characterEffect3008ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1035ui_story == nil then
				uv0.var_.characterEffect1035ui_story = uv0.actors_["1035ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1035ui_story then
					uv0.var_.characterEffect1035ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1035ui_story then
				uv0.var_.characterEffect1035ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1035ui_story", "StoryTimeline/CharAction/1035/1035actionlink/1035action494")
			end

			slot9 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[21].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(104112018).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112018", "story_v_out_104112.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_104112", "104112018", "story_v_out_104112.awb")

						uv0:RecordAudio("104112018", slot17)
						uv0:RecordAudio("104112018", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112018", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112018", "story_v_out_104112.awb")
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
	Play104112019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112019
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos3008ui_story = uv0.actors_["3008ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3008ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 100, 0)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1035ui_story = uv0.actors_["1035ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1035ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.475

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(104112019).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play104112020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112020
		slot1.duration_ = 10.133

		if ({
			ja = 10.133,
			ko = 6.166,
			zh = 7.366,
			en = 6.3
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
				uv0:Play104112021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["4010ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			slot11 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(104112020).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112020", "story_v_out_104112.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_104112", "104112020", "story_v_out_104112.awb")

						uv0:RecordAudio("104112020", slot19)
						uv0:RecordAudio("104112020", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112020", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112020", "story_v_out_104112.awb")
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
	Play104112021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112021
		slot1.duration_ = 5.5

		if ({
			ja = 5.5,
			ko = 4.6,
			zh = 4.733,
			en = 5.433
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
				uv0:Play104112022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["3009ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos3009ui_story = uv0.actors_["3009ui_story"].transform.localPosition

				uv0:ShowWeapon(uv0.var_["3009ui_story" .. "Animator"].transform, true)
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.7, -1.75, -4.8)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/3009action/3009action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot14 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(104112021).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112021", "story_v_out_104112.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_104112", "104112021", "story_v_out_104112.awb")

						uv0:RecordAudio("104112021", slot22)
						uv0:RecordAudio("104112021", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112021", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112021", "story_v_out_104112.awb")
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
	Play104112022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112022
		slot1.duration_ = 4.433

		if ({
			ja = 4.433,
			ko = 2.633,
			zh = 2.599999999999,
			en = 2.599999999999
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
				uv0:Play104112023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.1

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = true
					uv0.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = true
				uv0.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			slot10 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112022).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112022", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112022", "story_v_out_104112.awb")

						uv0:RecordAudio("104112022", slot18)
						uv0:RecordAudio("104112022", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112022", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112022", "story_v_out_104112.awb")
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
	Play104112023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112023
		slot1.duration_ = 6.2

		if ({
			ja = 6.2,
			ko = 4.9,
			zh = 5.5,
			en = 5.2
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
				uv0:Play104112024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/3009action/3009action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot10 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112023).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112023", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112023", "story_v_out_104112.awb")

						uv0:RecordAudio("104112023", slot18)
						uv0:RecordAudio("104112023", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112023", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112023", "story_v_out_104112.awb")
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
	Play104112024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112024
		slot1.duration_ = 3.433

		if ({
			ja = 3.433,
			ko = 2.733,
			zh = 3,
			en = 3.4
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
				uv0:Play104112025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = true
					uv0.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = true
				uv0.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot9 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(104112024).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112024", "story_v_out_104112.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_104112", "104112024", "story_v_out_104112.awb")

						uv0:RecordAudio("104112024", slot17)
						uv0:RecordAudio("104112024", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112024", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112024", "story_v_out_104112.awb")
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
	Play104112025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112025
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos3009ui_story = uv0.actors_["3009ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3009ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			slot11 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112025).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot11 or slot11 * utf8.len(slot13) / slot14) > 0 and slot11 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot10 then
						uv0.duration_ = slot16 + slot10
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
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
	Play104112026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112026
		slot1.duration_ = 18.733

		if ({
			ja = 14.833,
			ko = 12.3,
			zh = 12.833,
			en = 18.733
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
				uv0:Play104112027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -1.59, -5.2)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot10 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112026).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112026", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112026", "story_v_out_104112.awb")

						uv0:RecordAudio("104112026", slot18)
						uv0:RecordAudio("104112026", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112026", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112026", "story_v_out_104112.awb")
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
	Play104112027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112027
		slot1.duration_ = 5.033

		if ({
			ja = 5.033,
			ko = 3.566,
			zh = 3.666,
			en = 2.866
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
				uv0:Play104112028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["2020_tpose"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 100, 0)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot12 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(104112027).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112027", "story_v_out_104112.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_104112", "104112027", "story_v_out_104112.awb")

						uv0:RecordAudio("104112027", slot20)
						uv0:RecordAudio("104112027", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112027", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112027", "story_v_out_104112.awb")
				end

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
	Play104112028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112028
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = true
					uv0.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = true
				uv0.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.225

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(104112028).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play104112029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112029
		slot1.duration_ = 3.833

		if ({
			ja = 3.833,
			ko = 3.433,
			zh = 2.633,
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
				uv0:Play104112030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["2030_tpose"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = uv0.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos2030_tpose = uv0.actors_["2030_tpose"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, 100, 0)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			slot10 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112029).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112029", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112029", "story_v_out_104112.awb")

						uv0:RecordAudio("104112029", slot18)
						uv0:RecordAudio("104112029", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112029", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112029", "story_v_out_104112.awb")
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
	Play104112030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112030
		slot1.duration_ = 7.333

		if ({
			ja = 7.333,
			ko = 2.766,
			zh = 2.6,
			en = 3
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
				uv0:Play104112031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = uv0.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = true
					uv0.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = true
				uv0.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2020_tpose = uv0.actors_["2020_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(0.7, -1.2, -4.1), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -1.2, -4.1)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			slot12 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[65].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(104112030).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112030", "story_v_out_104112.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_104112", "104112030", "story_v_out_104112.awb")

						uv0:RecordAudio("104112030", slot20)
						uv0:RecordAudio("104112030", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112030", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112030", "story_v_out_104112.awb")
				end

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
	Play104112031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112031
		slot1.duration_ = 6.166

		if ({
			ja = 4.366,
			ko = 4.9,
			zh = 6.166,
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
				uv0:Play104112032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = true
					uv0.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = true
				uv0.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2020_tpose = uv0.actors_["2020_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos2030_tpose = uv0.actors_["2030_tpose"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -1.59, -5.2)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot19 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(104112031).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112031", "story_v_out_104112.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_104112", "104112031", "story_v_out_104112.awb")

						uv0:RecordAudio("104112031", slot27)
						uv0:RecordAudio("104112031", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112031", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112031", "story_v_out_104112.awb")
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
	Play104112032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112032
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			slot5 = 0.4

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(104112032).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play104112033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112033
		slot1.duration_ = 18.966

		if ({
			ja = 13.033,
			ko = 12.733,
			zh = 14.5,
			en = 18.966
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
				uv0:Play104112034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot7 = 1.55

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(104112033).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (61 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112033", "story_v_out_104112.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_104112", "104112033", "story_v_out_104112.awb")

						uv0:RecordAudio("104112033", slot15)
						uv0:RecordAudio("104112033", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112033", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112033", "story_v_out_104112.awb")
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
	Play104112034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112034
		slot1.duration_ = 10.733

		if ({
			ja = 10.533,
			ko = 9.066,
			zh = 10.266,
			en = 10.733
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
				uv0:Play104112035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			slot3 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(104112034).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112034", "story_v_out_104112.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_104112", "104112034", "story_v_out_104112.awb")

						uv0:RecordAudio("104112034", slot11)
						uv0:RecordAudio("104112034", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112034", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112034", "story_v_out_104112.awb")
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
	Play104112035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112035
		slot1.duration_ = 12.9

		if ({
			ja = 11.8,
			ko = 10.933,
			zh = 12.9,
			en = 11.9
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
				uv0:Play104112036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action6_1")
			end

			slot4 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(104112035).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112035", "story_v_out_104112.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_104112", "104112035", "story_v_out_104112.awb")

						uv0:RecordAudio("104112035", slot12)
						uv0:RecordAudio("104112035", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112035", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112035", "story_v_out_104112.awb")
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
	Play104112036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112036
		slot1.duration_ = 5.1

		if ({
			ja = 5.1,
			ko = 1.999999999999,
			zh = 2.166,
			en = 2.366
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
				uv0:Play104112037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos2020_tpose = uv0.actors_["2020_tpose"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(-0.7, -1.2, -4.1), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(-0.7, -1.2, -4.1)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("2020_tpose", "StoryTimeline/CharAction/story2020/story2020action/2020action1_1")
			end

			slot15 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot18 = uv0:FormatText(uv0:GetWordFromCfg(104112036).content)
				uv0.text_.text = slot18

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot15 or slot15 * utf8.len(slot18) / slot19) > 0 and slot15 < slot21 then
					uv0.talkMaxDuration = slot21

					if uv0.duration_ < slot21 + slot14 then
						uv0.duration_ = slot21 + slot14
					end
				end

				uv0.text_.text = slot18
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112036", "story_v_out_104112.awb") / 1000 + slot14 then
						uv0.duration_ = slot22 + slot14
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						slot23 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_104112", "104112036", "story_v_out_104112.awb")

						uv0:RecordAudio("104112036", slot23)
						uv0:RecordAudio("104112036", slot23)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112036", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112036", "story_v_out_104112.awb")
				end

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
	Play104112037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112037
		slot1.duration_ = 3.3

		if ({
			ja = 3.3,
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
				uv0:Play104112038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = uv0.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = true
					uv0.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = true
				uv0.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2030_tpose = uv0.actors_["2030_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(0.7, -1.2, -4.2), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -1.2, -4.2)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("2030_tpose", "StoryTimeline/CharAction/story2030/story2030action/2030action1_1")
			end

			slot12 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(104112037).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112037", "story_v_out_104112.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_104112", "104112037", "story_v_out_104112.awb")

						uv0:RecordAudio("104112037", slot20)
						uv0:RecordAudio("104112037", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112037", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112037", "story_v_out_104112.awb")
				end

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
	Play104112038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112038
		slot1.duration_ = 4.1

		if ({
			ja = 4.1,
			ko = 2,
			zh = 2.366,
			en = 1.833
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
				uv0:Play104112039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2030_tpose == nil then
				uv0.var_.characterEffect2030_tpose = uv0.actors_["2030_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2030_tpose then
					uv0.var_.characterEffect2030_tpose.fillFlat = true
					uv0.var_.characterEffect2030_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2030_tpose then
				uv0.var_.characterEffect2030_tpose.fillFlat = true
				uv0.var_.characterEffect2030_tpose.fillRatio = 0.5
			end

			slot8 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(104112038).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112038", "story_v_out_104112.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_104112", "104112038", "story_v_out_104112.awb")

						uv0:RecordAudio("104112038", slot16)
						uv0:RecordAudio("104112038", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112038", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112038", "story_v_out_104112.awb")
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
	Play104112039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112039
		slot1.duration_ = 2

		if ({
			ja = 1.999999999999,
			ko = 1.999999999999,
			zh = 2,
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
				uv0:Play104112040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2020_tpose == nil then
				uv0.var_.characterEffect2020_tpose = uv0.actors_["2020_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2020_tpose then
					uv0.var_.characterEffect2020_tpose.fillFlat = true
					uv0.var_.characterEffect2020_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2020_tpose then
				uv0.var_.characterEffect2020_tpose.fillFlat = true
				uv0.var_.characterEffect2020_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2030_tpose = uv0.actors_["2030_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2030_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos2020_tpose = uv0.actors_["2020_tpose"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2020_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, 100, 0)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, -1.59, -5.2), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -1.59, -5.2)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			slot19 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(104112039).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112039", "story_v_out_104112.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_104112", "104112039", "story_v_out_104112.awb")

						uv0:RecordAudio("104112039", slot27)
						uv0:RecordAudio("104112039", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112039", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112039", "story_v_out_104112.awb")
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
	Play104112040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112040
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play104112041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			slot5 = 0.675

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(104112040).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play104112041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112041
		slot1.duration_ = 8.1

		if ({
			ja = 8.1,
			ko = 6.9,
			zh = 6.566,
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
				uv0:Play104112042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot6 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(104112041).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112041", "story_v_out_104112.awb") / 1000 + slot5 then
						uv0.duration_ = slot13 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						slot14 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_out_104112", "104112041", "story_v_out_104112.awb")

						uv0:RecordAudio("104112041", slot14)
						uv0:RecordAudio("104112041", slot14)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112041", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112041", "story_v_out_104112.awb")
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
	Play104112042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112042
		slot1.duration_ = 9.766

		if ({
			ja = 8.933,
			ko = 9.333,
			zh = 8.833,
			en = 9.766
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
				uv0:Play104112043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot4 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(104112042).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (40 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112042", "story_v_out_104112.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_104112", "104112042", "story_v_out_104112.awb")

						uv0:RecordAudio("104112042", slot12)
						uv0:RecordAudio("104112042", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112042", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112042", "story_v_out_104112.awb")
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
	Play104112043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112043
		slot1.duration_ = 4.9

		if ({
			ja = 4.9,
			ko = 2.6,
			zh = 3.333,
			en = 2.6
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
				uv0:Play104112044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, 100, 0)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[19].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(104112043).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112043", "story_v_out_104112.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_104112", "104112043", "story_v_out_104112.awb")

						uv0:RecordAudio("104112043", slot16)
						uv0:RecordAudio("104112043", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112043", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112043", "story_v_out_104112.awb")
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
	Play104112044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112044
		slot1.duration_ = 8.1

		if ({
			ja = 6.2,
			ko = 8.1,
			zh = 7.166,
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
				uv0:Play104112045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[33].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20302")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(104112044).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112044", "story_v_out_104112.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_104112", "104112044", "story_v_out_104112.awb")

						uv0:RecordAudio("104112044", slot10)
						uv0:RecordAudio("104112044", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112044", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112044", "story_v_out_104112.awb")
				end

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
	Play104112045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112045
		slot1.duration_ = 5.1

		if ({
			ja = 3.1,
			ko = 3.066,
			zh = 3.733,
			en = 5.1
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
				uv0:Play104112046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[65].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_20301")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(104112045).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112045", "story_v_out_104112.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_104112", "104112045", "story_v_out_104112.awb")

						uv0:RecordAudio("104112045", slot10)
						uv0:RecordAudio("104112045", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112045", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112045", "story_v_out_104112.awb")
				end

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
	Play104112046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112046
		slot1.duration_ = 7.833

		if ({
			ja = 4.166,
			ko = 2.833,
			zh = 1.999999999999,
			en = 7.833
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
				uv0:Play104112047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story", "se_story_robot_short", "")
			end

			if uv0.actors_["2043_tpose"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2043_tpose == nil then
				uv0.var_.characterEffect2043_tpose = uv0.actors_["2043_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect2043_tpose then
					uv0.var_.characterEffect2043_tpose.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2043_tpose then
				uv0.var_.characterEffect2043_tpose.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2043_tpose = uv0.actors_["2043_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2043_tpose, Vector3.New(0, -0.95, -3.2), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -0.95, -3.2)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("2043_tpose", "StoryTimeline/CharAction/story2043/story2043action/2043action1_1")
			end

			slot12 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[29].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(104112046).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112046", "story_v_out_104112.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_104112", "104112046", "story_v_out_104112.awb")

						uv0:RecordAudio("104112046", slot20)
						uv0:RecordAudio("104112046", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112046", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112046", "story_v_out_104112.awb")
				end

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
	Play104112047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112047
		slot1.duration_ = 3.4

		if ({
			ja = 3.4,
			ko = 3.1,
			zh = 3.333,
			en = 2.833
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
				uv0:Play104112048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2043_tpose == nil then
				uv0.var_.characterEffect2043_tpose = uv0.actors_["2043_tpose"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2043_tpose then
					uv0.var_.characterEffect2043_tpose.fillFlat = true
					uv0.var_.characterEffect2043_tpose.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2043_tpose then
				uv0.var_.characterEffect2043_tpose.fillFlat = true
				uv0.var_.characterEffect2043_tpose.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos2043_tpose = uv0.actors_["2043_tpose"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2043_tpose, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, 100, 0)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos3009ui_story = uv0.actors_["3009ui_story"].transform.localPosition

				uv0:ShowWeapon(uv0.var_["3009ui_story" .. "Animator"].transform, true)
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos3009ui_story, Vector3.New(0.7, -1.75, -4.8), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0.7, -1.75, -4.8)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/3009action/3009action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0104cva")
			end

			slot16 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(104112047).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112047", "story_v_out_104112.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_104112", "104112047", "story_v_out_104112.awb")

						uv0:RecordAudio("104112047", slot24)
						uv0:RecordAudio("104112047", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112047", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112047", "story_v_out_104112.awb")
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
	Play104112048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112048
		slot1.duration_ = 9.933

		if ({
			ja = 9.933,
			ko = 4.366,
			zh = 6.5,
			en = 3.966
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
				uv0:Play104112049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = true
					uv0.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = true
				uv0.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos4010ui_story = uv0.actors_["4010ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos4010ui_story, Vector3.New(-0.7, -1.59, -5.2), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-0.7, -1.59, -5.2)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			slot13 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(104112048).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112048", "story_v_out_104112.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_104112", "104112048", "story_v_out_104112.awb")

						uv0:RecordAudio("104112048", slot21)
						uv0:RecordAudio("104112048", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112048", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112048", "story_v_out_104112.awb")
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
	Play104112049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112049
		slot1.duration_ = 5.6

		if ({
			ja = 5.6,
			ko = 3.133,
			zh = 5.033,
			en = 5
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
				uv0:Play104112050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = true
					uv0.var_.characterEffect4010ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = true
				uv0.var_.characterEffect4010ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("3009ui_story", "StoryTimeline/CharAction/story3009/3009action/3009action2_1")
			end

			slot10 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[43].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112049).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112049", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112049", "story_v_out_104112.awb")

						uv0:RecordAudio("104112049", slot18)
						uv0:RecordAudio("104112049", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112049", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112049", "story_v_out_104112.awb")
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
	Play104112050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 104112050
		slot1.duration_ = 7.466

		if ({
			ja = 5.833,
			ko = 5.9,
			zh = 7.466,
			en = 5.066
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
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect4010ui_story == nil then
				uv0.var_.characterEffect4010ui_story = uv0.actors_["4010ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect4010ui_story then
					uv0.var_.characterEffect4010ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect4010ui_story then
				uv0.var_.characterEffect4010ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect3009ui_story == nil then
				uv0.var_.characterEffect3009ui_story = uv0.actors_["3009ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect3009ui_story then
					uv0.var_.characterEffect3009ui_story.fillFlat = true
					uv0.var_.characterEffect3009ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect3009ui_story then
				uv0.var_.characterEffect3009ui_story.fillFlat = true
				uv0.var_.characterEffect3009ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("4010ui_story", "StoryTimeline/CharAction/story4010/story4010action/4010action4_1")
			end

			slot10 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[42].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(104112050).content)
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

				if manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_104112", "104112050", "story_v_out_104112.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_104112", "104112050", "story_v_out_104112.awb")

						uv0:RecordAudio("104112050", slot18)
						uv0:RecordAudio("104112050", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_104112", "104112050", "story_v_out_104112.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_104112", "104112050", "story_v_out_104112.awb")
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/B14"
	},
	voices = {
		"story_v_out_104112.awb"
	}
}
