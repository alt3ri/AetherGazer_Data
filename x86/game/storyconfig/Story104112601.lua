return {
	Play411261001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.ST73 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.ST73
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "ST73" then
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

			slot6 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot8 = 1

			if 0.666666666666667 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 1.45

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261001).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (58 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play411261002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261002
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.2

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(411261002).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (48 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play411261003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261003
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["10014ui_story"] == nil then
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
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -1.06, -6.2)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.200000002980232

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot11 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(411261003).content)
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
	Play411261004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261004
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				uv0.callingController_:SetSelectedState("calling")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261004).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
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
	Play411261005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261005
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[471].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1095")

				uv0.callingController_:SetSelectedState("calling")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261005).content)
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
	Play411261006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261006
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261006).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play411261007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261007
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261007).content)
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
	Play411261008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261008
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_shadoww")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261008).content)
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
	Play411261009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261009
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot8 = 1.4

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(411261009).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (56 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play411261010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261010).content)
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
	Play411261011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3101cva")
			end

			slot10 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261011).content)
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
	Play411261012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			slot10 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261012).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (25 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play411261013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261013
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261013).content)
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
	Play411261014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261014).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play411261015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261015
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261015).content)
				uv0.text_.text = slot8

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot5 or slot5 * utf8.len(slot8) / slot9) > 0 and slot5 < slot11 then
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
	Play411261016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261016
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			slot8 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot11 = uv0:FormatText(uv0:GetWordFromCfg(411261016).content)
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
	Play411261017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261017).content)
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
	Play411261018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261018
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261018).content)
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
	Play411261019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261019
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261019).content)
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
	Play411261020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261020
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261020).content)
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
	Play411261021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261021
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261021).content)
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
	Play411261022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261022
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261022).content)
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
	Play411261023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261023
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261023).content)
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
	Play411261024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261024
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.8

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261024).content)
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
	Play411261025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261025
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261025).content)
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
	Play411261026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261026
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.1

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261026).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (44 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
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
	Play411261027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261027
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261027).content)
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
	Play411261028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261028
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action2_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261028).content)
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
	Play411261029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261029
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot5 = 0.875

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot8 = uv0:FormatText(uv0:GetWordFromCfg(411261029).content)
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
	Play411261030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261030
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.95

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261030).content)
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
	Play411261031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261031
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[36].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(411261031).content)
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
	Play411261032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261032
		slot1.duration_ = 5.66666666666667

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.STblack == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0.666666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.STblack
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "STblack" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot4 = 0.666666666666667

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

			if 0.933333333333334 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot6 = 0.4

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

			if 0.666666666666667 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot8 = 0.266666666666667

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot10 = Color.New(0.5, 0.0731132, 0.0731132)
				slot10.a = Mathf.Lerp(0, 1, (uv0.time_ - slot7) / slot8)
				uv0.mask_.color = slot10
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot9 = Color.New(0.5, 0.0731132, 0.0731132)
				slot9.a = 1
				uv0.mask_.color = slot9
			end

			if 0.665999998152256 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot10) / slot11)
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

			if 0.665999998152256 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot14 = 0.200000002980232

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot13) / slot14)
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot16 = 0.4

			if 0.665999998152256 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_130", "se_story_130_gun", "")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot18 = 0.1

			if 0.666666666666667 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot19 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot19:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot19:setOnComplete(System.Action(function ()
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

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(411261032).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 + 0.3 then
						uv0.duration_ = slot24 + slot17
					end
				end

				uv0.text_.text = slot21
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot18 = math.max(slot18, uv0.talkMaxDuration)

			if slot17 + 0.3 <= uv0.time_ and uv0.time_ < slot17 + slot18 then
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
	Play411261033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261033
		slot1.duration_ = 6.4

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.ST73
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "ST73" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot2 + 0.3 and uv0.time_ < slot2 + slot3 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
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

			slot6 = manager.ui.mainCamera.transform

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.effect112 then
				Object.Destroy(slot8)

				uv0.var_.effect112 = nil
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot9 = 0.975

			if 1.4 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot10 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot10:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot10:setOnComplete(System.Action(function ()
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

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(411261033).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot9 or slot9 * utf8.len(slot12) / slot13) > 0 and slot9 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot8 + 0.3 then
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

			if slot8 + 0.3 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
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
	Play411261034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261034
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.4

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(411261034).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (56 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play411261035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261035
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["2079ui_story"] == nil then
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
				uv0.var_.moveOldPos2079ui_story = uv0.actors_["2079ui_story"].transform.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2079ui_story, Vector3.New(0, -1.28, -5.6), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -1.28, -5.6)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.200000002980232

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot11 = 0.225

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(411261035).content)
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
	Play411261036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261036
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos2079ui_story = uv0.actors_["2079ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2079ui_story, Vector3.New(-0.7, -1.28, -5.6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-0.7, -1.28, -5.6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = true
					uv0.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = true
				uv0.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (uv0.time_ - slot8) / slot9)
				slot13 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot7.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot7.localEulerAngles = slot14
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				slot7.localPosition = Vector3.New(0.7, -1.06, -6.2)
				slot12 = manager.ui.mainCamera.transform.position - slot7.position
				slot7.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot7.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot7.localEulerAngles = slot13
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot12 = 0.200000002980232

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot16 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(411261036).content)
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
	Play411261037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261037
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261038(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.200000002980232

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot10 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261037).content)
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
	Play411261038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261038
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0.7, -1.06, -6.2), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0.7, -1.06, -6.2)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot11 = 0.200000002980232

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = true
					uv0.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot10) / slot11)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = true
				uv0.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			slot13 = 0.275

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[264].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(411261038).content)
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
	Play411261039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261039
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play411261040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot4 = (uv0.time_ - slot2) / slot3

				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/story2079/story2079action/2079action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("2079ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.200000002980232

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot10 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[660].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(411261039).content)
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
	Play411261040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 411261040
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
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos2079ui_story = uv0.actors_["2079ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos2079ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect2079ui_story == nil then
				uv0.var_.characterEffect2079ui_story = uv0.actors_["2079ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				if uv0.var_.characterEffect2079ui_story then
					uv0.var_.characterEffect2079ui_story.fillFlat = true
					uv0.var_.characterEffect2079ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot5) / slot6)
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect2079ui_story then
				uv0.var_.characterEffect2079ui_story.fillFlat = true
				uv0.var_.characterEffect2079ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.var_.moveOldPos10014ui_story = uv0.actors_["10014ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10014ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect10014ui_story == nil then
				uv0.var_.characterEffect10014ui_story = uv0.actors_["10014ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot12 = 0.200000002980232

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				if uv0.var_.characterEffect10014ui_story then
					uv0.var_.characterEffect10014ui_story.fillFlat = true
					uv0.var_.characterEffect10014ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot11) / slot12)
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10014ui_story then
				uv0.var_.characterEffect10014ui_story.fillFlat = true
				uv0.var_.characterEffect10014ui_story.fillRatio = 0.5
			end

			slot14 = 1.575

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

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(411261040).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (63 <= 0 and slot14 or slot14 * utf8.len(slot16) / slot17) > 0 and slot14 < slot19 then
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST73",
		"Assets/UIResources/UI_AB/TextureConfig/Background/STblack"
	},
	voices = {}
}
