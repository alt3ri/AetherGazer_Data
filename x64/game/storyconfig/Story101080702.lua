return {
	Play108072001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072001
		slot1.duration_ = 7

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.S0804 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.S0804
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "S0804" then
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

			slot6 = 1

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot7 + 2 and uv0.time_ < slot7 + slot8 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot10 = 0.55

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

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(108072001).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
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
	Play108072002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072002
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072003(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(108072002).content)
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
	Play108072003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072003
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.725

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(108072003).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (29 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play108072004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072004
		slot1.duration_ = 6.200999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 2 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(108072004).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 2.01666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 19
			slot4 = 0.96
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(0.96, uv0.talkMaxDuration)

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

			slot10 = 2

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072004", "story_v_out_108072.awb") / 1000 > 0 and 4.201 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072004", "story_v_out_108072.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot14 = 2

			if slot13 <= uv0.time_ and uv0.time_ < slot13 + slot14 then
				slot16 = Color.New(0, 0, 0)
				slot16.a = Mathf.Lerp(0, 1, (uv0.time_ - slot13) / slot14)
				uv0.mask_.color = slot16
			end

			if uv0.time_ >= slot13 + slot14 and uv0.time_ < slot13 + slot14 + slot0 then
				slot15 = Color.New(0, 0, 0)
				slot15.a = 1
				uv0.mask_.color = slot15
			end

			if 2 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot16 = 2

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				slot18 = Color.New(0, 0, 0)
				slot18.a = Mathf.Lerp(1, 0, (uv0.time_ - slot15) / slot16)
				uv0.mask_.color = slot18
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 then
				slot17 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot17.a = 0
				uv0.mask_.color = slot17
			end

			if uv0.bgs_.S0809 == nil then
				slot18 = Object.Instantiate(uv0.paintGo_)
				slot18:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot17)
				slot18.name = slot17
				slot18.transform.parent = uv0.stage_.transform
				slot18.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot17] = slot18
			end

			if 2 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				slot19 = manager.ui.mainCamera.transform.localPosition
				slot21 = uv0.bgs_.S0809
				slot21.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot19.x, slot19.y, 0)
				slot21.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot21:GetComponent("SpriteRenderer") and slot22.sprite then
					slot25 = manager.ui.mainCameraCom_
					slot26 = 2 * (slot21.transform.localPosition - slot19).z * Mathf.Tan(slot25.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot32 = slot26 * slot25.aspect / slot22.sprite.bounds.size.x > slot26 / slot22.sprite.bounds.size.y and slot30 or slot31
					slot21.transform.localScale = Vector3.New(slot32, slot32, 0)
				end

				for slot26, slot27 in pairs(uv0.bgs_) do
					if slot26 ~= "S0809" then
						slot27.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end
		end
	end,
	Play108072006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072006
		slot1.duration_ = 3.052999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 13
			slot3 = 0.66
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.66, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072006", "story_v_out_108072.awb") / 1000 > 0 and 3.053 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072006", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072007
		slot1.duration_ = 8.395999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 40
			slot3 = 2.28
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.28, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072007", "story_v_out_108072.awb") / 1000 > 0 and 8.396 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072007", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072008
		slot1.duration_ = 5.865999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 26
			slot3 = 1.5
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.5, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072008", "story_v_out_108072.awb") / 1000 > 0 and 5.866 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072008", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072009
		slot1.duration_ = 2.597999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 15
			slot3 = 0.72
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.72, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072009", "story_v_out_108072.awb") / 1000 > 0 and 2.598 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072009", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072010
		slot1.duration_ = 13.990999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 51
			slot3 = 2.28
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072004).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.28, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072010", "story_v_out_108072.awb") / 1000 > 0 and 13.991 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072010", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072011
		slot1.duration_ = 7.976999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(108072011).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 0.0166666666666667 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot3 = 28
			slot4 = 1.5
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072011).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(1.5, uv0.talkMaxDuration)

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

			slot10 = 0

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072011", "story_v_out_108072.awb") / 1000 > 0 and 7.977 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072011", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072013
		slot1.duration_ = 14.424999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 40
			slot3 = 2.22
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072011).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.22, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072013", "story_v_out_108072.awb") / 1000 > 0 and 14.425 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072013", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072014
		slot1.duration_ = 5.559999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 20
			slot3 = 1.08
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072011).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.08, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072014", "story_v_out_108072.awb") / 1000 > 0 and 5.56 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072014", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072015
		slot1.duration_ = 10.189999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 30
			slot3 = 1.68
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(108072011).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.68, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_108072", "108072015", "story_v_out_108072.awb") / 1000 > 0 and 10.19 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_108072", "108072015", "story_v_out_108072.awb")
			end
		end
	end,
	Play108072017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072017
		slot1.duration_ = 12.866

		if ({
			ja = 11.266,
			ko = 8.633,
			zh = 9.766,
			en = 12.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 2 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.S0804
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "S0804" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.fswbg_:SetActive(false)
				uv0.dialog_:SetActive(true)
				uv0:ShowNextGo(false)
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

			slot8 = 0.225

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(108072017).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (9 <= 0 and slot8 or slot8 * utf8.len(slot12) / slot13) > 0 and slot8 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot7 + 0.3 then
						uv0.duration_ = slot15 + slot7
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072017", "story_v_out_108072.awb") / 1000 + slot7 then
						uv0.duration_ = slot16 + slot7
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_108072", "108072017", "story_v_out_108072.awb")

						uv0:RecordAudio("108072017", slot17)
						uv0:RecordAudio("108072017", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072017", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072017", "story_v_out_108072.awb")
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
	Play108072018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072018
		slot1.duration_ = 10.066

		if ({
			ja = 10.066,
			ko = 6.8,
			zh = 6.5,
			en = 7.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.65

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072018).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072018", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072018", "story_v_out_108072.awb")

						uv0:RecordAudio("108072018", slot10)
						uv0:RecordAudio("108072018", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072018", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072018", "story_v_out_108072.awb")
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
	Play108072019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072019
		slot1.duration_ = 6.333

		if ({
			ja = 5,
			ko = 5.5,
			zh = 6.333,
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
				uv0:Play108072020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.55

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[74].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1050")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072019).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072019", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072019", "story_v_out_108072.awb")

						uv0:RecordAudio("108072019", slot10)
						uv0:RecordAudio("108072019", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072019", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072019", "story_v_out_108072.awb")
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
	Play108072020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072020
		slot1.duration_ = 3.366

		if ({
			ja = 2.9,
			ko = 2.9,
			zh = 3.2,
			en = 3.366
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1099")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072020).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072020", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072020", "story_v_out_108072.awb")

						uv0:RecordAudio("108072020", slot10)
						uv0:RecordAudio("108072020", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072020", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072020", "story_v_out_108072.awb")
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
	Play108072021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072021
		slot1.duration_ = 9.8

		if ({
			ja = 8.866,
			ko = 6.5,
			zh = 9.8,
			en = 7
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072021).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072021", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072021", "story_v_out_108072.awb")

						uv0:RecordAudio("108072021", slot10)
						uv0:RecordAudio("108072021", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072021", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072021", "story_v_out_108072.awb")
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
	Play108072022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072022
		slot1.duration_ = 19.3

		if ({
			ja = 19.3,
			ko = 10.333,
			zh = 15.9,
			en = 12.666
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.075

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072022).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072022", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072022", "story_v_out_108072.awb")

						uv0:RecordAudio("108072022", slot10)
						uv0:RecordAudio("108072022", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072022", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072022", "story_v_out_108072.awb")
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
	Play108072023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072023
		slot1.duration_ = 8.733

		if ({
			ja = 8.2,
			ko = 7.4,
			zh = 7.7,
			en = 8.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072023).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072023", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072023", "story_v_out_108072.awb")

						uv0:RecordAudio("108072023", slot10)
						uv0:RecordAudio("108072023", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072023", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072023", "story_v_out_108072.awb")
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
	Play108072024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072024
		slot1.duration_ = 13.4

		if ({
			ja = 13.4,
			ko = 9.866,
			zh = 11.233,
			en = 8.6
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.425

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072024", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072024", "story_v_out_108072.awb")

						uv0:RecordAudio("108072024", slot10)
						uv0:RecordAudio("108072024", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072024", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072024", "story_v_out_108072.awb")
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
	Play108072025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072025
		slot1.duration_ = 2.866

		if ({
			ja = 1.333,
			ko = 2.866,
			zh = 1.4,
			en = 1.5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.05

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[96].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(108072025).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072025", "story_v_out_108072.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_108072", "108072025", "story_v_out_108072.awb")

						uv0:RecordAudio("108072025", slot10)
						uv0:RecordAudio("108072025", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072025", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072025", "story_v_out_108072.awb")
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
	Play108072026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072026
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.25

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(108072026).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (10 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play108072027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072027
		slot1.duration_ = 6.5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.C04 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 1.5 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.C04
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "C04" then
						slot11.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				if uv0.bgs_.S0804:GetComponent("SpriteRenderer") then
					slot5.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot6 = slot5.material
					uv0.var_.alphaOldValueS0804 = slot6:GetColor("_Color").a
					uv0.var_.alphaMatValueS0804 = slot6
				end

				uv0.var_.alphaOldValueS0804 = 1
			end

			slot5 = 1.5

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				if uv0.var_.alphaMatValueS0804 then
					slot8 = uv0.var_.alphaMatValueS0804
					slot9 = slot8:GetColor("_Color")
					slot9.a = Mathf.Lerp(uv0.var_.alphaOldValueS0804, 0, (uv0.time_ - slot4) / slot5)

					slot8:SetColor("_Color", slot9)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.alphaMatValueS0804 then
				slot6 = uv0.var_.alphaMatValueS0804
				slot7 = slot6:GetColor("_Color")
				slot7.a = 0

				slot6:SetColor("_Color", slot7)
			end

			if 1.5 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				if uv0.bgs_.C04:GetComponent("SpriteRenderer") then
					slot8.material = uv0.transpaintGo_:GetComponent("SpriteRenderer").material
					slot9 = slot8.material
					uv0.var_.alphaOldValueC04 = slot9:GetColor("_Color").a
					uv0.var_.alphaMatValueC04 = slot9
				end

				uv0.var_.alphaOldValueC04 = 0
			end

			slot8 = 1.5

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.alphaMatValueC04 then
					slot11 = uv0.var_.alphaMatValueC04
					slot12 = slot11:GetColor("_Color")
					slot12.a = Mathf.Lerp(uv0.var_.alphaOldValueC04, 1, (uv0.time_ - slot7) / slot8)

					slot11:SetColor("_Color", slot12)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.alphaMatValueC04 then
				slot9 = uv0.var_.alphaMatValueC04
				slot10 = slot9:GetColor("_Color")
				slot10.a = 1

				slot9:SetColor("_Color", slot10)
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot9 + 1.5 and uv0.time_ < slot9 + slot10 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot12 = 0.65

			if 1.5 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, false)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(108072027).content)
				uv0.text_.text = slot14

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (26 <= 0 and slot12 or slot12 * utf8.len(slot14) / slot15) > 0 and slot12 < slot17 then
					uv0.talkMaxDuration = slot17

					if uv0.duration_ < slot17 + slot11 then
						uv0.duration_ = slot17 + slot11
					end
				end

				uv0.text_.text = slot14
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)
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
	Play108072028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072028
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.675

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(108072028).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play108072029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072029
		slot1.duration_ = 7.133

		if ({
			ja = 3.366,
			ko = 6.1,
			zh = 5.933,
			en = 7.133
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play108072030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.actors_["1099ui_story"] == nil then
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
				uv0.var_.moveOldPos1099ui_story = uv0.actors_["1099ui_story"].transform.localPosition
			end

			slot4 = 0.001

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot4 then
				slot2.localPosition = Vector3.Lerp(uv0.var_.moveOldPos1099ui_story, Vector3.New(0, -1.08, -5.9), (uv0.time_ - slot3) / slot4)
				slot8 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot2.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot2.localEulerAngles = slot9
			end

			if uv0.time_ >= slot3 + slot4 and uv0.time_ < slot3 + slot4 + slot0 then
				slot2.localPosition = Vector3.New(0, -1.08, -5.9)
				slot7 = manager.ui.mainCamera.transform.position - slot2.position
				slot2.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot2.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot2.localEulerAngles = slot8
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 and uv0.var_.characterEffect1099ui_story == nil then
				uv0.var_.characterEffect1099ui_story = uv0.actors_["1099ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot7 = 0.2

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot8 = (uv0.time_ - slot6) / slot7

				if uv0.var_.characterEffect1099ui_story then
					uv0.var_.characterEffect1099ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 and uv0.var_.characterEffect1099ui_story then
				uv0.var_.characterEffect1099ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/1099/1099action/1099action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			slot11 = 0.725

			if 0 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot14 = uv0:FormatText(uv0:GetWordFromCfg(108072029).content)
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

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072029", "story_v_out_108072.awb") / 1000 + slot10 then
						uv0.duration_ = slot18 + slot10
					end

					if slot13.prefab_name ~= "" and uv0.actors_[slot13.prefab_name] ~= nil then
						slot19 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot13.prefab_name].transform, "story_v_out_108072", "108072029", "story_v_out_108072.awb")

						uv0:RecordAudio("108072029", slot19)
						uv0:RecordAudio("108072029", slot19)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072029", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072029", "story_v_out_108072.awb")
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
	Play108072030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 108072030
		slot1.duration_ = 11.933

		if ({
			ja = 11.933,
			ko = 3.733,
			zh = 5.3,
			en = 5.466
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
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("1099ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0203cva")
			end

			slot3 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[84].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot6 = uv0:FormatText(uv0:GetWordFromCfg(108072030).content)
				uv0.text_.text = slot6

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (20 <= 0 and slot3 or slot3 * utf8.len(slot6) / slot7) > 0 and slot3 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end

				uv0.text_.text = slot6
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_108072", "108072030", "story_v_out_108072.awb") / 1000 + slot2 then
						uv0.duration_ = slot10 + slot2
					end

					if slot5.prefab_name ~= "" and uv0.actors_[slot5.prefab_name] ~= nil then
						slot11 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot5.prefab_name].transform, "story_v_out_108072", "108072030", "story_v_out_108072.awb")

						uv0:RecordAudio("108072030", slot11)
						uv0:RecordAudio("108072030", slot11)
					else
						uv0:AudioAction("play", "voice", "story_v_out_108072", "108072030", "story_v_out_108072.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_108072", "108072030", "story_v_out_108072.awb")
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
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/S0804",
		"Assets/UIResources/UI_AB/TextureConfig/Background/S0809",
		"Assets/UIResources/UI_AB/TextureConfig/Background/C04"
	},
	voices = {
		"story_v_out_108072.awb"
	}
}
