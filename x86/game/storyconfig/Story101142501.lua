return {
	Play114251001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251001
		slot1.duration_ = 11.832999999999

		if ({
			ja = 7.099999999999,
			ko = 10.232999999999,
			zh = 10.332999999999,
			en = 11.832999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST25 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST25
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST25" then
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

			if uv0.actors_["10018"] == nil then
				slot6 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot5), uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["10018"].transform

			if 1.8 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos10018 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot12 = 0, slot6.childCount - 1 do
					if slot6:GetChild(slot12).name == "split_1" or not string.find(slot13.name, "split") then
						slot13.gameObject:SetActive(true)
					else
						slot13.gameObject:SetActive(false)
					end
				end
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(-390, -350, -180)
			end

			if 1.8 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot11 = 0.034

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.actorSpriteComps10018 then
					for slot16, slot17 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot17 then
							slot18 = Mathf.Lerp(slot17.color.r, 1, slot12)
							slot17.color = Color.New(slot18, slot18, slot18)
						end
					end
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot12 = 1

				for slot16, slot17 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot17 then
						slot17.color = Color.New(slot12, slot12, slot12)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 1.8 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot14.alpha
					uv0.var_.characterEffect10018 = slot14
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot14 = 0.5

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot13) / slot14)
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot16 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot18 = 1.2

			if 2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor", "bgm_activity_1_3_story_indoor.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot20 = 0.85

			if 1.999999999999 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot24 = uv0:FormatText(uv0:GetWordFromCfg(114251001).content)
				uv0.text_.text = slot24

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot20 or slot20 * utf8.len(slot24) / slot25) > 0 and slot20 < slot27 then
					uv0.talkMaxDuration = slot27

					if uv0.duration_ < slot27 + slot19 + 0.3 then
						uv0.duration_ = slot27 + slot19
					end
				end

				uv0.text_.text = slot24
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251001", "story_v_out_114251.awb") / 1000 + slot19 then
						uv0.duration_ = slot28 + slot19
					end

					if slot23.prefab_name ~= "" and uv0.actors_[slot23.prefab_name] ~= nil then
						slot29 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot23.prefab_name].transform, "story_v_out_114251", "114251001", "story_v_out_114251.awb")

						uv0:RecordAudio("114251001", slot29)
						uv0:RecordAudio("114251001", slot29)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251001", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251001", "story_v_out_114251.awb")
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
	Play114251002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251002
		slot1.duration_ = 7.5

		if ({
			ja = 7.5,
			ko = 5.333,
			zh = 6.366,
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
				uv0:Play114251003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251002).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251002", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251002", "story_v_out_114251.awb")

						uv0:RecordAudio("114251002", slot10)
						uv0:RecordAudio("114251002", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251002", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251002", "story_v_out_114251.awb")
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
	Play114251003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251003
		slot1.duration_ = 8.866

		if ({
			ja = 7.466,
			ko = 8.833,
			zh = 8.866,
			en = 6.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10015"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10015 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "split_1" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.actorSpriteComps10018 then
					for slot12, slot13 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot13 then
							slot14 = Mathf.Lerp(slot13.color.r, 0.5, slot8)
							slot13.color = Color.New(slot14, slot14, slot14)
						end
					end
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot8 = 0.5

				for slot12, slot13 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot13 then
						slot13.color = Color.New(slot8, slot8, slot8)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot10 = 0.034

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.actorSpriteComps10015 then
					for slot15, slot16 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot16 then
							slot17 = Mathf.Lerp(slot16.color.r, 1, slot11)
							slot16.color = Color.New(slot17, slot17, slot17)
						end
					end
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot11 = 1

				for slot15, slot16 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot16 then
						slot16.color = Color.New(slot11, slot11, slot11)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot13.alpha
					uv0.var_.characterEffect10015 = slot13
				end

				uv0.var_.alphaOldValue10015 = 0
			end

			slot13 = 0.5

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 1, (uv0.time_ - slot12) / slot13)
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 1
			end

			slot15 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot18 = uv0:FormatText(uv0:GetWordFromCfg(114251003).content)
				uv0.text_.text = slot18

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot15 or slot15 * utf8.len(slot18) / slot19) > 0 and slot15 < slot21 then
					uv0.talkMaxDuration = slot21

					if uv0.duration_ < slot21 + slot14 then
						uv0.duration_ = slot21 + slot14
					end
				end

				uv0.text_.text = slot18
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251003", "story_v_out_114251.awb") / 1000 + slot14 then
						uv0.duration_ = slot22 + slot14
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						slot23 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_114251", "114251003", "story_v_out_114251.awb")

						uv0:RecordAudio("114251003", slot23)
						uv0:RecordAudio("114251003", slot23)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251003", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251003", "story_v_out_114251.awb")
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
	Play114251004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251004
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot5 = 0.9

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251004).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251005
		slot1.duration_ = 7

		if ({
			ja = 7,
			ko = 2.666,
			zh = 2.466,
			en = 2.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251005).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251005", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251005", "story_v_out_114251.awb")

						uv0:RecordAudio("114251005", slot16)
						uv0:RecordAudio("114251005", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251005", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251005", "story_v_out_114251.awb")
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
	Play114251006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251006
		slot1.duration_ = 1.666

		if ({
			ja = 1.166,
			ko = 1.666,
			zh = 1.366,
			en = 1.433
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot7 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos10015 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_5" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(390, -350, -180)
			end

			slot11 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251006).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251006", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251006", "story_v_out_114251.awb")

						uv0:RecordAudio("114251006", slot19)
						uv0:RecordAudio("114251006", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251006", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251006", "story_v_out_114251.awb")
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
	Play114251007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251007
		slot1.duration_ = 7.466

		if ({
			ja = 7.366,
			ko = 7.266,
			zh = 6.633,
			en = 7.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251007).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251007", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251007", "story_v_out_114251.awb")

						uv0:RecordAudio("114251007", slot16)
						uv0:RecordAudio("114251007", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251007", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251007", "story_v_out_114251.awb")
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
	Play114251008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251008
		slot1.duration_ = 9.333

		if ({
			ja = 9.266,
			ko = 9.333,
			zh = 8.366,
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
				uv0:Play114251009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot3.alpha
					uv0.var_.characterEffect10015 = slot3
				end

				uv0.var_.alphaOldValue10015 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 0
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot6.alpha
					uv0.var_.characterEffect10018 = slot6
				end

				uv0.var_.alphaOldValue10018 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 0, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 0
			end

			slot8 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251008).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251008", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251008", "story_v_out_114251.awb")

						uv0:RecordAudio("114251008", slot16)
						uv0:RecordAudio("114251008", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251008", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251008", "story_v_out_114251.awb")
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
	Play114251009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251009
		slot1.duration_ = 8.666

		if ({
			ja = 8.366,
			ko = 8.666,
			zh = 8.333,
			en = 8.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251009).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251009", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251009", "story_v_out_114251.awb")

						uv0:RecordAudio("114251009", slot10)
						uv0:RecordAudio("114251009", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251009", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251009", "story_v_out_114251.awb")
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
	Play114251010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251011(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(114251010).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play114251011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251012(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(114251011).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play114251012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251012
		slot1.duration_ = 8.7

		if ({
			ja = 8.7,
			ko = 7.133,
			zh = 5.933,
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
				uv0:Play114251013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251012).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251012", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251012", "story_v_out_114251.awb")

						uv0:RecordAudio("114251012", slot10)
						uv0:RecordAudio("114251012", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251012", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251012", "story_v_out_114251.awb")
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
	Play114251013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251013
		slot1.duration_ = 4.566

		if ({
			ja = 4.166,
			ko = 4.5,
			zh = 4.3,
			en = 4.566
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[225].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10005")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251013).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251013", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251013", "story_v_out_114251.awb")

						uv0:RecordAudio("114251013", slot10)
						uv0:RecordAudio("114251013", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251013", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251013", "story_v_out_114251.awb")
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
	Play114251014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			slot3 = 0.6

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5, slot6 = math.modf((uv0.time_ - slot2) / 0.066)
				slot1.localPosition = Vector3.New(slot6 * 0.13, slot6 * 0.13, slot6 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = uv0.var_.shakeOldPos
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot4 + 0.6 and uv0.time_ < slot4 + slot5 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot7 = 1.3

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(114251014).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (51 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
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
	Play114251015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251015
		slot1.duration_ = 7.166

		if ({
			ja = 7.166,
			ko = 3.533,
			zh = 3.733,
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
				uv0:Play114251016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			slot4 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10015 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_1" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10015 then
					for slot17, slot18 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot13 = 0.5

				for slot17, slot18 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot15.alpha
					uv0.var_.characterEffect10018 = slot15
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot14) / slot15)
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot18.alpha
					uv0.var_.characterEffect10015 = slot18
				end

				uv0.var_.alphaOldValue10015 = 0
			end

			slot18 = 0.5

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 1, (uv0.time_ - slot17) / slot18)
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 1
			end

			slot20 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot23 = uv0:FormatText(uv0:GetWordFromCfg(114251015).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251015", "story_v_out_114251.awb") / 1000 + slot19 then
						uv0.duration_ = slot27 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						slot28 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_114251", "114251015", "story_v_out_114251.awb")

						uv0:RecordAudio("114251015", slot28)
						uv0:RecordAudio("114251015", slot28)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251015", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251015", "story_v_out_114251.awb")
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
	Play114251016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251016
		slot1.duration_ = 8.866

		if ({
			ja = 4.2,
			ko = 8.866,
			zh = 7.9,
			en = 5.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot11 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251016).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251016", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251016", "story_v_out_114251.awb")

						uv0:RecordAudio("114251016", slot19)
						uv0:RecordAudio("114251016", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251016", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251016", "story_v_out_114251.awb")
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
	Play114251017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot3.alpha
					uv0.var_.characterEffect10015 = slot3
				end

				uv0.var_.alphaOldValue10015 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 0
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot6.alpha
					uv0.var_.characterEffect10018 = slot6
				end

				uv0.var_.alphaOldValue10018 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 0, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 0
			end

			slot8 = 1.625

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(114251017).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (64 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play114251018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251018
		slot1.duration_ = 3.8

		if ({
			ja = 3.8,
			ko = 2.1,
			zh = 3.1,
			en = 2.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot9.alpha
					uv0.var_.characterEffect10015 = slot9
				end

				uv0.var_.alphaOldValue10015 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 1, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 1
			end

			slot11 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251018).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251018", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251018", "story_v_out_114251.awb")

						uv0:RecordAudio("114251018", slot19)
						uv0:RecordAudio("114251018", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251018", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251018", "story_v_out_114251.awb")
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
	Play114251019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251019
		slot1.duration_ = 4.1

		if ({
			ja = 4.1,
			ko = 3.633,
			zh = 3.433,
			en = 3.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot12.alpha
					uv0.var_.characterEffect10018 = slot12
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot11) / slot12)
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot14 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(114251019).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251019", "story_v_out_114251.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114251", "114251019", "story_v_out_114251.awb")

						uv0:RecordAudio("114251019", slot22)
						uv0:RecordAudio("114251019", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251019", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251019", "story_v_out_114251.awb")
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
	Play114251020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251020
		slot1.duration_ = 9.133

		if ({
			ja = 9.133,
			ko = 6.533,
			zh = 7.366,
			en = 7.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251020).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251020", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251020", "story_v_out_114251.awb")

						uv0:RecordAudio("114251020", slot16)
						uv0:RecordAudio("114251020", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251020", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251020", "story_v_out_114251.awb")
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
	Play114251021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251021
		slot1.duration_ = 8.45

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 7)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -180)
			end

			slot4 = uv0.actors_["10015"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10015 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 7)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_1" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 450)
			end

			if uv0.bgs_.ST24 == nil then
				slot8 = Object.Instantiate(uv0.paintGo_)
				slot8:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot7)
				slot8.name = slot7
				slot8.transform.parent = uv0.stage_.transform
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot7] = slot8
			end

			if 2 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				slot9 = manager.ui.mainCamera.transform.localPosition
				slot11 = uv0.bgs_.ST24
				slot11.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot9.x, slot9.y, 0)
				slot11.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot11:GetComponent("SpriteRenderer") and slot12.sprite then
					slot15 = manager.ui.mainCameraCom_
					slot16 = 2 * (slot11.transform.localPosition - slot9).z * Mathf.Tan(slot15.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot22 = slot16 * slot15.aspect / slot12.sprite.bounds.size.x > slot16 / slot12.sprite.bounds.size.y and slot20 or slot21
					slot11.transform.localScale = Vector3.New(slot22, slot22, 0)
				end

				for slot16, slot17 in pairs(uv0.bgs_) do
					if slot16 ~= "ST24" then
						slot17.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot10 = 2

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12 = Color.New(0, 0, 0)
				slot12.a = Mathf.Lerp(0, 1, (uv0.time_ - slot9) / slot10)
				uv0.mask_.color = slot12
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot11 = Color.New(0, 0, 0)
				slot11.a = 1
				uv0.mask_.color = slot11
			end

			if 2 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot12 = 2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14 = Color.New(0, 0, 0)
				slot14.a = Mathf.Lerp(1, 0, (uv0.time_ - slot11) / slot12)
				uv0.mask_.color = slot14
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot13 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot13.a = 0
				uv0.mask_.color = slot13
			end

			slot14 = 1

			if 1 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_activity_1_4_3", "se_story_activity_1_4_3_door", "")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot16 = 0.55

			if 3.45 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot17 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot17:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot17:setOnComplete(System.Action(function ()
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

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(114251021).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 + 0.3 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot16 = math.max(slot16, uv0.talkMaxDuration)

			if slot15 + 0.3 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
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
	Play114251022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251022
		slot1.duration_ = 3

		if ({
			ja = 3,
			ko = 1.9,
			zh = 1.7,
			en = 1.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			slot4 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10015 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "split_5" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10015 then
					for slot17, slot18 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot13 = 1

				for slot17, slot18 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot15.alpha
					uv0.var_.characterEffect10015 = slot15
				end

				uv0.var_.alphaOldValue10015 = 0
			end

			slot15 = 0.5

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 1, (uv0.time_ - slot14) / slot15)
				end
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 1
			end

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot18.alpha
					uv0.var_.characterEffect10018 = slot18
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot18 = 0.5

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot17) / slot18)
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot20 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot23 = uv0:FormatText(uv0:GetWordFromCfg(114251022).content)
				uv0.text_.text = slot23

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (5 <= 0 and slot20 or slot20 * utf8.len(slot23) / slot24) > 0 and slot20 < slot26 then
					uv0.talkMaxDuration = slot26

					if uv0.duration_ < slot26 + slot19 then
						uv0.duration_ = slot26 + slot19
					end
				end

				uv0.text_.text = slot23
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251022", "story_v_out_114251.awb") / 1000 + slot19 then
						uv0.duration_ = slot27 + slot19
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						slot28 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_114251", "114251022", "story_v_out_114251.awb")

						uv0:RecordAudio("114251022", slot28)
						uv0:RecordAudio("114251022", slot28)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251022", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251022", "story_v_out_114251.awb")
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
	Play114251023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251023
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251023).content)
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
	Play114251024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251024
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251025(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(114251024).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play114251025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251025
		slot1.duration_ = 3.5

		if ({
			ja = 1.833,
			ko = 2.866,
			zh = 3.166,
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
				uv0:Play114251026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251025).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251025", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251025", "story_v_out_114251.awb")

						uv0:RecordAudio("114251025", slot13)
						uv0:RecordAudio("114251025", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251025", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251025", "story_v_out_114251.awb")
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
	Play114251026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251026
		slot1.duration_ = 9.533

		if ({
			ja = 9.533,
			ko = 5.233,
			zh = 5.033,
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
				uv0:Play114251027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251026).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251026", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251026", "story_v_out_114251.awb")

						uv0:RecordAudio("114251026", slot16)
						uv0:RecordAudio("114251026", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251026", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251026", "story_v_out_114251.awb")
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
	Play114251027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251027
		slot1.duration_ = 11.9

		if ({
			ja = 11.366,
			ko = 11.3,
			zh = 11.9,
			en = 11.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251027).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251027", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251027", "story_v_out_114251.awb")

						uv0:RecordAudio("114251027", slot16)
						uv0:RecordAudio("114251027", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251027", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251027", "story_v_out_114251.awb")
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
	Play114251028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251028
		slot1.duration_ = 9.6

		if ({
			ja = 9.6,
			ko = 9.133,
			zh = 9.066,
			en = 9.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251028).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251028", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251028", "story_v_out_114251.awb")

						uv0:RecordAudio("114251028", slot10)
						uv0:RecordAudio("114251028", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251028", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251028", "story_v_out_114251.awb")
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
	Play114251029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251029
		slot1.duration_ = 4.733

		if ({
			ja = 4.233,
			ko = 3.966,
			zh = 4.1,
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
				uv0:Play114251030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251029).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251029", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251029", "story_v_out_114251.awb")

						uv0:RecordAudio("114251029", slot16)
						uv0:RecordAudio("114251029", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251029", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251029", "story_v_out_114251.awb")
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
	Play114251030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251030
		slot1.duration_ = 4.7

		if ({
			ja = 4.7,
			ko = 3.566,
			zh = 3.833,
			en = 3.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251030).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251030", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251030", "story_v_out_114251.awb")

						uv0:RecordAudio("114251030", slot16)
						uv0:RecordAudio("114251030", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251030", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251030", "story_v_out_114251.awb")
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
	Play114251031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251031
		slot1.duration_ = 2.866

		if ({
			ja = 2.866,
			ko = 1.633,
			zh = 2.333,
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
				uv0:Play114251032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot11 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251031).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251031", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251031", "story_v_out_114251.awb")

						uv0:RecordAudio("114251031", slot19)
						uv0:RecordAudio("114251031", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251031", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251031", "story_v_out_114251.awb")
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
	Play114251032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251032
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251032).content)
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
	Play114251033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251033
		slot1.duration_ = 12.733

		if ({
			ja = 12.166,
			ko = 11.8,
			zh = 11.433,
			en = 12.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251033).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251033", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251033", "story_v_out_114251.awb")

						uv0:RecordAudio("114251033", slot16)
						uv0:RecordAudio("114251033", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251033", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251033", "story_v_out_114251.awb")
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
	Play114251034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251034
		slot1.duration_ = 6.9

		if ({
			ja = 6.066,
			ko = 6.833,
			zh = 5.7,
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
				uv0:Play114251035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot11 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251034).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251034", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251034", "story_v_out_114251.awb")

						uv0:RecordAudio("114251034", slot19)
						uv0:RecordAudio("114251034", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251034", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251034", "story_v_out_114251.awb")
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
	Play114251035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251035
		slot1.duration_ = 9.366

		if ({
			ja = 9.366,
			ko = 6.733,
			zh = 4.966,
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
				uv0:Play114251036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251035).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251035", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251035", "story_v_out_114251.awb")

						uv0:RecordAudio("114251035", slot10)
						uv0:RecordAudio("114251035", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251035", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251035", "story_v_out_114251.awb")
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
	Play114251036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251036
		slot1.duration_ = 7.166

		if ({
			ja = 4.566,
			ko = 6.466,
			zh = 5.7,
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
				uv0:Play114251037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251036).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251036", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251036", "story_v_out_114251.awb")

						uv0:RecordAudio("114251036", slot16)
						uv0:RecordAudio("114251036", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251036", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251036", "story_v_out_114251.awb")
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
	Play114251037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251037
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 0.8

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251037).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251038
		slot1.duration_ = 3.5

		if ({
			ja = 3.5,
			ko = 1.7,
			zh = 2.8,
			en = 1.7
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_5" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251038).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251038", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251038", "story_v_out_114251.awb")

						uv0:RecordAudio("114251038", slot16)
						uv0:RecordAudio("114251038", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251038", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251038", "story_v_out_114251.awb")
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
	Play114251039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251039
		slot1.duration_ = 9

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST24a == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST24a
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST24a" then
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

			slot7 = uv0.actors_["10018"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos10018 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 7)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "split_2" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2000, -180)
			end

			slot10 = uv0.actors_["10015"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos10015 = slot10.localPosition
				slot10.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 7)

				for slot16 = 0, slot10.childCount - 1 do
					if slot10:GetChild(slot16).name == "split_5" or not string.find(slot17.name, "split") then
						slot17.gameObject:SetActive(true)
					else
						slot17.gameObject:SetActive(false)
					end
				end
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(0, -2000, 450), (uv0.time_ - slot11) / slot12)
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(0, -2000, 450)
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot14 = 0.05

			if 4 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot15 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot15:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot15:setOnComplete(System.Action(function ()
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

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(114251039).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 + 0.3 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot14 = math.max(slot14, uv0.talkMaxDuration)

			if slot13 + 0.3 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
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
	Play114251040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251040
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			ko = 6.5,
			zh = 6.6,
			en = 6.266
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10021"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10021"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10021 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10021", 2)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "split_1" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10021, Vector3.New(-390, -350, -180), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.actorSpriteComps10021 then
					for slot12, slot13 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot13 then
							slot14 = Mathf.Lerp(slot13.color.r, 1, slot8)
							slot13.color = Color.New(slot14, slot14, slot14)
						end
					end
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot8 = 1

				for slot12, slot13 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot13 then
						slot13.color = Color.New(slot8, slot8, slot8)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				if uv0.actors_["10021"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10021 = slot10.alpha
					uv0.var_.characterEffect10021 = slot10
				end

				uv0.var_.alphaOldValue10021 = 0
			end

			slot10 = 0.5

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				if uv0.var_.characterEffect10021 then
					uv0.var_.characterEffect10021.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10021, 1, (uv0.time_ - slot9) / slot10)
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.characterEffect10021 then
				uv0.var_.characterEffect10021.alpha = 1
			end

			slot12 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(114251040).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251040", "story_v_out_114251.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_114251", "114251040", "story_v_out_114251.awb")

						uv0:RecordAudio("114251040", slot20)
						uv0:RecordAudio("114251040", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251040", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251040", "story_v_out_114251.awb")
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
	Play114251041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251041
		slot1.duration_ = 11

		if ({
			ja = 11,
			ko = 9.3,
			zh = 7.8,
			en = 10.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10021 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot12.alpha
					uv0.var_.characterEffect10018 = slot12
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot11) / slot12)
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot14 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(114251041).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251041", "story_v_out_114251.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114251", "114251041", "story_v_out_114251.awb")

						uv0:RecordAudio("114251041", slot22)
						uv0:RecordAudio("114251041", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251041", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251041", "story_v_out_114251.awb")
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
	Play114251042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251042
		slot1.duration_ = 3.633

		if ({
			ja = 3.066,
			ko = 1.766,
			zh = 2.033,
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
				uv0:Play114251043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251042).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251042", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251042", "story_v_out_114251.awb")

						uv0:RecordAudio("114251042", slot16)
						uv0:RecordAudio("114251042", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251042", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251042", "story_v_out_114251.awb")
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
	Play114251043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251043
		slot1.duration_ = 9.2

		if ({
			ja = 7.866,
			ko = 8.733,
			zh = 9.2,
			en = 8.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251043).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251043", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251043", "story_v_out_114251.awb")

						uv0:RecordAudio("114251043", slot10)
						uv0:RecordAudio("114251043", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251043", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251043", "story_v_out_114251.awb")
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
	Play114251044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251044
		slot1.duration_ = 9.4

		if ({
			ja = 6.066,
			ko = 8.666,
			zh = 8.9,
			en = 9.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251044).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251044", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251044", "story_v_out_114251.awb")

						uv0:RecordAudio("114251044", slot10)
						uv0:RecordAudio("114251044", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251044", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251044", "story_v_out_114251.awb")
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
	Play114251045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251045
		slot1.duration_ = 5.433

		if ({
			ja = 5.433,
			ko = 2.366,
			zh = 4.033,
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
				uv0:Play114251046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10021 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251045).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251045", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251045", "story_v_out_114251.awb")

						uv0:RecordAudio("114251045", slot19)
						uv0:RecordAudio("114251045", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251045", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251045", "story_v_out_114251.awb")
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
	Play114251046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251046
		slot1.duration_ = 8.966

		if ({
			ja = 4.1,
			ko = 6.2,
			zh = 8.966,
			en = 5.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251046).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251046", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251046", "story_v_out_114251.awb")

						uv0:RecordAudio("114251046", slot16)
						uv0:RecordAudio("114251046", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251046", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251046", "story_v_out_114251.awb")
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
	Play114251047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251047
		slot1.duration_ = 7.366

		if ({
			ja = 6.9,
			ko = 5.833,
			zh = 7.366,
			en = 6.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251047).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251047", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251047", "story_v_out_114251.awb")

						uv0:RecordAudio("114251047", slot16)
						uv0:RecordAudio("114251047", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251047", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251047", "story_v_out_114251.awb")
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
	Play114251048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251048
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			ko = 4.8,
			zh = 5.733,
			en = 6.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251048).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251048", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251048", "story_v_out_114251.awb")

						uv0:RecordAudio("114251048", slot10)
						uv0:RecordAudio("114251048", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251048", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251048", "story_v_out_114251.awb")
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
	Play114251049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251049
		slot1.duration_ = 8.3

		if ({
			ja = 8.3,
			ko = 5.4,
			zh = 5.233,
			en = 4.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251049).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251049", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251049", "story_v_out_114251.awb")

						uv0:RecordAudio("114251049", slot16)
						uv0:RecordAudio("114251049", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251049", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251049", "story_v_out_114251.awb")
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
	Play114251050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251050
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 1.1

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251050).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251051
		slot1.duration_ = 1.9

		if ({
			ja = 1.233,
			ko = 1.9,
			zh = 0.999999999999,
			en = 1.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251051).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251051", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251051", "story_v_out_114251.awb")

						uv0:RecordAudio("114251051", slot13)
						uv0:RecordAudio("114251051", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251051", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251051", "story_v_out_114251.awb")
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
	Play114251052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251052
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251052).content)
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
	Play114251053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251053
		slot1.duration_ = 7.333

		if ({
			ja = 6.1,
			ko = 7.333,
			zh = 7.266,
			en = 6.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251053).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251053", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251053", "story_v_out_114251.awb")

						uv0:RecordAudio("114251053", slot13)
						uv0:RecordAudio("114251053", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251053", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251053", "story_v_out_114251.awb")
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
	Play114251054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251054
		slot1.duration_ = 10.066

		if ({
			ja = 10.066,
			ko = 7.366,
			zh = 6.233,
			en = 6.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10021 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251054).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251054", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251054", "story_v_out_114251.awb")

						uv0:RecordAudio("114251054", slot19)
						uv0:RecordAudio("114251054", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251054", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251054", "story_v_out_114251.awb")
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
	Play114251055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251055
		slot1.duration_ = 6.966

		if ({
			ja = 6.966,
			ko = 4.833,
			zh = 2.966,
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
				uv0:Play114251056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251055).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251055", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251055", "story_v_out_114251.awb")

						uv0:RecordAudio("114251055", slot16)
						uv0:RecordAudio("114251055", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251055", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251055", "story_v_out_114251.awb")
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
	Play114251056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251056
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251056).content)
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
	Play114251057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251057
		slot1.duration_ = 11.933

		if ({
			ja = 11.933,
			ko = 8.866,
			zh = 9.266,
			en = 8.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251057).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251057", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251057", "story_v_out_114251.awb")

						uv0:RecordAudio("114251057", slot13)
						uv0:RecordAudio("114251057", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251057", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251057", "story_v_out_114251.awb")
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
	Play114251058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251058
		slot1.duration_ = 8.266

		if ({
			ja = 6.5,
			ko = 6.733,
			zh = 8.266,
			en = 6.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10021 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.75

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251058).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251058", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251058", "story_v_out_114251.awb")

						uv0:RecordAudio("114251058", slot19)
						uv0:RecordAudio("114251058", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251058", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251058", "story_v_out_114251.awb")
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
	Play114251059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251059
		slot1.duration_ = 9.333

		if ({
			ja = 9.333,
			ko = 8.1,
			zh = 7.366,
			en = 7.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251059).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251059", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251059", "story_v_out_114251.awb")

						uv0:RecordAudio("114251059", slot16)
						uv0:RecordAudio("114251059", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251059", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251059", "story_v_out_114251.awb")
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
	Play114251060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251060
		slot1.duration_ = 12.566

		if ({
			ja = 12.566,
			ko = 6.966,
			zh = 7.4,
			en = 6.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251060).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251060", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251060", "story_v_out_114251.awb")

						uv0:RecordAudio("114251060", slot10)
						uv0:RecordAudio("114251060", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251060", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251060", "story_v_out_114251.awb")
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
	Play114251061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251061
		slot1.duration_ = 18.1

		if ({
			ja = 15.766,
			ko = 11.066,
			zh = 11.133,
			en = 18.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.375

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251061).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (54 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251061", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251061", "story_v_out_114251.awb")

						uv0:RecordAudio("114251061", slot10)
						uv0:RecordAudio("114251061", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251061", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251061", "story_v_out_114251.awb")
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
	Play114251062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251062
		slot1.duration_ = 6.733

		if ({
			ja = 6.733,
			ko = 3.033,
			zh = 2.766,
			en = 3.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot9.alpha
					uv0.var_.characterEffect10018 = slot9
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot9 = 0.0166666666666667

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot11 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251062).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251062", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251062", "story_v_out_114251.awb")

						uv0:RecordAudio("114251062", slot19)
						uv0:RecordAudio("114251062", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251062", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251062", "story_v_out_114251.awb")
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
	Play114251063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251063
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251063).content)
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
	Play114251064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251064
		slot1.duration_ = 3.933

		if ({
			ja = 2.3,
			ko = 2.966,
			zh = 2.633,
			en = 3.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251064).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251064", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251064", "story_v_out_114251.awb")

						uv0:RecordAudio("114251064", slot16)
						uv0:RecordAudio("114251064", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251064", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251064", "story_v_out_114251.awb")
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
	Play114251065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251065
		slot1.duration_ = 2.233

		if ({
			ja = 1.7,
			ko = 1.4,
			zh = 2.233,
			en = 1.433
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251066(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251065).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251065", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251065", "story_v_out_114251.awb")

						uv0:RecordAudio("114251065", slot16)
						uv0:RecordAudio("114251065", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251065", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251065", "story_v_out_114251.awb")
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
	Play114251066 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251066
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251067(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251066).content)
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
	Play114251067 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251067
		slot1.duration_ = 2.033

		if ({
			ja = 1.5,
			ko = 1.566,
			zh = 1.433,
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
				uv0:Play114251068(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251067).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251067", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251067", "story_v_out_114251.awb")

						uv0:RecordAudio("114251067", slot16)
						uv0:RecordAudio("114251067", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251067", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251067", "story_v_out_114251.awb")
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
	Play114251068 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251068
		slot1.duration_ = 5.066

		if ({
			ja = 3.433,
			ko = 4.1,
			zh = 4.766,
			en = 5.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251069(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251068).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251068", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251068", "story_v_out_114251.awb")

						uv0:RecordAudio("114251068", slot13)
						uv0:RecordAudio("114251068", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251068", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251068", "story_v_out_114251.awb")
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
	Play114251069 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251069
		slot1.duration_ = 4.833

		if ({
			ja = 3.333,
			ko = 4.133,
			zh = 4.833,
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
				uv0:Play114251070(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251069).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251069", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251069", "story_v_out_114251.awb")

						uv0:RecordAudio("114251069", slot16)
						uv0:RecordAudio("114251069", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251069", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251069", "story_v_out_114251.awb")
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
	Play114251070 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251070
		slot1.duration_ = 4.466

		if ({
			ja = 3.566,
			ko = 3.766,
			zh = 4.466,
			en = 4.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251071(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251070).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251070", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251070", "story_v_out_114251.awb")

						uv0:RecordAudio("114251070", slot16)
						uv0:RecordAudio("114251070", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251070", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251070", "story_v_out_114251.awb")
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
	Play114251071 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251071
		slot1.duration_ = 2.5

		if ({
			ja = 2.5,
			ko = 1.533,
			zh = 1.3,
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
				uv0:Play114251072(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251071).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251071", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251071", "story_v_out_114251.awb")

						uv0:RecordAudio("114251071", slot16)
						uv0:RecordAudio("114251071", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251071", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251071", "story_v_out_114251.awb")
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
	Play114251072 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251072
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251073(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 0.775

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251072).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (31 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251073 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251073
		slot1.duration_ = 16.666

		if ({
			ja = 11.833,
			ko = 12.2,
			zh = 16.1,
			en = 16.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251074(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 1.65

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251073).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (65 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251073", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251073", "story_v_out_114251.awb")

						uv0:RecordAudio("114251073", slot13)
						uv0:RecordAudio("114251073", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251073", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251073", "story_v_out_114251.awb")
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
	Play114251074 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251074
		slot1.duration_ = 5.866

		if ({
			ja = 5.866,
			ko = 2.533,
			zh = 2.766,
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
				uv0:Play114251075(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251074).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251074", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251074", "story_v_out_114251.awb")

						uv0:RecordAudio("114251074", slot16)
						uv0:RecordAudio("114251074", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251074", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251074", "story_v_out_114251.awb")
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
	Play114251075 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251075
		slot1.duration_ = 11.566

		if ({
			ja = 8.8,
			ko = 10.266,
			zh = 11.566,
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
				uv0:Play114251076(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 1.05

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251075).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251075", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251075", "story_v_out_114251.awb")

						uv0:RecordAudio("114251075", slot16)
						uv0:RecordAudio("114251075", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251075", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251075", "story_v_out_114251.awb")
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
	Play114251076 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251076
		slot1.duration_ = 4.233

		if ({
			ja = 4.233,
			ko = 3.033,
			zh = 3,
			en = 3.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251077(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251076).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251076", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251076", "story_v_out_114251.awb")

						uv0:RecordAudio("114251076", slot16)
						uv0:RecordAudio("114251076", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251076", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251076", "story_v_out_114251.awb")
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
	Play114251077 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251077
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251078(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 0.8

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251077).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251078 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251078
		slot1.duration_ = 12.933

		if ({
			ja = 9.966,
			ko = 12.933,
			zh = 12.466,
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
				uv0:Play114251079(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251078).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251078", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251078", "story_v_out_114251.awb")

						uv0:RecordAudio("114251078", slot13)
						uv0:RecordAudio("114251078", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251078", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251078", "story_v_out_114251.awb")
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
	Play114251079 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251079
		slot1.duration_ = 5.433

		if ({
			ja = 5.433,
			ko = 3.4,
			zh = 3.333,
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
				uv0:Play114251080(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251079).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251079", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251079", "story_v_out_114251.awb")

						uv0:RecordAudio("114251079", slot16)
						uv0:RecordAudio("114251079", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251079", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251079", "story_v_out_114251.awb")
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
	Play114251080 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251080
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251081(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251080).content)
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
	Play114251081 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251081
		slot1.duration_ = 4.233

		if ({
			ja = 3.666,
			ko = 4.233,
			zh = 2.966,
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
				uv0:Play114251082(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			slot5 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251081).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end

				uv0.text_.text = slot8
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251081", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251081", "story_v_out_114251.awb")

						uv0:RecordAudio("114251081", slot13)
						uv0:RecordAudio("114251081", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251081", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251081", "story_v_out_114251.awb")
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
	Play114251082 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251082
		slot1.duration_ = 5.2

		if ({
			ja = 4.766,
			ko = 3.1,
			zh = 5.2,
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
				uv0:Play114251083(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10021 == nil then
				uv0.var_.actorSpriteComps10021 = uv0.actors_["10021"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10021 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10021 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10021:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10021 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251082).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251082", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251082", "story_v_out_114251.awb")

						uv0:RecordAudio("114251082", slot16)
						uv0:RecordAudio("114251082", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251082", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251082", "story_v_out_114251.awb")
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
	Play114251083 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251083
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251084(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot3.alpha
					uv0.var_.characterEffect10018 = slot3
				end

				uv0.var_.alphaOldValue10018 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 0
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.actors_["10021"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10021 = slot6.alpha
					uv0.var_.characterEffect10021 = slot6
				end

				uv0.var_.alphaOldValue10021 = 1
			end

			slot6 = 0.5

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect10021 then
					uv0.var_.characterEffect10021.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10021, 0, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10021 then
				uv0.var_.characterEffect10021.alpha = 0
			end

			slot8 = 0.925

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(114251083).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play114251084 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251084
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251085(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(114251084).content)
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
	Play114251085 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251085
		slot1.duration_ = 4.3

		if ({
			ja = 3.133,
			ko = 3.6,
			zh = 4,
			en = 4.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251086(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 3)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(0, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot9.alpha
					uv0.var_.characterEffect10018 = slot9
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot9 = 0.5

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot11 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251085).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251085", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251085", "story_v_out_114251.awb")

						uv0:RecordAudio("114251085", slot19)
						uv0:RecordAudio("114251085", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251085", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251085", "story_v_out_114251.awb")
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
	Play114251086 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251086
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251087(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 2.3

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251086).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (92 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251087 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251087
		slot1.duration_ = 3.666

		if ({
			ja = 2.833,
			ko = 3.666,
			zh = 3.466,
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
				uv0:Play114251088(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 3)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(0, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot9.alpha
					uv0.var_.characterEffect10018 = slot9
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot9 = 0.0166666666666667

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot8) / slot9)
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251087).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251087", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251087", "story_v_out_114251.awb")

						uv0:RecordAudio("114251087", slot19)
						uv0:RecordAudio("114251087", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251087", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251087", "story_v_out_114251.awb")
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
	Play114251088 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251088
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251089(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251088).content)
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
	Play114251089 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251089
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251090(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot3.alpha
					uv0.var_.characterEffect10018 = slot3
				end

				uv0.var_.alphaOldValue10018 = 1
			end

			slot3 = 0.5

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 0
			end

			slot5 = 1.075

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251089).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play114251090 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251090
		slot1.duration_ = 15.5

		if ({
			ja = 15.5,
			ko = 2.8,
			zh = 3.933,
			en = 2.7
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251091(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[226].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10021")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251090).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251090", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251090", "story_v_out_114251.awb")

						uv0:RecordAudio("114251090", slot10)
						uv0:RecordAudio("114251090", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251090", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251090", "story_v_out_114251.awb")
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
	Play114251091 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251091
		slot1.duration_ = 2.333

		if ({
			ja = 2.333,
			ko = 1.533,
			zh = 0.999999999999,
			en = 1.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251092(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot5 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(114251091).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251091", "story_v_out_114251.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_114251", "114251091", "story_v_out_114251.awb")

						uv0:RecordAudio("114251091", slot13)
						uv0:RecordAudio("114251091", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251091", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251091", "story_v_out_114251.awb")
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
	Play114251092 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251092
		slot1.duration_ = 6.133

		if ({
			ja = 4.633,
			ko = 6.133,
			zh = 5.9,
			en = 5.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251093(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[258].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10018")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251092).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (24 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251092", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251092", "story_v_out_114251.awb")

						uv0:RecordAudio("114251092", slot10)
						uv0:RecordAudio("114251092", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251092", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251092", "story_v_out_114251.awb")
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
	Play114251093 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251093
		slot1.duration_ = 18.2

		if ({
			ja = 16.2,
			ko = 17.633,
			zh = 16.7,
			en = 18.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251094(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 1.999999999999 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.ST24
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "ST24" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot3 = 2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5 = Color.New(0, 0, 0)
				slot5.a = Mathf.Lerp(0, 1, (uv0.time_ - slot2) / slot3)
				uv0.mask_.color = slot5
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot4 = Color.New(0, 0, 0)
				slot4.a = 1
				uv0.mask_.color = slot4
			end

			if 2 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot5 = 2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot7 = Color.New(0, 0, 0)
				slot7.a = Mathf.Lerp(1, 0, (uv0.time_ - slot4) / slot5)
				uv0.mask_.color = slot7
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				slot6 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot6.a = 0
				uv0.mask_.color = slot6
			end

			slot6 = uv0.actors_["10018"].transform

			if 3.8 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos10018 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot12 = 0, slot6.childCount - 1 do
					if slot6:GetChild(slot12).name == "split_1" or not string.find(slot13.name, "split") then
						slot13.gameObject:SetActive(true)
					else
						slot13.gameObject:SetActive(false)
					end
				end
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(-390, -350, -180)
			end

			slot9 = uv0.actors_["10018"].transform

			if 1.966 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos10018 = slot9.localPosition
				slot9.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 7)

				for slot15 = 0, slot9.childCount - 1 do
					if slot9:GetChild(slot15).name == "split_1" or not string.find(slot16.name, "split") then
						slot16.gameObject:SetActive(true)
					else
						slot16.gameObject:SetActive(false)
					end
				end
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(0, -2000, -180), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(0, -2000, -180)
			end

			if 3.8 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot14 = 0.034

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.actorSpriteComps10018 then
					for slot19, slot20 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot20 then
							slot21 = Mathf.Lerp(slot20.color.r, 1, slot15)
							slot20.color = Color.New(slot21, slot21, slot21)
						end
					end
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot15 = 1

				for slot19, slot20 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot20 then
						slot20.color = Color.New(slot15, slot15, slot15)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 3.8 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				if uv0.actors_["10018"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10018 = slot17.alpha
					uv0.var_.characterEffect10018 = slot17
				end

				uv0.var_.alphaOldValue10018 = 0
			end

			slot17 = 0.5

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				if uv0.var_.characterEffect10018 then
					uv0.var_.characterEffect10018.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10018, 1, (uv0.time_ - slot16) / slot17)
				end
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 and uv0.var_.characterEffect10018 then
				uv0.var_.characterEffect10018.alpha = 1
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot19 = 1.225

			if 4 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot20 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot20:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot20:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot23 = uv0:FormatText(uv0:GetWordFromCfg(114251093).content)
				uv0.text_.text = slot23

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot19 or slot19 * utf8.len(slot23) / slot24) > 0 and slot19 < slot26 then
					uv0.talkMaxDuration = slot26

					if uv0.duration_ < slot26 + slot18 + 0.3 then
						uv0.duration_ = slot26 + slot18
					end
				end

				uv0.text_.text = slot23
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251093", "story_v_out_114251.awb") / 1000 + slot18 then
						uv0.duration_ = slot27 + slot18
					end

					if slot22.prefab_name ~= "" and uv0.actors_[slot22.prefab_name] ~= nil then
						slot28 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot22.prefab_name].transform, "story_v_out_114251", "114251093", "story_v_out_114251.awb")

						uv0:RecordAudio("114251093", slot28)
						uv0:RecordAudio("114251093", slot28)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251093", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251093", "story_v_out_114251.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot19 = math.max(slot19, uv0.talkMaxDuration)

			if slot18 + 0.3 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
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
	Play114251094 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251094
		slot1.duration_ = 7.666

		if ({
			ja = 7.5,
			ko = 7.366,
			zh = 7.666,
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
				uv0:Play114251095(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				if uv0.actors_["10015"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue10015 = slot12.alpha
					uv0.var_.characterEffect10015 = slot12
				end

				uv0.var_.alphaOldValue10015 = 0
			end

			slot12 = 0.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				if uv0.var_.characterEffect10015 then
					uv0.var_.characterEffect10015.alpha = Mathf.Lerp(uv0.var_.alphaOldValue10015, 1, (uv0.time_ - slot11) / slot12)
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10015 then
				uv0.var_.characterEffect10015.alpha = 1
			end

			slot14 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(114251094).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251094", "story_v_out_114251.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_114251", "114251094", "story_v_out_114251.awb")

						uv0:RecordAudio("114251094", slot22)
						uv0:RecordAudio("114251094", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251094", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251094", "story_v_out_114251.awb")
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
	Play114251095 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251095
		slot1.duration_ = 16.666

		if ({
			ja = 16.666,
			ko = 14.133,
			zh = 15.566,
			en = 13.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251096(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 1.775

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251095).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (71 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251095", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251095", "story_v_out_114251.awb")

						uv0:RecordAudio("114251095", slot16)
						uv0:RecordAudio("114251095", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251095", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251095", "story_v_out_114251.awb")
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
	Play114251096 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251096
		slot1.duration_ = 12.866

		if ({
			ja = 11.166,
			ko = 12.866,
			zh = 9.233,
			en = 10.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251097(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251096).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251096", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251096", "story_v_out_114251.awb")

						uv0:RecordAudio("114251096", slot10)
						uv0:RecordAudio("114251096", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251096", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251096", "story_v_out_114251.awb")
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
	Play114251097 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251097
		slot1.duration_ = 13.5

		if ({
			ja = 13.5,
			ko = 11.966,
			zh = 11.5,
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
				uv0:Play114251098(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.275

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(114251097).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251097", "story_v_out_114251.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_114251", "114251097", "story_v_out_114251.awb")

						uv0:RecordAudio("114251097", slot10)
						uv0:RecordAudio("114251097", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251097", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251097", "story_v_out_114251.awb")
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
	Play114251098 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251098
		slot1.duration_ = 5.4

		if ({
			ja = 5.4,
			ko = 4.433,
			zh = 4.6,
			en = 2.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251099(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot8 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251098).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251098", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251098", "story_v_out_114251.awb")

						uv0:RecordAudio("114251098", slot16)
						uv0:RecordAudio("114251098", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251098", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251098", "story_v_out_114251.awb")
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
	Play114251099 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251099
		slot1.duration_ = 13.5

		if ({
			ja = 13.5,
			ko = 13.233,
			zh = 11.433,
			en = 13.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251100(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10018 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot8 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(114251099).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251099", "story_v_out_114251.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_114251", "114251099", "story_v_out_114251.awb")

						uv0:RecordAudio("114251099", slot16)
						uv0:RecordAudio("114251099", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251099", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251099", "story_v_out_114251.awb")
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
	Play114251100 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251100
		slot1.duration_ = 9.166

		if ({
			ja = 9.166,
			ko = 7.433,
			zh = 8.4,
			en = 6.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251101(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251100).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251100", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251100", "story_v_out_114251.awb")

						uv0:RecordAudio("114251100", slot19)
						uv0:RecordAudio("114251100", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251100", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251100", "story_v_out_114251.awb")
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
	Play114251101 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251101
		slot1.duration_ = 8.9

		if ({
			ja = 7.6,
			ko = 8.9,
			zh = 7.033,
			en = 7.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251102(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251101).content)
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

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251101", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251101", "story_v_out_114251.awb")

						uv0:RecordAudio("114251101", slot19)
						uv0:RecordAudio("114251101", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251101", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251101", "story_v_out_114251.awb")
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
	Play114251102 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251102
		slot1.duration_ = 2.3

		if ({
			ja = 2.3,
			ko = 2.133,
			zh = 1.2,
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
				uv0:Play114251103(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10015"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10015 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10015", 4)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10015, Vector3.New(390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10015 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10018 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			slot11 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[208].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251102).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251102", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251102", "story_v_out_114251.awb")

						uv0:RecordAudio("114251102", slot19)
						uv0:RecordAudio("114251102", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251102", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251102", "story_v_out_114251.awb")
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
	Play114251103 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251103
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play114251104(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10015 then
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(114251103).content)
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
	Play114251104 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 114251104
		slot1.duration_ = 14.9

		if ({
			ja = 7.6,
			ko = 14.9,
			zh = 14.8,
			en = 12.4
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
			slot1 = uv0.actors_["10018"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10018 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("10018", 2)

				for slot7 = 0, slot1.childCount - 1 do
					if slot1:GetChild(slot7).name == "split_2" or not string.find(slot8.name, "split") then
						slot8.gameObject:SetActive(true)
					else
						slot8.gameObject:SetActive(false)
					end
				end
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10018, Vector3.New(-390, -350, -180), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -350, -180)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10018 == nil then
				uv0.var_.actorSpriteComps10018 = uv0.actors_["10018"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10018 then
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10018 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps10018:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10018 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10015 == nil then
				uv0.var_.actorSpriteComps10015 = uv0.actors_["10015"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10015 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10015 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps10015:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10015 = nil
			end

			slot11 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[257].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(114251104).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (43 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_114251", "114251104", "story_v_out_114251.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_114251", "114251104", "story_v_out_114251.awb")

						uv0:RecordAudio("114251104", slot19)
						uv0:RecordAudio("114251104", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_114251", "114251104", "story_v_out_114251.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_114251", "114251104", "story_v_out_114251.awb")
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST25",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST24",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST24a"
	},
	voices = {
		"story_v_out_114251.awb"
	}
}
