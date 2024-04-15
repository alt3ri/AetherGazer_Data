return {
	Play112302001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302001
		slot1.duration_ = 7.333

		if ({
			ja = 7.333,
			ko = 5.633,
			zh = 6.633,
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
				uv0:Play112302002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1084"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1084"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1084 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084, Vector3.New(-450, -450, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-450, -450, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot7
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				if uv0.var_.highlightMatValue1084 then
					slot9 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot6) / slot7)
					slot10 = uv0.var_.highlightMatValue1084
					slot11 = slot10.color
					slot11.r = slot9
					slot11.g = slot9
					slot11.b = slot9
					slot10.color = slot11
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.highlightMatValue1084 then
				slot8 = 1

				slot5.transform:SetSiblingIndex(1)

				slot9 = uv0.var_.highlightMatValue1084
				slot10 = slot9.color
				slot10.r = slot8
				slot10.g = slot8
				slot10.b = slot8
				slot9.color = slot10
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if uv0.actors_["1084"]:GetComponent("Image") then
					uv0.var_.alphaMatValue1084 = slot10
					uv0.var_.alphaOldValue1084 = slot10.color.a
				end

				uv0.var_.alphaOldValue1084 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				if uv0.var_.alphaMatValue1084 then
					slot13 = uv0.var_.alphaMatValue1084.color
					slot13.a = Mathf.Lerp(uv0.var_.alphaOldValue1084, 1, (uv0.time_ - slot9) / slot10)
					uv0.var_.alphaMatValue1084.color = slot13
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.alphaMatValue1084 then
				slot11 = uv0.var_.alphaMatValue1084
				slot12 = slot11.color
				slot12.a = 1
				slot11.color = slot12
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot12 = 0.55

			if 0.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot13 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot13:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot13:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[6].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(112302001).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot12 or slot12 * utf8.len(slot16) / slot17) > 0 and slot12 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot11 + 0.3 then
						uv0.duration_ = slot19 + slot11
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302001", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302001", "story_v_out_112302.awb") / 1000 + slot11 then
						uv0.duration_ = slot20 + slot11
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_112302", "112302001", "story_v_out_112302.awb")

						uv0:RecordAudio("112302001", slot21)
						uv0:RecordAudio("112302001", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302001", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302001", "story_v_out_112302.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot12 = math.max(slot12, uv0.talkMaxDuration)

			if slot11 + 0.3 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
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
	Play112302002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302002
		slot1.duration_ = 9.9

		if ({
			ja = 9.9,
			ko = 7.233,
			zh = 5.566,
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
				uv0:Play112302003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1148"] == nil then
				slot2 = Object.Instantiate(uv0.imageGo_, uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot3 = slot2:GetComponent(typeof(Image))
				slot3.sprite = getSpriteWithoutAtlas("TextureConfig/Character/Portrait/" .. slot1)

				slot3:SetNativeSize()

				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1148"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1148 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1148, Vector3.New(450, -560, 180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(450, -560, 180)
			end

			slot5 = uv0.actors_["1084"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1084 = slot5.localPosition
				slot5.localScale = Vector3.New(1, 1, 1)
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084, Vector3.New(-450, -450, 0), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-450, -450, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot10
			end

			slot10 = 0.2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				if uv0.var_.highlightMatValue1084 then
					slot12 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot9) / slot10)
					slot13 = uv0.var_.highlightMatValue1084
					slot14 = slot13.color
					slot14.r = slot12
					slot14.g = slot12
					slot14.b = slot12
					slot13.color = slot14
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.highlightMatValue1084 then
				slot11 = 0.5
				slot12 = uv0.var_.highlightMatValue1084
				slot13 = slot12.color
				slot13.r = slot11
				slot13.g = slot11
				slot13.b = slot11
				slot12.color = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot13
			end

			slot13 = 0.2

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				if uv0.var_.highlightMatValue1148 then
					slot15 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot12) / slot13)
					slot16 = uv0.var_.highlightMatValue1148
					slot17 = slot16.color
					slot17.r = slot15
					slot17.g = slot15
					slot17.b = slot15
					slot16.color = slot17
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.highlightMatValue1148 then
				slot14 = 1

				slot11.transform:SetSiblingIndex(1)

				slot15 = uv0.var_.highlightMatValue1148
				slot16 = slot15.color
				slot16.r = slot14
				slot16.g = slot14
				slot16.b = slot14
				slot15.color = slot16
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				if uv0.actors_["1148"]:GetComponent("Image") then
					uv0.var_.alphaMatValue1148 = slot16
					uv0.var_.alphaOldValue1148 = slot16.color.a
				end

				uv0.var_.alphaOldValue1148 = 0
			end

			slot16 = 0.5

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				if uv0.var_.alphaMatValue1148 then
					slot19 = uv0.var_.alphaMatValue1148.color
					slot19.a = Mathf.Lerp(uv0.var_.alphaOldValue1148, 1, (uv0.time_ - slot15) / slot16)
					uv0.var_.alphaMatValue1148.color = slot19
				end
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 and uv0.var_.alphaMatValue1148 then
				slot17 = uv0.var_.alphaMatValue1148
				slot18 = slot17.color
				slot18.a = 1
				slot17.color = slot18
			end

			slot18 = 0.7

			if 0.5 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
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

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(112302002).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 then
						uv0.duration_ = slot24 + slot17
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302002", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302002", "story_v_out_112302.awb") / 1000 + slot17 then
						uv0.duration_ = slot25 + slot17
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						slot26 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_112302", "112302002", "story_v_out_112302.awb")

						uv0:RecordAudio("112302002", slot26)
						uv0:RecordAudio("112302002", slot26)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302002", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302002", "story_v_out_112302.awb")
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
	Play112302003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302003
		slot1.duration_ = 12.866

		if ({
			ja = 12.866,
			ko = 10.366,
			zh = 11.2,
			en = 9.8
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
				uv0:Play112302004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302003).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302003", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302003", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302003", "story_v_out_112302.awb")

						uv0:RecordAudio("112302003", slot16)
						uv0:RecordAudio("112302003", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302003", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302003", "story_v_out_112302.awb")
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
	Play112302004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302004
		slot1.duration_ = 8.4

		if ({
			ja = 8.4,
			ko = 7.933,
			zh = 7.166,
			en = 8.1
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
				uv0:Play112302005(uv1)
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
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(112302004).content)
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

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302004", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302004", "story_v_out_112302.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_112302", "112302004", "story_v_out_112302.awb")

						uv0:RecordAudio("112302004", slot10)
						uv0:RecordAudio("112302004", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302004", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302004", "story_v_out_112302.awb")
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
	Play112302005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302005
		slot1.duration_ = 8.633

		if ({
			ja = 8.633,
			ko = 7.4,
			zh = 4.7,
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
				uv0:Play112302006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302005).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302005", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302005", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302005", "story_v_out_112302.awb")

						uv0:RecordAudio("112302005", slot16)
						uv0:RecordAudio("112302005", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302005", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302005", "story_v_out_112302.awb")
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
	Play112302006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302006
		slot1.duration_ = 12.833

		if ({
			ja = 10.066,
			ko = 12.833,
			zh = 8.466,
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
				uv0:Play112302007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(112302006).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302006", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302006", "story_v_out_112302.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_112302", "112302006", "story_v_out_112302.awb")

						uv0:RecordAudio("112302006", slot10)
						uv0:RecordAudio("112302006", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302006", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302006", "story_v_out_112302.awb")
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
	Play112302007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302007
		slot1.duration_ = 4.166

		if ({
			ja = 2.999999999999,
			ko = 4.166,
			zh = 3,
			en = 2.999999999999
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
				uv0:Play112302008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302007).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302007", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302007", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302007", "story_v_out_112302.awb")

						uv0:RecordAudio("112302007", slot16)
						uv0:RecordAudio("112302007", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302007", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302007", "story_v_out_112302.awb")
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
	Play112302008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302008
		slot1.duration_ = 3.2

		if ({
			ja = 2.999999999999,
			ko = 2.999999999999,
			zh = 3.2,
			en = 2.999999999999
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
				uv0:Play112302009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302008).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (6 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302008", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302008", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302008", "story_v_out_112302.awb")

						uv0:RecordAudio("112302008", slot16)
						uv0:RecordAudio("112302008", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302008", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302008", "story_v_out_112302.awb")
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
	Play112302009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302009
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play112302010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1148 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1148
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1148 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1148
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 1.125

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(112302009).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play112302010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302010
		slot1.duration_ = 8.933

		if ({
			ja = 8.666,
			ko = 8.933,
			zh = 6.933,
			en = 7.866
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
				uv0:Play112302011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1148 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1148
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1148 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1148
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			slot5 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
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

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(112302010).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302010", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302010", "story_v_out_112302.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_112302", "112302010", "story_v_out_112302.awb")

						uv0:RecordAudio("112302010", slot13)
						uv0:RecordAudio("112302010", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302010", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302010", "story_v_out_112302.awb")
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
	Play112302011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302011
		slot1.duration_ = 11.333

		if ({
			ja = 11.333,
			ko = 9.9,
			zh = 8.933,
			en = 11.1
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
				uv0:Play112302012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(112302011).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (53 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302011", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302011", "story_v_out_112302.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_112302", "112302011", "story_v_out_112302.awb")

						uv0:RecordAudio("112302011", slot10)
						uv0:RecordAudio("112302011", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302011", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302011", "story_v_out_112302.awb")
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
	Play112302012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302012
		slot1.duration_ = 2.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play112302013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302012).content)
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

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302012", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302012", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302012", "story_v_out_112302.awb")

						uv0:RecordAudio("112302012", slot16)
						uv0:RecordAudio("112302012", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302012", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302012", "story_v_out_112302.awb")
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
	Play112302013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302013
		slot1.duration_ = 6.833

		if ({
			ja = 5.8,
			ko = 5.1,
			zh = 6.833,
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
				uv0:Play112302014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302013).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302013", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302013", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302013", "story_v_out_112302.awb")

						uv0:RecordAudio("112302013", slot16)
						uv0:RecordAudio("112302013", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302013", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302013", "story_v_out_112302.awb")
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
	Play112302014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302014
		slot1.duration_ = 9

		if ({
			ja = 9,
			ko = 5.866,
			zh = 5.4,
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
				uv0:Play112302015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302014).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302014", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302014", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302014", "story_v_out_112302.awb")

						uv0:RecordAudio("112302014", slot16)
						uv0:RecordAudio("112302014", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302014", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302014", "story_v_out_112302.awb")
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
	Play112302015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302015
		slot1.duration_ = 4.8

		if ({
			ja = 3.4,
			ko = 3.333,
			zh = 4.8,
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
				uv0:Play112302016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302015).content)
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

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302015", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302015", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302015", "story_v_out_112302.awb")

						uv0:RecordAudio("112302015", slot16)
						uv0:RecordAudio("112302015", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302015", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302015", "story_v_out_112302.awb")
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
	Play112302016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302016
		slot1.duration_ = 9.4

		if ({
			ja = 9.4,
			ko = 6.066,
			zh = 5.6,
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
				uv0:Play112302017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(112302016).content)
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

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302016", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302016", "story_v_out_112302.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_112302", "112302016", "story_v_out_112302.awb")

						uv0:RecordAudio("112302016", slot10)
						uv0:RecordAudio("112302016", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302016", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302016", "story_v_out_112302.awb")
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
	Play112302017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302017
		slot1.duration_ = 2.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play112302018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302017).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302017", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302017", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302017", "story_v_out_112302.awb")

						uv0:RecordAudio("112302017", slot16)
						uv0:RecordAudio("112302017", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302017", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302017", "story_v_out_112302.awb")
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
	Play112302018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302018
		slot1.duration_ = 12.633

		if ({
			ja = 10.666,
			ko = 8.666,
			zh = 7.4,
			en = 12.633
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
				uv0:Play112302019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 0.5
				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 1

				slot4.transform:SetSiblingIndex(1)

				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302018).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302018", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302018", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302018", "story_v_out_112302.awb")

						uv0:RecordAudio("112302018", slot16)
						uv0:RecordAudio("112302018", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302018", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302018", "story_v_out_112302.awb")
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
	Play112302019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 112302019
		slot1.duration_ = 5.2

		if ({
			ja = 3.9,
			ko = 4.066,
			zh = 3.266,
			en = 5.2
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
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.actors_["1084"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1084 = slot3
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.highlightMatValue1084 then
					slot5 = Mathf.Lerp(0.5, 1, (uv0.time_ - slot2) / slot3)
					slot6 = uv0.var_.highlightMatValue1084
					slot7 = slot6.color
					slot7.r = slot5
					slot7.g = slot5
					slot7.b = slot5
					slot6.color = slot7
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.highlightMatValue1084 then
				slot4 = 1

				slot1.transform:SetSiblingIndex(1)

				slot5 = uv0.var_.highlightMatValue1084
				slot6 = slot5.color
				slot6.r = slot4
				slot6.g = slot4
				slot6.b = slot4
				slot5.color = slot6
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.actors_["1148"]:GetComponent("Image") then
				uv0.var_.highlightMatValue1148 = slot6
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.highlightMatValue1148 then
					slot8 = Mathf.Lerp(1, 0.5, (uv0.time_ - slot5) / slot6)
					slot9 = uv0.var_.highlightMatValue1148
					slot10 = slot9.color
					slot10.r = slot8
					slot10.g = slot8
					slot10.b = slot8
					slot9.color = slot10
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.highlightMatValue1148 then
				slot7 = 0.5
				slot8 = uv0.var_.highlightMatValue1148
				slot9 = slot8.color
				slot9.r = slot7
				slot9.g = slot7
				slot9.b = slot7
				slot8.color = slot9
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(112302019).content)
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

				if manager.audio:GetVoiceLength("story_v_out_112302", "112302019", "story_v_out_112302.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_112302", "112302019", "story_v_out_112302.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_112302", "112302019", "story_v_out_112302.awb")

						uv0:RecordAudio("112302019", slot16)
						uv0:RecordAudio("112302019", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_112302", "112302019", "story_v_out_112302.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_112302", "112302019", "story_v_out_112302.awb")
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
	assets = {},
	voices = {
		"story_v_out_112302.awb"
	}
}
