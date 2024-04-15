return {
	Play117062001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.A02d == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.A02d
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "A02d" then
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
				uv0:AudioAction("play", "music", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2", "bgm_story_v1_battleground_2.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.725

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(117062001).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play117062002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062002
		slot1.duration_ = 5.066

		if ({
			zh = 2.8,
			ja = 5.066
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1132"] == nil then
				slot2 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot1), uv0.canvasGo_.transform)

				slot2.transform:SetSiblingIndex(1)

				slot2.name = slot1
				slot2.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot4.alpha
					uv0.var_.characterEffect1132 = slot4
				end

				uv0.var_.alphaOldValue1132 = 0
			end

			slot4 = 0.333333333333333

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 1, (uv0.time_ - slot3) / slot4)
				end
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 1
			end

			if uv0.actors_["1033"] == nil then
				slot6 = Object.Instantiate(Asset.Load("UI/StoryExpression/" .. slot5), uv0.canvasGo_.transform)

				slot6.transform:SetSiblingIndex(1)

				slot6.name = slot5
				slot6.transform.localPosition = Vector3.New(0, 100000, 0)
				uv0.actors_[slot5] = slot6
			end

			slot6 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos1033 = slot6.localPosition
				slot6.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033", 4)

				for slot12 = 0, slot6.childCount - 1 do
					if slot6:GetChild(slot12).name == "split_6" or not string.find(slot13.name, "split") then
						slot13.gameObject:SetActive(true)
					else
						slot13.gameObject:SetActive(false)
					end
				end
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1033, Vector3.New(390, -420, 0), (uv0.time_ - slot7) / slot8)
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(390, -420, 0)
			end

			slot9 = uv0.actors_["1132"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1132 = slot9.localPosition
				slot9.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132", 2)

				for slot15 = 0, slot9.childCount - 1 do
					if slot9:GetChild(slot15).name == "split_6" or not string.find(slot16.name, "split") then
						slot16.gameObject:SetActive(true)
					else
						slot16.gameObject:SetActive(false)
					end
				end
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (uv0.time_ - slot10) / slot11)
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(-390, -413, -185)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot14 = 0.2

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot15 = (uv0.time_ - slot13) / slot14

				if uv0.var_.actorSpriteComps1132 then
					for slot19, slot20 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
						if slot20 then
							slot21 = Mathf.Lerp(slot20.color.r, 1, slot15)
							slot20.color = Color.New(slot21, slot21, slot21)
						end
					end
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot15 = 1

				for slot19, slot20 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
					if slot20 then
						slot20.color = Color.New(slot15, slot15, slot15)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot17 = 0.2

			if slot16 <= uv0.time_ and uv0.time_ < slot16 + slot17 then
				slot18 = (uv0.time_ - slot16) / slot17

				if uv0.var_.actorSpriteComps1033 then
					for slot22, slot23 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot23 then
							slot24 = Mathf.Lerp(slot23.color.r, 0.5, slot18)
							slot23.color = Color.New(slot24, slot24, slot24)
						end
					end
				end
			end

			if uv0.time_ >= slot16 + slot17 and uv0.time_ < slot16 + slot17 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot18 = 0.5

				for slot22, slot23 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
					if slot23 then
						slot23.color = Color.New(slot18, slot18, slot18)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				if uv0.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1033 = slot20.alpha
					uv0.var_.characterEffect1033 = slot20
				end

				uv0.var_.alphaOldValue1033 = 0
			end

			slot20 = 0.333333333333333

			if slot19 <= uv0.time_ and uv0.time_ < slot19 + slot20 then
				if uv0.var_.characterEffect1033 then
					uv0.var_.characterEffect1033.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1033, 1, (uv0.time_ - slot19) / slot20)
				end
			end

			if uv0.time_ >= slot19 + slot20 and uv0.time_ < slot19 + slot20 + slot0 and uv0.var_.characterEffect1033 then
				uv0.var_.characterEffect1033.alpha = 1
			end

			slot22 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
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

				slot25 = uv0:FormatText(uv0:GetWordFromCfg(117062002).content)
				uv0.text_.text = slot25

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot22 or slot22 * utf8.len(slot25) / slot26) > 0 and slot22 < slot28 then
					uv0.talkMaxDuration = slot28

					if uv0.duration_ < slot28 + slot21 then
						uv0.duration_ = slot28 + slot21
					end
				end

				uv0.text_.text = slot25
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062002", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062002", "story_v_out_117062.awb") / 1000 + slot21 then
						uv0.duration_ = slot29 + slot21
					end

					if slot24.prefab_name ~= "" and uv0.actors_[slot24.prefab_name] ~= nil then
						slot30 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot24.prefab_name].transform, "story_v_out_117062", "117062002", "story_v_out_117062.awb")

						uv0:RecordAudio("117062002", slot30)
						uv0:RecordAudio("117062002", slot30)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062002", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062002", "story_v_out_117062.awb")
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
	Play117062003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062003
		slot1.duration_ = 5.866

		if ({
			zh = 3.7,
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
				uv0:Play117062004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033", 4)

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

			slot4 = uv0.actors_["1132"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.var_.moveOldPos1132 = slot4.localPosition
				slot4.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132", 2)

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
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132, Vector3.New(-390, -413, -185), (uv0.time_ - slot5) / slot6)
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 then
				slot4.localPosition = Vector3.New(-390, -413, -185)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1132 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 0.5, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot10 = 0.5

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.actorSpriteComps1033 == nil then
				uv0.var_.actorSpriteComps1033 = uv0.actors_["1033"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.actorSpriteComps1033 then
					for slot17, slot18 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot18 then
							slot19 = Mathf.Lerp(slot18.color.r, 1, slot13)
							slot18.color = Color.New(slot19, slot19, slot19)
						end
					end
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot13 = 1

				for slot17, slot18 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
					if slot18 then
						slot18.color = Color.New(slot13, slot13, slot13)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot14 = 0.5

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

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(117062003).content)
				uv0.text_.text = slot17

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot14 or slot14 * utf8.len(slot17) / slot18) > 0 and slot14 < slot20 then
					uv0.talkMaxDuration = slot20

					if uv0.duration_ < slot20 + slot13 then
						uv0.duration_ = slot20 + slot13
					end
				end

				uv0.text_.text = slot17
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062003", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062003", "story_v_out_117062.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117062", "117062003", "story_v_out_117062.awb")

						uv0:RecordAudio("117062003", slot22)
						uv0:RecordAudio("117062003", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062003", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062003", "story_v_out_117062.awb")
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
	Play117062004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062004
		slot1.duration_ = 5.933

		if ({
			zh = 3.4,
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
				uv0:Play117062005(uv1)
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
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 1, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 1

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
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
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 0.5, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 0.5

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 0.5

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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117062004).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062004", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062004", "story_v_out_117062.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117062", "117062004", "story_v_out_117062.awb")

						uv0:RecordAudio("117062004", slot16)
						uv0:RecordAudio("117062004", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062004", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062004", "story_v_out_117062.awb")
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
	Play117062005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062005
		slot1.duration_ = 15

		if ({
			zh = 11.433,
			ja = 15
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062006(uv1)
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
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
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
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
					if slot12 then
						slot12.color = Color.New(slot7, slot7, slot7)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot8 = 1.425

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

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117062005).content)
				uv0.text_.text = slot11

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (57 <= 0 and slot8 or slot8 * utf8.len(slot11) / slot12) > 0 and slot8 < slot14 then
					uv0.talkMaxDuration = slot14

					if uv0.duration_ < slot14 + slot7 then
						uv0.duration_ = slot14 + slot7
					end
				end

				uv0.text_.text = slot11
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062005", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062005", "story_v_out_117062.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117062", "117062005", "story_v_out_117062.awb")

						uv0:RecordAudio("117062005", slot16)
						uv0:RecordAudio("117062005", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062005", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062005", "story_v_out_117062.awb")
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
	Play117062006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062006
		slot1.duration_ = 11.566

		if ({
			zh = 4.233,
			ja = 11.566
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.5

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062006).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062006", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062006", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062006", "story_v_out_117062.awb")

						uv0:RecordAudio("117062006", slot10)
						uv0:RecordAudio("117062006", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062006", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062006", "story_v_out_117062.awb")
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
	Play117062007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062007
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062008(uv1)
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
					for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot9 then
							slot10 = Mathf.Lerp(slot9.color.r, 0.5, slot4)
							slot9.color = Color.New(slot10, slot10, slot10)
						end
					end
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot4 = 0.5

				for slot8, slot9 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
					if slot9 then
						slot9.color = Color.New(slot4, slot4, slot4)
					end
				end

				uv0.var_.actorSpriteComps1033 = nil
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk3", "")
			end

			slot7 = 0.875

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(117062007).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
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
	Play117062008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062008
		slot1.duration_ = 4.1

		if ({
			zh = 2.733,
			ja = 4.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1033"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1033 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1033", 4)

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
					for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
						if slot12 then
							slot13 = Mathf.Lerp(slot12.color.r, 1, slot7)
							slot12.color = Color.New(slot13, slot13, slot13)
						end
					end
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.actorSpriteComps1033 then
				slot7 = 1

				for slot11, slot12 in pairs(uv0.var_.actorSpriteComps1033:ToTable()) do
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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[236].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(117062008).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062008", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062008", "story_v_out_117062.awb") / 1000 + slot7 then
						uv0.duration_ = slot15 + slot7
					end

					if slot10.prefab_name ~= "" and uv0.actors_[slot10.prefab_name] ~= nil then
						slot16 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot10.prefab_name].transform, "story_v_out_117062", "117062008", "story_v_out_117062.awb")

						uv0:RecordAudio("117062008", slot16)
						uv0:RecordAudio("117062008", slot16)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062008", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062008", "story_v_out_117062.awb")
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
	Play117062009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062009
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				if uv0.actors_["1033"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1033 = slot3.alpha
					uv0.var_.characterEffect1033 = slot3
				end

				uv0.var_.alphaOldValue1033 = 1
			end

			slot3 = 0.333333333333333

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1033 then
					uv0.var_.characterEffect1033.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1033, 0, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1033 then
				uv0.var_.characterEffect1033.alpha = 0
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot6.alpha
					uv0.var_.characterEffect1132 = slot6
				end

				uv0.var_.alphaOldValue1132 = 1
			end

			slot6 = 0.333333333333333

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 0, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 0
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(117062009).content)
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
	Play117062010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062011(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(117062010).content)
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
	Play117062011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062011
		slot1.duration_ = 2.633

		if ({
			zh = 1.333,
			ja = 2.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot1 = uv0.actors_["1132"].transform

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1132 = slot1.localPosition
				slot1.localScale = Vector3.New(1, 1, 1)

				uv0:CheckSpriteTmpPos("1132", 3)

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
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1132, Vector3.New(0, -413, -185), (uv0.time_ - slot2) / slot3)
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -413, -185)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				if uv0.actors_["1132"]:GetComponentInChildren(typeof(CanvasGroup)) then
					uv0.var_.alphaOldValue1132 = slot6.alpha
					uv0.var_.characterEffect1132 = slot6
				end

				uv0.var_.alphaOldValue1132 = 0
			end

			slot6 = 0.333333333333333

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect1132 then
					uv0.var_.characterEffect1132.alpha = Mathf.Lerp(uv0.var_.alphaOldValue1132, 1, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1132 then
				uv0.var_.characterEffect1132.alpha = 1
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 and uv0.var_.actorSpriteComps1132 == nil then
				uv0.var_.actorSpriteComps1132 = uv0.actors_["1132"]:GetComponentsInChildren(typeof(Image), true)
			end

			slot9 = 0.2

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot10 = (uv0.time_ - slot8) / slot9

				if uv0.var_.actorSpriteComps1132 then
					for slot14, slot15 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
						if slot15 then
							slot16 = Mathf.Lerp(slot15.color.r, 1, slot10)
							slot15.color = Color.New(slot16, slot16, slot16)
						end
					end
				end
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 and uv0.var_.actorSpriteComps1132 then
				slot10 = 1

				for slot14, slot15 in pairs(uv0.var_.actorSpriteComps1132:ToTable()) do
					if slot15 then
						slot15.color = Color.New(slot10, slot10, slot10)
					end
				end

				uv0.var_.actorSpriteComps1132 = nil
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			slot12 = 0.333333333333333

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot14, slot15 = math.modf((uv0.time_ - slot11) / 0.066)
				slot10.localPosition = Vector3.New(slot15 * 0.13, slot15 * 0.13, slot15 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = uv0.var_.shakeOldPos
			end

			slot14 = 0.15

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

				slot17 = uv0:FormatText(uv0:GetWordFromCfg(117062011).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062011", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062011", "story_v_out_117062.awb") / 1000 + slot13 then
						uv0.duration_ = slot21 + slot13
					end

					if slot16.prefab_name ~= "" and uv0.actors_[slot16.prefab_name] ~= nil then
						slot22 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot16.prefab_name].transform, "story_v_out_117062", "117062011", "story_v_out_117062.awb")

						uv0:RecordAudio("117062011", slot22)
						uv0:RecordAudio("117062011", slot22)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062011", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062011", "story_v_out_117062.awb")
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
	Play117062012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062013(uv1)
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

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_change", "")
			end

			slot7 = 1.425

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

				slot9 = uv0:FormatText(uv0:GetWordFromCfg(117062012).content)
				uv0.text_.text = slot9

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (57 <= 0 and slot7 or slot7 * utf8.len(slot9) / slot10) > 0 and slot7 < slot12 then
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
	Play117062013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062013
		slot1.duration_ = 8.533333333332

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.TI0104 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.TI0104
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "TI0104" then
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

			if 2 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPosTI0104 = uv0.bgs_.TI0104.transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0104, Vector3.New(-1, 0, 3), (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(-1, 0, 3)
			end

			if 2.03333333333333 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.var_.moveOldPosTI0104 = uv0.bgs_.TI0104.transform.localPosition
			end

			slot12 = 6.5

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot10.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0104, Vector3.New(-1, 0, 4), (uv0.time_ - slot11) / slot12)
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 then
				slot10.localPosition = Vector3.New(-1, 0, 4)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 4.53333333333333 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot16 = 1.325

			if 2 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
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

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(117062013).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (53 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
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
	Play117062014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			slot3 = 2

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot5, slot6 = math.modf((uv0.time_ - slot2) / 0.066)
				slot1.localPosition = Vector3.New(slot6 * 0.13, slot6 * 0.13, slot6 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = uv0.var_.shakeOldPos
			end

			slot5 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_boss_hawk1", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot6 + 2 and uv0.time_ < slot6 + slot7 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot9 = 0.075

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[371].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(117062014).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (3 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 then
						uv0.duration_ = slot15 + slot8
					end
				end

				uv0.text_.text = slot12
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
	Play117062015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062015
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_17", "se_story_17_messenger02", "")
			end

			slot4 = 1

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

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(117062015).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (40 <= 0 and slot4 or slot4 * utf8.len(slot6) / slot7) > 0 and slot4 < slot9 then
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
	Play117062016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062016
		slot1.duration_ = 2.233

		if ({
			zh = 1.2,
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
				uv0:Play117062017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.1

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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_5")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062016).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062016", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062016", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062016", "story_v_out_117062.awb")

						uv0:RecordAudio("117062016", slot10)
						uv0:RecordAudio("117062016", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062016", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062016", "story_v_out_117062.awb")
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
	Play117062017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062017
		slot1.duration_ = 6.933

		if ({
			zh = 5.866,
			ja = 6.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062018(uv1)
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

			if 2 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.moveOldPosTI0104 = uv0.bgs_.TI0104.transform.localPosition
			end

			slot7 = 0.001

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot5.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0104, Vector3.New(0, 1, 9.5), (uv0.time_ - slot6) / slot7)
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = Vector3.New(0, 1, 9.5)
			end

			if 2.01666666666667 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPosTI0104 = uv0.bgs_.TI0104.transform.localPosition
			end

			slot10 = 2.566666

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPosTI0104, Vector3.New(0, 1, 10), (uv0.time_ - slot9) / slot10)
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(0, 1, 10)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 0.583332666666667 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot14 = 0.25

			if 3.5 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
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

				slot18 = uv0:FormatText(uv0:GetWordFromCfg(117062017).content)
				uv0.text_.text = slot18

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot14 or slot14 * utf8.len(slot18) / slot19) > 0 and slot14 < slot21 then
					uv0.talkMaxDuration = slot21

					if uv0.duration_ < slot21 + slot13 + 0.3 then
						uv0.duration_ = slot21 + slot13
					end
				end

				uv0.text_.text = slot18
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062017", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062017", "story_v_out_117062.awb") / 1000 + slot13 then
						uv0.duration_ = slot22 + slot13
					end

					if slot17.prefab_name ~= "" and uv0.actors_[slot17.prefab_name] ~= nil then
						slot23 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot17.prefab_name].transform, "story_v_out_117062", "117062017", "story_v_out_117062.awb")

						uv0:RecordAudio("117062017", slot23)
						uv0:RecordAudio("117062017", slot23)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062017", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062017", "story_v_out_117062.awb")
				end

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
	Play117062018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062018
		slot1.duration_ = 7.066

		if ({
			zh = 7.066,
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
				uv0:Play117062019(uv1)
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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_6")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062018).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062018", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062018", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062018", "story_v_out_117062.awb")

						uv0:RecordAudio("117062018", slot10)
						uv0:RecordAudio("117062018", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062018", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062018", "story_v_out_117062.awb")
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
	Play117062019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062019
		slot1.duration_ = 7.2

		if ({
			zh = 7.2,
			ja = 3.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_6")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062019).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (47 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062019", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062019", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062019", "story_v_out_117062.awb")

						uv0:RecordAudio("117062019", slot10)
						uv0:RecordAudio("117062019", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062019", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062019", "story_v_out_117062.awb")
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
	Play117062020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062020
		slot1.duration_ = 4.466

		if ({
			zh = 1.9,
			ja = 4.466
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062020).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062020", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062020", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062020", "story_v_out_117062.awb")

						uv0:RecordAudio("117062020", slot10)
						uv0:RecordAudio("117062020", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062020", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062020", "story_v_out_117062.awb")
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
	Play117062021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062021
		slot1.duration_ = 1.666

		if ({
			zh = 1.133,
			ja = 1.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.075

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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_4")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062021).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062021", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062021", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062021", "story_v_out_117062.awb")

						uv0:RecordAudio("117062021", slot10)
						uv0:RecordAudio("117062021", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062021", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062021", "story_v_out_117062.awb")
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
	Play117062022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062022
		slot1.duration_ = 4.833

		if ({
			zh = 4.833,
			ja = 4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062023(uv1)
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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1132_split_6")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062022).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062022", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062022", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062022", "story_v_out_117062.awb")

						uv0:RecordAudio("117062022", slot10)
						uv0:RecordAudio("117062022", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062022", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062022", "story_v_out_117062.awb")
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
	Play117062023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062023
		slot1.duration_ = 2.633

		if ({
			zh = 2.533,
			ja = 2.633
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play117062024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

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
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1033_split_4")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062023).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062023", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062023", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062023", "story_v_out_117062.awb")

						uv0:RecordAudio("117062023", slot10)
						uv0:RecordAudio("117062023", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062023", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062023", "story_v_out_117062.awb")
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
	Play117062024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 117062024
		slot1.duration_ = 4.9

		if ({
			zh = 3.1,
			ja = 4.9
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
			slot2 = 0.375

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(117062024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_117062", "117062024", "story_v_out_117062.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_117062", "117062024", "story_v_out_117062.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_117062", "117062024", "story_v_out_117062.awb")

						uv0:RecordAudio("117062024", slot10)
						uv0:RecordAudio("117062024", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_117062", "117062024", "story_v_out_117062.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_117062", "117062024", "story_v_out_117062.awb")
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
		"Assets/UIResources/UI_AB/TextureConfig/Background/A02d",
		"Assets/UIResources/UI_AB/TextureConfig/Background/TI0104"
	},
	voices = {
		"story_v_out_117062.awb"
	}
}
