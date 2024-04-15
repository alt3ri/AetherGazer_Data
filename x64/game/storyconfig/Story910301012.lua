return {
	Play910302001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302001
		slot1.duration_ = 9

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.B13 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.B13
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "B13" then
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

			if uv0.actors_["1084ui_story"] == nil then
				slot8 = Object.Instantiate(Asset.Load("Char/" .. slot7), uv0.stage_.transform)
				slot8.name = slot7
				slot8.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot7] = slot8
				slot8:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot8, typeof(DynamicBoneHelper)) then
					slot10:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot9.transform, false)

				uv0.var_[slot7 .. "Animator"] = slot9.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot7 .. "Animator"].applyRootMotion = true
				uv0.var_[slot7 .. "LipSync"] = slot9.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 4 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot10 = 0.001

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot8.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot9) / slot10)
				slot14 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot8.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot8.localEulerAngles = slot15
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot13 = manager.ui.mainCamera.transform.position - slot8.position
				slot8.forward = Vector3.New(slot13.x, slot13.y, slot13.z)
				slot14 = slot8.localEulerAngles
				slot14.z = 0
				slot14.x = 0
				slot8.localEulerAngles = slot14
			end

			if 4 < uv0.time_ and uv0.time_ <= slot12 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot13 = 0.200000002980232

			if slot12 <= uv0.time_ and uv0.time_ < slot12 + slot13 then
				slot14 = (uv0.time_ - slot12) / slot13

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot12 + slot13 and uv0.time_ < slot12 + slot13 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 4 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action7_1")
			end

			if 4 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if uv0.actors_["1066ui_story"] == nil then
				slot17 = Object.Instantiate(Asset.Load("Char/" .. slot16), uv0.stage_.transform)
				slot17.name = slot16
				slot17.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot16] = slot17
				slot17:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot17, typeof(DynamicBoneHelper)) then
					slot19:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot18.transform, false)

				uv0.var_[slot16 .. "Animator"] = slot18.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot16 .. "Animator"].applyRootMotion = true
				uv0.var_[slot16 .. "LipSync"] = slot18.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 4 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot19 = 0.001

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				slot17.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (uv0.time_ - slot18) / slot19)
				slot23 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot23.x, slot23.y, slot23.z)
				slot24 = slot17.localEulerAngles
				slot24.z = 0
				slot24.x = 0
				slot17.localEulerAngles = slot24
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				slot17.localPosition = Vector3.New(0.7, -0.77, -6.1)
				slot22 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot22.x, slot22.y, slot22.z)
				slot23 = slot17.localEulerAngles
				slot23.z = 0
				slot23.x = 0
				slot17.localEulerAngles = slot23
			end

			if 4 < uv0.time_ and uv0.time_ <= slot21 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot22 = 0.200000002980232

			if slot21 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = true
					uv0.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot21) / slot22)
				end
			end

			if uv0.time_ >= slot21 + slot22 and uv0.time_ < slot21 + slot22 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = true
				uv0.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			if 4 < uv0.time_ and uv0.time_ <= slot23 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot25 = 0.55

			if 4 < uv0.time_ and uv0.time_ <= slot24 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot26 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot26:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot26:setOnComplete(System.Action(function ()
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

				slot29 = uv0:FormatText(uv0:GetWordFromCfg(910302001).content)
				uv0.text_.text = slot29

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot25 or slot25 * utf8.len(slot29) / slot30) > 0 and slot25 < slot32 then
					uv0.talkMaxDuration = slot32

					if uv0.duration_ < slot32 + slot24 + 0.3 then
						uv0.duration_ = slot32 + slot24
					end
				end

				uv0.text_.text = slot29
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
				uv0:RecordContent(uv0.text_.text)
			end

			slot25 = math.max(slot25, uv0.talkMaxDuration)

			if slot24 + 0.3 <= uv0.time_ and uv0.time_ < slot24 + slot25 then
				uv0.typewritter.percent = (uv0.time_ - slot24) / slot25

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot24 + slot25 and uv0.time_ < slot24 + slot25 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play910302002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302002
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot11 = 0.200000002980232

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot10) / slot11)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			slot13 = 0.575

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(910302002).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (23 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
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
	Play910302003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302003
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = true
					uv0.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot2) / slot3)
				end
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = true
				uv0.var_.characterEffect1066ui_story.fillRatio = 0.5
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
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot9 = 0.001

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				slot7.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot8) / slot9)
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

			slot11 = 1.15

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(910302003).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (46 <= 0 and slot11 or slot11 * utf8.len(slot13) / slot14) > 0 and slot11 < slot16 then
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
	Play910302004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302004
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302004).content)
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
	Play910302005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302005
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action3_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot10) / slot11)
				slot15 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot15.x, slot15.y, slot15.z)
				slot16 = slot9.localEulerAngles
				slot16.z = 0
				slot16.x = 0
				slot9.localEulerAngles = slot16
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 then
				slot9.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot14 = manager.ui.mainCamera.transform.position - slot9.position
				slot9.forward = Vector3.New(slot14.x, slot14.y, slot14.z)
				slot15 = slot9.localEulerAngles
				slot15.z = 0
				slot15.x = 0
				slot9.localEulerAngles = slot15
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot14 = 0.034000001847744

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot13) / slot14)
				end
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action1_1")
			end

			slot18 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot21 = uv0:FormatText(uv0:GetWordFromCfg(910302005).content)
				uv0.text_.text = slot21

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (18 <= 0 and slot18 or slot18 * utf8.len(slot21) / slot22) > 0 and slot18 < slot24 then
					uv0.talkMaxDuration = slot24

					if uv0.duration_ < slot24 + slot17 then
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
	Play910302006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302006
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302006).content)
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
	Play910302007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302007
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(-0.7, -0.97, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(-0.7, -0.97, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action5_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot11 = 0.200000002980232

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = true
					uv0.var_.characterEffect1066ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot10) / slot11)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = true
				uv0.var_.characterEffect1066ui_story.fillRatio = 0.5
			end

			slot13 = 1.025

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

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(910302007).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
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
	Play910302008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302008
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.3

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302008).content)
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
	Play910302009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302009
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

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

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action5_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1201cva")
			end

			slot7 = 0.825

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(910302009).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
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
	Play910302010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302010
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1101cva")
			end

			slot3 = 0.9

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
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

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(910302010).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (36 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
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
	Play910302011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302011
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302011).content)
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
	Play910302012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302012
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0.7, -0.77, -6.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0.7, -0.77, -6.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066actionlink/1066action432")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot10 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(910302012).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play910302013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302013
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302013).content)
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
	Play910302014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302014
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(910302014).content)
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
	Play910302015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302015
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -0.97, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action8_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			slot10 = 0.725

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(910302015).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play910302016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302016
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot3 = 0.200000002980232

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(910302016).content)
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
	Play910302017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302017
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

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

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302017).content)
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
	Play910302018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302018
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -0.77, -6.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot10) / slot11)
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

			slot13 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(910302018).content)
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
	Play910302019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302019
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302019).content)
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
	Play910302020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302020
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, -0.97, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -0.97, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/1084/1084action/1084action2_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1084ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot11 = 0.001

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				slot9.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot10) / slot11)
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

			slot13 = 0.975

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

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(910302020).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (39 <= 0 and slot13 or slot13 * utf8.len(slot16) / slot17) > 0 and slot13 < slot19 then
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
	Play910302021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302021
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos1066ui_story = uv0.actors_["1066ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1066ui_story, Vector3.New(0, -0.77, -6.1), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -0.77, -6.1)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 and uv0.var_.characterEffect1066ui_story == nil then
				uv0.var_.characterEffect1066ui_story = uv0.actors_["1066ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot6 = 0.200000002980232

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot7 = (uv0.time_ - slot5) / slot6

				if uv0.var_.characterEffect1066ui_story then
					uv0.var_.characterEffect1066ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot5 + slot6 and uv0.time_ < slot5 + slot6 + slot0 and uv0.var_.characterEffect1066ui_story then
				uv0.var_.characterEffect1066ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/1066/1066action/1066action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 and uv0.var_.characterEffect1084ui_story == nil then
				uv0.var_.characterEffect1084ui_story = uv0.actors_["1084ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot11 = 0.200000002980232

			if slot10 <= uv0.time_ and uv0.time_ < slot10 + slot11 then
				if uv0.var_.characterEffect1084ui_story then
					uv0.var_.characterEffect1084ui_story.fillFlat = true
					uv0.var_.characterEffect1084ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot10) / slot11)
				end
			end

			if uv0.time_ >= slot10 + slot11 and uv0.time_ < slot10 + slot11 + slot0 and uv0.var_.characterEffect1084ui_story then
				uv0.var_.characterEffect1084ui_story.fillFlat = true
				uv0.var_.characterEffect1084ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.var_.moveOldPos1084ui_story = uv0.actors_["1084ui_story"].transform.localPosition
			end

			slot14 = 0.001

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot12.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1084ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot13) / slot14)
				slot18 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot18.x, slot18.y, slot18.z)
				slot19 = slot12.localEulerAngles
				slot19.z = 0
				slot19.x = 0
				slot12.localEulerAngles = slot19
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot12.localPosition = Vector3.New(0, 100, 0)
				slot17 = manager.ui.mainCamera.transform.position - slot12.position
				slot12.forward = Vector3.New(slot17.x, slot17.y, slot17.z)
				slot18 = slot12.localEulerAngles
				slot18.z = 0
				slot18.x = 0
				slot12.localEulerAngles = slot18
			end

			slot16 = 0.925

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot19 = uv0:FormatText(uv0:GetWordFromCfg(910302021).content)
				uv0.text_.text = slot19

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (37 <= 0 and slot16 or slot16 * utf8.len(slot19) / slot20) > 0 and slot16 < slot22 then
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
	Play910302022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302022
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play910302023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(910302022).content)
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
	Play910302023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 910302023
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
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1066ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface1202cva")
			end

			slot3 = 0.4

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[32].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(910302023).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/B13"
	},
	voices = {}
}
