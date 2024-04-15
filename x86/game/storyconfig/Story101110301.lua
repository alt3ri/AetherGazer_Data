return {
	Play111031001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031001
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(111031001).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 0.2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 9
			slot4 = 0.54
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(111031001).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(0.54, uv0.talkMaxDuration)

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot9 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot7, (uv0.time_ - slot2) / slot9)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot2 + slot9 and uv0.time_ < slot2 + slot9 + slot0 then
				uv0.fswtw_.percent = slot7

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot8
			end

			slot11 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot12 = 0

			if manager.audio:GetVoiceLength("story_v_out_111031", "111031001", "story_v_out_111031.awb") / 1000 > 0 and 1 < slot14 and uv0.duration_ < slot14 + slot12 then
				slot13 = slot14
				uv0.duration_ = slot14 + slot12
			end

			if slot12 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_111031", "111031001", "story_v_out_111031.awb")
			end
		end
	end,
	Play111031002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031002
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 29
			slot3 = 1.74
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(111031001).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.74, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot8 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot6, (uv0.time_ - slot1) / slot8)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot8 and uv0.time_ < slot1 + slot8 + slot0 then
				uv0.fswtw_.percent = slot6

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot7
			end

			slot9 = 0

			if manager.audio:GetVoiceLength("story_v_out_111031", "111031002", "story_v_out_111031.awb") / 1000 > 0 and 1 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_111031", "111031002", "story_v_out_111031.awb")
			end
		end
	end,
	Play111031003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031003
		slot1.duration_ = 1.259999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 21
			slot3 = 1.26
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(111031001).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.26, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot8 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot6, (uv0.time_ - slot1) / slot8)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot8 and uv0.time_ < slot1 + slot8 + slot0 then
				uv0.fswtw_.percent = slot6

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot7
			end

			slot9 = 0

			if manager.audio:GetVoiceLength("story_v_out_111031", "111031003", "story_v_out_111031.awb") / 1000 > 0 and 1 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_111031", "111031003", "story_v_out_111031.awb")
			end
		end
	end,
	Play111031004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031004
		slot1.duration_ = 10.243999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 29
			slot3 = 1.74
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(111031001).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.74, uv0.talkMaxDuration)

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot8 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot6, (uv0.time_ - slot1) / slot8)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot1 + slot8 and uv0.time_ < slot1 + slot8 + slot0 then
				uv0.fswtw_.percent = slot6

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot7
			end

			slot9 = 0

			if manager.audio:GetVoiceLength("story_v_out_111031", "111031004", "story_v_out_111031.awb") / 1000 > 0 and 10.244 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_111031", "111031004", "story_v_out_111031.awb")
			end
		end
	end,
	Play111031005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031005
		slot1.duration_ = 4.8

		if ({
			ja = 4.3,
			ko = 4.8,
			zh = 4.466,
			en = 3.566
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
				uv0:Play111031006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.D05 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.D05
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "D05" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.fswbg_:SetActive(false)
				uv0.dialog_:SetActive(true)
				uv0:ShowNextGo(false)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.bgs_.D05:GetComponent("SpriteRenderer") then
					slot6.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot7 = slot6.material
					uv0.var_.alphaOldValueD05 = slot7:GetColor("_Color").a
					uv0.var_.alphaMatValueD05 = slot7
				end

				uv0.var_.alphaOldValueD05 = 0
			end

			slot6 = 1.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.alphaMatValueD05 then
					slot9 = uv0.var_.alphaMatValueD05
					slot10 = slot9:GetColor("_Color")
					slot10.a = Mathf.Lerp(uv0.var_.alphaOldValueD05, 1, (uv0.time_ - slot5) / slot6)

					slot9:SetColor("_Color", slot10)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.alphaMatValueD05 then
				slot7 = uv0.var_.alphaMatValueD05
				slot8 = slot7:GetColor("_Color")
				slot8.a = 1

				slot7:SetColor("_Color", slot8)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot7 + 1.5 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot10 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story", "bgm_activity_1_1_hel_story.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot12 = 0.3

			if 1.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(111031005).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot12 or slot12 * utf8.len(slot16) / slot17) > 0 and slot12 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot11 + 0.3 then
						uv0.duration_ = slot19 + slot11
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031005", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031005", "story_v_out_111031.awb") / 1000 + slot11 then
						uv0.duration_ = slot20 + slot11
					end

					if slot15.prefab_name ~= "" and uv0.actors_[slot15.prefab_name] ~= nil then
						slot21 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot15.prefab_name].transform, "story_v_out_111031", "111031005", "story_v_out_111031.awb")

						uv0:RecordAudio("111031005", slot21)
						uv0:RecordAudio("111031005", slot21)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031005", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031005", "story_v_out_111031.awb")
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
	Play111031006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031006
		slot1.duration_ = 4.633

		if ({
			ja = 4.166,
			ko = 4.633,
			zh = 4.433,
			en = 4.5
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
				uv0:Play111031007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(111031006).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031006", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031006", "story_v_out_111031.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_111031", "111031006", "story_v_out_111031.awb")

						uv0:RecordAudio("111031006", slot10)
						uv0:RecordAudio("111031006", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031006", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031006", "story_v_out_111031.awb")
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
	Play111031007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031007
		slot1.duration_ = 6.6

		if ({
			ja = 3.433,
			ko = 6.6,
			zh = 3.366,
			en = 3.766
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
				uv0:Play111031008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[177].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_ganglati")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(111031007).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031007", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031007", "story_v_out_111031.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_111031", "111031007", "story_v_out_111031.awb")

						uv0:RecordAudio("111031007", slot10)
						uv0:RecordAudio("111031007", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031007", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031007", "story_v_out_111031.awb")
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
	Play111031008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031008
		slot1.duration_ = 3.9

		if ({
			ja = 1.999999999999,
			ko = 2.333,
			zh = 3.9,
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
				uv0:Play111031009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1094ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1094ui_story = uv0.actors_["1094ui_story"].transform.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1094ui_story, Vector3.New(0, -0.84, -6.1), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -0.84, -6.1)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/1094/1094action/1094action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1094ui_story == nil then
				uv0.var_.characterEffect1094ui_story = uv0.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect1094ui_story then
					uv0.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1094ui_story then
				uv0.var_.characterEffect1094ui_story.fillFlat = false
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(111031008).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031008", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031008", "story_v_out_111031.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_111031", "111031008", "story_v_out_111031.awb")

						uv0:RecordAudio("111031008", slot19)
						uv0:RecordAudio("111031008", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031008", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031008", "story_v_out_111031.awb")
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
	Play111031009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031009
		slot1.duration_ = 4

		if ({
			ja = 2.033,
			ko = 2,
			zh = 4,
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
				uv0:Play111031010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1094ui_story == nil then
				uv0.var_.characterEffect1094ui_story = uv0.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1094ui_story then
					uv0.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1094ui_story then
				uv0.var_.characterEffect1094ui_story.fillFlat = false
			end

			slot6 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(111031009).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
					uv0.talkMaxDuration = slot12

					if uv0.duration_ < slot12 + slot5 then
						uv0.duration_ = slot12 + slot5
					end
				end

				uv0.text_.text = slot9
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031009", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031009", "story_v_out_111031.awb") / 1000 + slot5 then
						uv0.duration_ = slot13 + slot5
					end

					if slot8.prefab_name ~= "" and uv0.actors_[slot8.prefab_name] ~= nil then
						slot14 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot8.prefab_name].transform, "story_v_out_111031", "111031009", "story_v_out_111031.awb")

						uv0:RecordAudio("111031009", slot14)
						uv0:RecordAudio("111031009", slot14)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031009", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031009", "story_v_out_111031.awb")
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
	Play111031010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1094ui_story == nil then
				uv0.var_.characterEffect1094ui_story = uv0.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1094ui_story then
					uv0.var_.characterEffect1094ui_story.fillFlat = true
					uv0.var_.characterEffect1094ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1094ui_story then
				uv0.var_.characterEffect1094ui_story.fillFlat = true
				uv0.var_.characterEffect1094ui_story.fillRatio = 0.5
			end

			slot5 = 0.75

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(111031010).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play111031011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031011
		slot1.duration_ = 1.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/1094/1094actionlink/1094action435")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1094ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1094ui_story == nil then
				uv0.var_.characterEffect1094ui_story = uv0.actors_["1094ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1094ui_story then
					uv0.var_.characterEffect1094ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1094ui_story then
				uv0.var_.characterEffect1094ui_story.fillFlat = false
			end

			slot7 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[181].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(111031011).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (6 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031011", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031011", "story_v_out_111031.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_111031", "111031011", "story_v_out_111031.awb")

						uv0:RecordAudio("111031011", slot15)
						uv0:RecordAudio("111031011", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031011", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031011", "story_v_out_111031.awb")
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
	Play111031012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031012
		slot1.duration_ = 7.266

		if ({
			ja = 7.266,
			ko = 6.366,
			zh = 6.133,
			en = 6.466
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
				uv0:Play111031013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.bgs_.D05:GetComponent("SpriteRenderer") then
					slot3.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot4 = slot3.material
					uv0.var_.alphaOldValueD05 = slot4:GetColor("_Color").a
					uv0.var_.alphaMatValueD05 = slot4
				end

				uv0.var_.alphaOldValueD05 = 1
			end

			slot3 = 1

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.alphaMatValueD05 then
					slot6 = uv0.var_.alphaMatValueD05
					slot7 = slot6:GetColor("_Color")
					slot7.a = Mathf.Lerp(uv0.var_.alphaOldValueD05, 0, (uv0.time_ - slot2) / slot3)

					slot6:SetColor("_Color", slot7)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.alphaMatValueD05 then
				slot4 = uv0.var_.alphaMatValueD05
				slot5 = slot4:GetColor("_Color")
				slot5.a = 0

				slot4:SetColor("_Color", slot5)
			end

			if uv0.bgs_.D12b == nil then
				slot5 = Object.Instantiate(uv0.paintGo_)
				slot5:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot4)
				slot5.name = slot4
				slot5.transform.parent = uv0.stage_.transform
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot4] = slot5
			end

			if 1 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				slot6 = manager.ui.mainCamera.transform.localPosition
				slot8 = uv0.bgs_.D12b
				slot8.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot6.x, slot6.y, 0)
				slot8.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot8:GetComponent("SpriteRenderer") and slot9.sprite then
					slot12 = manager.ui.mainCameraCom_
					slot13 = 2 * (slot8.transform.localPosition - slot6).z * Mathf.Tan(slot12.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot19 = slot13 * slot12.aspect / slot9.sprite.bounds.size.x > slot13 / slot9.sprite.bounds.size.y and slot17 or slot18
					slot8.transform.localScale = Vector3.New(slot19, slot19, 0)
				end

				for slot13, slot14 in pairs(uv0.bgs_) do
					if slot13 ~= "D12b" then
						slot14.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 1 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if uv0.bgs_.D12b:GetComponent("SpriteRenderer") then
					slot8.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot9 = slot8.material
					uv0.var_.alphaOldValueD12b = slot9:GetColor("_Color").a
					uv0.var_.alphaMatValueD12b = slot9
				end

				uv0.var_.alphaOldValueD12b = 0
			end

			slot8 = 1

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.alphaMatValueD12b then
					slot11 = uv0.var_.alphaMatValueD12b
					slot12 = slot11:GetColor("_Color")
					slot12.a = Mathf.Lerp(uv0.var_.alphaOldValueD12b, 1, (uv0.time_ - slot7) / slot8)

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueD12b then
				slot9 = uv0.var_.alphaMatValueD12b
				slot10 = slot9:GetColor("_Color")
				slot10.a = 1

				slot9:SetColor("_Color", slot10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1094ui_story = uv0.actors_["1094ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1094ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, 100, 0)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			if uv0.actors_["1048ui_story"] == nil then
				slot13 = Object.Instantiate(Asset.Load("Char/" .. slot12), uv0.stage_.transform)
				slot13.name = slot12
				slot13.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot12] = slot13
				slot13:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot13, typeof(DynamicBoneHelper)) then
					slot15:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot14.transform, false)

				uv0.var_[slot12 .. "Animator"] = slot14.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot12 .. "Animator"].applyRootMotion = true
				uv0.var_[slot12 .. "LipSync"] = slot14.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 2.00066666666667 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos1048ui_story = uv0.actors_["1048ui_story"].transform.localPosition
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1048ui_story, Vector3.New(-0.7, -0.8, -6.2), (uv0.time_ - slot14) / slot15)
				slot19 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot19.x, slot19.y, slot19.z)
				slot20 = slot13.localEulerAngles
				slot20.z = 0
				slot20.x = 0
				slot13.localEulerAngles = slot20
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(-0.7, -0.8, -6.2)
				slot18 = manager.ui.mainCamera.transform.position - slot13.position
				slot13.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot13.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot13.localEulerAngles = slot19
			end

			if 2.00066666666667 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/1048/1048action/1048action7_1")
			end

			if 2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:PlayTimeline("1048ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 2 < uv0.time_ and uv0.time_ <= slot19 + slot0 and uv0.var_.characterEffect1048ui_story == nil then
				uv0.var_.characterEffect1048ui_story = uv0.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot20 = 0.2

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				slot21 = (uv0.time_ - slot19) / slot20

				if uv0.var_.characterEffect1048ui_story then
					uv0.var_.characterEffect1048ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 and uv0.var_.characterEffect1048ui_story then
				uv0.var_.characterEffect1048ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot21 + 2 and uv0.time_ < slot21 + slot22 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot24 = 0.55

			if 2 < uv0.time_ and uv0.time_ <= slot23 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot25 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot25:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot25:setOnComplete(System.Action(function ()
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

				slot28 = uv0:FormatText(uv0:GetWordFromCfg(111031012).content)
				uv0.text_.text = slot28

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot24 or slot24 * utf8.len(slot28) / slot29) > 0 and slot24 < slot31 then
					uv0.talkMaxDuration = slot31

					if uv0.duration_ < slot31 + slot23 + 0.3 then
						uv0.duration_ = slot31 + slot23
					end
				end

				uv0.text_.text = slot28
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031012", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031012", "story_v_out_111031.awb") / 1000 + slot23 then
						uv0.duration_ = slot32 + slot23
					end

					if slot27.prefab_name ~= "" and uv0.actors_[slot27.prefab_name] ~= nil then
						slot33 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot27.prefab_name].transform, "story_v_out_111031", "111031012", "story_v_out_111031.awb")

						uv0:RecordAudio("111031012", slot33)
						uv0:RecordAudio("111031012", slot33)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031012", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031012", "story_v_out_111031.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot24 = math.max(slot24, uv0.talkMaxDuration)

			if slot23 + 0.3 <= uv0.time_ and uv0.time_ < slot23 + slot24 then
				uv0.typewritter.percent = (uv0.time_ - slot23) / slot24

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot23 + slot24 and uv0.time_ < slot23 + slot24 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play111031013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031013
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1048ui_story == nil then
				uv0.var_.characterEffect1048ui_story = uv0.actors_["1048ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1048ui_story then
					uv0.var_.characterEffect1048ui_story.fillFlat = true
					uv0.var_.characterEffect1048ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1048ui_story then
				uv0.var_.characterEffect1048ui_story.fillFlat = true
				uv0.var_.characterEffect1048ui_story.fillRatio = 0.5
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_activity_1_1", "se_story_activity_1_1_stone", "")
			end

			slot7 = 1.025

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(111031013).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
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
	Play111031014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(111031014).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play111031015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031015
		slot1.duration_ = 11.4

		if ({
			ja = 11.4,
			ko = 7.166,
			zh = 5.2,
			en = 6.7
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
				uv0:Play111031016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1039ui_story"] == nil then
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

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition

				uv0:ShowWeapon(uv0.var_["1039ui_story" .. "Animator"].transform, false)
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0.7, -1.01, -5.9)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039action/1039action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			slot11 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
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

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(111031015).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031015", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031015", "story_v_out_111031.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_111031", "111031015", "story_v_out_111031.awb")

						uv0:RecordAudio("111031015", slot19)
						uv0:RecordAudio("111031015", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031015", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031015", "story_v_out_111031.awb")
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
	Play111031016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031016
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(111031016).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
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
	Play111031017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031017
		slot1.duration_ = 4.7

		if ({
			ja = 4.7,
			ko = 3.466,
			zh = 3.8,
			en = 4.033
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
				uv0:Play111031018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1048ui_story = uv0.actors_["1048ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1048ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			if uv0.actors_["1084ui_story"] == nil then
				slot5 = Object.Instantiate(Asset.Load("Char/" .. slot4), uv0.stage_.transform)
				slot5.name = slot4
				slot5.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot4] = slot5
				slot5:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot5, typeof(DynamicBoneHelper)) then
					slot7:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot6.transform, false)

				uv0.var_[slot4 .. "Animator"] = slot6.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot4 .. "Animator"].applyRootMotion = true
				uv0.var_[slot4 .. "LipSync"] = slot6.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2104cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot15 = 0.2

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = true
					uv0.var_.characterEffect1039ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot14) / slot15)
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = true
				uv0.var_.characterEffect1039ui_story.fillRatio = 0.5
			end

			slot17 = 0.425

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

				slot20 = uv0:FormatText(uv0:GetWordFromCfg(111031017).content)
				uv0.text_.text = slot20

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot17 or slot17 * utf8.len(slot20) / slot21) > 0 and slot17 < slot23 then
					uv0.talkMaxDuration = slot23

					if uv0.duration_ < slot23 + slot16 then
						uv0.duration_ = slot23 + slot16
					end
				end

				uv0.text_.text = slot20
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031017", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031017", "story_v_out_111031.awb") / 1000 + slot16 then
						uv0.duration_ = slot24 + slot16
					end

					if slot19.prefab_name ~= "" and uv0.actors_[slot19.prefab_name] ~= nil then
						slot25 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot19.prefab_name].transform, "story_v_out_111031", "111031017", "story_v_out_111031.awb")

						uv0:RecordAudio("111031017", slot25)
						uv0:RecordAudio("111031017", slot25)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031017", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031017", "story_v_out_111031.awb")
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
	Play111031018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031018
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			slot5 = 0.375

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(111031018).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play111031019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031019
		slot1.duration_ = 1.3

		if ({
			ja = 0.999999999999,
			ko = 0.999999999999,
			zh = 1.3,
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
				uv0:Play111031020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.1

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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1048")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(111031019).content)
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031019", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031019", "story_v_out_111031.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_111031", "111031019", "story_v_out_111031.awb")

						uv0:RecordAudio("111031019", slot10)
						uv0:RecordAudio("111031019", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031019", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031019", "story_v_out_111031.awb")
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
	Play111031020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031020
		slot1.duration_ = 2.566

		if ({
			ja = 2.233,
			ko = 2.066,
			zh = 2.466,
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
				uv0:Play111031021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084actionlink/1084action434")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			slot7 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(111031020).content)
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031020", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031020", "story_v_out_111031.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_111031", "111031020", "story_v_out_111031.awb")

						uv0:RecordAudio("111031020", slot15)
						uv0:RecordAudio("111031020", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031020", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031020", "story_v_out_111031.awb")
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
	Play111031021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031021
		slot1.duration_ = 2.433

		if ({
			ja = 2.433,
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
				uv0:Play111031022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action453")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			slot10 = 0.075

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(111031021).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031021", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031021", "story_v_out_111031.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_111031", "111031021", "story_v_out_111031.awb")

						uv0:RecordAudio("111031021", slot18)
						uv0:RecordAudio("111031021", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031021", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031021", "story_v_out_111031.awb")
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
	Play111031022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031022
		slot1.duration_ = 6.5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.bgs_.D12b.transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPosD12b = slot1.localPosition
				slot1.localScale = Vector3.New(1.2, 1.2, 1.2)
			end

			slot3 = 1.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPosD12b, Vector3.New(0, 1, 10), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, 1, 10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition

				uv0:ShowWeapon(uv0.var_["1039ui_story" .. "Animator"].transform, false)
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot11 = 0.75

			if 1.5 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot12 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot12:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot12:setOnComplete(System.Action(function ()
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

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(111031022).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 + 0.3 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot11 = math.max(slot11, uv0.talkMaxDuration)

			if slot10 + 0.3 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
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
	Play111031023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031023
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play111031024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(111031023).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play111031024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031024
		slot1.duration_ = 4.3

		if ({
			ja = 2.833,
			ko = 3.566,
			zh = 4.3,
			en = 2.733
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
				uv0:Play111031025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot4 = 0.2

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot5 = (uv0.time_ - slot3) / slot4

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot6) / slot7)
				slot11 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot5.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot5.localEulerAngles = slot12
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot10 = manager.ui.mainCamera.transform.position - slot5.position
				slot5.forward = Vector3.New(slot10.x, slot10.y, slot10.z)
				slot11 = slot5.localEulerAngles
				slot11.z = 0
				slot11.x = 0
				slot5.localEulerAngles = slot11
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1039ui_story = uv0.actors_["1039ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1039ui_story, Vector3.New(0.7, -1.01, -5.9), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0.7, -1.01, -5.9)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			slot12 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
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

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(111031024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031024", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031024", "story_v_out_111031.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_111031", "111031024", "story_v_out_111031.awb")

						uv0:RecordAudio("111031024", slot20)
						uv0:RecordAudio("111031024", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031024", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031024", "story_v_out_111031.awb")
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
	Play111031025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031025
		slot1.duration_ = 5

		if ({
			ja = 5,
			ko = 4.233,
			zh = 4.166,
			en = 2.733
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
				uv0:Play111031026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/1039/1039actionlink/1039action435")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("1039ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2204cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect1039ui_story then
					uv0.var_.characterEffect1039ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect1039ui_story then
				uv0.var_.characterEffect1039ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(111031025).content)
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

				if manager.audio:GetVoiceLength("story_v_out_111031", "111031025", "story_v_out_111031.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_111031", "111031025", "story_v_out_111031.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_111031", "111031025", "story_v_out_111031.awb")

						uv0:RecordAudio("111031025", slot18)
						uv0:RecordAudio("111031025", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_111031", "111031025", "story_v_out_111031.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_111031", "111031025", "story_v_out_111031.awb")
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
	Play111031026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 111031026
		slot1.duration_ = 5

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
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1039ui_story == nil then
				uv0.var_.characterEffect1039ui_story = uv0.actors_["1039ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.2

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

			slot5 = 0.575

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

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(111031026).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/D05",
		"Assets/UIResources/UI_AB/TextureConfig/Background/D12b"
	},
	voices = {
		"story_v_out_111031.awb"
	}
}
