return {
	Play116381001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381001
		slot1.duration_ = 10.450999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381002(uv1)
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

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
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

			if 2 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381001).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 2.01666666666667 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot5 = 37
			slot6 = 2.46666666666667
			slot9, slot10 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 1)

			if slot4 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot5 <= 0 and slot6 or slot6 * (slot10 - uv0.typewritterCharCountI18N) / slot5) > 0 and slot6 < slot11 then
					uv0.talkMaxDuration = slot11

					if uv0.duration_ < slot11 + slot4 then
						uv0.duration_ = slot11 + slot4
					end
				end
			end

			slot11 = math.max(2.46666666666667, uv0.talkMaxDuration)

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot11 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot9, (uv0.time_ - slot4) / slot11)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot4 + slot11 and uv0.time_ < slot4 + slot11 + slot0 then
				uv0.fswtw_.percent = slot9

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot10
			end

			slot12 = 2

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381001", "story_v_out_116381.awb") / 1000 > 0 and 8.451 < slot14 and uv0.duration_ < slot14 + slot12 then
				slot13 = slot14
				uv0.duration_ = slot14 + slot12
			end

			if slot12 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381001", "story_v_out_116381.awb")
			end

			slot16 = 0.266666666666667

			if 0 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot18 = 0.6

			if 2.2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")
			end

			slot20 = 0.425

			if 2.375 < uv0.time_ and uv0.time_ <= slot19 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_6_story_story", "story", "bgm_activity_1_6_story_story.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot22 = 2

			if slot21 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
				slot24 = Color.New(0, 0, 0)
				slot24.a = Mathf.Lerp(1, 0, (uv0.time_ - slot21) / slot22)
				uv0.mask_.color = slot24
			end

			if uv0.time_ >= slot21 + slot22 and uv0.time_ < slot21 + slot22 + slot0 then
				slot23 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot23.a = 0
				uv0.mask_.color = slot23
			end

			if 2 < uv0.time_ and uv0.time_ <= slot23 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot23 + 2.48333333333333 and uv0.time_ < slot23 + slot24 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381002
		slot1.duration_ = 10.274999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 44
			slot3 = 2.93333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.93333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381002", "story_v_out_116381.awb") / 1000 > 0 and 10.275 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381002", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.93333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381003
		slot1.duration_ = 13.779999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 62
			slot3 = 4.13333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(4.13333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381003", "story_v_out_116381.awb") / 1000 > 0 and 13.78 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381003", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 4.13333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381004
		slot1.duration_ = 1.348999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 11
			slot3 = 0.733333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.733333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381004", "story_v_out_116381.awb") / 1000 > 0 and 1.349 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381004", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.733333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381005
		slot1.duration_ = 4.216999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 23
			slot3 = 1.53333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.53333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381005", "story_v_out_116381.awb") / 1000 > 0 and 4.217 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381005", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.53333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381006
		slot1.duration_ = 7.026999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 42
			slot3 = 2.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381001).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381006", "story_v_out_116381.awb") / 1000 > 0 and 7.027 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381006", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381007
		slot1.duration_ = 10.286999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381007).content)

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

			slot3 = 48
			slot4 = 3.2
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(3.2, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381007", "story_v_out_116381.awb") / 1000 > 0 and 10.287 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381007", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 3.21666666666667 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381008
		slot1.duration_ = 7.653999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 27
			slot3 = 1.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381008", "story_v_out_116381.awb") / 1000 > 0 and 7.654 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381008", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381009
		slot1.duration_ = 12.168999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381010(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 61
			slot3 = 4.06666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(4.06666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381009", "story_v_out_116381.awb") / 1000 > 0 and 12.169 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381009", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 4.06666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381010 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381010
		slot1.duration_ = 9.973999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381011(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 31
			slot3 = 2.06666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.06666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381010", "story_v_out_116381.awb") / 1000 > 0 and 9.974 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381010", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.06666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381011 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381011
		slot1.duration_ = 0.964999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381012(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 10
			slot3 = 0.666666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.666666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381011", "story_v_out_116381.awb") / 1000 > 0 and 0.965 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381011", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.666666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381012 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381012
		slot1.duration_ = 9.533

		if ({
			zh = 8.2,
			ja = 9.533
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381013(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.SK0107 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.SK0107
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "SK0107" then
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

			if 1.98333333333333 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.fswbg_:SetActive(false)
				uv0.dialog_:SetActive(false)
				uv0:ShowNextGo(false)
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot9 = 0.4

			if 4 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
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

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381012).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot9 or slot9 * utf8.len(slot13) / slot14) > 0 and slot9 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot8 + 0.3 then
						uv0.duration_ = slot16 + slot8
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381012", "story_v_out_116381.awb") / 1000 + slot8 then
						uv0.duration_ = slot17 + slot8
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381012", "story_v_out_116381.awb")

						uv0:RecordAudio("116381012", slot18)
						uv0:RecordAudio("116381012", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381012", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381012", "story_v_out_116381.awb")
				end

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
	Play116381013 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381013
		slot1.duration_ = 15.2

		if ({
			zh = 11.366,
			ja = 15.2
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381014(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.SK0112 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.SK0112
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "SK0112" then
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

			slot8 = 0.7

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(116381013).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot8 or slot8 * utf8.len(slot12) / slot13) > 0 and slot8 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot7 + 0.3 then
						uv0.duration_ = slot15 + slot7
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381013", "story_v_out_116381.awb") / 1000 + slot7 then
						uv0.duration_ = slot16 + slot7
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_116381", "116381013", "story_v_out_116381.awb")

						uv0:RecordAudio("116381013", slot17)
						uv0:RecordAudio("116381013", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381013", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381013", "story_v_out_116381.awb")
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
	Play116381014 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381014
		slot1.duration_ = 8.833

		if ({
			zh = 8.833,
			ja = 7.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381015(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.SK0201 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.SK0201
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "SK0201" then
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

			slot8 = 0.4

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(116381014).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (16 <= 0 and slot8 or slot8 * utf8.len(slot12) / slot13) > 0 and slot8 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot7 + 0.3 then
						uv0.duration_ = slot15 + slot7
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381014", "story_v_out_116381.awb") / 1000 + slot7 then
						uv0.duration_ = slot16 + slot7
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_116381", "116381014", "story_v_out_116381.awb")

						uv0:RecordAudio("116381014", slot17)
						uv0:RecordAudio("116381014", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381014", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381014", "story_v_out_116381.awb")
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
	Play116381015 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381015
		slot1.duration_ = 17.766666666666

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381016(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 2 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.STblack
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "STblack" then
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

			slot6 = 4

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381015", "story_v_out_116381.awb") / 1000 > 0 and 12.868 < slot8 and uv0.duration_ < slot8 + slot6 then
				slot7 = slot8
				uv0.duration_ = slot8 + slot6
			end

			if slot6 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381015", "story_v_out_116381.awb")
			end

			if 4 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot10 = 48
			slot11 = 3.53333333333333
			slot14, slot15 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381007).content), 1)

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot10 <= 0 and slot11 or slot11 * (slot15 - uv0.typewritterCharCountI18N) / slot10) > 0 and slot11 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end
			end

			slot16 = math.max(3.53333333333333, uv0.talkMaxDuration)

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot16 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot14, (uv0.time_ - slot9) / slot16)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot9 + slot16 and uv0.time_ < slot9 + slot16 + slot0 then
				uv0.fswtw_.percent = slot14

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot15
			end

			if 2 < uv0.time_ and uv0.time_ <= slot17 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381015).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 4 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot18 + 3.53333333333333 and uv0.time_ < slot18 + slot19 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381016 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381016
		slot1.duration_ = 7.696999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381017(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 93
			slot3 = 2.66666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.66666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381016", "story_v_out_116381.awb") / 1000 > 0 and 7.697 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381016", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.66666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381017 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381017
		slot1.duration_ = 3.494999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381018(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 12
			slot3 = 0.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381017", "story_v_out_116381.awb") / 1000 > 0 and 3.495 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381017", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381018 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381018
		slot1.duration_ = 13.848999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381019(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 64
			slot3 = 4.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(4.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381018", "story_v_out_116381.awb") / 1000 > 0 and 13.849 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381018", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 4.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381019 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381019
		slot1.duration_ = 4.214999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381020(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 15
			slot3 = 1
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381019", "story_v_out_116381.awb") / 1000 > 0 and 4.215 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381019", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381020 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381020
		slot1.duration_ = 10.606999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381021(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 49
			slot3 = 3.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381020", "story_v_out_116381.awb") / 1000 > 0 and 10.607 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381020", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381021 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381021
		slot1.duration_ = 7.806999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381022(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 43
			slot3 = 2.86666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381015).content), 7)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.86666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381021", "story_v_out_116381.awb") / 1000 > 0 and 7.807 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381021", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.86666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381022 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381022
		slot1.duration_ = 20.4

		if ({
			zh = 15.7,
			ja = 20.4
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381023(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.SK0106 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.SK0106
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "SK0106" then
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

			if 2 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.fswbg_:SetActive(false)
				uv0.dialog_:SetActive(false)
				uv0:ShowNextGo(false)
			end

			if 2 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0.screenFilterGo_:SetActive(true)

				uv0.screenFilterEffect_.profile = Asset.Load("Effect/Scene/fx_vintageStyle_Profile")
			end

			slot9 = 0.1

			if slot8 <= uv0.time_ and uv0.time_ < slot8 + slot9 then
				uv0.screenFilterEffect_.weight = Mathf.Lerp(0, 1, (uv0.time_ - slot8) / slot9)
			end

			if uv0.time_ >= slot8 + slot9 and uv0.time_ < slot8 + slot9 + slot0 then
				uv0.screenFilterEffect_.weight = 1
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot11 = 0.875

			if 4 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
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

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot15 = uv0:FormatText(uv0:GetWordFromCfg(116381022).content)
				uv0.text_.text = slot15

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (35 <= 0 and slot11 or slot11 * utf8.len(slot15) / slot16) > 0 and slot11 < slot18 then
					uv0.talkMaxDuration = slot18

					if uv0.duration_ < slot18 + slot10 + 0.3 then
						uv0.duration_ = slot18 + slot10
					end
				end

				uv0.text_.text = slot15
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381022", "story_v_out_116381.awb") / 1000 + slot10 then
						uv0.duration_ = slot19 + slot10
					end

					if slot14.prefab_name ~= "" and uv0.actors_[slot14.prefab_name] ~= nil then
						slot20 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot14.prefab_name].transform, "story_v_out_116381", "116381022", "story_v_out_116381.awb")

						uv0:RecordAudio("116381022", slot20)
						uv0:RecordAudio("116381022", slot20)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381022", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381022", "story_v_out_116381.awb")
				end

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
	Play116381023 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381023
		slot1.duration_ = 15.733

		if ({
			zh = 12.1,
			ja = 15.733
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381024(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381023).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381023", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381023", "story_v_out_116381.awb")

						uv0:RecordAudio("116381023", slot10)
						uv0:RecordAudio("116381023", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381023", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381023", "story_v_out_116381.awb")
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
	Play116381024 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381024
		slot1.duration_ = 8.8

		if ({
			zh = 4.066,
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
				uv0:Play116381025(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381024).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381024", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381024", "story_v_out_116381.awb")

						uv0:RecordAudio("116381024", slot10)
						uv0:RecordAudio("116381024", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381024", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381024", "story_v_out_116381.awb")
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
	Play116381025 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381025
		slot1.duration_ = 3.833

		if ({
			zh = 3.2,
			ja = 3.833
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381026(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.35

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381025).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381025", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381025", "story_v_out_116381.awb")

						uv0:RecordAudio("116381025", slot10)
						uv0:RecordAudio("116381025", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381025", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381025", "story_v_out_116381.awb")
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
	Play116381026 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381026
		slot1.duration_ = 12.733

		if ({
			zh = 12.733,
			ja = 9.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381027(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.SK0102 == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.SK0102
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "SK0102" then
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

			slot8 = 0.45

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

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot12 = uv0:FormatText(uv0:GetWordFromCfg(116381026).content)
				uv0.text_.text = slot12

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot8 or slot8 * utf8.len(slot12) / slot13) > 0 and slot8 < slot15 then
					uv0.talkMaxDuration = slot15

					if uv0.duration_ < slot15 + slot7 + 0.3 then
						uv0.duration_ = slot15 + slot7
					end
				end

				uv0.text_.text = slot12
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381026", "story_v_out_116381.awb") / 1000 + slot7 then
						uv0.duration_ = slot16 + slot7
					end

					if slot11.prefab_name ~= "" and uv0.actors_[slot11.prefab_name] ~= nil then
						slot17 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot11.prefab_name].transform, "story_v_out_116381", "116381026", "story_v_out_116381.awb")

						uv0:RecordAudio("116381026", slot17)
						uv0:RecordAudio("116381026", slot17)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381026", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381026", "story_v_out_116381.awb")
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
	Play116381027 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381027
		slot1.duration_ = 2.666

		if ({
			zh = 2.666,
			ja = 1.966
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381028(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[337].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10046")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381027).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381027", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381027", "story_v_out_116381.awb")

						uv0:RecordAudio("116381027", slot10)
						uv0:RecordAudio("116381027", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381027", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381027", "story_v_out_116381.awb")
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
	Play116381028 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381028
		slot1.duration_ = 4.566

		if ({
			zh = 4.566,
			ja = 4.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381029(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10032")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381028).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381028", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381028", "story_v_out_116381.awb")

						uv0:RecordAudio("116381028", slot10)
						uv0:RecordAudio("116381028", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381028", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381028", "story_v_out_116381.awb")
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
	Play116381029 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381029
		slot1.duration_ = 11.1

		if ({
			zh = 9.733,
			ja = 11.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381030(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if uv0.bgs_.I05f == nil then
				slot2 = Object.Instantiate(uv0.paintGo_)
				slot2:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. slot1)
				slot2.name = slot1
				slot2.transform.parent = uv0.stage_.transform
				slot2.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.bgs_[slot1] = slot2
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				slot3 = manager.ui.mainCamera.transform.localPosition
				slot5 = uv0.bgs_.I05f
				slot5.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot3.x, slot3.y, 0)
				slot5.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot5:GetComponent("SpriteRenderer") and slot6.sprite then
					slot9 = manager.ui.mainCameraCom_
					slot10 = 2 * (slot5.transform.localPosition - slot3).z * Mathf.Tan(slot9.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot16 = slot10 * slot9.aspect / slot6.sprite.bounds.size.x > slot10 / slot6.sprite.bounds.size.y and slot14 or slot15
					slot5.transform.localScale = Vector3.New(slot16, slot16, 0)
				end

				for slot10, slot11 in pairs(uv0.bgs_) do
					if slot10 ~= "I05f" then
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

			if uv0.actors_["10024ui_story"] == nil then
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

			if 4 < uv0.time_ and uv0.time_ <= slot8 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 4 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 4 < uv0.time_ and uv0.time_ <= slot11 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot12 = 0.2

			if slot11 <= uv0.time_ and uv0.time_ < slot11 + slot12 then
				slot13 = (uv0.time_ - slot11) / slot12

				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot11 + slot12 and uv0.time_ < slot11 + slot12 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = false
			end

			if uv0.actors_["10025ui_story"] == nil then
				slot14 = Object.Instantiate(Asset.Load("Char/" .. slot13), uv0.stage_.transform)
				slot14.name = slot13
				slot14.transform.localPosition = Vector3.New(0, 100, 0)
				uv0.actors_[slot13] = slot14
				slot14:GetComponentInChildren(typeof(CharacterEffect)).enabled = true

				if GameObjectTools.GetOrAddComponent(slot14, typeof(DynamicBoneHelper)) then
					slot16:EnableDynamicBone(false)
				end

				uv0:ShowWeapon(slot15.transform, false)

				uv0.var_[slot13 .. "Animator"] = slot15.gameObject:GetComponent(typeof(UnityEngine.Animator))
				uv0.var_[slot13 .. "Animator"].applyRootMotion = true
				uv0.var_[slot13 .. "LipSync"] = slot15.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			if 2 < uv0.time_ and uv0.time_ <= slot15 + slot0 and uv0.var_.characterEffect10025ui_story == nil then
				uv0.var_.characterEffect10025ui_story = uv0.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot16 = 0.2

			if slot15 <= uv0.time_ and uv0.time_ < slot15 + slot16 then
				if uv0.var_.characterEffect10025ui_story then
					uv0.var_.characterEffect10025ui_story.fillFlat = true
					uv0.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot15) / slot16)
				end
			end

			if uv0.time_ >= slot15 + slot16 and uv0.time_ < slot15 + slot16 + slot0 and uv0.var_.characterEffect10025ui_story then
				uv0.var_.characterEffect10025ui_story.fillFlat = true
				uv0.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			if 4 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot19 = 0.001

			if slot18 <= uv0.time_ and uv0.time_ < slot18 + slot19 then
				slot17.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (uv0.time_ - slot18) / slot19)
				slot23 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot23.x, slot23.y, slot23.z)
				slot24 = slot17.localEulerAngles
				slot24.z = 0
				slot24.x = 0
				slot17.localEulerAngles = slot24
			end

			if uv0.time_ >= slot18 + slot19 and uv0.time_ < slot18 + slot19 + slot0 then
				slot17.localPosition = Vector3.New(-0.7, -1, -6)
				slot22 = manager.ui.mainCamera.transform.position - slot17.position
				slot17.forward = Vector3.New(slot22.x, slot22.y, slot22.z)
				slot23 = slot17.localEulerAngles
				slot23.z = 0
				slot23.x = 0
				slot17.localEulerAngles = slot23
			end

			if 4 < uv0.time_ and uv0.time_ <= slot21 + slot0 then
				uv0.var_.moveOldPos10025ui_story = uv0.actors_["10025ui_story"].transform.localPosition
			end

			slot22 = 0.001

			if slot21 <= uv0.time_ and uv0.time_ < slot21 + slot22 then
				slot20.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (uv0.time_ - slot21) / slot22)
				slot26 = manager.ui.mainCamera.transform.position - slot20.position
				slot20.forward = Vector3.New(slot26.x, slot26.y, slot26.z)
				slot27 = slot20.localEulerAngles
				slot27.z = 0
				slot27.x = 0
				slot20.localEulerAngles = slot27
			end

			if uv0.time_ >= slot21 + slot22 and uv0.time_ < slot21 + slot22 + slot0 then
				slot20.localPosition = Vector3.New(0.7, -1.1, -5.9)
				slot25 = manager.ui.mainCamera.transform.position - slot20.position
				slot20.forward = Vector3.New(slot25.x, slot25.y, slot25.z)
				slot26 = slot20.localEulerAngles
				slot26.z = 0
				slot26.x = 0
				slot20.localEulerAngles = slot26
			end

			slot24 = 0.266666666666667

			if 0 < uv0.time_ and uv0.time_ <= slot23 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot26 = 0.6

			if 0.4 < uv0.time_ and uv0.time_ <= slot25 + slot0 then
				uv0:AudioAction("play", "music", "bgm_story_scheme", "bgm_story_scheme", "bgm_story_scheme.awb")
			end

			if uv0.frameCnt_ <= 1 then
				uv0.dialog_:SetActive(false)
			end

			slot28 = 0.55

			if 4 < uv0.time_ and uv0.time_ <= slot27 + slot0 then
				uv0.talkMaxDuration = 0

				uv0.dialog_:SetActive(true)

				slot29 = LeanTween.value(uv0.dialog_, 0, 1, 0.3)

				slot29:setOnUpdate(LuaHelper.FloatAction(function (slot0)
					uv0.dialogCg_.alpha = slot0
				end))
				slot29:setOnComplete(System.Action(function ()
					LeanTween.cancel(uv0.dialog_)
					uv1:setOnUpdate(nil):setOnComplete(nil)
				end))

				uv0.duration_ = uv0.duration_ + 0.3

				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot32 = uv0:FormatText(uv0:GetWordFromCfg(116381029).content)
				uv0.text_.text = slot32

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (22 <= 0 and slot28 or slot28 * utf8.len(slot32) / slot33) > 0 and slot28 < slot35 then
					uv0.talkMaxDuration = slot35

					if uv0.duration_ < slot35 + slot27 + 0.3 then
						uv0.duration_ = slot35 + slot27
					end
				end

				uv0.text_.text = slot32
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381029", "story_v_out_116381.awb") / 1000 + slot27 then
						uv0.duration_ = slot36 + slot27
					end

					if slot31.prefab_name ~= "" and uv0.actors_[slot31.prefab_name] ~= nil then
						slot37 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot31.prefab_name].transform, "story_v_out_116381", "116381029", "story_v_out_116381.awb")

						uv0:RecordAudio("116381029", slot37)
						uv0:RecordAudio("116381029", slot37)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381029", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381029", "story_v_out_116381.awb")
				end

				uv0:RecordContent(uv0.text_.text)
			end

			slot28 = math.max(slot28, uv0.talkMaxDuration)

			if slot27 + 0.3 <= uv0.time_ and uv0.time_ < slot27 + slot28 then
				uv0.typewritter.percent = (uv0.time_ - slot27) / slot28

				uv0.typewritter:SetDirty()
			end

			if uv0.time_ >= slot27 + slot28 and uv0.time_ < slot27 + slot28 + slot0 then
				uv0.typewritter.percent = 1

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(true)
			end
		end
	end,
	Play116381030 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381030
		slot1.duration_ = 4.066

		if ({
			zh = 4.066,
			ja = 3.433
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381031(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot5 = 0.001

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot3.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(-0.7, -1, -6), (uv0.time_ - slot4) / slot5)
				slot9 = manager.ui.mainCamera.transform.position - slot3.position
				slot3.forward = Vector3.New(slot9.x, slot9.y, slot9.z)
				slot10 = slot3.localEulerAngles
				slot10.z = 0
				slot10.x = 0
				slot3.localEulerAngles = slot10
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 then
				slot3.localPosition = Vector3.New(-0.7, -1, -6)
				slot8 = manager.ui.mainCamera.transform.position - slot3.position
				slot3.forward = Vector3.New(slot8.x, slot8.y, slot8.z)
				slot9 = slot3.localEulerAngles
				slot9.z = 0
				slot9.x = 0
				slot3.localEulerAngles = slot9
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 then
				uv0.var_.moveOldPos10025ui_story = uv0.actors_["10025ui_story"].transform.localPosition
			end

			slot8 = 0.001

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot6.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10025ui_story, Vector3.New(0.7, -1.1, -5.9), (uv0.time_ - slot7) / slot8)
				slot12 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot12.x, slot12.y, slot12.z)
				slot13 = slot6.localEulerAngles
				slot13.z = 0
				slot13.x = 0
				slot6.localEulerAngles = slot13
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 then
				slot6.localPosition = Vector3.New(0.7, -1.1, -5.9)
				slot11 = manager.ui.mainCamera.transform.position - slot6.position
				slot6.forward = Vector3.New(slot11.x, slot11.y, slot11.z)
				slot12 = slot6.localEulerAngles
				slot12.z = 0
				slot12.x = 0
				slot6.localEulerAngles = slot12
			end

			slot10 = 0.45

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381030).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381030", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381030", "story_v_out_116381.awb")

						uv0:RecordAudio("116381030", slot18)
						uv0:RecordAudio("116381030", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381030", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381030", "story_v_out_116381.awb")
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
	Play116381031 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381031
		slot1.duration_ = 4.333

		if ({
			zh = 4.333,
			ja = 2.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381032(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect10025ui_story == nil then
				uv0.var_.characterEffect10025ui_story = uv0.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect10025ui_story then
					uv0.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect10025ui_story then
				uv0.var_.characterEffect10025ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = true
					uv0.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = true
				uv0.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			slot10 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381031).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381031", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381031", "story_v_out_116381.awb")

						uv0:RecordAudio("116381031", slot18)
						uv0:RecordAudio("116381031", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381031", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381031", "story_v_out_116381.awb")
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
	Play116381032 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381032
		slot1.duration_ = 6.766

		if ({
			zh = 6.766,
			ja = 4.033
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381033(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3203cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				slot6 = (uv0.time_ - slot4) / slot5

				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = false
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10025ui_story == nil then
				uv0.var_.characterEffect10025ui_story = uv0.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				if uv0.var_.characterEffect10025ui_story then
					uv0.var_.characterEffect10025ui_story.fillFlat = true
					uv0.var_.characterEffect10025ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot7) / slot8)
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10025ui_story then
				uv0.var_.characterEffect10025ui_story.fillFlat = true
				uv0.var_.characterEffect10025ui_story.fillRatio = 0.5
			end

			slot10 = 0.525

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381032).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (21 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381032", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381032", "story_v_out_116381.awb")

						uv0:RecordAudio("116381032", slot18)
						uv0:RecordAudio("116381032", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381032", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381032", "story_v_out_116381.awb")
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
	Play116381033 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381033
		slot1.duration_ = 2.266

		if ({
			zh = 2.266,
			ja = 1.999999999999
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381034(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/story10025/story10025action/10025action4_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10025ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2102cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot5 = 0.2

			if slot4 <= uv0.time_ and uv0.time_ < slot4 + slot5 then
				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = true
					uv0.var_.characterEffect10024ui_story.fillRatio = Mathf.Lerp(0, 0.5, (uv0.time_ - slot4) / slot5)
				end
			end

			if uv0.time_ >= slot4 + slot5 and uv0.time_ < slot4 + slot5 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = true
				uv0.var_.characterEffect10024ui_story.fillRatio = 0.5
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10025ui_story == nil then
				uv0.var_.characterEffect10025ui_story = uv0.actors_["10025ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10025ui_story then
					uv0.var_.characterEffect10025ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10025ui_story then
				uv0.var_.characterEffect10025ui_story.fillFlat = false
			end

			slot10 = 0.125

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381033).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381033", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381033", "story_v_out_116381.awb")

						uv0:RecordAudio("116381033", slot18)
						uv0:RecordAudio("116381033", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381033", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381033", "story_v_out_116381.awb")
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
	Play116381034 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381034
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381035(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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
				uv0.var_.moveOldPos10025ui_story = uv0.actors_["10025ui_story"].transform.localPosition
			end

			slot6 = 0.001

			if slot5 <= uv0.time_ and uv0.time_ < slot5 + slot6 then
				slot4.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10025ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot5) / slot6)
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

			slot8 = 1.3

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

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(116381034).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (52 <= 0 and slot8 or slot8 * utf8.len(slot10) / slot11) > 0 and slot8 < slot13 then
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
	Play116381035 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381035
		slot1.duration_ = 10.6

		if ({
			zh = 10.6,
			ja = 9.933
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381036(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.15

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381035).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381035", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381035", "story_v_out_116381.awb")

						uv0:RecordAudio("116381035", slot10)
						uv0:RecordAudio("116381035", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381035", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381035", "story_v_out_116381.awb")
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
	Play116381036 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381036
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381037(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.5

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			slot4 = 0.5

			if 0.333333333333333 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0:AudioAction("play", "effect", "se_story_16", "se_story_16_gun", "")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			slot7 = 0.6

			if slot6 <= uv0.time_ and uv0.time_ < slot6 + slot7 then
				slot9, slot10 = math.modf((uv0.time_ - slot6) / 0.066)
				slot5.localPosition = Vector3.New(slot10 * 0.13, slot10 * 0.13, slot10 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot6 + slot7 and uv0.time_ < slot6 + slot7 + slot0 then
				slot5.localPosition = uv0.var_.shakeOldPos
			end

			if 0.7 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.var_.shakeOldPos = manager.ui.mainCamera.transform.localPosition
			end

			slot10 = 0.6

			if slot9 <= uv0.time_ and uv0.time_ < slot9 + slot10 then
				slot12, slot13 = math.modf((uv0.time_ - slot9) / 0.066)
				slot8.localPosition = Vector3.New(slot13 * 0.13, slot13 * 0.13, slot13 * 0.13) + uv0.var_.shakeOldPos
			end

			if uv0.time_ >= slot9 + slot10 and uv0.time_ < slot9 + slot10 + slot0 then
				slot8.localPosition = uv0.var_.shakeOldPos
			end

			if 0 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot11 + 1.3 and uv0.time_ < slot11 + slot12 + slot0 then
				uv0.allBtn_.enabled = true
			end

			slot14 = 0.1

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

				slot16 = uv0:FormatText(uv0:GetWordFromCfg(116381036).content)
				uv0.text_.text = slot16

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot14 or slot14 * utf8.len(slot16) / slot17) > 0 and slot14 < slot19 then
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
	Play116381037 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381037
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381038(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381037).content)
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
	Play116381038 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381038
		slot1.duration_ = 8.333

		if ({
			zh = 8.2,
			ja = 8.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381039(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0103cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = false
			end

			slot10 = 0.7

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381038).content)
				uv0.text_.text = slot13

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (28 <= 0 and slot10 or slot10 * utf8.len(slot13) / slot14) > 0 and slot10 < slot16 then
					uv0.talkMaxDuration = slot16

					if uv0.duration_ < slot16 + slot9 then
						uv0.duration_ = slot16 + slot9
					end
				end

				uv0.text_.text = slot13
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381038", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381038", "story_v_out_116381.awb")

						uv0:RecordAudio("116381038", slot18)
						uv0:RecordAudio("116381038", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381038", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381038", "story_v_out_116381.awb")
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
	Play116381039 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381039
		slot1.duration_ = 5.066

		if ({
			zh = 4.866,
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
				uv0:Play116381040(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024actionlink/10024action462")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			slot4 = 0.375

			if 0 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(116381039).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (15 <= 0 and slot4 or slot4 * utf8.len(slot7) / slot8) > 0 and slot4 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381039", "story_v_out_116381.awb") / 1000 + slot3 then
						uv0.duration_ = slot11 + slot3
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_116381", "116381039", "story_v_out_116381.awb")

						uv0:RecordAudio("116381039", slot12)
						uv0:RecordAudio("116381039", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381039", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381039", "story_v_out_116381.awb")
				end

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
	Play116381040 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381040
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381041(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			slot5 = 0.675

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(116381040).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (27 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
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
	Play116381041 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381041
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381042(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.825

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381041).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (33 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381042 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381042
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381043(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.3

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381042).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (12 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381043 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381043
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381044(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381043).content)
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
	Play116381044 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381044
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381045(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.8

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381044).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (32 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381045 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381045
		slot1.duration_ = 12.3

		if ({
			zh = 7.966,
			ja = 12.3
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381046(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.775

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10024")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381045).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (30 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381045", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381045", "story_v_out_116381.awb")

						uv0:RecordAudio("116381045", slot10)
						uv0:RecordAudio("116381045", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381045", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381045", "story_v_out_116381.awb")
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
	Play116381046 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381046
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381047(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381046).content)
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
	Play116381047 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381047
		slot1.duration_ = 7.1

		if ({
			zh = 4.166,
			ja = 7.1
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381048(uv1)
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

			slot7 = 0.475

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[327].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_1028")

				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(116381047).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (19 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381047", "story_v_out_116381.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_116381", "116381047", "story_v_out_116381.awb")

						uv0:RecordAudio("116381047", slot15)
						uv0:RecordAudio("116381047", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381047", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381047", "story_v_out_116381.awb")
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
	Play116381048 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381048
		slot1.duration_ = 3.233

		if ({
			zh = 3.2,
			ja = 3.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381049(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3103cva")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot7 + slot0 and uv0.var_.characterEffect10024ui_story == nil then
				uv0.var_.characterEffect10024ui_story = uv0.actors_["10024ui_story"]:GetComponentInChildren(typeof(CharacterEffect))
			end

			slot8 = 0.2

			if slot7 <= uv0.time_ and uv0.time_ < slot7 + slot8 then
				slot9 = (uv0.time_ - slot7) / slot8

				if uv0.var_.characterEffect10024ui_story then
					uv0.var_.characterEffect10024ui_story.fillFlat = false
				end
			end

			if uv0.time_ >= slot7 + slot8 and uv0.time_ < slot7 + slot8 + slot0 and uv0.var_.characterEffect10024ui_story then
				uv0.var_.characterEffect10024ui_story.fillFlat = false
			end

			slot10 = 0.25

			if 0 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot13 = uv0:FormatText(uv0:GetWordFromCfg(116381048).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381048", "story_v_out_116381.awb") / 1000 + slot9 then
						uv0.duration_ = slot17 + slot9
					end

					if slot12.prefab_name ~= "" and uv0.actors_[slot12.prefab_name] ~= nil then
						slot18 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot12.prefab_name].transform, "story_v_out_116381", "116381048", "story_v_out_116381.awb")

						uv0:RecordAudio("116381048", slot18)
						uv0:RecordAudio("116381048", slot18)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381048", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381048", "story_v_out_116381.awb")
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
	Play116381049 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381049
		slot1.duration_ = 2.8

		if ({
			zh = 2.2,
			ja = 2.8
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381050(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action6_2")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			slot7 = 0.15

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(116381049).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381049", "story_v_out_116381.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_116381", "116381049", "story_v_out_116381.awb")

						uv0:RecordAudio("116381049", slot15)
						uv0:RecordAudio("116381049", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381049", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381049", "story_v_out_116381.awb")
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
	Play116381050 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381050
		slot1.duration_ = 9.1

		if ({
			zh = 9.1,
			ja = 7.233
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381051(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, -1, -6), (uv0.time_ - slot2) / slot3)
				slot7 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot7.x, slot7.y, slot7.z)
				slot8 = slot1.localEulerAngles
				slot8.z = 0
				slot8.x = 0
				slot1.localEulerAngles = slot8
			end

			if uv0.time_ >= slot2 + slot3 and uv0.time_ < slot2 + slot3 + slot0 then
				slot1.localPosition = Vector3.New(0, -1, -6)
				slot6 = manager.ui.mainCamera.transform.position - slot1.position
				slot1.forward = Vector3.New(slot6.x, slot6.y, slot6.z)
				slot7 = slot1.localEulerAngles
				slot7.z = 0
				slot7.x = 0
				slot1.localEulerAngles = slot7
			end

			if 0 < uv0.time_ and uv0.time_ <= slot4 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/story10024/story10024action/10024action1_1")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot5 + slot0 then
				uv0:PlayTimeline("10024ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0204cva")
			end

			slot7 = 1.025

			if 0 < uv0.time_ and uv0.time_ <= slot6 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[332].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot10 = uv0:FormatText(uv0:GetWordFromCfg(116381050).content)
				uv0.text_.text = slot10

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot7 or slot7 * utf8.len(slot10) / slot11) > 0 and slot7 < slot13 then
					uv0.talkMaxDuration = slot13

					if uv0.duration_ < slot13 + slot6 then
						uv0.duration_ = slot13 + slot6
					end
				end

				uv0.text_.text = slot10
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381050", "story_v_out_116381.awb") / 1000 + slot6 then
						uv0.duration_ = slot14 + slot6
					end

					if slot9.prefab_name ~= "" and uv0.actors_[slot9.prefab_name] ~= nil then
						slot15 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot9.prefab_name].transform, "story_v_out_116381", "116381050", "story_v_out_116381.awb")

						uv0:RecordAudio("116381050", slot15)
						uv0:RecordAudio("116381050", slot15)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381050", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381050", "story_v_out_116381.awb")
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
	Play116381051 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381051
		slot1.duration_ = 6.333

		if ({
			zh = 5.1,
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
				uv0:Play116381052(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.var_.moveOldPos10024ui_story = uv0.actors_["10024ui_story"].transform.localPosition
			end

			slot3 = 0.001

			if slot2 <= uv0.time_ and uv0.time_ < slot2 + slot3 then
				slot1.localPosition = Vector3.Lerp(uv0.var_.moveOldPos10024ui_story, Vector3.New(0, 100, 0), (uv0.time_ - slot2) / slot3)
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

			slot5 = 0.35

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

				slot7 = uv0:FormatText(uv0:GetWordFromCfg(116381051).content)
				uv0.text_.text = slot7

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (14 <= 0 and slot5 or slot5 * utf8.len(slot7) / slot8) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot4 then
						uv0.duration_ = slot10 + slot4
					end
				end

				uv0.text_.text = slot7
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381051", "story_v_out_116381.awb") / 1000 + slot4 then
						uv0.duration_ = slot11 + slot4
					end

					if slot6.prefab_name ~= "" and uv0.actors_[slot6.prefab_name] ~= nil then
						slot12 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot6.prefab_name].transform, "story_v_out_116381", "116381051", "story_v_out_116381.awb")

						uv0:RecordAudio("116381051", slot12)
						uv0:RecordAudio("116381051", slot12)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381051", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381051", "story_v_out_116381.awb")
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
	Play116381052 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381052
		slot1.duration_ = 9.833

		if ({
			zh = 9.833,
			ja = 5
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381053(uv1)
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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381052).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381052", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot8 + slot1
					end

					if slot3.prefab_name ~= "" and uv0.actors_[slot3.prefab_name] ~= nil then
						slot9 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot3.prefab_name].transform, "story_v_out_116381", "116381052", "story_v_out_116381.awb")

						uv0:RecordAudio("116381052", slot9)
						uv0:RecordAudio("116381052", slot9)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381052", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381052", "story_v_out_116381.awb")
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
	Play116381053 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381053
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381054(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.025

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381053).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (41 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381054 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381054
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381055(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.275

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381054).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (11 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381055 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381055
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381056(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.1

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381055).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (4 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381056 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381056
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381057(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.175

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381056).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (7 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
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
	Play116381057 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381057
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381058(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.05

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381057).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381058 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381058
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381059(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 1.05

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

				slot4 = uv0:FormatText(uv0:GetWordFromCfg(116381058).content)
				uv0.text_.text = slot4

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (42 <= 0 and slot2 or slot2 * utf8.len(slot4) / slot5) > 0 and slot2 < slot7 then
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
	Play116381059 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381059
		slot1.duration_ = 8.866

		if ({
			zh = 8.3,
			ja = 8.866
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381060(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.625

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381059).content)
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

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381059", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381059", "story_v_out_116381.awb")

						uv0:RecordAudio("116381059", slot10)
						uv0:RecordAudio("116381059", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381059", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381059", "story_v_out_116381.awb")
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
	Play116381060 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381060
		slot1.duration_ = 5

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381061(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.2

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[344].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, false)
				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381060).content)
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
	Play116381061 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381061
		slot1.duration_ = 7.333

		if ({
			zh = 3.866,
			ja = 7.333
		})[manager.audio:GetLocalizationFlag()] ~= nil then
			slot1.duration_ = slot2[slot3]
		end

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381062(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			slot2 = 0.325

			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0
				uv0.dialogCg_.alpha = 1

				uv0.dialog_:SetActive(true)
				SetActive(uv0.leftNameGo_, true)

				uv0.leftNameTxt_.text = uv0:FormatText(StoryNameCfg[328].name)

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(uv0.leftNameTxt_.transform)

				uv0.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				uv0.contentRectCom_.sizeDelta = Vector2(1644, 265)

				uv0:RecordName(uv0.leftNameTxt_.text)
				SetActive(uv0.iconTrs_.gameObject, true)
				uv0.iconController_:SetSelectedState("hero")

				uv0.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10025")

				uv0.callingController_:SetSelectedState("normal")

				slot5 = uv0:FormatText(uv0:GetWordFromCfg(116381061).content)
				uv0.text_.text = slot5

				LuaForUtil.ClearLinePrefixSymbol(uv0.text_)

				if (13 <= 0 and slot2 or slot2 * utf8.len(slot5) / slot6) > 0 and slot2 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end

				uv0.text_.text = slot5
				uv0.typewritter.percent = 0

				uv0.typewritter:SetDirty()
				uv0:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") ~= 0 then
					if uv0.duration_ < manager.audio:GetVoiceLength("story_v_out_116381", "116381061", "story_v_out_116381.awb") / 1000 + slot1 then
						uv0.duration_ = slot9 + slot1
					end

					if slot4.prefab_name ~= "" and uv0.actors_[slot4.prefab_name] ~= nil then
						slot10 = LuaForUtil.PlayVoiceWithCriLipsync(uv0.actors_[slot4.prefab_name].transform, "story_v_out_116381", "116381061", "story_v_out_116381.awb")

						uv0:RecordAudio("116381061", slot10)
						uv0:RecordAudio("116381061", slot10)
					else
						uv0:AudioAction("play", "voice", "story_v_out_116381", "116381061", "story_v_out_116381.awb")
					end

					uv0:RecordHistoryTalkVoice("story_v_out_116381", "116381061", "story_v_out_116381.awb")
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
	Play116381062 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381062
		slot1.duration_ = 10.542999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381063(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 2 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				slot2 = manager.ui.mainCamera.transform.localPosition
				slot4 = uv0.bgs_.STblack
				slot4.transform.localPosition = Vector3.New(0, 0, 10) + Vector3.New(slot2.x, slot2.y, 0)
				slot4.transform.localEulerAngles = Vector3(0, 0, 0)

				if slot4:GetComponent("SpriteRenderer") and slot5.sprite then
					slot8 = manager.ui.mainCameraCom_
					slot9 = 2 * (slot4.transform.localPosition - slot2).z * Mathf.Tan(slot8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					slot15 = slot9 * slot8.aspect / slot5.sprite.bounds.size.x > slot9 / slot5.sprite.bounds.size.y and slot13 or slot14
					slot4.transform.localScale = Vector3.New(slot15, slot15, 0)
				end

				for slot9, slot10 in pairs(uv0.bgs_) do
					if slot9 ~= "STblack" then
						slot10.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			if 2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381062).content)

				LuaForUtil.ClearLinePrefixSymbol(uv0.fswt_)

				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()

				uv0.typewritterCharCountI18N = 0

				uv0:ShowNextGo(false)
			end

			if 2.01666666666667 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot4 = 44
			slot5 = 2.93333333333333
			slot8, slot9 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 1)

			if slot3 < uv0.time_ and uv0.time_ <= slot3 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot4 <= 0 and slot5 or slot5 * (slot9 - uv0.typewritterCharCountI18N) / slot4) > 0 and slot5 < slot10 then
					uv0.talkMaxDuration = slot10

					if uv0.duration_ < slot10 + slot3 then
						uv0.duration_ = slot10 + slot3
					end
				end
			end

			slot10 = math.max(2.93333333333333, uv0.talkMaxDuration)

			if slot3 <= uv0.time_ and uv0.time_ < slot3 + slot10 then
				uv0.fswtw_.percent = Mathf.Lerp(uv0.var_.oldValueTypewriter, slot8, (uv0.time_ - slot3) / slot10)
				uv0.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				uv0.fswtw_:SetDirty()
			end

			if uv0.time_ >= slot3 + slot10 and uv0.time_ < slot3 + slot10 + slot0 then
				uv0.fswtw_.percent = slot8

				uv0.fswtw_:SetDirty()
				uv0:ShowNextGo(true)

				uv0.typewritterCharCountI18N = slot9
			end

			slot11 = 2

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381062", "story_v_out_116381.awb") / 1000 > 0 and 8.543 < slot13 and uv0.duration_ < slot13 + slot11 then
				slot12 = slot13
				uv0.duration_ = slot13 + slot11
			end

			if slot11 < uv0.time_ and uv0.time_ <= slot11 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381062", "story_v_out_116381.awb")
			end

			slot15 = 0.266666666666667

			if 2 < uv0.time_ and uv0.time_ <= slot14 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot17 = 0.6

			if 2.4 < uv0.time_ and uv0.time_ <= slot16 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story", "bgm_activity_1_6_story_story.awb")
			end

			slot19 = 0.425

			if 2.575 < uv0.time_ and uv0.time_ <= slot18 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_6_story_story", "corg", "bgm_activity_1_6_story_story.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot20 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot21 = 2

			if slot20 <= uv0.time_ and uv0.time_ < slot20 + slot21 then
				slot23 = Color.New(0, 0, 0)
				slot23.a = Mathf.Lerp(0, 1, (uv0.time_ - slot20) / slot21)
				uv0.mask_.color = slot23
			end

			if uv0.time_ >= slot20 + slot21 and uv0.time_ < slot20 + slot21 + slot0 then
				slot22 = Color.New(0, 0, 0)
				slot22.a = 1
				uv0.mask_.color = slot22
			end

			if 2 < uv0.time_ and uv0.time_ <= slot22 + slot0 then
				uv0.mask_.enabled = true
				uv0.mask_.raycastTarget = true

				uv0:SetGaussion(false)
			end

			slot23 = 2

			if slot22 <= uv0.time_ and uv0.time_ < slot22 + slot23 then
				slot25 = Color.New(0, 0, 0)
				slot25.a = Mathf.Lerp(1, 0, (uv0.time_ - slot22) / slot23)
				uv0.mask_.color = slot25
			end

			if uv0.time_ >= slot22 + slot23 and uv0.time_ < slot22 + slot23 + slot0 then
				slot24 = Color.New(0, 0, 0)
				uv0.mask_.enabled = false
				slot24.a = 0
				uv0.mask_.color = slot24
			end

			if 2 < uv0.time_ and uv0.time_ <= slot24 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot24 + 2.95 and uv0.time_ < slot24 + slot25 + slot0 then
				uv0.allBtn_.enabled = true
			end

			if 1.96666666666667 < uv0.time_ and uv0.time_ <= slot26 + slot0 then
				uv0.screenFilterGo_:SetActive(false)
			end

			slot27 = 0.0333333333333332

			if slot26 <= uv0.time_ and uv0.time_ < slot26 + slot27 then
				uv0.screenFilterEffect_.weight = Mathf.Lerp(1, 0, (uv0.time_ - slot26) / slot27)
			end

			if uv0.time_ >= slot26 + slot27 and uv0.time_ < slot26 + slot27 + slot0 then
				uv0.screenFilterEffect_.weight = 0
			end
		end
	end,
	Play116381063 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381063
		slot1.duration_ = 8.081999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381064(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 26
			slot3 = 1.73333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.73333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381063", "story_v_out_116381.awb") / 1000 > 0 and 8.082 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381063", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.73333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381064 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381064
		slot1.duration_ = 7.437999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381065(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 34
			slot3 = 2.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381064", "story_v_out_116381.awb") / 1000 > 0 and 7.438 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381064", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381065 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381065
		slot1.duration_ = 5.846999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381066(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 26
			slot3 = 1.73333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.73333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381065", "story_v_out_116381.awb") / 1000 > 0 and 5.847 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381065", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.73333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381066 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381066
		slot1.duration_ = 1.437999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381067(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 12
			slot3 = 0.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381066", "story_v_out_116381.awb") / 1000 > 0 and 1.438 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381066", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381067 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381067
		slot1.duration_ = 7.734999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381068(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 36
			slot3 = 2.4
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381062).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.4, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381067", "story_v_out_116381.awb") / 1000 > 0 and 7.735 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381067", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.4 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381068 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381068
		slot1.duration_ = 5.256999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381069(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381068).content)

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

			slot3 = 16
			slot4 = 1.06666666666667
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(1.06666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381068", "story_v_out_116381.awb") / 1000 > 0 and 5.257 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381068", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 1.08333333333333 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381069 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381069
		slot1.duration_ = 0.749999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381070(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 7
			slot3 = 0.466666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.466666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381069", "story_v_out_116381.awb") / 1000 > 0 and 0.75 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381069", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.466666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381070 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381070
		slot1.duration_ = 3.303999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381071(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 19
			slot3 = 1.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381070", "story_v_out_116381.awb") / 1000 > 0 and 3.304 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381070", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381071 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381071
		slot1.duration_ = 10.213999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381072(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 48
			slot3 = 3.2
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.2, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381071", "story_v_out_116381.awb") / 1000 > 0 and 10.214 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381071", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.2 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381072 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381072
		slot1.duration_ = 13.121999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381073(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 54
			slot3 = 3.6
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.6, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381072", "story_v_out_116381.awb") / 1000 > 0 and 13.122 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381072", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.6 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381073 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381073
		slot1.duration_ = 11.522999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381074(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 54
			slot3 = 3.6
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381068).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.6, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381073", "story_v_out_116381.awb") / 1000 > 0 and 11.523 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381073", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.6 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381074 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381074
		slot1.duration_ = 11.025999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381075(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381074).content)

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

			slot3 = 43
			slot4 = 2.86666666666667
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(2.86666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381074", "story_v_out_116381.awb") / 1000 > 0 and 11.026 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381074", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 2.88333333333333 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381075 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381075
		slot1.duration_ = 11.273999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381076(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 58
			slot3 = 3.86666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.86666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381075", "story_v_out_116381.awb") / 1000 > 0 and 11.274 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381075", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.86666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381076 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381076
		slot1.duration_ = 3.403999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381077(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 12
			slot3 = 0.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381076", "story_v_out_116381.awb") / 1000 > 0 and 3.404 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381076", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381077 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381077
		slot1.duration_ = 8.781999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381078(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 45
			slot3 = 3
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381077", "story_v_out_116381.awb") / 1000 > 0 and 8.782 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381077", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381078 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381078
		slot1.duration_ = 5.985999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381079(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 24
			slot3 = 1.6
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.6, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381078", "story_v_out_116381.awb") / 1000 > 0 and 5.986 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381078", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.6 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381079 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381079
		slot1.duration_ = 13.092999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381080(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 57
			slot3 = 3.8
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381074).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381079", "story_v_out_116381.awb") / 1000 > 0 and 13.093 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381079", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.8 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381080 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381080
		slot1.duration_ = 5.215999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381081(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381080).content)

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

			slot3 = 27
			slot4 = 1.8
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(1.8, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381080", "story_v_out_116381.awb") / 1000 > 0 and 5.216 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381080", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 1.81666666666667 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381081 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381081
		slot1.duration_ = 5.710999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381082(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 25
			slot3 = 1.66666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.66666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381081", "story_v_out_116381.awb") / 1000 > 0 and 5.711 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381081", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.66666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381082 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381082
		slot1.duration_ = 6.695999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381083(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 34
			slot3 = 2.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381082", "story_v_out_116381.awb") / 1000 > 0 and 6.696 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381082", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381083 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381083
		slot1.duration_ = 8.797999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381084(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 43
			slot3 = 2.86666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.86666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381083", "story_v_out_116381.awb") / 1000 > 0 and 8.798 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381083", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.86666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381084 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381084
		slot1.duration_ = 5.749999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381085(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 19
			slot3 = 1.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381084", "story_v_out_116381.awb") / 1000 > 0 and 5.75 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381084", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.33333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381085 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381085
		slot1.duration_ = 10.581999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381086(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 51
			slot3 = 3.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381080).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.26666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381085", "story_v_out_116381.awb") / 1000 > 0 and 10.582 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381085", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 3.26666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381086 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381086
		slot1.duration_ = 3.713999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381087(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(116381086).content)

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

			slot3 = 18
			slot4 = 1.2
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(1.2, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381086", "story_v_out_116381.awb") / 1000 > 0 and 3.714 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381086", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot13 + 1.21666666666667 and uv0.time_ < slot13 + slot14 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381087 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381087
		slot1.duration_ = 6.922999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381088(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 36
			slot3 = 2.4
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 2)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.4, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381087", "story_v_out_116381.awb") / 1000 > 0 and 6.923 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381087", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 2.4 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381088 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381088
		slot1.duration_ = 3.366666666666

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381089(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 16
			slot3 = 1.06666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.06666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381088", "story_v_out_116381.awb") / 1000 > 0 and 3.098 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381088", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.06666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381089 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381089
		slot1.duration_ = 4.834999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381090(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 17
			slot3 = 1.13333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.13333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381089", "story_v_out_116381.awb") / 1000 > 0 and 4.835 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381089", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.13333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381090 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381090
		slot1.duration_ = 6.233999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play116381091(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 22
			slot3 = 1.46666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.46666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381090", "story_v_out_116381.awb") / 1000 > 0 and 6.234 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381090", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 1.46666666666667 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	Play116381091 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 116381091
		slot1.duration_ = 3.033333333332

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
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 11
			slot3 = 0.733333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(116381086).content), 6)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(0.733333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_116381", "116381091", "story_v_out_116381.awb") / 1000 > 0 and 2.753 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_116381", "116381091", "story_v_out_116381.awb")
			end

			if 0 < uv0.time_ and uv0.time_ <= slot12 + slot0 then
				uv0.allBtn_.enabled = false
			end

			if uv0.time_ >= slot12 + 0.733333333333333 and uv0.time_ < slot12 + slot13 + slot0 then
				uv0.allBtn_.enabled = true
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/STblack",
		"Assets/UIResources/UI_AB/TextureConfig/Background/SK0107",
		"Assets/UIResources/UI_AB/TextureConfig/Background/SK0112",
		"Assets/UIResources/UI_AB/TextureConfig/Background/SK0201",
		"Assets/UIResources/UI_AB/TextureConfig/Background/SK0106",
		"Assets/UIResources/UI_AB/TextureConfig/Background/SK0102",
		"Assets/UIResources/UI_AB/TextureConfig/Background/I05f"
	},
	voices = {
		"story_v_out_116381.awb"
	}
}
