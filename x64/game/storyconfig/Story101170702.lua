return {
	Play117072001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.I08a == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.I08a
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "I08a" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
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

			slot6 = 0.466666666666667

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot8 = 1

			if 2 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse", "bgm_activity_1_7_story_firehouse.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.95

			if 2 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot11 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot11:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot11:setOnComplete(System.Action(function ()
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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(117072001).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 + 0.3 then
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

			if slot9 + 0.3 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
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
	Play117072002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072002
		slot1.duration_ = 7.2

		if ({
			zh = 3.466,
			ja = 7.2
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
				uv0:Play117072003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1033"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1033 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
				slot8 = 3

				uv0:CheckSpriteTmpPos("1033", slot8)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "split_6" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(0, -420, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.actorSpriteComps1033 then
					slot11 = uv0.var_.actorSpriteComps1033
					slot13 = slot11

					for slot12, slot13 in pairs(slot11.ToTable(slot13)) do
						if slot13 then
							slot14 = Mathf.Lerp(slot13.color.r, 1, slot8)
							slot13.color = Color.New(slot14, slot14, slot14)
						end
					end
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot8 = 1
				slot11 = uv0.var_.actorSpriteComps1033
				slot13 = slot11

				for slot12, slot13 in pairs(slot11.ToTable(slot13)) do
					if slot13 then
						slot13.color = Color.New(slot8, slot8, slot8)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if uv0.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1033 = slot10.alpha
					uv0.var_.characterEffect1033 = slot10
				end

				uv0.var_.alphaOldValue1033 = 0
			end

			slot10 = 0.333333333333333

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				if uv0.var_.characterEffect1033 then
					uv0.var_.characterEffect1033.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1033, 1, (uv0.time_ - slot9) / slot10)
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.characterEffect1033 then
				uv0.var_.characterEffect1033.alpha = 1
			end

			slot12 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(117072002).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072002", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072002", "story_v_out_117072.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_117072", "117072002", "story_v_out_117072.awb")

						uv0:RecordAudio("117072002", slot20)
						uv0:RecordAudio("117072002", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072002", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072002", "story_v_out_117072.awb")
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
	Play117072003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072003
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(117072003).content)
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
	Play117072004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072004
		slot1.duration_ = 2.766

		if ({
			zh = 0.999999999999,
			ja = 2.766
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
				uv0:Play117072005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_4" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(0, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072004).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072004", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072004", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072004", "story_v_out_117072.awb")

						uv0:RecordAudio("117072004", slot16)
						uv0:RecordAudio("117072004", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072004", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072004", "story_v_out_117072.awb")
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
	Play117072005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072005
		slot1.duration_ = 3.633

		if ({
			zh = 3.633,
			ja = 3.3
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
				uv0:Play117072006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_4" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if uv0.actors_["1132"] == nil then
				slot8 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot7), uv0.canvasGo_.transform)

				slot8.transform:SetSiblingIndex(1)

				slot8.name = slot7
				slot8.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot7] = slot8
			end

			slot8 = uv0.actors_["1132"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1132 = slot8.localPosition
				slot8.localScale = Vector3.New(1, 1, 1)
				slot14 = 2

				uv0:CheckSpriteTmpPos("1132", slot14)

				for slot14 = 0, slot8.childCount - 1 do
					if slot8:GetChild(slot14).name == "split_6" or not string.find(slot15.name, "split") then
						slot15.gameObject:SetActive(true)
					else
						slot15.gameObject:SetActive(false)
					end
				end
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(-390, -413, -185)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot13.alpha
					uv0.var_.characterEffect1132 = slot13
				end

				uv0.var_.alphaOldValue1132 = 0
			end

			slot13 = 0.333333333333333

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 1, (uv0.time_ - slot12) / slot13)
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 1
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot16 = 0.2

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot17 = (uv0.time_ - slot15) / slot16

				if uv0.var_.actorSpriteComps1132 then
					slot20 = uv0.var_.actorSpriteComps1132
					slot22 = slot20

					for slot21, slot22 in pairs(slot20.ToTable(slot22)) do
						if slot22 then
							slot23 = Mathf.Lerp(slot22.color.r, 1, slot17)
							slot22.color = Color.New(slot23, slot23, slot23)
						end
					end
				end
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot17 = 1
				slot20 = uv0.var_.actorSpriteComps1132
				slot22 = slot20

				for slot21, slot22 in pairs(slot20.ToTable(slot22)) do
					if slot22 then
						slot22.color = Color.New(slot17, slot17, slot17)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot18 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(117072005).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 then
						uv0.duration_ = slot24 + slot17
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072005", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072005", "story_v_out_117072.awb") / 1000 + slot17 then
						uv0.duration_ = slot25 + slot17
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						slot26 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_117072", "117072005", "story_v_out_117072.awb")

						uv0:RecordAudio("117072005", slot26)
						uv0:RecordAudio("117072005", slot26)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072005", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072005", "story_v_out_117072.awb")
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
	Play117072006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072006
		slot1.duration_ = 6.133

		if ({
			zh = 6.133,
			ja = 3.766
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
				uv0:Play117072007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot4 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1033 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("1033", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_6" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1033 then
					slot13 = uv0.var_.actorSpriteComps1033
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps1033
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot11 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(117072006).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072006", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072006", "story_v_out_117072.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117072", "117072006", "story_v_out_117072.awb")

						uv0:RecordAudio("117072006", slot19)
						uv0:RecordAudio("117072006", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072006", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072006", "story_v_out_117072.awb")
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
	Play117072007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072007
		slot1.duration_ = 9.7

		if ({
			zh = 6.766,
			ja = 9.7
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
				uv0:Play117072008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072007).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072007", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072007", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072007", "story_v_out_117072.awb")

						uv0:RecordAudio("117072007", slot10)
						uv0:RecordAudio("117072007", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072007", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072007", "story_v_out_117072.awb")
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
	Play117072008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072008
		slot1.duration_ = 6.433

		if ({
			zh = 6.433,
			ja = 5.6
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
				uv0:Play117072009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072008).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072008", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072008", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072008", "story_v_out_117072.awb")

						uv0:RecordAudio("117072008", slot10)
						uv0:RecordAudio("117072008", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072008", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072008", "story_v_out_117072.awb")
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
	Play117072009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072009
		slot1.duration_ = 12.433

		if ({
			zh = 12.433,
			ja = 12.4
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
				uv0:Play117072010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072009).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (58 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072009", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072009", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072009", "story_v_out_117072.awb")

						uv0:RecordAudio("117072009", slot10)
						uv0:RecordAudio("117072009", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072009", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072009", "story_v_out_117072.awb")
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
	Play117072010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072010
		slot1.duration_ = 15.1

		if ({
			zh = 10.3,
			ja = 15.1
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
				uv0:Play117072011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.4

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072010).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (56 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072010", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072010", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072010", "story_v_out_117072.awb")

						uv0:RecordAudio("117072010", slot10)
						uv0:RecordAudio("117072010", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072010", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072010", "story_v_out_117072.awb")
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
	Play117072011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072011
		slot1.duration_ = 4.5

		if ({
			zh = 4.2,
			ja = 4.5
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
				uv0:Play117072012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072011).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072011", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072011", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072011", "story_v_out_117072.awb")

						uv0:RecordAudio("117072011", slot16)
						uv0:RecordAudio("117072011", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072011", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072011", "story_v_out_117072.awb")
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
	Play117072012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot4 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1033 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("1033", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_4" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -420, 0)
			end

			slot8 = 0.625

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(117072012).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play117072013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072013
		slot1.duration_ = 11.666

		if ({
			zh = 11.666,
			ja = 10.966
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
				uv0:Play117072014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_6" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.4

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072013).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (56 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072013", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072013", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072013", "story_v_out_117072.awb")

						uv0:RecordAudio("117072013", slot16)
						uv0:RecordAudio("117072013", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072013", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072013", "story_v_out_117072.awb")
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
	Play117072014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072014
		slot1.duration_ = 3.1

		if ({
			zh = 1.533,
			ja = 3.1
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
				uv0:Play117072015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072014).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072014", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072014", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072014", "story_v_out_117072.awb")

						uv0:RecordAudio("117072014", slot10)
						uv0:RecordAudio("117072014", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072014", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072014", "story_v_out_117072.awb")
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
	Play117072015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072015
		slot1.duration_ = 8.233

		if ({
			zh = 6.4,
			ja = 8.233
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
				uv0:Play117072016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072015).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072015", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072015", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072015", "story_v_out_117072.awb")

						uv0:RecordAudio("117072015", slot16)
						uv0:RecordAudio("117072015", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072015", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072015", "story_v_out_117072.awb")
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
	Play117072016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072016
		slot1.duration_ = 11.4

		if ({
			zh = 11.4,
			ja = 5.866
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
				uv0:Play117072017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072016).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072016", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072016", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072016", "story_v_out_117072.awb")

						uv0:RecordAudio("117072016", slot10)
						uv0:RecordAudio("117072016", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072016", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072016", "story_v_out_117072.awb")
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
	Play117072017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072017
		slot1.duration_ = 10.233

		if ({
			zh = 5.4,
			ja = 10.233
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
				uv0:Play117072018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072017).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072017", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072017", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072017", "story_v_out_117072.awb")

						uv0:RecordAudio("117072017", slot16)
						uv0:RecordAudio("117072017", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072017", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072017", "story_v_out_117072.awb")
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
	Play117072018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072018
		slot1.duration_ = 10.166

		if ({
			zh = 10,
			ja = 10.166
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
				uv0:Play117072019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072018).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072018", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072018", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072018", "story_v_out_117072.awb")

						uv0:RecordAudio("117072018", slot16)
						uv0:RecordAudio("117072018", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072018", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072018", "story_v_out_117072.awb")
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
	Play117072019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072019
		slot1.duration_ = 5.866

		if ({
			zh = 5.133,
			ja = 5.866
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
				uv0:Play117072020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072019).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072019", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072019", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072019", "story_v_out_117072.awb")

						uv0:RecordAudio("117072019", slot10)
						uv0:RecordAudio("117072019", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072019", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072019", "story_v_out_117072.awb")
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
	Play117072020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072020
		slot1.duration_ = 5.433

		if ({
			zh = 4.233,
			ja = 5.433
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
				uv0:Play117072021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot7 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1033 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 4

				uv0:CheckSpriteTmpPos("1033", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_4" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(390, -420, 0)
			end

			slot11 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(117072020).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072020", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072020", "story_v_out_117072.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117072", "117072020", "story_v_out_117072.awb")

						uv0:RecordAudio("117072020", slot19)
						uv0:RecordAudio("117072020", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072020", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072020", "story_v_out_117072.awb")
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
	Play117072021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072021
		slot1.duration_ = 10.933

		if ({
			zh = 10.933,
			ja = 10.133
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
				uv0:Play117072022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072021).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072021", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072021", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072021", "story_v_out_117072.awb")

						uv0:RecordAudio("117072021", slot10)
						uv0:RecordAudio("117072021", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072021", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072021", "story_v_out_117072.awb")
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
	Play117072022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072022
		slot1.duration_ = 11.833

		if ({
			zh = 11.833,
			ja = 10.066
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
				uv0:Play117072023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_6" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.0333333333333333

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.575

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072022).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (63 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072022", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072022", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072022", "story_v_out_117072.awb")

						uv0:RecordAudio("117072022", slot16)
						uv0:RecordAudio("117072022", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072022", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072022", "story_v_out_117072.awb")
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
	Play117072023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072023
		slot1.duration_ = 8.1

		if ({
			zh = 8.1,
			ja = 7.2
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
				uv0:Play117072024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072023).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072023", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072023", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072023", "story_v_out_117072.awb")

						uv0:RecordAudio("117072023", slot16)
						uv0:RecordAudio("117072023", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072023", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072023", "story_v_out_117072.awb")
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
	Play117072024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072024
		slot1.duration_ = 3.566

		if ({
			zh = 1.366,
			ja = 3.566
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
				uv0:Play117072025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072024", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072024", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072024", "story_v_out_117072.awb")

						uv0:RecordAudio("117072024", slot16)
						uv0:RecordAudio("117072024", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072024", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072024", "story_v_out_117072.awb")
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
	Play117072025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072025
		slot1.duration_ = 6.166

		if ({
			zh = 6.166,
			ja = 4.566
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
				uv0:Play117072026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072025).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072025", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072025", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072025", "story_v_out_117072.awb")

						uv0:RecordAudio("117072025", slot16)
						uv0:RecordAudio("117072025", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072025", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072025", "story_v_out_117072.awb")
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
	Play117072026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072026
		slot1.duration_ = 5.766

		if ({
			zh = 4.3,
			ja = 5.766
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
				uv0:Play117072027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072026).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072026", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072026", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072026", "story_v_out_117072.awb")

						uv0:RecordAudio("117072026", slot10)
						uv0:RecordAudio("117072026", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072026", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072026", "story_v_out_117072.awb")
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
	Play117072027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072027
		slot1.duration_ = 4.266

		if ({
			zh = 3.1,
			ja = 4.266
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
				uv0:Play117072028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot7 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1033 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 4

				uv0:CheckSpriteTmpPos("1033", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_6" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(390, -420, 0)
			end

			slot11 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(117072027).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072027", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072027", "story_v_out_117072.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117072", "117072027", "story_v_out_117072.awb")

						uv0:RecordAudio("117072027", slot19)
						uv0:RecordAudio("117072027", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072027", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072027", "story_v_out_117072.awb")
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
	Play117072028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072028
		slot1.duration_ = 8.9

		if ({
			zh = 7.066,
			ja = 8.9
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
				uv0:Play117072029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_6" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072028).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072028", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072028", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072028", "story_v_out_117072.awb")

						uv0:RecordAudio("117072028", slot16)
						uv0:RecordAudio("117072028", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072028", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072028", "story_v_out_117072.awb")
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
	Play117072029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072029
		slot1.duration_ = 12.366

		if ({
			zh = 8.033,
			ja = 12.366
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
				uv0:Play117072030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072029).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072029", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072029", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072029", "story_v_out_117072.awb")

						uv0:RecordAudio("117072029", slot10)
						uv0:RecordAudio("117072029", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072029", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072029", "story_v_out_117072.awb")
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
	Play117072030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072030
		slot1.duration_ = 5.366

		if ({
			zh = 1.533,
			ja = 5.366
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
				uv0:Play117072031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072030).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072030", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072030", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072030", "story_v_out_117072.awb")

						uv0:RecordAudio("117072030", slot16)
						uv0:RecordAudio("117072030", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072030", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072030", "story_v_out_117072.awb")
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
	Play117072031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072031
		slot1.duration_ = 8.733

		if ({
			zh = 8.733,
			ja = 2.733
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
				uv0:Play117072032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072031).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072031", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072031", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072031", "story_v_out_117072.awb")

						uv0:RecordAudio("117072031", slot16)
						uv0:RecordAudio("117072031", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072031", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072031", "story_v_out_117072.awb")
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
	Play117072032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072032
		slot1.duration_ = 9.1

		if ({
			zh = 4.8,
			ja = 9.1
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
				uv0:Play117072033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072032).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072032", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072032", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072032", "story_v_out_117072.awb")

						uv0:RecordAudio("117072032", slot10)
						uv0:RecordAudio("117072032", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072032", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072032", "story_v_out_117072.awb")
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
	Play117072033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072033
		slot1.duration_ = 2.833

		if ({
			zh = 2.833,
			ja = 2.533
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
				uv0:Play117072034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072033).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072033", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072033", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072033", "story_v_out_117072.awb")

						uv0:RecordAudio("117072033", slot16)
						uv0:RecordAudio("117072033", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072033", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072033", "story_v_out_117072.awb")
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
	Play117072034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072034
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot5 = 0.625

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(117072034).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play117072035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072035
		slot1.duration_ = 7.666

		if ({
			zh = 7.666,
			ja = 6.8
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
				uv0:Play117072036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot5 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(117072035).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (38 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072035", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072035", "story_v_out_117072.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117072", "117072035", "story_v_out_117072.awb")

						uv0:RecordAudio("117072035", slot13)
						uv0:RecordAudio("117072035", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072035", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072035", "story_v_out_117072.awb")
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
	Play117072036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072036
		slot1.duration_ = 12.666

		if ({
			zh = 12.666,
			ja = 12.4
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
				uv0:Play117072037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.475

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072036).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (59 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072036", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072036", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072036", "story_v_out_117072.awb")

						uv0:RecordAudio("117072036", slot16)
						uv0:RecordAudio("117072036", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072036", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072036", "story_v_out_117072.awb")
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
	Play117072037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072037
		slot1.duration_ = 5.333

		if ({
			zh = 5.333,
			ja = 4.533
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
				uv0:Play117072038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot7 = uv0.actors_["1132"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1132 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 2

				uv0:CheckSpriteTmpPos("1132", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_6" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-390, -413, -185)
			end

			slot11 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(117072037).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072037", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072037", "story_v_out_117072.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_117072", "117072037", "story_v_out_117072.awb")

						uv0:RecordAudio("117072037", slot19)
						uv0:RecordAudio("117072037", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072037", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072037", "story_v_out_117072.awb")
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
	Play117072038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072038
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(117072038).content)
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
	Play117072039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072039
		slot1.duration_ = 3.433

		if ({
			zh = 3.433,
			ja = 2.233
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
				uv0:Play117072040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot5 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(117072039).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072039", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072039", "story_v_out_117072.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117072", "117072039", "story_v_out_117072.awb")

						uv0:RecordAudio("117072039", slot13)
						uv0:RecordAudio("117072039", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072039", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072039", "story_v_out_117072.awb")
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
	Play117072040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072040
		slot1.duration_ = 11.566

		if ({
			zh = 11.566,
			ja = 8.9
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
				uv0:Play117072041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072040).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (62 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072040", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072040", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072040", "story_v_out_117072.awb")

						uv0:RecordAudio("117072040", slot10)
						uv0:RecordAudio("117072040", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072040", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072040", "story_v_out_117072.awb")
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
	Play117072041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072041
		slot1.duration_ = 2.666

		if ({
			zh = 2.666,
			ja = 1.766
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
				uv0:Play117072042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot7 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1033 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 4

				uv0:CheckSpriteTmpPos("1033", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_4" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1033 then
					slot16 = uv0.var_.actorSpriteComps1033
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot13 = 1
				slot16 = uv0.var_.actorSpriteComps1033
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot14 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(117072041).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072041", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072041", "story_v_out_117072.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117072", "117072041", "story_v_out_117072.awb")

						uv0:RecordAudio("117072041", slot22)
						uv0:RecordAudio("117072041", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072041", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072041", "story_v_out_117072.awb")
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
	Play117072042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072042
		slot1.duration_ = 12.066

		if ({
			zh = 9.166,
			ja = 12.066
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
				uv0:Play117072043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_6" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -420, 0)
			end

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(117072042).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072042", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072042", "story_v_out_117072.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117072", "117072042", "story_v_out_117072.awb")

						uv0:RecordAudio("117072042", slot13)
						uv0:RecordAudio("117072042", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072042", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072042", "story_v_out_117072.awb")
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
	Play117072043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072043
		slot1.duration_ = 9.966

		if ({
			zh = 9.966,
			ja = 9.6
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
				uv0:Play117072044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.4

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072043).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (56 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072043", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072043", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072043", "story_v_out_117072.awb")

						uv0:RecordAudio("117072043", slot10)
						uv0:RecordAudio("117072043", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072043", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072043", "story_v_out_117072.awb")
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
	Play117072044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072044
		slot1.duration_ = 2.433

		if ({
			zh = 2.233,
			ja = 2.433
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
				uv0:Play117072045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1132 then
					slot7 = uv0.var_.actorSpriteComps1132
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1132
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072044).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072044", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072044", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072044", "story_v_out_117072.awb")

						uv0:RecordAudio("117072044", slot16)
						uv0:RecordAudio("117072044", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072044", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072044", "story_v_out_117072.awb")
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
	Play117072045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072045
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot3.alpha
					uv0.var_.characterEffect1132 = slot3
				end

				uv0.var_.alphaOldValue1132 = 1
			end

			slot3 = 0.333333333333333

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 0
			end

			slot5 = 0.825

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(117072045).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play117072046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072046
		slot1.duration_ = 11

		if ({
			zh = 9.4,
			ja = 11
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
				uv0:Play117072047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1033", slot7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_6" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(0, -420, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1033 then
					slot10 = uv0.var_.actorSpriteComps1033
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1033
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072046).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072046", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072046", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072046", "story_v_out_117072.awb")

						uv0:RecordAudio("117072046", slot16)
						uv0:RecordAudio("117072046", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072046", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072046", "story_v_out_117072.awb")
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
	Play117072047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072047
		slot1.duration_ = 7.366

		if ({
			zh = 7.366,
			ja = 4.8
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
				uv0:Play117072048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072047).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072047", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072047", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072047", "story_v_out_117072.awb")

						uv0:RecordAudio("117072047", slot10)
						uv0:RecordAudio("117072047", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072047", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072047", "story_v_out_117072.awb")
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
	Play117072048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072048
		slot1.duration_ = 8.733

		if ({
			zh = 4.6,
			ja = 8.733
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
				uv0:Play117072049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072048).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072048", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072048", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072048", "story_v_out_117072.awb")

						uv0:RecordAudio("117072048", slot10)
						uv0:RecordAudio("117072048", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072048", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072048", "story_v_out_117072.awb")
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
	Play117072049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072049
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117072050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(117072049).content)
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
	Play117072050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072050
		slot1.duration_ = 5.8

		if ({
			zh = 5.8,
			ja = 5.733
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
				uv0:Play117072051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_6")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072050).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072050", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072050", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072050", "story_v_out_117072.awb")

						uv0:RecordAudio("117072050", slot10)
						uv0:RecordAudio("117072050", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072050", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072050", "story_v_out_117072.awb")
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
	Play117072051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072051
		slot1.duration_ = 10.7

		if ({
			zh = 10.7,
			ja = 5.933
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
				uv0:Play117072052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_6")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072051).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (57 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072051", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072051", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072051", "story_v_out_117072.awb")

						uv0:RecordAudio("117072051", slot10)
						uv0:RecordAudio("117072051", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072051", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072051", "story_v_out_117072.awb")
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
	Play117072052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072052
		slot1.duration_ = 3.033

		if ({
			zh = 1.566,
			ja = 3.033
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
				uv0:Play117072053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot5 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(117072052).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072052", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072052", "story_v_out_117072.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_117072", "117072052", "story_v_out_117072.awb")

						uv0:RecordAudio("117072052", slot13)
						uv0:RecordAudio("117072052", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072052", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072052", "story_v_out_117072.awb")
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
	Play117072053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072053
		slot1.duration_ = 13.966

		if ({
			zh = 13.966,
			ja = 12.966
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
				uv0:Play117072054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot4 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1033 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("1033", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_6" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -420, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot9.alpha
					uv0.var_.characterEffect1132 = slot9
				end

				uv0.var_.alphaOldValue1132 = 0
			end

			slot9 = 0.333333333333333

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 1, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 1
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1132 then
					slot16 = uv0.var_.actorSpriteComps1132
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot13 = 1
				slot16 = uv0.var_.actorSpriteComps1132
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot14 = 1.775

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(117072053).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (70 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072053", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072053", "story_v_out_117072.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117072", "117072053", "story_v_out_117072.awb")

						uv0:RecordAudio("117072053", slot22)
						uv0:RecordAudio("117072053", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072053", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072053", "story_v_out_117072.awb")
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
	Play117072054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072054
		slot1.duration_ = 11

		if ({
			zh = 8.4,
			ja = 11
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
				uv0:Play117072055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072054).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072054", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072054", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072054", "story_v_out_117072.awb")

						uv0:RecordAudio("117072054", slot10)
						uv0:RecordAudio("117072054", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072054", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072054", "story_v_out_117072.awb")
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
	Play117072055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072055
		slot1.duration_ = 9

		if ({
			zh = 6.6,
			ja = 9
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
				uv0:Play117072056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1132 then
					slot10 = uv0.var_.actorSpriteComps1132
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1132
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot8 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072055).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072055", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072055", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072055", "story_v_out_117072.awb")

						uv0:RecordAudio("117072055", slot16)
						uv0:RecordAudio("117072055", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072055", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072055", "story_v_out_117072.awb")
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
	Play117072056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072056
		slot1.duration_ = 8.666

		if ({
			zh = 7.2,
			ja = 8.666
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
				uv0:Play117072057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072056).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072056", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072056", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072056", "story_v_out_117072.awb")

						uv0:RecordAudio("117072056", slot10)
						uv0:RecordAudio("117072056", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072056", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072056", "story_v_out_117072.awb")
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
	Play117072057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072057
		slot1.duration_ = 4.633

		if ({
			zh = 1.9,
			ja = 4.633
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
				uv0:Play117072058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1132 then
					slot10 = uv0.var_.actorSpriteComps1132
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1132
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot8 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072057).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072057", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072057", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072057", "story_v_out_117072.awb")

						uv0:RecordAudio("117072057", slot16)
						uv0:RecordAudio("117072057", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072057", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072057", "story_v_out_117072.awb")
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
	Play117072058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072058
		slot1.duration_ = 1.033

		if ({
			zh = 0.999999999999,
			ja = 1.033
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
				uv0:Play117072059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1132 then
					slot10 = uv0.var_.actorSpriteComps1132
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1132
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072058).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072058", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072058", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072058", "story_v_out_117072.awb")

						uv0:RecordAudio("117072058", slot16)
						uv0:RecordAudio("117072058", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072058", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072058", "story_v_out_117072.awb")
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
	Play117072059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072059
		slot1.duration_ = 11.033

		if ({
			zh = 11.033,
			ja = 8.6
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
				uv0:Play117072060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1132 then
					slot10 = uv0.var_.actorSpriteComps1132
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1132
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot8 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072059).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072059", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072059", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072059", "story_v_out_117072.awb")

						uv0:RecordAudio("117072059", slot16)
						uv0:RecordAudio("117072059", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072059", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072059", "story_v_out_117072.awb")
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
	Play117072060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072060
		slot1.duration_ = 4.233

		if ({
			zh = 4.233,
			ja = 2.266
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
				uv0:Play117072061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[61].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117072060).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072060", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072060", "story_v_out_117072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117072", "117072060", "story_v_out_117072.awb")

						uv0:RecordAudio("117072060", slot10)
						uv0:RecordAudio("117072060", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072060", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072060", "story_v_out_117072.awb")
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
	Play117072061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117072061
		slot1.duration_ = 3.666

		if ({
			zh = 3.666,
			ja = 1.5
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
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1033 then
					slot7 = uv0.var_.actorSpriteComps1033
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1033
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1132 then
					slot10 = uv0.var_.actorSpriteComps1132
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1132
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117072061).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117072", "117072061", "story_v_out_117072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117072", "117072061", "story_v_out_117072.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117072", "117072061", "story_v_out_117072.awb")

						uv0:RecordAudio("117072061", slot16)
						uv0:RecordAudio("117072061", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117072", "117072061", "story_v_out_117072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117072", "117072061", "story_v_out_117072.awb")
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/I08a"
	},
	voices = {
		"story_v_out_117072.awb"
	}
}
