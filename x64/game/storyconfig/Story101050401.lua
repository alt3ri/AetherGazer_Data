return {
	Play105041001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1", "bgm_story_v1_battleground_1")
			end

			slot4 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_v0_environment_source", "se_story_v0_environment_source", "se_story_v0_environment_source")
			end

			if uv0.bgs_.B12a == nil then
				slot6 = Object.Instantiate(uv0.paintGo_)
				slot6:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot5)
				slot6.name = slot5
				slot6.transform.parent = uv0.stage_.transform
				slot6.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot5] = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if uv0.bgs_.B12a:GetComponent("SpriteRenderer") then
					slot8.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot9 = slot8.material
					uv0.var_.alphaOldValueB12a = slot9:GetColor("_Color").a
					uv0.var_.alphaMatValueB12a = slot9
				end

				uv0.var_.alphaOldValueB12a = 0
			end

			slot8 = 1.5

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.alphaMatValueB12a then
					slot11 = uv0.var_.alphaMatValueB12a
					slot12 = slot11:GetColor("_Color")
					slot12.a = Mathf.Lerp(uv0.var_.alphaOldValueB12a, 1, (uv0.time_ - slot7) / slot8)

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueB12a then
				slot9 = uv0.var_.alphaMatValueB12a
				slot10 = slot9:GetColor("_Color")
				slot10.a = 1

				slot9:SetColor("_Color", slot10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				slot10 = manager.ui.mainCamera.transform.localPosition
				slot12 = uv0.bgs_.B12a
				slot12.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot10.x, slot10.y, 0)
				slot12.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot12:GetComponent("SpriteRenderer") and slot13.sprite then
					slot16 = manager.ui.mainCameraCom_
					slot17 = 2 * (slot12.transform.localPosition - slot10).z * Mathf.Tan(slot16.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot23 = slot17 * slot16.aspect / slot13.sprite.bounds.size.x > slot17 / slot13.sprite.bounds.size.y and slot21 or slot22
					slot12.transform.localScale = Vector3.New(slot23, slot23, 0)
				end

				for slot17, slot18 in pairs(uv0.bgs_) do
					if slot17 ~= "B12a" then
						slot18.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot10 + 2 and uv0.time_ < slot10 + slot11 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot13 = 0.2

			if 2 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot14 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot14:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot14:setOnComplete(System.Action(function ()
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

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(105041001).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 + 0.3 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot13 = math.max(slot13, uv0.talkMaxDuration)

			if slot12 + 0.3 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
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
	Play105041002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041002
		slot1.duration_ = 2.9

		if ({
			ja = 2.9,
			ko = 2.6,
			zh = 2.533,
			en = 1.8
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
				uv0:Play105041003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041002).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041002", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041002", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041002", "story_v_out_105041.awb")

						uv0:RecordAudio("105041002", slot10)
						uv0:RecordAudio("105041002", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041002", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041002", "story_v_out_105041.awb")
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
	Play105041003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041003
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			ko = 7.8,
			zh = 6.033,
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
				uv0:Play105041004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041003).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041003", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041003", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041003", "story_v_out_105041.awb")

						uv0:RecordAudio("105041003", slot10)
						uv0:RecordAudio("105041003", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041003", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041003", "story_v_out_105041.awb")
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
	Play105041004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041004
		slot1.duration_ = 5.066

		if ({
			ja = 4.266,
			ko = 5.066,
			zh = 2.366,
			en = 2.933
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
				uv0:Play105041005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1036ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1036ui_story == nil then
				uv0.var_.characterEffect1036ui_story = uv0.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1036ui_story then
					uv0.var_.characterEffect1036ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1036ui_story then
				uv0.var_.characterEffect1036ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1036ui_story = uv0.actors_["1036ui_story"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -1.09, -5.78)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/1036/1036action/1036action7_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1036ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot11 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(105041004).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041004", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041004", "story_v_out_105041.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105041", "105041004", "story_v_out_105041.awb")

						uv0:RecordAudio("105041004", slot19)
						uv0:RecordAudio("105041004", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041004", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041004", "story_v_out_105041.awb")
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
	Play105041005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041005
		slot1.duration_ = 9.666

		if ({
			ja = 9.666,
			ko = 5.533,
			zh = 6.133,
			en = 6.9
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
				uv0:Play105041006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1019ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1036ui_story == nil then
				uv0.var_.characterEffect1036ui_story = uv0.actors_["1036ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1036ui_story then
					uv0.var_.characterEffect1036ui_story.fillFlat = true
					uv0.var_.characterEffect1036ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1036ui_story then
				uv0.var_.characterEffect1036ui_story.fillFlat = true
				uv0.var_.characterEffect1036ui_story.fillRatio = 0.5
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1036ui_story = uv0.actors_["1036ui_story"].transform.localPosition
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1036ui_story, Vector3.New(-0.7, -1.09, -5.78), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(-0.7, -1.09, -5.78)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.var_.moveOldPos1036ui_story = uv0.actors_["1036ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1036ui_story, Vector3.New(0, -1.09, -5.78), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(0, -1.09, -5.78)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot16 = 0.001

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot14.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0.7, -1.08, -5.9), (uv0.time_ - slot15) / slot16)
				slot20 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot20.x, slot20.y, slot20.z)
				slot21 = slot14.localEulerAngles
				slot21.z = 0
				slot21.x = 0
				slot14.localEulerAngles = slot21
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot14.localPosition = Vector3.New(0.7, -1.08, -5.9)
				slot19 = manager.ui.mainCamera.transform.position - slot14.position
				slot14.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot14.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot14.localEulerAngles = slot20
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019action/1019action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot20 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot23 = uv0:FormatText(uv0:GetWordFromCfg(105041005).content)
				uv0.text_.text = slot23

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot20 or slot20 * utf8.len(slot23) / slot24) > 0 and slot20 < slot26 then
					uv0.talkMaxDuration = slot26

					if uv0.duration_ < slot26 + slot19 then
						uv0.duration_ = slot26 + slot19
					end
				end

				uv0.text_.text = slot23
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041005", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041005", "story_v_out_105041.awb") / 1000 + slot19 then
						uv0.duration_ = slot27 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						slot28 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_105041", "105041005", "story_v_out_105041.awb")

						uv0:RecordAudio("105041005", slot28)
						uv0:RecordAudio("105041005", slot28)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041005", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041005", "story_v_out_105041.awb")
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
	Play105041006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041006
		slot1.duration_ = 2.733

		if ({
			ja = 2.733,
			ko = 1.999999999999,
			zh = 2.466,
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
				uv0:Play105041007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019actionlink/1019action456")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot4 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(105041006).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041006", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041006", "story_v_out_105041.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_105041", "105041006", "story_v_out_105041.awb")

						uv0:RecordAudio("105041006", slot12)
						uv0:RecordAudio("105041006", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041006", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041006", "story_v_out_105041.awb")
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
	Play105041007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041007
		slot1.duration_ = 5.033

		if ({
			ja = 5.033,
			ko = 4.166,
			zh = 4.933,
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
				uv0:Play105041008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1084ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1036ui_story = uv0.actors_["1036ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1036ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
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
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot12) / slot13)
				slot17 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot11.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot11.localEulerAngles = slot18
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 then
				slot11.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot16 = manager.ui.mainCamera.transform.position - slot11.position
				slot11.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot11.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot11.localEulerAngles = slot17
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot17 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot20 = uv0:FormatText(uv0:GetWordFromCfg(105041007).content)
				uv0.text_.text = slot20

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot17 or slot17 * utf8.len(slot20) / slot21) > 0 and slot17 < slot23 then
					uv0.talkMaxDuration = slot23

					if uv0.duration_ < slot23 + slot16 then
						uv0.duration_ = slot23 + slot16
					end
				end

				uv0.text_.text = slot20
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041007", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041007", "story_v_out_105041.awb") / 1000 + slot16 then
						uv0.duration_ = slot24 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						slot25 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_105041", "105041007", "story_v_out_105041.awb")

						uv0:RecordAudio("105041007", slot25)
						uv0:RecordAudio("105041007", slot25)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041007", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041007", "story_v_out_105041.awb")
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
	Play105041008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041008
		slot1.duration_ = 4.2

		if ({
			ja = 2.066,
			ko = 2.766,
			zh = 2.7,
			en = 4.2
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
				uv0:Play105041009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1011ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.1

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.1

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot6) / slot7)
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot9) / slot10)
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
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot13 = 0.001

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot11.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot12) / slot13)
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

			slot15 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				uv0.callingController_:SetSelectedState("normal")

				slot18 = uv0:FormatText(uv0:GetWordFromCfg(105041008).content)
				uv0.text_.text = slot18

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot15 or slot15 * utf8.len(slot18) / slot19) > 0 and slot15 < slot21 then
					uv0.talkMaxDuration = slot21

					if uv0.duration_ < slot21 + slot14 then
						uv0.duration_ = slot21 + slot14
					end
				end

				uv0.text_.text = slot18
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041008", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041008", "story_v_out_105041.awb") / 1000 + slot14 then
						uv0.duration_ = slot22 + slot14
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						slot23 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_105041", "105041008", "story_v_out_105041.awb")

						uv0:RecordAudio("105041008", slot23)
						uv0:RecordAudio("105041008", slot23)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041008", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041008", "story_v_out_105041.awb")
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
	Play105041009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041009
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = true
					uv0.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = true
				uv0.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1011ui_story = uv0.actors_["1011ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1011ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019action/1019action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot16 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(105041009).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041009", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041009", "story_v_out_105041.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105041", "105041009", "story_v_out_105041.awb")

						uv0:RecordAudio("105041009", slot24)
						uv0:RecordAudio("105041009", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041009", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041009", "story_v_out_105041.awb")
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
	Play105041010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041010
		slot1.duration_ = 3.266

		if ({
			ja = 2.333,
			ko = 2.766,
			zh = 3.233,
			en = 3.266
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
				uv0:Play105041011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -0.97, -6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot13 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(105041010).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot12 then
						uv0.duration_ = slot19 + slot12
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041010", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041010", "story_v_out_105041.awb") / 1000 + slot12 then
						uv0.duration_ = slot20 + slot12
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_105041", "105041010", "story_v_out_105041.awb")

						uv0:RecordAudio("105041010", slot21)
						uv0:RecordAudio("105041010", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041010", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041010", "story_v_out_105041.awb")
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
	Play105041011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041011
		slot1.duration_ = 5.766

		if ({
			ja = 5.766,
			ko = 3.333,
			zh = 5.133,
			en = 3.633
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
				uv0:Play105041012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot11) / slot12)
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

			slot14 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(105041011).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041011", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041011", "story_v_out_105041.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_105041", "105041011", "story_v_out_105041.awb")

						uv0:RecordAudio("105041011", slot22)
						uv0:RecordAudio("105041011", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041011", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041011", "story_v_out_105041.awb")
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
	Play105041012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041012
		slot1.duration_ = 2.666

		if ({
			ja = 2.533,
			ko = 2.666,
			zh = 1.5,
			en = 0.999999999999
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
				uv0:Play105041013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = true
					uv0.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = true
				uv0.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0, -1.08, -5.9), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -1.08, -5.9)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3202cva")
			end

			slot12 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(105041012).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041012", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041012", "story_v_out_105041.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_105041", "105041012", "story_v_out_105041.awb")

						uv0:RecordAudio("105041012", slot20)
						uv0:RecordAudio("105041012", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041012", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041012", "story_v_out_105041.awb")
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
	Play105041013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041013
		slot1.duration_ = 4.433

		if ({
			ja = 2.6,
			ko = 2.8,
			zh = 4.433,
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
				uv0:Play105041014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			slot8 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[37].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1011")

				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(105041013).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (8 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041013", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041013", "story_v_out_105041.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_105041", "105041013", "story_v_out_105041.awb")

						uv0:RecordAudio("105041013", slot16)
						uv0:RecordAudio("105041013", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041013", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041013", "story_v_out_105041.awb")
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
	Play105041014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041014
		slot1.duration_ = 3.166

		if ({
			ja = 2.533,
			ko = 2.766,
			zh = 2.466,
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
				uv0:Play105041015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1011ui_story == nil then
				uv0.var_.characterEffect1011ui_story = uv0.actors_["1011ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1011ui_story then
					uv0.var_.characterEffect1011ui_story.fillFlat = true
					uv0.var_.characterEffect1011ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1011ui_story then
				uv0.var_.characterEffect1011ui_story.fillFlat = true
				uv0.var_.characterEffect1011ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.97, -6)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action13_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot16 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(105041014).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041014", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041014", "story_v_out_105041.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_105041", "105041014", "story_v_out_105041.awb")

						uv0:RecordAudio("105041014", slot24)
						uv0:RecordAudio("105041014", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041014", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041014", "story_v_out_105041.awb")
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
	Play105041015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041015
		slot1.duration_ = 6.433

		if ({
			ja = 4.933,
			ko = 5.9,
			zh = 5.766,
			en = 6.433
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
				uv0:Play105041016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot3 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(105041015).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041015", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041015", "story_v_out_105041.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_105041", "105041015", "story_v_out_105041.awb")

						uv0:RecordAudio("105041015", slot11)
						uv0:RecordAudio("105041015", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041015", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041015", "story_v_out_105041.awb")
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
	Play105041016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041016
		slot1.duration_ = 1.733

		if ({
			ja = 1.733,
			ko = 1.2,
			zh = 1.066,
			en = 0.9
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
				uv0:Play105041017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			slot11 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(105041016).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041016", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041016", "story_v_out_105041.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_105041", "105041016", "story_v_out_105041.awb")

						uv0:RecordAudio("105041016", slot19)
						uv0:RecordAudio("105041016", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041016", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041016", "story_v_out_105041.awb")
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
	Play105041017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			slot5 = 1.05

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(105041017).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play105041018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041018
		slot1.duration_ = 4.466

		if ({
			ja = 4.466,
			ko = 4.366,
			zh = 2.866,
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
				uv0:Play105041019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041018).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041018", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041018", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041018", "story_v_out_105041.awb")

						uv0:RecordAudio("105041018", slot10)
						uv0:RecordAudio("105041018", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041018", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041018", "story_v_out_105041.awb")
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
	Play105041019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041019
		slot1.duration_ = 8.6

		if ({
			ja = 8.6,
			ko = 7.633,
			zh = 7.4,
			en = 8.166
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
				uv0:Play105041020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041019).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041019", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041019", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041019", "story_v_out_105041.awb")

						uv0:RecordAudio("105041019", slot10)
						uv0:RecordAudio("105041019", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041019", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041019", "story_v_out_105041.awb")
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
	Play105041020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041020
		slot1.duration_ = 4.766

		if ({
			ja = 4.5,
			ko = 3.7,
			zh = 4,
			en = 4.766
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
				uv0:Play105041021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (uv0.time_ - slot5) / slot6)
				slot10 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot4.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot4.localEulerAngles = slot11
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -0.97, -6)
				slot9 = manager.ui.mainCamera.transform.position - slot4.position
				slot4.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot4.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot4.localEulerAngles = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action13_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2103cva")
			end

			slot10 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(105041020).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041020", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041020", "story_v_out_105041.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_105041", "105041020", "story_v_out_105041.awb")

						uv0:RecordAudio("105041020", slot18)
						uv0:RecordAudio("105041020", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041020", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041020", "story_v_out_105041.awb")
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
	Play105041021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041021
		slot1.duration_ = 3.1

		if ({
			ja = 2.966,
			ko = 2.8,
			zh = 3.1,
			en = 2.533
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
				uv0:Play105041022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0.033 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0.7, -0.97, -6), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -0.97, -6)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (uv0.time_ - slot11) / slot12)
				slot16 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot16.x, slot16.y, slot16.z)
				slot17 = slot10.localEulerAngles
				slot17.z = 0
				slot17.x = 0
				slot10.localEulerAngles = slot17
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -0.97, -6)
				slot15 = manager.ui.mainCamera.transform.position - slot10.position
				slot10.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot10.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot10.localEulerAngles = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(-0.7, -1.08, -5.9), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(-0.7, -1.08, -5.9)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/1019/1019action/1019action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot19 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot22 = uv0:FormatText(uv0:GetWordFromCfg(105041021).content)
				uv0.text_.text = slot22

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot19 or slot19 * utf8.len(slot22) / slot23) > 0 and slot19 < slot25 then
					uv0.talkMaxDuration = slot25

					if uv0.duration_ < slot25 + slot18 then
						uv0.duration_ = slot25 + slot18
					end
				end

				uv0.text_.text = slot22
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041021", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041021", "story_v_out_105041.awb") / 1000 + slot18 then
						uv0.duration_ = slot26 + slot18
					end

					if slot21.prefab_name ~= "" and uv0.actors_[slot21.prefab_name] ~= nil then
						slot27 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot21.prefab_name].transform, "story_v_out_105041", "105041021", "story_v_out_105041.awb")

						uv0:RecordAudio("105041021", slot27)
						uv0:RecordAudio("105041021", slot27)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041021", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041021", "story_v_out_105041.awb")
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
	Play105041022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041022
		slot1.duration_ = 1.1

		if ({
			ja = 0.999999999999,
			ko = 1.066,
			zh = 1.1,
			en = 1
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
				uv0:Play105041023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			slot9 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(105041022).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041022", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041022", "story_v_out_105041.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_105041", "105041022", "story_v_out_105041.awb")

						uv0:RecordAudio("105041022", slot17)
						uv0:RecordAudio("105041022", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041022", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041022", "story_v_out_105041.awb")
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
	Play105041023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041023
		slot1.duration_ = 1.666

		if ({
			ja = 1.666,
			ko = 1.2,
			zh = 1.133,
			en = 1.466
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
				uv0:Play105041024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.1

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1019ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot9 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(105041023).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041023", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041023", "story_v_out_105041.awb") / 1000 + slot8 then
						uv0.duration_ = slot16 + slot8
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_105041", "105041023", "story_v_out_105041.awb")

						uv0:RecordAudio("105041023", slot17)
						uv0:RecordAudio("105041023", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041023", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041023", "story_v_out_105041.awb")
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
	Play105041024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041024
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1019ui_story == nil then
				uv0.var_.characterEffect1019ui_story = uv0.actors_["1019ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1019ui_story then
					uv0.var_.characterEffect1019ui_story.fillFlat = true
					uv0.var_.characterEffect1019ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1019ui_story then
				uv0.var_.characterEffect1019ui_story.fillFlat = true
				uv0.var_.characterEffect1019ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1019ui_story = uv0.actors_["1019ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1019ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			slot11 = 0.725

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(105041024).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot11 or slot11 * utf8.len(slot13) / slot14) > 0 and slot11 < slot16 then
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
	Play105041025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041025
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.525

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(105041025).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (61 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play105041026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041026
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPosB12a = uv0.bgs_.B12a.transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPosB12a, Vector3.New(0, -100, 10), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -100, 10)
			end

			if uv0.bgs_.S0502 == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.S0502
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "S0502" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			slot7 = 0.825

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(105041026).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
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
	Play105041027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041027
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.35

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(105041027).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (54 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play105041028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041028
		slot1.duration_ = 6.266

		if ({
			ja = 6.266,
			ko = 3.2,
			zh = 4.633,
			en = 5.266
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
				uv0:Play105041029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041028).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041028", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041028", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041028", "story_v_out_105041.awb")

						uv0:RecordAudio("105041028", slot10)
						uv0:RecordAudio("105041028", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041028", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041028", "story_v_out_105041.awb")
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
	Play105041029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041029
		slot1.duration_ = 3.1

		if ({
			ja = 2.6,
			ko = 1.5,
			zh = 3.1,
			en = 2.566
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
				uv0:Play105041030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041029).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041029", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041029", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041029", "story_v_out_105041.awb")

						uv0:RecordAudio("105041029", slot10)
						uv0:RecordAudio("105041029", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041029", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041029", "story_v_out_105041.awb")
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
	Play105041030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041030
		slot1.duration_ = 3.566

		if ({
			ja = 3.566,
			ko = 1.566,
			zh = 1.833,
			en = 1.666
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
				uv0:Play105041031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041030).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041030", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041030", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041030", "story_v_out_105041.awb")

						uv0:RecordAudio("105041030", slot10)
						uv0:RecordAudio("105041030", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041030", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041030", "story_v_out_105041.awb")
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
	Play105041031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041031
		slot1.duration_ = 2.766

		if ({
			ja = 1.9,
			ko = 1.8,
			zh = 1.566,
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
				uv0:Play105041032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041031).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041031", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041031", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041031", "story_v_out_105041.awb")

						uv0:RecordAudio("105041031", slot10)
						uv0:RecordAudio("105041031", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041031", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041031", "story_v_out_105041.awb")
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
	Play105041032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041032
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(105041032).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play105041033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041033
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041034(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(105041033).content)
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
	Play105041034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041034
		slot1.duration_ = 10.966

		if ({
			ja = 10.733,
			ko = 6.8,
			zh = 9.966,
			en = 10.966
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
				uv0:Play105041035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041034).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041034", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041034", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041034", "story_v_out_105041.awb")

						uv0:RecordAudio("105041034", slot10)
						uv0:RecordAudio("105041034", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041034", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041034", "story_v_out_105041.awb")
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
	Play105041035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041035
		slot1.duration_ = 4.266

		if ({
			ja = 3.366,
			ko = 3.266,
			zh = 2.766,
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
				uv0:Play105041036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041035).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041035", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041035", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041035", "story_v_out_105041.awb")

						uv0:RecordAudio("105041035", slot10)
						uv0:RecordAudio("105041035", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041035", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041035", "story_v_out_105041.awb")
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
	Play105041036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041036
		slot1.duration_ = 4.566

		if ({
			ja = 4.566,
			ko = 3.9,
			zh = 2.833,
			en = 3.133
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
				uv0:Play105041037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041036).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041036", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041036", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041036", "story_v_out_105041.awb")

						uv0:RecordAudio("105041036", slot10)
						uv0:RecordAudio("105041036", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041036", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041036", "story_v_out_105041.awb")
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
	Play105041037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041037
		slot1.duration_ = 4.933

		if ({
			ja = 4.2,
			ko = 4.266,
			zh = 3.6,
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
				uv0:Play105041038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041037).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041037", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041037", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041037", "story_v_out_105041.awb")

						uv0:RecordAudio("105041037", slot10)
						uv0:RecordAudio("105041037", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041037", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041037", "story_v_out_105041.awb")
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
	Play105041038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041038
		slot1.duration_ = 3.533

		if ({
			ja = 2.6,
			ko = 2.2,
			zh = 2.5,
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
				uv0:Play105041039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041038).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041038", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041038", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041038", "story_v_out_105041.awb")

						uv0:RecordAudio("105041038", slot10)
						uv0:RecordAudio("105041038", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041038", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041038", "story_v_out_105041.awb")
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
	Play105041039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041039
		slot1.duration_ = 7.3

		if ({
			ja = 6.333,
			ko = 5.7,
			zh = 5.233,
			en = 7.3
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
				uv0:Play105041040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[5].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1036")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041039).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041039", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041039", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041039", "story_v_out_105041.awb")

						uv0:RecordAudio("105041039", slot10)
						uv0:RecordAudio("105041039", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041039", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041039", "story_v_out_105041.awb")
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
	Play105041040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041040
		slot1.duration_ = 9.566

		if ({
			ja = 5.166,
			ko = 8.433,
			zh = 7.533,
			en = 9.566
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
				uv0:Play105041041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041040).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041040", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041040", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041040", "story_v_out_105041.awb")

						uv0:RecordAudio("105041040", slot10)
						uv0:RecordAudio("105041040", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041040", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041040", "story_v_out_105041.awb")
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
	Play105041041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041041
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play105041042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.85

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(105041041).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play105041042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041042
		slot1.duration_ = 7.233

		if ({
			ja = 5.4,
			ko = 4.5,
			zh = 6.866,
			en = 7.233
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
				uv0:Play105041043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041042).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041042", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041042", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041042", "story_v_out_105041.awb")

						uv0:RecordAudio("105041042", slot10)
						uv0:RecordAudio("105041042", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041042", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041042", "story_v_out_105041.awb")
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
	Play105041043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041043
		slot1.duration_ = 2.1

		if ({
			ja = 1.2,
			ko = 1.433,
			zh = 1.466,
			en = 2.1
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
				uv0:Play105041044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[13].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1019")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041043).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041043", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041043", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041043", "story_v_out_105041.awb")

						uv0:RecordAudio("105041043", slot10)
						uv0:RecordAudio("105041043", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041043", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041043", "story_v_out_105041.awb")
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
	Play105041044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041044
		slot1.duration_ = 14.766

		if ({
			ja = 14.766,
			ko = 10.8,
			zh = 12.433,
			en = 12.466
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
				uv0:Play105041045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041044).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041044", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041044", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041044", "story_v_out_105041.awb")

						uv0:RecordAudio("105041044", slot10)
						uv0:RecordAudio("105041044", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041044", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041044", "story_v_out_105041.awb")
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
	Play105041045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041045
		slot1.duration_ = 17.533

		if ({
			ja = 17.533,
			ko = 10.5,
			zh = 12.133,
			en = 12.566
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
				uv0:Play105041046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041045).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (50 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041045", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041045", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041045", "story_v_out_105041.awb")

						uv0:RecordAudio("105041045", slot10)
						uv0:RecordAudio("105041045", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041045", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041045", "story_v_out_105041.awb")
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
	Play105041046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041046
		slot1.duration_ = 5.2

		if ({
			ja = 4.5,
			ko = 3.4,
			zh = 5.2,
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
				uv0:Play105041047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[67].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1111")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041046).content)
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

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041046", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041046", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041046", "story_v_out_105041.awb")

						uv0:RecordAudio("105041046", slot10)
						uv0:RecordAudio("105041046", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041046", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041046", "story_v_out_105041.awb")
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
	Play105041047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 105041047
		slot1.duration_ = 2.666

		if ({
			ja = 2.666,
			ko = 2.2,
			zh = 2.266,
			en = 1.7
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
			slot2 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1084")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(105041047).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_105041", "105041047", "story_v_out_105041.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_105041", "105041047", "story_v_out_105041.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_105041", "105041047", "story_v_out_105041.awb")

						uv0:RecordAudio("105041047", slot10)
						uv0:RecordAudio("105041047", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_105041", "105041047", "story_v_out_105041.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_105041", "105041047", "story_v_out_105041.awb")
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/B12a",
		"Assets/UIResources/UI_AB/TextureConfig/Background/S0502"
	},
	voices = {
		"story_v_out_105041.awb"
	}
}
