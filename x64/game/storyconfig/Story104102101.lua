return {
	Play410211001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST66 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST66
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST66" then
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

			slot6 = 0.166666666666667

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot8 = 1

			if 0.3 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building", "bgm_activity_2_8_story_tara_building.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 1.05

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(410211001).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play410211002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211002
		slot1.duration_ = 15.233

		if ({
			ja = 15.233,
			CriLanguages = 9.166,
			zh = 9.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1061"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos1061 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
				slot8 = 2

				uv0:CheckSpriteTmpPos("1061", slot8)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(-390, -490, 18)
			end

			if uv0.actors_["10059"] == nil then
				slot6 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot5), uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos10059 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)
				slot12 = 4

				uv0:CheckSpriteTmpPos("10059", slot12)

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
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot11 = 0.034

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot12 = (uv0.time_ - slot10) / slot11

				if uv0.var_.actorSpriteComps1061 then
					slot15 = uv0.var_.actorSpriteComps1061
					slot17 = slot15

					for slot16, slot17 in pairs(slot15.ToTable(slot17)) do
						if slot17 then
							slot18 = Mathf.Lerp(slot17.color.r, 1, slot12)
							slot17.color = Color.New(slot18, slot18, slot18)
						end
					end
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot12 = 1
				slot15 = uv0.var_.actorSpriteComps1061
				slot17 = slot15

				for slot16, slot17 in pairs(slot15.ToTable(slot17)) do
					if slot17 then
						slot17.color = Color.New(slot12, slot12, slot12)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot14 = 0.034

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.actorSpriteComps10059 then
					slot18 = uv0.var_.actorSpriteComps10059
					slot20 = slot18

					for slot19, slot20 in pairs(slot18.ToTable(slot20)) do
						if slot20 then
							slot21 = Mathf.Lerp(slot20.color.r, 0.5, slot15)
							slot20.color = Color.New(slot21, slot21, slot21)
						end
					end
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot15 = 0.5
				slot18 = uv0.var_.actorSpriteComps10059
				slot20 = slot18

				for slot19, slot20 in pairs(slot18.ToTable(slot20)) do
					if slot20 then
						slot20.color = Color.New(slot15, slot15, slot15)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot16 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(410211002).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
					uv0.talkMaxDuration = slot22

					if uv0.duration_ < slot22 + slot15 then
						uv0.duration_ = slot22 + slot15
					end
				end

				uv0.text_.text = slot19
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211002", "story_v_out_410211.awb") / 1000 + slot15 then
						uv0.duration_ = slot23 + slot15
					end

					if slot18.prefab_name ~= "" and uv0.actors_[slot18.prefab_name] ~= nil then
						slot24 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot18.prefab_name].transform, "story_v_out_410211", "410211002", "story_v_out_410211.awb")

						uv0:RecordAudio("410211002", slot24)
						uv0:RecordAudio("410211002", slot24)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211002", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211002", "story_v_out_410211.awb")
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
	Play410211003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211003
		slot1.duration_ = 1.9

		if ({
			ja = 1.6,
			CriLanguages = 1.9,
			zh = 1.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 1
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211003).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (6 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211003", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211003", "story_v_out_410211.awb")

						uv0:RecordAudio("410211003", slot22)
						uv0:RecordAudio("410211003", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211003", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211003", "story_v_out_410211.awb")
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
	Play410211004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211004
		slot1.duration_ = 17.5

		if ({
			ja = 17.5,
			CriLanguages = 10.666,
			zh = 10.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 1.225

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211004).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211004", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211004", "story_v_out_410211.awb")

						uv0:RecordAudio("410211004", slot22)
						uv0:RecordAudio("410211004", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211004", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211004", "story_v_out_410211.awb")
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
	Play410211005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211005
		slot1.duration_ = 4.4

		if ({
			ja = 4.4,
			CriLanguages = 1.9,
			zh = 1.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 1
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211005).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211005", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211005", "story_v_out_410211.awb")

						uv0:RecordAudio("410211005", slot22)
						uv0:RecordAudio("410211005", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211005", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211005", "story_v_out_410211.awb")
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
	Play410211006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211006
		slot1.duration_ = 7.266

		if ({
			ja = 7.266,
			CriLanguages = 3.833,
			zh = 3.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211006).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211006", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211006", "story_v_out_410211.awb")

						uv0:RecordAudio("410211006", slot22)
						uv0:RecordAudio("410211006", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211006", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211006", "story_v_out_410211.awb")
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
	Play410211007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211007
		slot1.duration_ = 0.999999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10060"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10060 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
				slot8 = 4

				uv0:CheckSpriteTmpPos("10060", slot8)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10060, Vector3.New(390, -400, 0), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(390, -400, 0)
			end

			slot5 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPos10059 = slot5.localPosition
				slot5.localScale = Vector3.New(1, 1, 1)
				slot11 = 7

				uv0:CheckSpriteTmpPos("10059", slot11)

				for slot11 = 0, slot5.childCount - 1 do
					if slot5:GetChild(slot11).name == "" or not string.find(slot12.name, "split") then
						slot12.gameObject:SetActive(true)
					else
						slot12.gameObject:SetActive(false)
					end
				end
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, -2000, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 and uv0.var_.actorSpriteComps10060 == nil then
				uv0.var_.actorSpriteComps10060 = uv0.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot10 = 0.034

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot11 = (uv0.time_ - slot9) / slot10

				if uv0.var_.actorSpriteComps10060 then
					slot14 = uv0.var_.actorSpriteComps10060
					slot16 = slot14

					for slot15, slot16 in pairs(slot14.ToTable(slot16)) do
						if slot16 then
							slot17 = Mathf.Lerp(slot16.color.r, 1, slot11)
							slot16.color = Color.New(slot17, slot17, slot17)
						end
					end
				end
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 and uv0.var_.actorSpriteComps10060 then
				slot11 = 1
				slot14 = uv0.var_.actorSpriteComps10060
				slot16 = slot14

				for slot15, slot16 in pairs(slot14.ToTable(slot16)) do
					if slot16 then
						slot16.color = Color.New(slot11, slot11, slot11)
					end
				end

				uv0.var_.actorSpriteComps10060 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot13 = 0.034

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot14 = (uv0.time_ - slot12) / slot13

				if uv0.var_.actorSpriteComps10059 then
					slot17 = uv0.var_.actorSpriteComps10059
					slot19 = slot17

					for slot18, slot19 in pairs(slot17.ToTable(slot19)) do
						if slot19 then
							slot20 = Mathf.Lerp(slot19.color.r, 0.5, slot14)
							slot19.color = Color.New(slot20, slot20, slot20)
						end
					end
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot14 = 0.5
				slot17 = uv0.var_.actorSpriteComps10059
				slot19 = slot17

				for slot18, slot19 in pairs(slot17.ToTable(slot19)) do
					if slot19 then
						slot19.color = Color.New(slot14, slot14, slot14)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot16 = 0.034

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot17 = (uv0.time_ - slot15) / slot16

				if uv0.var_.actorSpriteComps1061 then
					slot20 = uv0.var_.actorSpriteComps1061
					slot22 = slot20

					for slot21, slot22 in pairs(slot20.ToTable(slot22)) do
						if slot22 then
							slot23 = Mathf.Lerp(slot22.color.r, 0.5, slot17)
							slot22.color = Color.New(slot23, slot23, slot23)
						end
					end
				end
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot17 = 0.5
				slot20 = uv0.var_.actorSpriteComps1061
				slot22 = slot20

				for slot21, slot22 in pairs(slot20.ToTable(slot22)) do
					if slot22 then
						slot22.color = Color.New(slot17, slot17, slot17)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot18 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(410211007).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (2 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 then
						uv0.duration_ = slot24 + slot17
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211007", "story_v_out_410211.awb") / 1000 + slot17 then
						uv0.duration_ = slot25 + slot17
					end

					if slot20.prefab_name ~= "" and uv0.actors_[slot20.prefab_name] ~= nil then
						slot26 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot20.prefab_name].transform, "story_v_out_410211", "410211007", "story_v_out_410211.awb")

						uv0:RecordAudio("410211007", slot26)
						uv0:RecordAudio("410211007", slot26)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211007", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211007", "story_v_out_410211.awb")
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
	Play410211008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211008
		slot1.duration_ = 5.066

		if ({
			ja = 5.066,
			CriLanguages = 2.766,
			zh = 2.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10060", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10060, Vector3.New(390, -400, 0), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -400, 0)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10060 == nil then
				uv0.var_.actorSpriteComps10060 = uv0.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10060 then
					slot10 = uv0.var_.actorSpriteComps10060
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10060 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10060
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10060 = nil
			end

			slot8 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[597].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211008).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211008", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211008", "story_v_out_410211.awb")

						uv0:RecordAudio("410211008", slot16)
						uv0:RecordAudio("410211008", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211008", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211008", "story_v_out_410211.awb")
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
	Play410211009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211009
		slot1.duration_ = 14.933

		if ({
			ja = 14.933,
			CriLanguages = 9,
			zh = 9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10060 == nil then
				uv0.var_.actorSpriteComps10060 = uv0.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10060 then
					slot13 = uv0.var_.actorSpriteComps10060
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10060 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10060
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10060 = nil
			end

			slot11 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211009).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (40 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211009", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211009", "story_v_out_410211.awb")

						uv0:RecordAudio("410211009", slot19)
						uv0:RecordAudio("410211009", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211009", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211009", "story_v_out_410211.awb")
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
	Play410211010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10060"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10060 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10060", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10060, Vector3.New(0, -2000, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10060 == nil then
				uv0.var_.actorSpriteComps10060 = uv0.actors_["10060"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10060 then
					slot10 = uv0.var_.actorSpriteComps10060
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10060 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10060
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10060 = nil
			end

			slot7 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1061 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 7

				uv0:CheckSpriteTmpPos("1061", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2000, 18)
			end

			slot11 = 1.725

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(410211010).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (69 <= 0 and slot11 or slot11 * utf8.len(slot13) / slot14) > 0 and slot11 < slot16 then
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
	Play410211011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211011
		slot1.duration_ = 7.266

		if ({
			ja = 7.266,
			CriLanguages = 6.633,
			zh = 6.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot7 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1061 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 2

				uv0:CheckSpriteTmpPos("1061", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1061 then
					slot16 = uv0.var_.actorSpriteComps1061
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps1061
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot14 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211011).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211011", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211011", "story_v_out_410211.awb")

						uv0:RecordAudio("410211011", slot22)
						uv0:RecordAudio("410211011", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211011", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211011", "story_v_out_410211.awb")
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
	Play410211012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211012
		slot1.duration_ = 15.8

		if ({
			ja = 15.8,
			CriLanguages = 7.433,
			zh = 7.433
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.85

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211012).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (34 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211012", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211012", "story_v_out_410211.awb")

						uv0:RecordAudio("410211012", slot19)
						uv0:RecordAudio("410211012", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211012", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211012", "story_v_out_410211.awb")
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
	Play410211013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211013
		slot1.duration_ = 6.733

		if ({
			ja = 6.733,
			CriLanguages = 4.333,
			zh = 4.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot11 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211013).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211013", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211013", "story_v_out_410211.awb")

						uv0:RecordAudio("410211013", slot19)
						uv0:RecordAudio("410211013", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211013", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211013", "story_v_out_410211.awb")
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
	Play410211014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211014
		slot1.duration_ = 12.333

		if ({
			ja = 12.333,
			CriLanguages = 7.9,
			zh = 7.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211014).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211014", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211014", "story_v_out_410211.awb")

						uv0:RecordAudio("410211014", slot16)
						uv0:RecordAudio("410211014", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211014", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211014", "story_v_out_410211.awb")
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
	Play410211015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211015
		slot1.duration_ = 3.9

		if ({
			ja = 3.9,
			CriLanguages = 3.4,
			zh = 3.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211015).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211015", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211015", "story_v_out_410211.awb")

						uv0:RecordAudio("410211015", slot19)
						uv0:RecordAudio("410211015", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211015", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211015", "story_v_out_410211.awb")
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
	Play410211016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211016
		slot1.duration_ = 2.9

		if ({
			ja = 2.9,
			CriLanguages = 1.3,
			zh = 1.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot11 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211016).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211016", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211016", "story_v_out_410211.awb")

						uv0:RecordAudio("410211016", slot19)
						uv0:RecordAudio("410211016", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211016", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211016", "story_v_out_410211.awb")
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
	Play410211017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 35)
			end

			slot4 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1061 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 7

				uv0:CheckSpriteTmpPos("1061", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 18)
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211017).content)
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
	Play410211018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211018
		slot1.duration_ = 4.166

		if ({
			ja = 4.166,
			CriLanguages = 3.333,
			zh = 3.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot7 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1061 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 2

				uv0:CheckSpriteTmpPos("1061", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1061 then
					slot16 = uv0.var_.actorSpriteComps1061
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps1061
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot14 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211018).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211018", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211018", "story_v_out_410211.awb")

						uv0:RecordAudio("410211018", slot22)
						uv0:RecordAudio("410211018", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211018", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211018", "story_v_out_410211.awb")
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
	Play410211019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211019
		slot1.duration_ = 12.5

		if ({
			ja = 12.5,
			CriLanguages = 8,
			zh = 8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST64a == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST64a
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST64a" then
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

			slot7 = uv0.actors_["1061"].transform

			if 4 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1061 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 3

				uv0:CheckSpriteTmpPos("1061", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -490, 18)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1061 then
					slot16 = uv0.var_.actorSpriteComps1061
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot13 = 1
				slot16 = uv0.var_.actorSpriteComps1061
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot13 = uv0.actors_["10059"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos10059 = slot13.localPosition
				slot13.localScale = Vector3.New(1, 1, 1)
				slot19 = 7

				uv0:CheckSpriteTmpPos("10059", slot19)

				for slot19 = 0, slot13.childCount - 1 do
					if slot13:GetChild(slot19).name == "" or not string.find(slot20.name, "split") then
						slot20.gameObject:SetActive(true)
					else
						slot20.gameObject:SetActive(false)
					end
				end
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (uv0.time_ - slot14) / slot15)
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -2000, 18)
			end

			slot16 = uv0.actors_["1061"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.var_.moveOldPos1061 = slot16.localPosition
				slot16.localScale = Vector3.New(1, 1, 1)
				slot22 = 7

				uv0:CheckSpriteTmpPos("1061", slot22)

				for slot22 = 0, slot16.childCount - 1 do
					if slot16:GetChild(slot22).name == "" or not string.find(slot23.name, "split") then
						slot23.gameObject:SetActive(true)
					else
						slot23.gameObject:SetActive(false)
					end
				end
			end

			slot18 = 0.001

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot16.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot17) / slot18)
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 then
				slot16.localPosition = Vector3.New(0, -2000, 18)
			end

			if 2 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0.screenFilterGo_:SetActive(true)

				uv0.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
			end

			slot20 = 0.0166666666666667

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				uv0.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (uv0.time_ - slot19) / slot20)
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 then
				uv0.screenFilterEffect_.weight = 1
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot22 = 0.475

			if 4 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot23 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot23:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot23:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot26 = uv0:FormatText(uv0:GetWordFromCfg(410211019).content)
				uv0.text_.text = slot26

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot22 or slot22 * utf8.len(slot26) / slot27) > 0 and slot22 < slot29 then
					uv0.talkMaxDuration = slot29

					if uv0.duration_ < slot29 + slot21 + 0.3 then
						uv0.duration_ = slot29 + slot21
					end
				end

				uv0.text_.text = slot26
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211019", "story_v_out_410211.awb") / 1000 + slot21 then
						uv0.duration_ = slot30 + slot21
					end

					if slot25.prefab_name ~= "" and uv0.actors_[slot25.prefab_name] ~= nil then
						slot31 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot25.prefab_name].transform, "story_v_out_410211", "410211019", "story_v_out_410211.awb")

						uv0:RecordAudio("410211019", slot31)
						uv0:RecordAudio("410211019", slot31)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211019", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211019", "story_v_out_410211.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot22 = math.max(slot22, uv0.talkMaxDuration)

			if slot21 + 0.3 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
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
	Play410211020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211020
		slot1.duration_ = 8.6

		if ({
			ja = 6.166,
			CriLanguages = 8.6,
			zh = 8.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410211020).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (40 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211020", "story_v_out_410211.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_410211", "410211020", "story_v_out_410211.awb")

						uv0:RecordAudio("410211020", slot10)
						uv0:RecordAudio("410211020", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211020", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211020", "story_v_out_410211.awb")
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
	Play410211021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211021
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(410211021).content)
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
	Play410211022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211022
		slot1.duration_ = 9.866

		if ({
			ja = 8.8,
			CriLanguages = 9.866,
			zh = 9.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211022).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211022", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211022", "story_v_out_410211.awb")

						uv0:RecordAudio("410211022", slot16)
						uv0:RecordAudio("410211022", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211022", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211022", "story_v_out_410211.awb")
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
	Play410211023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211023
		slot1.duration_ = 12.033

		if ({
			ja = 12.033,
			CriLanguages = 11.533,
			zh = 11.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211023).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211023", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211023", "story_v_out_410211.awb")

						uv0:RecordAudio("410211023", slot16)
						uv0:RecordAudio("410211023", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211023", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211023", "story_v_out_410211.awb")
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
	Play410211024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211024
		slot1.duration_ = 4.933

		if ({
			ja = 4.933,
			CriLanguages = 3.666,
			zh = 3.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot5 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[610].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10055_b")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(410211024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211024", "story_v_out_410211.awb") / 1000 + slot4 then
						uv0.duration_ = slot12 + slot4
					end

					if slot7.prefab_name ~= "" and uv0.actors_[slot7.prefab_name] ~= nil then
						slot13 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot7.prefab_name].transform, "story_v_out_410211", "410211024", "story_v_out_410211.awb")

						uv0:RecordAudio("410211024", slot13)
						uv0:RecordAudio("410211024", slot13)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211024", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211024", "story_v_out_410211.awb")
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
	Play410211025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211025
		slot1.duration_ = 11.3

		if ({
			ja = 11.3,
			CriLanguages = 10.7,
			zh = 10.7
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.225

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211025).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (49 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211025", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211025", "story_v_out_410211.awb")

						uv0:RecordAudio("410211025", slot16)
						uv0:RecordAudio("410211025", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211025", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211025", "story_v_out_410211.awb")
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
	Play410211026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211026
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(410211026).content)
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
	Play410211027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211027
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.475

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211027).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (59 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410211028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211028
		slot1.duration_ = 16.9

		if ({
			ja = 16.9,
			CriLanguages = 12.233,
			zh = 12.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.35

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211028).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (54 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211028", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211028", "story_v_out_410211.awb")

						uv0:RecordAudio("410211028", slot16)
						uv0:RecordAudio("410211028", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211028", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211028", "story_v_out_410211.awb")
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
	Play410211029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211029
		slot1.duration_ = 12.066

		if ({
			ja = 12.066,
			CriLanguages = 11.3,
			zh = 11.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211029).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (55 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211029", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211029", "story_v_out_410211.awb")

						uv0:RecordAudio("410211029", slot16)
						uv0:RecordAudio("410211029", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211029", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211029", "story_v_out_410211.awb")
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
	Play410211030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211030
		slot1.duration_ = 6.066

		if ({
			ja = 6.066,
			CriLanguages = 3.7,
			zh = 3.7
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211030).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211030", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211030", "story_v_out_410211.awb")

						uv0:RecordAudio("410211030", slot16)
						uv0:RecordAudio("410211030", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211030", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211030", "story_v_out_410211.awb")
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
	Play410211031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211031
		slot1.duration_ = 8.633

		if ({
			ja = 8.633,
			CriLanguages = 8.366,
			zh = 8.366
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10063"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			slot2 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.moveOldPos10063 = slot2.localPosition
				slot2.localScale = Vector3.New(1, 1, 1)
				slot8 = 3

				uv0:CheckSpriteTmpPos("10063", slot8)

				for slot8 = 0, slot2.childCount - 1 do
					if slot2:GetChild(slot8).name == "" or not string.find(slot9.name, "split") then
						slot9.gameObject:SetActive(true)
					else
						slot9.gameObject:SetActive(false)
					end
				end
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -535, -105), (uv0.time_ - slot3) / slot4)
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -535, -105)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot7 = 0.034

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.actorSpriteComps10063 then
					slot11 = uv0.var_.actorSpriteComps10063
					slot13 = slot11

					for slot12, slot13 in pairs(slot11.ToTable(slot13)) do
						if slot13 then
							slot14 = Mathf.Lerp(slot13.color.r, 1, slot8)
							slot13.color = Color.New(slot14, slot14, slot14)
						end
					end
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot8 = 1
				slot11 = uv0.var_.actorSpriteComps10063
				slot13 = slot11

				for slot12, slot13 in pairs(slot11.ToTable(slot13)) do
					if slot13 then
						slot13.color = Color.New(slot8, slot8, slot8)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			slot8 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1061 = slot8.localPosition
				slot8.localScale = Vector3.New(1, 1, 1)
				slot14 = 7

				uv0:CheckSpriteTmpPos("1061", slot14)

				for slot14 = 0, slot8.childCount - 1 do
					if slot8:GetChild(slot14).name == "" or not string.find(slot15.name, "split") then
						slot15.gameObject:SetActive(true)
					else
						slot15.gameObject:SetActive(false)
					end
				end
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, -2000, 18)
			end

			slot12 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(410211031).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot12 or slot12 * utf8.len(slot15) / slot16) > 0 and slot12 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot11 then
						uv0.duration_ = slot18 + slot11
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211031", "story_v_out_410211.awb") / 1000 + slot11 then
						uv0.duration_ = slot19 + slot11
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_410211", "410211031", "story_v_out_410211.awb")

						uv0:RecordAudio("410211031", slot20)
						uv0:RecordAudio("410211031", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211031", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211031", "story_v_out_410211.awb")
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
	Play410211032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211032
		slot1.duration_ = 2.266

		if ({
			ja = 2.266,
			CriLanguages = 1.2,
			zh = 1.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot7 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos10063 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 7

				uv0:CheckSpriteTmpPos("10063", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0, -2000, -105)
			end

			slot11 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211032).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211032", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211032", "story_v_out_410211.awb")

						uv0:RecordAudio("410211032", slot19)
						uv0:RecordAudio("410211032", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211032", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211032", "story_v_out_410211.awb")
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
	Play410211033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211033
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(410211033).content)
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
	Play410211034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211034
		slot1.duration_ = 12.233

		if ({
			ja = 12.233,
			CriLanguages = 9.933,
			zh = 9.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.975

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211034).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211034", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211034", "story_v_out_410211.awb")

						uv0:RecordAudio("410211034", slot16)
						uv0:RecordAudio("410211034", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211034", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211034", "story_v_out_410211.awb")
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
	Play410211035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211035
		slot1.duration_ = 19.6

		if ({
			ja = 19.6,
			CriLanguages = 12.6,
			zh = 12.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211035).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211035", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211035", "story_v_out_410211.awb")

						uv0:RecordAudio("410211035", slot16)
						uv0:RecordAudio("410211035", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211035", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211035", "story_v_out_410211.awb")
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
	Play410211036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211036
		slot1.duration_ = 6.666

		if ({
			ja = 6.466,
			CriLanguages = 6.666,
			zh = 6.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.L04i == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.L04i
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "L04i" then
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

			slot7 = uv0.actors_["1061"].transform

			if 4 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos1061 = slot7.localPosition
				slot7.localScale = Vector3.New(1, 1, 1)
				slot13 = 2

				uv0:CheckSpriteTmpPos("1061", slot13)

				for slot13 = 0, slot7.childCount - 1 do
					if slot7:GetChild(slot13).name == "" or not string.find(slot14.name, "split") then
						slot14.gameObject:SetActive(true)
					else
						slot14.gameObject:SetActive(false)
					end
				end
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-390, -490, 18)
			end

			slot10 = uv0.actors_["10059"].transform

			if 4 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPos10059 = slot10.localPosition
				slot10.localScale = Vector3.New(1, 1, 1)
				slot16 = 4

				uv0:CheckSpriteTmpPos("10059", slot16)

				for slot16 = 0, slot10.childCount - 1 do
					if slot10:GetChild(slot16).name == "" or not string.find(slot17.name, "split") then
						slot17.gameObject:SetActive(true)
					else
						slot17.gameObject:SetActive(false)
					end
				end
			end

			slot12 = 0.001

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot11) / slot12)
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(390, -530, 35)
			end

			slot13 = uv0.actors_["10063"].transform

			if 4 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0.var_.moveOldPos10063 = slot13.localPosition
				slot13.localScale = Vector3.New(1, 1, 1)
				slot19 = 7

				uv0:CheckSpriteTmpPos("10063", slot19)

				for slot19 = 0, slot13.childCount - 1 do
					if slot13:GetChild(slot19).name == "" or not string.find(slot20.name, "split") then
						slot20.gameObject:SetActive(true)
					else
						slot20.gameObject:SetActive(false)
					end
				end
			end

			slot15 = 0.001

			if slot14 <= uv0.time_ and uv0.time_ < slot14 + slot15 then
				slot13.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (uv0.time_ - slot14) / slot15)
			end

			if uv0.time_ >= slot14 + slot15 and uv0.time_ < slot14 + slot15 + slot0 then
				slot13.localPosition = Vector3.New(0, -2000, -105)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot17 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot18 = 0.034

			if slot17 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
				slot19 = (uv0.time_ - slot17) / slot18

				if uv0.var_.actorSpriteComps1061 then
					slot22 = uv0.var_.actorSpriteComps1061
					slot24 = slot22

					for slot23, slot24 in pairs(slot22.ToTable(slot24)) do
						if slot24 then
							slot25 = Mathf.Lerp(slot24.color.r, 1, slot19)
							slot24.color = Color.New(slot25, slot25, slot25)
						end
					end
				end
			end

			if uv0.time_ >= slot17 + slot18 and uv0.time_ < slot17 + slot18 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot19 = 1
				slot22 = uv0.var_.actorSpriteComps1061
				slot24 = slot22

				for slot23, slot24 in pairs(slot22.ToTable(slot24)) do
					if slot24 then
						slot24.color = Color.New(slot19, slot19, slot19)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 4 < uv0.time_ and uv0.time_ <= slot20 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot21 = 0.034

			if slot20 <= uv0.time_ and uv0.time_ < slot20 + slot21 then
				slot22 = (uv0.time_ - slot20) / slot21

				if uv0.var_.actorSpriteComps10059 then
					slot25 = uv0.var_.actorSpriteComps10059
					slot27 = slot25

					for slot26, slot27 in pairs(slot25.ToTable(slot27)) do
						if slot27 then
							slot28 = Mathf.Lerp(slot27.color.r, 0.5, slot22)
							slot27.color = Color.New(slot28, slot28, slot28)
						end
					end
				end
			end

			if uv0.time_ >= slot20 + slot21 and uv0.time_ < slot20 + slot21 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot22 = 0.5
				slot25 = uv0.var_.actorSpriteComps10059
				slot27 = slot25

				for slot26, slot27 in pairs(slot25.ToTable(slot27)) do
					if slot27 then
						slot27.color = Color.New(slot22, slot22, slot22)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 4 < uv0.time_ and uv0.time_ <= slot23 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot24 = 0.034

			if slot23 <= uv0.time_ and uv0.time_ < slot23 + slot24 then
				slot25 = (uv0.time_ - slot23) / slot24

				if uv0.var_.actorSpriteComps10063 then
					slot28 = uv0.var_.actorSpriteComps10063
					slot30 = slot28

					for slot29, slot30 in pairs(slot28.ToTable(slot30)) do
						if slot30 then
							slot31 = Mathf.Lerp(slot30.color.r, 0.5, slot25)
							slot30.color = Color.New(slot31, slot31, slot31)
						end
					end
				end
			end

			if uv0.time_ >= slot23 + slot24 and uv0.time_ < slot23 + slot24 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot25 = 0.5
				slot28 = uv0.var_.actorSpriteComps10063
				slot30 = slot28

				for slot29, slot30 in pairs(slot28.ToTable(slot30)) do
					if slot30 then
						slot30.color = Color.New(slot25, slot25, slot25)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			slot25 = uv0.actors_["1061"].transform

			if 2 < uv0.time_ and uv0.time_ <= slot26 + slot0 then
				uv0.var_.moveOldPos1061 = slot25.localPosition
				slot25.localScale = Vector3.New(1, 1, 1)
				slot31 = 7

				uv0:CheckSpriteTmpPos("1061", slot31)

				for slot31 = 0, slot25.childCount - 1 do
					if slot25:GetChild(slot31).name == "" or not string.find(slot32.name, "split") then
						slot32.gameObject:SetActive(true)
					else
						slot32.gameObject:SetActive(false)
					end
				end
			end

			slot27 = 0.001

			if slot26 <= uv0.time_ and uv0.time_ < slot26 + slot27 then
				slot25.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot26) / slot27)
			end

			if uv0.time_ >= slot26 + slot27 and uv0.time_ < slot26 + slot27 + slot0 then
				slot25.localPosition = Vector3.New(0, -2000, 18)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot28 + slot0 then
				uv0.screenFilterGo_:SetActive(false)
			end

			slot29 = 0.0166666666666667

			if slot28 <= uv0.time_ and uv0.time_ < slot28 + slot29 then
				uv0.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (uv0.time_ - slot28) / slot29)
			end

			if uv0.time_ >= slot28 + slot29 and uv0.time_ < slot28 + slot29 + slot0 then
				uv0.screenFilterEffect_.weight = 0
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot31 = 0.275

			if 4 < uv0.time_ and uv0.time_ <= slot30 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot32 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot32:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot32:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot35 = uv0:FormatText(uv0:GetWordFromCfg(410211036).content)
				uv0.text_.text = slot35

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot31 or slot31 * utf8.len(slot35) / slot36) > 0 and slot31 < slot38 then
					uv0.talkMaxDuration = slot38

					if uv0.duration_ < slot38 + slot30 + 0.3 then
						uv0.duration_ = slot38 + slot30
					end
				end

				uv0.text_.text = slot35
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211036", "story_v_out_410211.awb") / 1000 + slot30 then
						uv0.duration_ = slot39 + slot30
					end

					if slot34.prefab_name ~= "" and uv0.actors_[slot34.prefab_name] ~= nil then
						slot40 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot34.prefab_name].transform, "story_v_out_410211", "410211036", "story_v_out_410211.awb")

						uv0:RecordAudio("410211036", slot40)
						uv0:RecordAudio("410211036", slot40)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211036", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211036", "story_v_out_410211.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot31 = math.max(slot31, uv0.talkMaxDuration)

			if slot30 + 0.3 <= uv0.time_ and uv0.time_ < slot30 + slot31 then
				uv0.typewritter.percent = (uv0.time_ - slot30) / slot31

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot30 + slot31 and uv0.time_ < slot30 + slot31 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play410211037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211037
		slot1.duration_ = 2.833

		if ({
			ja = 2.833,
			CriLanguages = 1.833,
			zh = 1.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211037).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211037", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211037", "story_v_out_410211.awb")

						uv0:RecordAudio("410211037", slot16)
						uv0:RecordAudio("410211037", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211037", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211037", "story_v_out_410211.awb")
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
	Play410211038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211038
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(410211038).content)
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
	Play410211039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211039
		slot1.duration_ = 3.166

		if ({
			ja = 3.166,
			CriLanguages = 1.633,
			zh = 1.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211039).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211039", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211039", "story_v_out_410211.awb")

						uv0:RecordAudio("410211039", slot16)
						uv0:RecordAudio("410211039", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211039", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211039", "story_v_out_410211.awb")
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
	Play410211040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211040
		slot1.duration_ = 12.966

		if ({
			ja = 12.966,
			CriLanguages = 11.266,
			zh = 11.266
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 1.35

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211040).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (54 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211040", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211040", "story_v_out_410211.awb")

						uv0:RecordAudio("410211040", slot19)
						uv0:RecordAudio("410211040", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211040", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211040", "story_v_out_410211.awb")
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
	Play410211041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211041
		slot1.duration_ = 4.9

		if ({
			ja = 4.433,
			CriLanguages = 4.9,
			zh = 4.9
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211041).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (17 <= 0 and slot11 or slot11 * utf8.len(slot14) / slot15) > 0 and slot11 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot10 then
						uv0.duration_ = slot17 + slot10
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211041", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211041", "story_v_out_410211.awb")

						uv0:RecordAudio("410211041", slot19)
						uv0:RecordAudio("410211041", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211041", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211041", "story_v_out_410211.awb")
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
	Play410211042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211042
		slot1.duration_ = 3.833

		if ({
			ja = 3.833,
			CriLanguages = 2.766,
			zh = 2.766
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211042).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211042", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211042", "story_v_out_410211.awb")

						uv0:RecordAudio("410211042", slot19)
						uv0:RecordAudio("410211042", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211042", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211042", "story_v_out_410211.awb")
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
	Play410211043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211043
		slot1.duration_ = 4.733

		if ({
			ja = 4.733,
			CriLanguages = 4.3,
			zh = 4.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211044(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211043).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211043", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211043", "story_v_out_410211.awb")

						uv0:RecordAudio("410211043", slot19)
						uv0:RecordAudio("410211043", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211043", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211043", "story_v_out_410211.awb")
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
	Play410211044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211044
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 18)
			end

			slot4 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1061 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 7

				uv0:CheckSpriteTmpPos("1061", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1061 then
					slot16 = uv0.var_.actorSpriteComps1061
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps1061
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot14 = 1.125

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(410211044).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (45 <= 0 and slot14 or slot14 * utf8.len(slot16) / slot17) > 0 and slot14 < slot19 then
					uv0.talkMaxDuration = slot19

					if uv0.duration_ < slot19 + slot13 then
						uv0.duration_ = slot19 + slot13
					end
				end

				uv0.text_.text = slot16
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
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
	Play410211045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211045
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.9

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211045).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410211046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211046
		slot1.duration_ = 1.633

		if ({
			ja = 1.4,
			CriLanguages = 1.633,
			zh = 1.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211047(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10063 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("10063", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(-390, -535, -105), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -535, -105)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10063 then
					slot13 = uv0.var_.actorSpriteComps10063
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps10063
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 0.1

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211046).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211046", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211046", "story_v_out_410211.awb")

						uv0:RecordAudio("410211046", slot22)
						uv0:RecordAudio("410211046", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211046", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211046", "story_v_out_410211.awb")
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
	Play410211047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211047
		slot1.duration_ = 4.266

		if ({
			ja = 4.266,
			CriLanguages = 2.533,
			zh = 2.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211048(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10063 then
					slot7 = uv0.var_.actorSpriteComps10063
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps10063
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211047).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211047", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211047", "story_v_out_410211.awb")

						uv0:RecordAudio("410211047", slot16)
						uv0:RecordAudio("410211047", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211047", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211047", "story_v_out_410211.awb")
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
	Play410211048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211048
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10063 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10063", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -2000, -105), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, -105)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 7

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 35)
			end

			slot8 = 1.15

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211048).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410211049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211049
		slot1.duration_ = 4.666

		if ({
			ja = 2.6,
			CriLanguages = 4.666,
			zh = 4.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 4

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(390, -530, 35)
			end

			slot4 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1061 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 2

				uv0:CheckSpriteTmpPos("1061", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1061 then
					slot16 = uv0.var_.actorSpriteComps1061
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps1061
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot14 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211049).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211049", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211049", "story_v_out_410211.awb")

						uv0:RecordAudio("410211049", slot22)
						uv0:RecordAudio("410211049", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211049", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211049", "story_v_out_410211.awb")
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
	Play410211050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211050
		slot1.duration_ = 4.533

		if ({
			ja = 4.533,
			CriLanguages = 2.366,
			zh = 2.366
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot11 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211050).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211050", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211050", "story_v_out_410211.awb")

						uv0:RecordAudio("410211050", slot19)
						uv0:RecordAudio("410211050", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211050", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211050", "story_v_out_410211.awb")
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
	Play410211051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211051
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 35)
			end

			slot4 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1061 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 7

				uv0:CheckSpriteTmpPos("1061", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 18)
			end

			slot8 = 1.5

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211051).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (60 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410211052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211052
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211053(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.675

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211052).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (67 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play410211053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211053
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[604].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_3046")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(410211053).content)
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
	Play410211054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211054
		slot1.duration_ = 1.166

		if ({
			ja = 1.133,
			CriLanguages = 1.166,
			zh = 1.166
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -530, 35), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211054).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211054", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211054", "story_v_out_410211.awb")

						uv0:RecordAudio("410211054", slot16)
						uv0:RecordAudio("410211054", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211054", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211054", "story_v_out_410211.awb")
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
	Play410211055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211055
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10059 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10059", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211055).content)
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
	Play410211056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211056
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211057(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211056).content)
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
	Play410211057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211057
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211058(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211057).content)
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
	Play410211058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211058
		slot1.duration_ = 6.1

		if ({
			ja = 6.1,
			CriLanguages = 3.466,
			zh = 3.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10063 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 3

				uv0:CheckSpriteTmpPos("10063", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10063 then
					slot10 = uv0.var_.actorSpriteComps10063
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10063
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			slot8 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[591].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211058).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211058", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211058", "story_v_out_410211.awb")

						uv0:RecordAudio("410211058", slot16)
						uv0:RecordAudio("410211058", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211058", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211058", "story_v_out_410211.awb")
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
	Play410211059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211059
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["10063"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10063 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("10063", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10063, Vector3.New(0, -2000, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10063 == nil then
				uv0.var_.actorSpriteComps10063 = uv0.actors_["10063"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10063 then
					slot10 = uv0.var_.actorSpriteComps10063
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10063 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10063
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10063 = nil
			end

			slot8 = 1.7

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211059).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (68 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play410211060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211060
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211061(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211060).content)
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
	Play410211061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211061
		slot1.duration_ = 6.866

		if ({
			ja = 6.866,
			CriLanguages = 3.5,
			zh = 3.5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 4

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(390, -530, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(390, -530, 35)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1061 then
					slot13 = uv0.var_.actorSpriteComps1061
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot10 = 1
				slot13 = uv0.var_.actorSpriteComps1061
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.034

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps10059 then
					slot16 = uv0.var_.actorSpriteComps10059
					slot18 = slot16

					for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 0.5, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot13 = 0.5
				slot16 = uv0.var_.actorSpriteComps10059
				slot18 = slot16

				for slot17, slot18 in pairs(slot16.ToTable(slot18)) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot14 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(410211061).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211061", "story_v_out_410211.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_410211", "410211061", "story_v_out_410211.awb")

						uv0:RecordAudio("410211061", slot22)
						uv0:RecordAudio("410211061", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211061", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211061", "story_v_out_410211.awb")
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
	Play410211062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211062
		slot1.duration_ = 12.333

		if ({
			ja = 12.333,
			CriLanguages = 6.466,
			zh = 6.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps10059 then
					slot7 = uv0.var_.actorSpriteComps10059
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps10059
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211062).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211062", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211062", "story_v_out_410211.awb")

						uv0:RecordAudio("410211062", slot16)
						uv0:RecordAudio("410211062", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211062", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211062", "story_v_out_410211.awb")
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
	Play410211063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211063
		slot1.duration_ = 3.366

		if ({
			ja = 3.366,
			CriLanguages = 1.4,
			zh = 1.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211063).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211063", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211063", "story_v_out_410211.awb")

						uv0:RecordAudio("410211063", slot19)
						uv0:RecordAudio("410211063", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211063", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211063", "story_v_out_410211.awb")
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
	Play410211064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211064
		slot1.duration_ = 4.633

		if ({
			ja = 4.266,
			CriLanguages = 4.633,
			zh = 4.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211064).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211064", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211064", "story_v_out_410211.awb")

						uv0:RecordAudio("410211064", slot16)
						uv0:RecordAudio("410211064", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211064", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211064", "story_v_out_410211.awb")
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
	Play410211065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211065
		slot1.duration_ = 9.4

		if ({
			ja = 8.9,
			CriLanguages = 9.4,
			zh = 9.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211066(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211065).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211065", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211065", "story_v_out_410211.awb")

						uv0:RecordAudio("410211065", slot16)
						uv0:RecordAudio("410211065", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211065", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211065", "story_v_out_410211.awb")
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
	Play410211066 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211066
		slot1.duration_ = 6

		if ({
			ja = 6,
			CriLanguages = 1.466,
			zh = 1.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211067(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211066).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211066", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211066", "story_v_out_410211.awb")

						uv0:RecordAudio("410211066", slot16)
						uv0:RecordAudio("410211066", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211066", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211066", "story_v_out_410211.awb")
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
	Play410211067 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211067
		slot1.duration_ = 3.2

		if ({
			ja = 3.2,
			CriLanguages = 1.4,
			zh = 1.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211068(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 1
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 0.5
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211067).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211067", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211067", "story_v_out_410211.awb")

						uv0:RecordAudio("410211067", slot16)
						uv0:RecordAudio("410211067", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211067", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211067", "story_v_out_410211.awb")
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
	Play410211068 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211068
		slot1.duration_ = 13.1

		if ({
			ja = 13.1,
			CriLanguages = 9.066,
			zh = 9.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211069(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211068).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211068", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211068", "story_v_out_410211.awb")

						uv0:RecordAudio("410211068", slot16)
						uv0:RecordAudio("410211068", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211068", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211068", "story_v_out_410211.awb")
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
	Play410211069 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211069
		slot1.duration_ = 8.1

		if ({
			ja = 8.1,
			CriLanguages = 5.066,
			zh = 5.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211070(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211069).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211069", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211069", "story_v_out_410211.awb")

						uv0:RecordAudio("410211069", slot16)
						uv0:RecordAudio("410211069", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211069", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211069", "story_v_out_410211.awb")
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
	Play410211070 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211070
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211071(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot5 = 1.325

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(410211070).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (53 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play410211071 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211071
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211072(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(410211071).content)
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
	Play410211072 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211072
		slot1.duration_ = 1.5

		if ({
			ja = 1.5,
			CriLanguages = 1.133,
			zh = 1.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211073(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			slot8 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211072).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211072", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211072", "story_v_out_410211.awb")

						uv0:RecordAudio("410211072", slot16)
						uv0:RecordAudio("410211072", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211072", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211072", "story_v_out_410211.awb")
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
	Play410211073 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211073
		slot1.duration_ = 9.166

		if ({
			ja = 9.166,
			CriLanguages = 6.566,
			zh = 6.566
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211074(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot3 = 0.034

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.actorSpriteComps1061 then
					slot7 = uv0.var_.actorSpriteComps1061
					slot9 = slot7

					for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot4 = 0.5
				slot7 = uv0.var_.actorSpriteComps1061
				slot9 = slot7

				for slot8, slot9 in pairs(slot7.ToTable(slot9)) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps10059 then
					slot10 = uv0.var_.actorSpriteComps10059
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps10059
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot8 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[596].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(410211073).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211073", "story_v_out_410211.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_410211", "410211073", "story_v_out_410211.awb")

						uv0:RecordAudio("410211073", slot16)
						uv0:RecordAudio("410211073", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211073", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211073", "story_v_out_410211.awb")
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
	Play410211074 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211074
		slot1.duration_ = 2.833

		if ({
			ja = 2.833,
			CriLanguages = 2.466,
			zh = 2.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play410211075(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 2

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(-390, -490, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-390, -490, 18)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.actorSpriteComps1061 == nil then
				uv0.var_.actorSpriteComps1061 = uv0.actors_["1061"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot6 = 0.034

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.actorSpriteComps1061 then
					slot10 = uv0.var_.actorSpriteComps1061
					slot12 = slot10

					for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1061 then
				slot7 = 1
				slot10 = uv0.var_.actorSpriteComps1061
				slot12 = slot10

				for slot11, slot12 in pairs(slot10.ToTable(slot12)) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1061 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps10059 == nil then
				uv0.var_.actorSpriteComps10059 = uv0.actors_["10059"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.034

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps10059 then
					slot13 = uv0.var_.actorSpriteComps10059
					slot15 = slot13

					for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps10059 then
				slot10 = 0.5
				slot13 = uv0.var_.actorSpriteComps10059
				slot15 = slot13

				for slot14, slot15 in pairs(slot13.ToTable(slot15)) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps10059 = nil
			end

			slot11 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[612].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(410211074).content)
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

				if manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_410211", "410211074", "story_v_out_410211.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_410211", "410211074", "story_v_out_410211.awb")

						uv0:RecordAudio("410211074", slot19)
						uv0:RecordAudio("410211074", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_410211", "410211074", "story_v_out_410211.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_410211", "410211074", "story_v_out_410211.awb")
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
	Play410211075 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 410211075
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
			slot1 = uv0.actors_["1061"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1061 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)
				slot7 = 7

				uv0:CheckSpriteTmpPos("1061", slot7)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1061, Vector3.New(0, -2000, 18), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -2000, 18)
			end

			slot4 = uv0.actors_["10059"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos10059 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)
				slot10 = 7

				uv0:CheckSpriteTmpPos("10059", slot10)

				for slot10 = 0, slot4.childCount - 1 do
					if slot4:GetChild(slot10).name == "" or not string.find(slot11.name, "split") then
						slot11.gameObject:SetActive(true)
					else
						slot11.gameObject:SetActive(false)
					end
				end
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10059, Vector3.New(0, -2000, 35), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(0, -2000, 35)
			end

			slot8 = 0.975

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(410211075).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST66",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST64a",
		"Assets/UIResources/UI_AB/TextureConfig/Background/L04i"
	},
	voices = {
		"story_v_out_410211.awb"
	}
}
