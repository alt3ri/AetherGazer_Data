return {
	Play110031001 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031001
		slot1.duration_ = 4.262999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031002(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(110031001).content)

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

			slot3 = 24
			slot4 = 1.6
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031001).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(1.6, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031001", "story_v_out_110031.awb") / 1000 > 0 and 4.263 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031001", "story_v_out_110031.awb")
			end

			slot14 = 0.6

			if 0 < uv0.time_ and uv0.time_ <= slot13 + slot0 then
				uv0:AudioAction("play", "music", "ui_battle", "ui_battle_stopbgm", "")
			end

			slot16 = 1

			if 0.738461699336767 < uv0.time_ and uv0.time_ <= slot15 + slot0 then
				uv0:AudioAction("play", "music", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui", "bgm_activity_1_0_1_osiris_ui.awb")
			end
		end
	end,
	Play110031002 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031002
		slot1.duration_ = 8.640999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031003(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 52
			slot3 = 3.26666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031001).content), 2)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031002", "story_v_out_110031.awb") / 1000 > 0 and 8.641 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031002", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031003 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031003
		slot1.duration_ = 10.555999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031004(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 70
			slot3 = 4.66666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031001).content), 3)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(4.66666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031003", "story_v_out_110031.awb") / 1000 > 0 and 10.556 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031003", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031004 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031004
		slot1.duration_ = 5.555999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031005(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 35
			slot3 = 2.33333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031001).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(2.33333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031004", "story_v_out_110031.awb") / 1000 > 0 and 5.556 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031004", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031005 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031005
		slot1.duration_ = 4.857999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031006(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 28
			slot3 = 1.93333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031001).content), 5)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(1.93333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031005", "story_v_out_110031.awb") / 1000 > 0 and 4.858 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031005", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031006 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031006
		slot1.duration_ = 10.893999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031007(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.fswbg_:SetActive(true)
				uv0.dialog_:SetActive(false)

				uv0.fswtw_.percent = 0
				uv0.fswt_.text = uv0:FormatText(uv0:GetWordFromCfg(110031006).content)

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

			slot3 = 46
			slot4 = 3.06666666666667
			slot7, slot8 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031006).content), 1)

			if slot2 < uv0.time_ and uv0.time_ <= slot2 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot3 <= 0 and slot4 or slot4 * (slot8 - uv0.typewritterCharCountI18N) / slot3) > 0 and slot4 < slot9 then
					uv0.talkMaxDuration = slot9

					if uv0.duration_ < slot9 + slot2 then
						uv0.duration_ = slot9 + slot2
					end
				end
			end

			slot9 = math.max(3.06666666666667, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031006", "story_v_out_110031.awb") / 1000 > 0 and 10.894 < slot12 and uv0.duration_ < slot12 + slot10 then
				slot11 = slot12
				uv0.duration_ = slot12 + slot10
			end

			if slot10 < uv0.time_ and uv0.time_ <= slot10 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031006", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031007 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031007
		slot1.duration_ = 4.207999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031008(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 25
			slot3 = 1.66666666666667
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031006).content), 2)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031007", "story_v_out_110031.awb") / 1000 > 0 and 4.208 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031007", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031008 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031008
		slot1.duration_ = 14.095999999999

		SetActive(slot1.tipsGo_, false)

		function slot1.onSingleLineFinish_()
			uv0.onSingleLineUpdate_ = nil
			uv0.onSingleLineFinish_ = nil
			uv0.state_ = "waiting"
		end

		function slot1.playNext_(slot0)
			if slot0 == 1 then
				uv0:Play110031009(uv1)
			end
		end

		function slot1.onSingleLineUpdate_(slot0)
			if 0 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.var_.oldValueTypewriter = uv0.fswtw_.percent

				uv0:ShowNextGo(false)
			end

			slot2 = 62
			slot3 = 4.13333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031006).content), 3)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031008", "story_v_out_110031.awb") / 1000 > 0 and 14.096 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031008", "story_v_out_110031.awb")
			end
		end
	end,
	Play110031009 = function (slot0, slot1)
		slot1.time_ = 0
		slot1.frameCnt_ = 0
		slot1.state_ = "playing"
		slot1.curTalkId_ = 110031009
		slot1.duration_ = 14.788999999999

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

			slot2 = 56
			slot3 = 3.73333333333333
			slot6, slot7 = uv0:GetPercentByPara(uv0:FormatText(uv0:GetWordFromCfg(110031006).content), 4)

			if slot1 < uv0.time_ and uv0.time_ <= slot1 + slot0 then
				uv0.talkMaxDuration = 0

				if (slot2 <= 0 and slot3 or slot3 * (slot7 - uv0.typewritterCharCountI18N) / slot2) > 0 and slot3 < slot8 then
					uv0.talkMaxDuration = slot8

					if uv0.duration_ < slot8 + slot1 then
						uv0.duration_ = slot8 + slot1
					end
				end
			end

			slot8 = math.max(3.73333333333333, uv0.talkMaxDuration)

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

			if manager.audio:GetVoiceLength("story_v_out_110031", "110031009", "story_v_out_110031.awb") / 1000 > 0 and 14.789 < slot11 and uv0.duration_ < slot11 + slot9 then
				slot10 = slot11
				uv0.duration_ = slot11 + slot9
			end

			if slot9 < uv0.time_ and uv0.time_ <= slot9 + slot0 then
				uv0:AudioAction("play", "voice", "story_v_out_110031", "110031009", "story_v_out_110031.awb")
			end
		end
	end,
	assets = {},
	voices = {
		"story_v_out_110031.awb"
	}
}
