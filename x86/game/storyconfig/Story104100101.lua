return {
	Play410011001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011001
		slot1.duration_ = 7.2

		if ({
			zh = 3.8,
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
				uv0:Play410011002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.L01f == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.L01f
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "L01f" then
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

			if uv0.actors_["1060"] == nil then
				slot6 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot5), uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["1060"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1060 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot12 = 0, slot6.childCount - 1 do
					if slot6:GetChild(slot12).name == "" or not string.find(slot13.name, "split") then
						slot13.gameObject:SetActive(true)
					else
						slot13.gameObject:SetActive(false)
					end
				end
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(0, -435, -40)
			end

			if 2 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot11 = 0.034

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.actorSpriteComps1060 then
					for slot16, slot17 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot17 then
							slot18 = Mathf.Lerp(slot17.color.r, 1, slot12)
							slot17.color = Color.New(slot18, slot18, slot18)
						end
					end
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot12 = 1

				for slot16, slot17 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot17 then
						slot17.color = Color.New(slot12, slot12, slot12)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot13 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot15 = 1

			if 1.56666666666667 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum", "bgm_activity_2_8_story_jivitabad_slum.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot17 = 0.225

			if 2 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot18 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot18:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot18:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(410011001).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot17 or slot17 * utf8.len(slot21) / slot22) > 0 and slot17 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot16 + 0.3 then
						uv0.duration_ = slot24 + slot16
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011001", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011001", "story_v_out_410011.awb") / 1000 + slot16 then
						uv0.duration_ = slot25 + slot16
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						slot26 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_410011", "410011001", "story_v_out_410011.awb")

						uv0:RecordAudio("410011001", slot26)
						uv0:RecordAudio("410011001", slot26)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011001", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011001", "story_v_out_410011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot17 = math.max(slot17, uv0.talkMaxDuration)

			if slot16 + 0.3 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
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
	Play410011002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011002
		slot1.duration_ = 9.3

		if ({
			zh = 9.1,
			ja = 9.3
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
				uv0:Play410011003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011002).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011002", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011002", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011002", "story_v_out_410011.awb")

						uv0:RecordAudio("410011002", slot13)
						uv0:RecordAudio("410011002", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011002", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011002", "story_v_out_410011.awb")
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
	Play410011003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011003
		slot1.duration_ = 10.9

		if ({
			zh = 5.1,
			ja = 10.9
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
				uv0:Play410011004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011003).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011003", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011003", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011003", "story_v_out_410011.awb")

						uv0:RecordAudio("410011003", slot10)
						uv0:RecordAudio("410011003", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011003", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011003", "story_v_out_410011.awb")
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
	Play410011004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011004
		slot1.duration_ = 7.566

		if ({
			zh = 7.566,
			ja = 6.333
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
				uv0:Play410011005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011004).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011004", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011004", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011004", "story_v_out_410011.awb")

						uv0:RecordAudio("410011004", slot16)
						uv0:RecordAudio("410011004", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011004", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011004", "story_v_out_410011.awb")
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
	Play410011005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011005
		slot1.duration_ = 11.033

		if ({
			zh = 9.733,
			ja = 11.033
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
				uv0:Play410011006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 1.2

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011005).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (48 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011005", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011005", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011005", "story_v_out_410011.awb")

						uv0:RecordAudio("410011005", slot13)
						uv0:RecordAudio("410011005", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011005", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011005", "story_v_out_410011.awb")
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
	Play410011006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011006
		slot1.duration_ = 4.133

		if ({
			zh = 3.433,
			ja = 4.133
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
				uv0:Play410011007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011006).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011006", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011006", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011006", "story_v_out_410011.awb")

						uv0:RecordAudio("410011006", slot16)
						uv0:RecordAudio("410011006", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011006", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011006", "story_v_out_410011.awb")
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
	Play410011007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011007
		slot1.duration_ = 16.766

		if ({
			zh = 5.8,
			ja = 16.766
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
				uv0:Play410011008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011007).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011007", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011007", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011007", "story_v_out_410011.awb")

						uv0:RecordAudio("410011007", slot13)
						uv0:RecordAudio("410011007", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011007", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011007", "story_v_out_410011.awb")
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
	Play410011008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011008
		slot1.duration_ = 9.066

		if ({
			zh = 2.666,
			ja = 9.066
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
				uv0:Play410011009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011008).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011008", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011008", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011008", "story_v_out_410011.awb")

						uv0:RecordAudio("410011008", slot10)
						uv0:RecordAudio("410011008", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011008", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011008", "story_v_out_410011.awb")
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
	Play410011009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011009
		slot1.duration_ = 7.766

		if ({
			zh = 4.066,
			ja = 7.766
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
				uv0:Play410011010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011009).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011009", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011009", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011009", "story_v_out_410011.awb")

						uv0:RecordAudio("410011009", slot16)
						uv0:RecordAudio("410011009", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011009", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011009", "story_v_out_410011.awb")
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
	Play410011010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011010
		slot1.duration_ = 11.233

		if ({
			zh = 7.466,
			ja = 11.233
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
				uv0:Play410011011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011010).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011010", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011010", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011010", "story_v_out_410011.awb")

						uv0:RecordAudio("410011010", slot13)
						uv0:RecordAudio("410011010", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011010", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011010", "story_v_out_410011.awb")
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
	Play410011011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -2000, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.55

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410011011).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410011012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011012).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (40 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011013
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.6

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011013).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (64 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.275

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011014).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (51 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011015
		slot1.duration_ = 7.2

		if ({
			zh = 7.2,
			ja = 3.666
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
				uv0:Play410011016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011015).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011015", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011015", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011015", "story_v_out_410011.awb")

						uv0:RecordAudio("410011015", slot16)
						uv0:RecordAudio("410011015", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011015", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011015", "story_v_out_410011.awb")
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
	Play410011016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011016
		slot1.duration_ = 8.066

		if ({
			zh = 8.066,
			ja = 7.966
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
				uv0:Play410011017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011016).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011016", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011016", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011016", "story_v_out_410011.awb")

						uv0:RecordAudio("410011016", slot10)
						uv0:RecordAudio("410011016", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011016", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011016", "story_v_out_410011.awb")
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
	Play410011017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011017
		slot1.duration_ = 13.933

		if ({
			zh = 11.133,
			ja = 13.933
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
				uv0:Play410011018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011017).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (51 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011017", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011017", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011017", "story_v_out_410011.awb")

						uv0:RecordAudio("410011017", slot10)
						uv0:RecordAudio("410011017", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011017", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011017", "story_v_out_410011.awb")
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
	Play410011018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011018
		slot1.duration_ = 5.1

		if ({
			zh = 5.1,
			ja = 4.366
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
				uv0:Play410011019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011018).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011018", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011018", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011018", "story_v_out_410011.awb")

						uv0:RecordAudio("410011018", slot16)
						uv0:RecordAudio("410011018", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011018", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011018", "story_v_out_410011.awb")
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
	Play410011019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011019
		slot1.duration_ = 11.6

		if ({
			zh = 11.6,
			ja = 10.9
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
				uv0:Play410011020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 1.25

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011019).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (50 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011019", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011019", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011019", "story_v_out_410011.awb")

						uv0:RecordAudio("410011019", slot13)
						uv0:RecordAudio("410011019", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011019", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011019", "story_v_out_410011.awb")
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
	Play410011020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011020
		slot1.duration_ = 9.333

		if ({
			zh = 2.433,
			ja = 9.333
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
				uv0:Play410011021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011020).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011020", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011020", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011020", "story_v_out_410011.awb")

						uv0:RecordAudio("410011020", slot16)
						uv0:RecordAudio("410011020", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011020", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011020", "story_v_out_410011.awb")
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
	Play410011021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011021
		slot1.duration_ = 13.066

		if ({
			zh = 5.833,
			ja = 13.066
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
				uv0:Play410011022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011021).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011021", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011021", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011021", "story_v_out_410011.awb")

						uv0:RecordAudio("410011021", slot13)
						uv0:RecordAudio("410011021", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011021", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011021", "story_v_out_410011.awb")
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
	Play410011022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011022
		slot1.duration_ = 7.433

		if ({
			zh = 3.766,
			ja = 7.433
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
				uv0:Play410011023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011022).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011022", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011022", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011022", "story_v_out_410011.awb")

						uv0:RecordAudio("410011022", slot16)
						uv0:RecordAudio("410011022", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011022", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011022", "story_v_out_410011.awb")
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
	Play410011023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011023
		slot1.duration_ = 10.466

		if ({
			zh = 9.4,
			ja = 10.466
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
				uv0:Play410011024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011023).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011023", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011023", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011023", "story_v_out_410011.awb")

						uv0:RecordAudio("410011023", slot13)
						uv0:RecordAudio("410011023", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011023", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011023", "story_v_out_410011.awb")
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
	Play410011024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011024
		slot1.duration_ = 12.833

		if ({
			zh = 9.4,
			ja = 12.833
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
				uv0:Play410011025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011024", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011024", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011024", "story_v_out_410011.awb")

						uv0:RecordAudio("410011024", slot10)
						uv0:RecordAudio("410011024", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011024", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011024", "story_v_out_410011.awb")
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
	Play410011025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011025
		slot1.duration_ = 1.833

		if ({
			zh = 1.1,
			ja = 1.833
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
				uv0:Play410011026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011025).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011025", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011025", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011025", "story_v_out_410011.awb")

						uv0:RecordAudio("410011025", slot16)
						uv0:RecordAudio("410011025", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011025", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011025", "story_v_out_410011.awb")
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
	Play410011026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011026
		slot1.duration_ = 11.5

		if ({
			zh = 6.666,
			ja = 11.5
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
				uv0:Play410011027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011026).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011026", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011026", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011026", "story_v_out_410011.awb")

						uv0:RecordAudio("410011026", slot13)
						uv0:RecordAudio("410011026", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011026", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011026", "story_v_out_410011.awb")
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
	Play410011027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011027
		slot1.duration_ = 8.8

		if ({
			zh = 7.9,
			ja = 8.8
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
				uv0:Play410011028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011027).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011027", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011027", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011027", "story_v_out_410011.awb")

						uv0:RecordAudio("410011027", slot10)
						uv0:RecordAudio("410011027", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011027", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011027", "story_v_out_410011.awb")
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
	Play410011028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011028
		slot1.duration_ = 9.166

		if ({
			zh = 6.5,
			ja = 9.166
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
				uv0:Play410011029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011028).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011028", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011028", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011028", "story_v_out_410011.awb")

						uv0:RecordAudio("410011028", slot10)
						uv0:RecordAudio("410011028", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011028", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011028", "story_v_out_410011.awb")
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
	Play410011029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011029
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.225

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011029).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011030
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011031(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011030).content)
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
	Play410011031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011031
		slot1.duration_ = 14.833

		if ({
			zh = 3.933,
			ja = 14.833
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
				uv0:Play410011032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011031).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011031", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011031", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011031", "story_v_out_410011.awb")

						uv0:RecordAudio("410011031", slot16)
						uv0:RecordAudio("410011031", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011031", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011031", "story_v_out_410011.awb")
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
	Play410011032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011032
		slot1.duration_ = 5.633

		if ({
			zh = 1,
			ja = 5.633
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
				uv0:Play410011033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011032).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011032", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011032", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011032", "story_v_out_410011.awb")

						uv0:RecordAudio("410011032", slot13)
						uv0:RecordAudio("410011032", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011032", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011032", "story_v_out_410011.awb")
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
	Play410011033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011033
		slot1.duration_ = 13.366

		if ({
			zh = 6.966,
			ja = 13.366
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
				uv0:Play410011034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011033).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011033", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011033", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011033", "story_v_out_410011.awb")

						uv0:RecordAudio("410011033", slot16)
						uv0:RecordAudio("410011033", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011033", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011033", "story_v_out_410011.awb")
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
	Play410011034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011034
		slot1.duration_ = 9.566

		if ({
			zh = 6.466,
			ja = 9.566
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
				uv0:Play410011035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011034).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011034", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011034", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011034", "story_v_out_410011.awb")

						uv0:RecordAudio("410011034", slot13)
						uv0:RecordAudio("410011034", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011034", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011034", "story_v_out_410011.awb")
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
	Play410011035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011035
		slot1.duration_ = 6

		if ({
			zh = 4.733,
			ja = 6
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
				uv0:Play410011036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011035).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011035", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011035", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011035", "story_v_out_410011.awb")

						uv0:RecordAudio("410011035", slot10)
						uv0:RecordAudio("410011035", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011035", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011035", "story_v_out_410011.awb")
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
	Play410011036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011036
		slot1.duration_ = 6.533

		if ({
			zh = 4.433,
			ja = 6.533
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
				uv0:Play410011037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_side_1096", "se_story_1096_brake", "")
			end

			slot10 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(410011036).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011036", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011036", "story_v_out_410011.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_410011", "410011036", "story_v_out_410011.awb")

						uv0:RecordAudio("410011036", slot18)
						uv0:RecordAudio("410011036", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011036", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011036", "story_v_out_410011.awb")
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
	Play410011037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011037
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -2000, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 1.075

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410011037).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410011038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011038
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_128", "se_story_128_knock", "")
			end

			slot4 = 1.2

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

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(410011038).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (48 <= 0 and slot4 or slot4 * utf8.len(slot6) / slot7) > 0 and slot4 < slot9 then
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
	Play410011039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011039
		slot1.duration_ = 3.766

		if ({
			zh = 2.2,
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
				uv0:Play410011040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011039).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011039", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011039", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011039", "story_v_out_410011.awb")

						uv0:RecordAudio("410011039", slot10)
						uv0:RecordAudio("410011039", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011039", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011039", "story_v_out_410011.awb")
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
	Play410011040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011040
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.575

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011040).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (63 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011041
		slot1.duration_ = 5.533

		if ({
			zh = 4.533,
			ja = 5.533
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
				uv0:Play410011042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011041).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011041", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011041", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011041", "story_v_out_410011.awb")

						uv0:RecordAudio("410011041", slot10)
						uv0:RecordAudio("410011041", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011041", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011041", "story_v_out_410011.awb")
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
	Play410011042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011042
		slot1.duration_ = 8.233

		if ({
			zh = 1.4,
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
				uv0:Play410011043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_1" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011042).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011042", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011042", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011042", "story_v_out_410011.awb")

						uv0:RecordAudio("410011042", slot16)
						uv0:RecordAudio("410011042", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011042", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011042", "story_v_out_410011.awb")
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
	Play410011043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011043
		slot1.duration_ = 7.3

		if ({
			zh = 3.866,
			ja = 7.3
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
				uv0:Play410011044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1060 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot5 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[585].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_fathera")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410011043).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011043", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011043", "story_v_out_410011.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410011", "410011043", "story_v_out_410011.awb")

						uv0:RecordAudio("410011043", slot13)
						uv0:RecordAudio("410011043", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011043", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011043", "story_v_out_410011.awb")
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
	Play410011044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011044
		slot1.duration_ = 8.966

		if ({
			zh = 5.066,
			ja = 8.966
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
				uv0:Play410011045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011044).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011044", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011044", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011044", "story_v_out_410011.awb")

						uv0:RecordAudio("410011044", slot16)
						uv0:RecordAudio("410011044", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011044", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011044", "story_v_out_410011.awb")
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
	Play410011045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011045
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011046(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011045).content)
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
	Play410011046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011046
		slot1.duration_ = 4.533

		if ({
			zh = 0.999999999999,
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
				uv0:Play410011047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_3" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -435, -40), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -435, -40)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410011046).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011046", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011046", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410011", "410011046", "story_v_out_410011.awb")

						uv0:RecordAudio("410011046", slot16)
						uv0:RecordAudio("410011046", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011046", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011046", "story_v_out_410011.awb")
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
	Play410011047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011047
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1060", 7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1060, Vector3.New(0, -2000, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1060 == nil then
				uv0.var_.actorSpriteComps1060 = uv0.actors_["1060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1060 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1060 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1060:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1060 = nil
			end

			slot8 = 1.225

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410011047).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410011048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011048
		slot1.duration_ = 13.866

		if ({
			zh = 9.633,
			ja = 13.866
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
				uv0:Play410011049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.LZ0101 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.LZ0101
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "LZ0101" then
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
				slot6.a = Mathf.Lerp(0, 1, (uv0.time_ - slot3) / slot4)
				uv0.mask_.color = slot6
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = 1
				uv0.mask_.color = slot5
			end

			if 2 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot6 = 2

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot8 = Color.New(0, 0, 0)
				slot8.a = Mathf.Lerp(1, 0, (uv0.time_ - slot5) / slot6)
				uv0.mask_.color = slot8
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot7 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot7.a = 0
				uv0.mask_.color = slot7
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot8 = 0.625

			if 4 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot9 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot9:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot9:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[587].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_badboyb")

				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(410011048).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot8 or slot8 * utf8.len(slot12) / slot13) > 0 and slot8 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot7 + 0.3 then
						uv0.duration_ = slot15 + slot7
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011048", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011048", "story_v_out_410011.awb") / 1000 + slot7 then
						uv0.duration_ = slot16 + slot7
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_410011", "410011048", "story_v_out_410011.awb")

						uv0:RecordAudio("410011048", slot17)
						uv0:RecordAudio("410011048", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011048", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011048", "story_v_out_410011.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot8 = math.max(slot8, uv0.talkMaxDuration)

			if slot7 + 0.3 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
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
	Play410011049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011049
		slot1.duration_ = 10.4

		if ({
			zh = 8.766,
			ja = 10.4
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
				uv0:Play410011050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[588].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_yakuzab")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011049).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011049", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011049", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011049", "story_v_out_410011.awb")

						uv0:RecordAudio("410011049", slot10)
						uv0:RecordAudio("410011049", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011049", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011049", "story_v_out_410011.awb")
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
	Play410011050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011050
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.3

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011050).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410011051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011051
		slot1.duration_ = 4.966

		if ({
			zh = 4.966,
			ja = 4.866
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
				uv0:Play410011052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011051).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011051", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011051", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011051", "story_v_out_410011.awb")

						uv0:RecordAudio("410011051", slot10)
						uv0:RecordAudio("410011051", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011051", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011051", "story_v_out_410011.awb")
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
	Play410011052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011052
		slot1.duration_ = 6.6

		if ({
			zh = 2.4,
			ja = 6.6
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
				uv0:Play410011053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011052).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011052", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011052", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011052", "story_v_out_410011.awb")

						uv0:RecordAudio("410011052", slot10)
						uv0:RecordAudio("410011052", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011052", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011052", "story_v_out_410011.awb")
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
	Play410011053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011053
		slot1.duration_ = 15.666

		if ({
			zh = 5.966,
			ja = 15.666
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
				uv0:Play410011054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011053).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011053", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011053", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011053", "story_v_out_410011.awb")

						uv0:RecordAudio("410011053", slot10)
						uv0:RecordAudio("410011053", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011053", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011053", "story_v_out_410011.awb")
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
	Play410011054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011054
		slot1.duration_ = 2.7

		if ({
			zh = 1.3,
			ja = 2.7
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
				uv0:Play410011055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011054).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011054", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011054", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011054", "story_v_out_410011.awb")

						uv0:RecordAudio("410011054", slot10)
						uv0:RecordAudio("410011054", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011054", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011054", "story_v_out_410011.awb")
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
	Play410011055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011055
		slot1.duration_ = 6.766

		if ({
			zh = 3.433,
			ja = 6.766
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
				uv0:Play410011056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011055).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011055", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011055", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011055", "story_v_out_410011.awb")

						uv0:RecordAudio("410011055", slot10)
						uv0:RecordAudio("410011055", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011055", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011055", "story_v_out_410011.awb")
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
	Play410011056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011056
		slot1.duration_ = 3.6

		if ({
			zh = 2.566,
			ja = 3.6
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
				uv0:Play410011057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011056).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011056", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011056", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011056", "story_v_out_410011.awb")

						uv0:RecordAudio("410011056", slot10)
						uv0:RecordAudio("410011056", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011056", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011056", "story_v_out_410011.awb")
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
	Play410011057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011057
		slot1.duration_ = 7.433

		if ({
			zh = 7.066,
			ja = 7.433
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
				uv0:Play410011058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011057).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011057", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011057", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011057", "story_v_out_410011.awb")

						uv0:RecordAudio("410011057", slot10)
						uv0:RecordAudio("410011057", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011057", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011057", "story_v_out_410011.awb")
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
	Play410011058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011058
		slot1.duration_ = 2.4

		if ({
			zh = 2.1,
			ja = 2.4
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
				uv0:Play410011059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011058).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (6 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011058", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011058", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011058", "story_v_out_410011.awb")

						uv0:RecordAudio("410011058", slot10)
						uv0:RecordAudio("410011058", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011058", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011058", "story_v_out_410011.awb")
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
	Play410011059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011059
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011060(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410011059).content)
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
	Play410011060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011060
		slot1.duration_ = 5.033

		if ({
			zh = 5.033,
			ja = 3.966
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
				uv0:Play410011061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011060).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011060", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011060", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011060", "story_v_out_410011.awb")

						uv0:RecordAudio("410011060", slot10)
						uv0:RecordAudio("410011060", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011060", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011060", "story_v_out_410011.awb")
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
	Play410011061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011061
		slot1.duration_ = 9.366

		if ({
			zh = 9.366,
			ja = 6.766
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
				uv0:Play410011062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011061).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011061", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011061", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011061", "story_v_out_410011.awb")

						uv0:RecordAudio("410011061", slot10)
						uv0:RecordAudio("410011061", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011061", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011061", "story_v_out_410011.awb")
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
	Play410011062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011062
		slot1.duration_ = 5.533

		if ({
			zh = 2,
			ja = 5.533
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
				uv0:Play410011063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011062).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011062", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011062", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011062", "story_v_out_410011.awb")

						uv0:RecordAudio("410011062", slot10)
						uv0:RecordAudio("410011062", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011062", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011062", "story_v_out_410011.awb")
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
	Play410011063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011063
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410011064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot2 = 0.5

			if slot1 <= uv0.time_ and uv0.time_ < slot1 + slot2 then
				slot4 = Color.New(1, 1, 1)
				slot4.a = Mathf.Lerp(1, 0, (uv0.time_ - slot1) / slot2)
				uv0.mask_.color = slot4
			end

			if uv0.time_ >= slot1 + slot2 and uv0.time_ < slot1 + slot2 + slot0 then
				slot3 = Color.New(1, 1, 1)
				uv0.mask_.enabled = false
				slot3.a = 0
				uv0.mask_.color = slot3
			end

			slot4 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_126_01", "se_story_126_01_whoosh", "")
			end

			slot6 = 1.1

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(410011063).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot6 or slot6 * utf8.len(slot9) / slot10) > 0 and slot6 < slot12 then
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
	Play410011064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011064
		slot1.duration_ = 8.766

		if ({
			zh = 7.7,
			ja = 8.766
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
				uv0:Play410011065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011064).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011064", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011064", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011064", "story_v_out_410011.awb")

						uv0:RecordAudio("410011064", slot10)
						uv0:RecordAudio("410011064", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011064", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011064", "story_v_out_410011.awb")
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
	Play410011065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011065
		slot1.duration_ = 1.866

		if ({
			zh = 1.866,
			ja = 1.333
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
				uv0:Play410011066(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[584].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011065).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011065", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011065", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011065", "story_v_out_410011.awb")

						uv0:RecordAudio("410011065", slot10)
						uv0:RecordAudio("410011065", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011065", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011065", "story_v_out_410011.awb")
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
	Play410011066 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410011066
		slot1.duration_ = 8.466

		if ({
			zh = 4.7,
			ja = 8.466
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
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[586].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_citizenma")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410011066).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410011", "410011066", "story_v_out_410011.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410011", "410011066", "story_v_out_410011.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410011", "410011066", "story_v_out_410011.awb")

						uv0:RecordAudio("410011066", slot10)
						uv0:RecordAudio("410011066", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410011", "410011066", "story_v_out_410011.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410011", "410011066", "story_v_out_410011.awb")
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
		"Assets/UIResources/UI_AB/TextureConfig/Background/L01f",
		"Assets/UIResources/UI_AB/TextureConfig/Background/LZ0101"
	},
	voices = {
		"story_v_out_410011.awb"
	}
}
