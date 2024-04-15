return {
	Play411051001 = function(arg_1_0, arg_1_1)
		arg_1_1.time_ = 0
		arg_1_1.frameCnt_ = 0
		arg_1_1.state_ = "playing"
		arg_1_1.curTalkId_ = 411051001
		arg_1_1.duration_ = 7

		SetActive(arg_1_1.tipsGo_, false)

		function arg_1_1.onSingleLineFinish_()
			arg_1_1.onSingleLineUpdate_ = nil
			arg_1_1.onSingleLineFinish_ = nil
			arg_1_1.state_ = "waiting"
		end

		function arg_1_1.playNext_(arg_3_0)
			if arg_3_0 == 1 then
				arg_1_0:Play411051002(arg_1_1)
			end
		end

		function arg_1_1.onSingleLineUpdate_(arg_4_0)
			local var_4_0 = "ST74"

			if arg_1_1.bgs_[var_4_0] == nil then
				local var_4_1 = Object.Instantiate(arg_1_1.paintGo_)

				var_4_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_4_0)
				var_4_1.name = var_4_0
				var_4_1.transform.parent = arg_1_1.stage_.transform
				var_4_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_1_1.bgs_[var_4_0] = var_4_1
			end

			local var_4_2 = 0

			if var_4_2 < arg_1_1.time_ and arg_1_1.time_ <= var_4_2 + arg_4_0 then
				local var_4_3 = manager.ui.mainCamera.transform.localPosition
				local var_4_4 = Vector3.New(0, 0, 10) + Vector3.New(var_4_3.x, var_4_3.y, 0)
				local var_4_5 = arg_1_1.bgs_.ST74

				var_4_5.transform.localPosition = var_4_4
				var_4_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_4_6 = var_4_5:GetComponent("SpriteRenderer")

				if var_4_6 and var_4_6.sprite then
					local var_4_7 = (var_4_5.transform.localPosition - var_4_3).z
					local var_4_8 = manager.ui.mainCameraCom_
					local var_4_9 = 2 * var_4_7 * Mathf.Tan(var_4_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_4_10 = var_4_9 * var_4_8.aspect
					local var_4_11 = var_4_6.sprite.bounds.size.x
					local var_4_12 = var_4_6.sprite.bounds.size.y
					local var_4_13 = var_4_10 / var_4_11
					local var_4_14 = var_4_9 / var_4_12
					local var_4_15 = var_4_14 < var_4_13 and var_4_13 or var_4_14

					var_4_5.transform.localScale = Vector3.New(var_4_15, var_4_15, 0)
				end

				for iter_4_0, iter_4_1 in pairs(arg_1_1.bgs_) do
					if iter_4_0 ~= "ST74" then
						iter_4_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_4_16 = 0

			if var_4_16 < arg_1_1.time_ and arg_1_1.time_ <= var_4_16 + arg_4_0 then
				arg_1_1.mask_.enabled = true
				arg_1_1.mask_.raycastTarget = true

				arg_1_1:SetGaussion(false)
			end

			local var_4_17 = 2

			if var_4_16 <= arg_1_1.time_ and arg_1_1.time_ < var_4_16 + var_4_17 then
				local var_4_18 = (arg_1_1.time_ - var_4_16) / var_4_17
				local var_4_19 = Color.New(0, 0, 0)

				var_4_19.a = Mathf.Lerp(1, 0, var_4_18)
				arg_1_1.mask_.color = var_4_19
			end

			if arg_1_1.time_ >= var_4_16 + var_4_17 and arg_1_1.time_ < var_4_16 + var_4_17 + arg_4_0 then
				local var_4_20 = Color.New(0, 0, 0)
				local var_4_21 = 0

				arg_1_1.mask_.enabled = false
				var_4_20.a = var_4_21
				arg_1_1.mask_.color = var_4_20
			end

			local var_4_22 = 0
			local var_4_23 = 0.366666666666667

			if var_4_22 < arg_1_1.time_ and arg_1_1.time_ <= var_4_22 + arg_4_0 then
				local var_4_24 = "play"
				local var_4_25 = "music"

				arg_1_1:AudioAction(var_4_24, var_4_25, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_4_26 = 1.23333333333333
			local var_4_27 = 0.766666666666667

			if var_4_26 < arg_1_1.time_ and arg_1_1.time_ <= var_4_26 + arg_4_0 then
				local var_4_28 = "play"
				local var_4_29 = "effect"

				arg_1_1:AudioAction(var_4_28, var_4_29, "se_story_131", "se_story_131__opendoor", "")
			end

			if arg_1_1.frameCnt_ <= 1 then
				arg_1_1.dialog_:SetActive(false)
			end

			local var_4_30 = 2
			local var_4_31 = 0.5

			if var_4_30 < arg_1_1.time_ and arg_1_1.time_ <= var_4_30 + arg_4_0 then
				arg_1_1.talkMaxDuration = 0

				arg_1_1.dialog_:SetActive(true)

				local var_4_32 = LeanTween.value(arg_1_1.dialog_, 0, 1, 0.3)

				var_4_32:setOnUpdate(LuaHelper.FloatAction(function(arg_5_0)
					arg_1_1.dialogCg_.alpha = arg_5_0
				end))
				var_4_32:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_1_1.dialog_)
					var_4_32:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_1_1.duration_ = arg_1_1.duration_ + 0.3

				SetActive(arg_1_1.leftNameGo_, false)

				arg_1_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_1_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_1_1:RecordName(arg_1_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_1_1.iconTrs_.gameObject, false)
				arg_1_1.callingController_:SetSelectedState("normal")

				local var_4_33 = arg_1_1:GetWordFromCfg(411051001)
				local var_4_34 = arg_1_1:FormatText(var_4_33.content)

				arg_1_1.text_.text = var_4_34

				LuaForUtil.ClearLinePrefixSymbol(arg_1_1.text_)

				local var_4_35 = 20
				local var_4_36 = utf8.len(var_4_34)
				local var_4_37 = var_4_35 <= 0 and var_4_31 or var_4_31 * (var_4_36 / var_4_35)

				if var_4_37 > 0 and var_4_31 < var_4_37 then
					arg_1_1.talkMaxDuration = var_4_37
					var_4_30 = var_4_30 + 0.3

					if var_4_37 + var_4_30 > arg_1_1.duration_ then
						arg_1_1.duration_ = var_4_37 + var_4_30
					end
				end

				arg_1_1.text_.text = var_4_34
				arg_1_1.typewritter.percent = 0

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(false)
				arg_1_1:RecordContent(arg_1_1.text_.text)
			end

			local var_4_38 = var_4_30 + 0.3
			local var_4_39 = math.max(var_4_31, arg_1_1.talkMaxDuration)

			if var_4_38 <= arg_1_1.time_ and arg_1_1.time_ < var_4_38 + var_4_39 then
				arg_1_1.typewritter.percent = (arg_1_1.time_ - var_4_38) / var_4_39

				arg_1_1.typewritter:SetDirty()
			end

			if arg_1_1.time_ >= var_4_38 + var_4_39 and arg_1_1.time_ < var_4_38 + var_4_39 + arg_4_0 then
				arg_1_1.typewritter.percent = 1

				arg_1_1.typewritter:SetDirty()
				arg_1_1:ShowNextGo(true)
			end
		end
	end,
	Play411051002 = function(arg_7_0, arg_7_1)
		arg_7_1.time_ = 0
		arg_7_1.frameCnt_ = 0
		arg_7_1.state_ = "playing"
		arg_7_1.curTalkId_ = 411051002
		arg_7_1.duration_ = 5

		SetActive(arg_7_1.tipsGo_, false)

		function arg_7_1.onSingleLineFinish_()
			arg_7_1.onSingleLineUpdate_ = nil
			arg_7_1.onSingleLineFinish_ = nil
			arg_7_1.state_ = "waiting"
		end

		function arg_7_1.playNext_(arg_9_0)
			if arg_9_0 == 1 then
				arg_7_0:Play411051003(arg_7_1)
			end
		end

		function arg_7_1.onSingleLineUpdate_(arg_10_0)
			local var_10_0 = 0
			local var_10_1 = 1.075

			if var_10_0 < arg_7_1.time_ and arg_7_1.time_ <= var_10_0 + arg_10_0 then
				arg_7_1.talkMaxDuration = 0
				arg_7_1.dialogCg_.alpha = 1

				arg_7_1.dialog_:SetActive(true)
				SetActive(arg_7_1.leftNameGo_, false)

				arg_7_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_7_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_7_1:RecordName(arg_7_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_7_1.iconTrs_.gameObject, false)
				arg_7_1.callingController_:SetSelectedState("normal")

				local var_10_2 = arg_7_1:GetWordFromCfg(411051002)
				local var_10_3 = arg_7_1:FormatText(var_10_2.content)

				arg_7_1.text_.text = var_10_3

				LuaForUtil.ClearLinePrefixSymbol(arg_7_1.text_)

				local var_10_4 = 43
				local var_10_5 = utf8.len(var_10_3)
				local var_10_6 = var_10_4 <= 0 and var_10_1 or var_10_1 * (var_10_5 / var_10_4)

				if var_10_6 > 0 and var_10_1 < var_10_6 then
					arg_7_1.talkMaxDuration = var_10_6

					if var_10_6 + var_10_0 > arg_7_1.duration_ then
						arg_7_1.duration_ = var_10_6 + var_10_0
					end
				end

				arg_7_1.text_.text = var_10_3
				arg_7_1.typewritter.percent = 0

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(false)
				arg_7_1:RecordContent(arg_7_1.text_.text)
			end

			local var_10_7 = math.max(var_10_1, arg_7_1.talkMaxDuration)

			if var_10_0 <= arg_7_1.time_ and arg_7_1.time_ < var_10_0 + var_10_7 then
				arg_7_1.typewritter.percent = (arg_7_1.time_ - var_10_0) / var_10_7

				arg_7_1.typewritter:SetDirty()
			end

			if arg_7_1.time_ >= var_10_0 + var_10_7 and arg_7_1.time_ < var_10_0 + var_10_7 + arg_10_0 then
				arg_7_1.typewritter.percent = 1

				arg_7_1.typewritter:SetDirty()
				arg_7_1:ShowNextGo(true)
			end
		end
	end,
	Play411051003 = function(arg_11_0, arg_11_1)
		arg_11_1.time_ = 0
		arg_11_1.frameCnt_ = 0
		arg_11_1.state_ = "playing"
		arg_11_1.curTalkId_ = 411051003
		arg_11_1.duration_ = 5

		SetActive(arg_11_1.tipsGo_, false)

		function arg_11_1.onSingleLineFinish_()
			arg_11_1.onSingleLineUpdate_ = nil
			arg_11_1.onSingleLineFinish_ = nil
			arg_11_1.state_ = "waiting"
		end

		function arg_11_1.playNext_(arg_13_0)
			if arg_13_0 == 1 then
				arg_11_0:Play411051004(arg_11_1)
			end
		end

		function arg_11_1.onSingleLineUpdate_(arg_14_0)
			local var_14_0 = 0
			local var_14_1 = 1.15

			if var_14_0 < arg_11_1.time_ and arg_11_1.time_ <= var_14_0 + arg_14_0 then
				arg_11_1.talkMaxDuration = 0
				arg_11_1.dialogCg_.alpha = 1

				arg_11_1.dialog_:SetActive(true)
				SetActive(arg_11_1.leftNameGo_, false)

				arg_11_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_11_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_11_1:RecordName(arg_11_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_11_1.iconTrs_.gameObject, false)
				arg_11_1.callingController_:SetSelectedState("normal")

				local var_14_2 = arg_11_1:GetWordFromCfg(411051003)
				local var_14_3 = arg_11_1:FormatText(var_14_2.content)

				arg_11_1.text_.text = var_14_3

				LuaForUtil.ClearLinePrefixSymbol(arg_11_1.text_)

				local var_14_4 = 46
				local var_14_5 = utf8.len(var_14_3)
				local var_14_6 = var_14_4 <= 0 and var_14_1 or var_14_1 * (var_14_5 / var_14_4)

				if var_14_6 > 0 and var_14_1 < var_14_6 then
					arg_11_1.talkMaxDuration = var_14_6

					if var_14_6 + var_14_0 > arg_11_1.duration_ then
						arg_11_1.duration_ = var_14_6 + var_14_0
					end
				end

				arg_11_1.text_.text = var_14_3
				arg_11_1.typewritter.percent = 0

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(false)
				arg_11_1:RecordContent(arg_11_1.text_.text)
			end

			local var_14_7 = math.max(var_14_1, arg_11_1.talkMaxDuration)

			if var_14_0 <= arg_11_1.time_ and arg_11_1.time_ < var_14_0 + var_14_7 then
				arg_11_1.typewritter.percent = (arg_11_1.time_ - var_14_0) / var_14_7

				arg_11_1.typewritter:SetDirty()
			end

			if arg_11_1.time_ >= var_14_0 + var_14_7 and arg_11_1.time_ < var_14_0 + var_14_7 + arg_14_0 then
				arg_11_1.typewritter.percent = 1

				arg_11_1.typewritter:SetDirty()
				arg_11_1:ShowNextGo(true)
			end
		end
	end,
	Play411051004 = function(arg_15_0, arg_15_1)
		arg_15_1.time_ = 0
		arg_15_1.frameCnt_ = 0
		arg_15_1.state_ = "playing"
		arg_15_1.curTalkId_ = 411051004
		arg_15_1.duration_ = 5

		SetActive(arg_15_1.tipsGo_, false)

		function arg_15_1.onSingleLineFinish_()
			arg_15_1.onSingleLineUpdate_ = nil
			arg_15_1.onSingleLineFinish_ = nil
			arg_15_1.state_ = "waiting"
		end

		function arg_15_1.playNext_(arg_17_0)
			if arg_17_0 == 1 then
				arg_15_0:Play411051005(arg_15_1)
			end
		end

		function arg_15_1.onSingleLineUpdate_(arg_18_0)
			local var_18_0 = 0
			local var_18_1 = 0.325

			if var_18_0 < arg_15_1.time_ and arg_15_1.time_ <= var_18_0 + arg_18_0 then
				arg_15_1.talkMaxDuration = 0
				arg_15_1.dialogCg_.alpha = 1

				arg_15_1.dialog_:SetActive(true)
				SetActive(arg_15_1.leftNameGo_, false)

				arg_15_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_15_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_15_1:RecordName(arg_15_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_15_1.iconTrs_.gameObject, false)
				arg_15_1.callingController_:SetSelectedState("normal")

				local var_18_2 = arg_15_1:GetWordFromCfg(411051004)
				local var_18_3 = arg_15_1:FormatText(var_18_2.content)

				arg_15_1.text_.text = var_18_3

				LuaForUtil.ClearLinePrefixSymbol(arg_15_1.text_)

				local var_18_4 = 13
				local var_18_5 = utf8.len(var_18_3)
				local var_18_6 = var_18_4 <= 0 and var_18_1 or var_18_1 * (var_18_5 / var_18_4)

				if var_18_6 > 0 and var_18_1 < var_18_6 then
					arg_15_1.talkMaxDuration = var_18_6

					if var_18_6 + var_18_0 > arg_15_1.duration_ then
						arg_15_1.duration_ = var_18_6 + var_18_0
					end
				end

				arg_15_1.text_.text = var_18_3
				arg_15_1.typewritter.percent = 0

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(false)
				arg_15_1:RecordContent(arg_15_1.text_.text)
			end

			local var_18_7 = math.max(var_18_1, arg_15_1.talkMaxDuration)

			if var_18_0 <= arg_15_1.time_ and arg_15_1.time_ < var_18_0 + var_18_7 then
				arg_15_1.typewritter.percent = (arg_15_1.time_ - var_18_0) / var_18_7

				arg_15_1.typewritter:SetDirty()
			end

			if arg_15_1.time_ >= var_18_0 + var_18_7 and arg_15_1.time_ < var_18_0 + var_18_7 + arg_18_0 then
				arg_15_1.typewritter.percent = 1

				arg_15_1.typewritter:SetDirty()
				arg_15_1:ShowNextGo(true)
			end
		end
	end,
	Play411051005 = function(arg_19_0, arg_19_1)
		arg_19_1.time_ = 0
		arg_19_1.frameCnt_ = 0
		arg_19_1.state_ = "playing"
		arg_19_1.curTalkId_ = 411051005
		arg_19_1.duration_ = 1.599999999999

		SetActive(arg_19_1.tipsGo_, false)

		function arg_19_1.onSingleLineFinish_()
			arg_19_1.onSingleLineUpdate_ = nil
			arg_19_1.onSingleLineFinish_ = nil
			arg_19_1.state_ = "waiting"
		end

		function arg_19_1.playNext_(arg_21_0)
			if arg_21_0 == 1 then
				arg_19_0:Play411051006(arg_19_1)
			end
		end

		function arg_19_1.onSingleLineUpdate_(arg_22_0)
			local var_22_0 = 0

			if var_22_0 < arg_19_1.time_ and arg_19_1.time_ <= var_22_0 + arg_22_0 then
				arg_19_1.fswbg_:SetActive(true)
				arg_19_1.dialog_:SetActive(false)

				arg_19_1.fswtw_.percent = 0

				local var_22_1 = arg_19_1:GetWordFromCfg(411051005)
				local var_22_2 = arg_19_1:FormatText(var_22_1.content)

				arg_19_1.fswt_.text = var_22_2

				LuaForUtil.ClearLinePrefixSymbol(arg_19_1.fswt_)

				arg_19_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_19_1.fswtw_:SetDirty()

				arg_19_1.typewritterCharCountI18N = 0

				SetActive(arg_19_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_19_1:ShowNextGo(false)
			end

			local var_22_3 = 0.033

			if var_22_3 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.var_.oldValueTypewriter = arg_19_1.fswtw_.percent

				arg_19_1:ShowNextGo(false)
			end

			local var_22_4 = 16
			local var_22_5 = 1.06666666666667
			local var_22_6 = arg_19_1:GetWordFromCfg(411051005)
			local var_22_7 = arg_19_1:FormatText(var_22_6.content)
			local var_22_8, var_22_9 = arg_19_1:GetPercentByPara(var_22_7, 1)

			if var_22_3 < arg_19_1.time_ and arg_19_1.time_ <= var_22_3 + arg_22_0 then
				arg_19_1.talkMaxDuration = 0

				local var_22_10 = var_22_4 <= 0 and var_22_5 or var_22_5 * ((var_22_9 - arg_19_1.typewritterCharCountI18N) / var_22_4)

				if var_22_10 > 0 and var_22_5 < var_22_10 then
					arg_19_1.talkMaxDuration = var_22_10

					if var_22_10 + var_22_3 > arg_19_1.duration_ then
						arg_19_1.duration_ = var_22_10 + var_22_3
					end
				end
			end

			local var_22_11 = 1.06666666666667
			local var_22_12 = math.max(var_22_11, arg_19_1.talkMaxDuration)

			if var_22_3 <= arg_19_1.time_ and arg_19_1.time_ < var_22_3 + var_22_12 then
				local var_22_13 = (arg_19_1.time_ - var_22_3) / var_22_12

				arg_19_1.fswtw_.percent = Mathf.Lerp(arg_19_1.var_.oldValueTypewriter, var_22_8, var_22_13)
				arg_19_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_19_1.fswtw_:SetDirty()
			end

			if arg_19_1.time_ >= var_22_3 + var_22_12 and arg_19_1.time_ < var_22_3 + var_22_12 + arg_22_0 then
				arg_19_1.fswtw_.percent = var_22_8

				arg_19_1.fswtw_:SetDirty()
				arg_19_1:ShowNextGo(true)

				arg_19_1.typewritterCharCountI18N = var_22_9
			end

			local var_22_14 = 0
			local var_22_15 = 1
			local var_22_16 = manager.audio:GetVoiceLength("story_v_out_411051", "411051005", "story_v_out_411051.awb") / 1000

			if var_22_16 > 0 and var_22_15 < var_22_16 and var_22_16 + var_22_14 > arg_19_1.duration_ then
				local var_22_17 = var_22_16

				arg_19_1.duration_ = var_22_16 + var_22_14
			end

			if var_22_14 < arg_19_1.time_ and arg_19_1.time_ <= var_22_14 + arg_22_0 then
				local var_22_18 = "play"
				local var_22_19 = "voice"

				arg_19_1:AudioAction(var_22_18, var_22_19, "story_v_out_411051", "411051005", "story_v_out_411051.awb")
			end

			local var_22_20 = 0
			local var_22_21 = 0.366666666666667

			if var_22_20 < arg_19_1.time_ and arg_19_1.time_ <= var_22_20 + arg_22_0 then
				local var_22_22 = "play"
				local var_22_23 = "music"

				arg_19_1:AudioAction(var_22_22, var_22_23, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_22_24 = 0.6
			local var_22_25 = 1

			if var_22_24 < arg_19_1.time_ and arg_19_1.time_ <= var_22_24 + arg_22_0 then
				local var_22_26 = "play"
				local var_22_27 = "music"

				arg_19_1:AudioAction(var_22_26, var_22_27, "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad", "bgm_activity_3_0_story_sad.awb")
			end
		end
	end,
	Play411051006 = function(arg_23_0, arg_23_1)
		arg_23_1.time_ = 0
		arg_23_1.frameCnt_ = 0
		arg_23_1.state_ = "playing"
		arg_23_1.curTalkId_ = 411051006
		arg_23_1.duration_ = 3.199999999999

		SetActive(arg_23_1.tipsGo_, false)

		function arg_23_1.onSingleLineFinish_()
			arg_23_1.onSingleLineUpdate_ = nil
			arg_23_1.onSingleLineFinish_ = nil
			arg_23_1.state_ = "waiting"
		end

		function arg_23_1.playNext_(arg_25_0)
			if arg_25_0 == 1 then
				arg_23_0:Play411051007(arg_23_1)
			end
		end

		function arg_23_1.onSingleLineUpdate_(arg_26_0)
			local var_26_0 = 0

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.var_.oldValueTypewriter = arg_23_1.fswtw_.percent

				arg_23_1:ShowNextGo(false)
			end

			local var_26_1 = 48
			local var_26_2 = 3.2
			local var_26_3 = arg_23_1:GetWordFromCfg(411051005)
			local var_26_4 = arg_23_1:FormatText(var_26_3.content)
			local var_26_5, var_26_6 = arg_23_1:GetPercentByPara(var_26_4, 2)

			if var_26_0 < arg_23_1.time_ and arg_23_1.time_ <= var_26_0 + arg_26_0 then
				arg_23_1.talkMaxDuration = 0

				local var_26_7 = var_26_1 <= 0 and var_26_2 or var_26_2 * ((var_26_6 - arg_23_1.typewritterCharCountI18N) / var_26_1)

				if var_26_7 > 0 and var_26_2 < var_26_7 then
					arg_23_1.talkMaxDuration = var_26_7

					if var_26_7 + var_26_0 > arg_23_1.duration_ then
						arg_23_1.duration_ = var_26_7 + var_26_0
					end
				end
			end

			local var_26_8 = 3.2
			local var_26_9 = math.max(var_26_8, arg_23_1.talkMaxDuration)

			if var_26_0 <= arg_23_1.time_ and arg_23_1.time_ < var_26_0 + var_26_9 then
				local var_26_10 = (arg_23_1.time_ - var_26_0) / var_26_9

				arg_23_1.fswtw_.percent = Mathf.Lerp(arg_23_1.var_.oldValueTypewriter, var_26_5, var_26_10)
				arg_23_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_23_1.fswtw_:SetDirty()
			end

			if arg_23_1.time_ >= var_26_0 + var_26_9 and arg_23_1.time_ < var_26_0 + var_26_9 + arg_26_0 then
				arg_23_1.fswtw_.percent = var_26_5

				arg_23_1.fswtw_:SetDirty()
				arg_23_1:ShowNextGo(true)

				arg_23_1.typewritterCharCountI18N = var_26_6
			end

			local var_26_11 = 0
			local var_26_12 = 1
			local var_26_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051006", "story_v_out_411051.awb") / 1000

			if var_26_13 > 0 and var_26_12 < var_26_13 and var_26_13 + var_26_11 > arg_23_1.duration_ then
				local var_26_14 = var_26_13

				arg_23_1.duration_ = var_26_13 + var_26_11
			end

			if var_26_11 < arg_23_1.time_ and arg_23_1.time_ <= var_26_11 + arg_26_0 then
				local var_26_15 = "play"
				local var_26_16 = "voice"

				arg_23_1:AudioAction(var_26_15, var_26_16, "story_v_out_411051", "411051006", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051007 = function(arg_27_0, arg_27_1)
		arg_27_1.time_ = 0
		arg_27_1.frameCnt_ = 0
		arg_27_1.state_ = "playing"
		arg_27_1.curTalkId_ = 411051007
		arg_27_1.duration_ = 2.466666666666

		SetActive(arg_27_1.tipsGo_, false)

		function arg_27_1.onSingleLineFinish_()
			arg_27_1.onSingleLineUpdate_ = nil
			arg_27_1.onSingleLineFinish_ = nil
			arg_27_1.state_ = "waiting"
		end

		function arg_27_1.playNext_(arg_29_0)
			if arg_29_0 == 1 then
				arg_27_0:Play411051008(arg_27_1)
			end
		end

		function arg_27_1.onSingleLineUpdate_(arg_30_0)
			local var_30_0 = 0

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.var_.oldValueTypewriter = arg_27_1.fswtw_.percent

				arg_27_1:ShowNextGo(false)
			end

			local var_30_1 = 37
			local var_30_2 = 2.46666666666667
			local var_30_3 = arg_27_1:GetWordFromCfg(411051005)
			local var_30_4 = arg_27_1:FormatText(var_30_3.content)
			local var_30_5, var_30_6 = arg_27_1:GetPercentByPara(var_30_4, 3)

			if var_30_0 < arg_27_1.time_ and arg_27_1.time_ <= var_30_0 + arg_30_0 then
				arg_27_1.talkMaxDuration = 0

				local var_30_7 = var_30_1 <= 0 and var_30_2 or var_30_2 * ((var_30_6 - arg_27_1.typewritterCharCountI18N) / var_30_1)

				if var_30_7 > 0 and var_30_2 < var_30_7 then
					arg_27_1.talkMaxDuration = var_30_7

					if var_30_7 + var_30_0 > arg_27_1.duration_ then
						arg_27_1.duration_ = var_30_7 + var_30_0
					end
				end
			end

			local var_30_8 = 2.46666666666667
			local var_30_9 = math.max(var_30_8, arg_27_1.talkMaxDuration)

			if var_30_0 <= arg_27_1.time_ and arg_27_1.time_ < var_30_0 + var_30_9 then
				local var_30_10 = (arg_27_1.time_ - var_30_0) / var_30_9

				arg_27_1.fswtw_.percent = Mathf.Lerp(arg_27_1.var_.oldValueTypewriter, var_30_5, var_30_10)
				arg_27_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_27_1.fswtw_:SetDirty()
			end

			if arg_27_1.time_ >= var_30_0 + var_30_9 and arg_27_1.time_ < var_30_0 + var_30_9 + arg_30_0 then
				arg_27_1.fswtw_.percent = var_30_5

				arg_27_1.fswtw_:SetDirty()
				arg_27_1:ShowNextGo(true)

				arg_27_1.typewritterCharCountI18N = var_30_6
			end

			local var_30_11 = 0
			local var_30_12 = 1
			local var_30_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051007", "story_v_out_411051.awb") / 1000

			if var_30_13 > 0 and var_30_12 < var_30_13 and var_30_13 + var_30_11 > arg_27_1.duration_ then
				local var_30_14 = var_30_13

				arg_27_1.duration_ = var_30_13 + var_30_11
			end

			if var_30_11 < arg_27_1.time_ and arg_27_1.time_ <= var_30_11 + arg_30_0 then
				local var_30_15 = "play"
				local var_30_16 = "voice"

				arg_27_1:AudioAction(var_30_15, var_30_16, "story_v_out_411051", "411051007", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051008 = function(arg_31_0, arg_31_1)
		arg_31_1.time_ = 0
		arg_31_1.frameCnt_ = 0
		arg_31_1.state_ = "playing"
		arg_31_1.curTalkId_ = 411051008
		arg_31_1.duration_ = 2.666666666666

		SetActive(arg_31_1.tipsGo_, false)

		function arg_31_1.onSingleLineFinish_()
			arg_31_1.onSingleLineUpdate_ = nil
			arg_31_1.onSingleLineFinish_ = nil
			arg_31_1.state_ = "waiting"
		end

		function arg_31_1.playNext_(arg_33_0)
			if arg_33_0 == 1 then
				arg_31_0:Play411051009(arg_31_1)
			end
		end

		function arg_31_1.onSingleLineUpdate_(arg_34_0)
			local var_34_0 = 0

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.var_.oldValueTypewriter = arg_31_1.fswtw_.percent

				arg_31_1:ShowNextGo(false)
			end

			local var_34_1 = 40
			local var_34_2 = 2.66666666666667
			local var_34_3 = arg_31_1:GetWordFromCfg(411051005)
			local var_34_4 = arg_31_1:FormatText(var_34_3.content)
			local var_34_5, var_34_6 = arg_31_1:GetPercentByPara(var_34_4, 4)

			if var_34_0 < arg_31_1.time_ and arg_31_1.time_ <= var_34_0 + arg_34_0 then
				arg_31_1.talkMaxDuration = 0

				local var_34_7 = var_34_1 <= 0 and var_34_2 or var_34_2 * ((var_34_6 - arg_31_1.typewritterCharCountI18N) / var_34_1)

				if var_34_7 > 0 and var_34_2 < var_34_7 then
					arg_31_1.talkMaxDuration = var_34_7

					if var_34_7 + var_34_0 > arg_31_1.duration_ then
						arg_31_1.duration_ = var_34_7 + var_34_0
					end
				end
			end

			local var_34_8 = 2.66666666666667
			local var_34_9 = math.max(var_34_8, arg_31_1.talkMaxDuration)

			if var_34_0 <= arg_31_1.time_ and arg_31_1.time_ < var_34_0 + var_34_9 then
				local var_34_10 = (arg_31_1.time_ - var_34_0) / var_34_9

				arg_31_1.fswtw_.percent = Mathf.Lerp(arg_31_1.var_.oldValueTypewriter, var_34_5, var_34_10)
				arg_31_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_31_1.fswtw_:SetDirty()
			end

			if arg_31_1.time_ >= var_34_0 + var_34_9 and arg_31_1.time_ < var_34_0 + var_34_9 + arg_34_0 then
				arg_31_1.fswtw_.percent = var_34_5

				arg_31_1.fswtw_:SetDirty()
				arg_31_1:ShowNextGo(true)

				arg_31_1.typewritterCharCountI18N = var_34_6
			end

			local var_34_11 = 0
			local var_34_12 = 1
			local var_34_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051008", "story_v_out_411051.awb") / 1000

			if var_34_13 > 0 and var_34_12 < var_34_13 and var_34_13 + var_34_11 > arg_31_1.duration_ then
				local var_34_14 = var_34_13

				arg_31_1.duration_ = var_34_13 + var_34_11
			end

			if var_34_11 < arg_31_1.time_ and arg_31_1.time_ <= var_34_11 + arg_34_0 then
				local var_34_15 = "play"
				local var_34_16 = "voice"

				arg_31_1:AudioAction(var_34_15, var_34_16, "story_v_out_411051", "411051008", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051009 = function(arg_35_0, arg_35_1)
		arg_35_1.time_ = 0
		arg_35_1.frameCnt_ = 0
		arg_35_1.state_ = "playing"
		arg_35_1.curTalkId_ = 411051009
		arg_35_1.duration_ = 0.999999999999

		SetActive(arg_35_1.tipsGo_, false)

		function arg_35_1.onSingleLineFinish_()
			arg_35_1.onSingleLineUpdate_ = nil
			arg_35_1.onSingleLineFinish_ = nil
			arg_35_1.state_ = "waiting"
		end

		function arg_35_1.playNext_(arg_37_0)
			if arg_37_0 == 1 then
				arg_35_0:Play411051010(arg_35_1)
			end
		end

		function arg_35_1.onSingleLineUpdate_(arg_38_0)
			local var_38_0 = 0

			if var_38_0 < arg_35_1.time_ and arg_35_1.time_ <= var_38_0 + arg_38_0 then
				arg_35_1.fswbg_:SetActive(true)
				arg_35_1.dialog_:SetActive(false)

				arg_35_1.fswtw_.percent = 0

				local var_38_1 = arg_35_1:GetWordFromCfg(411051009)
				local var_38_2 = arg_35_1:FormatText(var_38_1.content)

				arg_35_1.fswt_.text = var_38_2

				LuaForUtil.ClearLinePrefixSymbol(arg_35_1.fswt_)

				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()

				arg_35_1.typewritterCharCountI18N = 0

				SetActive(arg_35_1.fswtw_.transform.parent.parent:Find("bg/line").gameObject, false)
				arg_35_1:ShowNextGo(false)
			end

			local var_38_3 = 0.033

			if var_38_3 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.var_.oldValueTypewriter = arg_35_1.fswtw_.percent

				arg_35_1:ShowNextGo(false)
			end

			local var_38_4 = 9
			local var_38_5 = 0.6
			local var_38_6 = arg_35_1:GetWordFromCfg(411051009)
			local var_38_7 = arg_35_1:FormatText(var_38_6.content)
			local var_38_8, var_38_9 = arg_35_1:GetPercentByPara(var_38_7, 1)

			if var_38_3 < arg_35_1.time_ and arg_35_1.time_ <= var_38_3 + arg_38_0 then
				arg_35_1.talkMaxDuration = 0

				local var_38_10 = var_38_4 <= 0 and var_38_5 or var_38_5 * ((var_38_9 - arg_35_1.typewritterCharCountI18N) / var_38_4)

				if var_38_10 > 0 and var_38_5 < var_38_10 then
					arg_35_1.talkMaxDuration = var_38_10

					if var_38_10 + var_38_3 > arg_35_1.duration_ then
						arg_35_1.duration_ = var_38_10 + var_38_3
					end
				end
			end

			local var_38_11 = 0.6
			local var_38_12 = math.max(var_38_11, arg_35_1.talkMaxDuration)

			if var_38_3 <= arg_35_1.time_ and arg_35_1.time_ < var_38_3 + var_38_12 then
				local var_38_13 = (arg_35_1.time_ - var_38_3) / var_38_12

				arg_35_1.fswtw_.percent = Mathf.Lerp(arg_35_1.var_.oldValueTypewriter, var_38_8, var_38_13)
				arg_35_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_35_1.fswtw_:SetDirty()
			end

			if arg_35_1.time_ >= var_38_3 + var_38_12 and arg_35_1.time_ < var_38_3 + var_38_12 + arg_38_0 then
				arg_35_1.fswtw_.percent = var_38_8

				arg_35_1.fswtw_:SetDirty()
				arg_35_1:ShowNextGo(true)

				arg_35_1.typewritterCharCountI18N = var_38_9
			end

			local var_38_14 = 0
			local var_38_15 = 1
			local var_38_16 = manager.audio:GetVoiceLength("story_v_out_411051", "411051009", "story_v_out_411051.awb") / 1000

			if var_38_16 > 0 and var_38_15 < var_38_16 and var_38_16 + var_38_14 > arg_35_1.duration_ then
				local var_38_17 = var_38_16

				arg_35_1.duration_ = var_38_16 + var_38_14
			end

			if var_38_14 < arg_35_1.time_ and arg_35_1.time_ <= var_38_14 + arg_38_0 then
				local var_38_18 = "play"
				local var_38_19 = "voice"

				arg_35_1:AudioAction(var_38_18, var_38_19, "story_v_out_411051", "411051009", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051010 = function(arg_39_0, arg_39_1)
		arg_39_1.time_ = 0
		arg_39_1.frameCnt_ = 0
		arg_39_1.state_ = "playing"
		arg_39_1.curTalkId_ = 411051010
		arg_39_1.duration_ = 1.399999999999

		SetActive(arg_39_1.tipsGo_, false)

		function arg_39_1.onSingleLineFinish_()
			arg_39_1.onSingleLineUpdate_ = nil
			arg_39_1.onSingleLineFinish_ = nil
			arg_39_1.state_ = "waiting"
		end

		function arg_39_1.playNext_(arg_41_0)
			if arg_41_0 == 1 then
				arg_39_0:Play411051011(arg_39_1)
			end
		end

		function arg_39_1.onSingleLineUpdate_(arg_42_0)
			local var_42_0 = 0

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.var_.oldValueTypewriter = arg_39_1.fswtw_.percent

				arg_39_1:ShowNextGo(false)
			end

			local var_42_1 = 21
			local var_42_2 = 1.4
			local var_42_3 = arg_39_1:GetWordFromCfg(411051009)
			local var_42_4 = arg_39_1:FormatText(var_42_3.content)
			local var_42_5, var_42_6 = arg_39_1:GetPercentByPara(var_42_4, 2)

			if var_42_0 < arg_39_1.time_ and arg_39_1.time_ <= var_42_0 + arg_42_0 then
				arg_39_1.talkMaxDuration = 0

				local var_42_7 = var_42_1 <= 0 and var_42_2 or var_42_2 * ((var_42_6 - arg_39_1.typewritterCharCountI18N) / var_42_1)

				if var_42_7 > 0 and var_42_2 < var_42_7 then
					arg_39_1.talkMaxDuration = var_42_7

					if var_42_7 + var_42_0 > arg_39_1.duration_ then
						arg_39_1.duration_ = var_42_7 + var_42_0
					end
				end
			end

			local var_42_8 = 1.4
			local var_42_9 = math.max(var_42_8, arg_39_1.talkMaxDuration)

			if var_42_0 <= arg_39_1.time_ and arg_39_1.time_ < var_42_0 + var_42_9 then
				local var_42_10 = (arg_39_1.time_ - var_42_0) / var_42_9

				arg_39_1.fswtw_.percent = Mathf.Lerp(arg_39_1.var_.oldValueTypewriter, var_42_5, var_42_10)
				arg_39_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_39_1.fswtw_:SetDirty()
			end

			if arg_39_1.time_ >= var_42_0 + var_42_9 and arg_39_1.time_ < var_42_0 + var_42_9 + arg_42_0 then
				arg_39_1.fswtw_.percent = var_42_5

				arg_39_1.fswtw_:SetDirty()
				arg_39_1:ShowNextGo(true)

				arg_39_1.typewritterCharCountI18N = var_42_6
			end

			local var_42_11 = 0
			local var_42_12 = 1
			local var_42_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051010", "story_v_out_411051.awb") / 1000

			if var_42_13 > 0 and var_42_12 < var_42_13 and var_42_13 + var_42_11 > arg_39_1.duration_ then
				local var_42_14 = var_42_13

				arg_39_1.duration_ = var_42_13 + var_42_11
			end

			if var_42_11 < arg_39_1.time_ and arg_39_1.time_ <= var_42_11 + arg_42_0 then
				local var_42_15 = "play"
				local var_42_16 = "voice"

				arg_39_1:AudioAction(var_42_15, var_42_16, "story_v_out_411051", "411051010", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051011 = function(arg_43_0, arg_43_1)
		arg_43_1.time_ = 0
		arg_43_1.frameCnt_ = 0
		arg_43_1.state_ = "playing"
		arg_43_1.curTalkId_ = 411051011
		arg_43_1.duration_ = 3.266666666666

		SetActive(arg_43_1.tipsGo_, false)

		function arg_43_1.onSingleLineFinish_()
			arg_43_1.onSingleLineUpdate_ = nil
			arg_43_1.onSingleLineFinish_ = nil
			arg_43_1.state_ = "waiting"
		end

		function arg_43_1.playNext_(arg_45_0)
			if arg_45_0 == 1 then
				arg_43_0:Play411051012(arg_43_1)
			end
		end

		function arg_43_1.onSingleLineUpdate_(arg_46_0)
			local var_46_0 = 0

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.var_.oldValueTypewriter = arg_43_1.fswtw_.percent

				arg_43_1:ShowNextGo(false)
			end

			local var_46_1 = 49
			local var_46_2 = 3.26666666666667
			local var_46_3 = arg_43_1:GetWordFromCfg(411051009)
			local var_46_4 = arg_43_1:FormatText(var_46_3.content)
			local var_46_5, var_46_6 = arg_43_1:GetPercentByPara(var_46_4, 3)

			if var_46_0 < arg_43_1.time_ and arg_43_1.time_ <= var_46_0 + arg_46_0 then
				arg_43_1.talkMaxDuration = 0

				local var_46_7 = var_46_1 <= 0 and var_46_2 or var_46_2 * ((var_46_6 - arg_43_1.typewritterCharCountI18N) / var_46_1)

				if var_46_7 > 0 and var_46_2 < var_46_7 then
					arg_43_1.talkMaxDuration = var_46_7

					if var_46_7 + var_46_0 > arg_43_1.duration_ then
						arg_43_1.duration_ = var_46_7 + var_46_0
					end
				end
			end

			local var_46_8 = 3.26666666666667
			local var_46_9 = math.max(var_46_8, arg_43_1.talkMaxDuration)

			if var_46_0 <= arg_43_1.time_ and arg_43_1.time_ < var_46_0 + var_46_9 then
				local var_46_10 = (arg_43_1.time_ - var_46_0) / var_46_9

				arg_43_1.fswtw_.percent = Mathf.Lerp(arg_43_1.var_.oldValueTypewriter, var_46_5, var_46_10)
				arg_43_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_43_1.fswtw_:SetDirty()
			end

			if arg_43_1.time_ >= var_46_0 + var_46_9 and arg_43_1.time_ < var_46_0 + var_46_9 + arg_46_0 then
				arg_43_1.fswtw_.percent = var_46_5

				arg_43_1.fswtw_:SetDirty()
				arg_43_1:ShowNextGo(true)

				arg_43_1.typewritterCharCountI18N = var_46_6
			end

			local var_46_11 = 0
			local var_46_12 = 1
			local var_46_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051011", "story_v_out_411051.awb") / 1000

			if var_46_13 > 0 and var_46_12 < var_46_13 and var_46_13 + var_46_11 > arg_43_1.duration_ then
				local var_46_14 = var_46_13

				arg_43_1.duration_ = var_46_13 + var_46_11
			end

			if var_46_11 < arg_43_1.time_ and arg_43_1.time_ <= var_46_11 + arg_46_0 then
				local var_46_15 = "play"
				local var_46_16 = "voice"

				arg_43_1:AudioAction(var_46_15, var_46_16, "story_v_out_411051", "411051011", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051012 = function(arg_47_0, arg_47_1)
		arg_47_1.time_ = 0
		arg_47_1.frameCnt_ = 0
		arg_47_1.state_ = "playing"
		arg_47_1.curTalkId_ = 411051012
		arg_47_1.duration_ = 1.199999999999

		SetActive(arg_47_1.tipsGo_, false)

		function arg_47_1.onSingleLineFinish_()
			arg_47_1.onSingleLineUpdate_ = nil
			arg_47_1.onSingleLineFinish_ = nil
			arg_47_1.state_ = "waiting"
		end

		function arg_47_1.playNext_(arg_49_0)
			if arg_49_0 == 1 then
				arg_47_0:Play411051013(arg_47_1)
			end
		end

		function arg_47_1.onSingleLineUpdate_(arg_50_0)
			local var_50_0 = 0

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.var_.oldValueTypewriter = arg_47_1.fswtw_.percent

				arg_47_1:ShowNextGo(false)
			end

			local var_50_1 = 18
			local var_50_2 = 1.2
			local var_50_3 = arg_47_1:GetWordFromCfg(411051009)
			local var_50_4 = arg_47_1:FormatText(var_50_3.content)
			local var_50_5, var_50_6 = arg_47_1:GetPercentByPara(var_50_4, 4)

			if var_50_0 < arg_47_1.time_ and arg_47_1.time_ <= var_50_0 + arg_50_0 then
				arg_47_1.talkMaxDuration = 0

				local var_50_7 = var_50_1 <= 0 and var_50_2 or var_50_2 * ((var_50_6 - arg_47_1.typewritterCharCountI18N) / var_50_1)

				if var_50_7 > 0 and var_50_2 < var_50_7 then
					arg_47_1.talkMaxDuration = var_50_7

					if var_50_7 + var_50_0 > arg_47_1.duration_ then
						arg_47_1.duration_ = var_50_7 + var_50_0
					end
				end
			end

			local var_50_8 = 1.2
			local var_50_9 = math.max(var_50_8, arg_47_1.talkMaxDuration)

			if var_50_0 <= arg_47_1.time_ and arg_47_1.time_ < var_50_0 + var_50_9 then
				local var_50_10 = (arg_47_1.time_ - var_50_0) / var_50_9

				arg_47_1.fswtw_.percent = Mathf.Lerp(arg_47_1.var_.oldValueTypewriter, var_50_5, var_50_10)
				arg_47_1.fswt_:GetComponent("Text").color = Color(1, 1, 1)

				arg_47_1.fswtw_:SetDirty()
			end

			if arg_47_1.time_ >= var_50_0 + var_50_9 and arg_47_1.time_ < var_50_0 + var_50_9 + arg_50_0 then
				arg_47_1.fswtw_.percent = var_50_5

				arg_47_1.fswtw_:SetDirty()
				arg_47_1:ShowNextGo(true)

				arg_47_1.typewritterCharCountI18N = var_50_6
			end

			local var_50_11 = 0
			local var_50_12 = 1
			local var_50_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051012", "story_v_out_411051.awb") / 1000

			if var_50_13 > 0 and var_50_12 < var_50_13 and var_50_13 + var_50_11 > arg_47_1.duration_ then
				local var_50_14 = var_50_13

				arg_47_1.duration_ = var_50_13 + var_50_11
			end

			if var_50_11 < arg_47_1.time_ and arg_47_1.time_ <= var_50_11 + arg_50_0 then
				local var_50_15 = "play"
				local var_50_16 = "voice"

				arg_47_1:AudioAction(var_50_15, var_50_16, "story_v_out_411051", "411051012", "story_v_out_411051.awb")
			end
		end
	end,
	Play411051013 = function(arg_51_0, arg_51_1)
		arg_51_1.time_ = 0
		arg_51_1.frameCnt_ = 0
		arg_51_1.state_ = "playing"
		arg_51_1.curTalkId_ = 411051013
		arg_51_1.duration_ = 6.6

		local var_51_0 = {
			zh = 6.6,
			ja = 2.5
		}
		local var_51_1 = manager.audio:GetLocalizationFlag()

		if var_51_0[var_51_1] ~= nil then
			arg_51_1.duration_ = var_51_0[var_51_1]
		end

		SetActive(arg_51_1.tipsGo_, false)

		function arg_51_1.onSingleLineFinish_()
			arg_51_1.onSingleLineUpdate_ = nil
			arg_51_1.onSingleLineFinish_ = nil
			arg_51_1.state_ = "waiting"
		end

		function arg_51_1.playNext_(arg_53_0)
			if arg_53_0 == 1 then
				arg_51_0:Play411051014(arg_51_1)
			end
		end

		function arg_51_1.onSingleLineUpdate_(arg_54_0)
			local var_54_0 = "10058ui_story"

			if arg_51_1.actors_[var_54_0] == nil then
				local var_54_1 = Object.Instantiate(Asset.Load("Char/" .. var_54_0), arg_51_1.stage_.transform)

				var_54_1.name = var_54_0
				var_54_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_51_1.actors_[var_54_0] = var_54_1

				local var_54_2 = var_54_1:GetComponentInChildren(typeof(CharacterEffect))

				var_54_2.enabled = true

				local var_54_3 = GameObjectTools.GetOrAddComponent(var_54_1, typeof(DynamicBoneHelper))

				if var_54_3 then
					var_54_3:EnableDynamicBone(false)
				end

				arg_51_1:ShowWeapon(var_54_2.transform, false)

				arg_51_1.var_[var_54_0 .. "Animator"] = var_54_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_51_1.var_[var_54_0 .. "Animator"].applyRootMotion = true
				arg_51_1.var_[var_54_0 .. "LipSync"] = var_54_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_54_4 = arg_51_1.actors_["10058ui_story"].transform
			local var_54_5 = 0

			if var_54_5 < arg_51_1.time_ and arg_51_1.time_ <= var_54_5 + arg_54_0 then
				arg_51_1.var_.moveOldPos10058ui_story = var_54_4.localPosition
			end

			local var_54_6 = 0.001

			if var_54_5 <= arg_51_1.time_ and arg_51_1.time_ < var_54_5 + var_54_6 then
				local var_54_7 = (arg_51_1.time_ - var_54_5) / var_54_6
				local var_54_8 = Vector3.New(0, -0.98, -6.1)

				var_54_4.localPosition = Vector3.Lerp(arg_51_1.var_.moveOldPos10058ui_story, var_54_8, var_54_7)

				local var_54_9 = manager.ui.mainCamera.transform.position - var_54_4.position

				var_54_4.forward = Vector3.New(var_54_9.x, var_54_9.y, var_54_9.z)

				local var_54_10 = var_54_4.localEulerAngles

				var_54_10.z = 0
				var_54_10.x = 0
				var_54_4.localEulerAngles = var_54_10
			end

			if arg_51_1.time_ >= var_54_5 + var_54_6 and arg_51_1.time_ < var_54_5 + var_54_6 + arg_54_0 then
				var_54_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_54_11 = manager.ui.mainCamera.transform.position - var_54_4.position

				var_54_4.forward = Vector3.New(var_54_11.x, var_54_11.y, var_54_11.z)

				local var_54_12 = var_54_4.localEulerAngles

				var_54_12.z = 0
				var_54_12.x = 0
				var_54_4.localEulerAngles = var_54_12
			end

			local var_54_13 = arg_51_1.actors_["10058ui_story"]
			local var_54_14 = 0

			if var_54_14 < arg_51_1.time_ and arg_51_1.time_ <= var_54_14 + arg_54_0 and arg_51_1.var_.characterEffect10058ui_story == nil then
				arg_51_1.var_.characterEffect10058ui_story = var_54_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_54_15 = 0.200000002980232

			if var_54_14 <= arg_51_1.time_ and arg_51_1.time_ < var_54_14 + var_54_15 then
				local var_54_16 = (arg_51_1.time_ - var_54_14) / var_54_15

				if arg_51_1.var_.characterEffect10058ui_story then
					arg_51_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_51_1.time_ >= var_54_14 + var_54_15 and arg_51_1.time_ < var_54_14 + var_54_15 + arg_54_0 and arg_51_1.var_.characterEffect10058ui_story then
				arg_51_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_54_17 = 0

			if var_54_17 < arg_51_1.time_ and arg_51_1.time_ <= var_54_17 + arg_54_0 then
				arg_51_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_54_18 = 0

			if var_54_18 < arg_51_1.time_ and arg_51_1.time_ <= var_54_18 + arg_54_0 then
				arg_51_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_54_19 = 0

			if var_54_19 < arg_51_1.time_ and arg_51_1.time_ <= var_54_19 + arg_54_0 then
				arg_51_1.fswbg_:SetActive(false)
				arg_51_1.dialog_:SetActive(true)
				arg_51_1:ShowNextGo(false)
			end

			local var_54_20 = 0
			local var_54_21 = 0.525

			if var_54_20 < arg_51_1.time_ and arg_51_1.time_ <= var_54_20 + arg_54_0 then
				arg_51_1.talkMaxDuration = 0
				arg_51_1.dialogCg_.alpha = 1

				arg_51_1.dialog_:SetActive(true)
				SetActive(arg_51_1.leftNameGo_, true)

				local var_54_22 = arg_51_1:FormatText(StoryNameCfg[695].name)

				arg_51_1.leftNameTxt_.text = var_54_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_51_1.leftNameTxt_.transform)

				arg_51_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_51_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_51_1:RecordName(arg_51_1.leftNameTxt_.text)
				SetActive(arg_51_1.iconTrs_.gameObject, false)
				arg_51_1.callingController_:SetSelectedState("normal")

				local var_54_23 = arg_51_1:GetWordFromCfg(411051013)
				local var_54_24 = arg_51_1:FormatText(var_54_23.content)

				arg_51_1.text_.text = var_54_24

				LuaForUtil.ClearLinePrefixSymbol(arg_51_1.text_)

				local var_54_25 = 21
				local var_54_26 = utf8.len(var_54_24)
				local var_54_27 = var_54_25 <= 0 and var_54_21 or var_54_21 * (var_54_26 / var_54_25)

				if var_54_27 > 0 and var_54_21 < var_54_27 then
					arg_51_1.talkMaxDuration = var_54_27

					if var_54_27 + var_54_20 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_27 + var_54_20
					end
				end

				arg_51_1.text_.text = var_54_24
				arg_51_1.typewritter.percent = 0

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") ~= 0 then
					local var_54_28 = manager.audio:GetVoiceLength("story_v_out_411051", "411051013", "story_v_out_411051.awb") / 1000

					if var_54_28 + var_54_20 > arg_51_1.duration_ then
						arg_51_1.duration_ = var_54_28 + var_54_20
					end

					if var_54_23.prefab_name ~= "" and arg_51_1.actors_[var_54_23.prefab_name] ~= nil then
						local var_54_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_51_1.actors_[var_54_23.prefab_name].transform, "story_v_out_411051", "411051013", "story_v_out_411051.awb")

						arg_51_1:RecordAudio("411051013", var_54_29)
						arg_51_1:RecordAudio("411051013", var_54_29)
					else
						arg_51_1:AudioAction("play", "voice", "story_v_out_411051", "411051013", "story_v_out_411051.awb")
					end

					arg_51_1:RecordHistoryTalkVoice("story_v_out_411051", "411051013", "story_v_out_411051.awb")
				end

				arg_51_1:RecordContent(arg_51_1.text_.text)
			end

			local var_54_30 = math.max(var_54_21, arg_51_1.talkMaxDuration)

			if var_54_20 <= arg_51_1.time_ and arg_51_1.time_ < var_54_20 + var_54_30 then
				arg_51_1.typewritter.percent = (arg_51_1.time_ - var_54_20) / var_54_30

				arg_51_1.typewritter:SetDirty()
			end

			if arg_51_1.time_ >= var_54_20 + var_54_30 and arg_51_1.time_ < var_54_20 + var_54_30 + arg_54_0 then
				arg_51_1.typewritter.percent = 1

				arg_51_1.typewritter:SetDirty()
				arg_51_1:ShowNextGo(true)
			end
		end
	end,
	Play411051014 = function(arg_55_0, arg_55_1)
		arg_55_1.time_ = 0
		arg_55_1.frameCnt_ = 0
		arg_55_1.state_ = "playing"
		arg_55_1.curTalkId_ = 411051014
		arg_55_1.duration_ = 5

		SetActive(arg_55_1.tipsGo_, false)

		function arg_55_1.onSingleLineFinish_()
			arg_55_1.onSingleLineUpdate_ = nil
			arg_55_1.onSingleLineFinish_ = nil
			arg_55_1.state_ = "waiting"
		end

		function arg_55_1.playNext_(arg_57_0)
			if arg_57_0 == 1 then
				arg_55_0:Play411051015(arg_55_1)
			end
		end

		function arg_55_1.onSingleLineUpdate_(arg_58_0)
			local var_58_0 = arg_55_1.actors_["10058ui_story"]
			local var_58_1 = 0

			if var_58_1 < arg_55_1.time_ and arg_55_1.time_ <= var_58_1 + arg_58_0 and arg_55_1.var_.characterEffect10058ui_story == nil then
				arg_55_1.var_.characterEffect10058ui_story = var_58_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_58_2 = 0.200000002980232

			if var_58_1 <= arg_55_1.time_ and arg_55_1.time_ < var_58_1 + var_58_2 then
				local var_58_3 = (arg_55_1.time_ - var_58_1) / var_58_2

				if arg_55_1.var_.characterEffect10058ui_story then
					local var_58_4 = Mathf.Lerp(0, 0.5, var_58_3)

					arg_55_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_55_1.var_.characterEffect10058ui_story.fillRatio = var_58_4
				end
			end

			if arg_55_1.time_ >= var_58_1 + var_58_2 and arg_55_1.time_ < var_58_1 + var_58_2 + arg_58_0 and arg_55_1.var_.characterEffect10058ui_story then
				local var_58_5 = 0.5

				arg_55_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_55_1.var_.characterEffect10058ui_story.fillRatio = var_58_5
			end

			local var_58_6 = 0
			local var_58_7 = 1.475

			if var_58_6 < arg_55_1.time_ and arg_55_1.time_ <= var_58_6 + arg_58_0 then
				arg_55_1.talkMaxDuration = 0
				arg_55_1.dialogCg_.alpha = 1

				arg_55_1.dialog_:SetActive(true)
				SetActive(arg_55_1.leftNameGo_, false)

				arg_55_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_55_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_55_1:RecordName(arg_55_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_55_1.iconTrs_.gameObject, false)
				arg_55_1.callingController_:SetSelectedState("normal")

				local var_58_8 = arg_55_1:GetWordFromCfg(411051014)
				local var_58_9 = arg_55_1:FormatText(var_58_8.content)

				arg_55_1.text_.text = var_58_9

				LuaForUtil.ClearLinePrefixSymbol(arg_55_1.text_)

				local var_58_10 = 59
				local var_58_11 = utf8.len(var_58_9)
				local var_58_12 = var_58_10 <= 0 and var_58_7 or var_58_7 * (var_58_11 / var_58_10)

				if var_58_12 > 0 and var_58_7 < var_58_12 then
					arg_55_1.talkMaxDuration = var_58_12

					if var_58_12 + var_58_6 > arg_55_1.duration_ then
						arg_55_1.duration_ = var_58_12 + var_58_6
					end
				end

				arg_55_1.text_.text = var_58_9
				arg_55_1.typewritter.percent = 0

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(false)
				arg_55_1:RecordContent(arg_55_1.text_.text)
			end

			local var_58_13 = math.max(var_58_7, arg_55_1.talkMaxDuration)

			if var_58_6 <= arg_55_1.time_ and arg_55_1.time_ < var_58_6 + var_58_13 then
				arg_55_1.typewritter.percent = (arg_55_1.time_ - var_58_6) / var_58_13

				arg_55_1.typewritter:SetDirty()
			end

			if arg_55_1.time_ >= var_58_6 + var_58_13 and arg_55_1.time_ < var_58_6 + var_58_13 + arg_58_0 then
				arg_55_1.typewritter.percent = 1

				arg_55_1.typewritter:SetDirty()
				arg_55_1:ShowNextGo(true)
			end
		end
	end,
	Play411051015 = function(arg_59_0, arg_59_1)
		arg_59_1.time_ = 0
		arg_59_1.frameCnt_ = 0
		arg_59_1.state_ = "playing"
		arg_59_1.curTalkId_ = 411051015
		arg_59_1.duration_ = 5

		SetActive(arg_59_1.tipsGo_, false)

		function arg_59_1.onSingleLineFinish_()
			arg_59_1.onSingleLineUpdate_ = nil
			arg_59_1.onSingleLineFinish_ = nil
			arg_59_1.state_ = "waiting"
		end

		function arg_59_1.playNext_(arg_61_0)
			if arg_61_0 == 1 then
				arg_59_0:Play411051016(arg_59_1)
			end
		end

		function arg_59_1.onSingleLineUpdate_(arg_62_0)
			local var_62_0 = 0
			local var_62_1 = 0.7

			if var_62_0 < arg_59_1.time_ and arg_59_1.time_ <= var_62_0 + arg_62_0 then
				arg_59_1.talkMaxDuration = 0
				arg_59_1.dialogCg_.alpha = 1

				arg_59_1.dialog_:SetActive(true)
				SetActive(arg_59_1.leftNameGo_, false)

				arg_59_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_59_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_59_1:RecordName(arg_59_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_59_1.iconTrs_.gameObject, false)
				arg_59_1.callingController_:SetSelectedState("normal")

				local var_62_2 = arg_59_1:GetWordFromCfg(411051015)
				local var_62_3 = arg_59_1:FormatText(var_62_2.content)

				arg_59_1.text_.text = var_62_3

				LuaForUtil.ClearLinePrefixSymbol(arg_59_1.text_)

				local var_62_4 = 28
				local var_62_5 = utf8.len(var_62_3)
				local var_62_6 = var_62_4 <= 0 and var_62_1 or var_62_1 * (var_62_5 / var_62_4)

				if var_62_6 > 0 and var_62_1 < var_62_6 then
					arg_59_1.talkMaxDuration = var_62_6

					if var_62_6 + var_62_0 > arg_59_1.duration_ then
						arg_59_1.duration_ = var_62_6 + var_62_0
					end
				end

				arg_59_1.text_.text = var_62_3
				arg_59_1.typewritter.percent = 0

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(false)
				arg_59_1:RecordContent(arg_59_1.text_.text)
			end

			local var_62_7 = math.max(var_62_1, arg_59_1.talkMaxDuration)

			if var_62_0 <= arg_59_1.time_ and arg_59_1.time_ < var_62_0 + var_62_7 then
				arg_59_1.typewritter.percent = (arg_59_1.time_ - var_62_0) / var_62_7

				arg_59_1.typewritter:SetDirty()
			end

			if arg_59_1.time_ >= var_62_0 + var_62_7 and arg_59_1.time_ < var_62_0 + var_62_7 + arg_62_0 then
				arg_59_1.typewritter.percent = 1

				arg_59_1.typewritter:SetDirty()
				arg_59_1:ShowNextGo(true)
			end
		end
	end,
	Play411051016 = function(arg_63_0, arg_63_1)
		arg_63_1.time_ = 0
		arg_63_1.frameCnt_ = 0
		arg_63_1.state_ = "playing"
		arg_63_1.curTalkId_ = 411051016
		arg_63_1.duration_ = 9.1

		local var_63_0 = {
			zh = 8.633,
			ja = 9.1
		}
		local var_63_1 = manager.audio:GetLocalizationFlag()

		if var_63_0[var_63_1] ~= nil then
			arg_63_1.duration_ = var_63_0[var_63_1]
		end

		SetActive(arg_63_1.tipsGo_, false)

		function arg_63_1.onSingleLineFinish_()
			arg_63_1.onSingleLineUpdate_ = nil
			arg_63_1.onSingleLineFinish_ = nil
			arg_63_1.state_ = "waiting"
		end

		function arg_63_1.playNext_(arg_65_0)
			if arg_65_0 == 1 then
				arg_63_0:Play411051017(arg_63_1)
			end
		end

		function arg_63_1.onSingleLineUpdate_(arg_66_0)
			local var_66_0 = 0
			local var_66_1 = 1.025

			if var_66_0 < arg_63_1.time_ and arg_63_1.time_ <= var_66_0 + arg_66_0 then
				arg_63_1.talkMaxDuration = 0
				arg_63_1.dialogCg_.alpha = 1

				arg_63_1.dialog_:SetActive(true)
				SetActive(arg_63_1.leftNameGo_, true)

				local var_66_2 = arg_63_1:FormatText(StoryNameCfg[670].name)

				arg_63_1.leftNameTxt_.text = var_66_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_63_1.leftNameTxt_.transform)

				arg_63_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_63_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_63_1:RecordName(arg_63_1.leftNameTxt_.text)
				SetActive(arg_63_1.iconTrs_.gameObject, true)
				arg_63_1.iconController_:SetSelectedState("hero")

				arg_63_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_63_1.callingController_:SetSelectedState("calling")

				local var_66_3 = arg_63_1:GetWordFromCfg(411051016)
				local var_66_4 = arg_63_1:FormatText(var_66_3.content)

				arg_63_1.text_.text = var_66_4

				LuaForUtil.ClearLinePrefixSymbol(arg_63_1.text_)

				local var_66_5 = 41
				local var_66_6 = utf8.len(var_66_4)
				local var_66_7 = var_66_5 <= 0 and var_66_1 or var_66_1 * (var_66_6 / var_66_5)

				if var_66_7 > 0 and var_66_1 < var_66_7 then
					arg_63_1.talkMaxDuration = var_66_7

					if var_66_7 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_7 + var_66_0
					end
				end

				arg_63_1.text_.text = var_66_4
				arg_63_1.typewritter.percent = 0

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") ~= 0 then
					local var_66_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051016", "story_v_out_411051.awb") / 1000

					if var_66_8 + var_66_0 > arg_63_1.duration_ then
						arg_63_1.duration_ = var_66_8 + var_66_0
					end

					if var_66_3.prefab_name ~= "" and arg_63_1.actors_[var_66_3.prefab_name] ~= nil then
						local var_66_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_63_1.actors_[var_66_3.prefab_name].transform, "story_v_out_411051", "411051016", "story_v_out_411051.awb")

						arg_63_1:RecordAudio("411051016", var_66_9)
						arg_63_1:RecordAudio("411051016", var_66_9)
					else
						arg_63_1:AudioAction("play", "voice", "story_v_out_411051", "411051016", "story_v_out_411051.awb")
					end

					arg_63_1:RecordHistoryTalkVoice("story_v_out_411051", "411051016", "story_v_out_411051.awb")
				end

				arg_63_1:RecordContent(arg_63_1.text_.text)
			end

			local var_66_10 = math.max(var_66_1, arg_63_1.talkMaxDuration)

			if var_66_0 <= arg_63_1.time_ and arg_63_1.time_ < var_66_0 + var_66_10 then
				arg_63_1.typewritter.percent = (arg_63_1.time_ - var_66_0) / var_66_10

				arg_63_1.typewritter:SetDirty()
			end

			if arg_63_1.time_ >= var_66_0 + var_66_10 and arg_63_1.time_ < var_66_0 + var_66_10 + arg_66_0 then
				arg_63_1.typewritter.percent = 1

				arg_63_1.typewritter:SetDirty()
				arg_63_1:ShowNextGo(true)
			end
		end
	end,
	Play411051017 = function(arg_67_0, arg_67_1)
		arg_67_1.time_ = 0
		arg_67_1.frameCnt_ = 0
		arg_67_1.state_ = "playing"
		arg_67_1.curTalkId_ = 411051017
		arg_67_1.duration_ = 7.9

		local var_67_0 = {
			zh = 6.8,
			ja = 7.9
		}
		local var_67_1 = manager.audio:GetLocalizationFlag()

		if var_67_0[var_67_1] ~= nil then
			arg_67_1.duration_ = var_67_0[var_67_1]
		end

		SetActive(arg_67_1.tipsGo_, false)

		function arg_67_1.onSingleLineFinish_()
			arg_67_1.onSingleLineUpdate_ = nil
			arg_67_1.onSingleLineFinish_ = nil
			arg_67_1.state_ = "waiting"
		end

		function arg_67_1.playNext_(arg_69_0)
			if arg_69_0 == 1 then
				arg_67_0:Play411051018(arg_67_1)
			end
		end

		function arg_67_1.onSingleLineUpdate_(arg_70_0)
			local var_70_0 = 0
			local var_70_1 = 0.85

			if var_70_0 < arg_67_1.time_ and arg_67_1.time_ <= var_70_0 + arg_70_0 then
				arg_67_1.talkMaxDuration = 0
				arg_67_1.dialogCg_.alpha = 1

				arg_67_1.dialog_:SetActive(true)
				SetActive(arg_67_1.leftNameGo_, true)

				local var_70_2 = arg_67_1:FormatText(StoryNameCfg[670].name)

				arg_67_1.leftNameTxt_.text = var_70_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_67_1.leftNameTxt_.transform)

				arg_67_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_67_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_67_1:RecordName(arg_67_1.leftNameTxt_.text)
				SetActive(arg_67_1.iconTrs_.gameObject, true)
				arg_67_1.iconController_:SetSelectedState("hero")

				arg_67_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10071")

				arg_67_1.callingController_:SetSelectedState("calling")

				local var_70_3 = arg_67_1:GetWordFromCfg(411051017)
				local var_70_4 = arg_67_1:FormatText(var_70_3.content)

				arg_67_1.text_.text = var_70_4

				LuaForUtil.ClearLinePrefixSymbol(arg_67_1.text_)

				local var_70_5 = 34
				local var_70_6 = utf8.len(var_70_4)
				local var_70_7 = var_70_5 <= 0 and var_70_1 or var_70_1 * (var_70_6 / var_70_5)

				if var_70_7 > 0 and var_70_1 < var_70_7 then
					arg_67_1.talkMaxDuration = var_70_7

					if var_70_7 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_7 + var_70_0
					end
				end

				arg_67_1.text_.text = var_70_4
				arg_67_1.typewritter.percent = 0

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") ~= 0 then
					local var_70_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051017", "story_v_out_411051.awb") / 1000

					if var_70_8 + var_70_0 > arg_67_1.duration_ then
						arg_67_1.duration_ = var_70_8 + var_70_0
					end

					if var_70_3.prefab_name ~= "" and arg_67_1.actors_[var_70_3.prefab_name] ~= nil then
						local var_70_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_67_1.actors_[var_70_3.prefab_name].transform, "story_v_out_411051", "411051017", "story_v_out_411051.awb")

						arg_67_1:RecordAudio("411051017", var_70_9)
						arg_67_1:RecordAudio("411051017", var_70_9)
					else
						arg_67_1:AudioAction("play", "voice", "story_v_out_411051", "411051017", "story_v_out_411051.awb")
					end

					arg_67_1:RecordHistoryTalkVoice("story_v_out_411051", "411051017", "story_v_out_411051.awb")
				end

				arg_67_1:RecordContent(arg_67_1.text_.text)
			end

			local var_70_10 = math.max(var_70_1, arg_67_1.talkMaxDuration)

			if var_70_0 <= arg_67_1.time_ and arg_67_1.time_ < var_70_0 + var_70_10 then
				arg_67_1.typewritter.percent = (arg_67_1.time_ - var_70_0) / var_70_10

				arg_67_1.typewritter:SetDirty()
			end

			if arg_67_1.time_ >= var_70_0 + var_70_10 and arg_67_1.time_ < var_70_0 + var_70_10 + arg_70_0 then
				arg_67_1.typewritter.percent = 1

				arg_67_1.typewritter:SetDirty()
				arg_67_1:ShowNextGo(true)
			end
		end
	end,
	Play411051018 = function(arg_71_0, arg_71_1)
		arg_71_1.time_ = 0
		arg_71_1.frameCnt_ = 0
		arg_71_1.state_ = "playing"
		arg_71_1.curTalkId_ = 411051018
		arg_71_1.duration_ = 7.566

		local var_71_0 = {
			zh = 7.566,
			ja = 6.766
		}
		local var_71_1 = manager.audio:GetLocalizationFlag()

		if var_71_0[var_71_1] ~= nil then
			arg_71_1.duration_ = var_71_0[var_71_1]
		end

		SetActive(arg_71_1.tipsGo_, false)

		function arg_71_1.onSingleLineFinish_()
			arg_71_1.onSingleLineUpdate_ = nil
			arg_71_1.onSingleLineFinish_ = nil
			arg_71_1.state_ = "waiting"
		end

		function arg_71_1.playNext_(arg_73_0)
			if arg_73_0 == 1 then
				arg_71_0:Play411051019(arg_71_1)
			end
		end

		function arg_71_1.onSingleLineUpdate_(arg_74_0)
			local var_74_0 = arg_71_1.actors_["10058ui_story"].transform
			local var_74_1 = 0

			if var_74_1 < arg_71_1.time_ and arg_71_1.time_ <= var_74_1 + arg_74_0 then
				arg_71_1.var_.moveOldPos10058ui_story = var_74_0.localPosition
			end

			local var_74_2 = 0.001

			if var_74_1 <= arg_71_1.time_ and arg_71_1.time_ < var_74_1 + var_74_2 then
				local var_74_3 = (arg_71_1.time_ - var_74_1) / var_74_2
				local var_74_4 = Vector3.New(0, -0.98, -6.1)

				var_74_0.localPosition = Vector3.Lerp(arg_71_1.var_.moveOldPos10058ui_story, var_74_4, var_74_3)

				local var_74_5 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_5.x, var_74_5.y, var_74_5.z)

				local var_74_6 = var_74_0.localEulerAngles

				var_74_6.z = 0
				var_74_6.x = 0
				var_74_0.localEulerAngles = var_74_6
			end

			if arg_71_1.time_ >= var_74_1 + var_74_2 and arg_71_1.time_ < var_74_1 + var_74_2 + arg_74_0 then
				var_74_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_74_7 = manager.ui.mainCamera.transform.position - var_74_0.position

				var_74_0.forward = Vector3.New(var_74_7.x, var_74_7.y, var_74_7.z)

				local var_74_8 = var_74_0.localEulerAngles

				var_74_8.z = 0
				var_74_8.x = 0
				var_74_0.localEulerAngles = var_74_8
			end

			local var_74_9 = arg_71_1.actors_["10058ui_story"]
			local var_74_10 = 0

			if var_74_10 < arg_71_1.time_ and arg_71_1.time_ <= var_74_10 + arg_74_0 and arg_71_1.var_.characterEffect10058ui_story == nil then
				arg_71_1.var_.characterEffect10058ui_story = var_74_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_74_11 = 0.200000002980232

			if var_74_10 <= arg_71_1.time_ and arg_71_1.time_ < var_74_10 + var_74_11 then
				local var_74_12 = (arg_71_1.time_ - var_74_10) / var_74_11

				if arg_71_1.var_.characterEffect10058ui_story then
					arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_71_1.time_ >= var_74_10 + var_74_11 and arg_71_1.time_ < var_74_10 + var_74_11 + arg_74_0 and arg_71_1.var_.characterEffect10058ui_story then
				arg_71_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_74_13 = 0

			if var_74_13 < arg_71_1.time_ and arg_71_1.time_ <= var_74_13 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_74_14 = 0

			if var_74_14 < arg_71_1.time_ and arg_71_1.time_ <= var_74_14 + arg_74_0 then
				arg_71_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_74_15 = 0
			local var_74_16 = 0.525

			if var_74_15 < arg_71_1.time_ and arg_71_1.time_ <= var_74_15 + arg_74_0 then
				arg_71_1.talkMaxDuration = 0
				arg_71_1.dialogCg_.alpha = 1

				arg_71_1.dialog_:SetActive(true)
				SetActive(arg_71_1.leftNameGo_, true)

				local var_74_17 = arg_71_1:FormatText(StoryNameCfg[471].name)

				arg_71_1.leftNameTxt_.text = var_74_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_71_1.leftNameTxt_.transform)

				arg_71_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_71_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_71_1:RecordName(arg_71_1.leftNameTxt_.text)
				SetActive(arg_71_1.iconTrs_.gameObject, false)
				arg_71_1.callingController_:SetSelectedState("normal")

				local var_74_18 = arg_71_1:GetWordFromCfg(411051018)
				local var_74_19 = arg_71_1:FormatText(var_74_18.content)

				arg_71_1.text_.text = var_74_19

				LuaForUtil.ClearLinePrefixSymbol(arg_71_1.text_)

				local var_74_20 = 21
				local var_74_21 = utf8.len(var_74_19)
				local var_74_22 = var_74_20 <= 0 and var_74_16 or var_74_16 * (var_74_21 / var_74_20)

				if var_74_22 > 0 and var_74_16 < var_74_22 then
					arg_71_1.talkMaxDuration = var_74_22

					if var_74_22 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_22 + var_74_15
					end
				end

				arg_71_1.text_.text = var_74_19
				arg_71_1.typewritter.percent = 0

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") ~= 0 then
					local var_74_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051018", "story_v_out_411051.awb") / 1000

					if var_74_23 + var_74_15 > arg_71_1.duration_ then
						arg_71_1.duration_ = var_74_23 + var_74_15
					end

					if var_74_18.prefab_name ~= "" and arg_71_1.actors_[var_74_18.prefab_name] ~= nil then
						local var_74_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_71_1.actors_[var_74_18.prefab_name].transform, "story_v_out_411051", "411051018", "story_v_out_411051.awb")

						arg_71_1:RecordAudio("411051018", var_74_24)
						arg_71_1:RecordAudio("411051018", var_74_24)
					else
						arg_71_1:AudioAction("play", "voice", "story_v_out_411051", "411051018", "story_v_out_411051.awb")
					end

					arg_71_1:RecordHistoryTalkVoice("story_v_out_411051", "411051018", "story_v_out_411051.awb")
				end

				arg_71_1:RecordContent(arg_71_1.text_.text)
			end

			local var_74_25 = math.max(var_74_16, arg_71_1.talkMaxDuration)

			if var_74_15 <= arg_71_1.time_ and arg_71_1.time_ < var_74_15 + var_74_25 then
				arg_71_1.typewritter.percent = (arg_71_1.time_ - var_74_15) / var_74_25

				arg_71_1.typewritter:SetDirty()
			end

			if arg_71_1.time_ >= var_74_15 + var_74_25 and arg_71_1.time_ < var_74_15 + var_74_25 + arg_74_0 then
				arg_71_1.typewritter.percent = 1

				arg_71_1.typewritter:SetDirty()
				arg_71_1:ShowNextGo(true)
			end
		end
	end,
	Play411051019 = function(arg_75_0, arg_75_1)
		arg_75_1.time_ = 0
		arg_75_1.frameCnt_ = 0
		arg_75_1.state_ = "playing"
		arg_75_1.curTalkId_ = 411051019
		arg_75_1.duration_ = 10

		local var_75_0 = {
			zh = 6.833,
			ja = 10
		}
		local var_75_1 = manager.audio:GetLocalizationFlag()

		if var_75_0[var_75_1] ~= nil then
			arg_75_1.duration_ = var_75_0[var_75_1]
		end

		SetActive(arg_75_1.tipsGo_, false)

		function arg_75_1.onSingleLineFinish_()
			arg_75_1.onSingleLineUpdate_ = nil
			arg_75_1.onSingleLineFinish_ = nil
			arg_75_1.state_ = "waiting"
		end

		function arg_75_1.playNext_(arg_77_0)
			if arg_77_0 == 1 then
				arg_75_0:Play411051020(arg_75_1)
			end
		end

		function arg_75_1.onSingleLineUpdate_(arg_78_0)
			local var_78_0 = 0
			local var_78_1 = 0.6

			if var_78_0 < arg_75_1.time_ and arg_75_1.time_ <= var_78_0 + arg_78_0 then
				arg_75_1.talkMaxDuration = 0
				arg_75_1.dialogCg_.alpha = 1

				arg_75_1.dialog_:SetActive(true)
				SetActive(arg_75_1.leftNameGo_, true)

				local var_78_2 = arg_75_1:FormatText(StoryNameCfg[471].name)

				arg_75_1.leftNameTxt_.text = var_78_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_75_1.leftNameTxt_.transform)

				arg_75_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_75_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_75_1:RecordName(arg_75_1.leftNameTxt_.text)
				SetActive(arg_75_1.iconTrs_.gameObject, false)
				arg_75_1.callingController_:SetSelectedState("normal")

				local var_78_3 = arg_75_1:GetWordFromCfg(411051019)
				local var_78_4 = arg_75_1:FormatText(var_78_3.content)

				arg_75_1.text_.text = var_78_4

				LuaForUtil.ClearLinePrefixSymbol(arg_75_1.text_)

				local var_78_5 = 24
				local var_78_6 = utf8.len(var_78_4)
				local var_78_7 = var_78_5 <= 0 and var_78_1 or var_78_1 * (var_78_6 / var_78_5)

				if var_78_7 > 0 and var_78_1 < var_78_7 then
					arg_75_1.talkMaxDuration = var_78_7

					if var_78_7 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_7 + var_78_0
					end
				end

				arg_75_1.text_.text = var_78_4
				arg_75_1.typewritter.percent = 0

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") ~= 0 then
					local var_78_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051019", "story_v_out_411051.awb") / 1000

					if var_78_8 + var_78_0 > arg_75_1.duration_ then
						arg_75_1.duration_ = var_78_8 + var_78_0
					end

					if var_78_3.prefab_name ~= "" and arg_75_1.actors_[var_78_3.prefab_name] ~= nil then
						local var_78_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_75_1.actors_[var_78_3.prefab_name].transform, "story_v_out_411051", "411051019", "story_v_out_411051.awb")

						arg_75_1:RecordAudio("411051019", var_78_9)
						arg_75_1:RecordAudio("411051019", var_78_9)
					else
						arg_75_1:AudioAction("play", "voice", "story_v_out_411051", "411051019", "story_v_out_411051.awb")
					end

					arg_75_1:RecordHistoryTalkVoice("story_v_out_411051", "411051019", "story_v_out_411051.awb")
				end

				arg_75_1:RecordContent(arg_75_1.text_.text)
			end

			local var_78_10 = math.max(var_78_1, arg_75_1.talkMaxDuration)

			if var_78_0 <= arg_75_1.time_ and arg_75_1.time_ < var_78_0 + var_78_10 then
				arg_75_1.typewritter.percent = (arg_75_1.time_ - var_78_0) / var_78_10

				arg_75_1.typewritter:SetDirty()
			end

			if arg_75_1.time_ >= var_78_0 + var_78_10 and arg_75_1.time_ < var_78_0 + var_78_10 + arg_78_0 then
				arg_75_1.typewritter.percent = 1

				arg_75_1.typewritter:SetDirty()
				arg_75_1:ShowNextGo(true)
			end
		end
	end,
	Play411051020 = function(arg_79_0, arg_79_1)
		arg_79_1.time_ = 0
		arg_79_1.frameCnt_ = 0
		arg_79_1.state_ = "playing"
		arg_79_1.curTalkId_ = 411051020
		arg_79_1.duration_ = 5

		SetActive(arg_79_1.tipsGo_, false)

		function arg_79_1.onSingleLineFinish_()
			arg_79_1.onSingleLineUpdate_ = nil
			arg_79_1.onSingleLineFinish_ = nil
			arg_79_1.state_ = "waiting"
		end

		function arg_79_1.playNext_(arg_81_0)
			if arg_81_0 == 1 then
				arg_79_0:Play411051021(arg_79_1)
			end
		end

		function arg_79_1.onSingleLineUpdate_(arg_82_0)
			local var_82_0 = arg_79_1.actors_["10058ui_story"]
			local var_82_1 = 0

			if var_82_1 < arg_79_1.time_ and arg_79_1.time_ <= var_82_1 + arg_82_0 and arg_79_1.var_.characterEffect10058ui_story == nil then
				arg_79_1.var_.characterEffect10058ui_story = var_82_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_82_2 = 0.200000002980232

			if var_82_1 <= arg_79_1.time_ and arg_79_1.time_ < var_82_1 + var_82_2 then
				local var_82_3 = (arg_79_1.time_ - var_82_1) / var_82_2

				if arg_79_1.var_.characterEffect10058ui_story then
					local var_82_4 = Mathf.Lerp(0, 0.5, var_82_3)

					arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_79_1.var_.characterEffect10058ui_story.fillRatio = var_82_4
				end
			end

			if arg_79_1.time_ >= var_82_1 + var_82_2 and arg_79_1.time_ < var_82_1 + var_82_2 + arg_82_0 and arg_79_1.var_.characterEffect10058ui_story then
				local var_82_5 = 0.5

				arg_79_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_79_1.var_.characterEffect10058ui_story.fillRatio = var_82_5
			end

			local var_82_6 = 0
			local var_82_7 = 1.275

			if var_82_6 < arg_79_1.time_ and arg_79_1.time_ <= var_82_6 + arg_82_0 then
				arg_79_1.talkMaxDuration = 0
				arg_79_1.dialogCg_.alpha = 1

				arg_79_1.dialog_:SetActive(true)
				SetActive(arg_79_1.leftNameGo_, false)

				arg_79_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_79_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_79_1:RecordName(arg_79_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_79_1.iconTrs_.gameObject, false)
				arg_79_1.callingController_:SetSelectedState("normal")

				local var_82_8 = arg_79_1:GetWordFromCfg(411051020)
				local var_82_9 = arg_79_1:FormatText(var_82_8.content)

				arg_79_1.text_.text = var_82_9

				LuaForUtil.ClearLinePrefixSymbol(arg_79_1.text_)

				local var_82_10 = 51
				local var_82_11 = utf8.len(var_82_9)
				local var_82_12 = var_82_10 <= 0 and var_82_7 or var_82_7 * (var_82_11 / var_82_10)

				if var_82_12 > 0 and var_82_7 < var_82_12 then
					arg_79_1.talkMaxDuration = var_82_12

					if var_82_12 + var_82_6 > arg_79_1.duration_ then
						arg_79_1.duration_ = var_82_12 + var_82_6
					end
				end

				arg_79_1.text_.text = var_82_9
				arg_79_1.typewritter.percent = 0

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(false)
				arg_79_1:RecordContent(arg_79_1.text_.text)
			end

			local var_82_13 = math.max(var_82_7, arg_79_1.talkMaxDuration)

			if var_82_6 <= arg_79_1.time_ and arg_79_1.time_ < var_82_6 + var_82_13 then
				arg_79_1.typewritter.percent = (arg_79_1.time_ - var_82_6) / var_82_13

				arg_79_1.typewritter:SetDirty()
			end

			if arg_79_1.time_ >= var_82_6 + var_82_13 and arg_79_1.time_ < var_82_6 + var_82_13 + arg_82_0 then
				arg_79_1.typewritter.percent = 1

				arg_79_1.typewritter:SetDirty()
				arg_79_1:ShowNextGo(true)
			end
		end
	end,
	Play411051021 = function(arg_83_0, arg_83_1)
		arg_83_1.time_ = 0
		arg_83_1.frameCnt_ = 0
		arg_83_1.state_ = "playing"
		arg_83_1.curTalkId_ = 411051021
		arg_83_1.duration_ = 5

		SetActive(arg_83_1.tipsGo_, false)

		function arg_83_1.onSingleLineFinish_()
			arg_83_1.onSingleLineUpdate_ = nil
			arg_83_1.onSingleLineFinish_ = nil
			arg_83_1.state_ = "waiting"
		end

		function arg_83_1.playNext_(arg_85_0)
			if arg_85_0 == 1 then
				arg_83_0:Play411051022(arg_83_1)
			end
		end

		function arg_83_1.onSingleLineUpdate_(arg_86_0)
			local var_86_0 = 0
			local var_86_1 = 0.7

			if var_86_0 < arg_83_1.time_ and arg_83_1.time_ <= var_86_0 + arg_86_0 then
				arg_83_1.talkMaxDuration = 0
				arg_83_1.dialogCg_.alpha = 1

				arg_83_1.dialog_:SetActive(true)
				SetActive(arg_83_1.leftNameGo_, false)

				arg_83_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_83_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_83_1:RecordName(arg_83_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_83_1.iconTrs_.gameObject, false)
				arg_83_1.callingController_:SetSelectedState("normal")

				local var_86_2 = arg_83_1:GetWordFromCfg(411051021)
				local var_86_3 = arg_83_1:FormatText(var_86_2.content)

				arg_83_1.text_.text = var_86_3

				LuaForUtil.ClearLinePrefixSymbol(arg_83_1.text_)

				local var_86_4 = 28
				local var_86_5 = utf8.len(var_86_3)
				local var_86_6 = var_86_4 <= 0 and var_86_1 or var_86_1 * (var_86_5 / var_86_4)

				if var_86_6 > 0 and var_86_1 < var_86_6 then
					arg_83_1.talkMaxDuration = var_86_6

					if var_86_6 + var_86_0 > arg_83_1.duration_ then
						arg_83_1.duration_ = var_86_6 + var_86_0
					end
				end

				arg_83_1.text_.text = var_86_3
				arg_83_1.typewritter.percent = 0

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(false)
				arg_83_1:RecordContent(arg_83_1.text_.text)
			end

			local var_86_7 = math.max(var_86_1, arg_83_1.talkMaxDuration)

			if var_86_0 <= arg_83_1.time_ and arg_83_1.time_ < var_86_0 + var_86_7 then
				arg_83_1.typewritter.percent = (arg_83_1.time_ - var_86_0) / var_86_7

				arg_83_1.typewritter:SetDirty()
			end

			if arg_83_1.time_ >= var_86_0 + var_86_7 and arg_83_1.time_ < var_86_0 + var_86_7 + arg_86_0 then
				arg_83_1.typewritter.percent = 1

				arg_83_1.typewritter:SetDirty()
				arg_83_1:ShowNextGo(true)
			end
		end
	end,
	Play411051022 = function(arg_87_0, arg_87_1)
		arg_87_1.time_ = 0
		arg_87_1.frameCnt_ = 0
		arg_87_1.state_ = "playing"
		arg_87_1.curTalkId_ = 411051022
		arg_87_1.duration_ = 8.1

		local var_87_0 = {
			zh = 8.1,
			ja = 7.8
		}
		local var_87_1 = manager.audio:GetLocalizationFlag()

		if var_87_0[var_87_1] ~= nil then
			arg_87_1.duration_ = var_87_0[var_87_1]
		end

		SetActive(arg_87_1.tipsGo_, false)

		function arg_87_1.onSingleLineFinish_()
			arg_87_1.onSingleLineUpdate_ = nil
			arg_87_1.onSingleLineFinish_ = nil
			arg_87_1.state_ = "waiting"
		end

		function arg_87_1.playNext_(arg_89_0)
			if arg_89_0 == 1 then
				arg_87_0:Play411051023(arg_87_1)
			end
		end

		function arg_87_1.onSingleLineUpdate_(arg_90_0)
			local var_90_0 = "ST03"

			if arg_87_1.bgs_[var_90_0] == nil then
				local var_90_1 = Object.Instantiate(arg_87_1.paintGo_)

				var_90_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_90_0)
				var_90_1.name = var_90_0
				var_90_1.transform.parent = arg_87_1.stage_.transform
				var_90_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_87_1.bgs_[var_90_0] = var_90_1
			end

			local var_90_2 = 2

			if var_90_2 < arg_87_1.time_ and arg_87_1.time_ <= var_90_2 + arg_90_0 then
				local var_90_3 = manager.ui.mainCamera.transform.localPosition
				local var_90_4 = Vector3.New(0, 0, 10) + Vector3.New(var_90_3.x, var_90_3.y, 0)
				local var_90_5 = arg_87_1.bgs_.ST03

				var_90_5.transform.localPosition = var_90_4
				var_90_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_90_6 = var_90_5:GetComponent("SpriteRenderer")

				if var_90_6 and var_90_6.sprite then
					local var_90_7 = (var_90_5.transform.localPosition - var_90_3).z
					local var_90_8 = manager.ui.mainCameraCom_
					local var_90_9 = 2 * var_90_7 * Mathf.Tan(var_90_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_90_10 = var_90_9 * var_90_8.aspect
					local var_90_11 = var_90_6.sprite.bounds.size.x
					local var_90_12 = var_90_6.sprite.bounds.size.y
					local var_90_13 = var_90_10 / var_90_11
					local var_90_14 = var_90_9 / var_90_12
					local var_90_15 = var_90_14 < var_90_13 and var_90_13 or var_90_14

					var_90_5.transform.localScale = Vector3.New(var_90_15, var_90_15, 0)
				end

				for iter_90_0, iter_90_1 in pairs(arg_87_1.bgs_) do
					if iter_90_0 ~= "ST03" then
						iter_90_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_90_16 = 0

			if var_90_16 < arg_87_1.time_ and arg_87_1.time_ <= var_90_16 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_17 = 2

			if var_90_16 <= arg_87_1.time_ and arg_87_1.time_ < var_90_16 + var_90_17 then
				local var_90_18 = (arg_87_1.time_ - var_90_16) / var_90_17
				local var_90_19 = Color.New(0, 0, 0)

				var_90_19.a = Mathf.Lerp(0, 1, var_90_18)
				arg_87_1.mask_.color = var_90_19
			end

			if arg_87_1.time_ >= var_90_16 + var_90_17 and arg_87_1.time_ < var_90_16 + var_90_17 + arg_90_0 then
				local var_90_20 = Color.New(0, 0, 0)

				var_90_20.a = 1
				arg_87_1.mask_.color = var_90_20
			end

			local var_90_21 = 2

			if var_90_21 < arg_87_1.time_ and arg_87_1.time_ <= var_90_21 + arg_90_0 then
				arg_87_1.mask_.enabled = true
				arg_87_1.mask_.raycastTarget = true

				arg_87_1:SetGaussion(false)
			end

			local var_90_22 = 1.8

			if var_90_21 <= arg_87_1.time_ and arg_87_1.time_ < var_90_21 + var_90_22 then
				local var_90_23 = (arg_87_1.time_ - var_90_21) / var_90_22
				local var_90_24 = Color.New(0, 0, 0)

				var_90_24.a = Mathf.Lerp(1, 0, var_90_23)
				arg_87_1.mask_.color = var_90_24
			end

			if arg_87_1.time_ >= var_90_21 + var_90_22 and arg_87_1.time_ < var_90_21 + var_90_22 + arg_90_0 then
				local var_90_25 = Color.New(0, 0, 0)
				local var_90_26 = 0

				arg_87_1.mask_.enabled = false
				var_90_25.a = var_90_26
				arg_87_1.mask_.color = var_90_25
			end

			local var_90_27 = arg_87_1.actors_["10058ui_story"].transform
			local var_90_28 = 3.8

			if var_90_28 < arg_87_1.time_ and arg_87_1.time_ <= var_90_28 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = var_90_27.localPosition
			end

			local var_90_29 = 0.001

			if var_90_28 <= arg_87_1.time_ and arg_87_1.time_ < var_90_28 + var_90_29 then
				local var_90_30 = (arg_87_1.time_ - var_90_28) / var_90_29
				local var_90_31 = Vector3.New(0, -0.98, -6.1)

				var_90_27.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, var_90_31, var_90_30)

				local var_90_32 = manager.ui.mainCamera.transform.position - var_90_27.position

				var_90_27.forward = Vector3.New(var_90_32.x, var_90_32.y, var_90_32.z)

				local var_90_33 = var_90_27.localEulerAngles

				var_90_33.z = 0
				var_90_33.x = 0
				var_90_27.localEulerAngles = var_90_33
			end

			if arg_87_1.time_ >= var_90_28 + var_90_29 and arg_87_1.time_ < var_90_28 + var_90_29 + arg_90_0 then
				var_90_27.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_90_34 = manager.ui.mainCamera.transform.position - var_90_27.position

				var_90_27.forward = Vector3.New(var_90_34.x, var_90_34.y, var_90_34.z)

				local var_90_35 = var_90_27.localEulerAngles

				var_90_35.z = 0
				var_90_35.x = 0
				var_90_27.localEulerAngles = var_90_35
			end

			local var_90_36 = arg_87_1.actors_["10058ui_story"].transform
			local var_90_37 = 1.96599999815226

			if var_90_37 < arg_87_1.time_ and arg_87_1.time_ <= var_90_37 + arg_90_0 then
				arg_87_1.var_.moveOldPos10058ui_story = var_90_36.localPosition
			end

			local var_90_38 = 0.001

			if var_90_37 <= arg_87_1.time_ and arg_87_1.time_ < var_90_37 + var_90_38 then
				local var_90_39 = (arg_87_1.time_ - var_90_37) / var_90_38
				local var_90_40 = Vector3.New(0, 100, 0)

				var_90_36.localPosition = Vector3.Lerp(arg_87_1.var_.moveOldPos10058ui_story, var_90_40, var_90_39)

				local var_90_41 = manager.ui.mainCamera.transform.position - var_90_36.position

				var_90_36.forward = Vector3.New(var_90_41.x, var_90_41.y, var_90_41.z)

				local var_90_42 = var_90_36.localEulerAngles

				var_90_42.z = 0
				var_90_42.x = 0
				var_90_36.localEulerAngles = var_90_42
			end

			if arg_87_1.time_ >= var_90_37 + var_90_38 and arg_87_1.time_ < var_90_37 + var_90_38 + arg_90_0 then
				var_90_36.localPosition = Vector3.New(0, 100, 0)

				local var_90_43 = manager.ui.mainCamera.transform.position - var_90_36.position

				var_90_36.forward = Vector3.New(var_90_43.x, var_90_43.y, var_90_43.z)

				local var_90_44 = var_90_36.localEulerAngles

				var_90_44.z = 0
				var_90_44.x = 0
				var_90_36.localEulerAngles = var_90_44
			end

			local var_90_45 = arg_87_1.actors_["10058ui_story"]
			local var_90_46 = 3.8

			if var_90_46 < arg_87_1.time_ and arg_87_1.time_ <= var_90_46 + arg_90_0 and arg_87_1.var_.characterEffect10058ui_story == nil then
				arg_87_1.var_.characterEffect10058ui_story = var_90_45:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_90_47 = 0.200000002980232

			if var_90_46 <= arg_87_1.time_ and arg_87_1.time_ < var_90_46 + var_90_47 then
				local var_90_48 = (arg_87_1.time_ - var_90_46) / var_90_47

				if arg_87_1.var_.characterEffect10058ui_story then
					arg_87_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_87_1.time_ >= var_90_46 + var_90_47 and arg_87_1.time_ < var_90_46 + var_90_47 + arg_90_0 and arg_87_1.var_.characterEffect10058ui_story then
				arg_87_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_90_49 = 3.8

			if var_90_49 < arg_87_1.time_ and arg_87_1.time_ <= var_90_49 + arg_90_0 then
				arg_87_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_90_50 = 3.8

			if var_90_50 < arg_87_1.time_ and arg_87_1.time_ <= var_90_50 + arg_90_0 then
				arg_87_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			if arg_87_1.frameCnt_ <= 1 then
				arg_87_1.dialog_:SetActive(false)
			end

			local var_90_51 = 3.8
			local var_90_52 = 0.375

			if var_90_51 < arg_87_1.time_ and arg_87_1.time_ <= var_90_51 + arg_90_0 then
				arg_87_1.talkMaxDuration = 0

				arg_87_1.dialog_:SetActive(true)

				local var_90_53 = LeanTween.value(arg_87_1.dialog_, 0, 1, 0.3)

				var_90_53:setOnUpdate(LuaHelper.FloatAction(function(arg_91_0)
					arg_87_1.dialogCg_.alpha = arg_91_0
				end))
				var_90_53:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_87_1.dialog_)
					var_90_53:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_87_1.duration_ = arg_87_1.duration_ + 0.3

				SetActive(arg_87_1.leftNameGo_, true)

				local var_90_54 = arg_87_1:FormatText(StoryNameCfg[471].name)

				arg_87_1.leftNameTxt_.text = var_90_54

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_87_1.leftNameTxt_.transform)

				arg_87_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_87_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_87_1:RecordName(arg_87_1.leftNameTxt_.text)
				SetActive(arg_87_1.iconTrs_.gameObject, false)
				arg_87_1.callingController_:SetSelectedState("normal")

				local var_90_55 = arg_87_1:GetWordFromCfg(411051022)
				local var_90_56 = arg_87_1:FormatText(var_90_55.content)

				arg_87_1.text_.text = var_90_56

				LuaForUtil.ClearLinePrefixSymbol(arg_87_1.text_)

				local var_90_57 = 15
				local var_90_58 = utf8.len(var_90_56)
				local var_90_59 = var_90_57 <= 0 and var_90_52 or var_90_52 * (var_90_58 / var_90_57)

				if var_90_59 > 0 and var_90_52 < var_90_59 then
					arg_87_1.talkMaxDuration = var_90_59
					var_90_51 = var_90_51 + 0.3

					if var_90_59 + var_90_51 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_59 + var_90_51
					end
				end

				arg_87_1.text_.text = var_90_56
				arg_87_1.typewritter.percent = 0

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") ~= 0 then
					local var_90_60 = manager.audio:GetVoiceLength("story_v_out_411051", "411051022", "story_v_out_411051.awb") / 1000

					if var_90_60 + var_90_51 > arg_87_1.duration_ then
						arg_87_1.duration_ = var_90_60 + var_90_51
					end

					if var_90_55.prefab_name ~= "" and arg_87_1.actors_[var_90_55.prefab_name] ~= nil then
						local var_90_61 = LuaForUtil.PlayVoiceWithCriLipsync(arg_87_1.actors_[var_90_55.prefab_name].transform, "story_v_out_411051", "411051022", "story_v_out_411051.awb")

						arg_87_1:RecordAudio("411051022", var_90_61)
						arg_87_1:RecordAudio("411051022", var_90_61)
					else
						arg_87_1:AudioAction("play", "voice", "story_v_out_411051", "411051022", "story_v_out_411051.awb")
					end

					arg_87_1:RecordHistoryTalkVoice("story_v_out_411051", "411051022", "story_v_out_411051.awb")
				end

				arg_87_1:RecordContent(arg_87_1.text_.text)
			end

			local var_90_62 = var_90_51 + 0.3
			local var_90_63 = math.max(var_90_52, arg_87_1.talkMaxDuration)

			if var_90_62 <= arg_87_1.time_ and arg_87_1.time_ < var_90_62 + var_90_63 then
				arg_87_1.typewritter.percent = (arg_87_1.time_ - var_90_62) / var_90_63

				arg_87_1.typewritter:SetDirty()
			end

			if arg_87_1.time_ >= var_90_62 + var_90_63 and arg_87_1.time_ < var_90_62 + var_90_63 + arg_90_0 then
				arg_87_1.typewritter.percent = 1

				arg_87_1.typewritter:SetDirty()
				arg_87_1:ShowNextGo(true)
			end
		end
	end,
	Play411051023 = function(arg_93_0, arg_93_1)
		arg_93_1.time_ = 0
		arg_93_1.frameCnt_ = 0
		arg_93_1.state_ = "playing"
		arg_93_1.curTalkId_ = 411051023
		arg_93_1.duration_ = 4.1

		local var_93_0 = {
			zh = 3.266,
			ja = 4.1
		}
		local var_93_1 = manager.audio:GetLocalizationFlag()

		if var_93_0[var_93_1] ~= nil then
			arg_93_1.duration_ = var_93_0[var_93_1]
		end

		SetActive(arg_93_1.tipsGo_, false)

		function arg_93_1.onSingleLineFinish_()
			arg_93_1.onSingleLineUpdate_ = nil
			arg_93_1.onSingleLineFinish_ = nil
			arg_93_1.state_ = "waiting"
		end

		function arg_93_1.playNext_(arg_95_0)
			if arg_95_0 == 1 then
				arg_93_0:Play411051024(arg_93_1)
			end
		end

		function arg_93_1.onSingleLineUpdate_(arg_96_0)
			local var_96_0 = arg_93_1.actors_["10058ui_story"]
			local var_96_1 = 0

			if var_96_1 < arg_93_1.time_ and arg_93_1.time_ <= var_96_1 + arg_96_0 and arg_93_1.var_.characterEffect10058ui_story == nil then
				arg_93_1.var_.characterEffect10058ui_story = var_96_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_96_2 = 0.200000002980232

			if var_96_1 <= arg_93_1.time_ and arg_93_1.time_ < var_96_1 + var_96_2 then
				local var_96_3 = (arg_93_1.time_ - var_96_1) / var_96_2

				if arg_93_1.var_.characterEffect10058ui_story then
					local var_96_4 = Mathf.Lerp(0, 0.5, var_96_3)

					arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_93_1.var_.characterEffect10058ui_story.fillRatio = var_96_4
				end
			end

			if arg_93_1.time_ >= var_96_1 + var_96_2 and arg_93_1.time_ < var_96_1 + var_96_2 + arg_96_0 and arg_93_1.var_.characterEffect10058ui_story then
				local var_96_5 = 0.5

				arg_93_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_93_1.var_.characterEffect10058ui_story.fillRatio = var_96_5
			end

			local var_96_6 = 0
			local var_96_7 = 0.366666666666667

			if var_96_6 < arg_93_1.time_ and arg_93_1.time_ <= var_96_6 + arg_96_0 then
				local var_96_8 = "play"
				local var_96_9 = "music"

				arg_93_1:AudioAction(var_96_8, var_96_9, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_96_10 = 0
			local var_96_11 = 0.35

			if var_96_10 < arg_93_1.time_ and arg_93_1.time_ <= var_96_10 + arg_96_0 then
				arg_93_1.talkMaxDuration = 0
				arg_93_1.dialogCg_.alpha = 1

				arg_93_1.dialog_:SetActive(true)
				SetActive(arg_93_1.leftNameGo_, true)

				local var_96_12 = arg_93_1:FormatText(StoryNameCfg[264].name)

				arg_93_1.leftNameTxt_.text = var_96_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_93_1.leftNameTxt_.transform)

				arg_93_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_93_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_93_1:RecordName(arg_93_1.leftNameTxt_.text)
				SetActive(arg_93_1.iconTrs_.gameObject, true)
				arg_93_1.iconController_:SetSelectedState("hero")

				arg_93_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10014")

				arg_93_1.callingController_:SetSelectedState("calling")

				local var_96_13 = arg_93_1:GetWordFromCfg(411051023)
				local var_96_14 = arg_93_1:FormatText(var_96_13.content)

				arg_93_1.text_.text = var_96_14

				LuaForUtil.ClearLinePrefixSymbol(arg_93_1.text_)

				local var_96_15 = 14
				local var_96_16 = utf8.len(var_96_14)
				local var_96_17 = var_96_15 <= 0 and var_96_11 or var_96_11 * (var_96_16 / var_96_15)

				if var_96_17 > 0 and var_96_11 < var_96_17 then
					arg_93_1.talkMaxDuration = var_96_17

					if var_96_17 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_17 + var_96_10
					end
				end

				arg_93_1.text_.text = var_96_14
				arg_93_1.typewritter.percent = 0

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") ~= 0 then
					local var_96_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051023", "story_v_out_411051.awb") / 1000

					if var_96_18 + var_96_10 > arg_93_1.duration_ then
						arg_93_1.duration_ = var_96_18 + var_96_10
					end

					if var_96_13.prefab_name ~= "" and arg_93_1.actors_[var_96_13.prefab_name] ~= nil then
						local var_96_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_93_1.actors_[var_96_13.prefab_name].transform, "story_v_out_411051", "411051023", "story_v_out_411051.awb")

						arg_93_1:RecordAudio("411051023", var_96_19)
						arg_93_1:RecordAudio("411051023", var_96_19)
					else
						arg_93_1:AudioAction("play", "voice", "story_v_out_411051", "411051023", "story_v_out_411051.awb")
					end

					arg_93_1:RecordHistoryTalkVoice("story_v_out_411051", "411051023", "story_v_out_411051.awb")
				end

				arg_93_1:RecordContent(arg_93_1.text_.text)
			end

			local var_96_20 = math.max(var_96_11, arg_93_1.talkMaxDuration)

			if var_96_10 <= arg_93_1.time_ and arg_93_1.time_ < var_96_10 + var_96_20 then
				arg_93_1.typewritter.percent = (arg_93_1.time_ - var_96_10) / var_96_20

				arg_93_1.typewritter:SetDirty()
			end

			if arg_93_1.time_ >= var_96_10 + var_96_20 and arg_93_1.time_ < var_96_10 + var_96_20 + arg_96_0 then
				arg_93_1.typewritter.percent = 1

				arg_93_1.typewritter:SetDirty()
				arg_93_1:ShowNextGo(true)
			end
		end
	end,
	Play411051024 = function(arg_97_0, arg_97_1)
		arg_97_1.time_ = 0
		arg_97_1.frameCnt_ = 0
		arg_97_1.state_ = "playing"
		arg_97_1.curTalkId_ = 411051024
		arg_97_1.duration_ = 1.999999999999

		SetActive(arg_97_1.tipsGo_, false)

		function arg_97_1.onSingleLineFinish_()
			arg_97_1.onSingleLineUpdate_ = nil
			arg_97_1.onSingleLineFinish_ = nil
			arg_97_1.state_ = "waiting"
		end

		function arg_97_1.playNext_(arg_99_0)
			if arg_99_0 == 1 then
				arg_97_0:Play411051025(arg_97_1)
			end
		end

		function arg_97_1.onSingleLineUpdate_(arg_100_0)
			local var_100_0 = 0

			if var_100_0 < arg_97_1.time_ and arg_97_1.time_ <= var_100_0 + arg_100_0 then
				arg_97_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_100_1 = arg_97_1.actors_["10058ui_story"]
			local var_100_2 = 0

			if var_100_2 < arg_97_1.time_ and arg_97_1.time_ <= var_100_2 + arg_100_0 and arg_97_1.var_.characterEffect10058ui_story == nil then
				arg_97_1.var_.characterEffect10058ui_story = var_100_1:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_100_3 = 0.200000002980232

			if var_100_2 <= arg_97_1.time_ and arg_97_1.time_ < var_100_2 + var_100_3 then
				local var_100_4 = (arg_97_1.time_ - var_100_2) / var_100_3

				if arg_97_1.var_.characterEffect10058ui_story then
					arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_97_1.time_ >= var_100_2 + var_100_3 and arg_97_1.time_ < var_100_2 + var_100_3 + arg_100_0 and arg_97_1.var_.characterEffect10058ui_story then
				arg_97_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_100_5 = 0
			local var_100_6 = 0.05

			if var_100_5 < arg_97_1.time_ and arg_97_1.time_ <= var_100_5 + arg_100_0 then
				arg_97_1.talkMaxDuration = 0
				arg_97_1.dialogCg_.alpha = 1

				arg_97_1.dialog_:SetActive(true)
				SetActive(arg_97_1.leftNameGo_, true)

				local var_100_7 = arg_97_1:FormatText(StoryNameCfg[471].name)

				arg_97_1.leftNameTxt_.text = var_100_7

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_97_1.leftNameTxt_.transform)

				arg_97_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_97_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_97_1:RecordName(arg_97_1.leftNameTxt_.text)
				SetActive(arg_97_1.iconTrs_.gameObject, false)
				arg_97_1.callingController_:SetSelectedState("normal")

				local var_100_8 = arg_97_1:GetWordFromCfg(411051024)
				local var_100_9 = arg_97_1:FormatText(var_100_8.content)

				arg_97_1.text_.text = var_100_9

				LuaForUtil.ClearLinePrefixSymbol(arg_97_1.text_)

				local var_100_10 = 2
				local var_100_11 = utf8.len(var_100_9)
				local var_100_12 = var_100_10 <= 0 and var_100_6 or var_100_6 * (var_100_11 / var_100_10)

				if var_100_12 > 0 and var_100_6 < var_100_12 then
					arg_97_1.talkMaxDuration = var_100_12

					if var_100_12 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_12 + var_100_5
					end
				end

				arg_97_1.text_.text = var_100_9
				arg_97_1.typewritter.percent = 0

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") ~= 0 then
					local var_100_13 = manager.audio:GetVoiceLength("story_v_out_411051", "411051024", "story_v_out_411051.awb") / 1000

					if var_100_13 + var_100_5 > arg_97_1.duration_ then
						arg_97_1.duration_ = var_100_13 + var_100_5
					end

					if var_100_8.prefab_name ~= "" and arg_97_1.actors_[var_100_8.prefab_name] ~= nil then
						local var_100_14 = LuaForUtil.PlayVoiceWithCriLipsync(arg_97_1.actors_[var_100_8.prefab_name].transform, "story_v_out_411051", "411051024", "story_v_out_411051.awb")

						arg_97_1:RecordAudio("411051024", var_100_14)
						arg_97_1:RecordAudio("411051024", var_100_14)
					else
						arg_97_1:AudioAction("play", "voice", "story_v_out_411051", "411051024", "story_v_out_411051.awb")
					end

					arg_97_1:RecordHistoryTalkVoice("story_v_out_411051", "411051024", "story_v_out_411051.awb")
				end

				arg_97_1:RecordContent(arg_97_1.text_.text)
			end

			local var_100_15 = math.max(var_100_6, arg_97_1.talkMaxDuration)

			if var_100_5 <= arg_97_1.time_ and arg_97_1.time_ < var_100_5 + var_100_15 then
				arg_97_1.typewritter.percent = (arg_97_1.time_ - var_100_5) / var_100_15

				arg_97_1.typewritter:SetDirty()
			end

			if arg_97_1.time_ >= var_100_5 + var_100_15 and arg_97_1.time_ < var_100_5 + var_100_15 + arg_100_0 then
				arg_97_1.typewritter.percent = 1

				arg_97_1.typewritter:SetDirty()
				arg_97_1:ShowNextGo(true)
			end
		end
	end,
	Play411051025 = function(arg_101_0, arg_101_1)
		arg_101_1.time_ = 0
		arg_101_1.frameCnt_ = 0
		arg_101_1.state_ = "playing"
		arg_101_1.curTalkId_ = 411051025
		arg_101_1.duration_ = 5

		SetActive(arg_101_1.tipsGo_, false)

		function arg_101_1.onSingleLineFinish_()
			arg_101_1.onSingleLineUpdate_ = nil
			arg_101_1.onSingleLineFinish_ = nil
			arg_101_1.state_ = "waiting"
		end

		function arg_101_1.playNext_(arg_103_0)
			if arg_103_0 == 1 then
				arg_101_0:Play411051026(arg_101_1)
			end
		end

		function arg_101_1.onSingleLineUpdate_(arg_104_0)
			local var_104_0 = arg_101_1.actors_["10058ui_story"]
			local var_104_1 = 0

			if var_104_1 < arg_101_1.time_ and arg_101_1.time_ <= var_104_1 + arg_104_0 and arg_101_1.var_.characterEffect10058ui_story == nil then
				arg_101_1.var_.characterEffect10058ui_story = var_104_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_104_2 = 0.200000002980232

			if var_104_1 <= arg_101_1.time_ and arg_101_1.time_ < var_104_1 + var_104_2 then
				local var_104_3 = (arg_101_1.time_ - var_104_1) / var_104_2

				if arg_101_1.var_.characterEffect10058ui_story then
					local var_104_4 = Mathf.Lerp(0, 0.5, var_104_3)

					arg_101_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_101_1.var_.characterEffect10058ui_story.fillRatio = var_104_4
				end
			end

			if arg_101_1.time_ >= var_104_1 + var_104_2 and arg_101_1.time_ < var_104_1 + var_104_2 + arg_104_0 and arg_101_1.var_.characterEffect10058ui_story then
				local var_104_5 = 0.5

				arg_101_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_101_1.var_.characterEffect10058ui_story.fillRatio = var_104_5
			end

			local var_104_6 = arg_101_1.actors_["10058ui_story"].transform
			local var_104_7 = 0

			if var_104_7 < arg_101_1.time_ and arg_101_1.time_ <= var_104_7 + arg_104_0 then
				arg_101_1.var_.moveOldPos10058ui_story = var_104_6.localPosition
			end

			local var_104_8 = 0.001

			if var_104_7 <= arg_101_1.time_ and arg_101_1.time_ < var_104_7 + var_104_8 then
				local var_104_9 = (arg_101_1.time_ - var_104_7) / var_104_8
				local var_104_10 = Vector3.New(0, 100, 0)

				var_104_6.localPosition = Vector3.Lerp(arg_101_1.var_.moveOldPos10058ui_story, var_104_10, var_104_9)

				local var_104_11 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_11.x, var_104_11.y, var_104_11.z)

				local var_104_12 = var_104_6.localEulerAngles

				var_104_12.z = 0
				var_104_12.x = 0
				var_104_6.localEulerAngles = var_104_12
			end

			if arg_101_1.time_ >= var_104_7 + var_104_8 and arg_101_1.time_ < var_104_7 + var_104_8 + arg_104_0 then
				var_104_6.localPosition = Vector3.New(0, 100, 0)

				local var_104_13 = manager.ui.mainCamera.transform.position - var_104_6.position

				var_104_6.forward = Vector3.New(var_104_13.x, var_104_13.y, var_104_13.z)

				local var_104_14 = var_104_6.localEulerAngles

				var_104_14.z = 0
				var_104_14.x = 0
				var_104_6.localEulerAngles = var_104_14
			end

			local var_104_15 = 0
			local var_104_16 = 0.95

			if var_104_15 < arg_101_1.time_ and arg_101_1.time_ <= var_104_15 + arg_104_0 then
				arg_101_1.talkMaxDuration = 0
				arg_101_1.dialogCg_.alpha = 1

				arg_101_1.dialog_:SetActive(true)
				SetActive(arg_101_1.leftNameGo_, false)

				arg_101_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_101_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_101_1:RecordName(arg_101_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_101_1.iconTrs_.gameObject, false)
				arg_101_1.callingController_:SetSelectedState("normal")

				local var_104_17 = arg_101_1:GetWordFromCfg(411051025)
				local var_104_18 = arg_101_1:FormatText(var_104_17.content)

				arg_101_1.text_.text = var_104_18

				LuaForUtil.ClearLinePrefixSymbol(arg_101_1.text_)

				local var_104_19 = 38
				local var_104_20 = utf8.len(var_104_18)
				local var_104_21 = var_104_19 <= 0 and var_104_16 or var_104_16 * (var_104_20 / var_104_19)

				if var_104_21 > 0 and var_104_16 < var_104_21 then
					arg_101_1.talkMaxDuration = var_104_21

					if var_104_21 + var_104_15 > arg_101_1.duration_ then
						arg_101_1.duration_ = var_104_21 + var_104_15
					end
				end

				arg_101_1.text_.text = var_104_18
				arg_101_1.typewritter.percent = 0

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(false)
				arg_101_1:RecordContent(arg_101_1.text_.text)
			end

			local var_104_22 = math.max(var_104_16, arg_101_1.talkMaxDuration)

			if var_104_15 <= arg_101_1.time_ and arg_101_1.time_ < var_104_15 + var_104_22 then
				arg_101_1.typewritter.percent = (arg_101_1.time_ - var_104_15) / var_104_22

				arg_101_1.typewritter:SetDirty()
			end

			if arg_101_1.time_ >= var_104_15 + var_104_22 and arg_101_1.time_ < var_104_15 + var_104_22 + arg_104_0 then
				arg_101_1.typewritter.percent = 1

				arg_101_1.typewritter:SetDirty()
				arg_101_1:ShowNextGo(true)
			end
		end
	end,
	Play411051026 = function(arg_105_0, arg_105_1)
		arg_105_1.time_ = 0
		arg_105_1.frameCnt_ = 0
		arg_105_1.state_ = "playing"
		arg_105_1.curTalkId_ = 411051026
		arg_105_1.duration_ = 5.56666666666667

		SetActive(arg_105_1.tipsGo_, false)

		function arg_105_1.onSingleLineFinish_()
			arg_105_1.onSingleLineUpdate_ = nil
			arg_105_1.onSingleLineFinish_ = nil
			arg_105_1.state_ = "waiting"
		end

		function arg_105_1.playNext_(arg_107_0)
			if arg_107_0 == 1 then
				arg_105_0:Play411051027(arg_105_1)
			end
		end

		function arg_105_1.onSingleLineUpdate_(arg_108_0)
			local var_108_0 = "I07"

			if arg_105_1.bgs_[var_108_0] == nil then
				local var_108_1 = Object.Instantiate(arg_105_1.paintGo_)

				var_108_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_108_0)
				var_108_1.name = var_108_0
				var_108_1.transform.parent = arg_105_1.stage_.transform
				var_108_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_105_1.bgs_[var_108_0] = var_108_1
			end

			local var_108_2 = 0.566666666666667

			if var_108_2 < arg_105_1.time_ and arg_105_1.time_ <= var_108_2 + arg_108_0 then
				local var_108_3 = manager.ui.mainCamera.transform.localPosition
				local var_108_4 = Vector3.New(0, 0, 10) + Vector3.New(var_108_3.x, var_108_3.y, 0)
				local var_108_5 = arg_105_1.bgs_.I07

				var_108_5.transform.localPosition = var_108_4
				var_108_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_108_6 = var_108_5:GetComponent("SpriteRenderer")

				if var_108_6 and var_108_6.sprite then
					local var_108_7 = (var_108_5.transform.localPosition - var_108_3).z
					local var_108_8 = manager.ui.mainCameraCom_
					local var_108_9 = 2 * var_108_7 * Mathf.Tan(var_108_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_108_10 = var_108_9 * var_108_8.aspect
					local var_108_11 = var_108_6.sprite.bounds.size.x
					local var_108_12 = var_108_6.sprite.bounds.size.y
					local var_108_13 = var_108_10 / var_108_11
					local var_108_14 = var_108_9 / var_108_12
					local var_108_15 = var_108_14 < var_108_13 and var_108_13 or var_108_14

					var_108_5.transform.localScale = Vector3.New(var_108_15, var_108_15, 0)
				end

				for iter_108_0, iter_108_1 in pairs(arg_105_1.bgs_) do
					if iter_108_0 ~= "I07" then
						iter_108_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_108_16 = manager.ui.mainCamera.transform
			local var_108_17 = 0

			if var_108_17 < arg_105_1.time_ and arg_105_1.time_ <= var_108_17 + arg_108_0 then
				local var_108_18 = arg_105_1.var_.effect112345

				if not var_108_18 then
					var_108_18 = Object.Instantiate(Asset.Load("Effect/Scene/fx_uistory_error"))
					var_108_18.name = "112345"
					arg_105_1.var_.effect112345 = var_108_18
				end

				local var_108_19 = var_108_16:Find("")

				if var_108_19 then
					var_108_18.transform.parent = var_108_19
				else
					var_108_18.transform.parent = var_108_16
				end

				var_108_18.transform.localPosition = Vector3.New(0, 0, 0)
				var_108_18.transform.localRotation = Quaternion.Euler(0, 0, 0)
			end

			local var_108_20 = 0
			local var_108_21 = 0.366666666666667

			if var_108_20 < arg_105_1.time_ and arg_105_1.time_ <= var_108_20 + arg_108_0 then
				local var_108_22 = "play"
				local var_108_23 = "music"

				arg_105_1:AudioAction(var_108_22, var_108_23, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_108_24 = 0.6
			local var_108_25 = 1

			if var_108_24 < arg_105_1.time_ and arg_105_1.time_ <= var_108_24 + arg_108_0 then
				local var_108_26 = "play"
				local var_108_27 = "music"

				arg_105_1:AudioAction(var_108_26, var_108_27, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")
			end

			local var_108_28 = 0
			local var_108_29 = 1

			if var_108_28 < arg_105_1.time_ and arg_105_1.time_ <= var_108_28 + arg_108_0 then
				local var_108_30 = "play"
				local var_108_31 = "effect"

				arg_105_1:AudioAction(var_108_30, var_108_31, "se_story_130", "se_story_130_noise", "")
			end

			if arg_105_1.frameCnt_ <= 1 then
				arg_105_1.dialog_:SetActive(false)
			end

			local var_108_32 = 0.566666666666667
			local var_108_33 = 1.15

			if var_108_32 < arg_105_1.time_ and arg_105_1.time_ <= var_108_32 + arg_108_0 then
				arg_105_1.talkMaxDuration = 0

				arg_105_1.dialog_:SetActive(true)

				local var_108_34 = LeanTween.value(arg_105_1.dialog_, 0, 1, 0.3)

				var_108_34:setOnUpdate(LuaHelper.FloatAction(function(arg_109_0)
					arg_105_1.dialogCg_.alpha = arg_109_0
				end))
				var_108_34:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_105_1.dialog_)
					var_108_34:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_105_1.duration_ = arg_105_1.duration_ + 0.3

				SetActive(arg_105_1.leftNameGo_, false)

				arg_105_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_105_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_105_1:RecordName(arg_105_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_105_1.iconTrs_.gameObject, false)
				arg_105_1.callingController_:SetSelectedState("normal")

				local var_108_35 = arg_105_1:GetWordFromCfg(411051026)
				local var_108_36 = arg_105_1:FormatText(var_108_35.content)

				arg_105_1.text_.text = var_108_36

				LuaForUtil.ClearLinePrefixSymbol(arg_105_1.text_)

				local var_108_37 = 46
				local var_108_38 = utf8.len(var_108_36)
				local var_108_39 = var_108_37 <= 0 and var_108_33 or var_108_33 * (var_108_38 / var_108_37)

				if var_108_39 > 0 and var_108_33 < var_108_39 then
					arg_105_1.talkMaxDuration = var_108_39
					var_108_32 = var_108_32 + 0.3

					if var_108_39 + var_108_32 > arg_105_1.duration_ then
						arg_105_1.duration_ = var_108_39 + var_108_32
					end
				end

				arg_105_1.text_.text = var_108_36
				arg_105_1.typewritter.percent = 0

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(false)
				arg_105_1:RecordContent(arg_105_1.text_.text)
			end

			local var_108_40 = var_108_32 + 0.3
			local var_108_41 = math.max(var_108_33, arg_105_1.talkMaxDuration)

			if var_108_40 <= arg_105_1.time_ and arg_105_1.time_ < var_108_40 + var_108_41 then
				arg_105_1.typewritter.percent = (arg_105_1.time_ - var_108_40) / var_108_41

				arg_105_1.typewritter:SetDirty()
			end

			if arg_105_1.time_ >= var_108_40 + var_108_41 and arg_105_1.time_ < var_108_40 + var_108_41 + arg_108_0 then
				arg_105_1.typewritter.percent = 1

				arg_105_1.typewritter:SetDirty()
				arg_105_1:ShowNextGo(true)
			end
		end
	end,
	Play411051027 = function(arg_111_0, arg_111_1)
		arg_111_1.time_ = 0
		arg_111_1.frameCnt_ = 0
		arg_111_1.state_ = "playing"
		arg_111_1.curTalkId_ = 411051027
		arg_111_1.duration_ = 4.633

		local var_111_0 = {
			zh = 2.4,
			ja = 4.633
		}
		local var_111_1 = manager.audio:GetLocalizationFlag()

		if var_111_0[var_111_1] ~= nil then
			arg_111_1.duration_ = var_111_0[var_111_1]
		end

		SetActive(arg_111_1.tipsGo_, false)

		function arg_111_1.onSingleLineFinish_()
			arg_111_1.onSingleLineUpdate_ = nil
			arg_111_1.onSingleLineFinish_ = nil
			arg_111_1.state_ = "waiting"
		end

		function arg_111_1.playNext_(arg_113_0)
			if arg_113_0 == 1 then
				arg_111_0:Play411051028(arg_111_1)
			end
		end

		function arg_111_1.onSingleLineUpdate_(arg_114_0)
			local var_114_0 = arg_111_1.actors_["10058ui_story"].transform
			local var_114_1 = 0

			if var_114_1 < arg_111_1.time_ and arg_111_1.time_ <= var_114_1 + arg_114_0 then
				arg_111_1.var_.moveOldPos10058ui_story = var_114_0.localPosition
			end

			local var_114_2 = 0.001

			if var_114_1 <= arg_111_1.time_ and arg_111_1.time_ < var_114_1 + var_114_2 then
				local var_114_3 = (arg_111_1.time_ - var_114_1) / var_114_2
				local var_114_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_114_0.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10058ui_story, var_114_4, var_114_3)

				local var_114_5 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_5.x, var_114_5.y, var_114_5.z)

				local var_114_6 = var_114_0.localEulerAngles

				var_114_6.z = 0
				var_114_6.x = 0
				var_114_0.localEulerAngles = var_114_6
			end

			if arg_111_1.time_ >= var_114_1 + var_114_2 and arg_111_1.time_ < var_114_1 + var_114_2 + arg_114_0 then
				var_114_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_114_7 = manager.ui.mainCamera.transform.position - var_114_0.position

				var_114_0.forward = Vector3.New(var_114_7.x, var_114_7.y, var_114_7.z)

				local var_114_8 = var_114_0.localEulerAngles

				var_114_8.z = 0
				var_114_8.x = 0
				var_114_0.localEulerAngles = var_114_8
			end

			local var_114_9 = arg_111_1.actors_["10058ui_story"]
			local var_114_10 = 0

			if var_114_10 < arg_111_1.time_ and arg_111_1.time_ <= var_114_10 + arg_114_0 and arg_111_1.var_.characterEffect10058ui_story == nil then
				arg_111_1.var_.characterEffect10058ui_story = var_114_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_11 = 0.200000002980232

			if var_114_10 <= arg_111_1.time_ and arg_111_1.time_ < var_114_10 + var_114_11 then
				local var_114_12 = (arg_111_1.time_ - var_114_10) / var_114_11

				if arg_111_1.var_.characterEffect10058ui_story then
					arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_111_1.time_ >= var_114_10 + var_114_11 and arg_111_1.time_ < var_114_10 + var_114_11 + arg_114_0 and arg_111_1.var_.characterEffect10058ui_story then
				arg_111_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_114_13 = 0

			if var_114_13 < arg_111_1.time_ and arg_111_1.time_ <= var_114_13 + arg_114_0 then
				arg_111_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_114_14 = 0

			if var_114_14 < arg_111_1.time_ and arg_111_1.time_ <= var_114_14 + arg_114_0 then
				arg_111_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_114_15 = "10014ui_story"

			if arg_111_1.actors_[var_114_15] == nil then
				local var_114_16 = Object.Instantiate(Asset.Load("Char/" .. var_114_15), arg_111_1.stage_.transform)

				var_114_16.name = var_114_15
				var_114_16.transform.localPosition = Vector3.New(0, 100, 0)
				arg_111_1.actors_[var_114_15] = var_114_16

				local var_114_17 = var_114_16:GetComponentInChildren(typeof(CharacterEffect))

				var_114_17.enabled = true

				local var_114_18 = GameObjectTools.GetOrAddComponent(var_114_16, typeof(DynamicBoneHelper))

				if var_114_18 then
					var_114_18:EnableDynamicBone(false)
				end

				arg_111_1:ShowWeapon(var_114_17.transform, false)

				arg_111_1.var_[var_114_15 .. "Animator"] = var_114_17.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_111_1.var_[var_114_15 .. "Animator"].applyRootMotion = true
				arg_111_1.var_[var_114_15 .. "LipSync"] = var_114_17.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_114_19 = arg_111_1.actors_["10014ui_story"].transform
			local var_114_20 = 0

			if var_114_20 < arg_111_1.time_ and arg_111_1.time_ <= var_114_20 + arg_114_0 then
				arg_111_1.var_.moveOldPos10014ui_story = var_114_19.localPosition
			end

			local var_114_21 = 0.001

			if var_114_20 <= arg_111_1.time_ and arg_111_1.time_ < var_114_20 + var_114_21 then
				local var_114_22 = (arg_111_1.time_ - var_114_20) / var_114_21
				local var_114_23 = Vector3.New(0.7, -1.06, -6.2)

				var_114_19.localPosition = Vector3.Lerp(arg_111_1.var_.moveOldPos10014ui_story, var_114_23, var_114_22)

				local var_114_24 = manager.ui.mainCamera.transform.position - var_114_19.position

				var_114_19.forward = Vector3.New(var_114_24.x, var_114_24.y, var_114_24.z)

				local var_114_25 = var_114_19.localEulerAngles

				var_114_25.z = 0
				var_114_25.x = 0
				var_114_19.localEulerAngles = var_114_25
			end

			if arg_111_1.time_ >= var_114_20 + var_114_21 and arg_111_1.time_ < var_114_20 + var_114_21 + arg_114_0 then
				var_114_19.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_114_26 = manager.ui.mainCamera.transform.position - var_114_19.position

				var_114_19.forward = Vector3.New(var_114_26.x, var_114_26.y, var_114_26.z)

				local var_114_27 = var_114_19.localEulerAngles

				var_114_27.z = 0
				var_114_27.x = 0
				var_114_19.localEulerAngles = var_114_27
			end

			local var_114_28 = arg_111_1.actors_["10014ui_story"]
			local var_114_29 = 0

			if var_114_29 < arg_111_1.time_ and arg_111_1.time_ <= var_114_29 + arg_114_0 and arg_111_1.var_.characterEffect10014ui_story == nil then
				arg_111_1.var_.characterEffect10014ui_story = var_114_28:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_114_30 = 0.183333336313566

			if var_114_29 <= arg_111_1.time_ and arg_111_1.time_ < var_114_29 + var_114_30 then
				local var_114_31 = (arg_111_1.time_ - var_114_29) / var_114_30

				if arg_111_1.var_.characterEffect10014ui_story then
					local var_114_32 = Mathf.Lerp(0, 0.5, var_114_31)

					arg_111_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_111_1.var_.characterEffect10014ui_story.fillRatio = var_114_32
				end
			end

			if arg_111_1.time_ >= var_114_29 + var_114_30 and arg_111_1.time_ < var_114_29 + var_114_30 + arg_114_0 and arg_111_1.var_.characterEffect10014ui_story then
				local var_114_33 = 0.5

				arg_111_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_111_1.var_.characterEffect10014ui_story.fillRatio = var_114_33
			end

			local var_114_34 = manager.ui.mainCamera.transform
			local var_114_35 = 0

			if var_114_35 < arg_111_1.time_ and arg_111_1.time_ <= var_114_35 + arg_114_0 then
				local var_114_36 = arg_111_1.var_.effect112345

				if var_114_36 then
					Object.Destroy(var_114_36)

					arg_111_1.var_.effect112345 = nil
				end
			end

			local var_114_37 = 0
			local var_114_38 = 0.1

			if var_114_37 < arg_111_1.time_ and arg_111_1.time_ <= var_114_37 + arg_114_0 then
				local var_114_39 = "play"
				local var_114_40 = "music"

				arg_111_1:AudioAction(var_114_39, var_114_40, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_114_41 = 0.133333333333333
			local var_114_42 = 0.866666666666667

			if var_114_41 < arg_111_1.time_ and arg_111_1.time_ <= var_114_41 + arg_114_0 then
				local var_114_43 = "play"
				local var_114_44 = "music"

				arg_111_1:AudioAction(var_114_43, var_114_44, "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock", "bgm_activity_3_0_story_northblock.awb")
			end

			local var_114_45 = 0
			local var_114_46 = 0.325

			if var_114_45 < arg_111_1.time_ and arg_111_1.time_ <= var_114_45 + arg_114_0 then
				arg_111_1.talkMaxDuration = 0
				arg_111_1.dialogCg_.alpha = 1

				arg_111_1.dialog_:SetActive(true)
				SetActive(arg_111_1.leftNameGo_, true)

				local var_114_47 = arg_111_1:FormatText(StoryNameCfg[471].name)

				arg_111_1.leftNameTxt_.text = var_114_47

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_111_1.leftNameTxt_.transform)

				arg_111_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_111_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_111_1:RecordName(arg_111_1.leftNameTxt_.text)
				SetActive(arg_111_1.iconTrs_.gameObject, false)
				arg_111_1.callingController_:SetSelectedState("normal")

				local var_114_48 = arg_111_1:GetWordFromCfg(411051027)
				local var_114_49 = arg_111_1:FormatText(var_114_48.content)

				arg_111_1.text_.text = var_114_49

				LuaForUtil.ClearLinePrefixSymbol(arg_111_1.text_)

				local var_114_50 = 13
				local var_114_51 = utf8.len(var_114_49)
				local var_114_52 = var_114_50 <= 0 and var_114_46 or var_114_46 * (var_114_51 / var_114_50)

				if var_114_52 > 0 and var_114_46 < var_114_52 then
					arg_111_1.talkMaxDuration = var_114_52

					if var_114_52 + var_114_45 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_52 + var_114_45
					end
				end

				arg_111_1.text_.text = var_114_49
				arg_111_1.typewritter.percent = 0

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") ~= 0 then
					local var_114_53 = manager.audio:GetVoiceLength("story_v_out_411051", "411051027", "story_v_out_411051.awb") / 1000

					if var_114_53 + var_114_45 > arg_111_1.duration_ then
						arg_111_1.duration_ = var_114_53 + var_114_45
					end

					if var_114_48.prefab_name ~= "" and arg_111_1.actors_[var_114_48.prefab_name] ~= nil then
						local var_114_54 = LuaForUtil.PlayVoiceWithCriLipsync(arg_111_1.actors_[var_114_48.prefab_name].transform, "story_v_out_411051", "411051027", "story_v_out_411051.awb")

						arg_111_1:RecordAudio("411051027", var_114_54)
						arg_111_1:RecordAudio("411051027", var_114_54)
					else
						arg_111_1:AudioAction("play", "voice", "story_v_out_411051", "411051027", "story_v_out_411051.awb")
					end

					arg_111_1:RecordHistoryTalkVoice("story_v_out_411051", "411051027", "story_v_out_411051.awb")
				end

				arg_111_1:RecordContent(arg_111_1.text_.text)
			end

			local var_114_55 = math.max(var_114_46, arg_111_1.talkMaxDuration)

			if var_114_45 <= arg_111_1.time_ and arg_111_1.time_ < var_114_45 + var_114_55 then
				arg_111_1.typewritter.percent = (arg_111_1.time_ - var_114_45) / var_114_55

				arg_111_1.typewritter:SetDirty()
			end

			if arg_111_1.time_ >= var_114_45 + var_114_55 and arg_111_1.time_ < var_114_45 + var_114_55 + arg_114_0 then
				arg_111_1.typewritter.percent = 1

				arg_111_1.typewritter:SetDirty()
				arg_111_1:ShowNextGo(true)
			end
		end
	end,
	Play411051028 = function(arg_115_0, arg_115_1)
		arg_115_1.time_ = 0
		arg_115_1.frameCnt_ = 0
		arg_115_1.state_ = "playing"
		arg_115_1.curTalkId_ = 411051028
		arg_115_1.duration_ = 5

		SetActive(arg_115_1.tipsGo_, false)

		function arg_115_1.onSingleLineFinish_()
			arg_115_1.onSingleLineUpdate_ = nil
			arg_115_1.onSingleLineFinish_ = nil
			arg_115_1.state_ = "waiting"
		end

		function arg_115_1.playNext_(arg_117_0)
			if arg_117_0 == 1 then
				arg_115_0:Play411051029(arg_115_1)
			end
		end

		function arg_115_1.onSingleLineUpdate_(arg_118_0)
			local var_118_0 = arg_115_1.actors_["10058ui_story"]
			local var_118_1 = 0

			if var_118_1 < arg_115_1.time_ and arg_115_1.time_ <= var_118_1 + arg_118_0 and arg_115_1.var_.characterEffect10058ui_story == nil then
				arg_115_1.var_.characterEffect10058ui_story = var_118_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_118_2 = 0.200000002980232

			if var_118_1 <= arg_115_1.time_ and arg_115_1.time_ < var_118_1 + var_118_2 then
				local var_118_3 = (arg_115_1.time_ - var_118_1) / var_118_2

				if arg_115_1.var_.characterEffect10058ui_story then
					local var_118_4 = Mathf.Lerp(0, 0.5, var_118_3)

					arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_115_1.var_.characterEffect10058ui_story.fillRatio = var_118_4
				end
			end

			if arg_115_1.time_ >= var_118_1 + var_118_2 and arg_115_1.time_ < var_118_1 + var_118_2 + arg_118_0 and arg_115_1.var_.characterEffect10058ui_story then
				local var_118_5 = 0.5

				arg_115_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_115_1.var_.characterEffect10058ui_story.fillRatio = var_118_5
			end

			local var_118_6 = 0
			local var_118_7 = 1.025

			if var_118_6 < arg_115_1.time_ and arg_115_1.time_ <= var_118_6 + arg_118_0 then
				arg_115_1.talkMaxDuration = 0
				arg_115_1.dialogCg_.alpha = 1

				arg_115_1.dialog_:SetActive(true)
				SetActive(arg_115_1.leftNameGo_, false)

				arg_115_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_115_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_115_1:RecordName(arg_115_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_115_1.iconTrs_.gameObject, false)
				arg_115_1.callingController_:SetSelectedState("normal")

				local var_118_8 = arg_115_1:GetWordFromCfg(411051028)
				local var_118_9 = arg_115_1:FormatText(var_118_8.content)

				arg_115_1.text_.text = var_118_9

				LuaForUtil.ClearLinePrefixSymbol(arg_115_1.text_)

				local var_118_10 = 41
				local var_118_11 = utf8.len(var_118_9)
				local var_118_12 = var_118_10 <= 0 and var_118_7 or var_118_7 * (var_118_11 / var_118_10)

				if var_118_12 > 0 and var_118_7 < var_118_12 then
					arg_115_1.talkMaxDuration = var_118_12

					if var_118_12 + var_118_6 > arg_115_1.duration_ then
						arg_115_1.duration_ = var_118_12 + var_118_6
					end
				end

				arg_115_1.text_.text = var_118_9
				arg_115_1.typewritter.percent = 0

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(false)
				arg_115_1:RecordContent(arg_115_1.text_.text)
			end

			local var_118_13 = math.max(var_118_7, arg_115_1.talkMaxDuration)

			if var_118_6 <= arg_115_1.time_ and arg_115_1.time_ < var_118_6 + var_118_13 then
				arg_115_1.typewritter.percent = (arg_115_1.time_ - var_118_6) / var_118_13

				arg_115_1.typewritter:SetDirty()
			end

			if arg_115_1.time_ >= var_118_6 + var_118_13 and arg_115_1.time_ < var_118_6 + var_118_13 + arg_118_0 then
				arg_115_1.typewritter.percent = 1

				arg_115_1.typewritter:SetDirty()
				arg_115_1:ShowNextGo(true)
			end
		end
	end,
	Play411051029 = function(arg_119_0, arg_119_1)
		arg_119_1.time_ = 0
		arg_119_1.frameCnt_ = 0
		arg_119_1.state_ = "playing"
		arg_119_1.curTalkId_ = 411051029
		arg_119_1.duration_ = 5

		SetActive(arg_119_1.tipsGo_, false)

		function arg_119_1.onSingleLineFinish_()
			arg_119_1.onSingleLineUpdate_ = nil
			arg_119_1.onSingleLineFinish_ = nil
			arg_119_1.state_ = "waiting"
		end

		function arg_119_1.playNext_(arg_121_0)
			if arg_121_0 == 1 then
				arg_119_0:Play411051030(arg_119_1)
			end
		end

		function arg_119_1.onSingleLineUpdate_(arg_122_0)
			local var_122_0 = 0
			local var_122_1 = 0.9

			if var_122_0 < arg_119_1.time_ and arg_119_1.time_ <= var_122_0 + arg_122_0 then
				arg_119_1.talkMaxDuration = 0
				arg_119_1.dialogCg_.alpha = 1

				arg_119_1.dialog_:SetActive(true)
				SetActive(arg_119_1.leftNameGo_, false)

				arg_119_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_119_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_119_1:RecordName(arg_119_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_119_1.iconTrs_.gameObject, false)
				arg_119_1.callingController_:SetSelectedState("normal")

				local var_122_2 = arg_119_1:GetWordFromCfg(411051029)
				local var_122_3 = arg_119_1:FormatText(var_122_2.content)

				arg_119_1.text_.text = var_122_3

				LuaForUtil.ClearLinePrefixSymbol(arg_119_1.text_)

				local var_122_4 = 36
				local var_122_5 = utf8.len(var_122_3)
				local var_122_6 = var_122_4 <= 0 and var_122_1 or var_122_1 * (var_122_5 / var_122_4)

				if var_122_6 > 0 and var_122_1 < var_122_6 then
					arg_119_1.talkMaxDuration = var_122_6

					if var_122_6 + var_122_0 > arg_119_1.duration_ then
						arg_119_1.duration_ = var_122_6 + var_122_0
					end
				end

				arg_119_1.text_.text = var_122_3
				arg_119_1.typewritter.percent = 0

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(false)
				arg_119_1:RecordContent(arg_119_1.text_.text)
			end

			local var_122_7 = math.max(var_122_1, arg_119_1.talkMaxDuration)

			if var_122_0 <= arg_119_1.time_ and arg_119_1.time_ < var_122_0 + var_122_7 then
				arg_119_1.typewritter.percent = (arg_119_1.time_ - var_122_0) / var_122_7

				arg_119_1.typewritter:SetDirty()
			end

			if arg_119_1.time_ >= var_122_0 + var_122_7 and arg_119_1.time_ < var_122_0 + var_122_7 + arg_122_0 then
				arg_119_1.typewritter.percent = 1

				arg_119_1.typewritter:SetDirty()
				arg_119_1:ShowNextGo(true)
			end
		end
	end,
	Play411051030 = function(arg_123_0, arg_123_1)
		arg_123_1.time_ = 0
		arg_123_1.frameCnt_ = 0
		arg_123_1.state_ = "playing"
		arg_123_1.curTalkId_ = 411051030
		arg_123_1.duration_ = 5

		SetActive(arg_123_1.tipsGo_, false)

		function arg_123_1.onSingleLineFinish_()
			arg_123_1.onSingleLineUpdate_ = nil
			arg_123_1.onSingleLineFinish_ = nil
			arg_123_1.state_ = "waiting"
		end

		function arg_123_1.playNext_(arg_125_0)
			if arg_125_0 == 1 then
				arg_123_0:Play411051031(arg_123_1)
			end
		end

		function arg_123_1.onSingleLineUpdate_(arg_126_0)
			local var_126_0 = 0
			local var_126_1 = 1.125

			if var_126_0 < arg_123_1.time_ and arg_123_1.time_ <= var_126_0 + arg_126_0 then
				arg_123_1.talkMaxDuration = 0
				arg_123_1.dialogCg_.alpha = 1

				arg_123_1.dialog_:SetActive(true)
				SetActive(arg_123_1.leftNameGo_, false)

				arg_123_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_123_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_123_1:RecordName(arg_123_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_123_1.iconTrs_.gameObject, false)
				arg_123_1.callingController_:SetSelectedState("normal")

				local var_126_2 = arg_123_1:GetWordFromCfg(411051030)
				local var_126_3 = arg_123_1:FormatText(var_126_2.content)

				arg_123_1.text_.text = var_126_3

				LuaForUtil.ClearLinePrefixSymbol(arg_123_1.text_)

				local var_126_4 = 46
				local var_126_5 = utf8.len(var_126_3)
				local var_126_6 = var_126_4 <= 0 and var_126_1 or var_126_1 * (var_126_5 / var_126_4)

				if var_126_6 > 0 and var_126_1 < var_126_6 then
					arg_123_1.talkMaxDuration = var_126_6

					if var_126_6 + var_126_0 > arg_123_1.duration_ then
						arg_123_1.duration_ = var_126_6 + var_126_0
					end
				end

				arg_123_1.text_.text = var_126_3
				arg_123_1.typewritter.percent = 0

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(false)
				arg_123_1:RecordContent(arg_123_1.text_.text)
			end

			local var_126_7 = math.max(var_126_1, arg_123_1.talkMaxDuration)

			if var_126_0 <= arg_123_1.time_ and arg_123_1.time_ < var_126_0 + var_126_7 then
				arg_123_1.typewritter.percent = (arg_123_1.time_ - var_126_0) / var_126_7

				arg_123_1.typewritter:SetDirty()
			end

			if arg_123_1.time_ >= var_126_0 + var_126_7 and arg_123_1.time_ < var_126_0 + var_126_7 + arg_126_0 then
				arg_123_1.typewritter.percent = 1

				arg_123_1.typewritter:SetDirty()
				arg_123_1:ShowNextGo(true)
			end
		end
	end,
	Play411051031 = function(arg_127_0, arg_127_1)
		arg_127_1.time_ = 0
		arg_127_1.frameCnt_ = 0
		arg_127_1.state_ = "playing"
		arg_127_1.curTalkId_ = 411051031
		arg_127_1.duration_ = 5.433

		local var_127_0 = {
			zh = 4.033,
			ja = 5.433
		}
		local var_127_1 = manager.audio:GetLocalizationFlag()

		if var_127_0[var_127_1] ~= nil then
			arg_127_1.duration_ = var_127_0[var_127_1]
		end

		SetActive(arg_127_1.tipsGo_, false)

		function arg_127_1.onSingleLineFinish_()
			arg_127_1.onSingleLineUpdate_ = nil
			arg_127_1.onSingleLineFinish_ = nil
			arg_127_1.state_ = "waiting"
		end

		function arg_127_1.playNext_(arg_129_0)
			if arg_129_0 == 1 then
				arg_127_0:Play411051032(arg_127_1)
			end
		end

		function arg_127_1.onSingleLineUpdate_(arg_130_0)
			local var_130_0 = arg_127_1.actors_["10014ui_story"].transform
			local var_130_1 = 0

			if var_130_1 < arg_127_1.time_ and arg_127_1.time_ <= var_130_1 + arg_130_0 then
				arg_127_1.var_.moveOldPos10014ui_story = var_130_0.localPosition
			end

			local var_130_2 = 0.001

			if var_130_1 <= arg_127_1.time_ and arg_127_1.time_ < var_130_1 + var_130_2 then
				local var_130_3 = (arg_127_1.time_ - var_130_1) / var_130_2
				local var_130_4 = Vector3.New(0.7, -1.06, -6.2)

				var_130_0.localPosition = Vector3.Lerp(arg_127_1.var_.moveOldPos10014ui_story, var_130_4, var_130_3)

				local var_130_5 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_5.x, var_130_5.y, var_130_5.z)

				local var_130_6 = var_130_0.localEulerAngles

				var_130_6.z = 0
				var_130_6.x = 0
				var_130_0.localEulerAngles = var_130_6
			end

			if arg_127_1.time_ >= var_130_1 + var_130_2 and arg_127_1.time_ < var_130_1 + var_130_2 + arg_130_0 then
				var_130_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_130_7 = manager.ui.mainCamera.transform.position - var_130_0.position

				var_130_0.forward = Vector3.New(var_130_7.x, var_130_7.y, var_130_7.z)

				local var_130_8 = var_130_0.localEulerAngles

				var_130_8.z = 0
				var_130_8.x = 0
				var_130_0.localEulerAngles = var_130_8
			end

			local var_130_9 = arg_127_1.actors_["10014ui_story"]
			local var_130_10 = 0

			if var_130_10 < arg_127_1.time_ and arg_127_1.time_ <= var_130_10 + arg_130_0 and arg_127_1.var_.characterEffect10014ui_story == nil then
				arg_127_1.var_.characterEffect10014ui_story = var_130_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_130_11 = 0.200000002980232

			if var_130_10 <= arg_127_1.time_ and arg_127_1.time_ < var_130_10 + var_130_11 then
				local var_130_12 = (arg_127_1.time_ - var_130_10) / var_130_11

				if arg_127_1.var_.characterEffect10014ui_story then
					arg_127_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_127_1.time_ >= var_130_10 + var_130_11 and arg_127_1.time_ < var_130_10 + var_130_11 + arg_130_0 and arg_127_1.var_.characterEffect10014ui_story then
				arg_127_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_130_13 = 0

			if var_130_13 < arg_127_1.time_ and arg_127_1.time_ <= var_130_13 + arg_130_0 then
				arg_127_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_130_14 = 0

			if var_130_14 < arg_127_1.time_ and arg_127_1.time_ <= var_130_14 + arg_130_0 then
				arg_127_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_130_15 = 0
			local var_130_16 = 0.475

			if var_130_15 < arg_127_1.time_ and arg_127_1.time_ <= var_130_15 + arg_130_0 then
				arg_127_1.talkMaxDuration = 0
				arg_127_1.dialogCg_.alpha = 1

				arg_127_1.dialog_:SetActive(true)
				SetActive(arg_127_1.leftNameGo_, true)

				local var_130_17 = arg_127_1:FormatText(StoryNameCfg[264].name)

				arg_127_1.leftNameTxt_.text = var_130_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_127_1.leftNameTxt_.transform)

				arg_127_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_127_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_127_1:RecordName(arg_127_1.leftNameTxt_.text)
				SetActive(arg_127_1.iconTrs_.gameObject, false)
				arg_127_1.callingController_:SetSelectedState("normal")

				local var_130_18 = arg_127_1:GetWordFromCfg(411051031)
				local var_130_19 = arg_127_1:FormatText(var_130_18.content)

				arg_127_1.text_.text = var_130_19

				LuaForUtil.ClearLinePrefixSymbol(arg_127_1.text_)

				local var_130_20 = 19
				local var_130_21 = utf8.len(var_130_19)
				local var_130_22 = var_130_20 <= 0 and var_130_16 or var_130_16 * (var_130_21 / var_130_20)

				if var_130_22 > 0 and var_130_16 < var_130_22 then
					arg_127_1.talkMaxDuration = var_130_22

					if var_130_22 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_22 + var_130_15
					end
				end

				arg_127_1.text_.text = var_130_19
				arg_127_1.typewritter.percent = 0

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") ~= 0 then
					local var_130_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051031", "story_v_out_411051.awb") / 1000

					if var_130_23 + var_130_15 > arg_127_1.duration_ then
						arg_127_1.duration_ = var_130_23 + var_130_15
					end

					if var_130_18.prefab_name ~= "" and arg_127_1.actors_[var_130_18.prefab_name] ~= nil then
						local var_130_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_127_1.actors_[var_130_18.prefab_name].transform, "story_v_out_411051", "411051031", "story_v_out_411051.awb")

						arg_127_1:RecordAudio("411051031", var_130_24)
						arg_127_1:RecordAudio("411051031", var_130_24)
					else
						arg_127_1:AudioAction("play", "voice", "story_v_out_411051", "411051031", "story_v_out_411051.awb")
					end

					arg_127_1:RecordHistoryTalkVoice("story_v_out_411051", "411051031", "story_v_out_411051.awb")
				end

				arg_127_1:RecordContent(arg_127_1.text_.text)
			end

			local var_130_25 = math.max(var_130_16, arg_127_1.talkMaxDuration)

			if var_130_15 <= arg_127_1.time_ and arg_127_1.time_ < var_130_15 + var_130_25 then
				arg_127_1.typewritter.percent = (arg_127_1.time_ - var_130_15) / var_130_25

				arg_127_1.typewritter:SetDirty()
			end

			if arg_127_1.time_ >= var_130_15 + var_130_25 and arg_127_1.time_ < var_130_15 + var_130_25 + arg_130_0 then
				arg_127_1.typewritter.percent = 1

				arg_127_1.typewritter:SetDirty()
				arg_127_1:ShowNextGo(true)
			end
		end
	end,
	Play411051032 = function(arg_131_0, arg_131_1)
		arg_131_1.time_ = 0
		arg_131_1.frameCnt_ = 0
		arg_131_1.state_ = "playing"
		arg_131_1.curTalkId_ = 411051032
		arg_131_1.duration_ = 4.1

		local var_131_0 = {
			zh = 2.6,
			ja = 4.1
		}
		local var_131_1 = manager.audio:GetLocalizationFlag()

		if var_131_0[var_131_1] ~= nil then
			arg_131_1.duration_ = var_131_0[var_131_1]
		end

		SetActive(arg_131_1.tipsGo_, false)

		function arg_131_1.onSingleLineFinish_()
			arg_131_1.onSingleLineUpdate_ = nil
			arg_131_1.onSingleLineFinish_ = nil
			arg_131_1.state_ = "waiting"
		end

		function arg_131_1.playNext_(arg_133_0)
			if arg_133_0 == 1 then
				arg_131_0:Play411051033(arg_131_1)
			end
		end

		function arg_131_1.onSingleLineUpdate_(arg_134_0)
			local var_134_0 = arg_131_1.actors_["10058ui_story"].transform
			local var_134_1 = 0

			if var_134_1 < arg_131_1.time_ and arg_131_1.time_ <= var_134_1 + arg_134_0 then
				arg_131_1.var_.moveOldPos10058ui_story = var_134_0.localPosition
			end

			local var_134_2 = 0.001

			if var_134_1 <= arg_131_1.time_ and arg_131_1.time_ < var_134_1 + var_134_2 then
				local var_134_3 = (arg_131_1.time_ - var_134_1) / var_134_2
				local var_134_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_134_0.localPosition = Vector3.Lerp(arg_131_1.var_.moveOldPos10058ui_story, var_134_4, var_134_3)

				local var_134_5 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_5.x, var_134_5.y, var_134_5.z)

				local var_134_6 = var_134_0.localEulerAngles

				var_134_6.z = 0
				var_134_6.x = 0
				var_134_0.localEulerAngles = var_134_6
			end

			if arg_131_1.time_ >= var_134_1 + var_134_2 and arg_131_1.time_ < var_134_1 + var_134_2 + arg_134_0 then
				var_134_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_134_7 = manager.ui.mainCamera.transform.position - var_134_0.position

				var_134_0.forward = Vector3.New(var_134_7.x, var_134_7.y, var_134_7.z)

				local var_134_8 = var_134_0.localEulerAngles

				var_134_8.z = 0
				var_134_8.x = 0
				var_134_0.localEulerAngles = var_134_8
			end

			local var_134_9 = arg_131_1.actors_["10058ui_story"]
			local var_134_10 = 0

			if var_134_10 < arg_131_1.time_ and arg_131_1.time_ <= var_134_10 + arg_134_0 and arg_131_1.var_.characterEffect10058ui_story == nil then
				arg_131_1.var_.characterEffect10058ui_story = var_134_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_11 = 0.200000002980232

			if var_134_10 <= arg_131_1.time_ and arg_131_1.time_ < var_134_10 + var_134_11 then
				local var_134_12 = (arg_131_1.time_ - var_134_10) / var_134_11

				if arg_131_1.var_.characterEffect10058ui_story then
					arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_131_1.time_ >= var_134_10 + var_134_11 and arg_131_1.time_ < var_134_10 + var_134_11 + arg_134_0 and arg_131_1.var_.characterEffect10058ui_story then
				arg_131_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_134_13 = 0

			if var_134_13 < arg_131_1.time_ and arg_131_1.time_ <= var_134_13 + arg_134_0 then
				arg_131_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0201cva")
			end

			local var_134_14 = arg_131_1.actors_["10014ui_story"]
			local var_134_15 = 0

			if var_134_15 < arg_131_1.time_ and arg_131_1.time_ <= var_134_15 + arg_134_0 and arg_131_1.var_.characterEffect10014ui_story == nil then
				arg_131_1.var_.characterEffect10014ui_story = var_134_14:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_134_16 = 0.200000002980232

			if var_134_15 <= arg_131_1.time_ and arg_131_1.time_ < var_134_15 + var_134_16 then
				local var_134_17 = (arg_131_1.time_ - var_134_15) / var_134_16

				if arg_131_1.var_.characterEffect10014ui_story then
					local var_134_18 = Mathf.Lerp(0, 0.5, var_134_17)

					arg_131_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_131_1.var_.characterEffect10014ui_story.fillRatio = var_134_18
				end
			end

			if arg_131_1.time_ >= var_134_15 + var_134_16 and arg_131_1.time_ < var_134_15 + var_134_16 + arg_134_0 and arg_131_1.var_.characterEffect10014ui_story then
				local var_134_19 = 0.5

				arg_131_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_131_1.var_.characterEffect10014ui_story.fillRatio = var_134_19
			end

			local var_134_20 = 0
			local var_134_21 = 0.35

			if var_134_20 < arg_131_1.time_ and arg_131_1.time_ <= var_134_20 + arg_134_0 then
				arg_131_1.talkMaxDuration = 0
				arg_131_1.dialogCg_.alpha = 1

				arg_131_1.dialog_:SetActive(true)
				SetActive(arg_131_1.leftNameGo_, true)

				local var_134_22 = arg_131_1:FormatText(StoryNameCfg[471].name)

				arg_131_1.leftNameTxt_.text = var_134_22

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_131_1.leftNameTxt_.transform)

				arg_131_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_131_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_131_1:RecordName(arg_131_1.leftNameTxt_.text)
				SetActive(arg_131_1.iconTrs_.gameObject, false)
				arg_131_1.callingController_:SetSelectedState("normal")

				local var_134_23 = arg_131_1:GetWordFromCfg(411051032)
				local var_134_24 = arg_131_1:FormatText(var_134_23.content)

				arg_131_1.text_.text = var_134_24

				LuaForUtil.ClearLinePrefixSymbol(arg_131_1.text_)

				local var_134_25 = 14
				local var_134_26 = utf8.len(var_134_24)
				local var_134_27 = var_134_25 <= 0 and var_134_21 or var_134_21 * (var_134_26 / var_134_25)

				if var_134_27 > 0 and var_134_21 < var_134_27 then
					arg_131_1.talkMaxDuration = var_134_27

					if var_134_27 + var_134_20 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_27 + var_134_20
					end
				end

				arg_131_1.text_.text = var_134_24
				arg_131_1.typewritter.percent = 0

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") ~= 0 then
					local var_134_28 = manager.audio:GetVoiceLength("story_v_out_411051", "411051032", "story_v_out_411051.awb") / 1000

					if var_134_28 + var_134_20 > arg_131_1.duration_ then
						arg_131_1.duration_ = var_134_28 + var_134_20
					end

					if var_134_23.prefab_name ~= "" and arg_131_1.actors_[var_134_23.prefab_name] ~= nil then
						local var_134_29 = LuaForUtil.PlayVoiceWithCriLipsync(arg_131_1.actors_[var_134_23.prefab_name].transform, "story_v_out_411051", "411051032", "story_v_out_411051.awb")

						arg_131_1:RecordAudio("411051032", var_134_29)
						arg_131_1:RecordAudio("411051032", var_134_29)
					else
						arg_131_1:AudioAction("play", "voice", "story_v_out_411051", "411051032", "story_v_out_411051.awb")
					end

					arg_131_1:RecordHistoryTalkVoice("story_v_out_411051", "411051032", "story_v_out_411051.awb")
				end

				arg_131_1:RecordContent(arg_131_1.text_.text)
			end

			local var_134_30 = math.max(var_134_21, arg_131_1.talkMaxDuration)

			if var_134_20 <= arg_131_1.time_ and arg_131_1.time_ < var_134_20 + var_134_30 then
				arg_131_1.typewritter.percent = (arg_131_1.time_ - var_134_20) / var_134_30

				arg_131_1.typewritter:SetDirty()
			end

			if arg_131_1.time_ >= var_134_20 + var_134_30 and arg_131_1.time_ < var_134_20 + var_134_30 + arg_134_0 then
				arg_131_1.typewritter.percent = 1

				arg_131_1.typewritter:SetDirty()
				arg_131_1:ShowNextGo(true)
			end
		end
	end,
	Play411051033 = function(arg_135_0, arg_135_1)
		arg_135_1.time_ = 0
		arg_135_1.frameCnt_ = 0
		arg_135_1.state_ = "playing"
		arg_135_1.curTalkId_ = 411051033
		arg_135_1.duration_ = 9.166

		local var_135_0 = {
			zh = 8.966,
			ja = 9.166
		}
		local var_135_1 = manager.audio:GetLocalizationFlag()

		if var_135_0[var_135_1] ~= nil then
			arg_135_1.duration_ = var_135_0[var_135_1]
		end

		SetActive(arg_135_1.tipsGo_, false)

		function arg_135_1.onSingleLineFinish_()
			arg_135_1.onSingleLineUpdate_ = nil
			arg_135_1.onSingleLineFinish_ = nil
			arg_135_1.state_ = "waiting"
		end

		function arg_135_1.playNext_(arg_137_0)
			if arg_137_0 == 1 then
				arg_135_0:Play411051034(arg_135_1)
			end
		end

		function arg_135_1.onSingleLineUpdate_(arg_138_0)
			local var_138_0 = arg_135_1.actors_["10058ui_story"]
			local var_138_1 = 0

			if var_138_1 < arg_135_1.time_ and arg_135_1.time_ <= var_138_1 + arg_138_0 and arg_135_1.var_.characterEffect10058ui_story == nil then
				arg_135_1.var_.characterEffect10058ui_story = var_138_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_2 = 0.200000002980232

			if var_138_1 <= arg_135_1.time_ and arg_135_1.time_ < var_138_1 + var_138_2 then
				local var_138_3 = (arg_135_1.time_ - var_138_1) / var_138_2

				if arg_135_1.var_.characterEffect10058ui_story then
					local var_138_4 = Mathf.Lerp(0, 0.5, var_138_3)

					arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_4
				end
			end

			if arg_135_1.time_ >= var_138_1 + var_138_2 and arg_135_1.time_ < var_138_1 + var_138_2 + arg_138_0 and arg_135_1.var_.characterEffect10058ui_story then
				local var_138_5 = 0.5

				arg_135_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_135_1.var_.characterEffect10058ui_story.fillRatio = var_138_5
			end

			local var_138_6 = arg_135_1.actors_["10014ui_story"]
			local var_138_7 = 0

			if var_138_7 < arg_135_1.time_ and arg_135_1.time_ <= var_138_7 + arg_138_0 and arg_135_1.var_.characterEffect10014ui_story == nil then
				arg_135_1.var_.characterEffect10014ui_story = var_138_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_138_8 = 0.200000002980232

			if var_138_7 <= arg_135_1.time_ and arg_135_1.time_ < var_138_7 + var_138_8 then
				local var_138_9 = (arg_135_1.time_ - var_138_7) / var_138_8

				if arg_135_1.var_.characterEffect10014ui_story then
					arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_135_1.time_ >= var_138_7 + var_138_8 and arg_135_1.time_ < var_138_7 + var_138_8 + arg_138_0 and arg_135_1.var_.characterEffect10014ui_story then
				arg_135_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_138_10 = 0
			local var_138_11 = 1.125

			if var_138_10 < arg_135_1.time_ and arg_135_1.time_ <= var_138_10 + arg_138_0 then
				arg_135_1.talkMaxDuration = 0
				arg_135_1.dialogCg_.alpha = 1

				arg_135_1.dialog_:SetActive(true)
				SetActive(arg_135_1.leftNameGo_, true)

				local var_138_12 = arg_135_1:FormatText(StoryNameCfg[264].name)

				arg_135_1.leftNameTxt_.text = var_138_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_135_1.leftNameTxt_.transform)

				arg_135_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_135_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_135_1:RecordName(arg_135_1.leftNameTxt_.text)
				SetActive(arg_135_1.iconTrs_.gameObject, false)
				arg_135_1.callingController_:SetSelectedState("normal")

				local var_138_13 = arg_135_1:GetWordFromCfg(411051033)
				local var_138_14 = arg_135_1:FormatText(var_138_13.content)

				arg_135_1.text_.text = var_138_14

				LuaForUtil.ClearLinePrefixSymbol(arg_135_1.text_)

				local var_138_15 = 45
				local var_138_16 = utf8.len(var_138_14)
				local var_138_17 = var_138_15 <= 0 and var_138_11 or var_138_11 * (var_138_16 / var_138_15)

				if var_138_17 > 0 and var_138_11 < var_138_17 then
					arg_135_1.talkMaxDuration = var_138_17

					if var_138_17 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_17 + var_138_10
					end
				end

				arg_135_1.text_.text = var_138_14
				arg_135_1.typewritter.percent = 0

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") ~= 0 then
					local var_138_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051033", "story_v_out_411051.awb") / 1000

					if var_138_18 + var_138_10 > arg_135_1.duration_ then
						arg_135_1.duration_ = var_138_18 + var_138_10
					end

					if var_138_13.prefab_name ~= "" and arg_135_1.actors_[var_138_13.prefab_name] ~= nil then
						local var_138_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_135_1.actors_[var_138_13.prefab_name].transform, "story_v_out_411051", "411051033", "story_v_out_411051.awb")

						arg_135_1:RecordAudio("411051033", var_138_19)
						arg_135_1:RecordAudio("411051033", var_138_19)
					else
						arg_135_1:AudioAction("play", "voice", "story_v_out_411051", "411051033", "story_v_out_411051.awb")
					end

					arg_135_1:RecordHistoryTalkVoice("story_v_out_411051", "411051033", "story_v_out_411051.awb")
				end

				arg_135_1:RecordContent(arg_135_1.text_.text)
			end

			local var_138_20 = math.max(var_138_11, arg_135_1.talkMaxDuration)

			if var_138_10 <= arg_135_1.time_ and arg_135_1.time_ < var_138_10 + var_138_20 then
				arg_135_1.typewritter.percent = (arg_135_1.time_ - var_138_10) / var_138_20

				arg_135_1.typewritter:SetDirty()
			end

			if arg_135_1.time_ >= var_138_10 + var_138_20 and arg_135_1.time_ < var_138_10 + var_138_20 + arg_138_0 then
				arg_135_1.typewritter.percent = 1

				arg_135_1.typewritter:SetDirty()
				arg_135_1:ShowNextGo(true)
			end
		end
	end,
	Play411051034 = function(arg_139_0, arg_139_1)
		arg_139_1.time_ = 0
		arg_139_1.frameCnt_ = 0
		arg_139_1.state_ = "playing"
		arg_139_1.curTalkId_ = 411051034
		arg_139_1.duration_ = 4

		local var_139_0 = {
			zh = 1.033,
			ja = 4
		}
		local var_139_1 = manager.audio:GetLocalizationFlag()

		if var_139_0[var_139_1] ~= nil then
			arg_139_1.duration_ = var_139_0[var_139_1]
		end

		SetActive(arg_139_1.tipsGo_, false)

		function arg_139_1.onSingleLineFinish_()
			arg_139_1.onSingleLineUpdate_ = nil
			arg_139_1.onSingleLineFinish_ = nil
			arg_139_1.state_ = "waiting"
		end

		function arg_139_1.playNext_(arg_141_0)
			if arg_141_0 == 1 then
				arg_139_0:Play411051035(arg_139_1)
			end
		end

		function arg_139_1.onSingleLineUpdate_(arg_142_0)
			local var_142_0 = arg_139_1.actors_["10058ui_story"]
			local var_142_1 = 0

			if var_142_1 < arg_139_1.time_ and arg_139_1.time_ <= var_142_1 + arg_142_0 and arg_139_1.var_.characterEffect10058ui_story == nil then
				arg_139_1.var_.characterEffect10058ui_story = var_142_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_2 = 0.200000002980232

			if var_142_1 <= arg_139_1.time_ and arg_139_1.time_ < var_142_1 + var_142_2 then
				local var_142_3 = (arg_139_1.time_ - var_142_1) / var_142_2

				if arg_139_1.var_.characterEffect10058ui_story then
					arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_139_1.time_ >= var_142_1 + var_142_2 and arg_139_1.time_ < var_142_1 + var_142_2 + arg_142_0 and arg_139_1.var_.characterEffect10058ui_story then
				arg_139_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_142_4 = arg_139_1.actors_["10014ui_story"]
			local var_142_5 = 0

			if var_142_5 < arg_139_1.time_ and arg_139_1.time_ <= var_142_5 + arg_142_0 and arg_139_1.var_.characterEffect10014ui_story == nil then
				arg_139_1.var_.characterEffect10014ui_story = var_142_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_142_6 = 0.200000002980232

			if var_142_5 <= arg_139_1.time_ and arg_139_1.time_ < var_142_5 + var_142_6 then
				local var_142_7 = (arg_139_1.time_ - var_142_5) / var_142_6

				if arg_139_1.var_.characterEffect10014ui_story then
					local var_142_8 = Mathf.Lerp(0, 0.5, var_142_7)

					arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_8
				end
			end

			if arg_139_1.time_ >= var_142_5 + var_142_6 and arg_139_1.time_ < var_142_5 + var_142_6 + arg_142_0 and arg_139_1.var_.characterEffect10014ui_story then
				local var_142_9 = 0.5

				arg_139_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_139_1.var_.characterEffect10014ui_story.fillRatio = var_142_9
			end

			local var_142_10 = 0
			local var_142_11 = 0.125

			if var_142_10 < arg_139_1.time_ and arg_139_1.time_ <= var_142_10 + arg_142_0 then
				arg_139_1.talkMaxDuration = 0
				arg_139_1.dialogCg_.alpha = 1

				arg_139_1.dialog_:SetActive(true)
				SetActive(arg_139_1.leftNameGo_, true)

				local var_142_12 = arg_139_1:FormatText(StoryNameCfg[471].name)

				arg_139_1.leftNameTxt_.text = var_142_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_139_1.leftNameTxt_.transform)

				arg_139_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_139_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_139_1:RecordName(arg_139_1.leftNameTxt_.text)
				SetActive(arg_139_1.iconTrs_.gameObject, false)
				arg_139_1.callingController_:SetSelectedState("normal")

				local var_142_13 = arg_139_1:GetWordFromCfg(411051034)
				local var_142_14 = arg_139_1:FormatText(var_142_13.content)

				arg_139_1.text_.text = var_142_14

				LuaForUtil.ClearLinePrefixSymbol(arg_139_1.text_)

				local var_142_15 = 5
				local var_142_16 = utf8.len(var_142_14)
				local var_142_17 = var_142_15 <= 0 and var_142_11 or var_142_11 * (var_142_16 / var_142_15)

				if var_142_17 > 0 and var_142_11 < var_142_17 then
					arg_139_1.talkMaxDuration = var_142_17

					if var_142_17 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_17 + var_142_10
					end
				end

				arg_139_1.text_.text = var_142_14
				arg_139_1.typewritter.percent = 0

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") ~= 0 then
					local var_142_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051034", "story_v_out_411051.awb") / 1000

					if var_142_18 + var_142_10 > arg_139_1.duration_ then
						arg_139_1.duration_ = var_142_18 + var_142_10
					end

					if var_142_13.prefab_name ~= "" and arg_139_1.actors_[var_142_13.prefab_name] ~= nil then
						local var_142_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_139_1.actors_[var_142_13.prefab_name].transform, "story_v_out_411051", "411051034", "story_v_out_411051.awb")

						arg_139_1:RecordAudio("411051034", var_142_19)
						arg_139_1:RecordAudio("411051034", var_142_19)
					else
						arg_139_1:AudioAction("play", "voice", "story_v_out_411051", "411051034", "story_v_out_411051.awb")
					end

					arg_139_1:RecordHistoryTalkVoice("story_v_out_411051", "411051034", "story_v_out_411051.awb")
				end

				arg_139_1:RecordContent(arg_139_1.text_.text)
			end

			local var_142_20 = math.max(var_142_11, arg_139_1.talkMaxDuration)

			if var_142_10 <= arg_139_1.time_ and arg_139_1.time_ < var_142_10 + var_142_20 then
				arg_139_1.typewritter.percent = (arg_139_1.time_ - var_142_10) / var_142_20

				arg_139_1.typewritter:SetDirty()
			end

			if arg_139_1.time_ >= var_142_10 + var_142_20 and arg_139_1.time_ < var_142_10 + var_142_20 + arg_142_0 then
				arg_139_1.typewritter.percent = 1

				arg_139_1.typewritter:SetDirty()
				arg_139_1:ShowNextGo(true)
			end
		end
	end,
	Play411051035 = function(arg_143_0, arg_143_1)
		arg_143_1.time_ = 0
		arg_143_1.frameCnt_ = 0
		arg_143_1.state_ = "playing"
		arg_143_1.curTalkId_ = 411051035
		arg_143_1.duration_ = 6.3

		local var_143_0 = {
			zh = 4.3,
			ja = 6.3
		}
		local var_143_1 = manager.audio:GetLocalizationFlag()

		if var_143_0[var_143_1] ~= nil then
			arg_143_1.duration_ = var_143_0[var_143_1]
		end

		SetActive(arg_143_1.tipsGo_, false)

		function arg_143_1.onSingleLineFinish_()
			arg_143_1.onSingleLineUpdate_ = nil
			arg_143_1.onSingleLineFinish_ = nil
			arg_143_1.state_ = "waiting"
		end

		function arg_143_1.playNext_(arg_145_0)
			if arg_145_0 == 1 then
				arg_143_0:Play411051036(arg_143_1)
			end
		end

		function arg_143_1.onSingleLineUpdate_(arg_146_0)
			local var_146_0 = 0

			if var_146_0 < arg_143_1.time_ and arg_143_1.time_ <= var_146_0 + arg_146_0 then
				arg_143_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_146_1 = 0
			local var_146_2 = 0.575

			if var_146_1 < arg_143_1.time_ and arg_143_1.time_ <= var_146_1 + arg_146_0 then
				arg_143_1.talkMaxDuration = 0
				arg_143_1.dialogCg_.alpha = 1

				arg_143_1.dialog_:SetActive(true)
				SetActive(arg_143_1.leftNameGo_, true)

				local var_146_3 = arg_143_1:FormatText(StoryNameCfg[471].name)

				arg_143_1.leftNameTxt_.text = var_146_3

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_143_1.leftNameTxt_.transform)

				arg_143_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_143_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_143_1:RecordName(arg_143_1.leftNameTxt_.text)
				SetActive(arg_143_1.iconTrs_.gameObject, false)
				arg_143_1.callingController_:SetSelectedState("normal")

				local var_146_4 = arg_143_1:GetWordFromCfg(411051035)
				local var_146_5 = arg_143_1:FormatText(var_146_4.content)

				arg_143_1.text_.text = var_146_5

				LuaForUtil.ClearLinePrefixSymbol(arg_143_1.text_)

				local var_146_6 = 23
				local var_146_7 = utf8.len(var_146_5)
				local var_146_8 = var_146_6 <= 0 and var_146_2 or var_146_2 * (var_146_7 / var_146_6)

				if var_146_8 > 0 and var_146_2 < var_146_8 then
					arg_143_1.talkMaxDuration = var_146_8

					if var_146_8 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_8 + var_146_1
					end
				end

				arg_143_1.text_.text = var_146_5
				arg_143_1.typewritter.percent = 0

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") ~= 0 then
					local var_146_9 = manager.audio:GetVoiceLength("story_v_out_411051", "411051035", "story_v_out_411051.awb") / 1000

					if var_146_9 + var_146_1 > arg_143_1.duration_ then
						arg_143_1.duration_ = var_146_9 + var_146_1
					end

					if var_146_4.prefab_name ~= "" and arg_143_1.actors_[var_146_4.prefab_name] ~= nil then
						local var_146_10 = LuaForUtil.PlayVoiceWithCriLipsync(arg_143_1.actors_[var_146_4.prefab_name].transform, "story_v_out_411051", "411051035", "story_v_out_411051.awb")

						arg_143_1:RecordAudio("411051035", var_146_10)
						arg_143_1:RecordAudio("411051035", var_146_10)
					else
						arg_143_1:AudioAction("play", "voice", "story_v_out_411051", "411051035", "story_v_out_411051.awb")
					end

					arg_143_1:RecordHistoryTalkVoice("story_v_out_411051", "411051035", "story_v_out_411051.awb")
				end

				arg_143_1:RecordContent(arg_143_1.text_.text)
			end

			local var_146_11 = math.max(var_146_2, arg_143_1.talkMaxDuration)

			if var_146_1 <= arg_143_1.time_ and arg_143_1.time_ < var_146_1 + var_146_11 then
				arg_143_1.typewritter.percent = (arg_143_1.time_ - var_146_1) / var_146_11

				arg_143_1.typewritter:SetDirty()
			end

			if arg_143_1.time_ >= var_146_1 + var_146_11 and arg_143_1.time_ < var_146_1 + var_146_11 + arg_146_0 then
				arg_143_1.typewritter.percent = 1

				arg_143_1.typewritter:SetDirty()
				arg_143_1:ShowNextGo(true)
			end
		end
	end,
	Play411051036 = function(arg_147_0, arg_147_1)
		arg_147_1.time_ = 0
		arg_147_1.frameCnt_ = 0
		arg_147_1.state_ = "playing"
		arg_147_1.curTalkId_ = 411051036
		arg_147_1.duration_ = 3.933

		local var_147_0 = {
			zh = 2.033,
			ja = 3.933
		}
		local var_147_1 = manager.audio:GetLocalizationFlag()

		if var_147_0[var_147_1] ~= nil then
			arg_147_1.duration_ = var_147_0[var_147_1]
		end

		SetActive(arg_147_1.tipsGo_, false)

		function arg_147_1.onSingleLineFinish_()
			arg_147_1.onSingleLineUpdate_ = nil
			arg_147_1.onSingleLineFinish_ = nil
			arg_147_1.state_ = "waiting"
		end

		function arg_147_1.playNext_(arg_149_0)
			if arg_149_0 == 1 then
				arg_147_0:Play411051037(arg_147_1)
			end
		end

		function arg_147_1.onSingleLineUpdate_(arg_150_0)
			local var_150_0 = arg_147_1.actors_["10014ui_story"].transform
			local var_150_1 = 0

			if var_150_1 < arg_147_1.time_ and arg_147_1.time_ <= var_150_1 + arg_150_0 then
				arg_147_1.var_.moveOldPos10014ui_story = var_150_0.localPosition
			end

			local var_150_2 = 0.001

			if var_150_1 <= arg_147_1.time_ and arg_147_1.time_ < var_150_1 + var_150_2 then
				local var_150_3 = (arg_147_1.time_ - var_150_1) / var_150_2
				local var_150_4 = Vector3.New(0.7, -1.06, -6.2)

				var_150_0.localPosition = Vector3.Lerp(arg_147_1.var_.moveOldPos10014ui_story, var_150_4, var_150_3)

				local var_150_5 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_5.x, var_150_5.y, var_150_5.z)

				local var_150_6 = var_150_0.localEulerAngles

				var_150_6.z = 0
				var_150_6.x = 0
				var_150_0.localEulerAngles = var_150_6
			end

			if arg_147_1.time_ >= var_150_1 + var_150_2 and arg_147_1.time_ < var_150_1 + var_150_2 + arg_150_0 then
				var_150_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_150_7 = manager.ui.mainCamera.transform.position - var_150_0.position

				var_150_0.forward = Vector3.New(var_150_7.x, var_150_7.y, var_150_7.z)

				local var_150_8 = var_150_0.localEulerAngles

				var_150_8.z = 0
				var_150_8.x = 0
				var_150_0.localEulerAngles = var_150_8
			end

			local var_150_9 = arg_147_1.actors_["10014ui_story"]
			local var_150_10 = 0

			if var_150_10 < arg_147_1.time_ and arg_147_1.time_ <= var_150_10 + arg_150_0 and arg_147_1.var_.characterEffect10014ui_story == nil then
				arg_147_1.var_.characterEffect10014ui_story = var_150_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_11 = 0.200000002980232

			if var_150_10 <= arg_147_1.time_ and arg_147_1.time_ < var_150_10 + var_150_11 then
				local var_150_12 = (arg_147_1.time_ - var_150_10) / var_150_11

				if arg_147_1.var_.characterEffect10014ui_story then
					arg_147_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_147_1.time_ >= var_150_10 + var_150_11 and arg_147_1.time_ < var_150_10 + var_150_11 + arg_150_0 and arg_147_1.var_.characterEffect10014ui_story then
				arg_147_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_150_13 = 0

			if var_150_13 < arg_147_1.time_ and arg_147_1.time_ <= var_150_13 + arg_150_0 then
				arg_147_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_1")
			end

			local var_150_14 = 0

			if var_150_14 < arg_147_1.time_ and arg_147_1.time_ <= var_150_14 + arg_150_0 then
				arg_147_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_150_15 = arg_147_1.actors_["10058ui_story"]
			local var_150_16 = 0

			if var_150_16 < arg_147_1.time_ and arg_147_1.time_ <= var_150_16 + arg_150_0 and arg_147_1.var_.characterEffect10058ui_story == nil then
				arg_147_1.var_.characterEffect10058ui_story = var_150_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_150_17 = 0.200000002980232

			if var_150_16 <= arg_147_1.time_ and arg_147_1.time_ < var_150_16 + var_150_17 then
				local var_150_18 = (arg_147_1.time_ - var_150_16) / var_150_17

				if arg_147_1.var_.characterEffect10058ui_story then
					local var_150_19 = Mathf.Lerp(0, 0.5, var_150_18)

					arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_19
				end
			end

			if arg_147_1.time_ >= var_150_16 + var_150_17 and arg_147_1.time_ < var_150_16 + var_150_17 + arg_150_0 and arg_147_1.var_.characterEffect10058ui_story then
				local var_150_20 = 0.5

				arg_147_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_147_1.var_.characterEffect10058ui_story.fillRatio = var_150_20
			end

			local var_150_21 = 0
			local var_150_22 = 0.25

			if var_150_21 < arg_147_1.time_ and arg_147_1.time_ <= var_150_21 + arg_150_0 then
				arg_147_1.talkMaxDuration = 0
				arg_147_1.dialogCg_.alpha = 1

				arg_147_1.dialog_:SetActive(true)
				SetActive(arg_147_1.leftNameGo_, true)

				local var_150_23 = arg_147_1:FormatText(StoryNameCfg[264].name)

				arg_147_1.leftNameTxt_.text = var_150_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_147_1.leftNameTxt_.transform)

				arg_147_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_147_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_147_1:RecordName(arg_147_1.leftNameTxt_.text)
				SetActive(arg_147_1.iconTrs_.gameObject, false)
				arg_147_1.callingController_:SetSelectedState("normal")

				local var_150_24 = arg_147_1:GetWordFromCfg(411051036)
				local var_150_25 = arg_147_1:FormatText(var_150_24.content)

				arg_147_1.text_.text = var_150_25

				LuaForUtil.ClearLinePrefixSymbol(arg_147_1.text_)

				local var_150_26 = 10
				local var_150_27 = utf8.len(var_150_25)
				local var_150_28 = var_150_26 <= 0 and var_150_22 or var_150_22 * (var_150_27 / var_150_26)

				if var_150_28 > 0 and var_150_22 < var_150_28 then
					arg_147_1.talkMaxDuration = var_150_28

					if var_150_28 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_28 + var_150_21
					end
				end

				arg_147_1.text_.text = var_150_25
				arg_147_1.typewritter.percent = 0

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") ~= 0 then
					local var_150_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051036", "story_v_out_411051.awb") / 1000

					if var_150_29 + var_150_21 > arg_147_1.duration_ then
						arg_147_1.duration_ = var_150_29 + var_150_21
					end

					if var_150_24.prefab_name ~= "" and arg_147_1.actors_[var_150_24.prefab_name] ~= nil then
						local var_150_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_147_1.actors_[var_150_24.prefab_name].transform, "story_v_out_411051", "411051036", "story_v_out_411051.awb")

						arg_147_1:RecordAudio("411051036", var_150_30)
						arg_147_1:RecordAudio("411051036", var_150_30)
					else
						arg_147_1:AudioAction("play", "voice", "story_v_out_411051", "411051036", "story_v_out_411051.awb")
					end

					arg_147_1:RecordHistoryTalkVoice("story_v_out_411051", "411051036", "story_v_out_411051.awb")
				end

				arg_147_1:RecordContent(arg_147_1.text_.text)
			end

			local var_150_31 = math.max(var_150_22, arg_147_1.talkMaxDuration)

			if var_150_21 <= arg_147_1.time_ and arg_147_1.time_ < var_150_21 + var_150_31 then
				arg_147_1.typewritter.percent = (arg_147_1.time_ - var_150_21) / var_150_31

				arg_147_1.typewritter:SetDirty()
			end

			if arg_147_1.time_ >= var_150_21 + var_150_31 and arg_147_1.time_ < var_150_21 + var_150_31 + arg_150_0 then
				arg_147_1.typewritter.percent = 1

				arg_147_1.typewritter:SetDirty()
				arg_147_1:ShowNextGo(true)
			end
		end
	end,
	Play411051037 = function(arg_151_0, arg_151_1)
		arg_151_1.time_ = 0
		arg_151_1.frameCnt_ = 0
		arg_151_1.state_ = "playing"
		arg_151_1.curTalkId_ = 411051037
		arg_151_1.duration_ = 3.033

		local var_151_0 = {
			zh = 3.033,
			ja = 1.8
		}
		local var_151_1 = manager.audio:GetLocalizationFlag()

		if var_151_0[var_151_1] ~= nil then
			arg_151_1.duration_ = var_151_0[var_151_1]
		end

		SetActive(arg_151_1.tipsGo_, false)

		function arg_151_1.onSingleLineFinish_()
			arg_151_1.onSingleLineUpdate_ = nil
			arg_151_1.onSingleLineFinish_ = nil
			arg_151_1.state_ = "waiting"
		end

		function arg_151_1.playNext_(arg_153_0)
			if arg_153_0 == 1 then
				arg_151_0:Play411051038(arg_151_1)
			end
		end

		function arg_151_1.onSingleLineUpdate_(arg_154_0)
			local var_154_0 = arg_151_1.actors_["10014ui_story"]
			local var_154_1 = 0

			if var_154_1 < arg_151_1.time_ and arg_151_1.time_ <= var_154_1 + arg_154_0 and arg_151_1.var_.characterEffect10014ui_story == nil then
				arg_151_1.var_.characterEffect10014ui_story = var_154_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_2 = 0.200000002980232

			if var_154_1 <= arg_151_1.time_ and arg_151_1.time_ < var_154_1 + var_154_2 then
				local var_154_3 = (arg_151_1.time_ - var_154_1) / var_154_2

				if arg_151_1.var_.characterEffect10014ui_story then
					local var_154_4 = Mathf.Lerp(0, 0.5, var_154_3)

					arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_4
				end
			end

			if arg_151_1.time_ >= var_154_1 + var_154_2 and arg_151_1.time_ < var_154_1 + var_154_2 + arg_154_0 and arg_151_1.var_.characterEffect10014ui_story then
				local var_154_5 = 0.5

				arg_151_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_151_1.var_.characterEffect10014ui_story.fillRatio = var_154_5
			end

			local var_154_6 = arg_151_1.actors_["10058ui_story"]
			local var_154_7 = 0

			if var_154_7 < arg_151_1.time_ and arg_151_1.time_ <= var_154_7 + arg_154_0 and arg_151_1.var_.characterEffect10058ui_story == nil then
				arg_151_1.var_.characterEffect10058ui_story = var_154_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_154_8 = 0.200000002980232

			if var_154_7 <= arg_151_1.time_ and arg_151_1.time_ < var_154_7 + var_154_8 then
				local var_154_9 = (arg_151_1.time_ - var_154_7) / var_154_8

				if arg_151_1.var_.characterEffect10058ui_story then
					arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_151_1.time_ >= var_154_7 + var_154_8 and arg_151_1.time_ < var_154_7 + var_154_8 + arg_154_0 and arg_151_1.var_.characterEffect10058ui_story then
				arg_151_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_154_10 = 0
			local var_154_11 = 0.35

			if var_154_10 < arg_151_1.time_ and arg_151_1.time_ <= var_154_10 + arg_154_0 then
				arg_151_1.talkMaxDuration = 0
				arg_151_1.dialogCg_.alpha = 1

				arg_151_1.dialog_:SetActive(true)
				SetActive(arg_151_1.leftNameGo_, true)

				local var_154_12 = arg_151_1:FormatText(StoryNameCfg[471].name)

				arg_151_1.leftNameTxt_.text = var_154_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_151_1.leftNameTxt_.transform)

				arg_151_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_151_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_151_1:RecordName(arg_151_1.leftNameTxt_.text)
				SetActive(arg_151_1.iconTrs_.gameObject, false)
				arg_151_1.callingController_:SetSelectedState("normal")

				local var_154_13 = arg_151_1:GetWordFromCfg(411051037)
				local var_154_14 = arg_151_1:FormatText(var_154_13.content)

				arg_151_1.text_.text = var_154_14

				LuaForUtil.ClearLinePrefixSymbol(arg_151_1.text_)

				local var_154_15 = 14
				local var_154_16 = utf8.len(var_154_14)
				local var_154_17 = var_154_15 <= 0 and var_154_11 or var_154_11 * (var_154_16 / var_154_15)

				if var_154_17 > 0 and var_154_11 < var_154_17 then
					arg_151_1.talkMaxDuration = var_154_17

					if var_154_17 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_17 + var_154_10
					end
				end

				arg_151_1.text_.text = var_154_14
				arg_151_1.typewritter.percent = 0

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") ~= 0 then
					local var_154_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051037", "story_v_out_411051.awb") / 1000

					if var_154_18 + var_154_10 > arg_151_1.duration_ then
						arg_151_1.duration_ = var_154_18 + var_154_10
					end

					if var_154_13.prefab_name ~= "" and arg_151_1.actors_[var_154_13.prefab_name] ~= nil then
						local var_154_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_151_1.actors_[var_154_13.prefab_name].transform, "story_v_out_411051", "411051037", "story_v_out_411051.awb")

						arg_151_1:RecordAudio("411051037", var_154_19)
						arg_151_1:RecordAudio("411051037", var_154_19)
					else
						arg_151_1:AudioAction("play", "voice", "story_v_out_411051", "411051037", "story_v_out_411051.awb")
					end

					arg_151_1:RecordHistoryTalkVoice("story_v_out_411051", "411051037", "story_v_out_411051.awb")
				end

				arg_151_1:RecordContent(arg_151_1.text_.text)
			end

			local var_154_20 = math.max(var_154_11, arg_151_1.talkMaxDuration)

			if var_154_10 <= arg_151_1.time_ and arg_151_1.time_ < var_154_10 + var_154_20 then
				arg_151_1.typewritter.percent = (arg_151_1.time_ - var_154_10) / var_154_20

				arg_151_1.typewritter:SetDirty()
			end

			if arg_151_1.time_ >= var_154_10 + var_154_20 and arg_151_1.time_ < var_154_10 + var_154_20 + arg_154_0 then
				arg_151_1.typewritter.percent = 1

				arg_151_1.typewritter:SetDirty()
				arg_151_1:ShowNextGo(true)
			end
		end
	end,
	Play411051038 = function(arg_155_0, arg_155_1)
		arg_155_1.time_ = 0
		arg_155_1.frameCnt_ = 0
		arg_155_1.state_ = "playing"
		arg_155_1.curTalkId_ = 411051038
		arg_155_1.duration_ = 11.5

		local var_155_0 = {
			zh = 11.5,
			ja = 8
		}
		local var_155_1 = manager.audio:GetLocalizationFlag()

		if var_155_0[var_155_1] ~= nil then
			arg_155_1.duration_ = var_155_0[var_155_1]
		end

		SetActive(arg_155_1.tipsGo_, false)

		function arg_155_1.onSingleLineFinish_()
			arg_155_1.onSingleLineUpdate_ = nil
			arg_155_1.onSingleLineFinish_ = nil
			arg_155_1.state_ = "waiting"
		end

		function arg_155_1.playNext_(arg_157_0)
			if arg_157_0 == 1 then
				arg_155_0:Play411051039(arg_155_1)
			end
		end

		function arg_155_1.onSingleLineUpdate_(arg_158_0)
			local var_158_0 = arg_155_1.actors_["10014ui_story"]
			local var_158_1 = 0

			if var_158_1 < arg_155_1.time_ and arg_155_1.time_ <= var_158_1 + arg_158_0 and arg_155_1.var_.characterEffect10014ui_story == nil then
				arg_155_1.var_.characterEffect10014ui_story = var_158_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_2 = 0.200000002980232

			if var_158_1 <= arg_155_1.time_ and arg_155_1.time_ < var_158_1 + var_158_2 then
				local var_158_3 = (arg_155_1.time_ - var_158_1) / var_158_2

				if arg_155_1.var_.characterEffect10014ui_story then
					arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_155_1.time_ >= var_158_1 + var_158_2 and arg_155_1.time_ < var_158_1 + var_158_2 + arg_158_0 and arg_155_1.var_.characterEffect10014ui_story then
				arg_155_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_158_4 = arg_155_1.actors_["10058ui_story"]
			local var_158_5 = 0

			if var_158_5 < arg_155_1.time_ and arg_155_1.time_ <= var_158_5 + arg_158_0 and arg_155_1.var_.characterEffect10058ui_story == nil then
				arg_155_1.var_.characterEffect10058ui_story = var_158_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_158_6 = 0.200000002980232

			if var_158_5 <= arg_155_1.time_ and arg_155_1.time_ < var_158_5 + var_158_6 then
				local var_158_7 = (arg_155_1.time_ - var_158_5) / var_158_6

				if arg_155_1.var_.characterEffect10058ui_story then
					local var_158_8 = Mathf.Lerp(0, 0.5, var_158_7)

					arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_155_1.var_.characterEffect10058ui_story.fillRatio = var_158_8
				end
			end

			if arg_155_1.time_ >= var_158_5 + var_158_6 and arg_155_1.time_ < var_158_5 + var_158_6 + arg_158_0 and arg_155_1.var_.characterEffect10058ui_story then
				local var_158_9 = 0.5

				arg_155_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_155_1.var_.characterEffect10058ui_story.fillRatio = var_158_9
			end

			local var_158_10 = 0
			local var_158_11 = 1.3

			if var_158_10 < arg_155_1.time_ and arg_155_1.time_ <= var_158_10 + arg_158_0 then
				arg_155_1.talkMaxDuration = 0
				arg_155_1.dialogCg_.alpha = 1

				arg_155_1.dialog_:SetActive(true)
				SetActive(arg_155_1.leftNameGo_, true)

				local var_158_12 = arg_155_1:FormatText(StoryNameCfg[264].name)

				arg_155_1.leftNameTxt_.text = var_158_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_155_1.leftNameTxt_.transform)

				arg_155_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_155_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_155_1:RecordName(arg_155_1.leftNameTxt_.text)
				SetActive(arg_155_1.iconTrs_.gameObject, false)
				arg_155_1.callingController_:SetSelectedState("normal")

				local var_158_13 = arg_155_1:GetWordFromCfg(411051038)
				local var_158_14 = arg_155_1:FormatText(var_158_13.content)

				arg_155_1.text_.text = var_158_14

				LuaForUtil.ClearLinePrefixSymbol(arg_155_1.text_)

				local var_158_15 = 52
				local var_158_16 = utf8.len(var_158_14)
				local var_158_17 = var_158_15 <= 0 and var_158_11 or var_158_11 * (var_158_16 / var_158_15)

				if var_158_17 > 0 and var_158_11 < var_158_17 then
					arg_155_1.talkMaxDuration = var_158_17

					if var_158_17 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_17 + var_158_10
					end
				end

				arg_155_1.text_.text = var_158_14
				arg_155_1.typewritter.percent = 0

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") ~= 0 then
					local var_158_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051038", "story_v_out_411051.awb") / 1000

					if var_158_18 + var_158_10 > arg_155_1.duration_ then
						arg_155_1.duration_ = var_158_18 + var_158_10
					end

					if var_158_13.prefab_name ~= "" and arg_155_1.actors_[var_158_13.prefab_name] ~= nil then
						local var_158_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_155_1.actors_[var_158_13.prefab_name].transform, "story_v_out_411051", "411051038", "story_v_out_411051.awb")

						arg_155_1:RecordAudio("411051038", var_158_19)
						arg_155_1:RecordAudio("411051038", var_158_19)
					else
						arg_155_1:AudioAction("play", "voice", "story_v_out_411051", "411051038", "story_v_out_411051.awb")
					end

					arg_155_1:RecordHistoryTalkVoice("story_v_out_411051", "411051038", "story_v_out_411051.awb")
				end

				arg_155_1:RecordContent(arg_155_1.text_.text)
			end

			local var_158_20 = math.max(var_158_11, arg_155_1.talkMaxDuration)

			if var_158_10 <= arg_155_1.time_ and arg_155_1.time_ < var_158_10 + var_158_20 then
				arg_155_1.typewritter.percent = (arg_155_1.time_ - var_158_10) / var_158_20

				arg_155_1.typewritter:SetDirty()
			end

			if arg_155_1.time_ >= var_158_10 + var_158_20 and arg_155_1.time_ < var_158_10 + var_158_20 + arg_158_0 then
				arg_155_1.typewritter.percent = 1

				arg_155_1.typewritter:SetDirty()
				arg_155_1:ShowNextGo(true)
			end
		end
	end,
	Play411051039 = function(arg_159_0, arg_159_1)
		arg_159_1.time_ = 0
		arg_159_1.frameCnt_ = 0
		arg_159_1.state_ = "playing"
		arg_159_1.curTalkId_ = 411051039
		arg_159_1.duration_ = 8.233

		local var_159_0 = {
			zh = 5.8,
			ja = 8.233
		}
		local var_159_1 = manager.audio:GetLocalizationFlag()

		if var_159_0[var_159_1] ~= nil then
			arg_159_1.duration_ = var_159_0[var_159_1]
		end

		SetActive(arg_159_1.tipsGo_, false)

		function arg_159_1.onSingleLineFinish_()
			arg_159_1.onSingleLineUpdate_ = nil
			arg_159_1.onSingleLineFinish_ = nil
			arg_159_1.state_ = "waiting"
		end

		function arg_159_1.playNext_(arg_161_0)
			if arg_161_0 == 1 then
				arg_159_0:Play411051040(arg_159_1)
			end
		end

		function arg_159_1.onSingleLineUpdate_(arg_162_0)
			local var_162_0 = 0
			local var_162_1 = 0.75

			if var_162_0 < arg_159_1.time_ and arg_159_1.time_ <= var_162_0 + arg_162_0 then
				arg_159_1.talkMaxDuration = 0
				arg_159_1.dialogCg_.alpha = 1

				arg_159_1.dialog_:SetActive(true)
				SetActive(arg_159_1.leftNameGo_, true)

				local var_162_2 = arg_159_1:FormatText(StoryNameCfg[264].name)

				arg_159_1.leftNameTxt_.text = var_162_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_159_1.leftNameTxt_.transform)

				arg_159_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_159_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_159_1:RecordName(arg_159_1.leftNameTxt_.text)
				SetActive(arg_159_1.iconTrs_.gameObject, false)
				arg_159_1.callingController_:SetSelectedState("normal")

				local var_162_3 = arg_159_1:GetWordFromCfg(411051039)
				local var_162_4 = arg_159_1:FormatText(var_162_3.content)

				arg_159_1.text_.text = var_162_4

				LuaForUtil.ClearLinePrefixSymbol(arg_159_1.text_)

				local var_162_5 = 30
				local var_162_6 = utf8.len(var_162_4)
				local var_162_7 = var_162_5 <= 0 and var_162_1 or var_162_1 * (var_162_6 / var_162_5)

				if var_162_7 > 0 and var_162_1 < var_162_7 then
					arg_159_1.talkMaxDuration = var_162_7

					if var_162_7 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_7 + var_162_0
					end
				end

				arg_159_1.text_.text = var_162_4
				arg_159_1.typewritter.percent = 0

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") ~= 0 then
					local var_162_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051039", "story_v_out_411051.awb") / 1000

					if var_162_8 + var_162_0 > arg_159_1.duration_ then
						arg_159_1.duration_ = var_162_8 + var_162_0
					end

					if var_162_3.prefab_name ~= "" and arg_159_1.actors_[var_162_3.prefab_name] ~= nil then
						local var_162_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_159_1.actors_[var_162_3.prefab_name].transform, "story_v_out_411051", "411051039", "story_v_out_411051.awb")

						arg_159_1:RecordAudio("411051039", var_162_9)
						arg_159_1:RecordAudio("411051039", var_162_9)
					else
						arg_159_1:AudioAction("play", "voice", "story_v_out_411051", "411051039", "story_v_out_411051.awb")
					end

					arg_159_1:RecordHistoryTalkVoice("story_v_out_411051", "411051039", "story_v_out_411051.awb")
				end

				arg_159_1:RecordContent(arg_159_1.text_.text)
			end

			local var_162_10 = math.max(var_162_1, arg_159_1.talkMaxDuration)

			if var_162_0 <= arg_159_1.time_ and arg_159_1.time_ < var_162_0 + var_162_10 then
				arg_159_1.typewritter.percent = (arg_159_1.time_ - var_162_0) / var_162_10

				arg_159_1.typewritter:SetDirty()
			end

			if arg_159_1.time_ >= var_162_0 + var_162_10 and arg_159_1.time_ < var_162_0 + var_162_10 + arg_162_0 then
				arg_159_1.typewritter.percent = 1

				arg_159_1.typewritter:SetDirty()
				arg_159_1:ShowNextGo(true)
			end
		end
	end,
	Play411051040 = function(arg_163_0, arg_163_1)
		arg_163_1.time_ = 0
		arg_163_1.frameCnt_ = 0
		arg_163_1.state_ = "playing"
		arg_163_1.curTalkId_ = 411051040
		arg_163_1.duration_ = 4.6

		local var_163_0 = {
			zh = 2.666,
			ja = 4.6
		}
		local var_163_1 = manager.audio:GetLocalizationFlag()

		if var_163_0[var_163_1] ~= nil then
			arg_163_1.duration_ = var_163_0[var_163_1]
		end

		SetActive(arg_163_1.tipsGo_, false)

		function arg_163_1.onSingleLineFinish_()
			arg_163_1.onSingleLineUpdate_ = nil
			arg_163_1.onSingleLineFinish_ = nil
			arg_163_1.state_ = "waiting"
		end

		function arg_163_1.playNext_(arg_165_0)
			if arg_165_0 == 1 then
				arg_163_0:Play411051041(arg_163_1)
			end
		end

		function arg_163_1.onSingleLineUpdate_(arg_166_0)
			local var_166_0 = arg_163_1.actors_["10058ui_story"].transform
			local var_166_1 = 0

			if var_166_1 < arg_163_1.time_ and arg_163_1.time_ <= var_166_1 + arg_166_0 then
				arg_163_1.var_.moveOldPos10058ui_story = var_166_0.localPosition
			end

			local var_166_2 = 0.001

			if var_166_1 <= arg_163_1.time_ and arg_163_1.time_ < var_166_1 + var_166_2 then
				local var_166_3 = (arg_163_1.time_ - var_166_1) / var_166_2
				local var_166_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_166_0.localPosition = Vector3.Lerp(arg_163_1.var_.moveOldPos10058ui_story, var_166_4, var_166_3)

				local var_166_5 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_5.x, var_166_5.y, var_166_5.z)

				local var_166_6 = var_166_0.localEulerAngles

				var_166_6.z = 0
				var_166_6.x = 0
				var_166_0.localEulerAngles = var_166_6
			end

			if arg_163_1.time_ >= var_166_1 + var_166_2 and arg_163_1.time_ < var_166_1 + var_166_2 + arg_166_0 then
				var_166_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_166_7 = manager.ui.mainCamera.transform.position - var_166_0.position

				var_166_0.forward = Vector3.New(var_166_7.x, var_166_7.y, var_166_7.z)

				local var_166_8 = var_166_0.localEulerAngles

				var_166_8.z = 0
				var_166_8.x = 0
				var_166_0.localEulerAngles = var_166_8
			end

			local var_166_9 = arg_163_1.actors_["10058ui_story"]
			local var_166_10 = 0

			if var_166_10 < arg_163_1.time_ and arg_163_1.time_ <= var_166_10 + arg_166_0 and arg_163_1.var_.characterEffect10058ui_story == nil then
				arg_163_1.var_.characterEffect10058ui_story = var_166_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_11 = 0.200000002980232

			if var_166_10 <= arg_163_1.time_ and arg_163_1.time_ < var_166_10 + var_166_11 then
				local var_166_12 = (arg_163_1.time_ - var_166_10) / var_166_11

				if arg_163_1.var_.characterEffect10058ui_story then
					arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_163_1.time_ >= var_166_10 + var_166_11 and arg_163_1.time_ < var_166_10 + var_166_11 + arg_166_0 and arg_163_1.var_.characterEffect10058ui_story then
				arg_163_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_166_13 = 0

			if var_166_13 < arg_163_1.time_ and arg_163_1.time_ <= var_166_13 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action2_1")
			end

			local var_166_14 = 0

			if var_166_14 < arg_163_1.time_ and arg_163_1.time_ <= var_166_14 + arg_166_0 then
				arg_163_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_166_15 = arg_163_1.actors_["10014ui_story"]
			local var_166_16 = 0

			if var_166_16 < arg_163_1.time_ and arg_163_1.time_ <= var_166_16 + arg_166_0 and arg_163_1.var_.characterEffect10014ui_story == nil then
				arg_163_1.var_.characterEffect10014ui_story = var_166_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_166_17 = 0.200000002980232

			if var_166_16 <= arg_163_1.time_ and arg_163_1.time_ < var_166_16 + var_166_17 then
				local var_166_18 = (arg_163_1.time_ - var_166_16) / var_166_17

				if arg_163_1.var_.characterEffect10014ui_story then
					local var_166_19 = Mathf.Lerp(0, 0.5, var_166_18)

					arg_163_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_163_1.var_.characterEffect10014ui_story.fillRatio = var_166_19
				end
			end

			if arg_163_1.time_ >= var_166_16 + var_166_17 and arg_163_1.time_ < var_166_16 + var_166_17 + arg_166_0 and arg_163_1.var_.characterEffect10014ui_story then
				local var_166_20 = 0.5

				arg_163_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_163_1.var_.characterEffect10014ui_story.fillRatio = var_166_20
			end

			local var_166_21 = 0
			local var_166_22 = 0.225

			if var_166_21 < arg_163_1.time_ and arg_163_1.time_ <= var_166_21 + arg_166_0 then
				arg_163_1.talkMaxDuration = 0
				arg_163_1.dialogCg_.alpha = 1

				arg_163_1.dialog_:SetActive(true)
				SetActive(arg_163_1.leftNameGo_, true)

				local var_166_23 = arg_163_1:FormatText(StoryNameCfg[471].name)

				arg_163_1.leftNameTxt_.text = var_166_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_163_1.leftNameTxt_.transform)

				arg_163_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_163_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_163_1:RecordName(arg_163_1.leftNameTxt_.text)
				SetActive(arg_163_1.iconTrs_.gameObject, false)
				arg_163_1.callingController_:SetSelectedState("normal")

				local var_166_24 = arg_163_1:GetWordFromCfg(411051040)
				local var_166_25 = arg_163_1:FormatText(var_166_24.content)

				arg_163_1.text_.text = var_166_25

				LuaForUtil.ClearLinePrefixSymbol(arg_163_1.text_)

				local var_166_26 = 9
				local var_166_27 = utf8.len(var_166_25)
				local var_166_28 = var_166_26 <= 0 and var_166_22 or var_166_22 * (var_166_27 / var_166_26)

				if var_166_28 > 0 and var_166_22 < var_166_28 then
					arg_163_1.talkMaxDuration = var_166_28

					if var_166_28 + var_166_21 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_28 + var_166_21
					end
				end

				arg_163_1.text_.text = var_166_25
				arg_163_1.typewritter.percent = 0

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") ~= 0 then
					local var_166_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051040", "story_v_out_411051.awb") / 1000

					if var_166_29 + var_166_21 > arg_163_1.duration_ then
						arg_163_1.duration_ = var_166_29 + var_166_21
					end

					if var_166_24.prefab_name ~= "" and arg_163_1.actors_[var_166_24.prefab_name] ~= nil then
						local var_166_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_163_1.actors_[var_166_24.prefab_name].transform, "story_v_out_411051", "411051040", "story_v_out_411051.awb")

						arg_163_1:RecordAudio("411051040", var_166_30)
						arg_163_1:RecordAudio("411051040", var_166_30)
					else
						arg_163_1:AudioAction("play", "voice", "story_v_out_411051", "411051040", "story_v_out_411051.awb")
					end

					arg_163_1:RecordHistoryTalkVoice("story_v_out_411051", "411051040", "story_v_out_411051.awb")
				end

				arg_163_1:RecordContent(arg_163_1.text_.text)
			end

			local var_166_31 = math.max(var_166_22, arg_163_1.talkMaxDuration)

			if var_166_21 <= arg_163_1.time_ and arg_163_1.time_ < var_166_21 + var_166_31 then
				arg_163_1.typewritter.percent = (arg_163_1.time_ - var_166_21) / var_166_31

				arg_163_1.typewritter:SetDirty()
			end

			if arg_163_1.time_ >= var_166_21 + var_166_31 and arg_163_1.time_ < var_166_21 + var_166_31 + arg_166_0 then
				arg_163_1.typewritter.percent = 1

				arg_163_1.typewritter:SetDirty()
				arg_163_1:ShowNextGo(true)
			end
		end
	end,
	Play411051041 = function(arg_167_0, arg_167_1)
		arg_167_1.time_ = 0
		arg_167_1.frameCnt_ = 0
		arg_167_1.state_ = "playing"
		arg_167_1.curTalkId_ = 411051041
		arg_167_1.duration_ = 6.9

		local var_167_0 = {
			zh = 6.9,
			ja = 6.666
		}
		local var_167_1 = manager.audio:GetLocalizationFlag()

		if var_167_0[var_167_1] ~= nil then
			arg_167_1.duration_ = var_167_0[var_167_1]
		end

		SetActive(arg_167_1.tipsGo_, false)

		function arg_167_1.onSingleLineFinish_()
			arg_167_1.onSingleLineUpdate_ = nil
			arg_167_1.onSingleLineFinish_ = nil
			arg_167_1.state_ = "waiting"
		end

		function arg_167_1.playNext_(arg_169_0)
			if arg_169_0 == 1 then
				arg_167_0:Play411051042(arg_167_1)
			end
		end

		function arg_167_1.onSingleLineUpdate_(arg_170_0)
			local var_170_0 = arg_167_1.actors_["10058ui_story"]
			local var_170_1 = 0

			if var_170_1 < arg_167_1.time_ and arg_167_1.time_ <= var_170_1 + arg_170_0 and arg_167_1.var_.characterEffect10058ui_story == nil then
				arg_167_1.var_.characterEffect10058ui_story = var_170_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_2 = 0.200000002980232

			if var_170_1 <= arg_167_1.time_ and arg_167_1.time_ < var_170_1 + var_170_2 then
				local var_170_3 = (arg_167_1.time_ - var_170_1) / var_170_2

				if arg_167_1.var_.characterEffect10058ui_story then
					local var_170_4 = Mathf.Lerp(0, 0.5, var_170_3)

					arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_4
				end
			end

			if arg_167_1.time_ >= var_170_1 + var_170_2 and arg_167_1.time_ < var_170_1 + var_170_2 + arg_170_0 and arg_167_1.var_.characterEffect10058ui_story then
				local var_170_5 = 0.5

				arg_167_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_167_1.var_.characterEffect10058ui_story.fillRatio = var_170_5
			end

			local var_170_6 = arg_167_1.actors_["10014ui_story"]
			local var_170_7 = 0

			if var_170_7 < arg_167_1.time_ and arg_167_1.time_ <= var_170_7 + arg_170_0 and arg_167_1.var_.characterEffect10014ui_story == nil then
				arg_167_1.var_.characterEffect10014ui_story = var_170_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_170_8 = 0.200000002980232

			if var_170_7 <= arg_167_1.time_ and arg_167_1.time_ < var_170_7 + var_170_8 then
				local var_170_9 = (arg_167_1.time_ - var_170_7) / var_170_8

				if arg_167_1.var_.characterEffect10014ui_story then
					arg_167_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_167_1.time_ >= var_170_7 + var_170_8 and arg_167_1.time_ < var_170_7 + var_170_8 + arg_170_0 and arg_167_1.var_.characterEffect10014ui_story then
				arg_167_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_170_10 = 0
			local var_170_11 = 0.875

			if var_170_10 < arg_167_1.time_ and arg_167_1.time_ <= var_170_10 + arg_170_0 then
				arg_167_1.talkMaxDuration = 0
				arg_167_1.dialogCg_.alpha = 1

				arg_167_1.dialog_:SetActive(true)
				SetActive(arg_167_1.leftNameGo_, true)

				local var_170_12 = arg_167_1:FormatText(StoryNameCfg[264].name)

				arg_167_1.leftNameTxt_.text = var_170_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_167_1.leftNameTxt_.transform)

				arg_167_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_167_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_167_1:RecordName(arg_167_1.leftNameTxt_.text)
				SetActive(arg_167_1.iconTrs_.gameObject, false)
				arg_167_1.callingController_:SetSelectedState("normal")

				local var_170_13 = arg_167_1:GetWordFromCfg(411051041)
				local var_170_14 = arg_167_1:FormatText(var_170_13.content)

				arg_167_1.text_.text = var_170_14

				LuaForUtil.ClearLinePrefixSymbol(arg_167_1.text_)

				local var_170_15 = 35
				local var_170_16 = utf8.len(var_170_14)
				local var_170_17 = var_170_15 <= 0 and var_170_11 or var_170_11 * (var_170_16 / var_170_15)

				if var_170_17 > 0 and var_170_11 < var_170_17 then
					arg_167_1.talkMaxDuration = var_170_17

					if var_170_17 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_17 + var_170_10
					end
				end

				arg_167_1.text_.text = var_170_14
				arg_167_1.typewritter.percent = 0

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") ~= 0 then
					local var_170_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051041", "story_v_out_411051.awb") / 1000

					if var_170_18 + var_170_10 > arg_167_1.duration_ then
						arg_167_1.duration_ = var_170_18 + var_170_10
					end

					if var_170_13.prefab_name ~= "" and arg_167_1.actors_[var_170_13.prefab_name] ~= nil then
						local var_170_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_167_1.actors_[var_170_13.prefab_name].transform, "story_v_out_411051", "411051041", "story_v_out_411051.awb")

						arg_167_1:RecordAudio("411051041", var_170_19)
						arg_167_1:RecordAudio("411051041", var_170_19)
					else
						arg_167_1:AudioAction("play", "voice", "story_v_out_411051", "411051041", "story_v_out_411051.awb")
					end

					arg_167_1:RecordHistoryTalkVoice("story_v_out_411051", "411051041", "story_v_out_411051.awb")
				end

				arg_167_1:RecordContent(arg_167_1.text_.text)
			end

			local var_170_20 = math.max(var_170_11, arg_167_1.talkMaxDuration)

			if var_170_10 <= arg_167_1.time_ and arg_167_1.time_ < var_170_10 + var_170_20 then
				arg_167_1.typewritter.percent = (arg_167_1.time_ - var_170_10) / var_170_20

				arg_167_1.typewritter:SetDirty()
			end

			if arg_167_1.time_ >= var_170_10 + var_170_20 and arg_167_1.time_ < var_170_10 + var_170_20 + arg_170_0 then
				arg_167_1.typewritter.percent = 1

				arg_167_1.typewritter:SetDirty()
				arg_167_1:ShowNextGo(true)
			end
		end
	end,
	Play411051042 = function(arg_171_0, arg_171_1)
		arg_171_1.time_ = 0
		arg_171_1.frameCnt_ = 0
		arg_171_1.state_ = "playing"
		arg_171_1.curTalkId_ = 411051042
		arg_171_1.duration_ = 13.533

		local var_171_0 = {
			zh = 8.466,
			ja = 13.533
		}
		local var_171_1 = manager.audio:GetLocalizationFlag()

		if var_171_0[var_171_1] ~= nil then
			arg_171_1.duration_ = var_171_0[var_171_1]
		end

		SetActive(arg_171_1.tipsGo_, false)

		function arg_171_1.onSingleLineFinish_()
			arg_171_1.onSingleLineUpdate_ = nil
			arg_171_1.onSingleLineFinish_ = nil
			arg_171_1.state_ = "waiting"
		end

		function arg_171_1.playNext_(arg_173_0)
			if arg_173_0 == 1 then
				arg_171_0:Play411051043(arg_171_1)
			end
		end

		function arg_171_1.onSingleLineUpdate_(arg_174_0)
			local var_174_0 = 0
			local var_174_1 = 1

			if var_174_0 < arg_171_1.time_ and arg_171_1.time_ <= var_174_0 + arg_174_0 then
				arg_171_1.talkMaxDuration = 0
				arg_171_1.dialogCg_.alpha = 1

				arg_171_1.dialog_:SetActive(true)
				SetActive(arg_171_1.leftNameGo_, true)

				local var_174_2 = arg_171_1:FormatText(StoryNameCfg[264].name)

				arg_171_1.leftNameTxt_.text = var_174_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_171_1.leftNameTxt_.transform)

				arg_171_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_171_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_171_1:RecordName(arg_171_1.leftNameTxt_.text)
				SetActive(arg_171_1.iconTrs_.gameObject, false)
				arg_171_1.callingController_:SetSelectedState("normal")

				local var_174_3 = arg_171_1:GetWordFromCfg(411051042)
				local var_174_4 = arg_171_1:FormatText(var_174_3.content)

				arg_171_1.text_.text = var_174_4

				LuaForUtil.ClearLinePrefixSymbol(arg_171_1.text_)

				local var_174_5 = 40
				local var_174_6 = utf8.len(var_174_4)
				local var_174_7 = var_174_5 <= 0 and var_174_1 or var_174_1 * (var_174_6 / var_174_5)

				if var_174_7 > 0 and var_174_1 < var_174_7 then
					arg_171_1.talkMaxDuration = var_174_7

					if var_174_7 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_7 + var_174_0
					end
				end

				arg_171_1.text_.text = var_174_4
				arg_171_1.typewritter.percent = 0

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") ~= 0 then
					local var_174_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051042", "story_v_out_411051.awb") / 1000

					if var_174_8 + var_174_0 > arg_171_1.duration_ then
						arg_171_1.duration_ = var_174_8 + var_174_0
					end

					if var_174_3.prefab_name ~= "" and arg_171_1.actors_[var_174_3.prefab_name] ~= nil then
						local var_174_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_171_1.actors_[var_174_3.prefab_name].transform, "story_v_out_411051", "411051042", "story_v_out_411051.awb")

						arg_171_1:RecordAudio("411051042", var_174_9)
						arg_171_1:RecordAudio("411051042", var_174_9)
					else
						arg_171_1:AudioAction("play", "voice", "story_v_out_411051", "411051042", "story_v_out_411051.awb")
					end

					arg_171_1:RecordHistoryTalkVoice("story_v_out_411051", "411051042", "story_v_out_411051.awb")
				end

				arg_171_1:RecordContent(arg_171_1.text_.text)
			end

			local var_174_10 = math.max(var_174_1, arg_171_1.talkMaxDuration)

			if var_174_0 <= arg_171_1.time_ and arg_171_1.time_ < var_174_0 + var_174_10 then
				arg_171_1.typewritter.percent = (arg_171_1.time_ - var_174_0) / var_174_10

				arg_171_1.typewritter:SetDirty()
			end

			if arg_171_1.time_ >= var_174_0 + var_174_10 and arg_171_1.time_ < var_174_0 + var_174_10 + arg_174_0 then
				arg_171_1.typewritter.percent = 1

				arg_171_1.typewritter:SetDirty()
				arg_171_1:ShowNextGo(true)
			end
		end
	end,
	Play411051043 = function(arg_175_0, arg_175_1)
		arg_175_1.time_ = 0
		arg_175_1.frameCnt_ = 0
		arg_175_1.state_ = "playing"
		arg_175_1.curTalkId_ = 411051043
		arg_175_1.duration_ = 3.733

		local var_175_0 = {
			zh = 3.666,
			ja = 3.733
		}
		local var_175_1 = manager.audio:GetLocalizationFlag()

		if var_175_0[var_175_1] ~= nil then
			arg_175_1.duration_ = var_175_0[var_175_1]
		end

		SetActive(arg_175_1.tipsGo_, false)

		function arg_175_1.onSingleLineFinish_()
			arg_175_1.onSingleLineUpdate_ = nil
			arg_175_1.onSingleLineFinish_ = nil
			arg_175_1.state_ = "waiting"
		end

		function arg_175_1.playNext_(arg_177_0)
			if arg_177_0 == 1 then
				arg_175_0:Play411051044(arg_175_1)
			end
		end

		function arg_175_1.onSingleLineUpdate_(arg_178_0)
			local var_178_0 = 0
			local var_178_1 = 0.425

			if var_178_0 < arg_175_1.time_ and arg_175_1.time_ <= var_178_0 + arg_178_0 then
				arg_175_1.talkMaxDuration = 0
				arg_175_1.dialogCg_.alpha = 1

				arg_175_1.dialog_:SetActive(true)
				SetActive(arg_175_1.leftNameGo_, true)

				local var_178_2 = arg_175_1:FormatText(StoryNameCfg[264].name)

				arg_175_1.leftNameTxt_.text = var_178_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_175_1.leftNameTxt_.transform)

				arg_175_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_175_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_175_1:RecordName(arg_175_1.leftNameTxt_.text)
				SetActive(arg_175_1.iconTrs_.gameObject, false)
				arg_175_1.callingController_:SetSelectedState("normal")

				local var_178_3 = arg_175_1:GetWordFromCfg(411051043)
				local var_178_4 = arg_175_1:FormatText(var_178_3.content)

				arg_175_1.text_.text = var_178_4

				LuaForUtil.ClearLinePrefixSymbol(arg_175_1.text_)

				local var_178_5 = 17
				local var_178_6 = utf8.len(var_178_4)
				local var_178_7 = var_178_5 <= 0 and var_178_1 or var_178_1 * (var_178_6 / var_178_5)

				if var_178_7 > 0 and var_178_1 < var_178_7 then
					arg_175_1.talkMaxDuration = var_178_7

					if var_178_7 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_7 + var_178_0
					end
				end

				arg_175_1.text_.text = var_178_4
				arg_175_1.typewritter.percent = 0

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") ~= 0 then
					local var_178_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051043", "story_v_out_411051.awb") / 1000

					if var_178_8 + var_178_0 > arg_175_1.duration_ then
						arg_175_1.duration_ = var_178_8 + var_178_0
					end

					if var_178_3.prefab_name ~= "" and arg_175_1.actors_[var_178_3.prefab_name] ~= nil then
						local var_178_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_175_1.actors_[var_178_3.prefab_name].transform, "story_v_out_411051", "411051043", "story_v_out_411051.awb")

						arg_175_1:RecordAudio("411051043", var_178_9)
						arg_175_1:RecordAudio("411051043", var_178_9)
					else
						arg_175_1:AudioAction("play", "voice", "story_v_out_411051", "411051043", "story_v_out_411051.awb")
					end

					arg_175_1:RecordHistoryTalkVoice("story_v_out_411051", "411051043", "story_v_out_411051.awb")
				end

				arg_175_1:RecordContent(arg_175_1.text_.text)
			end

			local var_178_10 = math.max(var_178_1, arg_175_1.talkMaxDuration)

			if var_178_0 <= arg_175_1.time_ and arg_175_1.time_ < var_178_0 + var_178_10 then
				arg_175_1.typewritter.percent = (arg_175_1.time_ - var_178_0) / var_178_10

				arg_175_1.typewritter:SetDirty()
			end

			if arg_175_1.time_ >= var_178_0 + var_178_10 and arg_175_1.time_ < var_178_0 + var_178_10 + arg_178_0 then
				arg_175_1.typewritter.percent = 1

				arg_175_1.typewritter:SetDirty()
				arg_175_1:ShowNextGo(true)
			end
		end
	end,
	Play411051044 = function(arg_179_0, arg_179_1)
		arg_179_1.time_ = 0
		arg_179_1.frameCnt_ = 0
		arg_179_1.state_ = "playing"
		arg_179_1.curTalkId_ = 411051044
		arg_179_1.duration_ = 1.333

		local var_179_0 = {
			zh = 1.333,
			ja = 1.2
		}
		local var_179_1 = manager.audio:GetLocalizationFlag()

		if var_179_0[var_179_1] ~= nil then
			arg_179_1.duration_ = var_179_0[var_179_1]
		end

		SetActive(arg_179_1.tipsGo_, false)

		function arg_179_1.onSingleLineFinish_()
			arg_179_1.onSingleLineUpdate_ = nil
			arg_179_1.onSingleLineFinish_ = nil
			arg_179_1.state_ = "waiting"
		end

		function arg_179_1.playNext_(arg_181_0)
			if arg_181_0 == 1 then
				arg_179_0:Play411051045(arg_179_1)
			end
		end

		function arg_179_1.onSingleLineUpdate_(arg_182_0)
			local var_182_0 = arg_179_1.actors_["10014ui_story"]
			local var_182_1 = 0

			if var_182_1 < arg_179_1.time_ and arg_179_1.time_ <= var_182_1 + arg_182_0 and arg_179_1.var_.characterEffect10014ui_story == nil then
				arg_179_1.var_.characterEffect10014ui_story = var_182_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_2 = 0.200000002980232

			if var_182_1 <= arg_179_1.time_ and arg_179_1.time_ < var_182_1 + var_182_2 then
				local var_182_3 = (arg_179_1.time_ - var_182_1) / var_182_2

				if arg_179_1.var_.characterEffect10014ui_story then
					local var_182_4 = Mathf.Lerp(0, 0.5, var_182_3)

					arg_179_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_179_1.var_.characterEffect10014ui_story.fillRatio = var_182_4
				end
			end

			if arg_179_1.time_ >= var_182_1 + var_182_2 and arg_179_1.time_ < var_182_1 + var_182_2 + arg_182_0 and arg_179_1.var_.characterEffect10014ui_story then
				local var_182_5 = 0.5

				arg_179_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_179_1.var_.characterEffect10014ui_story.fillRatio = var_182_5
			end

			local var_182_6 = arg_179_1.actors_["10058ui_story"]
			local var_182_7 = 0

			if var_182_7 < arg_179_1.time_ and arg_179_1.time_ <= var_182_7 + arg_182_0 and arg_179_1.var_.characterEffect10058ui_story == nil then
				arg_179_1.var_.characterEffect10058ui_story = var_182_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_182_8 = 0.200000002980232

			if var_182_7 <= arg_179_1.time_ and arg_179_1.time_ < var_182_7 + var_182_8 then
				local var_182_9 = (arg_179_1.time_ - var_182_7) / var_182_8

				if arg_179_1.var_.characterEffect10058ui_story then
					arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_179_1.time_ >= var_182_7 + var_182_8 and arg_179_1.time_ < var_182_7 + var_182_8 + arg_182_0 and arg_179_1.var_.characterEffect10058ui_story then
				arg_179_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_182_10 = 0
			local var_182_11 = 0.125

			if var_182_10 < arg_179_1.time_ and arg_179_1.time_ <= var_182_10 + arg_182_0 then
				arg_179_1.talkMaxDuration = 0
				arg_179_1.dialogCg_.alpha = 1

				arg_179_1.dialog_:SetActive(true)
				SetActive(arg_179_1.leftNameGo_, true)

				local var_182_12 = arg_179_1:FormatText(StoryNameCfg[471].name)

				arg_179_1.leftNameTxt_.text = var_182_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_179_1.leftNameTxt_.transform)

				arg_179_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_179_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_179_1:RecordName(arg_179_1.leftNameTxt_.text)
				SetActive(arg_179_1.iconTrs_.gameObject, false)
				arg_179_1.callingController_:SetSelectedState("normal")

				local var_182_13 = arg_179_1:GetWordFromCfg(411051044)
				local var_182_14 = arg_179_1:FormatText(var_182_13.content)

				arg_179_1.text_.text = var_182_14

				LuaForUtil.ClearLinePrefixSymbol(arg_179_1.text_)

				local var_182_15 = 5
				local var_182_16 = utf8.len(var_182_14)
				local var_182_17 = var_182_15 <= 0 and var_182_11 or var_182_11 * (var_182_16 / var_182_15)

				if var_182_17 > 0 and var_182_11 < var_182_17 then
					arg_179_1.talkMaxDuration = var_182_17

					if var_182_17 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_17 + var_182_10
					end
				end

				arg_179_1.text_.text = var_182_14
				arg_179_1.typewritter.percent = 0

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") ~= 0 then
					local var_182_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051044", "story_v_out_411051.awb") / 1000

					if var_182_18 + var_182_10 > arg_179_1.duration_ then
						arg_179_1.duration_ = var_182_18 + var_182_10
					end

					if var_182_13.prefab_name ~= "" and arg_179_1.actors_[var_182_13.prefab_name] ~= nil then
						local var_182_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_179_1.actors_[var_182_13.prefab_name].transform, "story_v_out_411051", "411051044", "story_v_out_411051.awb")

						arg_179_1:RecordAudio("411051044", var_182_19)
						arg_179_1:RecordAudio("411051044", var_182_19)
					else
						arg_179_1:AudioAction("play", "voice", "story_v_out_411051", "411051044", "story_v_out_411051.awb")
					end

					arg_179_1:RecordHistoryTalkVoice("story_v_out_411051", "411051044", "story_v_out_411051.awb")
				end

				arg_179_1:RecordContent(arg_179_1.text_.text)
			end

			local var_182_20 = math.max(var_182_11, arg_179_1.talkMaxDuration)

			if var_182_10 <= arg_179_1.time_ and arg_179_1.time_ < var_182_10 + var_182_20 then
				arg_179_1.typewritter.percent = (arg_179_1.time_ - var_182_10) / var_182_20

				arg_179_1.typewritter:SetDirty()
			end

			if arg_179_1.time_ >= var_182_10 + var_182_20 and arg_179_1.time_ < var_182_10 + var_182_20 + arg_182_0 then
				arg_179_1.typewritter.percent = 1

				arg_179_1.typewritter:SetDirty()
				arg_179_1:ShowNextGo(true)
			end
		end
	end,
	Play411051045 = function(arg_183_0, arg_183_1)
		arg_183_1.time_ = 0
		arg_183_1.frameCnt_ = 0
		arg_183_1.state_ = "playing"
		arg_183_1.curTalkId_ = 411051045
		arg_183_1.duration_ = 9.7

		local var_183_0 = {
			zh = 7,
			ja = 9.7
		}
		local var_183_1 = manager.audio:GetLocalizationFlag()

		if var_183_0[var_183_1] ~= nil then
			arg_183_1.duration_ = var_183_0[var_183_1]
		end

		SetActive(arg_183_1.tipsGo_, false)

		function arg_183_1.onSingleLineFinish_()
			arg_183_1.onSingleLineUpdate_ = nil
			arg_183_1.onSingleLineFinish_ = nil
			arg_183_1.state_ = "waiting"
		end

		function arg_183_1.playNext_(arg_185_0)
			if arg_185_0 == 1 then
				arg_183_0:Play411051046(arg_183_1)
			end
		end

		function arg_183_1.onSingleLineUpdate_(arg_186_0)
			local var_186_0 = arg_183_1.actors_["10014ui_story"].transform
			local var_186_1 = 0

			if var_186_1 < arg_183_1.time_ and arg_183_1.time_ <= var_186_1 + arg_186_0 then
				arg_183_1.var_.moveOldPos10014ui_story = var_186_0.localPosition
			end

			local var_186_2 = 0.001

			if var_186_1 <= arg_183_1.time_ and arg_183_1.time_ < var_186_1 + var_186_2 then
				local var_186_3 = (arg_183_1.time_ - var_186_1) / var_186_2
				local var_186_4 = Vector3.New(0.7, -1.06, -6.2)

				var_186_0.localPosition = Vector3.Lerp(arg_183_1.var_.moveOldPos10014ui_story, var_186_4, var_186_3)

				local var_186_5 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_5.x, var_186_5.y, var_186_5.z)

				local var_186_6 = var_186_0.localEulerAngles

				var_186_6.z = 0
				var_186_6.x = 0
				var_186_0.localEulerAngles = var_186_6
			end

			if arg_183_1.time_ >= var_186_1 + var_186_2 and arg_183_1.time_ < var_186_1 + var_186_2 + arg_186_0 then
				var_186_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_186_7 = manager.ui.mainCamera.transform.position - var_186_0.position

				var_186_0.forward = Vector3.New(var_186_7.x, var_186_7.y, var_186_7.z)

				local var_186_8 = var_186_0.localEulerAngles

				var_186_8.z = 0
				var_186_8.x = 0
				var_186_0.localEulerAngles = var_186_8
			end

			local var_186_9 = arg_183_1.actors_["10014ui_story"]
			local var_186_10 = 0

			if var_186_10 < arg_183_1.time_ and arg_183_1.time_ <= var_186_10 + arg_186_0 and arg_183_1.var_.characterEffect10014ui_story == nil then
				arg_183_1.var_.characterEffect10014ui_story = var_186_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_11 = 0.200000002980232

			if var_186_10 <= arg_183_1.time_ and arg_183_1.time_ < var_186_10 + var_186_11 then
				local var_186_12 = (arg_183_1.time_ - var_186_10) / var_186_11

				if arg_183_1.var_.characterEffect10014ui_story then
					arg_183_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_183_1.time_ >= var_186_10 + var_186_11 and arg_183_1.time_ < var_186_10 + var_186_11 + arg_186_0 and arg_183_1.var_.characterEffect10014ui_story then
				arg_183_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_186_13 = 0

			if var_186_13 < arg_183_1.time_ and arg_183_1.time_ <= var_186_13 + arg_186_0 then
				arg_183_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action3_2")
			end

			local var_186_14 = 0

			if var_186_14 < arg_183_1.time_ and arg_183_1.time_ <= var_186_14 + arg_186_0 then
				arg_183_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_186_15 = arg_183_1.actors_["10058ui_story"]
			local var_186_16 = 0

			if var_186_16 < arg_183_1.time_ and arg_183_1.time_ <= var_186_16 + arg_186_0 and arg_183_1.var_.characterEffect10058ui_story == nil then
				arg_183_1.var_.characterEffect10058ui_story = var_186_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_186_17 = 0.200000002980232

			if var_186_16 <= arg_183_1.time_ and arg_183_1.time_ < var_186_16 + var_186_17 then
				local var_186_18 = (arg_183_1.time_ - var_186_16) / var_186_17

				if arg_183_1.var_.characterEffect10058ui_story then
					local var_186_19 = Mathf.Lerp(0, 0.5, var_186_18)

					arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_183_1.var_.characterEffect10058ui_story.fillRatio = var_186_19
				end
			end

			if arg_183_1.time_ >= var_186_16 + var_186_17 and arg_183_1.time_ < var_186_16 + var_186_17 + arg_186_0 and arg_183_1.var_.characterEffect10058ui_story then
				local var_186_20 = 0.5

				arg_183_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_183_1.var_.characterEffect10058ui_story.fillRatio = var_186_20
			end

			local var_186_21 = 0
			local var_186_22 = 0.925

			if var_186_21 < arg_183_1.time_ and arg_183_1.time_ <= var_186_21 + arg_186_0 then
				arg_183_1.talkMaxDuration = 0
				arg_183_1.dialogCg_.alpha = 1

				arg_183_1.dialog_:SetActive(true)
				SetActive(arg_183_1.leftNameGo_, true)

				local var_186_23 = arg_183_1:FormatText(StoryNameCfg[264].name)

				arg_183_1.leftNameTxt_.text = var_186_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_183_1.leftNameTxt_.transform)

				arg_183_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_183_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_183_1:RecordName(arg_183_1.leftNameTxt_.text)
				SetActive(arg_183_1.iconTrs_.gameObject, false)
				arg_183_1.callingController_:SetSelectedState("normal")

				local var_186_24 = arg_183_1:GetWordFromCfg(411051045)
				local var_186_25 = arg_183_1:FormatText(var_186_24.content)

				arg_183_1.text_.text = var_186_25

				LuaForUtil.ClearLinePrefixSymbol(arg_183_1.text_)

				local var_186_26 = 37
				local var_186_27 = utf8.len(var_186_25)
				local var_186_28 = var_186_26 <= 0 and var_186_22 or var_186_22 * (var_186_27 / var_186_26)

				if var_186_28 > 0 and var_186_22 < var_186_28 then
					arg_183_1.talkMaxDuration = var_186_28

					if var_186_28 + var_186_21 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_28 + var_186_21
					end
				end

				arg_183_1.text_.text = var_186_25
				arg_183_1.typewritter.percent = 0

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") ~= 0 then
					local var_186_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051045", "story_v_out_411051.awb") / 1000

					if var_186_29 + var_186_21 > arg_183_1.duration_ then
						arg_183_1.duration_ = var_186_29 + var_186_21
					end

					if var_186_24.prefab_name ~= "" and arg_183_1.actors_[var_186_24.prefab_name] ~= nil then
						local var_186_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_183_1.actors_[var_186_24.prefab_name].transform, "story_v_out_411051", "411051045", "story_v_out_411051.awb")

						arg_183_1:RecordAudio("411051045", var_186_30)
						arg_183_1:RecordAudio("411051045", var_186_30)
					else
						arg_183_1:AudioAction("play", "voice", "story_v_out_411051", "411051045", "story_v_out_411051.awb")
					end

					arg_183_1:RecordHistoryTalkVoice("story_v_out_411051", "411051045", "story_v_out_411051.awb")
				end

				arg_183_1:RecordContent(arg_183_1.text_.text)
			end

			local var_186_31 = math.max(var_186_22, arg_183_1.talkMaxDuration)

			if var_186_21 <= arg_183_1.time_ and arg_183_1.time_ < var_186_21 + var_186_31 then
				arg_183_1.typewritter.percent = (arg_183_1.time_ - var_186_21) / var_186_31

				arg_183_1.typewritter:SetDirty()
			end

			if arg_183_1.time_ >= var_186_21 + var_186_31 and arg_183_1.time_ < var_186_21 + var_186_31 + arg_186_0 then
				arg_183_1.typewritter.percent = 1

				arg_183_1.typewritter:SetDirty()
				arg_183_1:ShowNextGo(true)
			end
		end
	end,
	Play411051046 = function(arg_187_0, arg_187_1)
		arg_187_1.time_ = 0
		arg_187_1.frameCnt_ = 0
		arg_187_1.state_ = "playing"
		arg_187_1.curTalkId_ = 411051046
		arg_187_1.duration_ = 3.5

		local var_187_0 = {
			zh = 2.5,
			ja = 3.5
		}
		local var_187_1 = manager.audio:GetLocalizationFlag()

		if var_187_0[var_187_1] ~= nil then
			arg_187_1.duration_ = var_187_0[var_187_1]
		end

		SetActive(arg_187_1.tipsGo_, false)

		function arg_187_1.onSingleLineFinish_()
			arg_187_1.onSingleLineUpdate_ = nil
			arg_187_1.onSingleLineFinish_ = nil
			arg_187_1.state_ = "waiting"
		end

		function arg_187_1.playNext_(arg_189_0)
			if arg_189_0 == 1 then
				arg_187_0:Play411051047(arg_187_1)
			end
		end

		function arg_187_1.onSingleLineUpdate_(arg_190_0)
			local var_190_0 = arg_187_1.actors_["10058ui_story"].transform
			local var_190_1 = 0

			if var_190_1 < arg_187_1.time_ and arg_187_1.time_ <= var_190_1 + arg_190_0 then
				arg_187_1.var_.moveOldPos10058ui_story = var_190_0.localPosition
			end

			local var_190_2 = 0.001

			if var_190_1 <= arg_187_1.time_ and arg_187_1.time_ < var_190_1 + var_190_2 then
				local var_190_3 = (arg_187_1.time_ - var_190_1) / var_190_2
				local var_190_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_190_0.localPosition = Vector3.Lerp(arg_187_1.var_.moveOldPos10058ui_story, var_190_4, var_190_3)

				local var_190_5 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_5.x, var_190_5.y, var_190_5.z)

				local var_190_6 = var_190_0.localEulerAngles

				var_190_6.z = 0
				var_190_6.x = 0
				var_190_0.localEulerAngles = var_190_6
			end

			if arg_187_1.time_ >= var_190_1 + var_190_2 and arg_187_1.time_ < var_190_1 + var_190_2 + arg_190_0 then
				var_190_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_190_7 = manager.ui.mainCamera.transform.position - var_190_0.position

				var_190_0.forward = Vector3.New(var_190_7.x, var_190_7.y, var_190_7.z)

				local var_190_8 = var_190_0.localEulerAngles

				var_190_8.z = 0
				var_190_8.x = 0
				var_190_0.localEulerAngles = var_190_8
			end

			local var_190_9 = arg_187_1.actors_["10058ui_story"]
			local var_190_10 = 0

			if var_190_10 < arg_187_1.time_ and arg_187_1.time_ <= var_190_10 + arg_190_0 and arg_187_1.var_.characterEffect10058ui_story == nil then
				arg_187_1.var_.characterEffect10058ui_story = var_190_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_11 = 0.200000002980232

			if var_190_10 <= arg_187_1.time_ and arg_187_1.time_ < var_190_10 + var_190_11 then
				local var_190_12 = (arg_187_1.time_ - var_190_10) / var_190_11

				if arg_187_1.var_.characterEffect10058ui_story then
					arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_187_1.time_ >= var_190_10 + var_190_11 and arg_187_1.time_ < var_190_10 + var_190_11 + arg_190_0 and arg_187_1.var_.characterEffect10058ui_story then
				arg_187_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_190_13 = 0

			if var_190_13 < arg_187_1.time_ and arg_187_1.time_ <= var_190_13 + arg_190_0 then
				arg_187_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action423")
			end

			local var_190_14 = 0

			if var_190_14 < arg_187_1.time_ and arg_187_1.time_ <= var_190_14 + arg_190_0 then
				arg_187_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_190_15 = arg_187_1.actors_["10014ui_story"]
			local var_190_16 = 0

			if var_190_16 < arg_187_1.time_ and arg_187_1.time_ <= var_190_16 + arg_190_0 and arg_187_1.var_.characterEffect10014ui_story == nil then
				arg_187_1.var_.characterEffect10014ui_story = var_190_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_190_17 = 0.200000002980232

			if var_190_16 <= arg_187_1.time_ and arg_187_1.time_ < var_190_16 + var_190_17 then
				local var_190_18 = (arg_187_1.time_ - var_190_16) / var_190_17

				if arg_187_1.var_.characterEffect10014ui_story then
					local var_190_19 = Mathf.Lerp(0, 0.5, var_190_18)

					arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_187_1.var_.characterEffect10014ui_story.fillRatio = var_190_19
				end
			end

			if arg_187_1.time_ >= var_190_16 + var_190_17 and arg_187_1.time_ < var_190_16 + var_190_17 + arg_190_0 and arg_187_1.var_.characterEffect10014ui_story then
				local var_190_20 = 0.5

				arg_187_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_187_1.var_.characterEffect10014ui_story.fillRatio = var_190_20
			end

			local var_190_21 = 0
			local var_190_22 = 0.325

			if var_190_21 < arg_187_1.time_ and arg_187_1.time_ <= var_190_21 + arg_190_0 then
				arg_187_1.talkMaxDuration = 0
				arg_187_1.dialogCg_.alpha = 1

				arg_187_1.dialog_:SetActive(true)
				SetActive(arg_187_1.leftNameGo_, true)

				local var_190_23 = arg_187_1:FormatText(StoryNameCfg[471].name)

				arg_187_1.leftNameTxt_.text = var_190_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_187_1.leftNameTxt_.transform)

				arg_187_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_187_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_187_1:RecordName(arg_187_1.leftNameTxt_.text)
				SetActive(arg_187_1.iconTrs_.gameObject, false)
				arg_187_1.callingController_:SetSelectedState("normal")

				local var_190_24 = arg_187_1:GetWordFromCfg(411051046)
				local var_190_25 = arg_187_1:FormatText(var_190_24.content)

				arg_187_1.text_.text = var_190_25

				LuaForUtil.ClearLinePrefixSymbol(arg_187_1.text_)

				local var_190_26 = 13
				local var_190_27 = utf8.len(var_190_25)
				local var_190_28 = var_190_26 <= 0 and var_190_22 or var_190_22 * (var_190_27 / var_190_26)

				if var_190_28 > 0 and var_190_22 < var_190_28 then
					arg_187_1.talkMaxDuration = var_190_28

					if var_190_28 + var_190_21 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_28 + var_190_21
					end
				end

				arg_187_1.text_.text = var_190_25
				arg_187_1.typewritter.percent = 0

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") ~= 0 then
					local var_190_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051046", "story_v_out_411051.awb") / 1000

					if var_190_29 + var_190_21 > arg_187_1.duration_ then
						arg_187_1.duration_ = var_190_29 + var_190_21
					end

					if var_190_24.prefab_name ~= "" and arg_187_1.actors_[var_190_24.prefab_name] ~= nil then
						local var_190_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_187_1.actors_[var_190_24.prefab_name].transform, "story_v_out_411051", "411051046", "story_v_out_411051.awb")

						arg_187_1:RecordAudio("411051046", var_190_30)
						arg_187_1:RecordAudio("411051046", var_190_30)
					else
						arg_187_1:AudioAction("play", "voice", "story_v_out_411051", "411051046", "story_v_out_411051.awb")
					end

					arg_187_1:RecordHistoryTalkVoice("story_v_out_411051", "411051046", "story_v_out_411051.awb")
				end

				arg_187_1:RecordContent(arg_187_1.text_.text)
			end

			local var_190_31 = math.max(var_190_22, arg_187_1.talkMaxDuration)

			if var_190_21 <= arg_187_1.time_ and arg_187_1.time_ < var_190_21 + var_190_31 then
				arg_187_1.typewritter.percent = (arg_187_1.time_ - var_190_21) / var_190_31

				arg_187_1.typewritter:SetDirty()
			end

			if arg_187_1.time_ >= var_190_21 + var_190_31 and arg_187_1.time_ < var_190_21 + var_190_31 + arg_190_0 then
				arg_187_1.typewritter.percent = 1

				arg_187_1.typewritter:SetDirty()
				arg_187_1:ShowNextGo(true)
			end
		end
	end,
	Play411051047 = function(arg_191_0, arg_191_1)
		arg_191_1.time_ = 0
		arg_191_1.frameCnt_ = 0
		arg_191_1.state_ = "playing"
		arg_191_1.curTalkId_ = 411051047
		arg_191_1.duration_ = 4

		local var_191_0 = {
			zh = 3.9,
			ja = 4
		}
		local var_191_1 = manager.audio:GetLocalizationFlag()

		if var_191_0[var_191_1] ~= nil then
			arg_191_1.duration_ = var_191_0[var_191_1]
		end

		SetActive(arg_191_1.tipsGo_, false)

		function arg_191_1.onSingleLineFinish_()
			arg_191_1.onSingleLineUpdate_ = nil
			arg_191_1.onSingleLineFinish_ = nil
			arg_191_1.state_ = "waiting"
		end

		function arg_191_1.playNext_(arg_193_0)
			if arg_193_0 == 1 then
				arg_191_0:Play411051048(arg_191_1)
			end
		end

		function arg_191_1.onSingleLineUpdate_(arg_194_0)
			local var_194_0 = arg_191_1.actors_["10058ui_story"]
			local var_194_1 = 0

			if var_194_1 < arg_191_1.time_ and arg_191_1.time_ <= var_194_1 + arg_194_0 and arg_191_1.var_.characterEffect10058ui_story == nil then
				arg_191_1.var_.characterEffect10058ui_story = var_194_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_2 = 0.200000002980232

			if var_194_1 <= arg_191_1.time_ and arg_191_1.time_ < var_194_1 + var_194_2 then
				local var_194_3 = (arg_191_1.time_ - var_194_1) / var_194_2

				if arg_191_1.var_.characterEffect10058ui_story then
					local var_194_4 = Mathf.Lerp(0, 0.5, var_194_3)

					arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_4
				end
			end

			if arg_191_1.time_ >= var_194_1 + var_194_2 and arg_191_1.time_ < var_194_1 + var_194_2 + arg_194_0 and arg_191_1.var_.characterEffect10058ui_story then
				local var_194_5 = 0.5

				arg_191_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_191_1.var_.characterEffect10058ui_story.fillRatio = var_194_5
			end

			local var_194_6 = arg_191_1.actors_["10014ui_story"]
			local var_194_7 = 0

			if var_194_7 < arg_191_1.time_ and arg_191_1.time_ <= var_194_7 + arg_194_0 and arg_191_1.var_.characterEffect10014ui_story == nil then
				arg_191_1.var_.characterEffect10014ui_story = var_194_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_194_8 = 0.200000002980232

			if var_194_7 <= arg_191_1.time_ and arg_191_1.time_ < var_194_7 + var_194_8 then
				local var_194_9 = (arg_191_1.time_ - var_194_7) / var_194_8

				if arg_191_1.var_.characterEffect10014ui_story then
					arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_191_1.time_ >= var_194_7 + var_194_8 and arg_191_1.time_ < var_194_7 + var_194_8 + arg_194_0 and arg_191_1.var_.characterEffect10014ui_story then
				arg_191_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_194_10 = 0
			local var_194_11 = 0.35

			if var_194_10 < arg_191_1.time_ and arg_191_1.time_ <= var_194_10 + arg_194_0 then
				arg_191_1.talkMaxDuration = 0
				arg_191_1.dialogCg_.alpha = 1

				arg_191_1.dialog_:SetActive(true)
				SetActive(arg_191_1.leftNameGo_, true)

				local var_194_12 = arg_191_1:FormatText(StoryNameCfg[264].name)

				arg_191_1.leftNameTxt_.text = var_194_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_191_1.leftNameTxt_.transform)

				arg_191_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_191_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_191_1:RecordName(arg_191_1.leftNameTxt_.text)
				SetActive(arg_191_1.iconTrs_.gameObject, false)
				arg_191_1.callingController_:SetSelectedState("normal")

				local var_194_13 = arg_191_1:GetWordFromCfg(411051047)
				local var_194_14 = arg_191_1:FormatText(var_194_13.content)

				arg_191_1.text_.text = var_194_14

				LuaForUtil.ClearLinePrefixSymbol(arg_191_1.text_)

				local var_194_15 = 14
				local var_194_16 = utf8.len(var_194_14)
				local var_194_17 = var_194_15 <= 0 and var_194_11 or var_194_11 * (var_194_16 / var_194_15)

				if var_194_17 > 0 and var_194_11 < var_194_17 then
					arg_191_1.talkMaxDuration = var_194_17

					if var_194_17 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_17 + var_194_10
					end
				end

				arg_191_1.text_.text = var_194_14
				arg_191_1.typewritter.percent = 0

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") ~= 0 then
					local var_194_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051047", "story_v_out_411051.awb") / 1000

					if var_194_18 + var_194_10 > arg_191_1.duration_ then
						arg_191_1.duration_ = var_194_18 + var_194_10
					end

					if var_194_13.prefab_name ~= "" and arg_191_1.actors_[var_194_13.prefab_name] ~= nil then
						local var_194_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_191_1.actors_[var_194_13.prefab_name].transform, "story_v_out_411051", "411051047", "story_v_out_411051.awb")

						arg_191_1:RecordAudio("411051047", var_194_19)
						arg_191_1:RecordAudio("411051047", var_194_19)
					else
						arg_191_1:AudioAction("play", "voice", "story_v_out_411051", "411051047", "story_v_out_411051.awb")
					end

					arg_191_1:RecordHistoryTalkVoice("story_v_out_411051", "411051047", "story_v_out_411051.awb")
				end

				arg_191_1:RecordContent(arg_191_1.text_.text)
			end

			local var_194_20 = math.max(var_194_11, arg_191_1.talkMaxDuration)

			if var_194_10 <= arg_191_1.time_ and arg_191_1.time_ < var_194_10 + var_194_20 then
				arg_191_1.typewritter.percent = (arg_191_1.time_ - var_194_10) / var_194_20

				arg_191_1.typewritter:SetDirty()
			end

			if arg_191_1.time_ >= var_194_10 + var_194_20 and arg_191_1.time_ < var_194_10 + var_194_20 + arg_194_0 then
				arg_191_1.typewritter.percent = 1

				arg_191_1.typewritter:SetDirty()
				arg_191_1:ShowNextGo(true)
			end
		end
	end,
	Play411051048 = function(arg_195_0, arg_195_1)
		arg_195_1.time_ = 0
		arg_195_1.frameCnt_ = 0
		arg_195_1.state_ = "playing"
		arg_195_1.curTalkId_ = 411051048
		arg_195_1.duration_ = 8.8

		local var_195_0 = {
			zh = 6.9,
			ja = 8.8
		}
		local var_195_1 = manager.audio:GetLocalizationFlag()

		if var_195_0[var_195_1] ~= nil then
			arg_195_1.duration_ = var_195_0[var_195_1]
		end

		SetActive(arg_195_1.tipsGo_, false)

		function arg_195_1.onSingleLineFinish_()
			arg_195_1.onSingleLineUpdate_ = nil
			arg_195_1.onSingleLineFinish_ = nil
			arg_195_1.state_ = "waiting"
		end

		function arg_195_1.playNext_(arg_197_0)
			if arg_197_0 == 1 then
				arg_195_0:Play411051049(arg_195_1)
			end
		end

		function arg_195_1.onSingleLineUpdate_(arg_198_0)
			local var_198_0 = arg_195_1.actors_["10058ui_story"]
			local var_198_1 = 0

			if var_198_1 < arg_195_1.time_ and arg_195_1.time_ <= var_198_1 + arg_198_0 and arg_195_1.var_.characterEffect10058ui_story == nil then
				arg_195_1.var_.characterEffect10058ui_story = var_198_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_2 = 0.200000002980232

			if var_198_1 <= arg_195_1.time_ and arg_195_1.time_ < var_198_1 + var_198_2 then
				local var_198_3 = (arg_195_1.time_ - var_198_1) / var_198_2

				if arg_195_1.var_.characterEffect10058ui_story then
					arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_195_1.time_ >= var_198_1 + var_198_2 and arg_195_1.time_ < var_198_1 + var_198_2 + arg_198_0 and arg_195_1.var_.characterEffect10058ui_story then
				arg_195_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_198_4 = arg_195_1.actors_["10014ui_story"]
			local var_198_5 = 0

			if var_198_5 < arg_195_1.time_ and arg_195_1.time_ <= var_198_5 + arg_198_0 and arg_195_1.var_.characterEffect10014ui_story == nil then
				arg_195_1.var_.characterEffect10014ui_story = var_198_4:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_198_6 = 0.200000002980232

			if var_198_5 <= arg_195_1.time_ and arg_195_1.time_ < var_198_5 + var_198_6 then
				local var_198_7 = (arg_195_1.time_ - var_198_5) / var_198_6

				if arg_195_1.var_.characterEffect10014ui_story then
					local var_198_8 = Mathf.Lerp(0, 0.5, var_198_7)

					arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_195_1.var_.characterEffect10014ui_story.fillRatio = var_198_8
				end
			end

			if arg_195_1.time_ >= var_198_5 + var_198_6 and arg_195_1.time_ < var_198_5 + var_198_6 + arg_198_0 and arg_195_1.var_.characterEffect10014ui_story then
				local var_198_9 = 0.5

				arg_195_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_195_1.var_.characterEffect10014ui_story.fillRatio = var_198_9
			end

			local var_198_10 = 0
			local var_198_11 = 0.8

			if var_198_10 < arg_195_1.time_ and arg_195_1.time_ <= var_198_10 + arg_198_0 then
				arg_195_1.talkMaxDuration = 0
				arg_195_1.dialogCg_.alpha = 1

				arg_195_1.dialog_:SetActive(true)
				SetActive(arg_195_1.leftNameGo_, true)

				local var_198_12 = arg_195_1:FormatText(StoryNameCfg[471].name)

				arg_195_1.leftNameTxt_.text = var_198_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_195_1.leftNameTxt_.transform)

				arg_195_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_195_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_195_1:RecordName(arg_195_1.leftNameTxt_.text)
				SetActive(arg_195_1.iconTrs_.gameObject, false)
				arg_195_1.callingController_:SetSelectedState("normal")

				local var_198_13 = arg_195_1:GetWordFromCfg(411051048)
				local var_198_14 = arg_195_1:FormatText(var_198_13.content)

				arg_195_1.text_.text = var_198_14

				LuaForUtil.ClearLinePrefixSymbol(arg_195_1.text_)

				local var_198_15 = 32
				local var_198_16 = utf8.len(var_198_14)
				local var_198_17 = var_198_15 <= 0 and var_198_11 or var_198_11 * (var_198_16 / var_198_15)

				if var_198_17 > 0 and var_198_11 < var_198_17 then
					arg_195_1.talkMaxDuration = var_198_17

					if var_198_17 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_17 + var_198_10
					end
				end

				arg_195_1.text_.text = var_198_14
				arg_195_1.typewritter.percent = 0

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") ~= 0 then
					local var_198_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051048", "story_v_out_411051.awb") / 1000

					if var_198_18 + var_198_10 > arg_195_1.duration_ then
						arg_195_1.duration_ = var_198_18 + var_198_10
					end

					if var_198_13.prefab_name ~= "" and arg_195_1.actors_[var_198_13.prefab_name] ~= nil then
						local var_198_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_195_1.actors_[var_198_13.prefab_name].transform, "story_v_out_411051", "411051048", "story_v_out_411051.awb")

						arg_195_1:RecordAudio("411051048", var_198_19)
						arg_195_1:RecordAudio("411051048", var_198_19)
					else
						arg_195_1:AudioAction("play", "voice", "story_v_out_411051", "411051048", "story_v_out_411051.awb")
					end

					arg_195_1:RecordHistoryTalkVoice("story_v_out_411051", "411051048", "story_v_out_411051.awb")
				end

				arg_195_1:RecordContent(arg_195_1.text_.text)
			end

			local var_198_20 = math.max(var_198_11, arg_195_1.talkMaxDuration)

			if var_198_10 <= arg_195_1.time_ and arg_195_1.time_ < var_198_10 + var_198_20 then
				arg_195_1.typewritter.percent = (arg_195_1.time_ - var_198_10) / var_198_20

				arg_195_1.typewritter:SetDirty()
			end

			if arg_195_1.time_ >= var_198_10 + var_198_20 and arg_195_1.time_ < var_198_10 + var_198_20 + arg_198_0 then
				arg_195_1.typewritter.percent = 1

				arg_195_1.typewritter:SetDirty()
				arg_195_1:ShowNextGo(true)
			end
		end
	end,
	Play411051049 = function(arg_199_0, arg_199_1)
		arg_199_1.time_ = 0
		arg_199_1.frameCnt_ = 0
		arg_199_1.state_ = "playing"
		arg_199_1.curTalkId_ = 411051049
		arg_199_1.duration_ = 14.566

		local var_199_0 = {
			zh = 8.2,
			ja = 14.566
		}
		local var_199_1 = manager.audio:GetLocalizationFlag()

		if var_199_0[var_199_1] ~= nil then
			arg_199_1.duration_ = var_199_0[var_199_1]
		end

		SetActive(arg_199_1.tipsGo_, false)

		function arg_199_1.onSingleLineFinish_()
			arg_199_1.onSingleLineUpdate_ = nil
			arg_199_1.onSingleLineFinish_ = nil
			arg_199_1.state_ = "waiting"
		end

		function arg_199_1.playNext_(arg_201_0)
			if arg_201_0 == 1 then
				arg_199_0:Play411051050(arg_199_1)
			end
		end

		function arg_199_1.onSingleLineUpdate_(arg_202_0)
			local var_202_0 = arg_199_1.actors_["10058ui_story"]
			local var_202_1 = 0

			if var_202_1 < arg_199_1.time_ and arg_199_1.time_ <= var_202_1 + arg_202_0 and arg_199_1.var_.characterEffect10058ui_story == nil then
				arg_199_1.var_.characterEffect10058ui_story = var_202_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_2 = 0.200000002980232

			if var_202_1 <= arg_199_1.time_ and arg_199_1.time_ < var_202_1 + var_202_2 then
				local var_202_3 = (arg_199_1.time_ - var_202_1) / var_202_2

				if arg_199_1.var_.characterEffect10058ui_story then
					local var_202_4 = Mathf.Lerp(0, 0.5, var_202_3)

					arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_4
				end
			end

			if arg_199_1.time_ >= var_202_1 + var_202_2 and arg_199_1.time_ < var_202_1 + var_202_2 + arg_202_0 and arg_199_1.var_.characterEffect10058ui_story then
				local var_202_5 = 0.5

				arg_199_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_199_1.var_.characterEffect10058ui_story.fillRatio = var_202_5
			end

			local var_202_6 = arg_199_1.actors_["10014ui_story"]
			local var_202_7 = 0

			if var_202_7 < arg_199_1.time_ and arg_199_1.time_ <= var_202_7 + arg_202_0 and arg_199_1.var_.characterEffect10014ui_story == nil then
				arg_199_1.var_.characterEffect10014ui_story = var_202_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_202_8 = 0.200000002980232

			if var_202_7 <= arg_199_1.time_ and arg_199_1.time_ < var_202_7 + var_202_8 then
				local var_202_9 = (arg_199_1.time_ - var_202_7) / var_202_8

				if arg_199_1.var_.characterEffect10014ui_story then
					arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_199_1.time_ >= var_202_7 + var_202_8 and arg_199_1.time_ < var_202_7 + var_202_8 + arg_202_0 and arg_199_1.var_.characterEffect10014ui_story then
				arg_199_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_202_10 = 0
			local var_202_11 = 1.05

			if var_202_10 < arg_199_1.time_ and arg_199_1.time_ <= var_202_10 + arg_202_0 then
				arg_199_1.talkMaxDuration = 0
				arg_199_1.dialogCg_.alpha = 1

				arg_199_1.dialog_:SetActive(true)
				SetActive(arg_199_1.leftNameGo_, true)

				local var_202_12 = arg_199_1:FormatText(StoryNameCfg[264].name)

				arg_199_1.leftNameTxt_.text = var_202_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_199_1.leftNameTxt_.transform)

				arg_199_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_199_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_199_1:RecordName(arg_199_1.leftNameTxt_.text)
				SetActive(arg_199_1.iconTrs_.gameObject, false)
				arg_199_1.callingController_:SetSelectedState("normal")

				local var_202_13 = arg_199_1:GetWordFromCfg(411051049)
				local var_202_14 = arg_199_1:FormatText(var_202_13.content)

				arg_199_1.text_.text = var_202_14

				LuaForUtil.ClearLinePrefixSymbol(arg_199_1.text_)

				local var_202_15 = 42
				local var_202_16 = utf8.len(var_202_14)
				local var_202_17 = var_202_15 <= 0 and var_202_11 or var_202_11 * (var_202_16 / var_202_15)

				if var_202_17 > 0 and var_202_11 < var_202_17 then
					arg_199_1.talkMaxDuration = var_202_17

					if var_202_17 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_17 + var_202_10
					end
				end

				arg_199_1.text_.text = var_202_14
				arg_199_1.typewritter.percent = 0

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") ~= 0 then
					local var_202_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051049", "story_v_out_411051.awb") / 1000

					if var_202_18 + var_202_10 > arg_199_1.duration_ then
						arg_199_1.duration_ = var_202_18 + var_202_10
					end

					if var_202_13.prefab_name ~= "" and arg_199_1.actors_[var_202_13.prefab_name] ~= nil then
						local var_202_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_199_1.actors_[var_202_13.prefab_name].transform, "story_v_out_411051", "411051049", "story_v_out_411051.awb")

						arg_199_1:RecordAudio("411051049", var_202_19)
						arg_199_1:RecordAudio("411051049", var_202_19)
					else
						arg_199_1:AudioAction("play", "voice", "story_v_out_411051", "411051049", "story_v_out_411051.awb")
					end

					arg_199_1:RecordHistoryTalkVoice("story_v_out_411051", "411051049", "story_v_out_411051.awb")
				end

				arg_199_1:RecordContent(arg_199_1.text_.text)
			end

			local var_202_20 = math.max(var_202_11, arg_199_1.talkMaxDuration)

			if var_202_10 <= arg_199_1.time_ and arg_199_1.time_ < var_202_10 + var_202_20 then
				arg_199_1.typewritter.percent = (arg_199_1.time_ - var_202_10) / var_202_20

				arg_199_1.typewritter:SetDirty()
			end

			if arg_199_1.time_ >= var_202_10 + var_202_20 and arg_199_1.time_ < var_202_10 + var_202_20 + arg_202_0 then
				arg_199_1.typewritter.percent = 1

				arg_199_1.typewritter:SetDirty()
				arg_199_1:ShowNextGo(true)
			end
		end
	end,
	Play411051050 = function(arg_203_0, arg_203_1)
		arg_203_1.time_ = 0
		arg_203_1.frameCnt_ = 0
		arg_203_1.state_ = "playing"
		arg_203_1.curTalkId_ = 411051050
		arg_203_1.duration_ = 11.133

		local var_203_0 = {
			zh = 9.933,
			ja = 11.133
		}
		local var_203_1 = manager.audio:GetLocalizationFlag()

		if var_203_0[var_203_1] ~= nil then
			arg_203_1.duration_ = var_203_0[var_203_1]
		end

		SetActive(arg_203_1.tipsGo_, false)

		function arg_203_1.onSingleLineFinish_()
			arg_203_1.onSingleLineUpdate_ = nil
			arg_203_1.onSingleLineFinish_ = nil
			arg_203_1.state_ = "waiting"
		end

		function arg_203_1.playNext_(arg_205_0)
			if arg_205_0 == 1 then
				arg_203_0:Play411051051(arg_203_1)
			end
		end

		function arg_203_1.onSingleLineUpdate_(arg_206_0)
			local var_206_0 = 0
			local var_206_1 = 1.175

			if var_206_0 < arg_203_1.time_ and arg_203_1.time_ <= var_206_0 + arg_206_0 then
				arg_203_1.talkMaxDuration = 0
				arg_203_1.dialogCg_.alpha = 1

				arg_203_1.dialog_:SetActive(true)
				SetActive(arg_203_1.leftNameGo_, true)

				local var_206_2 = arg_203_1:FormatText(StoryNameCfg[264].name)

				arg_203_1.leftNameTxt_.text = var_206_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_203_1.leftNameTxt_.transform)

				arg_203_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_203_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_203_1:RecordName(arg_203_1.leftNameTxt_.text)
				SetActive(arg_203_1.iconTrs_.gameObject, false)
				arg_203_1.callingController_:SetSelectedState("normal")

				local var_206_3 = arg_203_1:GetWordFromCfg(411051050)
				local var_206_4 = arg_203_1:FormatText(var_206_3.content)

				arg_203_1.text_.text = var_206_4

				LuaForUtil.ClearLinePrefixSymbol(arg_203_1.text_)

				local var_206_5 = 47
				local var_206_6 = utf8.len(var_206_4)
				local var_206_7 = var_206_5 <= 0 and var_206_1 or var_206_1 * (var_206_6 / var_206_5)

				if var_206_7 > 0 and var_206_1 < var_206_7 then
					arg_203_1.talkMaxDuration = var_206_7

					if var_206_7 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_7 + var_206_0
					end
				end

				arg_203_1.text_.text = var_206_4
				arg_203_1.typewritter.percent = 0

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") ~= 0 then
					local var_206_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051050", "story_v_out_411051.awb") / 1000

					if var_206_8 + var_206_0 > arg_203_1.duration_ then
						arg_203_1.duration_ = var_206_8 + var_206_0
					end

					if var_206_3.prefab_name ~= "" and arg_203_1.actors_[var_206_3.prefab_name] ~= nil then
						local var_206_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_203_1.actors_[var_206_3.prefab_name].transform, "story_v_out_411051", "411051050", "story_v_out_411051.awb")

						arg_203_1:RecordAudio("411051050", var_206_9)
						arg_203_1:RecordAudio("411051050", var_206_9)
					else
						arg_203_1:AudioAction("play", "voice", "story_v_out_411051", "411051050", "story_v_out_411051.awb")
					end

					arg_203_1:RecordHistoryTalkVoice("story_v_out_411051", "411051050", "story_v_out_411051.awb")
				end

				arg_203_1:RecordContent(arg_203_1.text_.text)
			end

			local var_206_10 = math.max(var_206_1, arg_203_1.talkMaxDuration)

			if var_206_0 <= arg_203_1.time_ and arg_203_1.time_ < var_206_0 + var_206_10 then
				arg_203_1.typewritter.percent = (arg_203_1.time_ - var_206_0) / var_206_10

				arg_203_1.typewritter:SetDirty()
			end

			if arg_203_1.time_ >= var_206_0 + var_206_10 and arg_203_1.time_ < var_206_0 + var_206_10 + arg_206_0 then
				arg_203_1.typewritter.percent = 1

				arg_203_1.typewritter:SetDirty()
				arg_203_1:ShowNextGo(true)
			end
		end
	end,
	Play411051051 = function(arg_207_0, arg_207_1)
		arg_207_1.time_ = 0
		arg_207_1.frameCnt_ = 0
		arg_207_1.state_ = "playing"
		arg_207_1.curTalkId_ = 411051051
		arg_207_1.duration_ = 1.533

		local var_207_0 = {
			zh = 0.999999999999,
			ja = 1.533
		}
		local var_207_1 = manager.audio:GetLocalizationFlag()

		if var_207_0[var_207_1] ~= nil then
			arg_207_1.duration_ = var_207_0[var_207_1]
		end

		SetActive(arg_207_1.tipsGo_, false)

		function arg_207_1.onSingleLineFinish_()
			arg_207_1.onSingleLineUpdate_ = nil
			arg_207_1.onSingleLineFinish_ = nil
			arg_207_1.state_ = "waiting"
		end

		function arg_207_1.playNext_(arg_209_0)
			if arg_209_0 == 1 then
				arg_207_0:Play411051052(arg_207_1)
			end
		end

		function arg_207_1.onSingleLineUpdate_(arg_210_0)
			local var_210_0 = arg_207_1.actors_["10058ui_story"].transform
			local var_210_1 = 0

			if var_210_1 < arg_207_1.time_ and arg_207_1.time_ <= var_210_1 + arg_210_0 then
				arg_207_1.var_.moveOldPos10058ui_story = var_210_0.localPosition
			end

			local var_210_2 = 0.001

			if var_210_1 <= arg_207_1.time_ and arg_207_1.time_ < var_210_1 + var_210_2 then
				local var_210_3 = (arg_207_1.time_ - var_210_1) / var_210_2
				local var_210_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_210_0.localPosition = Vector3.Lerp(arg_207_1.var_.moveOldPos10058ui_story, var_210_4, var_210_3)

				local var_210_5 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_5.x, var_210_5.y, var_210_5.z)

				local var_210_6 = var_210_0.localEulerAngles

				var_210_6.z = 0
				var_210_6.x = 0
				var_210_0.localEulerAngles = var_210_6
			end

			if arg_207_1.time_ >= var_210_1 + var_210_2 and arg_207_1.time_ < var_210_1 + var_210_2 + arg_210_0 then
				var_210_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_210_7 = manager.ui.mainCamera.transform.position - var_210_0.position

				var_210_0.forward = Vector3.New(var_210_7.x, var_210_7.y, var_210_7.z)

				local var_210_8 = var_210_0.localEulerAngles

				var_210_8.z = 0
				var_210_8.x = 0
				var_210_0.localEulerAngles = var_210_8
			end

			local var_210_9 = arg_207_1.actors_["10058ui_story"]
			local var_210_10 = 0

			if var_210_10 < arg_207_1.time_ and arg_207_1.time_ <= var_210_10 + arg_210_0 and arg_207_1.var_.characterEffect10058ui_story == nil then
				arg_207_1.var_.characterEffect10058ui_story = var_210_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_11 = 0.200000002980232

			if var_210_10 <= arg_207_1.time_ and arg_207_1.time_ < var_210_10 + var_210_11 then
				local var_210_12 = (arg_207_1.time_ - var_210_10) / var_210_11

				if arg_207_1.var_.characterEffect10058ui_story then
					arg_207_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_207_1.time_ >= var_210_10 + var_210_11 and arg_207_1.time_ < var_210_10 + var_210_11 + arg_210_0 and arg_207_1.var_.characterEffect10058ui_story then
				arg_207_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_210_13 = arg_207_1.actors_["10014ui_story"]
			local var_210_14 = 0

			if var_210_14 < arg_207_1.time_ and arg_207_1.time_ <= var_210_14 + arg_210_0 and arg_207_1.var_.characterEffect10014ui_story == nil then
				arg_207_1.var_.characterEffect10014ui_story = var_210_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_210_15 = 0.200000002980232

			if var_210_14 <= arg_207_1.time_ and arg_207_1.time_ < var_210_14 + var_210_15 then
				local var_210_16 = (arg_207_1.time_ - var_210_14) / var_210_15

				if arg_207_1.var_.characterEffect10014ui_story then
					local var_210_17 = Mathf.Lerp(0, 0.5, var_210_16)

					arg_207_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_207_1.var_.characterEffect10014ui_story.fillRatio = var_210_17
				end
			end

			if arg_207_1.time_ >= var_210_14 + var_210_15 and arg_207_1.time_ < var_210_14 + var_210_15 + arg_210_0 and arg_207_1.var_.characterEffect10014ui_story then
				local var_210_18 = 0.5

				arg_207_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_207_1.var_.characterEffect10014ui_story.fillRatio = var_210_18
			end

			local var_210_19 = 0
			local var_210_20 = 0.1

			if var_210_19 < arg_207_1.time_ and arg_207_1.time_ <= var_210_19 + arg_210_0 then
				arg_207_1.talkMaxDuration = 0
				arg_207_1.dialogCg_.alpha = 1

				arg_207_1.dialog_:SetActive(true)
				SetActive(arg_207_1.leftNameGo_, true)

				local var_210_21 = arg_207_1:FormatText(StoryNameCfg[471].name)

				arg_207_1.leftNameTxt_.text = var_210_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_207_1.leftNameTxt_.transform)

				arg_207_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_207_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_207_1:RecordName(arg_207_1.leftNameTxt_.text)
				SetActive(arg_207_1.iconTrs_.gameObject, false)
				arg_207_1.callingController_:SetSelectedState("normal")

				local var_210_22 = arg_207_1:GetWordFromCfg(411051051)
				local var_210_23 = arg_207_1:FormatText(var_210_22.content)

				arg_207_1.text_.text = var_210_23

				LuaForUtil.ClearLinePrefixSymbol(arg_207_1.text_)

				local var_210_24 = 4
				local var_210_25 = utf8.len(var_210_23)
				local var_210_26 = var_210_24 <= 0 and var_210_20 or var_210_20 * (var_210_25 / var_210_24)

				if var_210_26 > 0 and var_210_20 < var_210_26 then
					arg_207_1.talkMaxDuration = var_210_26

					if var_210_26 + var_210_19 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_26 + var_210_19
					end
				end

				arg_207_1.text_.text = var_210_23
				arg_207_1.typewritter.percent = 0

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") ~= 0 then
					local var_210_27 = manager.audio:GetVoiceLength("story_v_out_411051", "411051051", "story_v_out_411051.awb") / 1000

					if var_210_27 + var_210_19 > arg_207_1.duration_ then
						arg_207_1.duration_ = var_210_27 + var_210_19
					end

					if var_210_22.prefab_name ~= "" and arg_207_1.actors_[var_210_22.prefab_name] ~= nil then
						local var_210_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_207_1.actors_[var_210_22.prefab_name].transform, "story_v_out_411051", "411051051", "story_v_out_411051.awb")

						arg_207_1:RecordAudio("411051051", var_210_28)
						arg_207_1:RecordAudio("411051051", var_210_28)
					else
						arg_207_1:AudioAction("play", "voice", "story_v_out_411051", "411051051", "story_v_out_411051.awb")
					end

					arg_207_1:RecordHistoryTalkVoice("story_v_out_411051", "411051051", "story_v_out_411051.awb")
				end

				arg_207_1:RecordContent(arg_207_1.text_.text)
			end

			local var_210_29 = math.max(var_210_20, arg_207_1.talkMaxDuration)

			if var_210_19 <= arg_207_1.time_ and arg_207_1.time_ < var_210_19 + var_210_29 then
				arg_207_1.typewritter.percent = (arg_207_1.time_ - var_210_19) / var_210_29

				arg_207_1.typewritter:SetDirty()
			end

			if arg_207_1.time_ >= var_210_19 + var_210_29 and arg_207_1.time_ < var_210_19 + var_210_29 + arg_210_0 then
				arg_207_1.typewritter.percent = 1

				arg_207_1.typewritter:SetDirty()
				arg_207_1:ShowNextGo(true)
			end
		end
	end,
	Play411051052 = function(arg_211_0, arg_211_1)
		arg_211_1.time_ = 0
		arg_211_1.frameCnt_ = 0
		arg_211_1.state_ = "playing"
		arg_211_1.curTalkId_ = 411051052
		arg_211_1.duration_ = 12.133

		local var_211_0 = {
			zh = 9.9,
			ja = 12.133
		}
		local var_211_1 = manager.audio:GetLocalizationFlag()

		if var_211_0[var_211_1] ~= nil then
			arg_211_1.duration_ = var_211_0[var_211_1]
		end

		SetActive(arg_211_1.tipsGo_, false)

		function arg_211_1.onSingleLineFinish_()
			arg_211_1.onSingleLineUpdate_ = nil
			arg_211_1.onSingleLineFinish_ = nil
			arg_211_1.state_ = "waiting"
		end

		function arg_211_1.playNext_(arg_213_0)
			if arg_213_0 == 1 then
				arg_211_0:Play411051053(arg_211_1)
			end
		end

		function arg_211_1.onSingleLineUpdate_(arg_214_0)
			local var_214_0 = arg_211_1.actors_["10014ui_story"].transform
			local var_214_1 = 0

			if var_214_1 < arg_211_1.time_ and arg_211_1.time_ <= var_214_1 + arg_214_0 then
				arg_211_1.var_.moveOldPos10014ui_story = var_214_0.localPosition
			end

			local var_214_2 = 0.001

			if var_214_1 <= arg_211_1.time_ and arg_211_1.time_ < var_214_1 + var_214_2 then
				local var_214_3 = (arg_211_1.time_ - var_214_1) / var_214_2
				local var_214_4 = Vector3.New(0.7, -1.06, -6.2)

				var_214_0.localPosition = Vector3.Lerp(arg_211_1.var_.moveOldPos10014ui_story, var_214_4, var_214_3)

				local var_214_5 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_5.x, var_214_5.y, var_214_5.z)

				local var_214_6 = var_214_0.localEulerAngles

				var_214_6.z = 0
				var_214_6.x = 0
				var_214_0.localEulerAngles = var_214_6
			end

			if arg_211_1.time_ >= var_214_1 + var_214_2 and arg_211_1.time_ < var_214_1 + var_214_2 + arg_214_0 then
				var_214_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_214_7 = manager.ui.mainCamera.transform.position - var_214_0.position

				var_214_0.forward = Vector3.New(var_214_7.x, var_214_7.y, var_214_7.z)

				local var_214_8 = var_214_0.localEulerAngles

				var_214_8.z = 0
				var_214_8.x = 0
				var_214_0.localEulerAngles = var_214_8
			end

			local var_214_9 = arg_211_1.actors_["10014ui_story"]
			local var_214_10 = 0

			if var_214_10 < arg_211_1.time_ and arg_211_1.time_ <= var_214_10 + arg_214_0 and arg_211_1.var_.characterEffect10014ui_story == nil then
				arg_211_1.var_.characterEffect10014ui_story = var_214_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_11 = 0.200000002980232

			if var_214_10 <= arg_211_1.time_ and arg_211_1.time_ < var_214_10 + var_214_11 then
				local var_214_12 = (arg_211_1.time_ - var_214_10) / var_214_11

				if arg_211_1.var_.characterEffect10014ui_story then
					arg_211_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_211_1.time_ >= var_214_10 + var_214_11 and arg_211_1.time_ < var_214_10 + var_214_11 + arg_214_0 and arg_211_1.var_.characterEffect10014ui_story then
				arg_211_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_214_13 = 0

			if var_214_13 < arg_211_1.time_ and arg_211_1.time_ <= var_214_13 + arg_214_0 then
				arg_211_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_214_14 = 0

			if var_214_14 < arg_211_1.time_ and arg_211_1.time_ <= var_214_14 + arg_214_0 then
				arg_211_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_214_15 = arg_211_1.actors_["10058ui_story"]
			local var_214_16 = 0

			if var_214_16 < arg_211_1.time_ and arg_211_1.time_ <= var_214_16 + arg_214_0 and arg_211_1.var_.characterEffect10058ui_story == nil then
				arg_211_1.var_.characterEffect10058ui_story = var_214_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_214_17 = 0.200000002980232

			if var_214_16 <= arg_211_1.time_ and arg_211_1.time_ < var_214_16 + var_214_17 then
				local var_214_18 = (arg_211_1.time_ - var_214_16) / var_214_17

				if arg_211_1.var_.characterEffect10058ui_story then
					local var_214_19 = Mathf.Lerp(0, 0.5, var_214_18)

					arg_211_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_211_1.var_.characterEffect10058ui_story.fillRatio = var_214_19
				end
			end

			if arg_211_1.time_ >= var_214_16 + var_214_17 and arg_211_1.time_ < var_214_16 + var_214_17 + arg_214_0 and arg_211_1.var_.characterEffect10058ui_story then
				local var_214_20 = 0.5

				arg_211_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_211_1.var_.characterEffect10058ui_story.fillRatio = var_214_20
			end

			local var_214_21 = 0
			local var_214_22 = 1.075

			if var_214_21 < arg_211_1.time_ and arg_211_1.time_ <= var_214_21 + arg_214_0 then
				arg_211_1.talkMaxDuration = 0
				arg_211_1.dialogCg_.alpha = 1

				arg_211_1.dialog_:SetActive(true)
				SetActive(arg_211_1.leftNameGo_, true)

				local var_214_23 = arg_211_1:FormatText(StoryNameCfg[264].name)

				arg_211_1.leftNameTxt_.text = var_214_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_211_1.leftNameTxt_.transform)

				arg_211_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_211_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_211_1:RecordName(arg_211_1.leftNameTxt_.text)
				SetActive(arg_211_1.iconTrs_.gameObject, false)
				arg_211_1.callingController_:SetSelectedState("normal")

				local var_214_24 = arg_211_1:GetWordFromCfg(411051052)
				local var_214_25 = arg_211_1:FormatText(var_214_24.content)

				arg_211_1.text_.text = var_214_25

				LuaForUtil.ClearLinePrefixSymbol(arg_211_1.text_)

				local var_214_26 = 43
				local var_214_27 = utf8.len(var_214_25)
				local var_214_28 = var_214_26 <= 0 and var_214_22 or var_214_22 * (var_214_27 / var_214_26)

				if var_214_28 > 0 and var_214_22 < var_214_28 then
					arg_211_1.talkMaxDuration = var_214_28

					if var_214_28 + var_214_21 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_28 + var_214_21
					end
				end

				arg_211_1.text_.text = var_214_25
				arg_211_1.typewritter.percent = 0

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") ~= 0 then
					local var_214_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051052", "story_v_out_411051.awb") / 1000

					if var_214_29 + var_214_21 > arg_211_1.duration_ then
						arg_211_1.duration_ = var_214_29 + var_214_21
					end

					if var_214_24.prefab_name ~= "" and arg_211_1.actors_[var_214_24.prefab_name] ~= nil then
						local var_214_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_211_1.actors_[var_214_24.prefab_name].transform, "story_v_out_411051", "411051052", "story_v_out_411051.awb")

						arg_211_1:RecordAudio("411051052", var_214_30)
						arg_211_1:RecordAudio("411051052", var_214_30)
					else
						arg_211_1:AudioAction("play", "voice", "story_v_out_411051", "411051052", "story_v_out_411051.awb")
					end

					arg_211_1:RecordHistoryTalkVoice("story_v_out_411051", "411051052", "story_v_out_411051.awb")
				end

				arg_211_1:RecordContent(arg_211_1.text_.text)
			end

			local var_214_31 = math.max(var_214_22, arg_211_1.talkMaxDuration)

			if var_214_21 <= arg_211_1.time_ and arg_211_1.time_ < var_214_21 + var_214_31 then
				arg_211_1.typewritter.percent = (arg_211_1.time_ - var_214_21) / var_214_31

				arg_211_1.typewritter:SetDirty()
			end

			if arg_211_1.time_ >= var_214_21 + var_214_31 and arg_211_1.time_ < var_214_21 + var_214_31 + arg_214_0 then
				arg_211_1.typewritter.percent = 1

				arg_211_1.typewritter:SetDirty()
				arg_211_1:ShowNextGo(true)
			end
		end
	end,
	Play411051053 = function(arg_215_0, arg_215_1)
		arg_215_1.time_ = 0
		arg_215_1.frameCnt_ = 0
		arg_215_1.state_ = "playing"
		arg_215_1.curTalkId_ = 411051053
		arg_215_1.duration_ = 5

		SetActive(arg_215_1.tipsGo_, false)

		function arg_215_1.onSingleLineFinish_()
			arg_215_1.onSingleLineUpdate_ = nil
			arg_215_1.onSingleLineFinish_ = nil
			arg_215_1.state_ = "waiting"
		end

		function arg_215_1.playNext_(arg_217_0)
			if arg_217_0 == 1 then
				arg_215_0:Play411051054(arg_215_1)
			end
		end

		function arg_215_1.onSingleLineUpdate_(arg_218_0)
			local var_218_0 = arg_215_1.actors_["10014ui_story"]
			local var_218_1 = 0

			if var_218_1 < arg_215_1.time_ and arg_215_1.time_ <= var_218_1 + arg_218_0 and arg_215_1.var_.characterEffect10014ui_story == nil then
				arg_215_1.var_.characterEffect10014ui_story = var_218_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_218_2 = 0.200000002980232

			if var_218_1 <= arg_215_1.time_ and arg_215_1.time_ < var_218_1 + var_218_2 then
				local var_218_3 = (arg_215_1.time_ - var_218_1) / var_218_2

				if arg_215_1.var_.characterEffect10014ui_story then
					local var_218_4 = Mathf.Lerp(0, 0.5, var_218_3)

					arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_215_1.var_.characterEffect10014ui_story.fillRatio = var_218_4
				end
			end

			if arg_215_1.time_ >= var_218_1 + var_218_2 and arg_215_1.time_ < var_218_1 + var_218_2 + arg_218_0 and arg_215_1.var_.characterEffect10014ui_story then
				local var_218_5 = 0.5

				arg_215_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_215_1.var_.characterEffect10014ui_story.fillRatio = var_218_5
			end

			local var_218_6 = 0
			local var_218_7 = 0.9

			if var_218_6 < arg_215_1.time_ and arg_215_1.time_ <= var_218_6 + arg_218_0 then
				arg_215_1.talkMaxDuration = 0
				arg_215_1.dialogCg_.alpha = 1

				arg_215_1.dialog_:SetActive(true)
				SetActive(arg_215_1.leftNameGo_, false)

				arg_215_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_215_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_215_1:RecordName(arg_215_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_215_1.iconTrs_.gameObject, false)
				arg_215_1.callingController_:SetSelectedState("normal")

				local var_218_8 = arg_215_1:GetWordFromCfg(411051053)
				local var_218_9 = arg_215_1:FormatText(var_218_8.content)

				arg_215_1.text_.text = var_218_9

				LuaForUtil.ClearLinePrefixSymbol(arg_215_1.text_)

				local var_218_10 = 36
				local var_218_11 = utf8.len(var_218_9)
				local var_218_12 = var_218_10 <= 0 and var_218_7 or var_218_7 * (var_218_11 / var_218_10)

				if var_218_12 > 0 and var_218_7 < var_218_12 then
					arg_215_1.talkMaxDuration = var_218_12

					if var_218_12 + var_218_6 > arg_215_1.duration_ then
						arg_215_1.duration_ = var_218_12 + var_218_6
					end
				end

				arg_215_1.text_.text = var_218_9
				arg_215_1.typewritter.percent = 0

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(false)
				arg_215_1:RecordContent(arg_215_1.text_.text)
			end

			local var_218_13 = math.max(var_218_7, arg_215_1.talkMaxDuration)

			if var_218_6 <= arg_215_1.time_ and arg_215_1.time_ < var_218_6 + var_218_13 then
				arg_215_1.typewritter.percent = (arg_215_1.time_ - var_218_6) / var_218_13

				arg_215_1.typewritter:SetDirty()
			end

			if arg_215_1.time_ >= var_218_6 + var_218_13 and arg_215_1.time_ < var_218_6 + var_218_13 + arg_218_0 then
				arg_215_1.typewritter.percent = 1

				arg_215_1.typewritter:SetDirty()
				arg_215_1:ShowNextGo(true)
			end
		end
	end,
	Play411051054 = function(arg_219_0, arg_219_1)
		arg_219_1.time_ = 0
		arg_219_1.frameCnt_ = 0
		arg_219_1.state_ = "playing"
		arg_219_1.curTalkId_ = 411051054
		arg_219_1.duration_ = 1.999999999999

		SetActive(arg_219_1.tipsGo_, false)

		function arg_219_1.onSingleLineFinish_()
			arg_219_1.onSingleLineUpdate_ = nil
			arg_219_1.onSingleLineFinish_ = nil
			arg_219_1.state_ = "waiting"
		end

		function arg_219_1.playNext_(arg_221_0)
			if arg_221_0 == 1 then
				arg_219_0:Play411051055(arg_219_1)
			end
		end

		function arg_219_1.onSingleLineUpdate_(arg_222_0)
			local var_222_0 = arg_219_1.actors_["10058ui_story"].transform
			local var_222_1 = 0

			if var_222_1 < arg_219_1.time_ and arg_219_1.time_ <= var_222_1 + arg_222_0 then
				arg_219_1.var_.moveOldPos10058ui_story = var_222_0.localPosition
			end

			local var_222_2 = 0.001

			if var_222_1 <= arg_219_1.time_ and arg_219_1.time_ < var_222_1 + var_222_2 then
				local var_222_3 = (arg_219_1.time_ - var_222_1) / var_222_2
				local var_222_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_222_0.localPosition = Vector3.Lerp(arg_219_1.var_.moveOldPos10058ui_story, var_222_4, var_222_3)

				local var_222_5 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_5.x, var_222_5.y, var_222_5.z)

				local var_222_6 = var_222_0.localEulerAngles

				var_222_6.z = 0
				var_222_6.x = 0
				var_222_0.localEulerAngles = var_222_6
			end

			if arg_219_1.time_ >= var_222_1 + var_222_2 and arg_219_1.time_ < var_222_1 + var_222_2 + arg_222_0 then
				var_222_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_222_7 = manager.ui.mainCamera.transform.position - var_222_0.position

				var_222_0.forward = Vector3.New(var_222_7.x, var_222_7.y, var_222_7.z)

				local var_222_8 = var_222_0.localEulerAngles

				var_222_8.z = 0
				var_222_8.x = 0
				var_222_0.localEulerAngles = var_222_8
			end

			local var_222_9 = arg_219_1.actors_["10058ui_story"]
			local var_222_10 = 0

			if var_222_10 < arg_219_1.time_ and arg_219_1.time_ <= var_222_10 + arg_222_0 and arg_219_1.var_.characterEffect10058ui_story == nil then
				arg_219_1.var_.characterEffect10058ui_story = var_222_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_222_11 = 0.200000002980232

			if var_222_10 <= arg_219_1.time_ and arg_219_1.time_ < var_222_10 + var_222_11 then
				local var_222_12 = (arg_219_1.time_ - var_222_10) / var_222_11

				if arg_219_1.var_.characterEffect10058ui_story then
					arg_219_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_219_1.time_ >= var_222_10 + var_222_11 and arg_219_1.time_ < var_222_10 + var_222_11 + arg_222_0 and arg_219_1.var_.characterEffect10058ui_story then
				arg_219_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_222_13 = 0

			if var_222_13 < arg_219_1.time_ and arg_219_1.time_ <= var_222_13 + arg_222_0 then
				arg_219_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_2")
			end

			local var_222_14 = 0

			if var_222_14 < arg_219_1.time_ and arg_219_1.time_ <= var_222_14 + arg_222_0 then
				arg_219_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface3201cva")
			end

			local var_222_15 = 0
			local var_222_16 = 0.2

			if var_222_15 < arg_219_1.time_ and arg_219_1.time_ <= var_222_15 + arg_222_0 then
				arg_219_1.talkMaxDuration = 0
				arg_219_1.dialogCg_.alpha = 1

				arg_219_1.dialog_:SetActive(true)
				SetActive(arg_219_1.leftNameGo_, true)

				local var_222_17 = arg_219_1:FormatText(StoryNameCfg[471].name)

				arg_219_1.leftNameTxt_.text = var_222_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_219_1.leftNameTxt_.transform)

				arg_219_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_219_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_219_1:RecordName(arg_219_1.leftNameTxt_.text)
				SetActive(arg_219_1.iconTrs_.gameObject, false)
				arg_219_1.callingController_:SetSelectedState("normal")

				local var_222_18 = arg_219_1:GetWordFromCfg(411051054)
				local var_222_19 = arg_219_1:FormatText(var_222_18.content)

				arg_219_1.text_.text = var_222_19

				LuaForUtil.ClearLinePrefixSymbol(arg_219_1.text_)

				local var_222_20 = 8
				local var_222_21 = utf8.len(var_222_19)
				local var_222_22 = var_222_20 <= 0 and var_222_16 or var_222_16 * (var_222_21 / var_222_20)

				if var_222_22 > 0 and var_222_16 < var_222_22 then
					arg_219_1.talkMaxDuration = var_222_22

					if var_222_22 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_22 + var_222_15
					end
				end

				arg_219_1.text_.text = var_222_19
				arg_219_1.typewritter.percent = 0

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") ~= 0 then
					local var_222_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051054", "story_v_out_411051.awb") / 1000

					if var_222_23 + var_222_15 > arg_219_1.duration_ then
						arg_219_1.duration_ = var_222_23 + var_222_15
					end

					if var_222_18.prefab_name ~= "" and arg_219_1.actors_[var_222_18.prefab_name] ~= nil then
						local var_222_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_219_1.actors_[var_222_18.prefab_name].transform, "story_v_out_411051", "411051054", "story_v_out_411051.awb")

						arg_219_1:RecordAudio("411051054", var_222_24)
						arg_219_1:RecordAudio("411051054", var_222_24)
					else
						arg_219_1:AudioAction("play", "voice", "story_v_out_411051", "411051054", "story_v_out_411051.awb")
					end

					arg_219_1:RecordHistoryTalkVoice("story_v_out_411051", "411051054", "story_v_out_411051.awb")
				end

				arg_219_1:RecordContent(arg_219_1.text_.text)
			end

			local var_222_25 = math.max(var_222_16, arg_219_1.talkMaxDuration)

			if var_222_15 <= arg_219_1.time_ and arg_219_1.time_ < var_222_15 + var_222_25 then
				arg_219_1.typewritter.percent = (arg_219_1.time_ - var_222_15) / var_222_25

				arg_219_1.typewritter:SetDirty()
			end

			if arg_219_1.time_ >= var_222_15 + var_222_25 and arg_219_1.time_ < var_222_15 + var_222_25 + arg_222_0 then
				arg_219_1.typewritter.percent = 1

				arg_219_1.typewritter:SetDirty()
				arg_219_1:ShowNextGo(true)
			end
		end
	end,
	Play411051055 = function(arg_223_0, arg_223_1)
		arg_223_1.time_ = 0
		arg_223_1.frameCnt_ = 0
		arg_223_1.state_ = "playing"
		arg_223_1.curTalkId_ = 411051055
		arg_223_1.duration_ = 6.333

		local var_223_0 = {
			zh = 2.7,
			ja = 6.333
		}
		local var_223_1 = manager.audio:GetLocalizationFlag()

		if var_223_0[var_223_1] ~= nil then
			arg_223_1.duration_ = var_223_0[var_223_1]
		end

		SetActive(arg_223_1.tipsGo_, false)

		function arg_223_1.onSingleLineFinish_()
			arg_223_1.onSingleLineUpdate_ = nil
			arg_223_1.onSingleLineFinish_ = nil
			arg_223_1.state_ = "waiting"
		end

		function arg_223_1.playNext_(arg_225_0)
			if arg_225_0 == 1 then
				arg_223_0:Play411051056(arg_223_1)
			end
		end

		function arg_223_1.onSingleLineUpdate_(arg_226_0)
			local var_226_0 = arg_223_1.actors_["10058ui_story"]
			local var_226_1 = 0

			if var_226_1 < arg_223_1.time_ and arg_223_1.time_ <= var_226_1 + arg_226_0 and arg_223_1.var_.characterEffect10058ui_story == nil then
				arg_223_1.var_.characterEffect10058ui_story = var_226_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_2 = 0.200000002980232

			if var_226_1 <= arg_223_1.time_ and arg_223_1.time_ < var_226_1 + var_226_2 then
				local var_226_3 = (arg_223_1.time_ - var_226_1) / var_226_2

				if arg_223_1.var_.characterEffect10058ui_story then
					local var_226_4 = Mathf.Lerp(0, 0.5, var_226_3)

					arg_223_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_223_1.var_.characterEffect10058ui_story.fillRatio = var_226_4
				end
			end

			if arg_223_1.time_ >= var_226_1 + var_226_2 and arg_223_1.time_ < var_226_1 + var_226_2 + arg_226_0 and arg_223_1.var_.characterEffect10058ui_story then
				local var_226_5 = 0.5

				arg_223_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_223_1.var_.characterEffect10058ui_story.fillRatio = var_226_5
			end

			local var_226_6 = arg_223_1.actors_["10014ui_story"]
			local var_226_7 = 0

			if var_226_7 < arg_223_1.time_ and arg_223_1.time_ <= var_226_7 + arg_226_0 and arg_223_1.var_.characterEffect10014ui_story == nil then
				arg_223_1.var_.characterEffect10014ui_story = var_226_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_226_8 = 0.200000002980232

			if var_226_7 <= arg_223_1.time_ and arg_223_1.time_ < var_226_7 + var_226_8 then
				local var_226_9 = (arg_223_1.time_ - var_226_7) / var_226_8

				if arg_223_1.var_.characterEffect10014ui_story then
					arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_223_1.time_ >= var_226_7 + var_226_8 and arg_223_1.time_ < var_226_7 + var_226_8 + arg_226_0 and arg_223_1.var_.characterEffect10014ui_story then
				arg_223_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_226_10 = 0
			local var_226_11 = 0.4

			if var_226_10 < arg_223_1.time_ and arg_223_1.time_ <= var_226_10 + arg_226_0 then
				arg_223_1.talkMaxDuration = 0
				arg_223_1.dialogCg_.alpha = 1

				arg_223_1.dialog_:SetActive(true)
				SetActive(arg_223_1.leftNameGo_, true)

				local var_226_12 = arg_223_1:FormatText(StoryNameCfg[264].name)

				arg_223_1.leftNameTxt_.text = var_226_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_223_1.leftNameTxt_.transform)

				arg_223_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_223_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_223_1:RecordName(arg_223_1.leftNameTxt_.text)
				SetActive(arg_223_1.iconTrs_.gameObject, false)
				arg_223_1.callingController_:SetSelectedState("normal")

				local var_226_13 = arg_223_1:GetWordFromCfg(411051055)
				local var_226_14 = arg_223_1:FormatText(var_226_13.content)

				arg_223_1.text_.text = var_226_14

				LuaForUtil.ClearLinePrefixSymbol(arg_223_1.text_)

				local var_226_15 = 16
				local var_226_16 = utf8.len(var_226_14)
				local var_226_17 = var_226_15 <= 0 and var_226_11 or var_226_11 * (var_226_16 / var_226_15)

				if var_226_17 > 0 and var_226_11 < var_226_17 then
					arg_223_1.talkMaxDuration = var_226_17

					if var_226_17 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_17 + var_226_10
					end
				end

				arg_223_1.text_.text = var_226_14
				arg_223_1.typewritter.percent = 0

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") ~= 0 then
					local var_226_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051055", "story_v_out_411051.awb") / 1000

					if var_226_18 + var_226_10 > arg_223_1.duration_ then
						arg_223_1.duration_ = var_226_18 + var_226_10
					end

					if var_226_13.prefab_name ~= "" and arg_223_1.actors_[var_226_13.prefab_name] ~= nil then
						local var_226_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_223_1.actors_[var_226_13.prefab_name].transform, "story_v_out_411051", "411051055", "story_v_out_411051.awb")

						arg_223_1:RecordAudio("411051055", var_226_19)
						arg_223_1:RecordAudio("411051055", var_226_19)
					else
						arg_223_1:AudioAction("play", "voice", "story_v_out_411051", "411051055", "story_v_out_411051.awb")
					end

					arg_223_1:RecordHistoryTalkVoice("story_v_out_411051", "411051055", "story_v_out_411051.awb")
				end

				arg_223_1:RecordContent(arg_223_1.text_.text)
			end

			local var_226_20 = math.max(var_226_11, arg_223_1.talkMaxDuration)

			if var_226_10 <= arg_223_1.time_ and arg_223_1.time_ < var_226_10 + var_226_20 then
				arg_223_1.typewritter.percent = (arg_223_1.time_ - var_226_10) / var_226_20

				arg_223_1.typewritter:SetDirty()
			end

			if arg_223_1.time_ >= var_226_10 + var_226_20 and arg_223_1.time_ < var_226_10 + var_226_20 + arg_226_0 then
				arg_223_1.typewritter.percent = 1

				arg_223_1.typewritter:SetDirty()
				arg_223_1:ShowNextGo(true)
			end
		end
	end,
	Play411051056 = function(arg_227_0, arg_227_1)
		arg_227_1.time_ = 0
		arg_227_1.frameCnt_ = 0
		arg_227_1.state_ = "playing"
		arg_227_1.curTalkId_ = 411051056
		arg_227_1.duration_ = 6.966

		local var_227_0 = {
			zh = 6.966,
			ja = 5.666
		}
		local var_227_1 = manager.audio:GetLocalizationFlag()

		if var_227_0[var_227_1] ~= nil then
			arg_227_1.duration_ = var_227_0[var_227_1]
		end

		SetActive(arg_227_1.tipsGo_, false)

		function arg_227_1.onSingleLineFinish_()
			arg_227_1.onSingleLineUpdate_ = nil
			arg_227_1.onSingleLineFinish_ = nil
			arg_227_1.state_ = "waiting"
		end

		function arg_227_1.playNext_(arg_229_0)
			if arg_229_0 == 1 then
				arg_227_0:Play411051057(arg_227_1)
			end
		end

		function arg_227_1.onSingleLineUpdate_(arg_230_0)
			local var_230_0 = 0
			local var_230_1 = 0.875

			if var_230_0 < arg_227_1.time_ and arg_227_1.time_ <= var_230_0 + arg_230_0 then
				arg_227_1.talkMaxDuration = 0
				arg_227_1.dialogCg_.alpha = 1

				arg_227_1.dialog_:SetActive(true)
				SetActive(arg_227_1.leftNameGo_, true)

				local var_230_2 = arg_227_1:FormatText(StoryNameCfg[264].name)

				arg_227_1.leftNameTxt_.text = var_230_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_227_1.leftNameTxt_.transform)

				arg_227_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_227_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_227_1:RecordName(arg_227_1.leftNameTxt_.text)
				SetActive(arg_227_1.iconTrs_.gameObject, false)
				arg_227_1.callingController_:SetSelectedState("normal")

				local var_230_3 = arg_227_1:GetWordFromCfg(411051056)
				local var_230_4 = arg_227_1:FormatText(var_230_3.content)

				arg_227_1.text_.text = var_230_4

				LuaForUtil.ClearLinePrefixSymbol(arg_227_1.text_)

				local var_230_5 = 35
				local var_230_6 = utf8.len(var_230_4)
				local var_230_7 = var_230_5 <= 0 and var_230_1 or var_230_1 * (var_230_6 / var_230_5)

				if var_230_7 > 0 and var_230_1 < var_230_7 then
					arg_227_1.talkMaxDuration = var_230_7

					if var_230_7 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_7 + var_230_0
					end
				end

				arg_227_1.text_.text = var_230_4
				arg_227_1.typewritter.percent = 0

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") ~= 0 then
					local var_230_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051056", "story_v_out_411051.awb") / 1000

					if var_230_8 + var_230_0 > arg_227_1.duration_ then
						arg_227_1.duration_ = var_230_8 + var_230_0
					end

					if var_230_3.prefab_name ~= "" and arg_227_1.actors_[var_230_3.prefab_name] ~= nil then
						local var_230_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_227_1.actors_[var_230_3.prefab_name].transform, "story_v_out_411051", "411051056", "story_v_out_411051.awb")

						arg_227_1:RecordAudio("411051056", var_230_9)
						arg_227_1:RecordAudio("411051056", var_230_9)
					else
						arg_227_1:AudioAction("play", "voice", "story_v_out_411051", "411051056", "story_v_out_411051.awb")
					end

					arg_227_1:RecordHistoryTalkVoice("story_v_out_411051", "411051056", "story_v_out_411051.awb")
				end

				arg_227_1:RecordContent(arg_227_1.text_.text)
			end

			local var_230_10 = math.max(var_230_1, arg_227_1.talkMaxDuration)

			if var_230_0 <= arg_227_1.time_ and arg_227_1.time_ < var_230_0 + var_230_10 then
				arg_227_1.typewritter.percent = (arg_227_1.time_ - var_230_0) / var_230_10

				arg_227_1.typewritter:SetDirty()
			end

			if arg_227_1.time_ >= var_230_0 + var_230_10 and arg_227_1.time_ < var_230_0 + var_230_10 + arg_230_0 then
				arg_227_1.typewritter.percent = 1

				arg_227_1.typewritter:SetDirty()
				arg_227_1:ShowNextGo(true)
			end
		end
	end,
	Play411051057 = function(arg_231_0, arg_231_1)
		arg_231_1.time_ = 0
		arg_231_1.frameCnt_ = 0
		arg_231_1.state_ = "playing"
		arg_231_1.curTalkId_ = 411051057
		arg_231_1.duration_ = 4.133

		local var_231_0 = {
			zh = 3.4,
			ja = 4.133
		}
		local var_231_1 = manager.audio:GetLocalizationFlag()

		if var_231_0[var_231_1] ~= nil then
			arg_231_1.duration_ = var_231_0[var_231_1]
		end

		SetActive(arg_231_1.tipsGo_, false)

		function arg_231_1.onSingleLineFinish_()
			arg_231_1.onSingleLineUpdate_ = nil
			arg_231_1.onSingleLineFinish_ = nil
			arg_231_1.state_ = "waiting"
		end

		function arg_231_1.playNext_(arg_233_0)
			if arg_233_0 == 1 then
				arg_231_0:Play411051058(arg_231_1)
			end
		end

		function arg_231_1.onSingleLineUpdate_(arg_234_0)
			local var_234_0 = arg_231_1.actors_["10058ui_story"]
			local var_234_1 = 0

			if var_234_1 < arg_231_1.time_ and arg_231_1.time_ <= var_234_1 + arg_234_0 and arg_231_1.var_.characterEffect10058ui_story == nil then
				arg_231_1.var_.characterEffect10058ui_story = var_234_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_2 = 0.200000002980232

			if var_234_1 <= arg_231_1.time_ and arg_231_1.time_ < var_234_1 + var_234_2 then
				local var_234_3 = (arg_231_1.time_ - var_234_1) / var_234_2

				if arg_231_1.var_.characterEffect10058ui_story then
					arg_231_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_231_1.time_ >= var_234_1 + var_234_2 and arg_231_1.time_ < var_234_1 + var_234_2 + arg_234_0 and arg_231_1.var_.characterEffect10058ui_story then
				arg_231_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_234_4 = 0

			if var_234_4 < arg_231_1.time_ and arg_231_1.time_ <= var_234_4 + arg_234_0 then
				arg_231_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_234_5 = arg_231_1.actors_["10014ui_story"]
			local var_234_6 = 0

			if var_234_6 < arg_231_1.time_ and arg_231_1.time_ <= var_234_6 + arg_234_0 and arg_231_1.var_.characterEffect10014ui_story == nil then
				arg_231_1.var_.characterEffect10014ui_story = var_234_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_234_7 = 0.200000002980232

			if var_234_6 <= arg_231_1.time_ and arg_231_1.time_ < var_234_6 + var_234_7 then
				local var_234_8 = (arg_231_1.time_ - var_234_6) / var_234_7

				if arg_231_1.var_.characterEffect10014ui_story then
					local var_234_9 = Mathf.Lerp(0, 0.5, var_234_8)

					arg_231_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_231_1.var_.characterEffect10014ui_story.fillRatio = var_234_9
				end
			end

			if arg_231_1.time_ >= var_234_6 + var_234_7 and arg_231_1.time_ < var_234_6 + var_234_7 + arg_234_0 and arg_231_1.var_.characterEffect10014ui_story then
				local var_234_10 = 0.5

				arg_231_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_231_1.var_.characterEffect10014ui_story.fillRatio = var_234_10
			end

			local var_234_11 = 0
			local var_234_12 = 0.45

			if var_234_11 < arg_231_1.time_ and arg_231_1.time_ <= var_234_11 + arg_234_0 then
				arg_231_1.talkMaxDuration = 0
				arg_231_1.dialogCg_.alpha = 1

				arg_231_1.dialog_:SetActive(true)
				SetActive(arg_231_1.leftNameGo_, true)

				local var_234_13 = arg_231_1:FormatText(StoryNameCfg[471].name)

				arg_231_1.leftNameTxt_.text = var_234_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_231_1.leftNameTxt_.transform)

				arg_231_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_231_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_231_1:RecordName(arg_231_1.leftNameTxt_.text)
				SetActive(arg_231_1.iconTrs_.gameObject, false)
				arg_231_1.callingController_:SetSelectedState("normal")

				local var_234_14 = arg_231_1:GetWordFromCfg(411051057)
				local var_234_15 = arg_231_1:FormatText(var_234_14.content)

				arg_231_1.text_.text = var_234_15

				LuaForUtil.ClearLinePrefixSymbol(arg_231_1.text_)

				local var_234_16 = 18
				local var_234_17 = utf8.len(var_234_15)
				local var_234_18 = var_234_16 <= 0 and var_234_12 or var_234_12 * (var_234_17 / var_234_16)

				if var_234_18 > 0 and var_234_12 < var_234_18 then
					arg_231_1.talkMaxDuration = var_234_18

					if var_234_18 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_18 + var_234_11
					end
				end

				arg_231_1.text_.text = var_234_15
				arg_231_1.typewritter.percent = 0

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") ~= 0 then
					local var_234_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051057", "story_v_out_411051.awb") / 1000

					if var_234_19 + var_234_11 > arg_231_1.duration_ then
						arg_231_1.duration_ = var_234_19 + var_234_11
					end

					if var_234_14.prefab_name ~= "" and arg_231_1.actors_[var_234_14.prefab_name] ~= nil then
						local var_234_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_231_1.actors_[var_234_14.prefab_name].transform, "story_v_out_411051", "411051057", "story_v_out_411051.awb")

						arg_231_1:RecordAudio("411051057", var_234_20)
						arg_231_1:RecordAudio("411051057", var_234_20)
					else
						arg_231_1:AudioAction("play", "voice", "story_v_out_411051", "411051057", "story_v_out_411051.awb")
					end

					arg_231_1:RecordHistoryTalkVoice("story_v_out_411051", "411051057", "story_v_out_411051.awb")
				end

				arg_231_1:RecordContent(arg_231_1.text_.text)
			end

			local var_234_21 = math.max(var_234_12, arg_231_1.talkMaxDuration)

			if var_234_11 <= arg_231_1.time_ and arg_231_1.time_ < var_234_11 + var_234_21 then
				arg_231_1.typewritter.percent = (arg_231_1.time_ - var_234_11) / var_234_21

				arg_231_1.typewritter:SetDirty()
			end

			if arg_231_1.time_ >= var_234_11 + var_234_21 and arg_231_1.time_ < var_234_11 + var_234_21 + arg_234_0 then
				arg_231_1.typewritter.percent = 1

				arg_231_1.typewritter:SetDirty()
				arg_231_1:ShowNextGo(true)
			end
		end
	end,
	Play411051058 = function(arg_235_0, arg_235_1)
		arg_235_1.time_ = 0
		arg_235_1.frameCnt_ = 0
		arg_235_1.state_ = "playing"
		arg_235_1.curTalkId_ = 411051058
		arg_235_1.duration_ = 7.166

		local var_235_0 = {
			zh = 7.166,
			ja = 6.5
		}
		local var_235_1 = manager.audio:GetLocalizationFlag()

		if var_235_0[var_235_1] ~= nil then
			arg_235_1.duration_ = var_235_0[var_235_1]
		end

		SetActive(arg_235_1.tipsGo_, false)

		function arg_235_1.onSingleLineFinish_()
			arg_235_1.onSingleLineUpdate_ = nil
			arg_235_1.onSingleLineFinish_ = nil
			arg_235_1.state_ = "waiting"
		end

		function arg_235_1.playNext_(arg_237_0)
			if arg_237_0 == 1 then
				arg_235_0:Play411051059(arg_235_1)
			end
		end

		function arg_235_1.onSingleLineUpdate_(arg_238_0)
			local var_238_0 = arg_235_1.actors_["10014ui_story"].transform
			local var_238_1 = 0

			if var_238_1 < arg_235_1.time_ and arg_235_1.time_ <= var_238_1 + arg_238_0 then
				arg_235_1.var_.moveOldPos10014ui_story = var_238_0.localPosition
			end

			local var_238_2 = 0.001

			if var_238_1 <= arg_235_1.time_ and arg_235_1.time_ < var_238_1 + var_238_2 then
				local var_238_3 = (arg_235_1.time_ - var_238_1) / var_238_2
				local var_238_4 = Vector3.New(0.7, -1.06, -6.2)

				var_238_0.localPosition = Vector3.Lerp(arg_235_1.var_.moveOldPos10014ui_story, var_238_4, var_238_3)

				local var_238_5 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_5.x, var_238_5.y, var_238_5.z)

				local var_238_6 = var_238_0.localEulerAngles

				var_238_6.z = 0
				var_238_6.x = 0
				var_238_0.localEulerAngles = var_238_6
			end

			if arg_235_1.time_ >= var_238_1 + var_238_2 and arg_235_1.time_ < var_238_1 + var_238_2 + arg_238_0 then
				var_238_0.localPosition = Vector3.New(0.7, -1.06, -6.2)

				local var_238_7 = manager.ui.mainCamera.transform.position - var_238_0.position

				var_238_0.forward = Vector3.New(var_238_7.x, var_238_7.y, var_238_7.z)

				local var_238_8 = var_238_0.localEulerAngles

				var_238_8.z = 0
				var_238_8.x = 0
				var_238_0.localEulerAngles = var_238_8
			end

			local var_238_9 = arg_235_1.actors_["10014ui_story"]
			local var_238_10 = 0

			if var_238_10 < arg_235_1.time_ and arg_235_1.time_ <= var_238_10 + arg_238_0 and arg_235_1.var_.characterEffect10014ui_story == nil then
				arg_235_1.var_.characterEffect10014ui_story = var_238_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_11 = 0.200000002980232

			if var_238_10 <= arg_235_1.time_ and arg_235_1.time_ < var_238_10 + var_238_11 then
				local var_238_12 = (arg_235_1.time_ - var_238_10) / var_238_11

				if arg_235_1.var_.characterEffect10014ui_story then
					arg_235_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_235_1.time_ >= var_238_10 + var_238_11 and arg_235_1.time_ < var_238_10 + var_238_11 + arg_238_0 and arg_235_1.var_.characterEffect10014ui_story then
				arg_235_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_238_13 = 0

			if var_238_13 < arg_235_1.time_ and arg_235_1.time_ <= var_238_13 + arg_238_0 then
				arg_235_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action1_1")
			end

			local var_238_14 = 0

			if var_238_14 < arg_235_1.time_ and arg_235_1.time_ <= var_238_14 + arg_238_0 then
				arg_235_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_238_15 = arg_235_1.actors_["10058ui_story"]
			local var_238_16 = 0

			if var_238_16 < arg_235_1.time_ and arg_235_1.time_ <= var_238_16 + arg_238_0 and arg_235_1.var_.characterEffect10058ui_story == nil then
				arg_235_1.var_.characterEffect10058ui_story = var_238_15:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_238_17 = 0.0166666666666667

			if var_238_16 <= arg_235_1.time_ and arg_235_1.time_ < var_238_16 + var_238_17 then
				local var_238_18 = (arg_235_1.time_ - var_238_16) / var_238_17

				if arg_235_1.var_.characterEffect10058ui_story then
					local var_238_19 = Mathf.Lerp(0, 0.5, var_238_18)

					arg_235_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_235_1.var_.characterEffect10058ui_story.fillRatio = var_238_19
				end
			end

			if arg_235_1.time_ >= var_238_16 + var_238_17 and arg_235_1.time_ < var_238_16 + var_238_17 + arg_238_0 and arg_235_1.var_.characterEffect10058ui_story then
				local var_238_20 = 0.5

				arg_235_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_235_1.var_.characterEffect10058ui_story.fillRatio = var_238_20
			end

			local var_238_21 = 0
			local var_238_22 = 0.9

			if var_238_21 < arg_235_1.time_ and arg_235_1.time_ <= var_238_21 + arg_238_0 then
				arg_235_1.talkMaxDuration = 0
				arg_235_1.dialogCg_.alpha = 1

				arg_235_1.dialog_:SetActive(true)
				SetActive(arg_235_1.leftNameGo_, true)

				local var_238_23 = arg_235_1:FormatText(StoryNameCfg[264].name)

				arg_235_1.leftNameTxt_.text = var_238_23

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_235_1.leftNameTxt_.transform)

				arg_235_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_235_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_235_1:RecordName(arg_235_1.leftNameTxt_.text)
				SetActive(arg_235_1.iconTrs_.gameObject, false)
				arg_235_1.callingController_:SetSelectedState("normal")

				local var_238_24 = arg_235_1:GetWordFromCfg(411051058)
				local var_238_25 = arg_235_1:FormatText(var_238_24.content)

				arg_235_1.text_.text = var_238_25

				LuaForUtil.ClearLinePrefixSymbol(arg_235_1.text_)

				local var_238_26 = 36
				local var_238_27 = utf8.len(var_238_25)
				local var_238_28 = var_238_26 <= 0 and var_238_22 or var_238_22 * (var_238_27 / var_238_26)

				if var_238_28 > 0 and var_238_22 < var_238_28 then
					arg_235_1.talkMaxDuration = var_238_28

					if var_238_28 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_28 + var_238_21
					end
				end

				arg_235_1.text_.text = var_238_25
				arg_235_1.typewritter.percent = 0

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") ~= 0 then
					local var_238_29 = manager.audio:GetVoiceLength("story_v_out_411051", "411051058", "story_v_out_411051.awb") / 1000

					if var_238_29 + var_238_21 > arg_235_1.duration_ then
						arg_235_1.duration_ = var_238_29 + var_238_21
					end

					if var_238_24.prefab_name ~= "" and arg_235_1.actors_[var_238_24.prefab_name] ~= nil then
						local var_238_30 = LuaForUtil.PlayVoiceWithCriLipsync(arg_235_1.actors_[var_238_24.prefab_name].transform, "story_v_out_411051", "411051058", "story_v_out_411051.awb")

						arg_235_1:RecordAudio("411051058", var_238_30)
						arg_235_1:RecordAudio("411051058", var_238_30)
					else
						arg_235_1:AudioAction("play", "voice", "story_v_out_411051", "411051058", "story_v_out_411051.awb")
					end

					arg_235_1:RecordHistoryTalkVoice("story_v_out_411051", "411051058", "story_v_out_411051.awb")
				end

				arg_235_1:RecordContent(arg_235_1.text_.text)
			end

			local var_238_31 = math.max(var_238_22, arg_235_1.talkMaxDuration)

			if var_238_21 <= arg_235_1.time_ and arg_235_1.time_ < var_238_21 + var_238_31 then
				arg_235_1.typewritter.percent = (arg_235_1.time_ - var_238_21) / var_238_31

				arg_235_1.typewritter:SetDirty()
			end

			if arg_235_1.time_ >= var_238_21 + var_238_31 and arg_235_1.time_ < var_238_21 + var_238_31 + arg_238_0 then
				arg_235_1.typewritter.percent = 1

				arg_235_1.typewritter:SetDirty()
				arg_235_1:ShowNextGo(true)
			end
		end
	end,
	Play411051059 = function(arg_239_0, arg_239_1)
		arg_239_1.time_ = 0
		arg_239_1.frameCnt_ = 0
		arg_239_1.state_ = "playing"
		arg_239_1.curTalkId_ = 411051059
		arg_239_1.duration_ = 11.1

		local var_239_0 = {
			zh = 11.1,
			ja = 7.566
		}
		local var_239_1 = manager.audio:GetLocalizationFlag()

		if var_239_0[var_239_1] ~= nil then
			arg_239_1.duration_ = var_239_0[var_239_1]
		end

		SetActive(arg_239_1.tipsGo_, false)

		function arg_239_1.onSingleLineFinish_()
			arg_239_1.onSingleLineUpdate_ = nil
			arg_239_1.onSingleLineFinish_ = nil
			arg_239_1.state_ = "waiting"
		end

		function arg_239_1.playNext_(arg_241_0)
			if arg_241_0 == 1 then
				arg_239_0:Play411051060(arg_239_1)
			end
		end

		function arg_239_1.onSingleLineUpdate_(arg_242_0)
			local var_242_0 = 0
			local var_242_1 = 1.325

			if var_242_0 < arg_239_1.time_ and arg_239_1.time_ <= var_242_0 + arg_242_0 then
				arg_239_1.talkMaxDuration = 0
				arg_239_1.dialogCg_.alpha = 1

				arg_239_1.dialog_:SetActive(true)
				SetActive(arg_239_1.leftNameGo_, true)

				local var_242_2 = arg_239_1:FormatText(StoryNameCfg[264].name)

				arg_239_1.leftNameTxt_.text = var_242_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_239_1.leftNameTxt_.transform)

				arg_239_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_239_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_239_1:RecordName(arg_239_1.leftNameTxt_.text)
				SetActive(arg_239_1.iconTrs_.gameObject, false)
				arg_239_1.callingController_:SetSelectedState("normal")

				local var_242_3 = arg_239_1:GetWordFromCfg(411051059)
				local var_242_4 = arg_239_1:FormatText(var_242_3.content)

				arg_239_1.text_.text = var_242_4

				LuaForUtil.ClearLinePrefixSymbol(arg_239_1.text_)

				local var_242_5 = 53
				local var_242_6 = utf8.len(var_242_4)
				local var_242_7 = var_242_5 <= 0 and var_242_1 or var_242_1 * (var_242_6 / var_242_5)

				if var_242_7 > 0 and var_242_1 < var_242_7 then
					arg_239_1.talkMaxDuration = var_242_7

					if var_242_7 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_7 + var_242_0
					end
				end

				arg_239_1.text_.text = var_242_4
				arg_239_1.typewritter.percent = 0

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") ~= 0 then
					local var_242_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051059", "story_v_out_411051.awb") / 1000

					if var_242_8 + var_242_0 > arg_239_1.duration_ then
						arg_239_1.duration_ = var_242_8 + var_242_0
					end

					if var_242_3.prefab_name ~= "" and arg_239_1.actors_[var_242_3.prefab_name] ~= nil then
						local var_242_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_239_1.actors_[var_242_3.prefab_name].transform, "story_v_out_411051", "411051059", "story_v_out_411051.awb")

						arg_239_1:RecordAudio("411051059", var_242_9)
						arg_239_1:RecordAudio("411051059", var_242_9)
					else
						arg_239_1:AudioAction("play", "voice", "story_v_out_411051", "411051059", "story_v_out_411051.awb")
					end

					arg_239_1:RecordHistoryTalkVoice("story_v_out_411051", "411051059", "story_v_out_411051.awb")
				end

				arg_239_1:RecordContent(arg_239_1.text_.text)
			end

			local var_242_10 = math.max(var_242_1, arg_239_1.talkMaxDuration)

			if var_242_0 <= arg_239_1.time_ and arg_239_1.time_ < var_242_0 + var_242_10 then
				arg_239_1.typewritter.percent = (arg_239_1.time_ - var_242_0) / var_242_10

				arg_239_1.typewritter:SetDirty()
			end

			if arg_239_1.time_ >= var_242_0 + var_242_10 and arg_239_1.time_ < var_242_0 + var_242_10 + arg_242_0 then
				arg_239_1.typewritter.percent = 1

				arg_239_1.typewritter:SetDirty()
				arg_239_1:ShowNextGo(true)
			end
		end
	end,
	Play411051060 = function(arg_243_0, arg_243_1)
		arg_243_1.time_ = 0
		arg_243_1.frameCnt_ = 0
		arg_243_1.state_ = "playing"
		arg_243_1.curTalkId_ = 411051060
		arg_243_1.duration_ = 1.566

		local var_243_0 = {
			zh = 1.3,
			ja = 1.566
		}
		local var_243_1 = manager.audio:GetLocalizationFlag()

		if var_243_0[var_243_1] ~= nil then
			arg_243_1.duration_ = var_243_0[var_243_1]
		end

		SetActive(arg_243_1.tipsGo_, false)

		function arg_243_1.onSingleLineFinish_()
			arg_243_1.onSingleLineUpdate_ = nil
			arg_243_1.onSingleLineFinish_ = nil
			arg_243_1.state_ = "waiting"
		end

		function arg_243_1.playNext_(arg_245_0)
			if arg_245_0 == 1 then
				arg_243_0:Play411051061(arg_243_1)
			end
		end

		function arg_243_1.onSingleLineUpdate_(arg_246_0)
			local var_246_0 = 0
			local var_246_1 = 0.15

			if var_246_0 < arg_243_1.time_ and arg_243_1.time_ <= var_246_0 + arg_246_0 then
				arg_243_1.talkMaxDuration = 0
				arg_243_1.dialogCg_.alpha = 1

				arg_243_1.dialog_:SetActive(true)
				SetActive(arg_243_1.leftNameGo_, true)

				local var_246_2 = arg_243_1:FormatText(StoryNameCfg[264].name)

				arg_243_1.leftNameTxt_.text = var_246_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_243_1.leftNameTxt_.transform)

				arg_243_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_243_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_243_1:RecordName(arg_243_1.leftNameTxt_.text)
				SetActive(arg_243_1.iconTrs_.gameObject, false)
				arg_243_1.callingController_:SetSelectedState("normal")

				local var_246_3 = arg_243_1:GetWordFromCfg(411051060)
				local var_246_4 = arg_243_1:FormatText(var_246_3.content)

				arg_243_1.text_.text = var_246_4

				LuaForUtil.ClearLinePrefixSymbol(arg_243_1.text_)

				local var_246_5 = 6
				local var_246_6 = utf8.len(var_246_4)
				local var_246_7 = var_246_5 <= 0 and var_246_1 or var_246_1 * (var_246_6 / var_246_5)

				if var_246_7 > 0 and var_246_1 < var_246_7 then
					arg_243_1.talkMaxDuration = var_246_7

					if var_246_7 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_7 + var_246_0
					end
				end

				arg_243_1.text_.text = var_246_4
				arg_243_1.typewritter.percent = 0

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") ~= 0 then
					local var_246_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051060", "story_v_out_411051.awb") / 1000

					if var_246_8 + var_246_0 > arg_243_1.duration_ then
						arg_243_1.duration_ = var_246_8 + var_246_0
					end

					if var_246_3.prefab_name ~= "" and arg_243_1.actors_[var_246_3.prefab_name] ~= nil then
						local var_246_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_243_1.actors_[var_246_3.prefab_name].transform, "story_v_out_411051", "411051060", "story_v_out_411051.awb")

						arg_243_1:RecordAudio("411051060", var_246_9)
						arg_243_1:RecordAudio("411051060", var_246_9)
					else
						arg_243_1:AudioAction("play", "voice", "story_v_out_411051", "411051060", "story_v_out_411051.awb")
					end

					arg_243_1:RecordHistoryTalkVoice("story_v_out_411051", "411051060", "story_v_out_411051.awb")
				end

				arg_243_1:RecordContent(arg_243_1.text_.text)
			end

			local var_246_10 = math.max(var_246_1, arg_243_1.talkMaxDuration)

			if var_246_0 <= arg_243_1.time_ and arg_243_1.time_ < var_246_0 + var_246_10 then
				arg_243_1.typewritter.percent = (arg_243_1.time_ - var_246_0) / var_246_10

				arg_243_1.typewritter:SetDirty()
			end

			if arg_243_1.time_ >= var_246_0 + var_246_10 and arg_243_1.time_ < var_246_0 + var_246_10 + arg_246_0 then
				arg_243_1.typewritter.percent = 1

				arg_243_1.typewritter:SetDirty()
				arg_243_1:ShowNextGo(true)
			end
		end
	end,
	Play411051061 = function(arg_247_0, arg_247_1)
		arg_247_1.time_ = 0
		arg_247_1.frameCnt_ = 0
		arg_247_1.state_ = "playing"
		arg_247_1.curTalkId_ = 411051061
		arg_247_1.duration_ = 3.966

		local var_247_0 = {
			zh = 3.7,
			ja = 3.966
		}
		local var_247_1 = manager.audio:GetLocalizationFlag()

		if var_247_0[var_247_1] ~= nil then
			arg_247_1.duration_ = var_247_0[var_247_1]
		end

		SetActive(arg_247_1.tipsGo_, false)

		function arg_247_1.onSingleLineFinish_()
			arg_247_1.onSingleLineUpdate_ = nil
			arg_247_1.onSingleLineFinish_ = nil
			arg_247_1.state_ = "waiting"
		end

		function arg_247_1.playNext_(arg_249_0)
			if arg_249_0 == 1 then
				arg_247_0:Play411051062(arg_247_1)
			end
		end

		function arg_247_1.onSingleLineUpdate_(arg_250_0)
			local var_250_0 = arg_247_1.actors_["10014ui_story"]
			local var_250_1 = 0

			if var_250_1 < arg_247_1.time_ and arg_247_1.time_ <= var_250_1 + arg_250_0 and arg_247_1.var_.characterEffect10014ui_story == nil then
				arg_247_1.var_.characterEffect10014ui_story = var_250_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_2 = 0.200000002980232

			if var_250_1 <= arg_247_1.time_ and arg_247_1.time_ < var_250_1 + var_250_2 then
				local var_250_3 = (arg_247_1.time_ - var_250_1) / var_250_2

				if arg_247_1.var_.characterEffect10014ui_story then
					local var_250_4 = Mathf.Lerp(0, 0.5, var_250_3)

					arg_247_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_247_1.var_.characterEffect10014ui_story.fillRatio = var_250_4
				end
			end

			if arg_247_1.time_ >= var_250_1 + var_250_2 and arg_247_1.time_ < var_250_1 + var_250_2 + arg_250_0 and arg_247_1.var_.characterEffect10014ui_story then
				local var_250_5 = 0.5

				arg_247_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_247_1.var_.characterEffect10014ui_story.fillRatio = var_250_5
			end

			local var_250_6 = arg_247_1.actors_["10058ui_story"]
			local var_250_7 = 0

			if var_250_7 < arg_247_1.time_ and arg_247_1.time_ <= var_250_7 + arg_250_0 and arg_247_1.var_.characterEffect10058ui_story == nil then
				arg_247_1.var_.characterEffect10058ui_story = var_250_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_250_8 = 0.200000002980232

			if var_250_7 <= arg_247_1.time_ and arg_247_1.time_ < var_250_7 + var_250_8 then
				local var_250_9 = (arg_247_1.time_ - var_250_7) / var_250_8

				if arg_247_1.var_.characterEffect10058ui_story then
					arg_247_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_247_1.time_ >= var_250_7 + var_250_8 and arg_247_1.time_ < var_250_7 + var_250_8 + arg_250_0 and arg_247_1.var_.characterEffect10058ui_story then
				arg_247_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_250_10 = 0
			local var_250_11 = 0.45

			if var_250_10 < arg_247_1.time_ and arg_247_1.time_ <= var_250_10 + arg_250_0 then
				arg_247_1.talkMaxDuration = 0
				arg_247_1.dialogCg_.alpha = 1

				arg_247_1.dialog_:SetActive(true)
				SetActive(arg_247_1.leftNameGo_, true)

				local var_250_12 = arg_247_1:FormatText(StoryNameCfg[471].name)

				arg_247_1.leftNameTxt_.text = var_250_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_247_1.leftNameTxt_.transform)

				arg_247_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_247_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_247_1:RecordName(arg_247_1.leftNameTxt_.text)
				SetActive(arg_247_1.iconTrs_.gameObject, false)
				arg_247_1.callingController_:SetSelectedState("normal")

				local var_250_13 = arg_247_1:GetWordFromCfg(411051061)
				local var_250_14 = arg_247_1:FormatText(var_250_13.content)

				arg_247_1.text_.text = var_250_14

				LuaForUtil.ClearLinePrefixSymbol(arg_247_1.text_)

				local var_250_15 = 18
				local var_250_16 = utf8.len(var_250_14)
				local var_250_17 = var_250_15 <= 0 and var_250_11 or var_250_11 * (var_250_16 / var_250_15)

				if var_250_17 > 0 and var_250_11 < var_250_17 then
					arg_247_1.talkMaxDuration = var_250_17

					if var_250_17 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_17 + var_250_10
					end
				end

				arg_247_1.text_.text = var_250_14
				arg_247_1.typewritter.percent = 0

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") ~= 0 then
					local var_250_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051061", "story_v_out_411051.awb") / 1000

					if var_250_18 + var_250_10 > arg_247_1.duration_ then
						arg_247_1.duration_ = var_250_18 + var_250_10
					end

					if var_250_13.prefab_name ~= "" and arg_247_1.actors_[var_250_13.prefab_name] ~= nil then
						local var_250_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_247_1.actors_[var_250_13.prefab_name].transform, "story_v_out_411051", "411051061", "story_v_out_411051.awb")

						arg_247_1:RecordAudio("411051061", var_250_19)
						arg_247_1:RecordAudio("411051061", var_250_19)
					else
						arg_247_1:AudioAction("play", "voice", "story_v_out_411051", "411051061", "story_v_out_411051.awb")
					end

					arg_247_1:RecordHistoryTalkVoice("story_v_out_411051", "411051061", "story_v_out_411051.awb")
				end

				arg_247_1:RecordContent(arg_247_1.text_.text)
			end

			local var_250_20 = math.max(var_250_11, arg_247_1.talkMaxDuration)

			if var_250_10 <= arg_247_1.time_ and arg_247_1.time_ < var_250_10 + var_250_20 then
				arg_247_1.typewritter.percent = (arg_247_1.time_ - var_250_10) / var_250_20

				arg_247_1.typewritter:SetDirty()
			end

			if arg_247_1.time_ >= var_250_10 + var_250_20 and arg_247_1.time_ < var_250_10 + var_250_20 + arg_250_0 then
				arg_247_1.typewritter.percent = 1

				arg_247_1.typewritter:SetDirty()
				arg_247_1:ShowNextGo(true)
			end
		end
	end,
	Play411051062 = function(arg_251_0, arg_251_1)
		arg_251_1.time_ = 0
		arg_251_1.frameCnt_ = 0
		arg_251_1.state_ = "playing"
		arg_251_1.curTalkId_ = 411051062
		arg_251_1.duration_ = 3.733

		local var_251_0 = {
			zh = 2.1,
			ja = 3.733
		}
		local var_251_1 = manager.audio:GetLocalizationFlag()

		if var_251_0[var_251_1] ~= nil then
			arg_251_1.duration_ = var_251_0[var_251_1]
		end

		SetActive(arg_251_1.tipsGo_, false)

		function arg_251_1.onSingleLineFinish_()
			arg_251_1.onSingleLineUpdate_ = nil
			arg_251_1.onSingleLineFinish_ = nil
			arg_251_1.state_ = "waiting"
		end

		function arg_251_1.playNext_(arg_253_0)
			if arg_253_0 == 1 then
				arg_251_0:Play411051063(arg_251_1)
			end
		end

		function arg_251_1.onSingleLineUpdate_(arg_254_0)
			local var_254_0 = arg_251_1.actors_["10058ui_story"].transform
			local var_254_1 = 0

			if var_254_1 < arg_251_1.time_ and arg_251_1.time_ <= var_254_1 + arg_254_0 then
				arg_251_1.var_.moveOldPos10058ui_story = var_254_0.localPosition
			end

			local var_254_2 = 0.001

			if var_254_1 <= arg_251_1.time_ and arg_251_1.time_ < var_254_1 + var_254_2 then
				local var_254_3 = (arg_251_1.time_ - var_254_1) / var_254_2
				local var_254_4 = Vector3.New(-0.7, -0.98, -6.1)

				var_254_0.localPosition = Vector3.Lerp(arg_251_1.var_.moveOldPos10058ui_story, var_254_4, var_254_3)

				local var_254_5 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_5.x, var_254_5.y, var_254_5.z)

				local var_254_6 = var_254_0.localEulerAngles

				var_254_6.z = 0
				var_254_6.x = 0
				var_254_0.localEulerAngles = var_254_6
			end

			if arg_251_1.time_ >= var_254_1 + var_254_2 and arg_251_1.time_ < var_254_1 + var_254_2 + arg_254_0 then
				var_254_0.localPosition = Vector3.New(-0.7, -0.98, -6.1)

				local var_254_7 = manager.ui.mainCamera.transform.position - var_254_0.position

				var_254_0.forward = Vector3.New(var_254_7.x, var_254_7.y, var_254_7.z)

				local var_254_8 = var_254_0.localEulerAngles

				var_254_8.z = 0
				var_254_8.x = 0
				var_254_0.localEulerAngles = var_254_8
			end

			local var_254_9 = 0

			if var_254_9 < arg_251_1.time_ and arg_251_1.time_ <= var_254_9 + arg_254_0 then
				arg_251_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_254_10 = 0
			local var_254_11 = 0.325

			if var_254_10 < arg_251_1.time_ and arg_251_1.time_ <= var_254_10 + arg_254_0 then
				arg_251_1.talkMaxDuration = 0
				arg_251_1.dialogCg_.alpha = 1

				arg_251_1.dialog_:SetActive(true)
				SetActive(arg_251_1.leftNameGo_, true)

				local var_254_12 = arg_251_1:FormatText(StoryNameCfg[471].name)

				arg_251_1.leftNameTxt_.text = var_254_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_251_1.leftNameTxt_.transform)

				arg_251_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_251_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_251_1:RecordName(arg_251_1.leftNameTxt_.text)
				SetActive(arg_251_1.iconTrs_.gameObject, false)
				arg_251_1.callingController_:SetSelectedState("normal")

				local var_254_13 = arg_251_1:GetWordFromCfg(411051062)
				local var_254_14 = arg_251_1:FormatText(var_254_13.content)

				arg_251_1.text_.text = var_254_14

				LuaForUtil.ClearLinePrefixSymbol(arg_251_1.text_)

				local var_254_15 = 13
				local var_254_16 = utf8.len(var_254_14)
				local var_254_17 = var_254_15 <= 0 and var_254_11 or var_254_11 * (var_254_16 / var_254_15)

				if var_254_17 > 0 and var_254_11 < var_254_17 then
					arg_251_1.talkMaxDuration = var_254_17

					if var_254_17 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_17 + var_254_10
					end
				end

				arg_251_1.text_.text = var_254_14
				arg_251_1.typewritter.percent = 0

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") ~= 0 then
					local var_254_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051062", "story_v_out_411051.awb") / 1000

					if var_254_18 + var_254_10 > arg_251_1.duration_ then
						arg_251_1.duration_ = var_254_18 + var_254_10
					end

					if var_254_13.prefab_name ~= "" and arg_251_1.actors_[var_254_13.prefab_name] ~= nil then
						local var_254_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_251_1.actors_[var_254_13.prefab_name].transform, "story_v_out_411051", "411051062", "story_v_out_411051.awb")

						arg_251_1:RecordAudio("411051062", var_254_19)
						arg_251_1:RecordAudio("411051062", var_254_19)
					else
						arg_251_1:AudioAction("play", "voice", "story_v_out_411051", "411051062", "story_v_out_411051.awb")
					end

					arg_251_1:RecordHistoryTalkVoice("story_v_out_411051", "411051062", "story_v_out_411051.awb")
				end

				arg_251_1:RecordContent(arg_251_1.text_.text)
			end

			local var_254_20 = math.max(var_254_11, arg_251_1.talkMaxDuration)

			if var_254_10 <= arg_251_1.time_ and arg_251_1.time_ < var_254_10 + var_254_20 then
				arg_251_1.typewritter.percent = (arg_251_1.time_ - var_254_10) / var_254_20

				arg_251_1.typewritter:SetDirty()
			end

			if arg_251_1.time_ >= var_254_10 + var_254_20 and arg_251_1.time_ < var_254_10 + var_254_20 + arg_254_0 then
				arg_251_1.typewritter.percent = 1

				arg_251_1.typewritter:SetDirty()
				arg_251_1:ShowNextGo(true)
			end
		end
	end,
	Play411051063 = function(arg_255_0, arg_255_1)
		arg_255_1.time_ = 0
		arg_255_1.frameCnt_ = 0
		arg_255_1.state_ = "playing"
		arg_255_1.curTalkId_ = 411051063
		arg_255_1.duration_ = 14.466

		local var_255_0 = {
			zh = 7,
			ja = 14.466
		}
		local var_255_1 = manager.audio:GetLocalizationFlag()

		if var_255_0[var_255_1] ~= nil then
			arg_255_1.duration_ = var_255_0[var_255_1]
		end

		SetActive(arg_255_1.tipsGo_, false)

		function arg_255_1.onSingleLineFinish_()
			arg_255_1.onSingleLineUpdate_ = nil
			arg_255_1.onSingleLineFinish_ = nil
			arg_255_1.state_ = "waiting"
		end

		function arg_255_1.playNext_(arg_257_0)
			if arg_257_0 == 1 then
				arg_255_0:Play411051064(arg_255_1)
			end
		end

		function arg_255_1.onSingleLineUpdate_(arg_258_0)
			local var_258_0 = arg_255_1.actors_["10058ui_story"]
			local var_258_1 = 0

			if var_258_1 < arg_255_1.time_ and arg_255_1.time_ <= var_258_1 + arg_258_0 and arg_255_1.var_.characterEffect10058ui_story == nil then
				arg_255_1.var_.characterEffect10058ui_story = var_258_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_2 = 0.200000002980232

			if var_258_1 <= arg_255_1.time_ and arg_255_1.time_ < var_258_1 + var_258_2 then
				local var_258_3 = (arg_255_1.time_ - var_258_1) / var_258_2

				if arg_255_1.var_.characterEffect10058ui_story then
					local var_258_4 = Mathf.Lerp(0, 0.5, var_258_3)

					arg_255_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_255_1.var_.characterEffect10058ui_story.fillRatio = var_258_4
				end
			end

			if arg_255_1.time_ >= var_258_1 + var_258_2 and arg_255_1.time_ < var_258_1 + var_258_2 + arg_258_0 and arg_255_1.var_.characterEffect10058ui_story then
				local var_258_5 = 0.5

				arg_255_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_255_1.var_.characterEffect10058ui_story.fillRatio = var_258_5
			end

			local var_258_6 = arg_255_1.actors_["10014ui_story"]
			local var_258_7 = 0

			if var_258_7 < arg_255_1.time_ and arg_255_1.time_ <= var_258_7 + arg_258_0 and arg_255_1.var_.characterEffect10014ui_story == nil then
				arg_255_1.var_.characterEffect10014ui_story = var_258_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_258_8 = 0.200000002980232

			if var_258_7 <= arg_255_1.time_ and arg_255_1.time_ < var_258_7 + var_258_8 then
				local var_258_9 = (arg_255_1.time_ - var_258_7) / var_258_8

				if arg_255_1.var_.characterEffect10014ui_story then
					arg_255_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_255_1.time_ >= var_258_7 + var_258_8 and arg_255_1.time_ < var_258_7 + var_258_8 + arg_258_0 and arg_255_1.var_.characterEffect10014ui_story then
				arg_255_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_258_10 = 0
			local var_258_11 = 0.825

			if var_258_10 < arg_255_1.time_ and arg_255_1.time_ <= var_258_10 + arg_258_0 then
				arg_255_1.talkMaxDuration = 0
				arg_255_1.dialogCg_.alpha = 1

				arg_255_1.dialog_:SetActive(true)
				SetActive(arg_255_1.leftNameGo_, true)

				local var_258_12 = arg_255_1:FormatText(StoryNameCfg[264].name)

				arg_255_1.leftNameTxt_.text = var_258_12

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_255_1.leftNameTxt_.transform)

				arg_255_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_255_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_255_1:RecordName(arg_255_1.leftNameTxt_.text)
				SetActive(arg_255_1.iconTrs_.gameObject, false)
				arg_255_1.callingController_:SetSelectedState("normal")

				local var_258_13 = arg_255_1:GetWordFromCfg(411051063)
				local var_258_14 = arg_255_1:FormatText(var_258_13.content)

				arg_255_1.text_.text = var_258_14

				LuaForUtil.ClearLinePrefixSymbol(arg_255_1.text_)

				local var_258_15 = 33
				local var_258_16 = utf8.len(var_258_14)
				local var_258_17 = var_258_15 <= 0 and var_258_11 or var_258_11 * (var_258_16 / var_258_15)

				if var_258_17 > 0 and var_258_11 < var_258_17 then
					arg_255_1.talkMaxDuration = var_258_17

					if var_258_17 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_17 + var_258_10
					end
				end

				arg_255_1.text_.text = var_258_14
				arg_255_1.typewritter.percent = 0

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") ~= 0 then
					local var_258_18 = manager.audio:GetVoiceLength("story_v_out_411051", "411051063", "story_v_out_411051.awb") / 1000

					if var_258_18 + var_258_10 > arg_255_1.duration_ then
						arg_255_1.duration_ = var_258_18 + var_258_10
					end

					if var_258_13.prefab_name ~= "" and arg_255_1.actors_[var_258_13.prefab_name] ~= nil then
						local var_258_19 = LuaForUtil.PlayVoiceWithCriLipsync(arg_255_1.actors_[var_258_13.prefab_name].transform, "story_v_out_411051", "411051063", "story_v_out_411051.awb")

						arg_255_1:RecordAudio("411051063", var_258_19)
						arg_255_1:RecordAudio("411051063", var_258_19)
					else
						arg_255_1:AudioAction("play", "voice", "story_v_out_411051", "411051063", "story_v_out_411051.awb")
					end

					arg_255_1:RecordHistoryTalkVoice("story_v_out_411051", "411051063", "story_v_out_411051.awb")
				end

				arg_255_1:RecordContent(arg_255_1.text_.text)
			end

			local var_258_20 = math.max(var_258_11, arg_255_1.talkMaxDuration)

			if var_258_10 <= arg_255_1.time_ and arg_255_1.time_ < var_258_10 + var_258_20 then
				arg_255_1.typewritter.percent = (arg_255_1.time_ - var_258_10) / var_258_20

				arg_255_1.typewritter:SetDirty()
			end

			if arg_255_1.time_ >= var_258_10 + var_258_20 and arg_255_1.time_ < var_258_10 + var_258_20 + arg_258_0 then
				arg_255_1.typewritter.percent = 1

				arg_255_1.typewritter:SetDirty()
				arg_255_1:ShowNextGo(true)
			end
		end
	end,
	Play411051064 = function(arg_259_0, arg_259_1)
		arg_259_1.time_ = 0
		arg_259_1.frameCnt_ = 0
		arg_259_1.state_ = "playing"
		arg_259_1.curTalkId_ = 411051064
		arg_259_1.duration_ = 5.5

		local var_259_0 = {
			zh = 4.8,
			ja = 5.5
		}
		local var_259_1 = manager.audio:GetLocalizationFlag()

		if var_259_0[var_259_1] ~= nil then
			arg_259_1.duration_ = var_259_0[var_259_1]
		end

		SetActive(arg_259_1.tipsGo_, false)

		function arg_259_1.onSingleLineFinish_()
			arg_259_1.onSingleLineUpdate_ = nil
			arg_259_1.onSingleLineFinish_ = nil
			arg_259_1.state_ = "waiting"
		end

		function arg_259_1.playNext_(arg_261_0)
			if arg_261_0 == 1 then
				arg_259_0:Play411051065(arg_259_1)
			end
		end

		function arg_259_1.onSingleLineUpdate_(arg_262_0)
			local var_262_0 = arg_259_1.actors_["10058ui_story"]
			local var_262_1 = 0

			if var_262_1 < arg_259_1.time_ and arg_259_1.time_ <= var_262_1 + arg_262_0 and arg_259_1.var_.characterEffect10058ui_story == nil then
				arg_259_1.var_.characterEffect10058ui_story = var_262_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_2 = 0.200000002980232

			if var_262_1 <= arg_259_1.time_ and arg_259_1.time_ < var_262_1 + var_262_2 then
				local var_262_3 = (arg_259_1.time_ - var_262_1) / var_262_2

				if arg_259_1.var_.characterEffect10058ui_story then
					arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_259_1.time_ >= var_262_1 + var_262_2 and arg_259_1.time_ < var_262_1 + var_262_2 + arg_262_0 and arg_259_1.var_.characterEffect10058ui_story then
				arg_259_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_262_4 = 0

			if var_262_4 < arg_259_1.time_ and arg_259_1.time_ <= var_262_4 + arg_262_0 then
				arg_259_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface2101cva")
			end

			local var_262_5 = arg_259_1.actors_["10014ui_story"]
			local var_262_6 = 0

			if var_262_6 < arg_259_1.time_ and arg_259_1.time_ <= var_262_6 + arg_262_0 and arg_259_1.var_.characterEffect10014ui_story == nil then
				arg_259_1.var_.characterEffect10014ui_story = var_262_5:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_262_7 = 0.200000002980232

			if var_262_6 <= arg_259_1.time_ and arg_259_1.time_ < var_262_6 + var_262_7 then
				local var_262_8 = (arg_259_1.time_ - var_262_6) / var_262_7

				if arg_259_1.var_.characterEffect10014ui_story then
					local var_262_9 = Mathf.Lerp(0, 0.5, var_262_8)

					arg_259_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_259_1.var_.characterEffect10014ui_story.fillRatio = var_262_9
				end
			end

			if arg_259_1.time_ >= var_262_6 + var_262_7 and arg_259_1.time_ < var_262_6 + var_262_7 + arg_262_0 and arg_259_1.var_.characterEffect10014ui_story then
				local var_262_10 = 0.5

				arg_259_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_259_1.var_.characterEffect10014ui_story.fillRatio = var_262_10
			end

			local var_262_11 = 0
			local var_262_12 = 0.525

			if var_262_11 < arg_259_1.time_ and arg_259_1.time_ <= var_262_11 + arg_262_0 then
				arg_259_1.talkMaxDuration = 0
				arg_259_1.dialogCg_.alpha = 1

				arg_259_1.dialog_:SetActive(true)
				SetActive(arg_259_1.leftNameGo_, true)

				local var_262_13 = arg_259_1:FormatText(StoryNameCfg[471].name)

				arg_259_1.leftNameTxt_.text = var_262_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_259_1.leftNameTxt_.transform)

				arg_259_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_259_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_259_1:RecordName(arg_259_1.leftNameTxt_.text)
				SetActive(arg_259_1.iconTrs_.gameObject, false)
				arg_259_1.callingController_:SetSelectedState("normal")

				local var_262_14 = arg_259_1:GetWordFromCfg(411051064)
				local var_262_15 = arg_259_1:FormatText(var_262_14.content)

				arg_259_1.text_.text = var_262_15

				LuaForUtil.ClearLinePrefixSymbol(arg_259_1.text_)

				local var_262_16 = 21
				local var_262_17 = utf8.len(var_262_15)
				local var_262_18 = var_262_16 <= 0 and var_262_12 or var_262_12 * (var_262_17 / var_262_16)

				if var_262_18 > 0 and var_262_12 < var_262_18 then
					arg_259_1.talkMaxDuration = var_262_18

					if var_262_18 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_18 + var_262_11
					end
				end

				arg_259_1.text_.text = var_262_15
				arg_259_1.typewritter.percent = 0

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") ~= 0 then
					local var_262_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051064", "story_v_out_411051.awb") / 1000

					if var_262_19 + var_262_11 > arg_259_1.duration_ then
						arg_259_1.duration_ = var_262_19 + var_262_11
					end

					if var_262_14.prefab_name ~= "" and arg_259_1.actors_[var_262_14.prefab_name] ~= nil then
						local var_262_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_259_1.actors_[var_262_14.prefab_name].transform, "story_v_out_411051", "411051064", "story_v_out_411051.awb")

						arg_259_1:RecordAudio("411051064", var_262_20)
						arg_259_1:RecordAudio("411051064", var_262_20)
					else
						arg_259_1:AudioAction("play", "voice", "story_v_out_411051", "411051064", "story_v_out_411051.awb")
					end

					arg_259_1:RecordHistoryTalkVoice("story_v_out_411051", "411051064", "story_v_out_411051.awb")
				end

				arg_259_1:RecordContent(arg_259_1.text_.text)
			end

			local var_262_21 = math.max(var_262_12, arg_259_1.talkMaxDuration)

			if var_262_11 <= arg_259_1.time_ and arg_259_1.time_ < var_262_11 + var_262_21 then
				arg_259_1.typewritter.percent = (arg_259_1.time_ - var_262_11) / var_262_21

				arg_259_1.typewritter:SetDirty()
			end

			if arg_259_1.time_ >= var_262_11 + var_262_21 and arg_259_1.time_ < var_262_11 + var_262_21 + arg_262_0 then
				arg_259_1.typewritter.percent = 1

				arg_259_1.typewritter:SetDirty()
				arg_259_1:ShowNextGo(true)
			end
		end
	end,
	Play411051065 = function(arg_263_0, arg_263_1)
		arg_263_1.time_ = 0
		arg_263_1.frameCnt_ = 0
		arg_263_1.state_ = "playing"
		arg_263_1.curTalkId_ = 411051065
		arg_263_1.duration_ = 9.3

		local var_263_0 = {
			zh = 4.1,
			ja = 9.3
		}
		local var_263_1 = manager.audio:GetLocalizationFlag()

		if var_263_0[var_263_1] ~= nil then
			arg_263_1.duration_ = var_263_0[var_263_1]
		end

		SetActive(arg_263_1.tipsGo_, false)

		function arg_263_1.onSingleLineFinish_()
			arg_263_1.onSingleLineUpdate_ = nil
			arg_263_1.onSingleLineFinish_ = nil
			arg_263_1.state_ = "waiting"
		end

		function arg_263_1.playNext_(arg_265_0)
			if arg_265_0 == 1 then
				arg_263_0:Play411051066(arg_263_1)
			end
		end

		function arg_263_1.onSingleLineUpdate_(arg_266_0)
			local var_266_0 = arg_263_1.actors_["10014ui_story"]
			local var_266_1 = 0

			if var_266_1 < arg_263_1.time_ and arg_263_1.time_ <= var_266_1 + arg_266_0 and arg_263_1.var_.characterEffect10014ui_story == nil then
				arg_263_1.var_.characterEffect10014ui_story = var_266_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_2 = 0.200000002980232

			if var_266_1 <= arg_263_1.time_ and arg_263_1.time_ < var_266_1 + var_266_2 then
				local var_266_3 = (arg_263_1.time_ - var_266_1) / var_266_2

				if arg_263_1.var_.characterEffect10014ui_story then
					arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
				end
			end

			if arg_263_1.time_ >= var_266_1 + var_266_2 and arg_263_1.time_ < var_266_1 + var_266_2 + arg_266_0 and arg_263_1.var_.characterEffect10014ui_story then
				arg_263_1.var_.characterEffect10014ui_story.fillFlat = false
			end

			local var_266_4 = 0

			if var_266_4 < arg_263_1.time_ and arg_263_1.time_ <= var_266_4 + arg_266_0 then
				arg_263_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/story10014/story10014action/10014action5_1")
			end

			local var_266_5 = 0

			if var_266_5 < arg_263_1.time_ and arg_263_1.time_ <= var_266_5 + arg_266_0 then
				arg_263_1:PlayTimeline("10014ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_266_6 = arg_263_1.actors_["10058ui_story"]
			local var_266_7 = 0

			if var_266_7 < arg_263_1.time_ and arg_263_1.time_ <= var_266_7 + arg_266_0 and arg_263_1.var_.characterEffect10058ui_story == nil then
				arg_263_1.var_.characterEffect10058ui_story = var_266_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_266_8 = 0.200000002980232

			if var_266_7 <= arg_263_1.time_ and arg_263_1.time_ < var_266_7 + var_266_8 then
				local var_266_9 = (arg_263_1.time_ - var_266_7) / var_266_8

				if arg_263_1.var_.characterEffect10058ui_story then
					local var_266_10 = Mathf.Lerp(0, 0.5, var_266_9)

					arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_263_1.var_.characterEffect10058ui_story.fillRatio = var_266_10
				end
			end

			if arg_263_1.time_ >= var_266_7 + var_266_8 and arg_263_1.time_ < var_266_7 + var_266_8 + arg_266_0 and arg_263_1.var_.characterEffect10058ui_story then
				local var_266_11 = 0.5

				arg_263_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_263_1.var_.characterEffect10058ui_story.fillRatio = var_266_11
			end

			local var_266_12 = 0
			local var_266_13 = 0.475

			if var_266_12 < arg_263_1.time_ and arg_263_1.time_ <= var_266_12 + arg_266_0 then
				arg_263_1.talkMaxDuration = 0
				arg_263_1.dialogCg_.alpha = 1

				arg_263_1.dialog_:SetActive(true)
				SetActive(arg_263_1.leftNameGo_, true)

				local var_266_14 = arg_263_1:FormatText(StoryNameCfg[264].name)

				arg_263_1.leftNameTxt_.text = var_266_14

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_263_1.leftNameTxt_.transform)

				arg_263_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_263_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_263_1:RecordName(arg_263_1.leftNameTxt_.text)
				SetActive(arg_263_1.iconTrs_.gameObject, false)
				arg_263_1.callingController_:SetSelectedState("normal")

				local var_266_15 = arg_263_1:GetWordFromCfg(411051065)
				local var_266_16 = arg_263_1:FormatText(var_266_15.content)

				arg_263_1.text_.text = var_266_16

				LuaForUtil.ClearLinePrefixSymbol(arg_263_1.text_)

				local var_266_17 = 19
				local var_266_18 = utf8.len(var_266_16)
				local var_266_19 = var_266_17 <= 0 and var_266_13 or var_266_13 * (var_266_18 / var_266_17)

				if var_266_19 > 0 and var_266_13 < var_266_19 then
					arg_263_1.talkMaxDuration = var_266_19

					if var_266_19 + var_266_12 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_19 + var_266_12
					end
				end

				arg_263_1.text_.text = var_266_16
				arg_263_1.typewritter.percent = 0

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") ~= 0 then
					local var_266_20 = manager.audio:GetVoiceLength("story_v_out_411051", "411051065", "story_v_out_411051.awb") / 1000

					if var_266_20 + var_266_12 > arg_263_1.duration_ then
						arg_263_1.duration_ = var_266_20 + var_266_12
					end

					if var_266_15.prefab_name ~= "" and arg_263_1.actors_[var_266_15.prefab_name] ~= nil then
						local var_266_21 = LuaForUtil.PlayVoiceWithCriLipsync(arg_263_1.actors_[var_266_15.prefab_name].transform, "story_v_out_411051", "411051065", "story_v_out_411051.awb")

						arg_263_1:RecordAudio("411051065", var_266_21)
						arg_263_1:RecordAudio("411051065", var_266_21)
					else
						arg_263_1:AudioAction("play", "voice", "story_v_out_411051", "411051065", "story_v_out_411051.awb")
					end

					arg_263_1:RecordHistoryTalkVoice("story_v_out_411051", "411051065", "story_v_out_411051.awb")
				end

				arg_263_1:RecordContent(arg_263_1.text_.text)
			end

			local var_266_22 = math.max(var_266_13, arg_263_1.talkMaxDuration)

			if var_266_12 <= arg_263_1.time_ and arg_263_1.time_ < var_266_12 + var_266_22 then
				arg_263_1.typewritter.percent = (arg_263_1.time_ - var_266_12) / var_266_22

				arg_263_1.typewritter:SetDirty()
			end

			if arg_263_1.time_ >= var_266_12 + var_266_22 and arg_263_1.time_ < var_266_12 + var_266_22 + arg_266_0 then
				arg_263_1.typewritter.percent = 1

				arg_263_1.typewritter:SetDirty()
				arg_263_1:ShowNextGo(true)
			end
		end
	end,
	Play411051066 = function(arg_267_0, arg_267_1)
		arg_267_1.time_ = 0
		arg_267_1.frameCnt_ = 0
		arg_267_1.state_ = "playing"
		arg_267_1.curTalkId_ = 411051066
		arg_267_1.duration_ = 3.433

		local var_267_0 = {
			zh = 2.833,
			ja = 3.433
		}
		local var_267_1 = manager.audio:GetLocalizationFlag()

		if var_267_0[var_267_1] ~= nil then
			arg_267_1.duration_ = var_267_0[var_267_1]
		end

		SetActive(arg_267_1.tipsGo_, false)

		function arg_267_1.onSingleLineFinish_()
			arg_267_1.onSingleLineUpdate_ = nil
			arg_267_1.onSingleLineFinish_ = nil
			arg_267_1.state_ = "waiting"
		end

		function arg_267_1.playNext_(arg_269_0)
			if arg_269_0 == 1 then
				arg_267_0:Play411051067(arg_267_1)
			end
		end

		function arg_267_1.onSingleLineUpdate_(arg_270_0)
			local var_270_0 = arg_267_1.actors_["10014ui_story"]
			local var_270_1 = 0

			if var_270_1 < arg_267_1.time_ and arg_267_1.time_ <= var_270_1 + arg_270_0 and arg_267_1.var_.characterEffect10014ui_story == nil then
				arg_267_1.var_.characterEffect10014ui_story = var_270_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_2 = 0.200000002980232

			if var_270_1 <= arg_267_1.time_ and arg_267_1.time_ < var_270_1 + var_270_2 then
				local var_270_3 = (arg_267_1.time_ - var_270_1) / var_270_2

				if arg_267_1.var_.characterEffect10014ui_story then
					local var_270_4 = Mathf.Lerp(0, 0.5, var_270_3)

					arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_267_1.var_.characterEffect10014ui_story.fillRatio = var_270_4
				end
			end

			if arg_267_1.time_ >= var_270_1 + var_270_2 and arg_267_1.time_ < var_270_1 + var_270_2 + arg_270_0 and arg_267_1.var_.characterEffect10014ui_story then
				local var_270_5 = 0.5

				arg_267_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_267_1.var_.characterEffect10014ui_story.fillRatio = var_270_5
			end

			local var_270_6 = arg_267_1.actors_["10058ui_story"]
			local var_270_7 = 0

			if var_270_7 < arg_267_1.time_ and arg_267_1.time_ <= var_270_7 + arg_270_0 and arg_267_1.var_.characterEffect10058ui_story == nil then
				arg_267_1.var_.characterEffect10058ui_story = var_270_6:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_270_8 = 0.200000002980232

			if var_270_7 <= arg_267_1.time_ and arg_267_1.time_ < var_270_7 + var_270_8 then
				local var_270_9 = (arg_267_1.time_ - var_270_7) / var_270_8

				if arg_267_1.var_.characterEffect10058ui_story then
					arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_267_1.time_ >= var_270_7 + var_270_8 and arg_267_1.time_ < var_270_7 + var_270_8 + arg_270_0 and arg_267_1.var_.characterEffect10058ui_story then
				arg_267_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_270_10 = 0

			if var_270_10 < arg_267_1.time_ and arg_267_1.time_ <= var_270_10 + arg_270_0 then
				arg_267_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_270_11 = 0
			local var_270_12 = 0.275

			if var_270_11 < arg_267_1.time_ and arg_267_1.time_ <= var_270_11 + arg_270_0 then
				arg_267_1.talkMaxDuration = 0
				arg_267_1.dialogCg_.alpha = 1

				arg_267_1.dialog_:SetActive(true)
				SetActive(arg_267_1.leftNameGo_, true)

				local var_270_13 = arg_267_1:FormatText(StoryNameCfg[471].name)

				arg_267_1.leftNameTxt_.text = var_270_13

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_267_1.leftNameTxt_.transform)

				arg_267_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_267_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_267_1:RecordName(arg_267_1.leftNameTxt_.text)
				SetActive(arg_267_1.iconTrs_.gameObject, false)
				arg_267_1.callingController_:SetSelectedState("normal")

				local var_270_14 = arg_267_1:GetWordFromCfg(411051066)
				local var_270_15 = arg_267_1:FormatText(var_270_14.content)

				arg_267_1.text_.text = var_270_15

				LuaForUtil.ClearLinePrefixSymbol(arg_267_1.text_)

				local var_270_16 = 11
				local var_270_17 = utf8.len(var_270_15)
				local var_270_18 = var_270_16 <= 0 and var_270_12 or var_270_12 * (var_270_17 / var_270_16)

				if var_270_18 > 0 and var_270_12 < var_270_18 then
					arg_267_1.talkMaxDuration = var_270_18

					if var_270_18 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_18 + var_270_11
					end
				end

				arg_267_1.text_.text = var_270_15
				arg_267_1.typewritter.percent = 0

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") ~= 0 then
					local var_270_19 = manager.audio:GetVoiceLength("story_v_out_411051", "411051066", "story_v_out_411051.awb") / 1000

					if var_270_19 + var_270_11 > arg_267_1.duration_ then
						arg_267_1.duration_ = var_270_19 + var_270_11
					end

					if var_270_14.prefab_name ~= "" and arg_267_1.actors_[var_270_14.prefab_name] ~= nil then
						local var_270_20 = LuaForUtil.PlayVoiceWithCriLipsync(arg_267_1.actors_[var_270_14.prefab_name].transform, "story_v_out_411051", "411051066", "story_v_out_411051.awb")

						arg_267_1:RecordAudio("411051066", var_270_20)
						arg_267_1:RecordAudio("411051066", var_270_20)
					else
						arg_267_1:AudioAction("play", "voice", "story_v_out_411051", "411051066", "story_v_out_411051.awb")
					end

					arg_267_1:RecordHistoryTalkVoice("story_v_out_411051", "411051066", "story_v_out_411051.awb")
				end

				arg_267_1:RecordContent(arg_267_1.text_.text)
			end

			local var_270_21 = math.max(var_270_12, arg_267_1.talkMaxDuration)

			if var_270_11 <= arg_267_1.time_ and arg_267_1.time_ < var_270_11 + var_270_21 then
				arg_267_1.typewritter.percent = (arg_267_1.time_ - var_270_11) / var_270_21

				arg_267_1.typewritter:SetDirty()
			end

			if arg_267_1.time_ >= var_270_11 + var_270_21 and arg_267_1.time_ < var_270_11 + var_270_21 + arg_270_0 then
				arg_267_1.typewritter.percent = 1

				arg_267_1.typewritter:SetDirty()
				arg_267_1:ShowNextGo(true)
			end
		end
	end,
	Play411051067 = function(arg_271_0, arg_271_1)
		arg_271_1.time_ = 0
		arg_271_1.frameCnt_ = 0
		arg_271_1.state_ = "playing"
		arg_271_1.curTalkId_ = 411051067
		arg_271_1.duration_ = 9

		SetActive(arg_271_1.tipsGo_, false)

		function arg_271_1.onSingleLineFinish_()
			arg_271_1.onSingleLineUpdate_ = nil
			arg_271_1.onSingleLineFinish_ = nil
			arg_271_1.state_ = "waiting"
		end

		function arg_271_1.playNext_(arg_273_0)
			if arg_273_0 == 1 then
				arg_271_0:Play411051068(arg_271_1)
			end
		end

		function arg_271_1.onSingleLineUpdate_(arg_274_0)
			local var_274_0 = 2

			if var_274_0 < arg_271_1.time_ and arg_271_1.time_ <= var_274_0 + arg_274_0 then
				local var_274_1 = manager.ui.mainCamera.transform.localPosition
				local var_274_2 = Vector3.New(0, 0, 10) + Vector3.New(var_274_1.x, var_274_1.y, 0)
				local var_274_3 = arg_271_1.bgs_.ST03

				var_274_3.transform.localPosition = var_274_2
				var_274_3.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_4 = var_274_3:GetComponent("SpriteRenderer")

				if var_274_4 and var_274_4.sprite then
					local var_274_5 = (var_274_3.transform.localPosition - var_274_1).z
					local var_274_6 = manager.ui.mainCameraCom_
					local var_274_7 = 2 * var_274_5 * Mathf.Tan(var_274_6.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_8 = var_274_7 * var_274_6.aspect
					local var_274_9 = var_274_4.sprite.bounds.size.x
					local var_274_10 = var_274_4.sprite.bounds.size.y
					local var_274_11 = var_274_8 / var_274_9
					local var_274_12 = var_274_7 / var_274_10
					local var_274_13 = var_274_12 < var_274_11 and var_274_11 or var_274_12

					var_274_3.transform.localScale = Vector3.New(var_274_13, var_274_13, 0)
				end

				for iter_274_0, iter_274_1 in pairs(arg_271_1.bgs_) do
					if iter_274_0 ~= "ST03" then
						iter_274_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_14 = 0

			if var_274_14 < arg_271_1.time_ and arg_271_1.time_ <= var_274_14 + arg_274_0 then
				local var_274_15 = manager.ui.mainCamera.transform.localPosition
				local var_274_16 = Vector3.New(0, 0, 10) + Vector3.New(var_274_15.x, var_274_15.y, 0)
				local var_274_17 = arg_271_1.bgs_.I07

				var_274_17.transform.localPosition = var_274_16
				var_274_17.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_274_18 = var_274_17:GetComponent("SpriteRenderer")

				if var_274_18 and var_274_18.sprite then
					local var_274_19 = (var_274_17.transform.localPosition - var_274_15).z
					local var_274_20 = manager.ui.mainCameraCom_
					local var_274_21 = 2 * var_274_19 * Mathf.Tan(var_274_20.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_274_22 = var_274_21 * var_274_20.aspect
					local var_274_23 = var_274_18.sprite.bounds.size.x
					local var_274_24 = var_274_18.sprite.bounds.size.y
					local var_274_25 = var_274_22 / var_274_23
					local var_274_26 = var_274_21 / var_274_24
					local var_274_27 = var_274_26 < var_274_25 and var_274_25 or var_274_26

					var_274_17.transform.localScale = Vector3.New(var_274_27, var_274_27, 0)
				end

				for iter_274_2, iter_274_3 in pairs(arg_271_1.bgs_) do
					if iter_274_2 ~= "I07" then
						iter_274_3.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_274_28 = 0

			if var_274_28 < arg_271_1.time_ and arg_271_1.time_ <= var_274_28 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_29 = 2

			if var_274_28 <= arg_271_1.time_ and arg_271_1.time_ < var_274_28 + var_274_29 then
				local var_274_30 = (arg_271_1.time_ - var_274_28) / var_274_29
				local var_274_31 = Color.New(0, 0, 0)

				var_274_31.a = Mathf.Lerp(0, 1, var_274_30)
				arg_271_1.mask_.color = var_274_31
			end

			if arg_271_1.time_ >= var_274_28 + var_274_29 and arg_271_1.time_ < var_274_28 + var_274_29 + arg_274_0 then
				local var_274_32 = Color.New(0, 0, 0)

				var_274_32.a = 1
				arg_271_1.mask_.color = var_274_32
			end

			local var_274_33 = 2

			if var_274_33 < arg_271_1.time_ and arg_271_1.time_ <= var_274_33 + arg_274_0 then
				arg_271_1.mask_.enabled = true
				arg_271_1.mask_.raycastTarget = true

				arg_271_1:SetGaussion(false)
			end

			local var_274_34 = 2

			if var_274_33 <= arg_271_1.time_ and arg_271_1.time_ < var_274_33 + var_274_34 then
				local var_274_35 = (arg_271_1.time_ - var_274_33) / var_274_34
				local var_274_36 = Color.New(0, 0, 0)

				var_274_36.a = Mathf.Lerp(1, 0, var_274_35)
				arg_271_1.mask_.color = var_274_36
			end

			if arg_271_1.time_ >= var_274_33 + var_274_34 and arg_271_1.time_ < var_274_33 + var_274_34 + arg_274_0 then
				local var_274_37 = Color.New(0, 0, 0)
				local var_274_38 = 0

				arg_271_1.mask_.enabled = false
				var_274_37.a = var_274_38
				arg_271_1.mask_.color = var_274_37
			end

			local var_274_39 = arg_271_1.actors_["10058ui_story"]
			local var_274_40 = 2

			if var_274_40 < arg_271_1.time_ and arg_271_1.time_ <= var_274_40 + arg_274_0 and arg_271_1.var_.characterEffect10058ui_story == nil then
				arg_271_1.var_.characterEffect10058ui_story = var_274_39:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_41 = 0.200000002980232

			if var_274_40 <= arg_271_1.time_ and arg_271_1.time_ < var_274_40 + var_274_41 then
				local var_274_42 = (arg_271_1.time_ - var_274_40) / var_274_41

				if arg_271_1.var_.characterEffect10058ui_story then
					local var_274_43 = Mathf.Lerp(0, 0.5, var_274_42)

					arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10058ui_story.fillRatio = var_274_43
				end
			end

			if arg_271_1.time_ >= var_274_40 + var_274_41 and arg_271_1.time_ < var_274_40 + var_274_41 + arg_274_0 and arg_271_1.var_.characterEffect10058ui_story then
				local var_274_44 = 0.5

				arg_271_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10058ui_story.fillRatio = var_274_44
			end

			local var_274_45 = arg_271_1.actors_["10058ui_story"].transform
			local var_274_46 = 2

			if var_274_46 < arg_271_1.time_ and arg_271_1.time_ <= var_274_46 + arg_274_0 then
				arg_271_1.var_.moveOldPos10058ui_story = var_274_45.localPosition
			end

			local var_274_47 = 0.001

			if var_274_46 <= arg_271_1.time_ and arg_271_1.time_ < var_274_46 + var_274_47 then
				local var_274_48 = (arg_271_1.time_ - var_274_46) / var_274_47
				local var_274_49 = Vector3.New(0, 100, 0)

				var_274_45.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10058ui_story, var_274_49, var_274_48)

				local var_274_50 = manager.ui.mainCamera.transform.position - var_274_45.position

				var_274_45.forward = Vector3.New(var_274_50.x, var_274_50.y, var_274_50.z)

				local var_274_51 = var_274_45.localEulerAngles

				var_274_51.z = 0
				var_274_51.x = 0
				var_274_45.localEulerAngles = var_274_51
			end

			if arg_271_1.time_ >= var_274_46 + var_274_47 and arg_271_1.time_ < var_274_46 + var_274_47 + arg_274_0 then
				var_274_45.localPosition = Vector3.New(0, 100, 0)

				local var_274_52 = manager.ui.mainCamera.transform.position - var_274_45.position

				var_274_45.forward = Vector3.New(var_274_52.x, var_274_52.y, var_274_52.z)

				local var_274_53 = var_274_45.localEulerAngles

				var_274_53.z = 0
				var_274_53.x = 0
				var_274_45.localEulerAngles = var_274_53
			end

			local var_274_54 = arg_271_1.actors_["10014ui_story"].transform
			local var_274_55 = 2

			if var_274_55 < arg_271_1.time_ and arg_271_1.time_ <= var_274_55 + arg_274_0 then
				arg_271_1.var_.moveOldPos10014ui_story = var_274_54.localPosition
			end

			local var_274_56 = 0.001

			if var_274_55 <= arg_271_1.time_ and arg_271_1.time_ < var_274_55 + var_274_56 then
				local var_274_57 = (arg_271_1.time_ - var_274_55) / var_274_56
				local var_274_58 = Vector3.New(0, 100, 0)

				var_274_54.localPosition = Vector3.Lerp(arg_271_1.var_.moveOldPos10014ui_story, var_274_58, var_274_57)

				local var_274_59 = manager.ui.mainCamera.transform.position - var_274_54.position

				var_274_54.forward = Vector3.New(var_274_59.x, var_274_59.y, var_274_59.z)

				local var_274_60 = var_274_54.localEulerAngles

				var_274_60.z = 0
				var_274_60.x = 0
				var_274_54.localEulerAngles = var_274_60
			end

			if arg_271_1.time_ >= var_274_55 + var_274_56 and arg_271_1.time_ < var_274_55 + var_274_56 + arg_274_0 then
				var_274_54.localPosition = Vector3.New(0, 100, 0)

				local var_274_61 = manager.ui.mainCamera.transform.position - var_274_54.position

				var_274_54.forward = Vector3.New(var_274_61.x, var_274_61.y, var_274_61.z)

				local var_274_62 = var_274_54.localEulerAngles

				var_274_62.z = 0
				var_274_62.x = 0
				var_274_54.localEulerAngles = var_274_62
			end

			local var_274_63 = arg_271_1.actors_["10014ui_story"]
			local var_274_64 = 2

			if var_274_64 < arg_271_1.time_ and arg_271_1.time_ <= var_274_64 + arg_274_0 and arg_271_1.var_.characterEffect10014ui_story == nil then
				arg_271_1.var_.characterEffect10014ui_story = var_274_63:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_274_65 = 0.200000002980232

			if var_274_64 <= arg_271_1.time_ and arg_271_1.time_ < var_274_64 + var_274_65 then
				local var_274_66 = (arg_271_1.time_ - var_274_64) / var_274_65

				if arg_271_1.var_.characterEffect10014ui_story then
					local var_274_67 = Mathf.Lerp(0, 0.5, var_274_66)

					arg_271_1.var_.characterEffect10014ui_story.fillFlat = true
					arg_271_1.var_.characterEffect10014ui_story.fillRatio = var_274_67
				end
			end

			if arg_271_1.time_ >= var_274_64 + var_274_65 and arg_271_1.time_ < var_274_64 + var_274_65 + arg_274_0 and arg_271_1.var_.characterEffect10014ui_story then
				local var_274_68 = 0.5

				arg_271_1.var_.characterEffect10014ui_story.fillFlat = true
				arg_271_1.var_.characterEffect10014ui_story.fillRatio = var_274_68
			end

			if arg_271_1.frameCnt_ <= 1 then
				arg_271_1.dialog_:SetActive(false)
			end

			local var_274_69 = 4
			local var_274_70 = 0.825

			if var_274_69 < arg_271_1.time_ and arg_271_1.time_ <= var_274_69 + arg_274_0 then
				arg_271_1.talkMaxDuration = 0

				arg_271_1.dialog_:SetActive(true)

				local var_274_71 = LeanTween.value(arg_271_1.dialog_, 0, 1, 0.3)

				var_274_71:setOnUpdate(LuaHelper.FloatAction(function(arg_275_0)
					arg_271_1.dialogCg_.alpha = arg_275_0
				end))
				var_274_71:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_271_1.dialog_)
					var_274_71:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_271_1.duration_ = arg_271_1.duration_ + 0.3

				SetActive(arg_271_1.leftNameGo_, false)

				arg_271_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_271_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_271_1:RecordName(arg_271_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_271_1.iconTrs_.gameObject, false)
				arg_271_1.callingController_:SetSelectedState("normal")

				local var_274_72 = arg_271_1:GetWordFromCfg(411051067)
				local var_274_73 = arg_271_1:FormatText(var_274_72.content)

				arg_271_1.text_.text = var_274_73

				LuaForUtil.ClearLinePrefixSymbol(arg_271_1.text_)

				local var_274_74 = 33
				local var_274_75 = utf8.len(var_274_73)
				local var_274_76 = var_274_74 <= 0 and var_274_70 or var_274_70 * (var_274_75 / var_274_74)

				if var_274_76 > 0 and var_274_70 < var_274_76 then
					arg_271_1.talkMaxDuration = var_274_76
					var_274_69 = var_274_69 + 0.3

					if var_274_76 + var_274_69 > arg_271_1.duration_ then
						arg_271_1.duration_ = var_274_76 + var_274_69
					end
				end

				arg_271_1.text_.text = var_274_73
				arg_271_1.typewritter.percent = 0

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(false)
				arg_271_1:RecordContent(arg_271_1.text_.text)
			end

			local var_274_77 = var_274_69 + 0.3
			local var_274_78 = math.max(var_274_70, arg_271_1.talkMaxDuration)

			if var_274_77 <= arg_271_1.time_ and arg_271_1.time_ < var_274_77 + var_274_78 then
				arg_271_1.typewritter.percent = (arg_271_1.time_ - var_274_77) / var_274_78

				arg_271_1.typewritter:SetDirty()
			end

			if arg_271_1.time_ >= var_274_77 + var_274_78 and arg_271_1.time_ < var_274_77 + var_274_78 + arg_274_0 then
				arg_271_1.typewritter.percent = 1

				arg_271_1.typewritter:SetDirty()
				arg_271_1:ShowNextGo(true)
			end
		end
	end,
	Play411051068 = function(arg_277_0, arg_277_1)
		arg_277_1.time_ = 0
		arg_277_1.frameCnt_ = 0
		arg_277_1.state_ = "playing"
		arg_277_1.curTalkId_ = 411051068
		arg_277_1.duration_ = 5

		SetActive(arg_277_1.tipsGo_, false)

		function arg_277_1.onSingleLineFinish_()
			arg_277_1.onSingleLineUpdate_ = nil
			arg_277_1.onSingleLineFinish_ = nil
			arg_277_1.state_ = "waiting"
		end

		function arg_277_1.playNext_(arg_279_0)
			if arg_279_0 == 1 then
				arg_277_0:Play411051069(arg_277_1)
			end
		end

		function arg_277_1.onSingleLineUpdate_(arg_280_0)
			local var_280_0 = 0
			local var_280_1 = 0.366666666666667

			if var_280_0 < arg_277_1.time_ and arg_277_1.time_ <= var_280_0 + arg_280_0 then
				local var_280_2 = "play"
				local var_280_3 = "music"

				arg_277_1:AudioAction(var_280_2, var_280_3, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_280_4 = 0
			local var_280_5 = 1.3

			if var_280_4 < arg_277_1.time_ and arg_277_1.time_ <= var_280_4 + arg_280_0 then
				arg_277_1.talkMaxDuration = 0
				arg_277_1.dialogCg_.alpha = 1

				arg_277_1.dialog_:SetActive(true)
				SetActive(arg_277_1.leftNameGo_, false)

				arg_277_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_277_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_277_1:RecordName(arg_277_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_277_1.iconTrs_.gameObject, false)
				arg_277_1.callingController_:SetSelectedState("normal")

				local var_280_6 = arg_277_1:GetWordFromCfg(411051068)
				local var_280_7 = arg_277_1:FormatText(var_280_6.content)

				arg_277_1.text_.text = var_280_7

				LuaForUtil.ClearLinePrefixSymbol(arg_277_1.text_)

				local var_280_8 = 52
				local var_280_9 = utf8.len(var_280_7)
				local var_280_10 = var_280_8 <= 0 and var_280_5 or var_280_5 * (var_280_9 / var_280_8)

				if var_280_10 > 0 and var_280_5 < var_280_10 then
					arg_277_1.talkMaxDuration = var_280_10

					if var_280_10 + var_280_4 > arg_277_1.duration_ then
						arg_277_1.duration_ = var_280_10 + var_280_4
					end
				end

				arg_277_1.text_.text = var_280_7
				arg_277_1.typewritter.percent = 0

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(false)
				arg_277_1:RecordContent(arg_277_1.text_.text)
			end

			local var_280_11 = math.max(var_280_5, arg_277_1.talkMaxDuration)

			if var_280_4 <= arg_277_1.time_ and arg_277_1.time_ < var_280_4 + var_280_11 then
				arg_277_1.typewritter.percent = (arg_277_1.time_ - var_280_4) / var_280_11

				arg_277_1.typewritter:SetDirty()
			end

			if arg_277_1.time_ >= var_280_4 + var_280_11 and arg_277_1.time_ < var_280_4 + var_280_11 + arg_280_0 then
				arg_277_1.typewritter.percent = 1

				arg_277_1.typewritter:SetDirty()
				arg_277_1:ShowNextGo(true)
			end
		end
	end,
	Play411051069 = function(arg_281_0, arg_281_1)
		arg_281_1.time_ = 0
		arg_281_1.frameCnt_ = 0
		arg_281_1.state_ = "playing"
		arg_281_1.curTalkId_ = 411051069
		arg_281_1.duration_ = 2.033

		local var_281_0 = {
			zh = 1.999999999999,
			ja = 2.033
		}
		local var_281_1 = manager.audio:GetLocalizationFlag()

		if var_281_0[var_281_1] ~= nil then
			arg_281_1.duration_ = var_281_0[var_281_1]
		end

		SetActive(arg_281_1.tipsGo_, false)

		function arg_281_1.onSingleLineFinish_()
			arg_281_1.onSingleLineUpdate_ = nil
			arg_281_1.onSingleLineFinish_ = nil
			arg_281_1.state_ = "waiting"
		end

		function arg_281_1.playNext_(arg_283_0)
			if arg_283_0 == 1 then
				arg_281_0:Play411051070(arg_281_1)
			end
		end

		function arg_281_1.onSingleLineUpdate_(arg_284_0)
			local var_284_0 = arg_281_1.actors_["10058ui_story"].transform
			local var_284_1 = 0

			if var_284_1 < arg_281_1.time_ and arg_281_1.time_ <= var_284_1 + arg_284_0 then
				arg_281_1.var_.moveOldPos10058ui_story = var_284_0.localPosition
			end

			local var_284_2 = 0.001

			if var_284_1 <= arg_281_1.time_ and arg_281_1.time_ < var_284_1 + var_284_2 then
				local var_284_3 = (arg_281_1.time_ - var_284_1) / var_284_2
				local var_284_4 = Vector3.New(0, -0.98, -6.1)

				var_284_0.localPosition = Vector3.Lerp(arg_281_1.var_.moveOldPos10058ui_story, var_284_4, var_284_3)

				local var_284_5 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_5.x, var_284_5.y, var_284_5.z)

				local var_284_6 = var_284_0.localEulerAngles

				var_284_6.z = 0
				var_284_6.x = 0
				var_284_0.localEulerAngles = var_284_6
			end

			if arg_281_1.time_ >= var_284_1 + var_284_2 and arg_281_1.time_ < var_284_1 + var_284_2 + arg_284_0 then
				var_284_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_284_7 = manager.ui.mainCamera.transform.position - var_284_0.position

				var_284_0.forward = Vector3.New(var_284_7.x, var_284_7.y, var_284_7.z)

				local var_284_8 = var_284_0.localEulerAngles

				var_284_8.z = 0
				var_284_8.x = 0
				var_284_0.localEulerAngles = var_284_8
			end

			local var_284_9 = arg_281_1.actors_["10058ui_story"]
			local var_284_10 = 0

			if var_284_10 < arg_281_1.time_ and arg_281_1.time_ <= var_284_10 + arg_284_0 and arg_281_1.var_.characterEffect10058ui_story == nil then
				arg_281_1.var_.characterEffect10058ui_story = var_284_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_284_11 = 0.200000002980232

			if var_284_10 <= arg_281_1.time_ and arg_281_1.time_ < var_284_10 + var_284_11 then
				local var_284_12 = (arg_281_1.time_ - var_284_10) / var_284_11

				if arg_281_1.var_.characterEffect10058ui_story then
					arg_281_1.var_.characterEffect10058ui_story.fillFlat = false
				end
			end

			if arg_281_1.time_ >= var_284_10 + var_284_11 and arg_281_1.time_ < var_284_10 + var_284_11 + arg_284_0 and arg_281_1.var_.characterEffect10058ui_story then
				arg_281_1.var_.characterEffect10058ui_story.fillFlat = false
			end

			local var_284_13 = 0

			if var_284_13 < arg_281_1.time_ and arg_281_1.time_ <= var_284_13 + arg_284_0 then
				arg_281_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_284_14 = 0

			if var_284_14 < arg_281_1.time_ and arg_281_1.time_ <= var_284_14 + arg_284_0 then
				arg_281_1:PlayTimeline("10058ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0101cva")
			end

			local var_284_15 = 0
			local var_284_16 = 0.15

			if var_284_15 < arg_281_1.time_ and arg_281_1.time_ <= var_284_15 + arg_284_0 then
				arg_281_1.talkMaxDuration = 0
				arg_281_1.dialogCg_.alpha = 1

				arg_281_1.dialog_:SetActive(true)
				SetActive(arg_281_1.leftNameGo_, true)

				local var_284_17 = arg_281_1:FormatText(StoryNameCfg[471].name)

				arg_281_1.leftNameTxt_.text = var_284_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_281_1.leftNameTxt_.transform)

				arg_281_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_281_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_281_1:RecordName(arg_281_1.leftNameTxt_.text)
				SetActive(arg_281_1.iconTrs_.gameObject, false)
				arg_281_1.callingController_:SetSelectedState("normal")

				local var_284_18 = arg_281_1:GetWordFromCfg(411051069)
				local var_284_19 = arg_281_1:FormatText(var_284_18.content)

				arg_281_1.text_.text = var_284_19

				LuaForUtil.ClearLinePrefixSymbol(arg_281_1.text_)

				local var_284_20 = 6
				local var_284_21 = utf8.len(var_284_19)
				local var_284_22 = var_284_20 <= 0 and var_284_16 or var_284_16 * (var_284_21 / var_284_20)

				if var_284_22 > 0 and var_284_16 < var_284_22 then
					arg_281_1.talkMaxDuration = var_284_22

					if var_284_22 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_22 + var_284_15
					end
				end

				arg_281_1.text_.text = var_284_19
				arg_281_1.typewritter.percent = 0

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") ~= 0 then
					local var_284_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051069", "story_v_out_411051.awb") / 1000

					if var_284_23 + var_284_15 > arg_281_1.duration_ then
						arg_281_1.duration_ = var_284_23 + var_284_15
					end

					if var_284_18.prefab_name ~= "" and arg_281_1.actors_[var_284_18.prefab_name] ~= nil then
						local var_284_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_281_1.actors_[var_284_18.prefab_name].transform, "story_v_out_411051", "411051069", "story_v_out_411051.awb")

						arg_281_1:RecordAudio("411051069", var_284_24)
						arg_281_1:RecordAudio("411051069", var_284_24)
					else
						arg_281_1:AudioAction("play", "voice", "story_v_out_411051", "411051069", "story_v_out_411051.awb")
					end

					arg_281_1:RecordHistoryTalkVoice("story_v_out_411051", "411051069", "story_v_out_411051.awb")
				end

				arg_281_1:RecordContent(arg_281_1.text_.text)
			end

			local var_284_25 = math.max(var_284_16, arg_281_1.talkMaxDuration)

			if var_284_15 <= arg_281_1.time_ and arg_281_1.time_ < var_284_15 + var_284_25 then
				arg_281_1.typewritter.percent = (arg_281_1.time_ - var_284_15) / var_284_25

				arg_281_1.typewritter:SetDirty()
			end

			if arg_281_1.time_ >= var_284_15 + var_284_25 and arg_281_1.time_ < var_284_15 + var_284_25 + arg_284_0 then
				arg_281_1.typewritter.percent = 1

				arg_281_1.typewritter:SetDirty()
				arg_281_1:ShowNextGo(true)
			end
		end
	end,
	Play411051070 = function(arg_285_0, arg_285_1)
		arg_285_1.time_ = 0
		arg_285_1.frameCnt_ = 0
		arg_285_1.state_ = "playing"
		arg_285_1.curTalkId_ = 411051070
		arg_285_1.duration_ = 5

		SetActive(arg_285_1.tipsGo_, false)

		function arg_285_1.onSingleLineFinish_()
			arg_285_1.onSingleLineUpdate_ = nil
			arg_285_1.onSingleLineFinish_ = nil
			arg_285_1.state_ = "waiting"
		end

		function arg_285_1.playNext_(arg_287_0)
			if arg_287_0 == 1 then
				arg_285_0:Play411051071(arg_285_1)
			end
		end

		function arg_285_1.onSingleLineUpdate_(arg_288_0)
			local var_288_0 = arg_285_1.actors_["10058ui_story"]
			local var_288_1 = 0

			if var_288_1 < arg_285_1.time_ and arg_285_1.time_ <= var_288_1 + arg_288_0 and arg_285_1.var_.characterEffect10058ui_story == nil then
				arg_285_1.var_.characterEffect10058ui_story = var_288_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_288_2 = 0.200000002980232

			if var_288_1 <= arg_285_1.time_ and arg_285_1.time_ < var_288_1 + var_288_2 then
				local var_288_3 = (arg_285_1.time_ - var_288_1) / var_288_2

				if arg_285_1.var_.characterEffect10058ui_story then
					local var_288_4 = Mathf.Lerp(0, 0.5, var_288_3)

					arg_285_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_285_1.var_.characterEffect10058ui_story.fillRatio = var_288_4
				end
			end

			if arg_285_1.time_ >= var_288_1 + var_288_2 and arg_285_1.time_ < var_288_1 + var_288_2 + arg_288_0 and arg_285_1.var_.characterEffect10058ui_story then
				local var_288_5 = 0.5

				arg_285_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_285_1.var_.characterEffect10058ui_story.fillRatio = var_288_5
			end

			local var_288_6 = 0
			local var_288_7 = 0.7

			if var_288_6 < arg_285_1.time_ and arg_285_1.time_ <= var_288_6 + arg_288_0 then
				arg_285_1.talkMaxDuration = 0
				arg_285_1.dialogCg_.alpha = 1

				arg_285_1.dialog_:SetActive(true)
				SetActive(arg_285_1.leftNameGo_, false)

				arg_285_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_285_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_285_1:RecordName(arg_285_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_285_1.iconTrs_.gameObject, false)
				arg_285_1.callingController_:SetSelectedState("normal")

				local var_288_8 = arg_285_1:GetWordFromCfg(411051070)
				local var_288_9 = arg_285_1:FormatText(var_288_8.content)

				arg_285_1.text_.text = var_288_9

				LuaForUtil.ClearLinePrefixSymbol(arg_285_1.text_)

				local var_288_10 = 28
				local var_288_11 = utf8.len(var_288_9)
				local var_288_12 = var_288_10 <= 0 and var_288_7 or var_288_7 * (var_288_11 / var_288_10)

				if var_288_12 > 0 and var_288_7 < var_288_12 then
					arg_285_1.talkMaxDuration = var_288_12

					if var_288_12 + var_288_6 > arg_285_1.duration_ then
						arg_285_1.duration_ = var_288_12 + var_288_6
					end
				end

				arg_285_1.text_.text = var_288_9
				arg_285_1.typewritter.percent = 0

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(false)
				arg_285_1:RecordContent(arg_285_1.text_.text)
			end

			local var_288_13 = math.max(var_288_7, arg_285_1.talkMaxDuration)

			if var_288_6 <= arg_285_1.time_ and arg_285_1.time_ < var_288_6 + var_288_13 then
				arg_285_1.typewritter.percent = (arg_285_1.time_ - var_288_6) / var_288_13

				arg_285_1.typewritter:SetDirty()
			end

			if arg_285_1.time_ >= var_288_6 + var_288_13 and arg_285_1.time_ < var_288_6 + var_288_13 + arg_288_0 then
				arg_285_1.typewritter.percent = 1

				arg_285_1.typewritter:SetDirty()
				arg_285_1:ShowNextGo(true)
			end
		end
	end,
	Play411051071 = function(arg_289_0, arg_289_1)
		arg_289_1.time_ = 0
		arg_289_1.frameCnt_ = 0
		arg_289_1.state_ = "playing"
		arg_289_1.curTalkId_ = 411051071
		arg_289_1.duration_ = 6.7

		SetActive(arg_289_1.tipsGo_, false)

		function arg_289_1.onSingleLineFinish_()
			arg_289_1.onSingleLineUpdate_ = nil
			arg_289_1.onSingleLineFinish_ = nil
			arg_289_1.state_ = "waiting"
		end

		function arg_289_1.playNext_(arg_291_0)
			if arg_291_0 == 1 then
				arg_289_0:Play411051072(arg_289_1)
			end
		end

		function arg_289_1.onSingleLineUpdate_(arg_292_0)
			local var_292_0 = "B10a"

			if arg_289_1.bgs_[var_292_0] == nil then
				local var_292_1 = Object.Instantiate(arg_289_1.paintGo_)

				var_292_1:GetComponent("SpriteRenderer").sprite = getSpriteWithoutAtlas("TextureConfig/Background/" .. var_292_0)
				var_292_1.name = var_292_0
				var_292_1.transform.parent = arg_289_1.stage_.transform
				var_292_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_289_1.bgs_[var_292_0] = var_292_1
			end

			local var_292_2 = 2

			if var_292_2 < arg_289_1.time_ and arg_289_1.time_ <= var_292_2 + arg_292_0 then
				local var_292_3 = manager.ui.mainCamera.transform.localPosition
				local var_292_4 = Vector3.New(0, 0, 10) + Vector3.New(var_292_3.x, var_292_3.y, 0)
				local var_292_5 = arg_289_1.bgs_.B10a

				var_292_5.transform.localPosition = var_292_4
				var_292_5.transform.localEulerAngles = Vector3(0, 0, 0)

				local var_292_6 = var_292_5:GetComponent("SpriteRenderer")

				if var_292_6 and var_292_6.sprite then
					local var_292_7 = (var_292_5.transform.localPosition - var_292_3).z
					local var_292_8 = manager.ui.mainCameraCom_
					local var_292_9 = 2 * var_292_7 * Mathf.Tan(var_292_8.fieldOfView * 0.5 * Mathf.Deg2Rad)
					local var_292_10 = var_292_9 * var_292_8.aspect
					local var_292_11 = var_292_6.sprite.bounds.size.x
					local var_292_12 = var_292_6.sprite.bounds.size.y
					local var_292_13 = var_292_10 / var_292_11
					local var_292_14 = var_292_9 / var_292_12
					local var_292_15 = var_292_14 < var_292_13 and var_292_13 or var_292_14

					var_292_5.transform.localScale = Vector3.New(var_292_15, var_292_15, 0)
				end

				for iter_292_0, iter_292_1 in pairs(arg_289_1.bgs_) do
					if iter_292_0 ~= "B10a" then
						iter_292_1.transform.localPosition = Vector3.New(0, 100, 0)
					end
				end
			end

			local var_292_16 = 0

			if var_292_16 < arg_289_1.time_ and arg_289_1.time_ <= var_292_16 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_17 = 2

			if var_292_16 <= arg_289_1.time_ and arg_289_1.time_ < var_292_16 + var_292_17 then
				local var_292_18 = (arg_289_1.time_ - var_292_16) / var_292_17
				local var_292_19 = Color.New(0, 0, 0)

				var_292_19.a = Mathf.Lerp(0, 1, var_292_18)
				arg_289_1.mask_.color = var_292_19
			end

			if arg_289_1.time_ >= var_292_16 + var_292_17 and arg_289_1.time_ < var_292_16 + var_292_17 + arg_292_0 then
				local var_292_20 = Color.New(0, 0, 0)

				var_292_20.a = 1
				arg_289_1.mask_.color = var_292_20
			end

			local var_292_21 = 2

			if var_292_21 < arg_289_1.time_ and arg_289_1.time_ <= var_292_21 + arg_292_0 then
				arg_289_1.mask_.enabled = true
				arg_289_1.mask_.raycastTarget = true

				arg_289_1:SetGaussion(false)
			end

			local var_292_22 = 2

			if var_292_21 <= arg_289_1.time_ and arg_289_1.time_ < var_292_21 + var_292_22 then
				local var_292_23 = (arg_289_1.time_ - var_292_21) / var_292_22
				local var_292_24 = Color.New(0, 0, 0)

				var_292_24.a = Mathf.Lerp(1, 0, var_292_23)
				arg_289_1.mask_.color = var_292_24
			end

			if arg_289_1.time_ >= var_292_21 + var_292_22 and arg_289_1.time_ < var_292_21 + var_292_22 + arg_292_0 then
				local var_292_25 = Color.New(0, 0, 0)
				local var_292_26 = 0

				arg_289_1.mask_.enabled = false
				var_292_25.a = var_292_26
				arg_289_1.mask_.color = var_292_25
			end

			local var_292_27 = arg_289_1.actors_["10058ui_story"].transform
			local var_292_28 = 2

			if var_292_28 < arg_289_1.time_ and arg_289_1.time_ <= var_292_28 + arg_292_0 then
				arg_289_1.var_.moveOldPos10058ui_story = var_292_27.localPosition
			end

			local var_292_29 = 0.001

			if var_292_28 <= arg_289_1.time_ and arg_289_1.time_ < var_292_28 + var_292_29 then
				local var_292_30 = (arg_289_1.time_ - var_292_28) / var_292_29
				local var_292_31 = Vector3.New(0, 100, 0)

				var_292_27.localPosition = Vector3.Lerp(arg_289_1.var_.moveOldPos10058ui_story, var_292_31, var_292_30)

				local var_292_32 = manager.ui.mainCamera.transform.position - var_292_27.position

				var_292_27.forward = Vector3.New(var_292_32.x, var_292_32.y, var_292_32.z)

				local var_292_33 = var_292_27.localEulerAngles

				var_292_33.z = 0
				var_292_33.x = 0
				var_292_27.localEulerAngles = var_292_33
			end

			if arg_289_1.time_ >= var_292_28 + var_292_29 and arg_289_1.time_ < var_292_28 + var_292_29 + arg_292_0 then
				var_292_27.localPosition = Vector3.New(0, 100, 0)

				local var_292_34 = manager.ui.mainCamera.transform.position - var_292_27.position

				var_292_27.forward = Vector3.New(var_292_34.x, var_292_34.y, var_292_34.z)

				local var_292_35 = var_292_27.localEulerAngles

				var_292_35.z = 0
				var_292_35.x = 0
				var_292_27.localEulerAngles = var_292_35
			end

			local var_292_36 = arg_289_1.actors_["10058ui_story"]
			local var_292_37 = 2

			if var_292_37 < arg_289_1.time_ and arg_289_1.time_ <= var_292_37 + arg_292_0 and arg_289_1.var_.characterEffect10058ui_story == nil then
				arg_289_1.var_.characterEffect10058ui_story = var_292_36:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_292_38 = 0.200000002980232

			if var_292_37 <= arg_289_1.time_ and arg_289_1.time_ < var_292_37 + var_292_38 then
				local var_292_39 = (arg_289_1.time_ - var_292_37) / var_292_38

				if arg_289_1.var_.characterEffect10058ui_story then
					local var_292_40 = Mathf.Lerp(0, 0.5, var_292_39)

					arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
					arg_289_1.var_.characterEffect10058ui_story.fillRatio = var_292_40
				end
			end

			if arg_289_1.time_ >= var_292_37 + var_292_38 and arg_289_1.time_ < var_292_37 + var_292_38 + arg_292_0 and arg_289_1.var_.characterEffect10058ui_story then
				local var_292_41 = 0.5

				arg_289_1.var_.characterEffect10058ui_story.fillFlat = true
				arg_289_1.var_.characterEffect10058ui_story.fillRatio = var_292_41
			end

			local var_292_42 = 0
			local var_292_43 = 0.366666666666667

			if var_292_42 < arg_289_1.time_ and arg_289_1.time_ <= var_292_42 + arg_292_0 then
				local var_292_44 = "play"
				local var_292_45 = "music"

				arg_289_1:AudioAction(var_292_44, var_292_45, "ui_battle", "ui_battle_stopbgm", "")
			end

			local var_292_46 = 0.466666666666667
			local var_292_47 = 1

			if var_292_46 < arg_289_1.time_ and arg_289_1.time_ <= var_292_46 + arg_292_0 then
				local var_292_48 = "play"
				local var_292_49 = "music"

				arg_289_1:AudioAction(var_292_48, var_292_49, "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin", "bgm_story_v1_qiaolin.awb")
			end

			local var_292_50 = 4
			local var_292_51 = 0.15

			if var_292_50 < arg_289_1.time_ and arg_289_1.time_ <= var_292_50 + arg_292_0 then
				local var_292_52 = "play"
				local var_292_53 = "effect"

				arg_289_1:AudioAction(var_292_52, var_292_53, "se_story_130", "se_story_130_robot", "")
			end

			if arg_289_1.frameCnt_ <= 1 then
				arg_289_1.dialog_:SetActive(false)
			end

			local var_292_54 = 4
			local var_292_55 = 0.15

			if var_292_54 < arg_289_1.time_ and arg_289_1.time_ <= var_292_54 + arg_292_0 then
				arg_289_1.talkMaxDuration = 0

				arg_289_1.dialog_:SetActive(true)

				local var_292_56 = LeanTween.value(arg_289_1.dialog_, 0, 1, 0.3)

				var_292_56:setOnUpdate(LuaHelper.FloatAction(function(arg_293_0)
					arg_289_1.dialogCg_.alpha = arg_293_0
				end))
				var_292_56:setOnComplete(System.Action(function()
					LeanTween.cancel(arg_289_1.dialog_)
					var_292_56:setOnUpdate(nil):setOnComplete(nil)
				end))

				arg_289_1.duration_ = arg_289_1.duration_ + 0.3

				SetActive(arg_289_1.leftNameGo_, true)

				local var_292_57 = arg_289_1:FormatText(StoryNameCfg[674].name)

				arg_289_1.leftNameTxt_.text = var_292_57

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_289_1.leftNameTxt_.transform)

				arg_289_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_289_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_289_1:RecordName(arg_289_1.leftNameTxt_.text)
				SetActive(arg_289_1.iconTrs_.gameObject, true)
				arg_289_1.iconController_:SetSelectedState("hero")

				arg_289_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_289_1.callingController_:SetSelectedState("normal")

				local var_292_58 = arg_289_1:GetWordFromCfg(411051071)
				local var_292_59 = arg_289_1:FormatText(var_292_58.content)

				arg_289_1.text_.text = var_292_59

				LuaForUtil.ClearLinePrefixSymbol(arg_289_1.text_)

				local var_292_60 = 6
				local var_292_61 = utf8.len(var_292_59)
				local var_292_62 = var_292_60 <= 0 and var_292_55 or var_292_55 * (var_292_61 / var_292_60)

				if var_292_62 > 0 and var_292_55 < var_292_62 then
					arg_289_1.talkMaxDuration = var_292_62
					var_292_54 = var_292_54 + 0.3

					if var_292_62 + var_292_54 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_62 + var_292_54
					end
				end

				arg_289_1.text_.text = var_292_59
				arg_289_1.typewritter.percent = 0

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") ~= 0 then
					local var_292_63 = manager.audio:GetVoiceLength("story_v_out_411051", "411051071", "story_v_out_411051.awb") / 1000

					if var_292_63 + var_292_54 > arg_289_1.duration_ then
						arg_289_1.duration_ = var_292_63 + var_292_54
					end

					if var_292_58.prefab_name ~= "" and arg_289_1.actors_[var_292_58.prefab_name] ~= nil then
						local var_292_64 = LuaForUtil.PlayVoiceWithCriLipsync(arg_289_1.actors_[var_292_58.prefab_name].transform, "story_v_out_411051", "411051071", "story_v_out_411051.awb")

						arg_289_1:RecordAudio("411051071", var_292_64)
						arg_289_1:RecordAudio("411051071", var_292_64)
					else
						arg_289_1:AudioAction("play", "voice", "story_v_out_411051", "411051071", "story_v_out_411051.awb")
					end

					arg_289_1:RecordHistoryTalkVoice("story_v_out_411051", "411051071", "story_v_out_411051.awb")
				end

				arg_289_1:RecordContent(arg_289_1.text_.text)
			end

			local var_292_65 = var_292_54 + 0.3
			local var_292_66 = math.max(var_292_55, arg_289_1.talkMaxDuration)

			if var_292_65 <= arg_289_1.time_ and arg_289_1.time_ < var_292_65 + var_292_66 then
				arg_289_1.typewritter.percent = (arg_289_1.time_ - var_292_65) / var_292_66

				arg_289_1.typewritter:SetDirty()
			end

			if arg_289_1.time_ >= var_292_65 + var_292_66 and arg_289_1.time_ < var_292_65 + var_292_66 + arg_292_0 then
				arg_289_1.typewritter.percent = 1

				arg_289_1.typewritter:SetDirty()
				arg_289_1:ShowNextGo(true)
			end
		end
	end,
	Play411051072 = function(arg_295_0, arg_295_1)
		arg_295_1.time_ = 0
		arg_295_1.frameCnt_ = 0
		arg_295_1.state_ = "playing"
		arg_295_1.curTalkId_ = 411051072
		arg_295_1.duration_ = 5

		SetActive(arg_295_1.tipsGo_, false)

		function arg_295_1.onSingleLineFinish_()
			arg_295_1.onSingleLineUpdate_ = nil
			arg_295_1.onSingleLineFinish_ = nil
			arg_295_1.state_ = "waiting"
		end

		function arg_295_1.playNext_(arg_297_0)
			if arg_297_0 == 1 then
				arg_295_0:Play411051073(arg_295_1)
			end
		end

		function arg_295_1.onSingleLineUpdate_(arg_298_0)
			local var_298_0 = 0
			local var_298_1 = 0.825

			if var_298_0 < arg_295_1.time_ and arg_295_1.time_ <= var_298_0 + arg_298_0 then
				arg_295_1.talkMaxDuration = 0
				arg_295_1.dialogCg_.alpha = 1

				arg_295_1.dialog_:SetActive(true)
				SetActive(arg_295_1.leftNameGo_, false)

				arg_295_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_295_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_295_1:RecordName(arg_295_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_295_1.iconTrs_.gameObject, false)
				arg_295_1.callingController_:SetSelectedState("normal")

				local var_298_2 = arg_295_1:GetWordFromCfg(411051072)
				local var_298_3 = arg_295_1:FormatText(var_298_2.content)

				arg_295_1.text_.text = var_298_3

				LuaForUtil.ClearLinePrefixSymbol(arg_295_1.text_)

				local var_298_4 = 32
				local var_298_5 = utf8.len(var_298_3)
				local var_298_6 = var_298_4 <= 0 and var_298_1 or var_298_1 * (var_298_5 / var_298_4)

				if var_298_6 > 0 and var_298_1 < var_298_6 then
					arg_295_1.talkMaxDuration = var_298_6

					if var_298_6 + var_298_0 > arg_295_1.duration_ then
						arg_295_1.duration_ = var_298_6 + var_298_0
					end
				end

				arg_295_1.text_.text = var_298_3
				arg_295_1.typewritter.percent = 0

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(false)
				arg_295_1:RecordContent(arg_295_1.text_.text)
			end

			local var_298_7 = math.max(var_298_1, arg_295_1.talkMaxDuration)

			if var_298_0 <= arg_295_1.time_ and arg_295_1.time_ < var_298_0 + var_298_7 then
				arg_295_1.typewritter.percent = (arg_295_1.time_ - var_298_0) / var_298_7

				arg_295_1.typewritter:SetDirty()
			end

			if arg_295_1.time_ >= var_298_0 + var_298_7 and arg_295_1.time_ < var_298_0 + var_298_7 + arg_298_0 then
				arg_295_1.typewritter.percent = 1

				arg_295_1.typewritter:SetDirty()
				arg_295_1:ShowNextGo(true)
			end
		end
	end,
	Play411051073 = function(arg_299_0, arg_299_1)
		arg_299_1.time_ = 0
		arg_299_1.frameCnt_ = 0
		arg_299_1.state_ = "playing"
		arg_299_1.curTalkId_ = 411051073
		arg_299_1.duration_ = 6.9

		local var_299_0 = {
			zh = 3.866,
			ja = 6.9
		}
		local var_299_1 = manager.audio:GetLocalizationFlag()

		if var_299_0[var_299_1] ~= nil then
			arg_299_1.duration_ = var_299_0[var_299_1]
		end

		SetActive(arg_299_1.tipsGo_, false)

		function arg_299_1.onSingleLineFinish_()
			arg_299_1.onSingleLineUpdate_ = nil
			arg_299_1.onSingleLineFinish_ = nil
			arg_299_1.state_ = "waiting"
		end

		function arg_299_1.playNext_(arg_301_0)
			if arg_301_0 == 1 then
				arg_299_0:Play411051074(arg_299_1)
			end
		end

		function arg_299_1.onSingleLineUpdate_(arg_302_0)
			local var_302_0 = 0
			local var_302_1 = 0.35

			if var_302_0 < arg_299_1.time_ and arg_299_1.time_ <= var_302_0 + arg_302_0 then
				arg_299_1.talkMaxDuration = 0
				arg_299_1.dialogCg_.alpha = 1

				arg_299_1.dialog_:SetActive(true)
				SetActive(arg_299_1.leftNameGo_, true)

				local var_302_2 = arg_299_1:FormatText(StoryNameCfg[674].name)

				arg_299_1.leftNameTxt_.text = var_302_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_299_1.leftNameTxt_.transform)

				arg_299_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_299_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_299_1:RecordName(arg_299_1.leftNameTxt_.text)
				SetActive(arg_299_1.iconTrs_.gameObject, true)
				arg_299_1.iconController_:SetSelectedState("hero")

				arg_299_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_2022")

				arg_299_1.callingController_:SetSelectedState("normal")

				local var_302_3 = arg_299_1:GetWordFromCfg(411051073)
				local var_302_4 = arg_299_1:FormatText(var_302_3.content)

				arg_299_1.text_.text = var_302_4

				LuaForUtil.ClearLinePrefixSymbol(arg_299_1.text_)

				local var_302_5 = 14
				local var_302_6 = utf8.len(var_302_4)
				local var_302_7 = var_302_5 <= 0 and var_302_1 or var_302_1 * (var_302_6 / var_302_5)

				if var_302_7 > 0 and var_302_1 < var_302_7 then
					arg_299_1.talkMaxDuration = var_302_7

					if var_302_7 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_7 + var_302_0
					end
				end

				arg_299_1.text_.text = var_302_4
				arg_299_1.typewritter.percent = 0

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") ~= 0 then
					local var_302_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051073", "story_v_out_411051.awb") / 1000

					if var_302_8 + var_302_0 > arg_299_1.duration_ then
						arg_299_1.duration_ = var_302_8 + var_302_0
					end

					if var_302_3.prefab_name ~= "" and arg_299_1.actors_[var_302_3.prefab_name] ~= nil then
						local var_302_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_299_1.actors_[var_302_3.prefab_name].transform, "story_v_out_411051", "411051073", "story_v_out_411051.awb")

						arg_299_1:RecordAudio("411051073", var_302_9)
						arg_299_1:RecordAudio("411051073", var_302_9)
					else
						arg_299_1:AudioAction("play", "voice", "story_v_out_411051", "411051073", "story_v_out_411051.awb")
					end

					arg_299_1:RecordHistoryTalkVoice("story_v_out_411051", "411051073", "story_v_out_411051.awb")
				end

				arg_299_1:RecordContent(arg_299_1.text_.text)
			end

			local var_302_10 = math.max(var_302_1, arg_299_1.talkMaxDuration)

			if var_302_0 <= arg_299_1.time_ and arg_299_1.time_ < var_302_0 + var_302_10 then
				arg_299_1.typewritter.percent = (arg_299_1.time_ - var_302_0) / var_302_10

				arg_299_1.typewritter:SetDirty()
			end

			if arg_299_1.time_ >= var_302_0 + var_302_10 and arg_299_1.time_ < var_302_0 + var_302_10 + arg_302_0 then
				arg_299_1.typewritter.percent = 1

				arg_299_1.typewritter:SetDirty()
				arg_299_1:ShowNextGo(true)
			end
		end
	end,
	Play411051074 = function(arg_303_0, arg_303_1)
		arg_303_1.time_ = 0
		arg_303_1.frameCnt_ = 0
		arg_303_1.state_ = "playing"
		arg_303_1.curTalkId_ = 411051074
		arg_303_1.duration_ = 2.5

		local var_303_0 = {
			zh = 2.5,
			ja = 1.833
		}
		local var_303_1 = manager.audio:GetLocalizationFlag()

		if var_303_0[var_303_1] ~= nil then
			arg_303_1.duration_ = var_303_0[var_303_1]
		end

		SetActive(arg_303_1.tipsGo_, false)

		function arg_303_1.onSingleLineFinish_()
			arg_303_1.onSingleLineUpdate_ = nil
			arg_303_1.onSingleLineFinish_ = nil
			arg_303_1.state_ = "waiting"
		end

		function arg_303_1.playNext_(arg_305_0)
			if arg_305_0 == 1 then
				arg_303_0:Play411051075(arg_303_1)
			end
		end

		function arg_303_1.onSingleLineUpdate_(arg_306_0)
			local var_306_0 = 0
			local var_306_1 = 0.075

			if var_306_0 < arg_303_1.time_ and arg_303_1.time_ <= var_306_0 + arg_306_0 then
				arg_303_1.talkMaxDuration = 0
				arg_303_1.dialogCg_.alpha = 1

				arg_303_1.dialog_:SetActive(true)
				SetActive(arg_303_1.leftNameGo_, true)

				local var_306_2 = arg_303_1:FormatText(StoryNameCfg[675].name)

				arg_303_1.leftNameTxt_.text = var_306_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_303_1.leftNameTxt_.transform)

				arg_303_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_303_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_303_1:RecordName(arg_303_1.leftNameTxt_.text)
				SetActive(arg_303_1.iconTrs_.gameObject, true)
				arg_303_1.iconController_:SetSelectedState("hero")

				arg_303_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_303_1.callingController_:SetSelectedState("normal")

				local var_306_3 = arg_303_1:GetWordFromCfg(411051074)
				local var_306_4 = arg_303_1:FormatText(var_306_3.content)

				arg_303_1.text_.text = var_306_4

				LuaForUtil.ClearLinePrefixSymbol(arg_303_1.text_)

				local var_306_5 = 3
				local var_306_6 = utf8.len(var_306_4)
				local var_306_7 = var_306_5 <= 0 and var_306_1 or var_306_1 * (var_306_6 / var_306_5)

				if var_306_7 > 0 and var_306_1 < var_306_7 then
					arg_303_1.talkMaxDuration = var_306_7

					if var_306_7 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_7 + var_306_0
					end
				end

				arg_303_1.text_.text = var_306_4
				arg_303_1.typewritter.percent = 0

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") ~= 0 then
					local var_306_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051074", "story_v_out_411051.awb") / 1000

					if var_306_8 + var_306_0 > arg_303_1.duration_ then
						arg_303_1.duration_ = var_306_8 + var_306_0
					end

					if var_306_3.prefab_name ~= "" and arg_303_1.actors_[var_306_3.prefab_name] ~= nil then
						local var_306_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_303_1.actors_[var_306_3.prefab_name].transform, "story_v_out_411051", "411051074", "story_v_out_411051.awb")

						arg_303_1:RecordAudio("411051074", var_306_9)
						arg_303_1:RecordAudio("411051074", var_306_9)
					else
						arg_303_1:AudioAction("play", "voice", "story_v_out_411051", "411051074", "story_v_out_411051.awb")
					end

					arg_303_1:RecordHistoryTalkVoice("story_v_out_411051", "411051074", "story_v_out_411051.awb")
				end

				arg_303_1:RecordContent(arg_303_1.text_.text)
			end

			local var_306_10 = math.max(var_306_1, arg_303_1.talkMaxDuration)

			if var_306_0 <= arg_303_1.time_ and arg_303_1.time_ < var_306_0 + var_306_10 then
				arg_303_1.typewritter.percent = (arg_303_1.time_ - var_306_0) / var_306_10

				arg_303_1.typewritter:SetDirty()
			end

			if arg_303_1.time_ >= var_306_0 + var_306_10 and arg_303_1.time_ < var_306_0 + var_306_10 + arg_306_0 then
				arg_303_1.typewritter.percent = 1

				arg_303_1.typewritter:SetDirty()
				arg_303_1:ShowNextGo(true)
			end
		end
	end,
	Play411051075 = function(arg_307_0, arg_307_1)
		arg_307_1.time_ = 0
		arg_307_1.frameCnt_ = 0
		arg_307_1.state_ = "playing"
		arg_307_1.curTalkId_ = 411051075
		arg_307_1.duration_ = 5

		SetActive(arg_307_1.tipsGo_, false)

		function arg_307_1.onSingleLineFinish_()
			arg_307_1.onSingleLineUpdate_ = nil
			arg_307_1.onSingleLineFinish_ = nil
			arg_307_1.state_ = "waiting"
		end

		function arg_307_1.playNext_(arg_309_0)
			if arg_309_0 == 1 then
				arg_307_0:Play411051076(arg_307_1)
			end
		end

		function arg_307_1.onSingleLineUpdate_(arg_310_0)
			local var_310_0 = 0
			local var_310_1 = 1.65

			if var_310_0 < arg_307_1.time_ and arg_307_1.time_ <= var_310_0 + arg_310_0 then
				arg_307_1.talkMaxDuration = 0
				arg_307_1.dialogCg_.alpha = 1

				arg_307_1.dialog_:SetActive(true)
				SetActive(arg_307_1.leftNameGo_, false)

				arg_307_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_307_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_307_1:RecordName(arg_307_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_307_1.iconTrs_.gameObject, false)
				arg_307_1.callingController_:SetSelectedState("normal")

				local var_310_2 = arg_307_1:GetWordFromCfg(411051075)
				local var_310_3 = arg_307_1:FormatText(var_310_2.content)

				arg_307_1.text_.text = var_310_3

				LuaForUtil.ClearLinePrefixSymbol(arg_307_1.text_)

				local var_310_4 = 66
				local var_310_5 = utf8.len(var_310_3)
				local var_310_6 = var_310_4 <= 0 and var_310_1 or var_310_1 * (var_310_5 / var_310_4)

				if var_310_6 > 0 and var_310_1 < var_310_6 then
					arg_307_1.talkMaxDuration = var_310_6

					if var_310_6 + var_310_0 > arg_307_1.duration_ then
						arg_307_1.duration_ = var_310_6 + var_310_0
					end
				end

				arg_307_1.text_.text = var_310_3
				arg_307_1.typewritter.percent = 0

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(false)
				arg_307_1:RecordContent(arg_307_1.text_.text)
			end

			local var_310_7 = math.max(var_310_1, arg_307_1.talkMaxDuration)

			if var_310_0 <= arg_307_1.time_ and arg_307_1.time_ < var_310_0 + var_310_7 then
				arg_307_1.typewritter.percent = (arg_307_1.time_ - var_310_0) / var_310_7

				arg_307_1.typewritter:SetDirty()
			end

			if arg_307_1.time_ >= var_310_0 + var_310_7 and arg_307_1.time_ < var_310_0 + var_310_7 + arg_310_0 then
				arg_307_1.typewritter.percent = 1

				arg_307_1.typewritter:SetDirty()
				arg_307_1:ShowNextGo(true)
			end
		end
	end,
	Play411051076 = function(arg_311_0, arg_311_1)
		arg_311_1.time_ = 0
		arg_311_1.frameCnt_ = 0
		arg_311_1.state_ = "playing"
		arg_311_1.curTalkId_ = 411051076
		arg_311_1.duration_ = 5

		SetActive(arg_311_1.tipsGo_, false)

		function arg_311_1.onSingleLineFinish_()
			arg_311_1.onSingleLineUpdate_ = nil
			arg_311_1.onSingleLineFinish_ = nil
			arg_311_1.state_ = "waiting"
		end

		function arg_311_1.playNext_(arg_313_0)
			if arg_313_0 == 1 then
				arg_311_0:Play411051077(arg_311_1)
			end
		end

		function arg_311_1.onSingleLineUpdate_(arg_314_0)
			local var_314_0 = 0
			local var_314_1 = 1.175

			if var_314_0 < arg_311_1.time_ and arg_311_1.time_ <= var_314_0 + arg_314_0 then
				arg_311_1.talkMaxDuration = 0
				arg_311_1.dialogCg_.alpha = 1

				arg_311_1.dialog_:SetActive(true)
				SetActive(arg_311_1.leftNameGo_, false)

				arg_311_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_311_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_311_1:RecordName(arg_311_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_311_1.iconTrs_.gameObject, false)
				arg_311_1.callingController_:SetSelectedState("normal")

				local var_314_2 = arg_311_1:GetWordFromCfg(411051076)
				local var_314_3 = arg_311_1:FormatText(var_314_2.content)

				arg_311_1.text_.text = var_314_3

				LuaForUtil.ClearLinePrefixSymbol(arg_311_1.text_)

				local var_314_4 = 47
				local var_314_5 = utf8.len(var_314_3)
				local var_314_6 = var_314_4 <= 0 and var_314_1 or var_314_1 * (var_314_5 / var_314_4)

				if var_314_6 > 0 and var_314_1 < var_314_6 then
					arg_311_1.talkMaxDuration = var_314_6

					if var_314_6 + var_314_0 > arg_311_1.duration_ then
						arg_311_1.duration_ = var_314_6 + var_314_0
					end
				end

				arg_311_1.text_.text = var_314_3
				arg_311_1.typewritter.percent = 0

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(false)
				arg_311_1:RecordContent(arg_311_1.text_.text)
			end

			local var_314_7 = math.max(var_314_1, arg_311_1.talkMaxDuration)

			if var_314_0 <= arg_311_1.time_ and arg_311_1.time_ < var_314_0 + var_314_7 then
				arg_311_1.typewritter.percent = (arg_311_1.time_ - var_314_0) / var_314_7

				arg_311_1.typewritter:SetDirty()
			end

			if arg_311_1.time_ >= var_314_0 + var_314_7 and arg_311_1.time_ < var_314_0 + var_314_7 + arg_314_0 then
				arg_311_1.typewritter.percent = 1

				arg_311_1.typewritter:SetDirty()
				arg_311_1:ShowNextGo(true)
			end
		end
	end,
	Play411051077 = function(arg_315_0, arg_315_1)
		arg_315_1.time_ = 0
		arg_315_1.frameCnt_ = 0
		arg_315_1.state_ = "playing"
		arg_315_1.curTalkId_ = 411051077
		arg_315_1.duration_ = 11

		local var_315_0 = {
			zh = 10.733,
			ja = 11
		}
		local var_315_1 = manager.audio:GetLocalizationFlag()

		if var_315_0[var_315_1] ~= nil then
			arg_315_1.duration_ = var_315_0[var_315_1]
		end

		SetActive(arg_315_1.tipsGo_, false)

		function arg_315_1.onSingleLineFinish_()
			arg_315_1.onSingleLineUpdate_ = nil
			arg_315_1.onSingleLineFinish_ = nil
			arg_315_1.state_ = "waiting"
		end

		function arg_315_1.playNext_(arg_317_0)
			if arg_317_0 == 1 then
				arg_315_0:Play411051078(arg_315_1)
			end
		end

		function arg_315_1.onSingleLineUpdate_(arg_318_0)
			local var_318_0 = 0
			local var_318_1 = 0.925

			if var_318_0 < arg_315_1.time_ and arg_315_1.time_ <= var_318_0 + arg_318_0 then
				arg_315_1.talkMaxDuration = 0
				arg_315_1.dialogCg_.alpha = 1

				arg_315_1.dialog_:SetActive(true)
				SetActive(arg_315_1.leftNameGo_, true)

				local var_318_2 = arg_315_1:FormatText(StoryNameCfg[675].name)

				arg_315_1.leftNameTxt_.text = var_318_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_315_1.leftNameTxt_.transform)

				arg_315_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_315_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_315_1:RecordName(arg_315_1.leftNameTxt_.text)
				SetActive(arg_315_1.iconTrs_.gameObject, true)
				arg_315_1.iconController_:SetSelectedState("hero")

				arg_315_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_315_1.callingController_:SetSelectedState("normal")

				local var_318_3 = arg_315_1:GetWordFromCfg(411051077)
				local var_318_4 = arg_315_1:FormatText(var_318_3.content)

				arg_315_1.text_.text = var_318_4

				LuaForUtil.ClearLinePrefixSymbol(arg_315_1.text_)

				local var_318_5 = 37
				local var_318_6 = utf8.len(var_318_4)
				local var_318_7 = var_318_5 <= 0 and var_318_1 or var_318_1 * (var_318_6 / var_318_5)

				if var_318_7 > 0 and var_318_1 < var_318_7 then
					arg_315_1.talkMaxDuration = var_318_7

					if var_318_7 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_7 + var_318_0
					end
				end

				arg_315_1.text_.text = var_318_4
				arg_315_1.typewritter.percent = 0

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") ~= 0 then
					local var_318_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051077", "story_v_out_411051.awb") / 1000

					if var_318_8 + var_318_0 > arg_315_1.duration_ then
						arg_315_1.duration_ = var_318_8 + var_318_0
					end

					if var_318_3.prefab_name ~= "" and arg_315_1.actors_[var_318_3.prefab_name] ~= nil then
						local var_318_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_315_1.actors_[var_318_3.prefab_name].transform, "story_v_out_411051", "411051077", "story_v_out_411051.awb")

						arg_315_1:RecordAudio("411051077", var_318_9)
						arg_315_1:RecordAudio("411051077", var_318_9)
					else
						arg_315_1:AudioAction("play", "voice", "story_v_out_411051", "411051077", "story_v_out_411051.awb")
					end

					arg_315_1:RecordHistoryTalkVoice("story_v_out_411051", "411051077", "story_v_out_411051.awb")
				end

				arg_315_1:RecordContent(arg_315_1.text_.text)
			end

			local var_318_10 = math.max(var_318_1, arg_315_1.talkMaxDuration)

			if var_318_0 <= arg_315_1.time_ and arg_315_1.time_ < var_318_0 + var_318_10 then
				arg_315_1.typewritter.percent = (arg_315_1.time_ - var_318_0) / var_318_10

				arg_315_1.typewritter:SetDirty()
			end

			if arg_315_1.time_ >= var_318_0 + var_318_10 and arg_315_1.time_ < var_318_0 + var_318_10 + arg_318_0 then
				arg_315_1.typewritter.percent = 1

				arg_315_1.typewritter:SetDirty()
				arg_315_1:ShowNextGo(true)
			end
		end
	end,
	Play411051078 = function(arg_319_0, arg_319_1)
		arg_319_1.time_ = 0
		arg_319_1.frameCnt_ = 0
		arg_319_1.state_ = "playing"
		arg_319_1.curTalkId_ = 411051078
		arg_319_1.duration_ = 5

		SetActive(arg_319_1.tipsGo_, false)

		function arg_319_1.onSingleLineFinish_()
			arg_319_1.onSingleLineUpdate_ = nil
			arg_319_1.onSingleLineFinish_ = nil
			arg_319_1.state_ = "waiting"
		end

		function arg_319_1.playNext_(arg_321_0)
			if arg_321_0 == 1 then
				arg_319_0:Play411051079(arg_319_1)
			end
		end

		function arg_319_1.onSingleLineUpdate_(arg_322_0)
			local var_322_0 = 0
			local var_322_1 = 0.975

			if var_322_0 < arg_319_1.time_ and arg_319_1.time_ <= var_322_0 + arg_322_0 then
				arg_319_1.talkMaxDuration = 0
				arg_319_1.dialogCg_.alpha = 1

				arg_319_1.dialog_:SetActive(true)
				SetActive(arg_319_1.leftNameGo_, false)

				arg_319_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_319_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_319_1:RecordName(arg_319_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_319_1.iconTrs_.gameObject, false)
				arg_319_1.callingController_:SetSelectedState("normal")

				local var_322_2 = arg_319_1:GetWordFromCfg(411051078)
				local var_322_3 = arg_319_1:FormatText(var_322_2.content)

				arg_319_1.text_.text = var_322_3

				LuaForUtil.ClearLinePrefixSymbol(arg_319_1.text_)

				local var_322_4 = 39
				local var_322_5 = utf8.len(var_322_3)
				local var_322_6 = var_322_4 <= 0 and var_322_1 or var_322_1 * (var_322_5 / var_322_4)

				if var_322_6 > 0 and var_322_1 < var_322_6 then
					arg_319_1.talkMaxDuration = var_322_6

					if var_322_6 + var_322_0 > arg_319_1.duration_ then
						arg_319_1.duration_ = var_322_6 + var_322_0
					end
				end

				arg_319_1.text_.text = var_322_3
				arg_319_1.typewritter.percent = 0

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(false)
				arg_319_1:RecordContent(arg_319_1.text_.text)
			end

			local var_322_7 = math.max(var_322_1, arg_319_1.talkMaxDuration)

			if var_322_0 <= arg_319_1.time_ and arg_319_1.time_ < var_322_0 + var_322_7 then
				arg_319_1.typewritter.percent = (arg_319_1.time_ - var_322_0) / var_322_7

				arg_319_1.typewritter:SetDirty()
			end

			if arg_319_1.time_ >= var_322_0 + var_322_7 and arg_319_1.time_ < var_322_0 + var_322_7 + arg_322_0 then
				arg_319_1.typewritter.percent = 1

				arg_319_1.typewritter:SetDirty()
				arg_319_1:ShowNextGo(true)
			end
		end
	end,
	Play411051079 = function(arg_323_0, arg_323_1)
		arg_323_1.time_ = 0
		arg_323_1.frameCnt_ = 0
		arg_323_1.state_ = "playing"
		arg_323_1.curTalkId_ = 411051079
		arg_323_1.duration_ = 5.266

		local var_323_0 = {
			zh = 3.666,
			ja = 5.266
		}
		local var_323_1 = manager.audio:GetLocalizationFlag()

		if var_323_0[var_323_1] ~= nil then
			arg_323_1.duration_ = var_323_0[var_323_1]
		end

		SetActive(arg_323_1.tipsGo_, false)

		function arg_323_1.onSingleLineFinish_()
			arg_323_1.onSingleLineUpdate_ = nil
			arg_323_1.onSingleLineFinish_ = nil
			arg_323_1.state_ = "waiting"
		end

		function arg_323_1.playNext_(arg_325_0)
			if arg_325_0 == 1 then
				arg_323_0:Play411051080(arg_323_1)
			end
		end

		function arg_323_1.onSingleLineUpdate_(arg_326_0)
			local var_326_0 = "1095ui_story"

			if arg_323_1.actors_[var_326_0] == nil then
				local var_326_1 = Object.Instantiate(Asset.Load("Char/" .. var_326_0), arg_323_1.stage_.transform)

				var_326_1.name = var_326_0
				var_326_1.transform.localPosition = Vector3.New(0, 100, 0)
				arg_323_1.actors_[var_326_0] = var_326_1

				local var_326_2 = var_326_1:GetComponentInChildren(typeof(CharacterEffect))

				var_326_2.enabled = true

				local var_326_3 = GameObjectTools.GetOrAddComponent(var_326_1, typeof(DynamicBoneHelper))

				if var_326_3 then
					var_326_3:EnableDynamicBone(false)
				end

				arg_323_1:ShowWeapon(var_326_2.transform, false)

				arg_323_1.var_[var_326_0 .. "Animator"] = var_326_2.gameObject:GetComponent(typeof(UnityEngine.Animator))
				arg_323_1.var_[var_326_0 .. "Animator"].applyRootMotion = true
				arg_323_1.var_[var_326_0 .. "LipSync"] = var_326_2.gameObject:GetComponentInChildren(typeof(RogoDigital.Lipsync.LipSync))
			end

			local var_326_4 = arg_323_1.actors_["1095ui_story"].transform
			local var_326_5 = 0

			if var_326_5 < arg_323_1.time_ and arg_323_1.time_ <= var_326_5 + arg_326_0 then
				arg_323_1.var_.moveOldPos1095ui_story = var_326_4.localPosition
			end

			local var_326_6 = 0.001

			if var_326_5 <= arg_323_1.time_ and arg_323_1.time_ < var_326_5 + var_326_6 then
				local var_326_7 = (arg_323_1.time_ - var_326_5) / var_326_6
				local var_326_8 = Vector3.New(0, -0.98, -6.1)

				var_326_4.localPosition = Vector3.Lerp(arg_323_1.var_.moveOldPos1095ui_story, var_326_8, var_326_7)

				local var_326_9 = manager.ui.mainCamera.transform.position - var_326_4.position

				var_326_4.forward = Vector3.New(var_326_9.x, var_326_9.y, var_326_9.z)

				local var_326_10 = var_326_4.localEulerAngles

				var_326_10.z = 0
				var_326_10.x = 0
				var_326_4.localEulerAngles = var_326_10
			end

			if arg_323_1.time_ >= var_326_5 + var_326_6 and arg_323_1.time_ < var_326_5 + var_326_6 + arg_326_0 then
				var_326_4.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_326_11 = manager.ui.mainCamera.transform.position - var_326_4.position

				var_326_4.forward = Vector3.New(var_326_11.x, var_326_11.y, var_326_11.z)

				local var_326_12 = var_326_4.localEulerAngles

				var_326_12.z = 0
				var_326_12.x = 0
				var_326_4.localEulerAngles = var_326_12
			end

			local var_326_13 = arg_323_1.actors_["1095ui_story"]
			local var_326_14 = 0

			if var_326_14 < arg_323_1.time_ and arg_323_1.time_ <= var_326_14 + arg_326_0 and arg_323_1.var_.characterEffect1095ui_story == nil then
				arg_323_1.var_.characterEffect1095ui_story = var_326_13:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_326_15 = 0.200000002980232

			if var_326_14 <= arg_323_1.time_ and arg_323_1.time_ < var_326_14 + var_326_15 then
				local var_326_16 = (arg_323_1.time_ - var_326_14) / var_326_15

				if arg_323_1.var_.characterEffect1095ui_story then
					arg_323_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_323_1.time_ >= var_326_14 + var_326_15 and arg_323_1.time_ < var_326_14 + var_326_15 + arg_326_0 and arg_323_1.var_.characterEffect1095ui_story then
				arg_323_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_326_17 = 0

			if var_326_17 < arg_323_1.time_ and arg_323_1.time_ <= var_326_17 + arg_326_0 then
				arg_323_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_326_18 = 0

			if var_326_18 < arg_323_1.time_ and arg_323_1.time_ <= var_326_18 + arg_326_0 then
				arg_323_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_326_19 = 0
			local var_326_20 = 0.375

			if var_326_19 < arg_323_1.time_ and arg_323_1.time_ <= var_326_19 + arg_326_0 then
				arg_323_1.talkMaxDuration = 0
				arg_323_1.dialogCg_.alpha = 1

				arg_323_1.dialog_:SetActive(true)
				SetActive(arg_323_1.leftNameGo_, true)

				local var_326_21 = arg_323_1:FormatText(StoryNameCfg[471].name)

				arg_323_1.leftNameTxt_.text = var_326_21

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_323_1.leftNameTxt_.transform)

				arg_323_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_323_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_323_1:RecordName(arg_323_1.leftNameTxt_.text)
				SetActive(arg_323_1.iconTrs_.gameObject, false)
				arg_323_1.callingController_:SetSelectedState("normal")

				local var_326_22 = arg_323_1:GetWordFromCfg(411051079)
				local var_326_23 = arg_323_1:FormatText(var_326_22.content)

				arg_323_1.text_.text = var_326_23

				LuaForUtil.ClearLinePrefixSymbol(arg_323_1.text_)

				local var_326_24 = 15
				local var_326_25 = utf8.len(var_326_23)
				local var_326_26 = var_326_24 <= 0 and var_326_20 or var_326_20 * (var_326_25 / var_326_24)

				if var_326_26 > 0 and var_326_20 < var_326_26 then
					arg_323_1.talkMaxDuration = var_326_26

					if var_326_26 + var_326_19 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_26 + var_326_19
					end
				end

				arg_323_1.text_.text = var_326_23
				arg_323_1.typewritter.percent = 0

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") ~= 0 then
					local var_326_27 = manager.audio:GetVoiceLength("story_v_out_411051", "411051079", "story_v_out_411051.awb") / 1000

					if var_326_27 + var_326_19 > arg_323_1.duration_ then
						arg_323_1.duration_ = var_326_27 + var_326_19
					end

					if var_326_22.prefab_name ~= "" and arg_323_1.actors_[var_326_22.prefab_name] ~= nil then
						local var_326_28 = LuaForUtil.PlayVoiceWithCriLipsync(arg_323_1.actors_[var_326_22.prefab_name].transform, "story_v_out_411051", "411051079", "story_v_out_411051.awb")

						arg_323_1:RecordAudio("411051079", var_326_28)
						arg_323_1:RecordAudio("411051079", var_326_28)
					else
						arg_323_1:AudioAction("play", "voice", "story_v_out_411051", "411051079", "story_v_out_411051.awb")
					end

					arg_323_1:RecordHistoryTalkVoice("story_v_out_411051", "411051079", "story_v_out_411051.awb")
				end

				arg_323_1:RecordContent(arg_323_1.text_.text)
			end

			local var_326_29 = math.max(var_326_20, arg_323_1.talkMaxDuration)

			if var_326_19 <= arg_323_1.time_ and arg_323_1.time_ < var_326_19 + var_326_29 then
				arg_323_1.typewritter.percent = (arg_323_1.time_ - var_326_19) / var_326_29

				arg_323_1.typewritter:SetDirty()
			end

			if arg_323_1.time_ >= var_326_19 + var_326_29 and arg_323_1.time_ < var_326_19 + var_326_29 + arg_326_0 then
				arg_323_1.typewritter.percent = 1

				arg_323_1.typewritter:SetDirty()
				arg_323_1:ShowNextGo(true)
			end
		end
	end,
	Play411051080 = function(arg_327_0, arg_327_1)
		arg_327_1.time_ = 0
		arg_327_1.frameCnt_ = 0
		arg_327_1.state_ = "playing"
		arg_327_1.curTalkId_ = 411051080
		arg_327_1.duration_ = 3.333

		local var_327_0 = {
			zh = 3.333,
			ja = 1.6
		}
		local var_327_1 = manager.audio:GetLocalizationFlag()

		if var_327_0[var_327_1] ~= nil then
			arg_327_1.duration_ = var_327_0[var_327_1]
		end

		SetActive(arg_327_1.tipsGo_, false)

		function arg_327_1.onSingleLineFinish_()
			arg_327_1.onSingleLineUpdate_ = nil
			arg_327_1.onSingleLineFinish_ = nil
			arg_327_1.state_ = "waiting"
		end

		function arg_327_1.playNext_(arg_329_0)
			if arg_329_0 == 1 then
				arg_327_0:Play411051081(arg_327_1)
			end
		end

		function arg_327_1.onSingleLineUpdate_(arg_330_0)
			local var_330_0 = arg_327_1.actors_["1095ui_story"]
			local var_330_1 = 0

			if var_330_1 < arg_327_1.time_ and arg_327_1.time_ <= var_330_1 + arg_330_0 and arg_327_1.var_.characterEffect1095ui_story == nil then
				arg_327_1.var_.characterEffect1095ui_story = var_330_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_330_2 = 0.200000002980232

			if var_330_1 <= arg_327_1.time_ and arg_327_1.time_ < var_330_1 + var_330_2 then
				local var_330_3 = (arg_327_1.time_ - var_330_1) / var_330_2

				if arg_327_1.var_.characterEffect1095ui_story then
					local var_330_4 = Mathf.Lerp(0, 0.5, var_330_3)

					arg_327_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_327_1.var_.characterEffect1095ui_story.fillRatio = var_330_4
				end
			end

			if arg_327_1.time_ >= var_330_1 + var_330_2 and arg_327_1.time_ < var_330_1 + var_330_2 + arg_330_0 and arg_327_1.var_.characterEffect1095ui_story then
				local var_330_5 = 0.5

				arg_327_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_327_1.var_.characterEffect1095ui_story.fillRatio = var_330_5
			end

			local var_330_6 = 0
			local var_330_7 = 0.225

			if var_330_6 < arg_327_1.time_ and arg_327_1.time_ <= var_330_6 + arg_330_0 then
				arg_327_1.talkMaxDuration = 0
				arg_327_1.dialogCg_.alpha = 1

				arg_327_1.dialog_:SetActive(true)
				SetActive(arg_327_1.leftNameGo_, true)

				local var_330_8 = arg_327_1:FormatText(StoryNameCfg[39].name)

				arg_327_1.leftNameTxt_.text = var_330_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_327_1.leftNameTxt_.transform)

				arg_327_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_327_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_327_1:RecordName(arg_327_1.leftNameTxt_.text)
				SetActive(arg_327_1.iconTrs_.gameObject, true)
				arg_327_1.iconController_:SetSelectedState("hero")

				arg_327_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_327_1.callingController_:SetSelectedState("normal")

				local var_330_9 = arg_327_1:GetWordFromCfg(411051080)
				local var_330_10 = arg_327_1:FormatText(var_330_9.content)

				arg_327_1.text_.text = var_330_10

				LuaForUtil.ClearLinePrefixSymbol(arg_327_1.text_)

				local var_330_11 = 9
				local var_330_12 = utf8.len(var_330_10)
				local var_330_13 = var_330_11 <= 0 and var_330_7 or var_330_7 * (var_330_12 / var_330_11)

				if var_330_13 > 0 and var_330_7 < var_330_13 then
					arg_327_1.talkMaxDuration = var_330_13

					if var_330_13 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_13 + var_330_6
					end
				end

				arg_327_1.text_.text = var_330_10
				arg_327_1.typewritter.percent = 0

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") ~= 0 then
					local var_330_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051080", "story_v_out_411051.awb") / 1000

					if var_330_14 + var_330_6 > arg_327_1.duration_ then
						arg_327_1.duration_ = var_330_14 + var_330_6
					end

					if var_330_9.prefab_name ~= "" and arg_327_1.actors_[var_330_9.prefab_name] ~= nil then
						local var_330_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_327_1.actors_[var_330_9.prefab_name].transform, "story_v_out_411051", "411051080", "story_v_out_411051.awb")

						arg_327_1:RecordAudio("411051080", var_330_15)
						arg_327_1:RecordAudio("411051080", var_330_15)
					else
						arg_327_1:AudioAction("play", "voice", "story_v_out_411051", "411051080", "story_v_out_411051.awb")
					end

					arg_327_1:RecordHistoryTalkVoice("story_v_out_411051", "411051080", "story_v_out_411051.awb")
				end

				arg_327_1:RecordContent(arg_327_1.text_.text)
			end

			local var_330_16 = math.max(var_330_7, arg_327_1.talkMaxDuration)

			if var_330_6 <= arg_327_1.time_ and arg_327_1.time_ < var_330_6 + var_330_16 then
				arg_327_1.typewritter.percent = (arg_327_1.time_ - var_330_6) / var_330_16

				arg_327_1.typewritter:SetDirty()
			end

			if arg_327_1.time_ >= var_330_6 + var_330_16 and arg_327_1.time_ < var_330_6 + var_330_16 + arg_330_0 then
				arg_327_1.typewritter.percent = 1

				arg_327_1.typewritter:SetDirty()
				arg_327_1:ShowNextGo(true)
			end
		end
	end,
	Play411051081 = function(arg_331_0, arg_331_1)
		arg_331_1.time_ = 0
		arg_331_1.frameCnt_ = 0
		arg_331_1.state_ = "playing"
		arg_331_1.curTalkId_ = 411051081
		arg_331_1.duration_ = 4

		local var_331_0 = {
			zh = 3.366,
			ja = 4
		}
		local var_331_1 = manager.audio:GetLocalizationFlag()

		if var_331_0[var_331_1] ~= nil then
			arg_331_1.duration_ = var_331_0[var_331_1]
		end

		SetActive(arg_331_1.tipsGo_, false)

		function arg_331_1.onSingleLineFinish_()
			arg_331_1.onSingleLineUpdate_ = nil
			arg_331_1.onSingleLineFinish_ = nil
			arg_331_1.state_ = "waiting"
		end

		function arg_331_1.playNext_(arg_333_0)
			if arg_333_0 == 1 then
				arg_331_0:Play411051082(arg_331_1)
			end
		end

		function arg_331_1.onSingleLineUpdate_(arg_334_0)
			local var_334_0 = arg_331_1.actors_["1095ui_story"]
			local var_334_1 = 0

			if var_334_1 < arg_331_1.time_ and arg_331_1.time_ <= var_334_1 + arg_334_0 and arg_331_1.var_.characterEffect1095ui_story == nil then
				arg_331_1.var_.characterEffect1095ui_story = var_334_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_334_2 = 0.200000002980232

			if var_334_1 <= arg_331_1.time_ and arg_331_1.time_ < var_334_1 + var_334_2 then
				local var_334_3 = (arg_331_1.time_ - var_334_1) / var_334_2

				if arg_331_1.var_.characterEffect1095ui_story then
					arg_331_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_331_1.time_ >= var_334_1 + var_334_2 and arg_331_1.time_ < var_334_1 + var_334_2 + arg_334_0 and arg_331_1.var_.characterEffect1095ui_story then
				arg_331_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_334_4 = 0
			local var_334_5 = 0.4

			if var_334_4 < arg_331_1.time_ and arg_331_1.time_ <= var_334_4 + arg_334_0 then
				arg_331_1.talkMaxDuration = 0
				arg_331_1.dialogCg_.alpha = 1

				arg_331_1.dialog_:SetActive(true)
				SetActive(arg_331_1.leftNameGo_, true)

				local var_334_6 = arg_331_1:FormatText(StoryNameCfg[471].name)

				arg_331_1.leftNameTxt_.text = var_334_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_331_1.leftNameTxt_.transform)

				arg_331_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_331_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_331_1:RecordName(arg_331_1.leftNameTxt_.text)
				SetActive(arg_331_1.iconTrs_.gameObject, false)
				arg_331_1.callingController_:SetSelectedState("normal")

				local var_334_7 = arg_331_1:GetWordFromCfg(411051081)
				local var_334_8 = arg_331_1:FormatText(var_334_7.content)

				arg_331_1.text_.text = var_334_8

				LuaForUtil.ClearLinePrefixSymbol(arg_331_1.text_)

				local var_334_9 = 16
				local var_334_10 = utf8.len(var_334_8)
				local var_334_11 = var_334_9 <= 0 and var_334_5 or var_334_5 * (var_334_10 / var_334_9)

				if var_334_11 > 0 and var_334_5 < var_334_11 then
					arg_331_1.talkMaxDuration = var_334_11

					if var_334_11 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_11 + var_334_4
					end
				end

				arg_331_1.text_.text = var_334_8
				arg_331_1.typewritter.percent = 0

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") ~= 0 then
					local var_334_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051081", "story_v_out_411051.awb") / 1000

					if var_334_12 + var_334_4 > arg_331_1.duration_ then
						arg_331_1.duration_ = var_334_12 + var_334_4
					end

					if var_334_7.prefab_name ~= "" and arg_331_1.actors_[var_334_7.prefab_name] ~= nil then
						local var_334_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_331_1.actors_[var_334_7.prefab_name].transform, "story_v_out_411051", "411051081", "story_v_out_411051.awb")

						arg_331_1:RecordAudio("411051081", var_334_13)
						arg_331_1:RecordAudio("411051081", var_334_13)
					else
						arg_331_1:AudioAction("play", "voice", "story_v_out_411051", "411051081", "story_v_out_411051.awb")
					end

					arg_331_1:RecordHistoryTalkVoice("story_v_out_411051", "411051081", "story_v_out_411051.awb")
				end

				arg_331_1:RecordContent(arg_331_1.text_.text)
			end

			local var_334_14 = math.max(var_334_5, arg_331_1.talkMaxDuration)

			if var_334_4 <= arg_331_1.time_ and arg_331_1.time_ < var_334_4 + var_334_14 then
				arg_331_1.typewritter.percent = (arg_331_1.time_ - var_334_4) / var_334_14

				arg_331_1.typewritter:SetDirty()
			end

			if arg_331_1.time_ >= var_334_4 + var_334_14 and arg_331_1.time_ < var_334_4 + var_334_14 + arg_334_0 then
				arg_331_1.typewritter.percent = 1

				arg_331_1.typewritter:SetDirty()
				arg_331_1:ShowNextGo(true)
			end
		end
	end,
	Play411051082 = function(arg_335_0, arg_335_1)
		arg_335_1.time_ = 0
		arg_335_1.frameCnt_ = 0
		arg_335_1.state_ = "playing"
		arg_335_1.curTalkId_ = 411051082
		arg_335_1.duration_ = 5

		SetActive(arg_335_1.tipsGo_, false)

		function arg_335_1.onSingleLineFinish_()
			arg_335_1.onSingleLineUpdate_ = nil
			arg_335_1.onSingleLineFinish_ = nil
			arg_335_1.state_ = "waiting"
		end

		function arg_335_1.playNext_(arg_337_0)
			if arg_337_0 == 1 then
				arg_335_0:Play411051083(arg_335_1)
			end
		end

		function arg_335_1.onSingleLineUpdate_(arg_338_0)
			local var_338_0 = arg_335_1.actors_["1095ui_story"]
			local var_338_1 = 0

			if var_338_1 < arg_335_1.time_ and arg_335_1.time_ <= var_338_1 + arg_338_0 and arg_335_1.var_.characterEffect1095ui_story == nil then
				arg_335_1.var_.characterEffect1095ui_story = var_338_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_338_2 = 0.200000002980232

			if var_338_1 <= arg_335_1.time_ and arg_335_1.time_ < var_338_1 + var_338_2 then
				local var_338_3 = (arg_335_1.time_ - var_338_1) / var_338_2

				if arg_335_1.var_.characterEffect1095ui_story then
					local var_338_4 = Mathf.Lerp(0, 0.5, var_338_3)

					arg_335_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_335_1.var_.characterEffect1095ui_story.fillRatio = var_338_4
				end
			end

			if arg_335_1.time_ >= var_338_1 + var_338_2 and arg_335_1.time_ < var_338_1 + var_338_2 + arg_338_0 and arg_335_1.var_.characterEffect1095ui_story then
				local var_338_5 = 0.5

				arg_335_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_335_1.var_.characterEffect1095ui_story.fillRatio = var_338_5
			end

			local var_338_6 = 0
			local var_338_7 = 1.175

			if var_338_6 < arg_335_1.time_ and arg_335_1.time_ <= var_338_6 + arg_338_0 then
				arg_335_1.talkMaxDuration = 0
				arg_335_1.dialogCg_.alpha = 1

				arg_335_1.dialog_:SetActive(true)
				SetActive(arg_335_1.leftNameGo_, false)

				arg_335_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_335_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_335_1:RecordName(arg_335_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_335_1.iconTrs_.gameObject, false)
				arg_335_1.callingController_:SetSelectedState("normal")

				local var_338_8 = arg_335_1:GetWordFromCfg(411051082)
				local var_338_9 = arg_335_1:FormatText(var_338_8.content)

				arg_335_1.text_.text = var_338_9

				LuaForUtil.ClearLinePrefixSymbol(arg_335_1.text_)

				local var_338_10 = 47
				local var_338_11 = utf8.len(var_338_9)
				local var_338_12 = var_338_10 <= 0 and var_338_7 or var_338_7 * (var_338_11 / var_338_10)

				if var_338_12 > 0 and var_338_7 < var_338_12 then
					arg_335_1.talkMaxDuration = var_338_12

					if var_338_12 + var_338_6 > arg_335_1.duration_ then
						arg_335_1.duration_ = var_338_12 + var_338_6
					end
				end

				arg_335_1.text_.text = var_338_9
				arg_335_1.typewritter.percent = 0

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(false)
				arg_335_1:RecordContent(arg_335_1.text_.text)
			end

			local var_338_13 = math.max(var_338_7, arg_335_1.talkMaxDuration)

			if var_338_6 <= arg_335_1.time_ and arg_335_1.time_ < var_338_6 + var_338_13 then
				arg_335_1.typewritter.percent = (arg_335_1.time_ - var_338_6) / var_338_13

				arg_335_1.typewritter:SetDirty()
			end

			if arg_335_1.time_ >= var_338_6 + var_338_13 and arg_335_1.time_ < var_338_6 + var_338_13 + arg_338_0 then
				arg_335_1.typewritter.percent = 1

				arg_335_1.typewritter:SetDirty()
				arg_335_1:ShowNextGo(true)
			end
		end
	end,
	Play411051083 = function(arg_339_0, arg_339_1)
		arg_339_1.time_ = 0
		arg_339_1.frameCnt_ = 0
		arg_339_1.state_ = "playing"
		arg_339_1.curTalkId_ = 411051083
		arg_339_1.duration_ = 2.166

		local var_339_0 = {
			zh = 1.3,
			ja = 2.166
		}
		local var_339_1 = manager.audio:GetLocalizationFlag()

		if var_339_0[var_339_1] ~= nil then
			arg_339_1.duration_ = var_339_0[var_339_1]
		end

		SetActive(arg_339_1.tipsGo_, false)

		function arg_339_1.onSingleLineFinish_()
			arg_339_1.onSingleLineUpdate_ = nil
			arg_339_1.onSingleLineFinish_ = nil
			arg_339_1.state_ = "waiting"
		end

		function arg_339_1.playNext_(arg_341_0)
			if arg_341_0 == 1 then
				arg_339_0:Play411051084(arg_339_1)
			end
		end

		function arg_339_1.onSingleLineUpdate_(arg_342_0)
			local var_342_0 = arg_339_1.actors_["1095ui_story"]
			local var_342_1 = 0

			if var_342_1 < arg_339_1.time_ and arg_339_1.time_ <= var_342_1 + arg_342_0 and arg_339_1.var_.characterEffect1095ui_story == nil then
				arg_339_1.var_.characterEffect1095ui_story = var_342_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_342_2 = 0.200000002980232

			if var_342_1 <= arg_339_1.time_ and arg_339_1.time_ < var_342_1 + var_342_2 then
				local var_342_3 = (arg_339_1.time_ - var_342_1) / var_342_2

				if arg_339_1.var_.characterEffect1095ui_story then
					arg_339_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_339_1.time_ >= var_342_1 + var_342_2 and arg_339_1.time_ < var_342_1 + var_342_2 + arg_342_0 and arg_339_1.var_.characterEffect1095ui_story then
				arg_339_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_342_4 = 0
			local var_342_5 = 0.125

			if var_342_4 < arg_339_1.time_ and arg_339_1.time_ <= var_342_4 + arg_342_0 then
				arg_339_1.talkMaxDuration = 0
				arg_339_1.dialogCg_.alpha = 1

				arg_339_1.dialog_:SetActive(true)
				SetActive(arg_339_1.leftNameGo_, true)

				local var_342_6 = arg_339_1:FormatText(StoryNameCfg[471].name)

				arg_339_1.leftNameTxt_.text = var_342_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_339_1.leftNameTxt_.transform)

				arg_339_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_339_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_339_1:RecordName(arg_339_1.leftNameTxt_.text)
				SetActive(arg_339_1.iconTrs_.gameObject, false)
				arg_339_1.callingController_:SetSelectedState("normal")

				local var_342_7 = arg_339_1:GetWordFromCfg(411051083)
				local var_342_8 = arg_339_1:FormatText(var_342_7.content)

				arg_339_1.text_.text = var_342_8

				LuaForUtil.ClearLinePrefixSymbol(arg_339_1.text_)

				local var_342_9 = 5
				local var_342_10 = utf8.len(var_342_8)
				local var_342_11 = var_342_9 <= 0 and var_342_5 or var_342_5 * (var_342_10 / var_342_9)

				if var_342_11 > 0 and var_342_5 < var_342_11 then
					arg_339_1.talkMaxDuration = var_342_11

					if var_342_11 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_11 + var_342_4
					end
				end

				arg_339_1.text_.text = var_342_8
				arg_339_1.typewritter.percent = 0

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") ~= 0 then
					local var_342_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051083", "story_v_out_411051.awb") / 1000

					if var_342_12 + var_342_4 > arg_339_1.duration_ then
						arg_339_1.duration_ = var_342_12 + var_342_4
					end

					if var_342_7.prefab_name ~= "" and arg_339_1.actors_[var_342_7.prefab_name] ~= nil then
						local var_342_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_339_1.actors_[var_342_7.prefab_name].transform, "story_v_out_411051", "411051083", "story_v_out_411051.awb")

						arg_339_1:RecordAudio("411051083", var_342_13)
						arg_339_1:RecordAudio("411051083", var_342_13)
					else
						arg_339_1:AudioAction("play", "voice", "story_v_out_411051", "411051083", "story_v_out_411051.awb")
					end

					arg_339_1:RecordHistoryTalkVoice("story_v_out_411051", "411051083", "story_v_out_411051.awb")
				end

				arg_339_1:RecordContent(arg_339_1.text_.text)
			end

			local var_342_14 = math.max(var_342_5, arg_339_1.talkMaxDuration)

			if var_342_4 <= arg_339_1.time_ and arg_339_1.time_ < var_342_4 + var_342_14 then
				arg_339_1.typewritter.percent = (arg_339_1.time_ - var_342_4) / var_342_14

				arg_339_1.typewritter:SetDirty()
			end

			if arg_339_1.time_ >= var_342_4 + var_342_14 and arg_339_1.time_ < var_342_4 + var_342_14 + arg_342_0 then
				arg_339_1.typewritter.percent = 1

				arg_339_1.typewritter:SetDirty()
				arg_339_1:ShowNextGo(true)
			end
		end
	end,
	Play411051084 = function(arg_343_0, arg_343_1)
		arg_343_1.time_ = 0
		arg_343_1.frameCnt_ = 0
		arg_343_1.state_ = "playing"
		arg_343_1.curTalkId_ = 411051084
		arg_343_1.duration_ = 6.566

		local var_343_0 = {
			zh = 5.166,
			ja = 6.566
		}
		local var_343_1 = manager.audio:GetLocalizationFlag()

		if var_343_0[var_343_1] ~= nil then
			arg_343_1.duration_ = var_343_0[var_343_1]
		end

		SetActive(arg_343_1.tipsGo_, false)

		function arg_343_1.onSingleLineFinish_()
			arg_343_1.onSingleLineUpdate_ = nil
			arg_343_1.onSingleLineFinish_ = nil
			arg_343_1.state_ = "waiting"
		end

		function arg_343_1.playNext_(arg_345_0)
			if arg_345_0 == 1 then
				arg_343_0:Play411051085(arg_343_1)
			end
		end

		function arg_343_1.onSingleLineUpdate_(arg_346_0)
			local var_346_0 = 0
			local var_346_1 = 0.625

			if var_346_0 < arg_343_1.time_ and arg_343_1.time_ <= var_346_0 + arg_346_0 then
				arg_343_1.talkMaxDuration = 0
				arg_343_1.dialogCg_.alpha = 1

				arg_343_1.dialog_:SetActive(true)
				SetActive(arg_343_1.leftNameGo_, true)

				local var_346_2 = arg_343_1:FormatText(StoryNameCfg[39].name)

				arg_343_1.leftNameTxt_.text = var_346_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_343_1.leftNameTxt_.transform)

				arg_343_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_343_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_343_1:RecordName(arg_343_1.leftNameTxt_.text)
				SetActive(arg_343_1.iconTrs_.gameObject, true)
				arg_343_1.iconController_:SetSelectedState("hero")

				arg_343_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_343_1.callingController_:SetSelectedState("normal")

				local var_346_3 = arg_343_1:GetWordFromCfg(411051084)
				local var_346_4 = arg_343_1:FormatText(var_346_3.content)

				arg_343_1.text_.text = var_346_4

				LuaForUtil.ClearLinePrefixSymbol(arg_343_1.text_)

				local var_346_5 = 25
				local var_346_6 = utf8.len(var_346_4)
				local var_346_7 = var_346_5 <= 0 and var_346_1 or var_346_1 * (var_346_6 / var_346_5)

				if var_346_7 > 0 and var_346_1 < var_346_7 then
					arg_343_1.talkMaxDuration = var_346_7

					if var_346_7 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_7 + var_346_0
					end
				end

				arg_343_1.text_.text = var_346_4
				arg_343_1.typewritter.percent = 0

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") ~= 0 then
					local var_346_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051084", "story_v_out_411051.awb") / 1000

					if var_346_8 + var_346_0 > arg_343_1.duration_ then
						arg_343_1.duration_ = var_346_8 + var_346_0
					end

					if var_346_3.prefab_name ~= "" and arg_343_1.actors_[var_346_3.prefab_name] ~= nil then
						local var_346_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_343_1.actors_[var_346_3.prefab_name].transform, "story_v_out_411051", "411051084", "story_v_out_411051.awb")

						arg_343_1:RecordAudio("411051084", var_346_9)
						arg_343_1:RecordAudio("411051084", var_346_9)
					else
						arg_343_1:AudioAction("play", "voice", "story_v_out_411051", "411051084", "story_v_out_411051.awb")
					end

					arg_343_1:RecordHistoryTalkVoice("story_v_out_411051", "411051084", "story_v_out_411051.awb")
				end

				arg_343_1:RecordContent(arg_343_1.text_.text)
			end

			local var_346_10 = math.max(var_346_1, arg_343_1.talkMaxDuration)

			if var_346_0 <= arg_343_1.time_ and arg_343_1.time_ < var_346_0 + var_346_10 then
				arg_343_1.typewritter.percent = (arg_343_1.time_ - var_346_0) / var_346_10

				arg_343_1.typewritter:SetDirty()
			end

			if arg_343_1.time_ >= var_346_0 + var_346_10 and arg_343_1.time_ < var_346_0 + var_346_10 + arg_346_0 then
				arg_343_1.typewritter.percent = 1

				arg_343_1.typewritter:SetDirty()
				arg_343_1:ShowNextGo(true)
			end
		end
	end,
	Play411051085 = function(arg_347_0, arg_347_1)
		arg_347_1.time_ = 0
		arg_347_1.frameCnt_ = 0
		arg_347_1.state_ = "playing"
		arg_347_1.curTalkId_ = 411051085
		arg_347_1.duration_ = 6.533

		local var_347_0 = {
			zh = 5.933,
			ja = 6.533
		}
		local var_347_1 = manager.audio:GetLocalizationFlag()

		if var_347_0[var_347_1] ~= nil then
			arg_347_1.duration_ = var_347_0[var_347_1]
		end

		SetActive(arg_347_1.tipsGo_, false)

		function arg_347_1.onSingleLineFinish_()
			arg_347_1.onSingleLineUpdate_ = nil
			arg_347_1.onSingleLineFinish_ = nil
			arg_347_1.state_ = "waiting"
		end

		function arg_347_1.playNext_(arg_349_0)
			if arg_349_0 == 1 then
				arg_347_0:Play411051086(arg_347_1)
			end
		end

		function arg_347_1.onSingleLineUpdate_(arg_350_0)
			local var_350_0 = arg_347_1.actors_["1095ui_story"]
			local var_350_1 = 0

			if var_350_1 < arg_347_1.time_ and arg_347_1.time_ <= var_350_1 + arg_350_0 and arg_347_1.var_.characterEffect1095ui_story == nil then
				arg_347_1.var_.characterEffect1095ui_story = var_350_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_350_2 = 0.200000002980232

			if var_350_1 <= arg_347_1.time_ and arg_347_1.time_ < var_350_1 + var_350_2 then
				local var_350_3 = (arg_347_1.time_ - var_350_1) / var_350_2

				if arg_347_1.var_.characterEffect1095ui_story then
					arg_347_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_347_1.time_ >= var_350_1 + var_350_2 and arg_347_1.time_ < var_350_1 + var_350_2 + arg_350_0 and arg_347_1.var_.characterEffect1095ui_story then
				arg_347_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_350_4 = 0
			local var_350_5 = 0.7

			if var_350_4 < arg_347_1.time_ and arg_347_1.time_ <= var_350_4 + arg_350_0 then
				arg_347_1.talkMaxDuration = 0
				arg_347_1.dialogCg_.alpha = 1

				arg_347_1.dialog_:SetActive(true)
				SetActive(arg_347_1.leftNameGo_, true)

				local var_350_6 = arg_347_1:FormatText(StoryNameCfg[471].name)

				arg_347_1.leftNameTxt_.text = var_350_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_347_1.leftNameTxt_.transform)

				arg_347_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_347_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_347_1:RecordName(arg_347_1.leftNameTxt_.text)
				SetActive(arg_347_1.iconTrs_.gameObject, false)
				arg_347_1.callingController_:SetSelectedState("normal")

				local var_350_7 = arg_347_1:GetWordFromCfg(411051085)
				local var_350_8 = arg_347_1:FormatText(var_350_7.content)

				arg_347_1.text_.text = var_350_8

				LuaForUtil.ClearLinePrefixSymbol(arg_347_1.text_)

				local var_350_9 = 28
				local var_350_10 = utf8.len(var_350_8)
				local var_350_11 = var_350_9 <= 0 and var_350_5 or var_350_5 * (var_350_10 / var_350_9)

				if var_350_11 > 0 and var_350_5 < var_350_11 then
					arg_347_1.talkMaxDuration = var_350_11

					if var_350_11 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_11 + var_350_4
					end
				end

				arg_347_1.text_.text = var_350_8
				arg_347_1.typewritter.percent = 0

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") ~= 0 then
					local var_350_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051085", "story_v_out_411051.awb") / 1000

					if var_350_12 + var_350_4 > arg_347_1.duration_ then
						arg_347_1.duration_ = var_350_12 + var_350_4
					end

					if var_350_7.prefab_name ~= "" and arg_347_1.actors_[var_350_7.prefab_name] ~= nil then
						local var_350_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_347_1.actors_[var_350_7.prefab_name].transform, "story_v_out_411051", "411051085", "story_v_out_411051.awb")

						arg_347_1:RecordAudio("411051085", var_350_13)
						arg_347_1:RecordAudio("411051085", var_350_13)
					else
						arg_347_1:AudioAction("play", "voice", "story_v_out_411051", "411051085", "story_v_out_411051.awb")
					end

					arg_347_1:RecordHistoryTalkVoice("story_v_out_411051", "411051085", "story_v_out_411051.awb")
				end

				arg_347_1:RecordContent(arg_347_1.text_.text)
			end

			local var_350_14 = math.max(var_350_5, arg_347_1.talkMaxDuration)

			if var_350_4 <= arg_347_1.time_ and arg_347_1.time_ < var_350_4 + var_350_14 then
				arg_347_1.typewritter.percent = (arg_347_1.time_ - var_350_4) / var_350_14

				arg_347_1.typewritter:SetDirty()
			end

			if arg_347_1.time_ >= var_350_4 + var_350_14 and arg_347_1.time_ < var_350_4 + var_350_14 + arg_350_0 then
				arg_347_1.typewritter.percent = 1

				arg_347_1.typewritter:SetDirty()
				arg_347_1:ShowNextGo(true)
			end
		end
	end,
	Play411051086 = function(arg_351_0, arg_351_1)
		arg_351_1.time_ = 0
		arg_351_1.frameCnt_ = 0
		arg_351_1.state_ = "playing"
		arg_351_1.curTalkId_ = 411051086
		arg_351_1.duration_ = 5.3

		local var_351_0 = {
			zh = 5.3,
			ja = 5.1
		}
		local var_351_1 = manager.audio:GetLocalizationFlag()

		if var_351_0[var_351_1] ~= nil then
			arg_351_1.duration_ = var_351_0[var_351_1]
		end

		SetActive(arg_351_1.tipsGo_, false)

		function arg_351_1.onSingleLineFinish_()
			arg_351_1.onSingleLineUpdate_ = nil
			arg_351_1.onSingleLineFinish_ = nil
			arg_351_1.state_ = "waiting"
		end

		function arg_351_1.playNext_(arg_353_0)
			if arg_353_0 == 1 then
				arg_351_0:Play411051087(arg_351_1)
			end
		end

		function arg_351_1.onSingleLineUpdate_(arg_354_0)
			local var_354_0 = 0
			local var_354_1 = 0.7

			if var_354_0 < arg_351_1.time_ and arg_351_1.time_ <= var_354_0 + arg_354_0 then
				arg_351_1.talkMaxDuration = 0
				arg_351_1.dialogCg_.alpha = 1

				arg_351_1.dialog_:SetActive(true)
				SetActive(arg_351_1.leftNameGo_, true)

				local var_354_2 = arg_351_1:FormatText(StoryNameCfg[471].name)

				arg_351_1.leftNameTxt_.text = var_354_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_351_1.leftNameTxt_.transform)

				arg_351_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_351_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_351_1:RecordName(arg_351_1.leftNameTxt_.text)
				SetActive(arg_351_1.iconTrs_.gameObject, false)
				arg_351_1.callingController_:SetSelectedState("normal")

				local var_354_3 = arg_351_1:GetWordFromCfg(411051086)
				local var_354_4 = arg_351_1:FormatText(var_354_3.content)

				arg_351_1.text_.text = var_354_4

				LuaForUtil.ClearLinePrefixSymbol(arg_351_1.text_)

				local var_354_5 = 28
				local var_354_6 = utf8.len(var_354_4)
				local var_354_7 = var_354_5 <= 0 and var_354_1 or var_354_1 * (var_354_6 / var_354_5)

				if var_354_7 > 0 and var_354_1 < var_354_7 then
					arg_351_1.talkMaxDuration = var_354_7

					if var_354_7 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_7 + var_354_0
					end
				end

				arg_351_1.text_.text = var_354_4
				arg_351_1.typewritter.percent = 0

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") ~= 0 then
					local var_354_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051086", "story_v_out_411051.awb") / 1000

					if var_354_8 + var_354_0 > arg_351_1.duration_ then
						arg_351_1.duration_ = var_354_8 + var_354_0
					end

					if var_354_3.prefab_name ~= "" and arg_351_1.actors_[var_354_3.prefab_name] ~= nil then
						local var_354_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_351_1.actors_[var_354_3.prefab_name].transform, "story_v_out_411051", "411051086", "story_v_out_411051.awb")

						arg_351_1:RecordAudio("411051086", var_354_9)
						arg_351_1:RecordAudio("411051086", var_354_9)
					else
						arg_351_1:AudioAction("play", "voice", "story_v_out_411051", "411051086", "story_v_out_411051.awb")
					end

					arg_351_1:RecordHistoryTalkVoice("story_v_out_411051", "411051086", "story_v_out_411051.awb")
				end

				arg_351_1:RecordContent(arg_351_1.text_.text)
			end

			local var_354_10 = math.max(var_354_1, arg_351_1.talkMaxDuration)

			if var_354_0 <= arg_351_1.time_ and arg_351_1.time_ < var_354_0 + var_354_10 then
				arg_351_1.typewritter.percent = (arg_351_1.time_ - var_354_0) / var_354_10

				arg_351_1.typewritter:SetDirty()
			end

			if arg_351_1.time_ >= var_354_0 + var_354_10 and arg_351_1.time_ < var_354_0 + var_354_10 + arg_354_0 then
				arg_351_1.typewritter.percent = 1

				arg_351_1.typewritter:SetDirty()
				arg_351_1:ShowNextGo(true)
			end
		end
	end,
	Play411051087 = function(arg_355_0, arg_355_1)
		arg_355_1.time_ = 0
		arg_355_1.frameCnt_ = 0
		arg_355_1.state_ = "playing"
		arg_355_1.curTalkId_ = 411051087
		arg_355_1.duration_ = 2.333

		local var_355_0 = {
			zh = 2.2,
			ja = 2.333
		}
		local var_355_1 = manager.audio:GetLocalizationFlag()

		if var_355_0[var_355_1] ~= nil then
			arg_355_1.duration_ = var_355_0[var_355_1]
		end

		SetActive(arg_355_1.tipsGo_, false)

		function arg_355_1.onSingleLineFinish_()
			arg_355_1.onSingleLineUpdate_ = nil
			arg_355_1.onSingleLineFinish_ = nil
			arg_355_1.state_ = "waiting"
		end

		function arg_355_1.playNext_(arg_357_0)
			if arg_357_0 == 1 then
				arg_355_0:Play411051088(arg_355_1)
			end
		end

		function arg_355_1.onSingleLineUpdate_(arg_358_0)
			local var_358_0 = arg_355_1.actors_["1095ui_story"]
			local var_358_1 = 0

			if var_358_1 < arg_355_1.time_ and arg_355_1.time_ <= var_358_1 + arg_358_0 and arg_355_1.var_.characterEffect1095ui_story == nil then
				arg_355_1.var_.characterEffect1095ui_story = var_358_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_358_2 = 0.200000002980232

			if var_358_1 <= arg_355_1.time_ and arg_355_1.time_ < var_358_1 + var_358_2 then
				local var_358_3 = (arg_355_1.time_ - var_358_1) / var_358_2

				if arg_355_1.var_.characterEffect1095ui_story then
					local var_358_4 = Mathf.Lerp(0, 0.5, var_358_3)

					arg_355_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_355_1.var_.characterEffect1095ui_story.fillRatio = var_358_4
				end
			end

			if arg_355_1.time_ >= var_358_1 + var_358_2 and arg_355_1.time_ < var_358_1 + var_358_2 + arg_358_0 and arg_355_1.var_.characterEffect1095ui_story then
				local var_358_5 = 0.5

				arg_355_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_355_1.var_.characterEffect1095ui_story.fillRatio = var_358_5
			end

			local var_358_6 = 0
			local var_358_7 = 0.15

			if var_358_6 < arg_355_1.time_ and arg_355_1.time_ <= var_358_6 + arg_358_0 then
				arg_355_1.talkMaxDuration = 0
				arg_355_1.dialogCg_.alpha = 1

				arg_355_1.dialog_:SetActive(true)
				SetActive(arg_355_1.leftNameGo_, true)

				local var_358_8 = arg_355_1:FormatText(StoryNameCfg[39].name)

				arg_355_1.leftNameTxt_.text = var_358_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_355_1.leftNameTxt_.transform)

				arg_355_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_355_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_355_1:RecordName(arg_355_1.leftNameTxt_.text)
				SetActive(arg_355_1.iconTrs_.gameObject, true)
				arg_355_1.iconController_:SetSelectedState("hero")

				arg_355_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_355_1.callingController_:SetSelectedState("normal")

				local var_358_9 = arg_355_1:GetWordFromCfg(411051087)
				local var_358_10 = arg_355_1:FormatText(var_358_9.content)

				arg_355_1.text_.text = var_358_10

				LuaForUtil.ClearLinePrefixSymbol(arg_355_1.text_)

				local var_358_11 = 6
				local var_358_12 = utf8.len(var_358_10)
				local var_358_13 = var_358_11 <= 0 and var_358_7 or var_358_7 * (var_358_12 / var_358_11)

				if var_358_13 > 0 and var_358_7 < var_358_13 then
					arg_355_1.talkMaxDuration = var_358_13

					if var_358_13 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_13 + var_358_6
					end
				end

				arg_355_1.text_.text = var_358_10
				arg_355_1.typewritter.percent = 0

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") ~= 0 then
					local var_358_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051087", "story_v_out_411051.awb") / 1000

					if var_358_14 + var_358_6 > arg_355_1.duration_ then
						arg_355_1.duration_ = var_358_14 + var_358_6
					end

					if var_358_9.prefab_name ~= "" and arg_355_1.actors_[var_358_9.prefab_name] ~= nil then
						local var_358_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_355_1.actors_[var_358_9.prefab_name].transform, "story_v_out_411051", "411051087", "story_v_out_411051.awb")

						arg_355_1:RecordAudio("411051087", var_358_15)
						arg_355_1:RecordAudio("411051087", var_358_15)
					else
						arg_355_1:AudioAction("play", "voice", "story_v_out_411051", "411051087", "story_v_out_411051.awb")
					end

					arg_355_1:RecordHistoryTalkVoice("story_v_out_411051", "411051087", "story_v_out_411051.awb")
				end

				arg_355_1:RecordContent(arg_355_1.text_.text)
			end

			local var_358_16 = math.max(var_358_7, arg_355_1.talkMaxDuration)

			if var_358_6 <= arg_355_1.time_ and arg_355_1.time_ < var_358_6 + var_358_16 then
				arg_355_1.typewritter.percent = (arg_355_1.time_ - var_358_6) / var_358_16

				arg_355_1.typewritter:SetDirty()
			end

			if arg_355_1.time_ >= var_358_6 + var_358_16 and arg_355_1.time_ < var_358_6 + var_358_16 + arg_358_0 then
				arg_355_1.typewritter.percent = 1

				arg_355_1.typewritter:SetDirty()
				arg_355_1:ShowNextGo(true)
			end
		end
	end,
	Play411051088 = function(arg_359_0, arg_359_1)
		arg_359_1.time_ = 0
		arg_359_1.frameCnt_ = 0
		arg_359_1.state_ = "playing"
		arg_359_1.curTalkId_ = 411051088
		arg_359_1.duration_ = 5

		SetActive(arg_359_1.tipsGo_, false)

		function arg_359_1.onSingleLineFinish_()
			arg_359_1.onSingleLineUpdate_ = nil
			arg_359_1.onSingleLineFinish_ = nil
			arg_359_1.state_ = "waiting"
		end

		function arg_359_1.playNext_(arg_361_0)
			if arg_361_0 == 1 then
				arg_359_0:Play411051089(arg_359_1)
			end
		end

		function arg_359_1.onSingleLineUpdate_(arg_362_0)
			local var_362_0 = arg_359_1.actors_["1095ui_story"]
			local var_362_1 = 0

			if var_362_1 < arg_359_1.time_ and arg_359_1.time_ <= var_362_1 + arg_362_0 and arg_359_1.var_.characterEffect1095ui_story == nil then
				arg_359_1.var_.characterEffect1095ui_story = var_362_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_362_2 = 0.200000002980232

			if var_362_1 <= arg_359_1.time_ and arg_359_1.time_ < var_362_1 + var_362_2 then
				local var_362_3 = (arg_359_1.time_ - var_362_1) / var_362_2

				if arg_359_1.var_.characterEffect1095ui_story then
					local var_362_4 = Mathf.Lerp(0, 0.5, var_362_3)

					arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_359_1.var_.characterEffect1095ui_story.fillRatio = var_362_4
				end
			end

			if arg_359_1.time_ >= var_362_1 + var_362_2 and arg_359_1.time_ < var_362_1 + var_362_2 + arg_362_0 and arg_359_1.var_.characterEffect1095ui_story then
				local var_362_5 = 0.5

				arg_359_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_359_1.var_.characterEffect1095ui_story.fillRatio = var_362_5
			end

			local var_362_6 = 0
			local var_362_7 = 0.825

			if var_362_6 < arg_359_1.time_ and arg_359_1.time_ <= var_362_6 + arg_362_0 then
				arg_359_1.talkMaxDuration = 0
				arg_359_1.dialogCg_.alpha = 1

				arg_359_1.dialog_:SetActive(true)
				SetActive(arg_359_1.leftNameGo_, false)

				arg_359_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_359_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_359_1:RecordName(arg_359_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_359_1.iconTrs_.gameObject, false)
				arg_359_1.callingController_:SetSelectedState("normal")

				local var_362_8 = arg_359_1:GetWordFromCfg(411051088)
				local var_362_9 = arg_359_1:FormatText(var_362_8.content)

				arg_359_1.text_.text = var_362_9

				LuaForUtil.ClearLinePrefixSymbol(arg_359_1.text_)

				local var_362_10 = 33
				local var_362_11 = utf8.len(var_362_9)
				local var_362_12 = var_362_10 <= 0 and var_362_7 or var_362_7 * (var_362_11 / var_362_10)

				if var_362_12 > 0 and var_362_7 < var_362_12 then
					arg_359_1.talkMaxDuration = var_362_12

					if var_362_12 + var_362_6 > arg_359_1.duration_ then
						arg_359_1.duration_ = var_362_12 + var_362_6
					end
				end

				arg_359_1.text_.text = var_362_9
				arg_359_1.typewritter.percent = 0

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(false)
				arg_359_1:RecordContent(arg_359_1.text_.text)
			end

			local var_362_13 = math.max(var_362_7, arg_359_1.talkMaxDuration)

			if var_362_6 <= arg_359_1.time_ and arg_359_1.time_ < var_362_6 + var_362_13 then
				arg_359_1.typewritter.percent = (arg_359_1.time_ - var_362_6) / var_362_13

				arg_359_1.typewritter:SetDirty()
			end

			if arg_359_1.time_ >= var_362_6 + var_362_13 and arg_359_1.time_ < var_362_6 + var_362_13 + arg_362_0 then
				arg_359_1.typewritter.percent = 1

				arg_359_1.typewritter:SetDirty()
				arg_359_1:ShowNextGo(true)
			end
		end
	end,
	Play411051089 = function(arg_363_0, arg_363_1)
		arg_363_1.time_ = 0
		arg_363_1.frameCnt_ = 0
		arg_363_1.state_ = "playing"
		arg_363_1.curTalkId_ = 411051089
		arg_363_1.duration_ = 5.466

		local var_363_0 = {
			zh = 4.833,
			ja = 5.466
		}
		local var_363_1 = manager.audio:GetLocalizationFlag()

		if var_363_0[var_363_1] ~= nil then
			arg_363_1.duration_ = var_363_0[var_363_1]
		end

		SetActive(arg_363_1.tipsGo_, false)

		function arg_363_1.onSingleLineFinish_()
			arg_363_1.onSingleLineUpdate_ = nil
			arg_363_1.onSingleLineFinish_ = nil
			arg_363_1.state_ = "waiting"
		end

		function arg_363_1.playNext_(arg_365_0)
			if arg_365_0 == 1 then
				arg_363_0:Play411051090(arg_363_1)
			end
		end

		function arg_363_1.onSingleLineUpdate_(arg_366_0)
			local var_366_0 = 0
			local var_366_1 = 0.575

			if var_366_0 < arg_363_1.time_ and arg_363_1.time_ <= var_366_0 + arg_366_0 then
				arg_363_1.talkMaxDuration = 0
				arg_363_1.dialogCg_.alpha = 1

				arg_363_1.dialog_:SetActive(true)
				SetActive(arg_363_1.leftNameGo_, true)

				local var_366_2 = arg_363_1:FormatText(StoryNameCfg[39].name)

				arg_363_1.leftNameTxt_.text = var_366_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_363_1.leftNameTxt_.transform)

				arg_363_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_363_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_363_1:RecordName(arg_363_1.leftNameTxt_.text)
				SetActive(arg_363_1.iconTrs_.gameObject, true)
				arg_363_1.iconController_:SetSelectedState("hero")

				arg_363_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_363_1.callingController_:SetSelectedState("normal")

				local var_366_3 = arg_363_1:GetWordFromCfg(411051089)
				local var_366_4 = arg_363_1:FormatText(var_366_3.content)

				arg_363_1.text_.text = var_366_4

				LuaForUtil.ClearLinePrefixSymbol(arg_363_1.text_)

				local var_366_5 = 23
				local var_366_6 = utf8.len(var_366_4)
				local var_366_7 = var_366_5 <= 0 and var_366_1 or var_366_1 * (var_366_6 / var_366_5)

				if var_366_7 > 0 and var_366_1 < var_366_7 then
					arg_363_1.talkMaxDuration = var_366_7

					if var_366_7 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_7 + var_366_0
					end
				end

				arg_363_1.text_.text = var_366_4
				arg_363_1.typewritter.percent = 0

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") ~= 0 then
					local var_366_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051089", "story_v_out_411051.awb") / 1000

					if var_366_8 + var_366_0 > arg_363_1.duration_ then
						arg_363_1.duration_ = var_366_8 + var_366_0
					end

					if var_366_3.prefab_name ~= "" and arg_363_1.actors_[var_366_3.prefab_name] ~= nil then
						local var_366_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_363_1.actors_[var_366_3.prefab_name].transform, "story_v_out_411051", "411051089", "story_v_out_411051.awb")

						arg_363_1:RecordAudio("411051089", var_366_9)
						arg_363_1:RecordAudio("411051089", var_366_9)
					else
						arg_363_1:AudioAction("play", "voice", "story_v_out_411051", "411051089", "story_v_out_411051.awb")
					end

					arg_363_1:RecordHistoryTalkVoice("story_v_out_411051", "411051089", "story_v_out_411051.awb")
				end

				arg_363_1:RecordContent(arg_363_1.text_.text)
			end

			local var_366_10 = math.max(var_366_1, arg_363_1.talkMaxDuration)

			if var_366_0 <= arg_363_1.time_ and arg_363_1.time_ < var_366_0 + var_366_10 then
				arg_363_1.typewritter.percent = (arg_363_1.time_ - var_366_0) / var_366_10

				arg_363_1.typewritter:SetDirty()
			end

			if arg_363_1.time_ >= var_366_0 + var_366_10 and arg_363_1.time_ < var_366_0 + var_366_10 + arg_366_0 then
				arg_363_1.typewritter.percent = 1

				arg_363_1.typewritter:SetDirty()
				arg_363_1:ShowNextGo(true)
			end
		end
	end,
	Play411051090 = function(arg_367_0, arg_367_1)
		arg_367_1.time_ = 0
		arg_367_1.frameCnt_ = 0
		arg_367_1.state_ = "playing"
		arg_367_1.curTalkId_ = 411051090
		arg_367_1.duration_ = 1.3

		local var_367_0 = {
			zh = 1.1,
			ja = 1.3
		}
		local var_367_1 = manager.audio:GetLocalizationFlag()

		if var_367_0[var_367_1] ~= nil then
			arg_367_1.duration_ = var_367_0[var_367_1]
		end

		SetActive(arg_367_1.tipsGo_, false)

		function arg_367_1.onSingleLineFinish_()
			arg_367_1.onSingleLineUpdate_ = nil
			arg_367_1.onSingleLineFinish_ = nil
			arg_367_1.state_ = "waiting"
		end

		function arg_367_1.playNext_(arg_369_0)
			if arg_369_0 == 1 then
				arg_367_0:Play411051091(arg_367_1)
			end
		end

		function arg_367_1.onSingleLineUpdate_(arg_370_0)
			local var_370_0 = arg_367_1.actors_["1095ui_story"]
			local var_370_1 = 0

			if var_370_1 < arg_367_1.time_ and arg_367_1.time_ <= var_370_1 + arg_370_0 and arg_367_1.var_.characterEffect1095ui_story == nil then
				arg_367_1.var_.characterEffect1095ui_story = var_370_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_370_2 = 0.200000002980232

			if var_370_1 <= arg_367_1.time_ and arg_367_1.time_ < var_370_1 + var_370_2 then
				local var_370_3 = (arg_367_1.time_ - var_370_1) / var_370_2

				if arg_367_1.var_.characterEffect1095ui_story then
					arg_367_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_367_1.time_ >= var_370_1 + var_370_2 and arg_367_1.time_ < var_370_1 + var_370_2 + arg_370_0 and arg_367_1.var_.characterEffect1095ui_story then
				arg_367_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_370_4 = 0
			local var_370_5 = 0.1

			if var_370_4 < arg_367_1.time_ and arg_367_1.time_ <= var_370_4 + arg_370_0 then
				arg_367_1.talkMaxDuration = 0
				arg_367_1.dialogCg_.alpha = 1

				arg_367_1.dialog_:SetActive(true)
				SetActive(arg_367_1.leftNameGo_, true)

				local var_370_6 = arg_367_1:FormatText(StoryNameCfg[471].name)

				arg_367_1.leftNameTxt_.text = var_370_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_367_1.leftNameTxt_.transform)

				arg_367_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_367_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_367_1:RecordName(arg_367_1.leftNameTxt_.text)
				SetActive(arg_367_1.iconTrs_.gameObject, false)
				arg_367_1.callingController_:SetSelectedState("normal")

				local var_370_7 = arg_367_1:GetWordFromCfg(411051090)
				local var_370_8 = arg_367_1:FormatText(var_370_7.content)

				arg_367_1.text_.text = var_370_8

				LuaForUtil.ClearLinePrefixSymbol(arg_367_1.text_)

				local var_370_9 = 4
				local var_370_10 = utf8.len(var_370_8)
				local var_370_11 = var_370_9 <= 0 and var_370_5 or var_370_5 * (var_370_10 / var_370_9)

				if var_370_11 > 0 and var_370_5 < var_370_11 then
					arg_367_1.talkMaxDuration = var_370_11

					if var_370_11 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_11 + var_370_4
					end
				end

				arg_367_1.text_.text = var_370_8
				arg_367_1.typewritter.percent = 0

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") ~= 0 then
					local var_370_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051090", "story_v_out_411051.awb") / 1000

					if var_370_12 + var_370_4 > arg_367_1.duration_ then
						arg_367_1.duration_ = var_370_12 + var_370_4
					end

					if var_370_7.prefab_name ~= "" and arg_367_1.actors_[var_370_7.prefab_name] ~= nil then
						local var_370_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_367_1.actors_[var_370_7.prefab_name].transform, "story_v_out_411051", "411051090", "story_v_out_411051.awb")

						arg_367_1:RecordAudio("411051090", var_370_13)
						arg_367_1:RecordAudio("411051090", var_370_13)
					else
						arg_367_1:AudioAction("play", "voice", "story_v_out_411051", "411051090", "story_v_out_411051.awb")
					end

					arg_367_1:RecordHistoryTalkVoice("story_v_out_411051", "411051090", "story_v_out_411051.awb")
				end

				arg_367_1:RecordContent(arg_367_1.text_.text)
			end

			local var_370_14 = math.max(var_370_5, arg_367_1.talkMaxDuration)

			if var_370_4 <= arg_367_1.time_ and arg_367_1.time_ < var_370_4 + var_370_14 then
				arg_367_1.typewritter.percent = (arg_367_1.time_ - var_370_4) / var_370_14

				arg_367_1.typewritter:SetDirty()
			end

			if arg_367_1.time_ >= var_370_4 + var_370_14 and arg_367_1.time_ < var_370_4 + var_370_14 + arg_370_0 then
				arg_367_1.typewritter.percent = 1

				arg_367_1.typewritter:SetDirty()
				arg_367_1:ShowNextGo(true)
			end
		end
	end,
	Play411051091 = function(arg_371_0, arg_371_1)
		arg_371_1.time_ = 0
		arg_371_1.frameCnt_ = 0
		arg_371_1.state_ = "playing"
		arg_371_1.curTalkId_ = 411051091
		arg_371_1.duration_ = 8.3

		local var_371_0 = {
			zh = 4.833,
			ja = 8.3
		}
		local var_371_1 = manager.audio:GetLocalizationFlag()

		if var_371_0[var_371_1] ~= nil then
			arg_371_1.duration_ = var_371_0[var_371_1]
		end

		SetActive(arg_371_1.tipsGo_, false)

		function arg_371_1.onSingleLineFinish_()
			arg_371_1.onSingleLineUpdate_ = nil
			arg_371_1.onSingleLineFinish_ = nil
			arg_371_1.state_ = "waiting"
		end

		function arg_371_1.playNext_(arg_373_0)
			if arg_373_0 == 1 then
				arg_371_0:Play411051092(arg_371_1)
			end
		end

		function arg_371_1.onSingleLineUpdate_(arg_374_0)
			local var_374_0 = arg_371_1.actors_["1095ui_story"]
			local var_374_1 = 0

			if var_374_1 < arg_371_1.time_ and arg_371_1.time_ <= var_374_1 + arg_374_0 and arg_371_1.var_.characterEffect1095ui_story == nil then
				arg_371_1.var_.characterEffect1095ui_story = var_374_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_374_2 = 0.200000002980232

			if var_374_1 <= arg_371_1.time_ and arg_371_1.time_ < var_374_1 + var_374_2 then
				local var_374_3 = (arg_371_1.time_ - var_374_1) / var_374_2

				if arg_371_1.var_.characterEffect1095ui_story then
					local var_374_4 = Mathf.Lerp(0, 0.5, var_374_3)

					arg_371_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_371_1.var_.characterEffect1095ui_story.fillRatio = var_374_4
				end
			end

			if arg_371_1.time_ >= var_374_1 + var_374_2 and arg_371_1.time_ < var_374_1 + var_374_2 + arg_374_0 and arg_371_1.var_.characterEffect1095ui_story then
				local var_374_5 = 0.5

				arg_371_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_371_1.var_.characterEffect1095ui_story.fillRatio = var_374_5
			end

			local var_374_6 = 0
			local var_374_7 = 0.575

			if var_374_6 < arg_371_1.time_ and arg_371_1.time_ <= var_374_6 + arg_374_0 then
				arg_371_1.talkMaxDuration = 0
				arg_371_1.dialogCg_.alpha = 1

				arg_371_1.dialog_:SetActive(true)
				SetActive(arg_371_1.leftNameGo_, true)

				local var_374_8 = arg_371_1:FormatText(StoryNameCfg[39].name)

				arg_371_1.leftNameTxt_.text = var_374_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_371_1.leftNameTxt_.transform)

				arg_371_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_371_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_371_1:RecordName(arg_371_1.leftNameTxt_.text)
				SetActive(arg_371_1.iconTrs_.gameObject, true)
				arg_371_1.iconController_:SetSelectedState("hero")

				arg_371_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_371_1.callingController_:SetSelectedState("normal")

				local var_374_9 = arg_371_1:GetWordFromCfg(411051091)
				local var_374_10 = arg_371_1:FormatText(var_374_9.content)

				arg_371_1.text_.text = var_374_10

				LuaForUtil.ClearLinePrefixSymbol(arg_371_1.text_)

				local var_374_11 = 23
				local var_374_12 = utf8.len(var_374_10)
				local var_374_13 = var_374_11 <= 0 and var_374_7 or var_374_7 * (var_374_12 / var_374_11)

				if var_374_13 > 0 and var_374_7 < var_374_13 then
					arg_371_1.talkMaxDuration = var_374_13

					if var_374_13 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_13 + var_374_6
					end
				end

				arg_371_1.text_.text = var_374_10
				arg_371_1.typewritter.percent = 0

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") ~= 0 then
					local var_374_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051091", "story_v_out_411051.awb") / 1000

					if var_374_14 + var_374_6 > arg_371_1.duration_ then
						arg_371_1.duration_ = var_374_14 + var_374_6
					end

					if var_374_9.prefab_name ~= "" and arg_371_1.actors_[var_374_9.prefab_name] ~= nil then
						local var_374_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_371_1.actors_[var_374_9.prefab_name].transform, "story_v_out_411051", "411051091", "story_v_out_411051.awb")

						arg_371_1:RecordAudio("411051091", var_374_15)
						arg_371_1:RecordAudio("411051091", var_374_15)
					else
						arg_371_1:AudioAction("play", "voice", "story_v_out_411051", "411051091", "story_v_out_411051.awb")
					end

					arg_371_1:RecordHistoryTalkVoice("story_v_out_411051", "411051091", "story_v_out_411051.awb")
				end

				arg_371_1:RecordContent(arg_371_1.text_.text)
			end

			local var_374_16 = math.max(var_374_7, arg_371_1.talkMaxDuration)

			if var_374_6 <= arg_371_1.time_ and arg_371_1.time_ < var_374_6 + var_374_16 then
				arg_371_1.typewritter.percent = (arg_371_1.time_ - var_374_6) / var_374_16

				arg_371_1.typewritter:SetDirty()
			end

			if arg_371_1.time_ >= var_374_6 + var_374_16 and arg_371_1.time_ < var_374_6 + var_374_16 + arg_374_0 then
				arg_371_1.typewritter.percent = 1

				arg_371_1.typewritter:SetDirty()
				arg_371_1:ShowNextGo(true)
			end
		end
	end,
	Play411051092 = function(arg_375_0, arg_375_1)
		arg_375_1.time_ = 0
		arg_375_1.frameCnt_ = 0
		arg_375_1.state_ = "playing"
		arg_375_1.curTalkId_ = 411051092
		arg_375_1.duration_ = 13.333

		local var_375_0 = {
			zh = 7.8,
			ja = 13.333
		}
		local var_375_1 = manager.audio:GetLocalizationFlag()

		if var_375_0[var_375_1] ~= nil then
			arg_375_1.duration_ = var_375_0[var_375_1]
		end

		SetActive(arg_375_1.tipsGo_, false)

		function arg_375_1.onSingleLineFinish_()
			arg_375_1.onSingleLineUpdate_ = nil
			arg_375_1.onSingleLineFinish_ = nil
			arg_375_1.state_ = "waiting"
		end

		function arg_375_1.playNext_(arg_377_0)
			if arg_377_0 == 1 then
				arg_375_0:Play411051093(arg_375_1)
			end
		end

		function arg_375_1.onSingleLineUpdate_(arg_378_0)
			local var_378_0 = arg_375_1.actors_["1095ui_story"]
			local var_378_1 = 0

			if var_378_1 < arg_375_1.time_ and arg_375_1.time_ <= var_378_1 + arg_378_0 and arg_375_1.var_.characterEffect1095ui_story == nil then
				arg_375_1.var_.characterEffect1095ui_story = var_378_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_378_2 = 0.200000002980232

			if var_378_1 <= arg_375_1.time_ and arg_375_1.time_ < var_378_1 + var_378_2 then
				local var_378_3 = (arg_375_1.time_ - var_378_1) / var_378_2

				if arg_375_1.var_.characterEffect1095ui_story then
					arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_375_1.time_ >= var_378_1 + var_378_2 and arg_375_1.time_ < var_378_1 + var_378_2 + arg_378_0 and arg_375_1.var_.characterEffect1095ui_story then
				arg_375_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_378_4 = 0

			if var_378_4 < arg_375_1.time_ and arg_375_1.time_ <= var_378_4 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action3_1")
			end

			local var_378_5 = 0

			if var_378_5 < arg_375_1.time_ and arg_375_1.time_ <= var_378_5 + arg_378_0 then
				arg_375_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_378_6 = 0
			local var_378_7 = 0.95

			if var_378_6 < arg_375_1.time_ and arg_375_1.time_ <= var_378_6 + arg_378_0 then
				arg_375_1.talkMaxDuration = 0
				arg_375_1.dialogCg_.alpha = 1

				arg_375_1.dialog_:SetActive(true)
				SetActive(arg_375_1.leftNameGo_, true)

				local var_378_8 = arg_375_1:FormatText(StoryNameCfg[471].name)

				arg_375_1.leftNameTxt_.text = var_378_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_375_1.leftNameTxt_.transform)

				arg_375_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_375_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_375_1:RecordName(arg_375_1.leftNameTxt_.text)
				SetActive(arg_375_1.iconTrs_.gameObject, false)
				arg_375_1.callingController_:SetSelectedState("normal")

				local var_378_9 = arg_375_1:GetWordFromCfg(411051092)
				local var_378_10 = arg_375_1:FormatText(var_378_9.content)

				arg_375_1.text_.text = var_378_10

				LuaForUtil.ClearLinePrefixSymbol(arg_375_1.text_)

				local var_378_11 = 38
				local var_378_12 = utf8.len(var_378_10)
				local var_378_13 = var_378_11 <= 0 and var_378_7 or var_378_7 * (var_378_12 / var_378_11)

				if var_378_13 > 0 and var_378_7 < var_378_13 then
					arg_375_1.talkMaxDuration = var_378_13

					if var_378_13 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_13 + var_378_6
					end
				end

				arg_375_1.text_.text = var_378_10
				arg_375_1.typewritter.percent = 0

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") ~= 0 then
					local var_378_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051092", "story_v_out_411051.awb") / 1000

					if var_378_14 + var_378_6 > arg_375_1.duration_ then
						arg_375_1.duration_ = var_378_14 + var_378_6
					end

					if var_378_9.prefab_name ~= "" and arg_375_1.actors_[var_378_9.prefab_name] ~= nil then
						local var_378_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_375_1.actors_[var_378_9.prefab_name].transform, "story_v_out_411051", "411051092", "story_v_out_411051.awb")

						arg_375_1:RecordAudio("411051092", var_378_15)
						arg_375_1:RecordAudio("411051092", var_378_15)
					else
						arg_375_1:AudioAction("play", "voice", "story_v_out_411051", "411051092", "story_v_out_411051.awb")
					end

					arg_375_1:RecordHistoryTalkVoice("story_v_out_411051", "411051092", "story_v_out_411051.awb")
				end

				arg_375_1:RecordContent(arg_375_1.text_.text)
			end

			local var_378_16 = math.max(var_378_7, arg_375_1.talkMaxDuration)

			if var_378_6 <= arg_375_1.time_ and arg_375_1.time_ < var_378_6 + var_378_16 then
				arg_375_1.typewritter.percent = (arg_375_1.time_ - var_378_6) / var_378_16

				arg_375_1.typewritter:SetDirty()
			end

			if arg_375_1.time_ >= var_378_6 + var_378_16 and arg_375_1.time_ < var_378_6 + var_378_16 + arg_378_0 then
				arg_375_1.typewritter.percent = 1

				arg_375_1.typewritter:SetDirty()
				arg_375_1:ShowNextGo(true)
			end
		end
	end,
	Play411051093 = function(arg_379_0, arg_379_1)
		arg_379_1.time_ = 0
		arg_379_1.frameCnt_ = 0
		arg_379_1.state_ = "playing"
		arg_379_1.curTalkId_ = 411051093
		arg_379_1.duration_ = 13.466

		local var_379_0 = {
			zh = 8.2,
			ja = 13.466
		}
		local var_379_1 = manager.audio:GetLocalizationFlag()

		if var_379_0[var_379_1] ~= nil then
			arg_379_1.duration_ = var_379_0[var_379_1]
		end

		SetActive(arg_379_1.tipsGo_, false)

		function arg_379_1.onSingleLineFinish_()
			arg_379_1.onSingleLineUpdate_ = nil
			arg_379_1.onSingleLineFinish_ = nil
			arg_379_1.state_ = "waiting"
		end

		function arg_379_1.playNext_(arg_381_0)
			if arg_381_0 == 1 then
				arg_379_0:Play411051094(arg_379_1)
			end
		end

		function arg_379_1.onSingleLineUpdate_(arg_382_0)
			local var_382_0 = 0
			local var_382_1 = 0.875

			if var_382_0 < arg_379_1.time_ and arg_379_1.time_ <= var_382_0 + arg_382_0 then
				arg_379_1.talkMaxDuration = 0
				arg_379_1.dialogCg_.alpha = 1

				arg_379_1.dialog_:SetActive(true)
				SetActive(arg_379_1.leftNameGo_, true)

				local var_382_2 = arg_379_1:FormatText(StoryNameCfg[471].name)

				arg_379_1.leftNameTxt_.text = var_382_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_379_1.leftNameTxt_.transform)

				arg_379_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_379_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_379_1:RecordName(arg_379_1.leftNameTxt_.text)
				SetActive(arg_379_1.iconTrs_.gameObject, false)
				arg_379_1.callingController_:SetSelectedState("normal")

				local var_382_3 = arg_379_1:GetWordFromCfg(411051093)
				local var_382_4 = arg_379_1:FormatText(var_382_3.content)

				arg_379_1.text_.text = var_382_4

				LuaForUtil.ClearLinePrefixSymbol(arg_379_1.text_)

				local var_382_5 = 35
				local var_382_6 = utf8.len(var_382_4)
				local var_382_7 = var_382_5 <= 0 and var_382_1 or var_382_1 * (var_382_6 / var_382_5)

				if var_382_7 > 0 and var_382_1 < var_382_7 then
					arg_379_1.talkMaxDuration = var_382_7

					if var_382_7 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_7 + var_382_0
					end
				end

				arg_379_1.text_.text = var_382_4
				arg_379_1.typewritter.percent = 0

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") ~= 0 then
					local var_382_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051093", "story_v_out_411051.awb") / 1000

					if var_382_8 + var_382_0 > arg_379_1.duration_ then
						arg_379_1.duration_ = var_382_8 + var_382_0
					end

					if var_382_3.prefab_name ~= "" and arg_379_1.actors_[var_382_3.prefab_name] ~= nil then
						local var_382_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_379_1.actors_[var_382_3.prefab_name].transform, "story_v_out_411051", "411051093", "story_v_out_411051.awb")

						arg_379_1:RecordAudio("411051093", var_382_9)
						arg_379_1:RecordAudio("411051093", var_382_9)
					else
						arg_379_1:AudioAction("play", "voice", "story_v_out_411051", "411051093", "story_v_out_411051.awb")
					end

					arg_379_1:RecordHistoryTalkVoice("story_v_out_411051", "411051093", "story_v_out_411051.awb")
				end

				arg_379_1:RecordContent(arg_379_1.text_.text)
			end

			local var_382_10 = math.max(var_382_1, arg_379_1.talkMaxDuration)

			if var_382_0 <= arg_379_1.time_ and arg_379_1.time_ < var_382_0 + var_382_10 then
				arg_379_1.typewritter.percent = (arg_379_1.time_ - var_382_0) / var_382_10

				arg_379_1.typewritter:SetDirty()
			end

			if arg_379_1.time_ >= var_382_0 + var_382_10 and arg_379_1.time_ < var_382_0 + var_382_10 + arg_382_0 then
				arg_379_1.typewritter.percent = 1

				arg_379_1.typewritter:SetDirty()
				arg_379_1:ShowNextGo(true)
			end
		end
	end,
	Play411051094 = function(arg_383_0, arg_383_1)
		arg_383_1.time_ = 0
		arg_383_1.frameCnt_ = 0
		arg_383_1.state_ = "playing"
		arg_383_1.curTalkId_ = 411051094
		arg_383_1.duration_ = 9.7

		local var_383_0 = {
			zh = 9.7,
			ja = 6.366
		}
		local var_383_1 = manager.audio:GetLocalizationFlag()

		if var_383_0[var_383_1] ~= nil then
			arg_383_1.duration_ = var_383_0[var_383_1]
		end

		SetActive(arg_383_1.tipsGo_, false)

		function arg_383_1.onSingleLineFinish_()
			arg_383_1.onSingleLineUpdate_ = nil
			arg_383_1.onSingleLineFinish_ = nil
			arg_383_1.state_ = "waiting"
		end

		function arg_383_1.playNext_(arg_385_0)
			if arg_385_0 == 1 then
				arg_383_0:Play411051095(arg_383_1)
			end
		end

		function arg_383_1.onSingleLineUpdate_(arg_386_0)
			local var_386_0 = arg_383_1.actors_["1095ui_story"]
			local var_386_1 = 0

			if var_386_1 < arg_383_1.time_ and arg_383_1.time_ <= var_386_1 + arg_386_0 and arg_383_1.var_.characterEffect1095ui_story == nil then
				arg_383_1.var_.characterEffect1095ui_story = var_386_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_386_2 = 0.200000002980232

			if var_386_1 <= arg_383_1.time_ and arg_383_1.time_ < var_386_1 + var_386_2 then
				local var_386_3 = (arg_383_1.time_ - var_386_1) / var_386_2

				if arg_383_1.var_.characterEffect1095ui_story then
					local var_386_4 = Mathf.Lerp(0, 0.5, var_386_3)

					arg_383_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_383_1.var_.characterEffect1095ui_story.fillRatio = var_386_4
				end
			end

			if arg_383_1.time_ >= var_386_1 + var_386_2 and arg_383_1.time_ < var_386_1 + var_386_2 + arg_386_0 and arg_383_1.var_.characterEffect1095ui_story then
				local var_386_5 = 0.5

				arg_383_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_383_1.var_.characterEffect1095ui_story.fillRatio = var_386_5
			end

			local var_386_6 = 0
			local var_386_7 = 0.95

			if var_386_6 < arg_383_1.time_ and arg_383_1.time_ <= var_386_6 + arg_386_0 then
				arg_383_1.talkMaxDuration = 0
				arg_383_1.dialogCg_.alpha = 1

				arg_383_1.dialog_:SetActive(true)
				SetActive(arg_383_1.leftNameGo_, true)

				local var_386_8 = arg_383_1:FormatText(StoryNameCfg[39].name)

				arg_383_1.leftNameTxt_.text = var_386_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_383_1.leftNameTxt_.transform)

				arg_383_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_383_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_383_1:RecordName(arg_383_1.leftNameTxt_.text)
				SetActive(arg_383_1.iconTrs_.gameObject, true)
				arg_383_1.iconController_:SetSelectedState("hero")

				arg_383_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_383_1.callingController_:SetSelectedState("normal")

				local var_386_9 = arg_383_1:GetWordFromCfg(411051094)
				local var_386_10 = arg_383_1:FormatText(var_386_9.content)

				arg_383_1.text_.text = var_386_10

				LuaForUtil.ClearLinePrefixSymbol(arg_383_1.text_)

				local var_386_11 = 37
				local var_386_12 = utf8.len(var_386_10)
				local var_386_13 = var_386_11 <= 0 and var_386_7 or var_386_7 * (var_386_12 / var_386_11)

				if var_386_13 > 0 and var_386_7 < var_386_13 then
					arg_383_1.talkMaxDuration = var_386_13

					if var_386_13 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_13 + var_386_6
					end
				end

				arg_383_1.text_.text = var_386_10
				arg_383_1.typewritter.percent = 0

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") ~= 0 then
					local var_386_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051094", "story_v_out_411051.awb") / 1000

					if var_386_14 + var_386_6 > arg_383_1.duration_ then
						arg_383_1.duration_ = var_386_14 + var_386_6
					end

					if var_386_9.prefab_name ~= "" and arg_383_1.actors_[var_386_9.prefab_name] ~= nil then
						local var_386_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_383_1.actors_[var_386_9.prefab_name].transform, "story_v_out_411051", "411051094", "story_v_out_411051.awb")

						arg_383_1:RecordAudio("411051094", var_386_15)
						arg_383_1:RecordAudio("411051094", var_386_15)
					else
						arg_383_1:AudioAction("play", "voice", "story_v_out_411051", "411051094", "story_v_out_411051.awb")
					end

					arg_383_1:RecordHistoryTalkVoice("story_v_out_411051", "411051094", "story_v_out_411051.awb")
				end

				arg_383_1:RecordContent(arg_383_1.text_.text)
			end

			local var_386_16 = math.max(var_386_7, arg_383_1.talkMaxDuration)

			if var_386_6 <= arg_383_1.time_ and arg_383_1.time_ < var_386_6 + var_386_16 then
				arg_383_1.typewritter.percent = (arg_383_1.time_ - var_386_6) / var_386_16

				arg_383_1.typewritter:SetDirty()
			end

			if arg_383_1.time_ >= var_386_6 + var_386_16 and arg_383_1.time_ < var_386_6 + var_386_16 + arg_386_0 then
				arg_383_1.typewritter.percent = 1

				arg_383_1.typewritter:SetDirty()
				arg_383_1:ShowNextGo(true)
			end
		end
	end,
	Play411051095 = function(arg_387_0, arg_387_1)
		arg_387_1.time_ = 0
		arg_387_1.frameCnt_ = 0
		arg_387_1.state_ = "playing"
		arg_387_1.curTalkId_ = 411051095
		arg_387_1.duration_ = 7.433

		local var_387_0 = {
			zh = 5.533,
			ja = 7.433
		}
		local var_387_1 = manager.audio:GetLocalizationFlag()

		if var_387_0[var_387_1] ~= nil then
			arg_387_1.duration_ = var_387_0[var_387_1]
		end

		SetActive(arg_387_1.tipsGo_, false)

		function arg_387_1.onSingleLineFinish_()
			arg_387_1.onSingleLineUpdate_ = nil
			arg_387_1.onSingleLineFinish_ = nil
			arg_387_1.state_ = "waiting"
		end

		function arg_387_1.playNext_(arg_389_0)
			if arg_389_0 == 1 then
				arg_387_0:Play411051096(arg_387_1)
			end
		end

		function arg_387_1.onSingleLineUpdate_(arg_390_0)
			local var_390_0 = arg_387_1.actors_["1095ui_story"]
			local var_390_1 = 0

			if var_390_1 < arg_387_1.time_ and arg_387_1.time_ <= var_390_1 + arg_390_0 and arg_387_1.var_.characterEffect1095ui_story == nil then
				arg_387_1.var_.characterEffect1095ui_story = var_390_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_390_2 = 0.200000002980232

			if var_390_1 <= arg_387_1.time_ and arg_387_1.time_ < var_390_1 + var_390_2 then
				local var_390_3 = (arg_387_1.time_ - var_390_1) / var_390_2

				if arg_387_1.var_.characterEffect1095ui_story then
					arg_387_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_387_1.time_ >= var_390_1 + var_390_2 and arg_387_1.time_ < var_390_1 + var_390_2 + arg_390_0 and arg_387_1.var_.characterEffect1095ui_story then
				arg_387_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_390_4 = 0
			local var_390_5 = 0.55

			if var_390_4 < arg_387_1.time_ and arg_387_1.time_ <= var_390_4 + arg_390_0 then
				arg_387_1.talkMaxDuration = 0
				arg_387_1.dialogCg_.alpha = 1

				arg_387_1.dialog_:SetActive(true)
				SetActive(arg_387_1.leftNameGo_, true)

				local var_390_6 = arg_387_1:FormatText(StoryNameCfg[471].name)

				arg_387_1.leftNameTxt_.text = var_390_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_387_1.leftNameTxt_.transform)

				arg_387_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_387_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_387_1:RecordName(arg_387_1.leftNameTxt_.text)
				SetActive(arg_387_1.iconTrs_.gameObject, false)
				arg_387_1.callingController_:SetSelectedState("normal")

				local var_390_7 = arg_387_1:GetWordFromCfg(411051095)
				local var_390_8 = arg_387_1:FormatText(var_390_7.content)

				arg_387_1.text_.text = var_390_8

				LuaForUtil.ClearLinePrefixSymbol(arg_387_1.text_)

				local var_390_9 = 22
				local var_390_10 = utf8.len(var_390_8)
				local var_390_11 = var_390_9 <= 0 and var_390_5 or var_390_5 * (var_390_10 / var_390_9)

				if var_390_11 > 0 and var_390_5 < var_390_11 then
					arg_387_1.talkMaxDuration = var_390_11

					if var_390_11 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_11 + var_390_4
					end
				end

				arg_387_1.text_.text = var_390_8
				arg_387_1.typewritter.percent = 0

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") ~= 0 then
					local var_390_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051095", "story_v_out_411051.awb") / 1000

					if var_390_12 + var_390_4 > arg_387_1.duration_ then
						arg_387_1.duration_ = var_390_12 + var_390_4
					end

					if var_390_7.prefab_name ~= "" and arg_387_1.actors_[var_390_7.prefab_name] ~= nil then
						local var_390_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_387_1.actors_[var_390_7.prefab_name].transform, "story_v_out_411051", "411051095", "story_v_out_411051.awb")

						arg_387_1:RecordAudio("411051095", var_390_13)
						arg_387_1:RecordAudio("411051095", var_390_13)
					else
						arg_387_1:AudioAction("play", "voice", "story_v_out_411051", "411051095", "story_v_out_411051.awb")
					end

					arg_387_1:RecordHistoryTalkVoice("story_v_out_411051", "411051095", "story_v_out_411051.awb")
				end

				arg_387_1:RecordContent(arg_387_1.text_.text)
			end

			local var_390_14 = math.max(var_390_5, arg_387_1.talkMaxDuration)

			if var_390_4 <= arg_387_1.time_ and arg_387_1.time_ < var_390_4 + var_390_14 then
				arg_387_1.typewritter.percent = (arg_387_1.time_ - var_390_4) / var_390_14

				arg_387_1.typewritter:SetDirty()
			end

			if arg_387_1.time_ >= var_390_4 + var_390_14 and arg_387_1.time_ < var_390_4 + var_390_14 + arg_390_0 then
				arg_387_1.typewritter.percent = 1

				arg_387_1.typewritter:SetDirty()
				arg_387_1:ShowNextGo(true)
			end
		end
	end,
	Play411051096 = function(arg_391_0, arg_391_1)
		arg_391_1.time_ = 0
		arg_391_1.frameCnt_ = 0
		arg_391_1.state_ = "playing"
		arg_391_1.curTalkId_ = 411051096
		arg_391_1.duration_ = 3

		local var_391_0 = {
			zh = 1.4,
			ja = 3
		}
		local var_391_1 = manager.audio:GetLocalizationFlag()

		if var_391_0[var_391_1] ~= nil then
			arg_391_1.duration_ = var_391_0[var_391_1]
		end

		SetActive(arg_391_1.tipsGo_, false)

		function arg_391_1.onSingleLineFinish_()
			arg_391_1.onSingleLineUpdate_ = nil
			arg_391_1.onSingleLineFinish_ = nil
			arg_391_1.state_ = "waiting"
		end

		function arg_391_1.playNext_(arg_393_0)
			if arg_393_0 == 1 then
				arg_391_0:Play411051097(arg_391_1)
			end
		end

		function arg_391_1.onSingleLineUpdate_(arg_394_0)
			local var_394_0 = arg_391_1.actors_["1095ui_story"]
			local var_394_1 = 0

			if var_394_1 < arg_391_1.time_ and arg_391_1.time_ <= var_394_1 + arg_394_0 and arg_391_1.var_.characterEffect1095ui_story == nil then
				arg_391_1.var_.characterEffect1095ui_story = var_394_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_394_2 = 0.200000002980232

			if var_394_1 <= arg_391_1.time_ and arg_391_1.time_ < var_394_1 + var_394_2 then
				local var_394_3 = (arg_391_1.time_ - var_394_1) / var_394_2

				if arg_391_1.var_.characterEffect1095ui_story then
					local var_394_4 = Mathf.Lerp(0, 0.5, var_394_3)

					arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_391_1.var_.characterEffect1095ui_story.fillRatio = var_394_4
				end
			end

			if arg_391_1.time_ >= var_394_1 + var_394_2 and arg_391_1.time_ < var_394_1 + var_394_2 + arg_394_0 and arg_391_1.var_.characterEffect1095ui_story then
				local var_394_5 = 0.5

				arg_391_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_391_1.var_.characterEffect1095ui_story.fillRatio = var_394_5
			end

			local var_394_6 = 0
			local var_394_7 = 0.175

			if var_394_6 < arg_391_1.time_ and arg_391_1.time_ <= var_394_6 + arg_394_0 then
				arg_391_1.talkMaxDuration = 0
				arg_391_1.dialogCg_.alpha = 1

				arg_391_1.dialog_:SetActive(true)
				SetActive(arg_391_1.leftNameGo_, true)

				local var_394_8 = arg_391_1:FormatText(StoryNameCfg[39].name)

				arg_391_1.leftNameTxt_.text = var_394_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_391_1.leftNameTxt_.transform)

				arg_391_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_391_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_391_1:RecordName(arg_391_1.leftNameTxt_.text)
				SetActive(arg_391_1.iconTrs_.gameObject, true)
				arg_391_1.iconController_:SetSelectedState("hero")

				arg_391_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_391_1.callingController_:SetSelectedState("normal")

				local var_394_9 = arg_391_1:GetWordFromCfg(411051096)
				local var_394_10 = arg_391_1:FormatText(var_394_9.content)

				arg_391_1.text_.text = var_394_10

				LuaForUtil.ClearLinePrefixSymbol(arg_391_1.text_)

				local var_394_11 = 7
				local var_394_12 = utf8.len(var_394_10)
				local var_394_13 = var_394_11 <= 0 and var_394_7 or var_394_7 * (var_394_12 / var_394_11)

				if var_394_13 > 0 and var_394_7 < var_394_13 then
					arg_391_1.talkMaxDuration = var_394_13

					if var_394_13 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_13 + var_394_6
					end
				end

				arg_391_1.text_.text = var_394_10
				arg_391_1.typewritter.percent = 0

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") ~= 0 then
					local var_394_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051096", "story_v_out_411051.awb") / 1000

					if var_394_14 + var_394_6 > arg_391_1.duration_ then
						arg_391_1.duration_ = var_394_14 + var_394_6
					end

					if var_394_9.prefab_name ~= "" and arg_391_1.actors_[var_394_9.prefab_name] ~= nil then
						local var_394_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_391_1.actors_[var_394_9.prefab_name].transform, "story_v_out_411051", "411051096", "story_v_out_411051.awb")

						arg_391_1:RecordAudio("411051096", var_394_15)
						arg_391_1:RecordAudio("411051096", var_394_15)
					else
						arg_391_1:AudioAction("play", "voice", "story_v_out_411051", "411051096", "story_v_out_411051.awb")
					end

					arg_391_1:RecordHistoryTalkVoice("story_v_out_411051", "411051096", "story_v_out_411051.awb")
				end

				arg_391_1:RecordContent(arg_391_1.text_.text)
			end

			local var_394_16 = math.max(var_394_7, arg_391_1.talkMaxDuration)

			if var_394_6 <= arg_391_1.time_ and arg_391_1.time_ < var_394_6 + var_394_16 then
				arg_391_1.typewritter.percent = (arg_391_1.time_ - var_394_6) / var_394_16

				arg_391_1.typewritter:SetDirty()
			end

			if arg_391_1.time_ >= var_394_6 + var_394_16 and arg_391_1.time_ < var_394_6 + var_394_16 + arg_394_0 then
				arg_391_1.typewritter.percent = 1

				arg_391_1.typewritter:SetDirty()
				arg_391_1:ShowNextGo(true)
			end
		end
	end,
	Play411051097 = function(arg_395_0, arg_395_1)
		arg_395_1.time_ = 0
		arg_395_1.frameCnt_ = 0
		arg_395_1.state_ = "playing"
		arg_395_1.curTalkId_ = 411051097
		arg_395_1.duration_ = 6.033

		local var_395_0 = {
			zh = 5.033,
			ja = 6.033
		}
		local var_395_1 = manager.audio:GetLocalizationFlag()

		if var_395_0[var_395_1] ~= nil then
			arg_395_1.duration_ = var_395_0[var_395_1]
		end

		SetActive(arg_395_1.tipsGo_, false)

		function arg_395_1.onSingleLineFinish_()
			arg_395_1.onSingleLineUpdate_ = nil
			arg_395_1.onSingleLineFinish_ = nil
			arg_395_1.state_ = "waiting"
		end

		function arg_395_1.playNext_(arg_397_0)
			if arg_397_0 == 1 then
				arg_395_0:Play411051098(arg_395_1)
			end
		end

		function arg_395_1.onSingleLineUpdate_(arg_398_0)
			local var_398_0 = arg_395_1.actors_["1095ui_story"]
			local var_398_1 = 0

			if var_398_1 < arg_395_1.time_ and arg_395_1.time_ <= var_398_1 + arg_398_0 and arg_395_1.var_.characterEffect1095ui_story == nil then
				arg_395_1.var_.characterEffect1095ui_story = var_398_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_398_2 = 0.200000002980232

			if var_398_1 <= arg_395_1.time_ and arg_395_1.time_ < var_398_1 + var_398_2 then
				local var_398_3 = (arg_395_1.time_ - var_398_1) / var_398_2

				if arg_395_1.var_.characterEffect1095ui_story then
					arg_395_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_395_1.time_ >= var_398_1 + var_398_2 and arg_395_1.time_ < var_398_1 + var_398_2 + arg_398_0 and arg_395_1.var_.characterEffect1095ui_story then
				arg_395_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_398_4 = 0
			local var_398_5 = 0.65

			if var_398_4 < arg_395_1.time_ and arg_395_1.time_ <= var_398_4 + arg_398_0 then
				arg_395_1.talkMaxDuration = 0
				arg_395_1.dialogCg_.alpha = 1

				arg_395_1.dialog_:SetActive(true)
				SetActive(arg_395_1.leftNameGo_, true)

				local var_398_6 = arg_395_1:FormatText(StoryNameCfg[471].name)

				arg_395_1.leftNameTxt_.text = var_398_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_395_1.leftNameTxt_.transform)

				arg_395_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_395_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_395_1:RecordName(arg_395_1.leftNameTxt_.text)
				SetActive(arg_395_1.iconTrs_.gameObject, false)
				arg_395_1.callingController_:SetSelectedState("normal")

				local var_398_7 = arg_395_1:GetWordFromCfg(411051097)
				local var_398_8 = arg_395_1:FormatText(var_398_7.content)

				arg_395_1.text_.text = var_398_8

				LuaForUtil.ClearLinePrefixSymbol(arg_395_1.text_)

				local var_398_9 = 26
				local var_398_10 = utf8.len(var_398_8)
				local var_398_11 = var_398_9 <= 0 and var_398_5 or var_398_5 * (var_398_10 / var_398_9)

				if var_398_11 > 0 and var_398_5 < var_398_11 then
					arg_395_1.talkMaxDuration = var_398_11

					if var_398_11 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_11 + var_398_4
					end
				end

				arg_395_1.text_.text = var_398_8
				arg_395_1.typewritter.percent = 0

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") ~= 0 then
					local var_398_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051097", "story_v_out_411051.awb") / 1000

					if var_398_12 + var_398_4 > arg_395_1.duration_ then
						arg_395_1.duration_ = var_398_12 + var_398_4
					end

					if var_398_7.prefab_name ~= "" and arg_395_1.actors_[var_398_7.prefab_name] ~= nil then
						local var_398_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_395_1.actors_[var_398_7.prefab_name].transform, "story_v_out_411051", "411051097", "story_v_out_411051.awb")

						arg_395_1:RecordAudio("411051097", var_398_13)
						arg_395_1:RecordAudio("411051097", var_398_13)
					else
						arg_395_1:AudioAction("play", "voice", "story_v_out_411051", "411051097", "story_v_out_411051.awb")
					end

					arg_395_1:RecordHistoryTalkVoice("story_v_out_411051", "411051097", "story_v_out_411051.awb")
				end

				arg_395_1:RecordContent(arg_395_1.text_.text)
			end

			local var_398_14 = math.max(var_398_5, arg_395_1.talkMaxDuration)

			if var_398_4 <= arg_395_1.time_ and arg_395_1.time_ < var_398_4 + var_398_14 then
				arg_395_1.typewritter.percent = (arg_395_1.time_ - var_398_4) / var_398_14

				arg_395_1.typewritter:SetDirty()
			end

			if arg_395_1.time_ >= var_398_4 + var_398_14 and arg_395_1.time_ < var_398_4 + var_398_14 + arg_398_0 then
				arg_395_1.typewritter.percent = 1

				arg_395_1.typewritter:SetDirty()
				arg_395_1:ShowNextGo(true)
			end
		end
	end,
	Play411051098 = function(arg_399_0, arg_399_1)
		arg_399_1.time_ = 0
		arg_399_1.frameCnt_ = 0
		arg_399_1.state_ = "playing"
		arg_399_1.curTalkId_ = 411051098
		arg_399_1.duration_ = 11.166

		local var_399_0 = {
			zh = 10.2,
			ja = 11.166
		}
		local var_399_1 = manager.audio:GetLocalizationFlag()

		if var_399_0[var_399_1] ~= nil then
			arg_399_1.duration_ = var_399_0[var_399_1]
		end

		SetActive(arg_399_1.tipsGo_, false)

		function arg_399_1.onSingleLineFinish_()
			arg_399_1.onSingleLineUpdate_ = nil
			arg_399_1.onSingleLineFinish_ = nil
			arg_399_1.state_ = "waiting"
		end

		function arg_399_1.playNext_(arg_401_0)
			if arg_401_0 == 1 then
				arg_399_0:Play411051099(arg_399_1)
			end
		end

		function arg_399_1.onSingleLineUpdate_(arg_402_0)
			local var_402_0 = 0
			local var_402_1 = 1.3

			if var_402_0 < arg_399_1.time_ and arg_399_1.time_ <= var_402_0 + arg_402_0 then
				arg_399_1.talkMaxDuration = 0
				arg_399_1.dialogCg_.alpha = 1

				arg_399_1.dialog_:SetActive(true)
				SetActive(arg_399_1.leftNameGo_, true)

				local var_402_2 = arg_399_1:FormatText(StoryNameCfg[471].name)

				arg_399_1.leftNameTxt_.text = var_402_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_399_1.leftNameTxt_.transform)

				arg_399_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_399_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_399_1:RecordName(arg_399_1.leftNameTxt_.text)
				SetActive(arg_399_1.iconTrs_.gameObject, false)
				arg_399_1.callingController_:SetSelectedState("normal")

				local var_402_3 = arg_399_1:GetWordFromCfg(411051098)
				local var_402_4 = arg_399_1:FormatText(var_402_3.content)

				arg_399_1.text_.text = var_402_4

				LuaForUtil.ClearLinePrefixSymbol(arg_399_1.text_)

				local var_402_5 = 52
				local var_402_6 = utf8.len(var_402_4)
				local var_402_7 = var_402_5 <= 0 and var_402_1 or var_402_1 * (var_402_6 / var_402_5)

				if var_402_7 > 0 and var_402_1 < var_402_7 then
					arg_399_1.talkMaxDuration = var_402_7

					if var_402_7 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_7 + var_402_0
					end
				end

				arg_399_1.text_.text = var_402_4
				arg_399_1.typewritter.percent = 0

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") ~= 0 then
					local var_402_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051098", "story_v_out_411051.awb") / 1000

					if var_402_8 + var_402_0 > arg_399_1.duration_ then
						arg_399_1.duration_ = var_402_8 + var_402_0
					end

					if var_402_3.prefab_name ~= "" and arg_399_1.actors_[var_402_3.prefab_name] ~= nil then
						local var_402_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_399_1.actors_[var_402_3.prefab_name].transform, "story_v_out_411051", "411051098", "story_v_out_411051.awb")

						arg_399_1:RecordAudio("411051098", var_402_9)
						arg_399_1:RecordAudio("411051098", var_402_9)
					else
						arg_399_1:AudioAction("play", "voice", "story_v_out_411051", "411051098", "story_v_out_411051.awb")
					end

					arg_399_1:RecordHistoryTalkVoice("story_v_out_411051", "411051098", "story_v_out_411051.awb")
				end

				arg_399_1:RecordContent(arg_399_1.text_.text)
			end

			local var_402_10 = math.max(var_402_1, arg_399_1.talkMaxDuration)

			if var_402_0 <= arg_399_1.time_ and arg_399_1.time_ < var_402_0 + var_402_10 then
				arg_399_1.typewritter.percent = (arg_399_1.time_ - var_402_0) / var_402_10

				arg_399_1.typewritter:SetDirty()
			end

			if arg_399_1.time_ >= var_402_0 + var_402_10 and arg_399_1.time_ < var_402_0 + var_402_10 + arg_402_0 then
				arg_399_1.typewritter.percent = 1

				arg_399_1.typewritter:SetDirty()
				arg_399_1:ShowNextGo(true)
			end
		end
	end,
	Play411051099 = function(arg_403_0, arg_403_1)
		arg_403_1.time_ = 0
		arg_403_1.frameCnt_ = 0
		arg_403_1.state_ = "playing"
		arg_403_1.curTalkId_ = 411051099
		arg_403_1.duration_ = 10.533

		local var_403_0 = {
			zh = 10.533,
			ja = 7
		}
		local var_403_1 = manager.audio:GetLocalizationFlag()

		if var_403_0[var_403_1] ~= nil then
			arg_403_1.duration_ = var_403_0[var_403_1]
		end

		SetActive(arg_403_1.tipsGo_, false)

		function arg_403_1.onSingleLineFinish_()
			arg_403_1.onSingleLineUpdate_ = nil
			arg_403_1.onSingleLineFinish_ = nil
			arg_403_1.state_ = "waiting"
		end

		function arg_403_1.playNext_(arg_405_0)
			if arg_405_0 == 1 then
				arg_403_0:Play411051100(arg_403_1)
			end
		end

		function arg_403_1.onSingleLineUpdate_(arg_406_0)
			local var_406_0 = 0
			local var_406_1 = 1.275

			if var_406_0 < arg_403_1.time_ and arg_403_1.time_ <= var_406_0 + arg_406_0 then
				arg_403_1.talkMaxDuration = 0
				arg_403_1.dialogCg_.alpha = 1

				arg_403_1.dialog_:SetActive(true)
				SetActive(arg_403_1.leftNameGo_, true)

				local var_406_2 = arg_403_1:FormatText(StoryNameCfg[471].name)

				arg_403_1.leftNameTxt_.text = var_406_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_403_1.leftNameTxt_.transform)

				arg_403_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_403_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_403_1:RecordName(arg_403_1.leftNameTxt_.text)
				SetActive(arg_403_1.iconTrs_.gameObject, false)
				arg_403_1.callingController_:SetSelectedState("normal")

				local var_406_3 = arg_403_1:GetWordFromCfg(411051099)
				local var_406_4 = arg_403_1:FormatText(var_406_3.content)

				arg_403_1.text_.text = var_406_4

				LuaForUtil.ClearLinePrefixSymbol(arg_403_1.text_)

				local var_406_5 = 51
				local var_406_6 = utf8.len(var_406_4)
				local var_406_7 = var_406_5 <= 0 and var_406_1 or var_406_1 * (var_406_6 / var_406_5)

				if var_406_7 > 0 and var_406_1 < var_406_7 then
					arg_403_1.talkMaxDuration = var_406_7

					if var_406_7 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_7 + var_406_0
					end
				end

				arg_403_1.text_.text = var_406_4
				arg_403_1.typewritter.percent = 0

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") ~= 0 then
					local var_406_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051099", "story_v_out_411051.awb") / 1000

					if var_406_8 + var_406_0 > arg_403_1.duration_ then
						arg_403_1.duration_ = var_406_8 + var_406_0
					end

					if var_406_3.prefab_name ~= "" and arg_403_1.actors_[var_406_3.prefab_name] ~= nil then
						local var_406_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_403_1.actors_[var_406_3.prefab_name].transform, "story_v_out_411051", "411051099", "story_v_out_411051.awb")

						arg_403_1:RecordAudio("411051099", var_406_9)
						arg_403_1:RecordAudio("411051099", var_406_9)
					else
						arg_403_1:AudioAction("play", "voice", "story_v_out_411051", "411051099", "story_v_out_411051.awb")
					end

					arg_403_1:RecordHistoryTalkVoice("story_v_out_411051", "411051099", "story_v_out_411051.awb")
				end

				arg_403_1:RecordContent(arg_403_1.text_.text)
			end

			local var_406_10 = math.max(var_406_1, arg_403_1.talkMaxDuration)

			if var_406_0 <= arg_403_1.time_ and arg_403_1.time_ < var_406_0 + var_406_10 then
				arg_403_1.typewritter.percent = (arg_403_1.time_ - var_406_0) / var_406_10

				arg_403_1.typewritter:SetDirty()
			end

			if arg_403_1.time_ >= var_406_0 + var_406_10 and arg_403_1.time_ < var_406_0 + var_406_10 + arg_406_0 then
				arg_403_1.typewritter.percent = 1

				arg_403_1.typewritter:SetDirty()
				arg_403_1:ShowNextGo(true)
			end
		end
	end,
	Play411051100 = function(arg_407_0, arg_407_1)
		arg_407_1.time_ = 0
		arg_407_1.frameCnt_ = 0
		arg_407_1.state_ = "playing"
		arg_407_1.curTalkId_ = 411051100
		arg_407_1.duration_ = 5.9

		local var_407_0 = {
			zh = 5.9,
			ja = 5.433
		}
		local var_407_1 = manager.audio:GetLocalizationFlag()

		if var_407_0[var_407_1] ~= nil then
			arg_407_1.duration_ = var_407_0[var_407_1]
		end

		SetActive(arg_407_1.tipsGo_, false)

		function arg_407_1.onSingleLineFinish_()
			arg_407_1.onSingleLineUpdate_ = nil
			arg_407_1.onSingleLineFinish_ = nil
			arg_407_1.state_ = "waiting"
		end

		function arg_407_1.playNext_(arg_409_0)
			if arg_409_0 == 1 then
				arg_407_0:Play411051101(arg_407_1)
			end
		end

		function arg_407_1.onSingleLineUpdate_(arg_410_0)
			local var_410_0 = arg_407_1.actors_["1095ui_story"].transform
			local var_410_1 = 0

			if var_410_1 < arg_407_1.time_ and arg_407_1.time_ <= var_410_1 + arg_410_0 then
				arg_407_1.var_.moveOldPos1095ui_story = var_410_0.localPosition
			end

			local var_410_2 = 0.001

			if var_410_1 <= arg_407_1.time_ and arg_407_1.time_ < var_410_1 + var_410_2 then
				local var_410_3 = (arg_407_1.time_ - var_410_1) / var_410_2
				local var_410_4 = Vector3.New(0, -0.98, -6.1)

				var_410_0.localPosition = Vector3.Lerp(arg_407_1.var_.moveOldPos1095ui_story, var_410_4, var_410_3)

				local var_410_5 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_5.x, var_410_5.y, var_410_5.z)

				local var_410_6 = var_410_0.localEulerAngles

				var_410_6.z = 0
				var_410_6.x = 0
				var_410_0.localEulerAngles = var_410_6
			end

			if arg_407_1.time_ >= var_410_1 + var_410_2 and arg_407_1.time_ < var_410_1 + var_410_2 + arg_410_0 then
				var_410_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_410_7 = manager.ui.mainCamera.transform.position - var_410_0.position

				var_410_0.forward = Vector3.New(var_410_7.x, var_410_7.y, var_410_7.z)

				local var_410_8 = var_410_0.localEulerAngles

				var_410_8.z = 0
				var_410_8.x = 0
				var_410_0.localEulerAngles = var_410_8
			end

			local var_410_9 = arg_407_1.actors_["1095ui_story"]
			local var_410_10 = 0

			if var_410_10 < arg_407_1.time_ and arg_407_1.time_ <= var_410_10 + arg_410_0 and arg_407_1.var_.characterEffect1095ui_story == nil then
				arg_407_1.var_.characterEffect1095ui_story = var_410_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_410_11 = 0.200000002980232

			if var_410_10 <= arg_407_1.time_ and arg_407_1.time_ < var_410_10 + var_410_11 then
				local var_410_12 = (arg_407_1.time_ - var_410_10) / var_410_11

				if arg_407_1.var_.characterEffect1095ui_story then
					arg_407_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_407_1.time_ >= var_410_10 + var_410_11 and arg_407_1.time_ < var_410_10 + var_410_11 + arg_410_0 and arg_407_1.var_.characterEffect1095ui_story then
				arg_407_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_410_13 = 0

			if var_410_13 < arg_407_1.time_ and arg_407_1.time_ <= var_410_13 + arg_410_0 then
				arg_407_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095actionlink/1095action436")
			end

			local var_410_14 = 0

			if var_410_14 < arg_407_1.time_ and arg_407_1.time_ <= var_410_14 + arg_410_0 then
				arg_407_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_410_15 = 0
			local var_410_16 = 0.7

			if var_410_15 < arg_407_1.time_ and arg_407_1.time_ <= var_410_15 + arg_410_0 then
				arg_407_1.talkMaxDuration = 0
				arg_407_1.dialogCg_.alpha = 1

				arg_407_1.dialog_:SetActive(true)
				SetActive(arg_407_1.leftNameGo_, true)

				local var_410_17 = arg_407_1:FormatText(StoryNameCfg[471].name)

				arg_407_1.leftNameTxt_.text = var_410_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_407_1.leftNameTxt_.transform)

				arg_407_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_407_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_407_1:RecordName(arg_407_1.leftNameTxt_.text)
				SetActive(arg_407_1.iconTrs_.gameObject, false)
				arg_407_1.callingController_:SetSelectedState("normal")

				local var_410_18 = arg_407_1:GetWordFromCfg(411051100)
				local var_410_19 = arg_407_1:FormatText(var_410_18.content)

				arg_407_1.text_.text = var_410_19

				LuaForUtil.ClearLinePrefixSymbol(arg_407_1.text_)

				local var_410_20 = 28
				local var_410_21 = utf8.len(var_410_19)
				local var_410_22 = var_410_20 <= 0 and var_410_16 or var_410_16 * (var_410_21 / var_410_20)

				if var_410_22 > 0 and var_410_16 < var_410_22 then
					arg_407_1.talkMaxDuration = var_410_22

					if var_410_22 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_22 + var_410_15
					end
				end

				arg_407_1.text_.text = var_410_19
				arg_407_1.typewritter.percent = 0

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") ~= 0 then
					local var_410_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051100", "story_v_out_411051.awb") / 1000

					if var_410_23 + var_410_15 > arg_407_1.duration_ then
						arg_407_1.duration_ = var_410_23 + var_410_15
					end

					if var_410_18.prefab_name ~= "" and arg_407_1.actors_[var_410_18.prefab_name] ~= nil then
						local var_410_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_407_1.actors_[var_410_18.prefab_name].transform, "story_v_out_411051", "411051100", "story_v_out_411051.awb")

						arg_407_1:RecordAudio("411051100", var_410_24)
						arg_407_1:RecordAudio("411051100", var_410_24)
					else
						arg_407_1:AudioAction("play", "voice", "story_v_out_411051", "411051100", "story_v_out_411051.awb")
					end

					arg_407_1:RecordHistoryTalkVoice("story_v_out_411051", "411051100", "story_v_out_411051.awb")
				end

				arg_407_1:RecordContent(arg_407_1.text_.text)
			end

			local var_410_25 = math.max(var_410_16, arg_407_1.talkMaxDuration)

			if var_410_15 <= arg_407_1.time_ and arg_407_1.time_ < var_410_15 + var_410_25 then
				arg_407_1.typewritter.percent = (arg_407_1.time_ - var_410_15) / var_410_25

				arg_407_1.typewritter:SetDirty()
			end

			if arg_407_1.time_ >= var_410_15 + var_410_25 and arg_407_1.time_ < var_410_15 + var_410_25 + arg_410_0 then
				arg_407_1.typewritter.percent = 1

				arg_407_1.typewritter:SetDirty()
				arg_407_1:ShowNextGo(true)
			end
		end
	end,
	Play411051101 = function(arg_411_0, arg_411_1)
		arg_411_1.time_ = 0
		arg_411_1.frameCnt_ = 0
		arg_411_1.state_ = "playing"
		arg_411_1.curTalkId_ = 411051101
		arg_411_1.duration_ = 1.7

		local var_411_0 = {
			zh = 0.999999999999,
			ja = 1.7
		}
		local var_411_1 = manager.audio:GetLocalizationFlag()

		if var_411_0[var_411_1] ~= nil then
			arg_411_1.duration_ = var_411_0[var_411_1]
		end

		SetActive(arg_411_1.tipsGo_, false)

		function arg_411_1.onSingleLineFinish_()
			arg_411_1.onSingleLineUpdate_ = nil
			arg_411_1.onSingleLineFinish_ = nil
			arg_411_1.state_ = "waiting"
		end

		function arg_411_1.playNext_(arg_413_0)
			if arg_413_0 == 1 then
				arg_411_0:Play411051102(arg_411_1)
			end
		end

		function arg_411_1.onSingleLineUpdate_(arg_414_0)
			local var_414_0 = arg_411_1.actors_["1095ui_story"]
			local var_414_1 = 0

			if var_414_1 < arg_411_1.time_ and arg_411_1.time_ <= var_414_1 + arg_414_0 and arg_411_1.var_.characterEffect1095ui_story == nil then
				arg_411_1.var_.characterEffect1095ui_story = var_414_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_414_2 = 0.200000002980232

			if var_414_1 <= arg_411_1.time_ and arg_411_1.time_ < var_414_1 + var_414_2 then
				local var_414_3 = (arg_411_1.time_ - var_414_1) / var_414_2

				if arg_411_1.var_.characterEffect1095ui_story then
					local var_414_4 = Mathf.Lerp(0, 0.5, var_414_3)

					arg_411_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_411_1.var_.characterEffect1095ui_story.fillRatio = var_414_4
				end
			end

			if arg_411_1.time_ >= var_414_1 + var_414_2 and arg_411_1.time_ < var_414_1 + var_414_2 + arg_414_0 and arg_411_1.var_.characterEffect1095ui_story then
				local var_414_5 = 0.5

				arg_411_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_411_1.var_.characterEffect1095ui_story.fillRatio = var_414_5
			end

			local var_414_6 = 0
			local var_414_7 = 0.075

			if var_414_6 < arg_411_1.time_ and arg_411_1.time_ <= var_414_6 + arg_414_0 then
				arg_411_1.talkMaxDuration = 0
				arg_411_1.dialogCg_.alpha = 1

				arg_411_1.dialog_:SetActive(true)
				SetActive(arg_411_1.leftNameGo_, true)

				local var_414_8 = arg_411_1:FormatText(StoryNameCfg[39].name)

				arg_411_1.leftNameTxt_.text = var_414_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_411_1.leftNameTxt_.transform)

				arg_411_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_411_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_411_1:RecordName(arg_411_1.leftNameTxt_.text)
				SetActive(arg_411_1.iconTrs_.gameObject, true)
				arg_411_1.iconController_:SetSelectedState("hero")

				arg_411_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_411_1.callingController_:SetSelectedState("normal")

				local var_414_9 = arg_411_1:GetWordFromCfg(411051101)
				local var_414_10 = arg_411_1:FormatText(var_414_9.content)

				arg_411_1.text_.text = var_414_10

				LuaForUtil.ClearLinePrefixSymbol(arg_411_1.text_)

				local var_414_11 = 3
				local var_414_12 = utf8.len(var_414_10)
				local var_414_13 = var_414_11 <= 0 and var_414_7 or var_414_7 * (var_414_12 / var_414_11)

				if var_414_13 > 0 and var_414_7 < var_414_13 then
					arg_411_1.talkMaxDuration = var_414_13

					if var_414_13 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_13 + var_414_6
					end
				end

				arg_411_1.text_.text = var_414_10
				arg_411_1.typewritter.percent = 0

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") ~= 0 then
					local var_414_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051101", "story_v_out_411051.awb") / 1000

					if var_414_14 + var_414_6 > arg_411_1.duration_ then
						arg_411_1.duration_ = var_414_14 + var_414_6
					end

					if var_414_9.prefab_name ~= "" and arg_411_1.actors_[var_414_9.prefab_name] ~= nil then
						local var_414_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_411_1.actors_[var_414_9.prefab_name].transform, "story_v_out_411051", "411051101", "story_v_out_411051.awb")

						arg_411_1:RecordAudio("411051101", var_414_15)
						arg_411_1:RecordAudio("411051101", var_414_15)
					else
						arg_411_1:AudioAction("play", "voice", "story_v_out_411051", "411051101", "story_v_out_411051.awb")
					end

					arg_411_1:RecordHistoryTalkVoice("story_v_out_411051", "411051101", "story_v_out_411051.awb")
				end

				arg_411_1:RecordContent(arg_411_1.text_.text)
			end

			local var_414_16 = math.max(var_414_7, arg_411_1.talkMaxDuration)

			if var_414_6 <= arg_411_1.time_ and arg_411_1.time_ < var_414_6 + var_414_16 then
				arg_411_1.typewritter.percent = (arg_411_1.time_ - var_414_6) / var_414_16

				arg_411_1.typewritter:SetDirty()
			end

			if arg_411_1.time_ >= var_414_6 + var_414_16 and arg_411_1.time_ < var_414_6 + var_414_16 + arg_414_0 then
				arg_411_1.typewritter.percent = 1

				arg_411_1.typewritter:SetDirty()
				arg_411_1:ShowNextGo(true)
			end
		end
	end,
	Play411051102 = function(arg_415_0, arg_415_1)
		arg_415_1.time_ = 0
		arg_415_1.frameCnt_ = 0
		arg_415_1.state_ = "playing"
		arg_415_1.curTalkId_ = 411051102
		arg_415_1.duration_ = 11.466

		local var_415_0 = {
			zh = 7.866,
			ja = 11.466
		}
		local var_415_1 = manager.audio:GetLocalizationFlag()

		if var_415_0[var_415_1] ~= nil then
			arg_415_1.duration_ = var_415_0[var_415_1]
		end

		SetActive(arg_415_1.tipsGo_, false)

		function arg_415_1.onSingleLineFinish_()
			arg_415_1.onSingleLineUpdate_ = nil
			arg_415_1.onSingleLineFinish_ = nil
			arg_415_1.state_ = "waiting"
		end

		function arg_415_1.playNext_(arg_417_0)
			if arg_417_0 == 1 then
				arg_415_0:Play411051103(arg_415_1)
			end
		end

		function arg_415_1.onSingleLineUpdate_(arg_418_0)
			local var_418_0 = arg_415_1.actors_["1095ui_story"]
			local var_418_1 = 0

			if var_418_1 < arg_415_1.time_ and arg_415_1.time_ <= var_418_1 + arg_418_0 and arg_415_1.var_.characterEffect1095ui_story == nil then
				arg_415_1.var_.characterEffect1095ui_story = var_418_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_418_2 = 0.200000002980232

			if var_418_1 <= arg_415_1.time_ and arg_415_1.time_ < var_418_1 + var_418_2 then
				local var_418_3 = (arg_415_1.time_ - var_418_1) / var_418_2

				if arg_415_1.var_.characterEffect1095ui_story then
					arg_415_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_415_1.time_ >= var_418_1 + var_418_2 and arg_415_1.time_ < var_418_1 + var_418_2 + arg_418_0 and arg_415_1.var_.characterEffect1095ui_story then
				arg_415_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_418_4 = 0
			local var_418_5 = 0.9

			if var_418_4 < arg_415_1.time_ and arg_415_1.time_ <= var_418_4 + arg_418_0 then
				arg_415_1.talkMaxDuration = 0
				arg_415_1.dialogCg_.alpha = 1

				arg_415_1.dialog_:SetActive(true)
				SetActive(arg_415_1.leftNameGo_, true)

				local var_418_6 = arg_415_1:FormatText(StoryNameCfg[471].name)

				arg_415_1.leftNameTxt_.text = var_418_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_415_1.leftNameTxt_.transform)

				arg_415_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_415_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_415_1:RecordName(arg_415_1.leftNameTxt_.text)
				SetActive(arg_415_1.iconTrs_.gameObject, false)
				arg_415_1.callingController_:SetSelectedState("normal")

				local var_418_7 = arg_415_1:GetWordFromCfg(411051102)
				local var_418_8 = arg_415_1:FormatText(var_418_7.content)

				arg_415_1.text_.text = var_418_8

				LuaForUtil.ClearLinePrefixSymbol(arg_415_1.text_)

				local var_418_9 = 36
				local var_418_10 = utf8.len(var_418_8)
				local var_418_11 = var_418_9 <= 0 and var_418_5 or var_418_5 * (var_418_10 / var_418_9)

				if var_418_11 > 0 and var_418_5 < var_418_11 then
					arg_415_1.talkMaxDuration = var_418_11

					if var_418_11 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_11 + var_418_4
					end
				end

				arg_415_1.text_.text = var_418_8
				arg_415_1.typewritter.percent = 0

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") ~= 0 then
					local var_418_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051102", "story_v_out_411051.awb") / 1000

					if var_418_12 + var_418_4 > arg_415_1.duration_ then
						arg_415_1.duration_ = var_418_12 + var_418_4
					end

					if var_418_7.prefab_name ~= "" and arg_415_1.actors_[var_418_7.prefab_name] ~= nil then
						local var_418_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_415_1.actors_[var_418_7.prefab_name].transform, "story_v_out_411051", "411051102", "story_v_out_411051.awb")

						arg_415_1:RecordAudio("411051102", var_418_13)
						arg_415_1:RecordAudio("411051102", var_418_13)
					else
						arg_415_1:AudioAction("play", "voice", "story_v_out_411051", "411051102", "story_v_out_411051.awb")
					end

					arg_415_1:RecordHistoryTalkVoice("story_v_out_411051", "411051102", "story_v_out_411051.awb")
				end

				arg_415_1:RecordContent(arg_415_1.text_.text)
			end

			local var_418_14 = math.max(var_418_5, arg_415_1.talkMaxDuration)

			if var_418_4 <= arg_415_1.time_ and arg_415_1.time_ < var_418_4 + var_418_14 then
				arg_415_1.typewritter.percent = (arg_415_1.time_ - var_418_4) / var_418_14

				arg_415_1.typewritter:SetDirty()
			end

			if arg_415_1.time_ >= var_418_4 + var_418_14 and arg_415_1.time_ < var_418_4 + var_418_14 + arg_418_0 then
				arg_415_1.typewritter.percent = 1

				arg_415_1.typewritter:SetDirty()
				arg_415_1:ShowNextGo(true)
			end
		end
	end,
	Play411051103 = function(arg_419_0, arg_419_1)
		arg_419_1.time_ = 0
		arg_419_1.frameCnt_ = 0
		arg_419_1.state_ = "playing"
		arg_419_1.curTalkId_ = 411051103
		arg_419_1.duration_ = 8.8

		local var_419_0 = {
			zh = 8.8,
			ja = 4.566
		}
		local var_419_1 = manager.audio:GetLocalizationFlag()

		if var_419_0[var_419_1] ~= nil then
			arg_419_1.duration_ = var_419_0[var_419_1]
		end

		SetActive(arg_419_1.tipsGo_, false)

		function arg_419_1.onSingleLineFinish_()
			arg_419_1.onSingleLineUpdate_ = nil
			arg_419_1.onSingleLineFinish_ = nil
			arg_419_1.state_ = "waiting"
		end

		function arg_419_1.playNext_(arg_421_0)
			if arg_421_0 == 1 then
				arg_419_0:Play411051104(arg_419_1)
			end
		end

		function arg_419_1.onSingleLineUpdate_(arg_422_0)
			local var_422_0 = 0
			local var_422_1 = 0.85

			if var_422_0 < arg_419_1.time_ and arg_419_1.time_ <= var_422_0 + arg_422_0 then
				arg_419_1.talkMaxDuration = 0
				arg_419_1.dialogCg_.alpha = 1

				arg_419_1.dialog_:SetActive(true)
				SetActive(arg_419_1.leftNameGo_, true)

				local var_422_2 = arg_419_1:FormatText(StoryNameCfg[471].name)

				arg_419_1.leftNameTxt_.text = var_422_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_419_1.leftNameTxt_.transform)

				arg_419_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_419_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_419_1:RecordName(arg_419_1.leftNameTxt_.text)
				SetActive(arg_419_1.iconTrs_.gameObject, false)
				arg_419_1.callingController_:SetSelectedState("normal")

				local var_422_3 = arg_419_1:GetWordFromCfg(411051103)
				local var_422_4 = arg_419_1:FormatText(var_422_3.content)

				arg_419_1.text_.text = var_422_4

				LuaForUtil.ClearLinePrefixSymbol(arg_419_1.text_)

				local var_422_5 = 34
				local var_422_6 = utf8.len(var_422_4)
				local var_422_7 = var_422_5 <= 0 and var_422_1 or var_422_1 * (var_422_6 / var_422_5)

				if var_422_7 > 0 and var_422_1 < var_422_7 then
					arg_419_1.talkMaxDuration = var_422_7

					if var_422_7 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_7 + var_422_0
					end
				end

				arg_419_1.text_.text = var_422_4
				arg_419_1.typewritter.percent = 0

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") ~= 0 then
					local var_422_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051103", "story_v_out_411051.awb") / 1000

					if var_422_8 + var_422_0 > arg_419_1.duration_ then
						arg_419_1.duration_ = var_422_8 + var_422_0
					end

					if var_422_3.prefab_name ~= "" and arg_419_1.actors_[var_422_3.prefab_name] ~= nil then
						local var_422_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_419_1.actors_[var_422_3.prefab_name].transform, "story_v_out_411051", "411051103", "story_v_out_411051.awb")

						arg_419_1:RecordAudio("411051103", var_422_9)
						arg_419_1:RecordAudio("411051103", var_422_9)
					else
						arg_419_1:AudioAction("play", "voice", "story_v_out_411051", "411051103", "story_v_out_411051.awb")
					end

					arg_419_1:RecordHistoryTalkVoice("story_v_out_411051", "411051103", "story_v_out_411051.awb")
				end

				arg_419_1:RecordContent(arg_419_1.text_.text)
			end

			local var_422_10 = math.max(var_422_1, arg_419_1.talkMaxDuration)

			if var_422_0 <= arg_419_1.time_ and arg_419_1.time_ < var_422_0 + var_422_10 then
				arg_419_1.typewritter.percent = (arg_419_1.time_ - var_422_0) / var_422_10

				arg_419_1.typewritter:SetDirty()
			end

			if arg_419_1.time_ >= var_422_0 + var_422_10 and arg_419_1.time_ < var_422_0 + var_422_10 + arg_422_0 then
				arg_419_1.typewritter.percent = 1

				arg_419_1.typewritter:SetDirty()
				arg_419_1:ShowNextGo(true)
			end
		end
	end,
	Play411051104 = function(arg_423_0, arg_423_1)
		arg_423_1.time_ = 0
		arg_423_1.frameCnt_ = 0
		arg_423_1.state_ = "playing"
		arg_423_1.curTalkId_ = 411051104
		arg_423_1.duration_ = 5

		SetActive(arg_423_1.tipsGo_, false)

		function arg_423_1.onSingleLineFinish_()
			arg_423_1.onSingleLineUpdate_ = nil
			arg_423_1.onSingleLineFinish_ = nil
			arg_423_1.state_ = "waiting"
		end

		function arg_423_1.playNext_(arg_425_0)
			if arg_425_0 == 1 then
				arg_423_0:Play411051105(arg_423_1)
			end
		end

		function arg_423_1.onSingleLineUpdate_(arg_426_0)
			local var_426_0 = arg_423_1.actors_["1095ui_story"]
			local var_426_1 = 0

			if var_426_1 < arg_423_1.time_ and arg_423_1.time_ <= var_426_1 + arg_426_0 and arg_423_1.var_.characterEffect1095ui_story == nil then
				arg_423_1.var_.characterEffect1095ui_story = var_426_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_426_2 = 0.200000002980232

			if var_426_1 <= arg_423_1.time_ and arg_423_1.time_ < var_426_1 + var_426_2 then
				local var_426_3 = (arg_423_1.time_ - var_426_1) / var_426_2

				if arg_423_1.var_.characterEffect1095ui_story then
					local var_426_4 = Mathf.Lerp(0, 0.5, var_426_3)

					arg_423_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_423_1.var_.characterEffect1095ui_story.fillRatio = var_426_4
				end
			end

			if arg_423_1.time_ >= var_426_1 + var_426_2 and arg_423_1.time_ < var_426_1 + var_426_2 + arg_426_0 and arg_423_1.var_.characterEffect1095ui_story then
				local var_426_5 = 0.5

				arg_423_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_423_1.var_.characterEffect1095ui_story.fillRatio = var_426_5
			end

			local var_426_6 = 0
			local var_426_7 = 1.05

			if var_426_6 < arg_423_1.time_ and arg_423_1.time_ <= var_426_6 + arg_426_0 then
				arg_423_1.talkMaxDuration = 0
				arg_423_1.dialogCg_.alpha = 1

				arg_423_1.dialog_:SetActive(true)
				SetActive(arg_423_1.leftNameGo_, false)

				arg_423_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_423_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_423_1:RecordName(arg_423_1:FormatText(GetTips("TIP_NARRATOR")))
				SetActive(arg_423_1.iconTrs_.gameObject, false)
				arg_423_1.callingController_:SetSelectedState("normal")

				local var_426_8 = arg_423_1:GetWordFromCfg(411051104)
				local var_426_9 = arg_423_1:FormatText(var_426_8.content)

				arg_423_1.text_.text = var_426_9

				LuaForUtil.ClearLinePrefixSymbol(arg_423_1.text_)

				local var_426_10 = 42
				local var_426_11 = utf8.len(var_426_9)
				local var_426_12 = var_426_10 <= 0 and var_426_7 or var_426_7 * (var_426_11 / var_426_10)

				if var_426_12 > 0 and var_426_7 < var_426_12 then
					arg_423_1.talkMaxDuration = var_426_12

					if var_426_12 + var_426_6 > arg_423_1.duration_ then
						arg_423_1.duration_ = var_426_12 + var_426_6
					end
				end

				arg_423_1.text_.text = var_426_9
				arg_423_1.typewritter.percent = 0

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(false)
				arg_423_1:RecordContent(arg_423_1.text_.text)
			end

			local var_426_13 = math.max(var_426_7, arg_423_1.talkMaxDuration)

			if var_426_6 <= arg_423_1.time_ and arg_423_1.time_ < var_426_6 + var_426_13 then
				arg_423_1.typewritter.percent = (arg_423_1.time_ - var_426_6) / var_426_13

				arg_423_1.typewritter:SetDirty()
			end

			if arg_423_1.time_ >= var_426_6 + var_426_13 and arg_423_1.time_ < var_426_6 + var_426_13 + arg_426_0 then
				arg_423_1.typewritter.percent = 1

				arg_423_1.typewritter:SetDirty()
				arg_423_1:ShowNextGo(true)
			end
		end
	end,
	Play411051105 = function(arg_427_0, arg_427_1)
		arg_427_1.time_ = 0
		arg_427_1.frameCnt_ = 0
		arg_427_1.state_ = "playing"
		arg_427_1.curTalkId_ = 411051105
		arg_427_1.duration_ = 2.433

		local var_427_0 = {
			zh = 2.433,
			ja = 1.999999999999
		}
		local var_427_1 = manager.audio:GetLocalizationFlag()

		if var_427_0[var_427_1] ~= nil then
			arg_427_1.duration_ = var_427_0[var_427_1]
		end

		SetActive(arg_427_1.tipsGo_, false)

		function arg_427_1.onSingleLineFinish_()
			arg_427_1.onSingleLineUpdate_ = nil
			arg_427_1.onSingleLineFinish_ = nil
			arg_427_1.state_ = "waiting"
		end

		function arg_427_1.playNext_(arg_429_0)
			if arg_429_0 == 1 then
				arg_427_0:Play411051106(arg_427_1)
			end
		end

		function arg_427_1.onSingleLineUpdate_(arg_430_0)
			local var_430_0 = arg_427_1.actors_["1095ui_story"]
			local var_430_1 = 0

			if var_430_1 < arg_427_1.time_ and arg_427_1.time_ <= var_430_1 + arg_430_0 and arg_427_1.var_.characterEffect1095ui_story == nil then
				arg_427_1.var_.characterEffect1095ui_story = var_430_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_430_2 = 0.200000002980232

			if var_430_1 <= arg_427_1.time_ and arg_427_1.time_ < var_430_1 + var_430_2 then
				local var_430_3 = (arg_427_1.time_ - var_430_1) / var_430_2

				if arg_427_1.var_.characterEffect1095ui_story then
					arg_427_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_427_1.time_ >= var_430_1 + var_430_2 and arg_427_1.time_ < var_430_1 + var_430_2 + arg_430_0 and arg_427_1.var_.characterEffect1095ui_story then
				arg_427_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_430_4 = 0

			if var_430_4 < arg_427_1.time_ and arg_427_1.time_ <= var_430_4 + arg_430_0 then
				arg_427_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action6_2")
			end

			local var_430_5 = 0

			if var_430_5 < arg_427_1.time_ and arg_427_1.time_ <= var_430_5 + arg_430_0 then
				arg_427_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_430_6 = 0
			local var_430_7 = 0.175

			if var_430_6 < arg_427_1.time_ and arg_427_1.time_ <= var_430_6 + arg_430_0 then
				arg_427_1.talkMaxDuration = 0
				arg_427_1.dialogCg_.alpha = 1

				arg_427_1.dialog_:SetActive(true)
				SetActive(arg_427_1.leftNameGo_, true)

				local var_430_8 = arg_427_1:FormatText(StoryNameCfg[471].name)

				arg_427_1.leftNameTxt_.text = var_430_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_427_1.leftNameTxt_.transform)

				arg_427_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_427_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_427_1:RecordName(arg_427_1.leftNameTxt_.text)
				SetActive(arg_427_1.iconTrs_.gameObject, false)
				arg_427_1.callingController_:SetSelectedState("normal")

				local var_430_9 = arg_427_1:GetWordFromCfg(411051105)
				local var_430_10 = arg_427_1:FormatText(var_430_9.content)

				arg_427_1.text_.text = var_430_10

				LuaForUtil.ClearLinePrefixSymbol(arg_427_1.text_)

				local var_430_11 = 7
				local var_430_12 = utf8.len(var_430_10)
				local var_430_13 = var_430_11 <= 0 and var_430_7 or var_430_7 * (var_430_12 / var_430_11)

				if var_430_13 > 0 and var_430_7 < var_430_13 then
					arg_427_1.talkMaxDuration = var_430_13

					if var_430_13 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_13 + var_430_6
					end
				end

				arg_427_1.text_.text = var_430_10
				arg_427_1.typewritter.percent = 0

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") ~= 0 then
					local var_430_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051105", "story_v_out_411051.awb") / 1000

					if var_430_14 + var_430_6 > arg_427_1.duration_ then
						arg_427_1.duration_ = var_430_14 + var_430_6
					end

					if var_430_9.prefab_name ~= "" and arg_427_1.actors_[var_430_9.prefab_name] ~= nil then
						local var_430_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_427_1.actors_[var_430_9.prefab_name].transform, "story_v_out_411051", "411051105", "story_v_out_411051.awb")

						arg_427_1:RecordAudio("411051105", var_430_15)
						arg_427_1:RecordAudio("411051105", var_430_15)
					else
						arg_427_1:AudioAction("play", "voice", "story_v_out_411051", "411051105", "story_v_out_411051.awb")
					end

					arg_427_1:RecordHistoryTalkVoice("story_v_out_411051", "411051105", "story_v_out_411051.awb")
				end

				arg_427_1:RecordContent(arg_427_1.text_.text)
			end

			local var_430_16 = math.max(var_430_7, arg_427_1.talkMaxDuration)

			if var_430_6 <= arg_427_1.time_ and arg_427_1.time_ < var_430_6 + var_430_16 then
				arg_427_1.typewritter.percent = (arg_427_1.time_ - var_430_6) / var_430_16

				arg_427_1.typewritter:SetDirty()
			end

			if arg_427_1.time_ >= var_430_6 + var_430_16 and arg_427_1.time_ < var_430_6 + var_430_16 + arg_430_0 then
				arg_427_1.typewritter.percent = 1

				arg_427_1.typewritter:SetDirty()
				arg_427_1:ShowNextGo(true)
			end
		end
	end,
	Play411051106 = function(arg_431_0, arg_431_1)
		arg_431_1.time_ = 0
		arg_431_1.frameCnt_ = 0
		arg_431_1.state_ = "playing"
		arg_431_1.curTalkId_ = 411051106
		arg_431_1.duration_ = 4.166

		local var_431_0 = {
			zh = 1.9,
			ja = 4.166
		}
		local var_431_1 = manager.audio:GetLocalizationFlag()

		if var_431_0[var_431_1] ~= nil then
			arg_431_1.duration_ = var_431_0[var_431_1]
		end

		SetActive(arg_431_1.tipsGo_, false)

		function arg_431_1.onSingleLineFinish_()
			arg_431_1.onSingleLineUpdate_ = nil
			arg_431_1.onSingleLineFinish_ = nil
			arg_431_1.state_ = "waiting"
		end

		function arg_431_1.playNext_(arg_433_0)
			if arg_433_0 == 1 then
				arg_431_0:Play411051107(arg_431_1)
			end
		end

		function arg_431_1.onSingleLineUpdate_(arg_434_0)
			local var_434_0 = arg_431_1.actors_["1095ui_story"]
			local var_434_1 = 0

			if var_434_1 < arg_431_1.time_ and arg_431_1.time_ <= var_434_1 + arg_434_0 and arg_431_1.var_.characterEffect1095ui_story == nil then
				arg_431_1.var_.characterEffect1095ui_story = var_434_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_434_2 = 0.200000002980232

			if var_434_1 <= arg_431_1.time_ and arg_431_1.time_ < var_434_1 + var_434_2 then
				local var_434_3 = (arg_431_1.time_ - var_434_1) / var_434_2

				if arg_431_1.var_.characterEffect1095ui_story then
					local var_434_4 = Mathf.Lerp(0, 0.5, var_434_3)

					arg_431_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_431_1.var_.characterEffect1095ui_story.fillRatio = var_434_4
				end
			end

			if arg_431_1.time_ >= var_434_1 + var_434_2 and arg_431_1.time_ < var_434_1 + var_434_2 + arg_434_0 and arg_431_1.var_.characterEffect1095ui_story then
				local var_434_5 = 0.5

				arg_431_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_431_1.var_.characterEffect1095ui_story.fillRatio = var_434_5
			end

			local var_434_6 = 0
			local var_434_7 = 0.275

			if var_434_6 < arg_431_1.time_ and arg_431_1.time_ <= var_434_6 + arg_434_0 then
				arg_431_1.talkMaxDuration = 0
				arg_431_1.dialogCg_.alpha = 1

				arg_431_1.dialog_:SetActive(true)
				SetActive(arg_431_1.leftNameGo_, true)

				local var_434_8 = arg_431_1:FormatText(StoryNameCfg[39].name)

				arg_431_1.leftNameTxt_.text = var_434_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_431_1.leftNameTxt_.transform)

				arg_431_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_431_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_431_1:RecordName(arg_431_1.leftNameTxt_.text)
				SetActive(arg_431_1.iconTrs_.gameObject, true)
				arg_431_1.iconController_:SetSelectedState("hero")

				arg_431_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_431_1.callingController_:SetSelectedState("normal")

				local var_434_9 = arg_431_1:GetWordFromCfg(411051106)
				local var_434_10 = arg_431_1:FormatText(var_434_9.content)

				arg_431_1.text_.text = var_434_10

				LuaForUtil.ClearLinePrefixSymbol(arg_431_1.text_)

				local var_434_11 = 11
				local var_434_12 = utf8.len(var_434_10)
				local var_434_13 = var_434_11 <= 0 and var_434_7 or var_434_7 * (var_434_12 / var_434_11)

				if var_434_13 > 0 and var_434_7 < var_434_13 then
					arg_431_1.talkMaxDuration = var_434_13

					if var_434_13 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_13 + var_434_6
					end
				end

				arg_431_1.text_.text = var_434_10
				arg_431_1.typewritter.percent = 0

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") ~= 0 then
					local var_434_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051106", "story_v_out_411051.awb") / 1000

					if var_434_14 + var_434_6 > arg_431_1.duration_ then
						arg_431_1.duration_ = var_434_14 + var_434_6
					end

					if var_434_9.prefab_name ~= "" and arg_431_1.actors_[var_434_9.prefab_name] ~= nil then
						local var_434_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_431_1.actors_[var_434_9.prefab_name].transform, "story_v_out_411051", "411051106", "story_v_out_411051.awb")

						arg_431_1:RecordAudio("411051106", var_434_15)
						arg_431_1:RecordAudio("411051106", var_434_15)
					else
						arg_431_1:AudioAction("play", "voice", "story_v_out_411051", "411051106", "story_v_out_411051.awb")
					end

					arg_431_1:RecordHistoryTalkVoice("story_v_out_411051", "411051106", "story_v_out_411051.awb")
				end

				arg_431_1:RecordContent(arg_431_1.text_.text)
			end

			local var_434_16 = math.max(var_434_7, arg_431_1.talkMaxDuration)

			if var_434_6 <= arg_431_1.time_ and arg_431_1.time_ < var_434_6 + var_434_16 then
				arg_431_1.typewritter.percent = (arg_431_1.time_ - var_434_6) / var_434_16

				arg_431_1.typewritter:SetDirty()
			end

			if arg_431_1.time_ >= var_434_6 + var_434_16 and arg_431_1.time_ < var_434_6 + var_434_16 + arg_434_0 then
				arg_431_1.typewritter.percent = 1

				arg_431_1.typewritter:SetDirty()
				arg_431_1:ShowNextGo(true)
			end
		end
	end,
	Play411051107 = function(arg_435_0, arg_435_1)
		arg_435_1.time_ = 0
		arg_435_1.frameCnt_ = 0
		arg_435_1.state_ = "playing"
		arg_435_1.curTalkId_ = 411051107
		arg_435_1.duration_ = 11.933

		local var_435_0 = {
			zh = 11.933,
			ja = 9.2
		}
		local var_435_1 = manager.audio:GetLocalizationFlag()

		if var_435_0[var_435_1] ~= nil then
			arg_435_1.duration_ = var_435_0[var_435_1]
		end

		SetActive(arg_435_1.tipsGo_, false)

		function arg_435_1.onSingleLineFinish_()
			arg_435_1.onSingleLineUpdate_ = nil
			arg_435_1.onSingleLineFinish_ = nil
			arg_435_1.state_ = "waiting"
		end

		function arg_435_1.playNext_(arg_437_0)
			if arg_437_0 == 1 then
				arg_435_0:Play411051108(arg_435_1)
			end
		end

		function arg_435_1.onSingleLineUpdate_(arg_438_0)
			local var_438_0 = 0
			local var_438_1 = 1.225

			if var_438_0 < arg_435_1.time_ and arg_435_1.time_ <= var_438_0 + arg_438_0 then
				arg_435_1.talkMaxDuration = 0
				arg_435_1.dialogCg_.alpha = 1

				arg_435_1.dialog_:SetActive(true)
				SetActive(arg_435_1.leftNameGo_, true)

				local var_438_2 = arg_435_1:FormatText(StoryNameCfg[39].name)

				arg_435_1.leftNameTxt_.text = var_438_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_435_1.leftNameTxt_.transform)

				arg_435_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_435_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_435_1:RecordName(arg_435_1.leftNameTxt_.text)
				SetActive(arg_435_1.iconTrs_.gameObject, true)
				arg_435_1.iconController_:SetSelectedState("hero")

				arg_435_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_435_1.callingController_:SetSelectedState("normal")

				local var_438_3 = arg_435_1:GetWordFromCfg(411051107)
				local var_438_4 = arg_435_1:FormatText(var_438_3.content)

				arg_435_1.text_.text = var_438_4

				LuaForUtil.ClearLinePrefixSymbol(arg_435_1.text_)

				local var_438_5 = 49
				local var_438_6 = utf8.len(var_438_4)
				local var_438_7 = var_438_5 <= 0 and var_438_1 or var_438_1 * (var_438_6 / var_438_5)

				if var_438_7 > 0 and var_438_1 < var_438_7 then
					arg_435_1.talkMaxDuration = var_438_7

					if var_438_7 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_7 + var_438_0
					end
				end

				arg_435_1.text_.text = var_438_4
				arg_435_1.typewritter.percent = 0

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") ~= 0 then
					local var_438_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051107", "story_v_out_411051.awb") / 1000

					if var_438_8 + var_438_0 > arg_435_1.duration_ then
						arg_435_1.duration_ = var_438_8 + var_438_0
					end

					if var_438_3.prefab_name ~= "" and arg_435_1.actors_[var_438_3.prefab_name] ~= nil then
						local var_438_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_435_1.actors_[var_438_3.prefab_name].transform, "story_v_out_411051", "411051107", "story_v_out_411051.awb")

						arg_435_1:RecordAudio("411051107", var_438_9)
						arg_435_1:RecordAudio("411051107", var_438_9)
					else
						arg_435_1:AudioAction("play", "voice", "story_v_out_411051", "411051107", "story_v_out_411051.awb")
					end

					arg_435_1:RecordHistoryTalkVoice("story_v_out_411051", "411051107", "story_v_out_411051.awb")
				end

				arg_435_1:RecordContent(arg_435_1.text_.text)
			end

			local var_438_10 = math.max(var_438_1, arg_435_1.talkMaxDuration)

			if var_438_0 <= arg_435_1.time_ and arg_435_1.time_ < var_438_0 + var_438_10 then
				arg_435_1.typewritter.percent = (arg_435_1.time_ - var_438_0) / var_438_10

				arg_435_1.typewritter:SetDirty()
			end

			if arg_435_1.time_ >= var_438_0 + var_438_10 and arg_435_1.time_ < var_438_0 + var_438_10 + arg_438_0 then
				arg_435_1.typewritter.percent = 1

				arg_435_1.typewritter:SetDirty()
				arg_435_1:ShowNextGo(true)
			end
		end
	end,
	Play411051108 = function(arg_439_0, arg_439_1)
		arg_439_1.time_ = 0
		arg_439_1.frameCnt_ = 0
		arg_439_1.state_ = "playing"
		arg_439_1.curTalkId_ = 411051108
		arg_439_1.duration_ = 12.5

		local var_439_0 = {
			zh = 12.5,
			ja = 6.7
		}
		local var_439_1 = manager.audio:GetLocalizationFlag()

		if var_439_0[var_439_1] ~= nil then
			arg_439_1.duration_ = var_439_0[var_439_1]
		end

		SetActive(arg_439_1.tipsGo_, false)

		function arg_439_1.onSingleLineFinish_()
			arg_439_1.onSingleLineUpdate_ = nil
			arg_439_1.onSingleLineFinish_ = nil
			arg_439_1.state_ = "waiting"
		end

		function arg_439_1.playNext_(arg_441_0)
			if arg_441_0 == 1 then
				arg_439_0:Play411051109(arg_439_1)
			end
		end

		function arg_439_1.onSingleLineUpdate_(arg_442_0)
			local var_442_0 = 0
			local var_442_1 = 1.375

			if var_442_0 < arg_439_1.time_ and arg_439_1.time_ <= var_442_0 + arg_442_0 then
				arg_439_1.talkMaxDuration = 0
				arg_439_1.dialogCg_.alpha = 1

				arg_439_1.dialog_:SetActive(true)
				SetActive(arg_439_1.leftNameGo_, true)

				local var_442_2 = arg_439_1:FormatText(StoryNameCfg[39].name)

				arg_439_1.leftNameTxt_.text = var_442_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_439_1.leftNameTxt_.transform)

				arg_439_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_439_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_439_1:RecordName(arg_439_1.leftNameTxt_.text)
				SetActive(arg_439_1.iconTrs_.gameObject, true)
				arg_439_1.iconController_:SetSelectedState("hero")

				arg_439_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_439_1.callingController_:SetSelectedState("normal")

				local var_442_3 = arg_439_1:GetWordFromCfg(411051108)
				local var_442_4 = arg_439_1:FormatText(var_442_3.content)

				arg_439_1.text_.text = var_442_4

				LuaForUtil.ClearLinePrefixSymbol(arg_439_1.text_)

				local var_442_5 = 55
				local var_442_6 = utf8.len(var_442_4)
				local var_442_7 = var_442_5 <= 0 and var_442_1 or var_442_1 * (var_442_6 / var_442_5)

				if var_442_7 > 0 and var_442_1 < var_442_7 then
					arg_439_1.talkMaxDuration = var_442_7

					if var_442_7 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_7 + var_442_0
					end
				end

				arg_439_1.text_.text = var_442_4
				arg_439_1.typewritter.percent = 0

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") ~= 0 then
					local var_442_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051108", "story_v_out_411051.awb") / 1000

					if var_442_8 + var_442_0 > arg_439_1.duration_ then
						arg_439_1.duration_ = var_442_8 + var_442_0
					end

					if var_442_3.prefab_name ~= "" and arg_439_1.actors_[var_442_3.prefab_name] ~= nil then
						local var_442_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_439_1.actors_[var_442_3.prefab_name].transform, "story_v_out_411051", "411051108", "story_v_out_411051.awb")

						arg_439_1:RecordAudio("411051108", var_442_9)
						arg_439_1:RecordAudio("411051108", var_442_9)
					else
						arg_439_1:AudioAction("play", "voice", "story_v_out_411051", "411051108", "story_v_out_411051.awb")
					end

					arg_439_1:RecordHistoryTalkVoice("story_v_out_411051", "411051108", "story_v_out_411051.awb")
				end

				arg_439_1:RecordContent(arg_439_1.text_.text)
			end

			local var_442_10 = math.max(var_442_1, arg_439_1.talkMaxDuration)

			if var_442_0 <= arg_439_1.time_ and arg_439_1.time_ < var_442_0 + var_442_10 then
				arg_439_1.typewritter.percent = (arg_439_1.time_ - var_442_0) / var_442_10

				arg_439_1.typewritter:SetDirty()
			end

			if arg_439_1.time_ >= var_442_0 + var_442_10 and arg_439_1.time_ < var_442_0 + var_442_10 + arg_442_0 then
				arg_439_1.typewritter.percent = 1

				arg_439_1.typewritter:SetDirty()
				arg_439_1:ShowNextGo(true)
			end
		end
	end,
	Play411051109 = function(arg_443_0, arg_443_1)
		arg_443_1.time_ = 0
		arg_443_1.frameCnt_ = 0
		arg_443_1.state_ = "playing"
		arg_443_1.curTalkId_ = 411051109
		arg_443_1.duration_ = 15

		local var_443_0 = {
			zh = 15,
			ja = 11.066
		}
		local var_443_1 = manager.audio:GetLocalizationFlag()

		if var_443_0[var_443_1] ~= nil then
			arg_443_1.duration_ = var_443_0[var_443_1]
		end

		SetActive(arg_443_1.tipsGo_, false)

		function arg_443_1.onSingleLineFinish_()
			arg_443_1.onSingleLineUpdate_ = nil
			arg_443_1.onSingleLineFinish_ = nil
			arg_443_1.state_ = "waiting"
		end

		function arg_443_1.playNext_(arg_445_0)
			if arg_445_0 == 1 then
				arg_443_0:Play411051110(arg_443_1)
			end
		end

		function arg_443_1.onSingleLineUpdate_(arg_446_0)
			local var_446_0 = 0
			local var_446_1 = 1.6

			if var_446_0 < arg_443_1.time_ and arg_443_1.time_ <= var_446_0 + arg_446_0 then
				arg_443_1.talkMaxDuration = 0
				arg_443_1.dialogCg_.alpha = 1

				arg_443_1.dialog_:SetActive(true)
				SetActive(arg_443_1.leftNameGo_, true)

				local var_446_2 = arg_443_1:FormatText(StoryNameCfg[39].name)

				arg_443_1.leftNameTxt_.text = var_446_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_443_1.leftNameTxt_.transform)

				arg_443_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_443_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_443_1:RecordName(arg_443_1.leftNameTxt_.text)
				SetActive(arg_443_1.iconTrs_.gameObject, true)
				arg_443_1.iconController_:SetSelectedState("hero")

				arg_443_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_443_1.callingController_:SetSelectedState("normal")

				local var_446_3 = arg_443_1:GetWordFromCfg(411051109)
				local var_446_4 = arg_443_1:FormatText(var_446_3.content)

				arg_443_1.text_.text = var_446_4

				LuaForUtil.ClearLinePrefixSymbol(arg_443_1.text_)

				local var_446_5 = 64
				local var_446_6 = utf8.len(var_446_4)
				local var_446_7 = var_446_5 <= 0 and var_446_1 or var_446_1 * (var_446_6 / var_446_5)

				if var_446_7 > 0 and var_446_1 < var_446_7 then
					arg_443_1.talkMaxDuration = var_446_7

					if var_446_7 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_7 + var_446_0
					end
				end

				arg_443_1.text_.text = var_446_4
				arg_443_1.typewritter.percent = 0

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") ~= 0 then
					local var_446_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051109", "story_v_out_411051.awb") / 1000

					if var_446_8 + var_446_0 > arg_443_1.duration_ then
						arg_443_1.duration_ = var_446_8 + var_446_0
					end

					if var_446_3.prefab_name ~= "" and arg_443_1.actors_[var_446_3.prefab_name] ~= nil then
						local var_446_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_443_1.actors_[var_446_3.prefab_name].transform, "story_v_out_411051", "411051109", "story_v_out_411051.awb")

						arg_443_1:RecordAudio("411051109", var_446_9)
						arg_443_1:RecordAudio("411051109", var_446_9)
					else
						arg_443_1:AudioAction("play", "voice", "story_v_out_411051", "411051109", "story_v_out_411051.awb")
					end

					arg_443_1:RecordHistoryTalkVoice("story_v_out_411051", "411051109", "story_v_out_411051.awb")
				end

				arg_443_1:RecordContent(arg_443_1.text_.text)
			end

			local var_446_10 = math.max(var_446_1, arg_443_1.talkMaxDuration)

			if var_446_0 <= arg_443_1.time_ and arg_443_1.time_ < var_446_0 + var_446_10 then
				arg_443_1.typewritter.percent = (arg_443_1.time_ - var_446_0) / var_446_10

				arg_443_1.typewritter:SetDirty()
			end

			if arg_443_1.time_ >= var_446_0 + var_446_10 and arg_443_1.time_ < var_446_0 + var_446_10 + arg_446_0 then
				arg_443_1.typewritter.percent = 1

				arg_443_1.typewritter:SetDirty()
				arg_443_1:ShowNextGo(true)
			end
		end
	end,
	Play411051110 = function(arg_447_0, arg_447_1)
		arg_447_1.time_ = 0
		arg_447_1.frameCnt_ = 0
		arg_447_1.state_ = "playing"
		arg_447_1.curTalkId_ = 411051110
		arg_447_1.duration_ = 11.566

		local var_447_0 = {
			zh = 11.433,
			ja = 11.566
		}
		local var_447_1 = manager.audio:GetLocalizationFlag()

		if var_447_0[var_447_1] ~= nil then
			arg_447_1.duration_ = var_447_0[var_447_1]
		end

		SetActive(arg_447_1.tipsGo_, false)

		function arg_447_1.onSingleLineFinish_()
			arg_447_1.onSingleLineUpdate_ = nil
			arg_447_1.onSingleLineFinish_ = nil
			arg_447_1.state_ = "waiting"
		end

		function arg_447_1.playNext_(arg_449_0)
			if arg_449_0 == 1 then
				arg_447_0:Play411051111(arg_447_1)
			end
		end

		function arg_447_1.onSingleLineUpdate_(arg_450_0)
			local var_450_0 = 0
			local var_450_1 = 1.125

			if var_450_0 < arg_447_1.time_ and arg_447_1.time_ <= var_450_0 + arg_450_0 then
				arg_447_1.talkMaxDuration = 0
				arg_447_1.dialogCg_.alpha = 1

				arg_447_1.dialog_:SetActive(true)
				SetActive(arg_447_1.leftNameGo_, true)

				local var_450_2 = arg_447_1:FormatText(StoryNameCfg[39].name)

				arg_447_1.leftNameTxt_.text = var_450_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_447_1.leftNameTxt_.transform)

				arg_447_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_447_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_447_1:RecordName(arg_447_1.leftNameTxt_.text)
				SetActive(arg_447_1.iconTrs_.gameObject, true)
				arg_447_1.iconController_:SetSelectedState("hero")

				arg_447_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_447_1.callingController_:SetSelectedState("normal")

				local var_450_3 = arg_447_1:GetWordFromCfg(411051110)
				local var_450_4 = arg_447_1:FormatText(var_450_3.content)

				arg_447_1.text_.text = var_450_4

				LuaForUtil.ClearLinePrefixSymbol(arg_447_1.text_)

				local var_450_5 = 45
				local var_450_6 = utf8.len(var_450_4)
				local var_450_7 = var_450_5 <= 0 and var_450_1 or var_450_1 * (var_450_6 / var_450_5)

				if var_450_7 > 0 and var_450_1 < var_450_7 then
					arg_447_1.talkMaxDuration = var_450_7

					if var_450_7 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_7 + var_450_0
					end
				end

				arg_447_1.text_.text = var_450_4
				arg_447_1.typewritter.percent = 0

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") ~= 0 then
					local var_450_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051110", "story_v_out_411051.awb") / 1000

					if var_450_8 + var_450_0 > arg_447_1.duration_ then
						arg_447_1.duration_ = var_450_8 + var_450_0
					end

					if var_450_3.prefab_name ~= "" and arg_447_1.actors_[var_450_3.prefab_name] ~= nil then
						local var_450_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_447_1.actors_[var_450_3.prefab_name].transform, "story_v_out_411051", "411051110", "story_v_out_411051.awb")

						arg_447_1:RecordAudio("411051110", var_450_9)
						arg_447_1:RecordAudio("411051110", var_450_9)
					else
						arg_447_1:AudioAction("play", "voice", "story_v_out_411051", "411051110", "story_v_out_411051.awb")
					end

					arg_447_1:RecordHistoryTalkVoice("story_v_out_411051", "411051110", "story_v_out_411051.awb")
				end

				arg_447_1:RecordContent(arg_447_1.text_.text)
			end

			local var_450_10 = math.max(var_450_1, arg_447_1.talkMaxDuration)

			if var_450_0 <= arg_447_1.time_ and arg_447_1.time_ < var_450_0 + var_450_10 then
				arg_447_1.typewritter.percent = (arg_447_1.time_ - var_450_0) / var_450_10

				arg_447_1.typewritter:SetDirty()
			end

			if arg_447_1.time_ >= var_450_0 + var_450_10 and arg_447_1.time_ < var_450_0 + var_450_10 + arg_450_0 then
				arg_447_1.typewritter.percent = 1

				arg_447_1.typewritter:SetDirty()
				arg_447_1:ShowNextGo(true)
			end
		end
	end,
	Play411051111 = function(arg_451_0, arg_451_1)
		arg_451_1.time_ = 0
		arg_451_1.frameCnt_ = 0
		arg_451_1.state_ = "playing"
		arg_451_1.curTalkId_ = 411051111
		arg_451_1.duration_ = 8.633

		local var_451_0 = {
			zh = 4.133,
			ja = 8.633
		}
		local var_451_1 = manager.audio:GetLocalizationFlag()

		if var_451_0[var_451_1] ~= nil then
			arg_451_1.duration_ = var_451_0[var_451_1]
		end

		SetActive(arg_451_1.tipsGo_, false)

		function arg_451_1.onSingleLineFinish_()
			arg_451_1.onSingleLineUpdate_ = nil
			arg_451_1.onSingleLineFinish_ = nil
			arg_451_1.state_ = "waiting"
		end

		function arg_451_1.playNext_(arg_453_0)
			if arg_453_0 == 1 then
				arg_451_0:Play411051112(arg_451_1)
			end
		end

		function arg_451_1.onSingleLineUpdate_(arg_454_0)
			local var_454_0 = arg_451_1.actors_["1095ui_story"]
			local var_454_1 = 0

			if var_454_1 < arg_451_1.time_ and arg_451_1.time_ <= var_454_1 + arg_454_0 and arg_451_1.var_.characterEffect1095ui_story == nil then
				arg_451_1.var_.characterEffect1095ui_story = var_454_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_454_2 = 0.200000002980232

			if var_454_1 <= arg_451_1.time_ and arg_451_1.time_ < var_454_1 + var_454_2 then
				local var_454_3 = (arg_451_1.time_ - var_454_1) / var_454_2

				if arg_451_1.var_.characterEffect1095ui_story then
					arg_451_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_451_1.time_ >= var_454_1 + var_454_2 and arg_451_1.time_ < var_454_1 + var_454_2 + arg_454_0 and arg_451_1.var_.characterEffect1095ui_story then
				arg_451_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_454_4 = 0
			local var_454_5 = 0.45

			if var_454_4 < arg_451_1.time_ and arg_451_1.time_ <= var_454_4 + arg_454_0 then
				arg_451_1.talkMaxDuration = 0
				arg_451_1.dialogCg_.alpha = 1

				arg_451_1.dialog_:SetActive(true)
				SetActive(arg_451_1.leftNameGo_, true)

				local var_454_6 = arg_451_1:FormatText(StoryNameCfg[471].name)

				arg_451_1.leftNameTxt_.text = var_454_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_451_1.leftNameTxt_.transform)

				arg_451_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_451_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_451_1:RecordName(arg_451_1.leftNameTxt_.text)
				SetActive(arg_451_1.iconTrs_.gameObject, false)
				arg_451_1.callingController_:SetSelectedState("normal")

				local var_454_7 = arg_451_1:GetWordFromCfg(411051111)
				local var_454_8 = arg_451_1:FormatText(var_454_7.content)

				arg_451_1.text_.text = var_454_8

				LuaForUtil.ClearLinePrefixSymbol(arg_451_1.text_)

				local var_454_9 = 18
				local var_454_10 = utf8.len(var_454_8)
				local var_454_11 = var_454_9 <= 0 and var_454_5 or var_454_5 * (var_454_10 / var_454_9)

				if var_454_11 > 0 and var_454_5 < var_454_11 then
					arg_451_1.talkMaxDuration = var_454_11

					if var_454_11 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_11 + var_454_4
					end
				end

				arg_451_1.text_.text = var_454_8
				arg_451_1.typewritter.percent = 0

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") ~= 0 then
					local var_454_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051111", "story_v_out_411051.awb") / 1000

					if var_454_12 + var_454_4 > arg_451_1.duration_ then
						arg_451_1.duration_ = var_454_12 + var_454_4
					end

					if var_454_7.prefab_name ~= "" and arg_451_1.actors_[var_454_7.prefab_name] ~= nil then
						local var_454_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_451_1.actors_[var_454_7.prefab_name].transform, "story_v_out_411051", "411051111", "story_v_out_411051.awb")

						arg_451_1:RecordAudio("411051111", var_454_13)
						arg_451_1:RecordAudio("411051111", var_454_13)
					else
						arg_451_1:AudioAction("play", "voice", "story_v_out_411051", "411051111", "story_v_out_411051.awb")
					end

					arg_451_1:RecordHistoryTalkVoice("story_v_out_411051", "411051111", "story_v_out_411051.awb")
				end

				arg_451_1:RecordContent(arg_451_1.text_.text)
			end

			local var_454_14 = math.max(var_454_5, arg_451_1.talkMaxDuration)

			if var_454_4 <= arg_451_1.time_ and arg_451_1.time_ < var_454_4 + var_454_14 then
				arg_451_1.typewritter.percent = (arg_451_1.time_ - var_454_4) / var_454_14

				arg_451_1.typewritter:SetDirty()
			end

			if arg_451_1.time_ >= var_454_4 + var_454_14 and arg_451_1.time_ < var_454_4 + var_454_14 + arg_454_0 then
				arg_451_1.typewritter.percent = 1

				arg_451_1.typewritter:SetDirty()
				arg_451_1:ShowNextGo(true)
			end
		end
	end,
	Play411051112 = function(arg_455_0, arg_455_1)
		arg_455_1.time_ = 0
		arg_455_1.frameCnt_ = 0
		arg_455_1.state_ = "playing"
		arg_455_1.curTalkId_ = 411051112
		arg_455_1.duration_ = 8.366

		local var_455_0 = {
			zh = 8.366,
			ja = 2.966
		}
		local var_455_1 = manager.audio:GetLocalizationFlag()

		if var_455_0[var_455_1] ~= nil then
			arg_455_1.duration_ = var_455_0[var_455_1]
		end

		SetActive(arg_455_1.tipsGo_, false)

		function arg_455_1.onSingleLineFinish_()
			arg_455_1.onSingleLineUpdate_ = nil
			arg_455_1.onSingleLineFinish_ = nil
			arg_455_1.state_ = "waiting"
		end

		function arg_455_1.playNext_(arg_457_0)
			if arg_457_0 == 1 then
				arg_455_0:Play411051113(arg_455_1)
			end
		end

		function arg_455_1.onSingleLineUpdate_(arg_458_0)
			local var_458_0 = arg_455_1.actors_["1095ui_story"]
			local var_458_1 = 0

			if var_458_1 < arg_455_1.time_ and arg_455_1.time_ <= var_458_1 + arg_458_0 and arg_455_1.var_.characterEffect1095ui_story == nil then
				arg_455_1.var_.characterEffect1095ui_story = var_458_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_458_2 = 0.200000002980232

			if var_458_1 <= arg_455_1.time_ and arg_455_1.time_ < var_458_1 + var_458_2 then
				local var_458_3 = (arg_455_1.time_ - var_458_1) / var_458_2

				if arg_455_1.var_.characterEffect1095ui_story then
					local var_458_4 = Mathf.Lerp(0, 0.5, var_458_3)

					arg_455_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_455_1.var_.characterEffect1095ui_story.fillRatio = var_458_4
				end
			end

			if arg_455_1.time_ >= var_458_1 + var_458_2 and arg_455_1.time_ < var_458_1 + var_458_2 + arg_458_0 and arg_455_1.var_.characterEffect1095ui_story then
				local var_458_5 = 0.5

				arg_455_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_455_1.var_.characterEffect1095ui_story.fillRatio = var_458_5
			end

			local var_458_6 = 0
			local var_458_7 = 1

			if var_458_6 < arg_455_1.time_ and arg_455_1.time_ <= var_458_6 + arg_458_0 then
				arg_455_1.talkMaxDuration = 0
				arg_455_1.dialogCg_.alpha = 1

				arg_455_1.dialog_:SetActive(true)
				SetActive(arg_455_1.leftNameGo_, true)

				local var_458_8 = arg_455_1:FormatText(StoryNameCfg[39].name)

				arg_455_1.leftNameTxt_.text = var_458_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_455_1.leftNameTxt_.transform)

				arg_455_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_455_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_455_1:RecordName(arg_455_1.leftNameTxt_.text)
				SetActive(arg_455_1.iconTrs_.gameObject, true)
				arg_455_1.iconController_:SetSelectedState("hero")

				arg_455_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_455_1.callingController_:SetSelectedState("normal")

				local var_458_9 = arg_455_1:GetWordFromCfg(411051112)
				local var_458_10 = arg_455_1:FormatText(var_458_9.content)

				arg_455_1.text_.text = var_458_10

				LuaForUtil.ClearLinePrefixSymbol(arg_455_1.text_)

				local var_458_11 = 40
				local var_458_12 = utf8.len(var_458_10)
				local var_458_13 = var_458_11 <= 0 and var_458_7 or var_458_7 * (var_458_12 / var_458_11)

				if var_458_13 > 0 and var_458_7 < var_458_13 then
					arg_455_1.talkMaxDuration = var_458_13

					if var_458_13 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_13 + var_458_6
					end
				end

				arg_455_1.text_.text = var_458_10
				arg_455_1.typewritter.percent = 0

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") ~= 0 then
					local var_458_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051112", "story_v_out_411051.awb") / 1000

					if var_458_14 + var_458_6 > arg_455_1.duration_ then
						arg_455_1.duration_ = var_458_14 + var_458_6
					end

					if var_458_9.prefab_name ~= "" and arg_455_1.actors_[var_458_9.prefab_name] ~= nil then
						local var_458_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_455_1.actors_[var_458_9.prefab_name].transform, "story_v_out_411051", "411051112", "story_v_out_411051.awb")

						arg_455_1:RecordAudio("411051112", var_458_15)
						arg_455_1:RecordAudio("411051112", var_458_15)
					else
						arg_455_1:AudioAction("play", "voice", "story_v_out_411051", "411051112", "story_v_out_411051.awb")
					end

					arg_455_1:RecordHistoryTalkVoice("story_v_out_411051", "411051112", "story_v_out_411051.awb")
				end

				arg_455_1:RecordContent(arg_455_1.text_.text)
			end

			local var_458_16 = math.max(var_458_7, arg_455_1.talkMaxDuration)

			if var_458_6 <= arg_455_1.time_ and arg_455_1.time_ < var_458_6 + var_458_16 then
				arg_455_1.typewritter.percent = (arg_455_1.time_ - var_458_6) / var_458_16

				arg_455_1.typewritter:SetDirty()
			end

			if arg_455_1.time_ >= var_458_6 + var_458_16 and arg_455_1.time_ < var_458_6 + var_458_16 + arg_458_0 then
				arg_455_1.typewritter.percent = 1

				arg_455_1.typewritter:SetDirty()
				arg_455_1:ShowNextGo(true)
			end
		end
	end,
	Play411051113 = function(arg_459_0, arg_459_1)
		arg_459_1.time_ = 0
		arg_459_1.frameCnt_ = 0
		arg_459_1.state_ = "playing"
		arg_459_1.curTalkId_ = 411051113
		arg_459_1.duration_ = 7.7

		local var_459_0 = {
			zh = 7.7,
			ja = 6.2
		}
		local var_459_1 = manager.audio:GetLocalizationFlag()

		if var_459_0[var_459_1] ~= nil then
			arg_459_1.duration_ = var_459_0[var_459_1]
		end

		SetActive(arg_459_1.tipsGo_, false)

		function arg_459_1.onSingleLineFinish_()
			arg_459_1.onSingleLineUpdate_ = nil
			arg_459_1.onSingleLineFinish_ = nil
			arg_459_1.state_ = "waiting"
		end

		function arg_459_1.playNext_(arg_461_0)
			if arg_461_0 == 1 then
				arg_459_0:Play411051114(arg_459_1)
			end
		end

		function arg_459_1.onSingleLineUpdate_(arg_462_0)
			local var_462_0 = 0
			local var_462_1 = 0.625

			if var_462_0 < arg_459_1.time_ and arg_459_1.time_ <= var_462_0 + arg_462_0 then
				arg_459_1.talkMaxDuration = 0
				arg_459_1.dialogCg_.alpha = 1

				arg_459_1.dialog_:SetActive(true)
				SetActive(arg_459_1.leftNameGo_, true)

				local var_462_2 = arg_459_1:FormatText(StoryNameCfg[39].name)

				arg_459_1.leftNameTxt_.text = var_462_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_459_1.leftNameTxt_.transform)

				arg_459_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_459_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_459_1:RecordName(arg_459_1.leftNameTxt_.text)
				SetActive(arg_459_1.iconTrs_.gameObject, true)
				arg_459_1.iconController_:SetSelectedState("hero")

				arg_459_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_459_1.callingController_:SetSelectedState("normal")

				local var_462_3 = arg_459_1:GetWordFromCfg(411051113)
				local var_462_4 = arg_459_1:FormatText(var_462_3.content)

				arg_459_1.text_.text = var_462_4

				LuaForUtil.ClearLinePrefixSymbol(arg_459_1.text_)

				local var_462_5 = 25
				local var_462_6 = utf8.len(var_462_4)
				local var_462_7 = var_462_5 <= 0 and var_462_1 or var_462_1 * (var_462_6 / var_462_5)

				if var_462_7 > 0 and var_462_1 < var_462_7 then
					arg_459_1.talkMaxDuration = var_462_7

					if var_462_7 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_7 + var_462_0
					end
				end

				arg_459_1.text_.text = var_462_4
				arg_459_1.typewritter.percent = 0

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") ~= 0 then
					local var_462_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051113", "story_v_out_411051.awb") / 1000

					if var_462_8 + var_462_0 > arg_459_1.duration_ then
						arg_459_1.duration_ = var_462_8 + var_462_0
					end

					if var_462_3.prefab_name ~= "" and arg_459_1.actors_[var_462_3.prefab_name] ~= nil then
						local var_462_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_459_1.actors_[var_462_3.prefab_name].transform, "story_v_out_411051", "411051113", "story_v_out_411051.awb")

						arg_459_1:RecordAudio("411051113", var_462_9)
						arg_459_1:RecordAudio("411051113", var_462_9)
					else
						arg_459_1:AudioAction("play", "voice", "story_v_out_411051", "411051113", "story_v_out_411051.awb")
					end

					arg_459_1:RecordHistoryTalkVoice("story_v_out_411051", "411051113", "story_v_out_411051.awb")
				end

				arg_459_1:RecordContent(arg_459_1.text_.text)
			end

			local var_462_10 = math.max(var_462_1, arg_459_1.talkMaxDuration)

			if var_462_0 <= arg_459_1.time_ and arg_459_1.time_ < var_462_0 + var_462_10 then
				arg_459_1.typewritter.percent = (arg_459_1.time_ - var_462_0) / var_462_10

				arg_459_1.typewritter:SetDirty()
			end

			if arg_459_1.time_ >= var_462_0 + var_462_10 and arg_459_1.time_ < var_462_0 + var_462_10 + arg_462_0 then
				arg_459_1.typewritter.percent = 1

				arg_459_1.typewritter:SetDirty()
				arg_459_1:ShowNextGo(true)
			end
		end
	end,
	Play411051114 = function(arg_463_0, arg_463_1)
		arg_463_1.time_ = 0
		arg_463_1.frameCnt_ = 0
		arg_463_1.state_ = "playing"
		arg_463_1.curTalkId_ = 411051114
		arg_463_1.duration_ = 14.966

		local var_463_0 = {
			zh = 11.966,
			ja = 14.966
		}
		local var_463_1 = manager.audio:GetLocalizationFlag()

		if var_463_0[var_463_1] ~= nil then
			arg_463_1.duration_ = var_463_0[var_463_1]
		end

		SetActive(arg_463_1.tipsGo_, false)

		function arg_463_1.onSingleLineFinish_()
			arg_463_1.onSingleLineUpdate_ = nil
			arg_463_1.onSingleLineFinish_ = nil
			arg_463_1.state_ = "waiting"
		end

		function arg_463_1.playNext_(arg_465_0)
			if arg_465_0 == 1 then
				arg_463_0:Play411051115(arg_463_1)
			end
		end

		function arg_463_1.onSingleLineUpdate_(arg_466_0)
			local var_466_0 = arg_463_1.actors_["1095ui_story"].transform
			local var_466_1 = 0

			if var_466_1 < arg_463_1.time_ and arg_463_1.time_ <= var_466_1 + arg_466_0 then
				arg_463_1.var_.moveOldPos1095ui_story = var_466_0.localPosition
			end

			local var_466_2 = 0.001

			if var_466_1 <= arg_463_1.time_ and arg_463_1.time_ < var_466_1 + var_466_2 then
				local var_466_3 = (arg_463_1.time_ - var_466_1) / var_466_2
				local var_466_4 = Vector3.New(0, -0.98, -6.1)

				var_466_0.localPosition = Vector3.Lerp(arg_463_1.var_.moveOldPos1095ui_story, var_466_4, var_466_3)

				local var_466_5 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_5.x, var_466_5.y, var_466_5.z)

				local var_466_6 = var_466_0.localEulerAngles

				var_466_6.z = 0
				var_466_6.x = 0
				var_466_0.localEulerAngles = var_466_6
			end

			if arg_463_1.time_ >= var_466_1 + var_466_2 and arg_463_1.time_ < var_466_1 + var_466_2 + arg_466_0 then
				var_466_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_466_7 = manager.ui.mainCamera.transform.position - var_466_0.position

				var_466_0.forward = Vector3.New(var_466_7.x, var_466_7.y, var_466_7.z)

				local var_466_8 = var_466_0.localEulerAngles

				var_466_8.z = 0
				var_466_8.x = 0
				var_466_0.localEulerAngles = var_466_8
			end

			local var_466_9 = arg_463_1.actors_["1095ui_story"]
			local var_466_10 = 0

			if var_466_10 < arg_463_1.time_ and arg_463_1.time_ <= var_466_10 + arg_466_0 and arg_463_1.var_.characterEffect1095ui_story == nil then
				arg_463_1.var_.characterEffect1095ui_story = var_466_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_466_11 = 0.200000002980232

			if var_466_10 <= arg_463_1.time_ and arg_463_1.time_ < var_466_10 + var_466_11 then
				local var_466_12 = (arg_463_1.time_ - var_466_10) / var_466_11

				if arg_463_1.var_.characterEffect1095ui_story then
					arg_463_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_463_1.time_ >= var_466_10 + var_466_11 and arg_463_1.time_ < var_466_10 + var_466_11 + arg_466_0 and arg_463_1.var_.characterEffect1095ui_story then
				arg_463_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_466_13 = 0

			if var_466_13 < arg_463_1.time_ and arg_463_1.time_ <= var_466_13 + arg_466_0 then
				arg_463_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_466_14 = 0

			if var_466_14 < arg_463_1.time_ and arg_463_1.time_ <= var_466_14 + arg_466_0 then
				arg_463_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_466_15 = 0
			local var_466_16 = 1.5

			if var_466_15 < arg_463_1.time_ and arg_463_1.time_ <= var_466_15 + arg_466_0 then
				arg_463_1.talkMaxDuration = 0
				arg_463_1.dialogCg_.alpha = 1

				arg_463_1.dialog_:SetActive(true)
				SetActive(arg_463_1.leftNameGo_, true)

				local var_466_17 = arg_463_1:FormatText(StoryNameCfg[471].name)

				arg_463_1.leftNameTxt_.text = var_466_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_463_1.leftNameTxt_.transform)

				arg_463_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_463_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_463_1:RecordName(arg_463_1.leftNameTxt_.text)
				SetActive(arg_463_1.iconTrs_.gameObject, false)
				arg_463_1.callingController_:SetSelectedState("normal")

				local var_466_18 = arg_463_1:GetWordFromCfg(411051114)
				local var_466_19 = arg_463_1:FormatText(var_466_18.content)

				arg_463_1.text_.text = var_466_19

				LuaForUtil.ClearLinePrefixSymbol(arg_463_1.text_)

				local var_466_20 = 60
				local var_466_21 = utf8.len(var_466_19)
				local var_466_22 = var_466_20 <= 0 and var_466_16 or var_466_16 * (var_466_21 / var_466_20)

				if var_466_22 > 0 and var_466_16 < var_466_22 then
					arg_463_1.talkMaxDuration = var_466_22

					if var_466_22 + var_466_15 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_22 + var_466_15
					end
				end

				arg_463_1.text_.text = var_466_19
				arg_463_1.typewritter.percent = 0

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") ~= 0 then
					local var_466_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051114", "story_v_out_411051.awb") / 1000

					if var_466_23 + var_466_15 > arg_463_1.duration_ then
						arg_463_1.duration_ = var_466_23 + var_466_15
					end

					if var_466_18.prefab_name ~= "" and arg_463_1.actors_[var_466_18.prefab_name] ~= nil then
						local var_466_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_463_1.actors_[var_466_18.prefab_name].transform, "story_v_out_411051", "411051114", "story_v_out_411051.awb")

						arg_463_1:RecordAudio("411051114", var_466_24)
						arg_463_1:RecordAudio("411051114", var_466_24)
					else
						arg_463_1:AudioAction("play", "voice", "story_v_out_411051", "411051114", "story_v_out_411051.awb")
					end

					arg_463_1:RecordHistoryTalkVoice("story_v_out_411051", "411051114", "story_v_out_411051.awb")
				end

				arg_463_1:RecordContent(arg_463_1.text_.text)
			end

			local var_466_25 = math.max(var_466_16, arg_463_1.talkMaxDuration)

			if var_466_15 <= arg_463_1.time_ and arg_463_1.time_ < var_466_15 + var_466_25 then
				arg_463_1.typewritter.percent = (arg_463_1.time_ - var_466_15) / var_466_25

				arg_463_1.typewritter:SetDirty()
			end

			if arg_463_1.time_ >= var_466_15 + var_466_25 and arg_463_1.time_ < var_466_15 + var_466_25 + arg_466_0 then
				arg_463_1.typewritter.percent = 1

				arg_463_1.typewritter:SetDirty()
				arg_463_1:ShowNextGo(true)
			end
		end
	end,
	Play411051115 = function(arg_467_0, arg_467_1)
		arg_467_1.time_ = 0
		arg_467_1.frameCnt_ = 0
		arg_467_1.state_ = "playing"
		arg_467_1.curTalkId_ = 411051115
		arg_467_1.duration_ = 10.966

		local var_467_0 = {
			zh = 8.833,
			ja = 10.966
		}
		local var_467_1 = manager.audio:GetLocalizationFlag()

		if var_467_0[var_467_1] ~= nil then
			arg_467_1.duration_ = var_467_0[var_467_1]
		end

		SetActive(arg_467_1.tipsGo_, false)

		function arg_467_1.onSingleLineFinish_()
			arg_467_1.onSingleLineUpdate_ = nil
			arg_467_1.onSingleLineFinish_ = nil
			arg_467_1.state_ = "waiting"
		end

		function arg_467_1.playNext_(arg_469_0)
			if arg_469_0 == 1 then
				arg_467_0:Play411051116(arg_467_1)
			end
		end

		function arg_467_1.onSingleLineUpdate_(arg_470_0)
			local var_470_0 = 0
			local var_470_1 = 1.075

			if var_470_0 < arg_467_1.time_ and arg_467_1.time_ <= var_470_0 + arg_470_0 then
				arg_467_1.talkMaxDuration = 0
				arg_467_1.dialogCg_.alpha = 1

				arg_467_1.dialog_:SetActive(true)
				SetActive(arg_467_1.leftNameGo_, true)

				local var_470_2 = arg_467_1:FormatText(StoryNameCfg[471].name)

				arg_467_1.leftNameTxt_.text = var_470_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_467_1.leftNameTxt_.transform)

				arg_467_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_467_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_467_1:RecordName(arg_467_1.leftNameTxt_.text)
				SetActive(arg_467_1.iconTrs_.gameObject, false)
				arg_467_1.callingController_:SetSelectedState("normal")

				local var_470_3 = arg_467_1:GetWordFromCfg(411051115)
				local var_470_4 = arg_467_1:FormatText(var_470_3.content)

				arg_467_1.text_.text = var_470_4

				LuaForUtil.ClearLinePrefixSymbol(arg_467_1.text_)

				local var_470_5 = 43
				local var_470_6 = utf8.len(var_470_4)
				local var_470_7 = var_470_5 <= 0 and var_470_1 or var_470_1 * (var_470_6 / var_470_5)

				if var_470_7 > 0 and var_470_1 < var_470_7 then
					arg_467_1.talkMaxDuration = var_470_7

					if var_470_7 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_7 + var_470_0
					end
				end

				arg_467_1.text_.text = var_470_4
				arg_467_1.typewritter.percent = 0

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") ~= 0 then
					local var_470_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051115", "story_v_out_411051.awb") / 1000

					if var_470_8 + var_470_0 > arg_467_1.duration_ then
						arg_467_1.duration_ = var_470_8 + var_470_0
					end

					if var_470_3.prefab_name ~= "" and arg_467_1.actors_[var_470_3.prefab_name] ~= nil then
						local var_470_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_467_1.actors_[var_470_3.prefab_name].transform, "story_v_out_411051", "411051115", "story_v_out_411051.awb")

						arg_467_1:RecordAudio("411051115", var_470_9)
						arg_467_1:RecordAudio("411051115", var_470_9)
					else
						arg_467_1:AudioAction("play", "voice", "story_v_out_411051", "411051115", "story_v_out_411051.awb")
					end

					arg_467_1:RecordHistoryTalkVoice("story_v_out_411051", "411051115", "story_v_out_411051.awb")
				end

				arg_467_1:RecordContent(arg_467_1.text_.text)
			end

			local var_470_10 = math.max(var_470_1, arg_467_1.talkMaxDuration)

			if var_470_0 <= arg_467_1.time_ and arg_467_1.time_ < var_470_0 + var_470_10 then
				arg_467_1.typewritter.percent = (arg_467_1.time_ - var_470_0) / var_470_10

				arg_467_1.typewritter:SetDirty()
			end

			if arg_467_1.time_ >= var_470_0 + var_470_10 and arg_467_1.time_ < var_470_0 + var_470_10 + arg_470_0 then
				arg_467_1.typewritter.percent = 1

				arg_467_1.typewritter:SetDirty()
				arg_467_1:ShowNextGo(true)
			end
		end
	end,
	Play411051116 = function(arg_471_0, arg_471_1)
		arg_471_1.time_ = 0
		arg_471_1.frameCnt_ = 0
		arg_471_1.state_ = "playing"
		arg_471_1.curTalkId_ = 411051116
		arg_471_1.duration_ = 8.6

		local var_471_0 = {
			zh = 8.2,
			ja = 8.6
		}
		local var_471_1 = manager.audio:GetLocalizationFlag()

		if var_471_0[var_471_1] ~= nil then
			arg_471_1.duration_ = var_471_0[var_471_1]
		end

		SetActive(arg_471_1.tipsGo_, false)

		function arg_471_1.onSingleLineFinish_()
			arg_471_1.onSingleLineUpdate_ = nil
			arg_471_1.onSingleLineFinish_ = nil
			arg_471_1.state_ = "waiting"
		end

		function arg_471_1.playNext_(arg_473_0)
			if arg_473_0 == 1 then
				arg_471_0:Play411051117(arg_471_1)
			end
		end

		function arg_471_1.onSingleLineUpdate_(arg_474_0)
			local var_474_0 = arg_471_1.actors_["1095ui_story"]
			local var_474_1 = 0

			if var_474_1 < arg_471_1.time_ and arg_471_1.time_ <= var_474_1 + arg_474_0 and arg_471_1.var_.characterEffect1095ui_story == nil then
				arg_471_1.var_.characterEffect1095ui_story = var_474_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_474_2 = 0.200000002980232

			if var_474_1 <= arg_471_1.time_ and arg_471_1.time_ < var_474_1 + var_474_2 then
				local var_474_3 = (arg_471_1.time_ - var_474_1) / var_474_2

				if arg_471_1.var_.characterEffect1095ui_story then
					local var_474_4 = Mathf.Lerp(0, 0.5, var_474_3)

					arg_471_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_471_1.var_.characterEffect1095ui_story.fillRatio = var_474_4
				end
			end

			if arg_471_1.time_ >= var_474_1 + var_474_2 and arg_471_1.time_ < var_474_1 + var_474_2 + arg_474_0 and arg_471_1.var_.characterEffect1095ui_story then
				local var_474_5 = 0.5

				arg_471_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_471_1.var_.characterEffect1095ui_story.fillRatio = var_474_5
			end

			local var_474_6 = 0
			local var_474_7 = 0.65

			if var_474_6 < arg_471_1.time_ and arg_471_1.time_ <= var_474_6 + arg_474_0 then
				arg_471_1.talkMaxDuration = 0
				arg_471_1.dialogCg_.alpha = 1

				arg_471_1.dialog_:SetActive(true)
				SetActive(arg_471_1.leftNameGo_, true)

				local var_474_8 = arg_471_1:FormatText(StoryNameCfg[39].name)

				arg_471_1.leftNameTxt_.text = var_474_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_471_1.leftNameTxt_.transform)

				arg_471_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_471_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_471_1:RecordName(arg_471_1.leftNameTxt_.text)
				SetActive(arg_471_1.iconTrs_.gameObject, true)
				arg_471_1.iconController_:SetSelectedState("hero")

				arg_471_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_471_1.callingController_:SetSelectedState("normal")

				local var_474_9 = arg_471_1:GetWordFromCfg(411051116)
				local var_474_10 = arg_471_1:FormatText(var_474_9.content)

				arg_471_1.text_.text = var_474_10

				LuaForUtil.ClearLinePrefixSymbol(arg_471_1.text_)

				local var_474_11 = 26
				local var_474_12 = utf8.len(var_474_10)
				local var_474_13 = var_474_11 <= 0 and var_474_7 or var_474_7 * (var_474_12 / var_474_11)

				if var_474_13 > 0 and var_474_7 < var_474_13 then
					arg_471_1.talkMaxDuration = var_474_13

					if var_474_13 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_13 + var_474_6
					end
				end

				arg_471_1.text_.text = var_474_10
				arg_471_1.typewritter.percent = 0

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") ~= 0 then
					local var_474_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051116", "story_v_out_411051.awb") / 1000

					if var_474_14 + var_474_6 > arg_471_1.duration_ then
						arg_471_1.duration_ = var_474_14 + var_474_6
					end

					if var_474_9.prefab_name ~= "" and arg_471_1.actors_[var_474_9.prefab_name] ~= nil then
						local var_474_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_471_1.actors_[var_474_9.prefab_name].transform, "story_v_out_411051", "411051116", "story_v_out_411051.awb")

						arg_471_1:RecordAudio("411051116", var_474_15)
						arg_471_1:RecordAudio("411051116", var_474_15)
					else
						arg_471_1:AudioAction("play", "voice", "story_v_out_411051", "411051116", "story_v_out_411051.awb")
					end

					arg_471_1:RecordHistoryTalkVoice("story_v_out_411051", "411051116", "story_v_out_411051.awb")
				end

				arg_471_1:RecordContent(arg_471_1.text_.text)
			end

			local var_474_16 = math.max(var_474_7, arg_471_1.talkMaxDuration)

			if var_474_6 <= arg_471_1.time_ and arg_471_1.time_ < var_474_6 + var_474_16 then
				arg_471_1.typewritter.percent = (arg_471_1.time_ - var_474_6) / var_474_16

				arg_471_1.typewritter:SetDirty()
			end

			if arg_471_1.time_ >= var_474_6 + var_474_16 and arg_471_1.time_ < var_474_6 + var_474_16 + arg_474_0 then
				arg_471_1.typewritter.percent = 1

				arg_471_1.typewritter:SetDirty()
				arg_471_1:ShowNextGo(true)
			end
		end
	end,
	Play411051117 = function(arg_475_0, arg_475_1)
		arg_475_1.time_ = 0
		arg_475_1.frameCnt_ = 0
		arg_475_1.state_ = "playing"
		arg_475_1.curTalkId_ = 411051117
		arg_475_1.duration_ = 6.4

		local var_475_0 = {
			zh = 4.266,
			ja = 6.4
		}
		local var_475_1 = manager.audio:GetLocalizationFlag()

		if var_475_0[var_475_1] ~= nil then
			arg_475_1.duration_ = var_475_0[var_475_1]
		end

		SetActive(arg_475_1.tipsGo_, false)

		function arg_475_1.onSingleLineFinish_()
			arg_475_1.onSingleLineUpdate_ = nil
			arg_475_1.onSingleLineFinish_ = nil
			arg_475_1.state_ = "waiting"
		end

		function arg_475_1.playNext_(arg_477_0)
			if arg_477_0 == 1 then
				arg_475_0:Play411051118(arg_475_1)
			end
		end

		function arg_475_1.onSingleLineUpdate_(arg_478_0)
			local var_478_0 = arg_475_1.actors_["1095ui_story"]
			local var_478_1 = 0

			if var_478_1 < arg_475_1.time_ and arg_475_1.time_ <= var_478_1 + arg_478_0 and arg_475_1.var_.characterEffect1095ui_story == nil then
				arg_475_1.var_.characterEffect1095ui_story = var_478_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_478_2 = 0.200000002980232

			if var_478_1 <= arg_475_1.time_ and arg_475_1.time_ < var_478_1 + var_478_2 then
				local var_478_3 = (arg_475_1.time_ - var_478_1) / var_478_2

				if arg_475_1.var_.characterEffect1095ui_story then
					arg_475_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_475_1.time_ >= var_478_1 + var_478_2 and arg_475_1.time_ < var_478_1 + var_478_2 + arg_478_0 and arg_475_1.var_.characterEffect1095ui_story then
				arg_475_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_478_4 = 0
			local var_478_5 = 0.55

			if var_478_4 < arg_475_1.time_ and arg_475_1.time_ <= var_478_4 + arg_478_0 then
				arg_475_1.talkMaxDuration = 0
				arg_475_1.dialogCg_.alpha = 1

				arg_475_1.dialog_:SetActive(true)
				SetActive(arg_475_1.leftNameGo_, true)

				local var_478_6 = arg_475_1:FormatText(StoryNameCfg[471].name)

				arg_475_1.leftNameTxt_.text = var_478_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_475_1.leftNameTxt_.transform)

				arg_475_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_475_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_475_1:RecordName(arg_475_1.leftNameTxt_.text)
				SetActive(arg_475_1.iconTrs_.gameObject, false)
				arg_475_1.callingController_:SetSelectedState("normal")

				local var_478_7 = arg_475_1:GetWordFromCfg(411051117)
				local var_478_8 = arg_475_1:FormatText(var_478_7.content)

				arg_475_1.text_.text = var_478_8

				LuaForUtil.ClearLinePrefixSymbol(arg_475_1.text_)

				local var_478_9 = 22
				local var_478_10 = utf8.len(var_478_8)
				local var_478_11 = var_478_9 <= 0 and var_478_5 or var_478_5 * (var_478_10 / var_478_9)

				if var_478_11 > 0 and var_478_5 < var_478_11 then
					arg_475_1.talkMaxDuration = var_478_11

					if var_478_11 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_11 + var_478_4
					end
				end

				arg_475_1.text_.text = var_478_8
				arg_475_1.typewritter.percent = 0

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") ~= 0 then
					local var_478_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051117", "story_v_out_411051.awb") / 1000

					if var_478_12 + var_478_4 > arg_475_1.duration_ then
						arg_475_1.duration_ = var_478_12 + var_478_4
					end

					if var_478_7.prefab_name ~= "" and arg_475_1.actors_[var_478_7.prefab_name] ~= nil then
						local var_478_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_475_1.actors_[var_478_7.prefab_name].transform, "story_v_out_411051", "411051117", "story_v_out_411051.awb")

						arg_475_1:RecordAudio("411051117", var_478_13)
						arg_475_1:RecordAudio("411051117", var_478_13)
					else
						arg_475_1:AudioAction("play", "voice", "story_v_out_411051", "411051117", "story_v_out_411051.awb")
					end

					arg_475_1:RecordHistoryTalkVoice("story_v_out_411051", "411051117", "story_v_out_411051.awb")
				end

				arg_475_1:RecordContent(arg_475_1.text_.text)
			end

			local var_478_14 = math.max(var_478_5, arg_475_1.talkMaxDuration)

			if var_478_4 <= arg_475_1.time_ and arg_475_1.time_ < var_478_4 + var_478_14 then
				arg_475_1.typewritter.percent = (arg_475_1.time_ - var_478_4) / var_478_14

				arg_475_1.typewritter:SetDirty()
			end

			if arg_475_1.time_ >= var_478_4 + var_478_14 and arg_475_1.time_ < var_478_4 + var_478_14 + arg_478_0 then
				arg_475_1.typewritter.percent = 1

				arg_475_1.typewritter:SetDirty()
				arg_475_1:ShowNextGo(true)
			end
		end
	end,
	Play411051118 = function(arg_479_0, arg_479_1)
		arg_479_1.time_ = 0
		arg_479_1.frameCnt_ = 0
		arg_479_1.state_ = "playing"
		arg_479_1.curTalkId_ = 411051118
		arg_479_1.duration_ = 8.8

		local var_479_0 = {
			zh = 8.8,
			ja = 5.333
		}
		local var_479_1 = manager.audio:GetLocalizationFlag()

		if var_479_0[var_479_1] ~= nil then
			arg_479_1.duration_ = var_479_0[var_479_1]
		end

		SetActive(arg_479_1.tipsGo_, false)

		function arg_479_1.onSingleLineFinish_()
			arg_479_1.onSingleLineUpdate_ = nil
			arg_479_1.onSingleLineFinish_ = nil
			arg_479_1.state_ = "waiting"
		end

		function arg_479_1.playNext_(arg_481_0)
			if arg_481_0 == 1 then
				arg_479_0:Play411051119(arg_479_1)
			end
		end

		function arg_479_1.onSingleLineUpdate_(arg_482_0)
			local var_482_0 = 0
			local var_482_1 = 1.075

			if var_482_0 < arg_479_1.time_ and arg_479_1.time_ <= var_482_0 + arg_482_0 then
				arg_479_1.talkMaxDuration = 0
				arg_479_1.dialogCg_.alpha = 1

				arg_479_1.dialog_:SetActive(true)
				SetActive(arg_479_1.leftNameGo_, true)

				local var_482_2 = arg_479_1:FormatText(StoryNameCfg[471].name)

				arg_479_1.leftNameTxt_.text = var_482_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_479_1.leftNameTxt_.transform)

				arg_479_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_479_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_479_1:RecordName(arg_479_1.leftNameTxt_.text)
				SetActive(arg_479_1.iconTrs_.gameObject, false)
				arg_479_1.callingController_:SetSelectedState("normal")

				local var_482_3 = arg_479_1:GetWordFromCfg(411051118)
				local var_482_4 = arg_479_1:FormatText(var_482_3.content)

				arg_479_1.text_.text = var_482_4

				LuaForUtil.ClearLinePrefixSymbol(arg_479_1.text_)

				local var_482_5 = 43
				local var_482_6 = utf8.len(var_482_4)
				local var_482_7 = var_482_5 <= 0 and var_482_1 or var_482_1 * (var_482_6 / var_482_5)

				if var_482_7 > 0 and var_482_1 < var_482_7 then
					arg_479_1.talkMaxDuration = var_482_7

					if var_482_7 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_7 + var_482_0
					end
				end

				arg_479_1.text_.text = var_482_4
				arg_479_1.typewritter.percent = 0

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") ~= 0 then
					local var_482_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051118", "story_v_out_411051.awb") / 1000

					if var_482_8 + var_482_0 > arg_479_1.duration_ then
						arg_479_1.duration_ = var_482_8 + var_482_0
					end

					if var_482_3.prefab_name ~= "" and arg_479_1.actors_[var_482_3.prefab_name] ~= nil then
						local var_482_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_479_1.actors_[var_482_3.prefab_name].transform, "story_v_out_411051", "411051118", "story_v_out_411051.awb")

						arg_479_1:RecordAudio("411051118", var_482_9)
						arg_479_1:RecordAudio("411051118", var_482_9)
					else
						arg_479_1:AudioAction("play", "voice", "story_v_out_411051", "411051118", "story_v_out_411051.awb")
					end

					arg_479_1:RecordHistoryTalkVoice("story_v_out_411051", "411051118", "story_v_out_411051.awb")
				end

				arg_479_1:RecordContent(arg_479_1.text_.text)
			end

			local var_482_10 = math.max(var_482_1, arg_479_1.talkMaxDuration)

			if var_482_0 <= arg_479_1.time_ and arg_479_1.time_ < var_482_0 + var_482_10 then
				arg_479_1.typewritter.percent = (arg_479_1.time_ - var_482_0) / var_482_10

				arg_479_1.typewritter:SetDirty()
			end

			if arg_479_1.time_ >= var_482_0 + var_482_10 and arg_479_1.time_ < var_482_0 + var_482_10 + arg_482_0 then
				arg_479_1.typewritter.percent = 1

				arg_479_1.typewritter:SetDirty()
				arg_479_1:ShowNextGo(true)
			end
		end
	end,
	Play411051119 = function(arg_483_0, arg_483_1)
		arg_483_1.time_ = 0
		arg_483_1.frameCnt_ = 0
		arg_483_1.state_ = "playing"
		arg_483_1.curTalkId_ = 411051119
		arg_483_1.duration_ = 1.566

		local var_483_0 = {
			zh = 1.466,
			ja = 1.566
		}
		local var_483_1 = manager.audio:GetLocalizationFlag()

		if var_483_0[var_483_1] ~= nil then
			arg_483_1.duration_ = var_483_0[var_483_1]
		end

		SetActive(arg_483_1.tipsGo_, false)

		function arg_483_1.onSingleLineFinish_()
			arg_483_1.onSingleLineUpdate_ = nil
			arg_483_1.onSingleLineFinish_ = nil
			arg_483_1.state_ = "waiting"
		end

		function arg_483_1.playNext_(arg_485_0)
			if arg_485_0 == 1 then
				arg_483_0:Play411051120(arg_483_1)
			end
		end

		function arg_483_1.onSingleLineUpdate_(arg_486_0)
			local var_486_0 = 0
			local var_486_1 = 0.125

			if var_486_0 < arg_483_1.time_ and arg_483_1.time_ <= var_486_0 + arg_486_0 then
				arg_483_1.talkMaxDuration = 0
				arg_483_1.dialogCg_.alpha = 1

				arg_483_1.dialog_:SetActive(true)
				SetActive(arg_483_1.leftNameGo_, true)

				local var_486_2 = arg_483_1:FormatText(StoryNameCfg[39].name)

				arg_483_1.leftNameTxt_.text = var_486_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_483_1.leftNameTxt_.transform)

				arg_483_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_483_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_483_1:RecordName(arg_483_1.leftNameTxt_.text)
				SetActive(arg_483_1.iconTrs_.gameObject, true)
				arg_483_1.iconController_:SetSelectedState("hero")

				arg_483_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_483_1.callingController_:SetSelectedState("normal")

				local var_486_3 = arg_483_1:GetWordFromCfg(411051119)
				local var_486_4 = arg_483_1:FormatText(var_486_3.content)

				arg_483_1.text_.text = var_486_4

				LuaForUtil.ClearLinePrefixSymbol(arg_483_1.text_)

				local var_486_5 = 5
				local var_486_6 = utf8.len(var_486_4)
				local var_486_7 = var_486_5 <= 0 and var_486_1 or var_486_1 * (var_486_6 / var_486_5)

				if var_486_7 > 0 and var_486_1 < var_486_7 then
					arg_483_1.talkMaxDuration = var_486_7

					if var_486_7 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_7 + var_486_0
					end
				end

				arg_483_1.text_.text = var_486_4
				arg_483_1.typewritter.percent = 0

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") ~= 0 then
					local var_486_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051119", "story_v_out_411051.awb") / 1000

					if var_486_8 + var_486_0 > arg_483_1.duration_ then
						arg_483_1.duration_ = var_486_8 + var_486_0
					end

					if var_486_3.prefab_name ~= "" and arg_483_1.actors_[var_486_3.prefab_name] ~= nil then
						local var_486_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_483_1.actors_[var_486_3.prefab_name].transform, "story_v_out_411051", "411051119", "story_v_out_411051.awb")

						arg_483_1:RecordAudio("411051119", var_486_9)
						arg_483_1:RecordAudio("411051119", var_486_9)
					else
						arg_483_1:AudioAction("play", "voice", "story_v_out_411051", "411051119", "story_v_out_411051.awb")
					end

					arg_483_1:RecordHistoryTalkVoice("story_v_out_411051", "411051119", "story_v_out_411051.awb")
				end

				arg_483_1:RecordContent(arg_483_1.text_.text)
			end

			local var_486_10 = math.max(var_486_1, arg_483_1.talkMaxDuration)

			if var_486_0 <= arg_483_1.time_ and arg_483_1.time_ < var_486_0 + var_486_10 then
				arg_483_1.typewritter.percent = (arg_483_1.time_ - var_486_0) / var_486_10

				arg_483_1.typewritter:SetDirty()
			end

			if arg_483_1.time_ >= var_486_0 + var_486_10 and arg_483_1.time_ < var_486_0 + var_486_10 + arg_486_0 then
				arg_483_1.typewritter.percent = 1

				arg_483_1.typewritter:SetDirty()
				arg_483_1:ShowNextGo(true)
			end
		end
	end,
	Play411051120 = function(arg_487_0, arg_487_1)
		arg_487_1.time_ = 0
		arg_487_1.frameCnt_ = 0
		arg_487_1.state_ = "playing"
		arg_487_1.curTalkId_ = 411051120
		arg_487_1.duration_ = 8.433

		local var_487_0 = {
			zh = 8.433,
			ja = 6.9
		}
		local var_487_1 = manager.audio:GetLocalizationFlag()

		if var_487_0[var_487_1] ~= nil then
			arg_487_1.duration_ = var_487_0[var_487_1]
		end

		SetActive(arg_487_1.tipsGo_, false)

		function arg_487_1.onSingleLineFinish_()
			arg_487_1.onSingleLineUpdate_ = nil
			arg_487_1.onSingleLineFinish_ = nil
			arg_487_1.state_ = "waiting"
		end

		function arg_487_1.playNext_(arg_489_0)
			if arg_489_0 == 1 then
				arg_487_0:Play411051121(arg_487_1)
			end
		end

		function arg_487_1.onSingleLineUpdate_(arg_490_0)
			local var_490_0 = arg_487_1.actors_["1095ui_story"].transform
			local var_490_1 = 0

			if var_490_1 < arg_487_1.time_ and arg_487_1.time_ <= var_490_1 + arg_490_0 then
				arg_487_1.var_.moveOldPos1095ui_story = var_490_0.localPosition
			end

			local var_490_2 = 0.001

			if var_490_1 <= arg_487_1.time_ and arg_487_1.time_ < var_490_1 + var_490_2 then
				local var_490_3 = (arg_487_1.time_ - var_490_1) / var_490_2
				local var_490_4 = Vector3.New(0, -0.98, -6.1)

				var_490_0.localPosition = Vector3.Lerp(arg_487_1.var_.moveOldPos1095ui_story, var_490_4, var_490_3)

				local var_490_5 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_5.x, var_490_5.y, var_490_5.z)

				local var_490_6 = var_490_0.localEulerAngles

				var_490_6.z = 0
				var_490_6.x = 0
				var_490_0.localEulerAngles = var_490_6
			end

			if arg_487_1.time_ >= var_490_1 + var_490_2 and arg_487_1.time_ < var_490_1 + var_490_2 + arg_490_0 then
				var_490_0.localPosition = Vector3.New(0, -0.98, -6.1)

				local var_490_7 = manager.ui.mainCamera.transform.position - var_490_0.position

				var_490_0.forward = Vector3.New(var_490_7.x, var_490_7.y, var_490_7.z)

				local var_490_8 = var_490_0.localEulerAngles

				var_490_8.z = 0
				var_490_8.x = 0
				var_490_0.localEulerAngles = var_490_8
			end

			local var_490_9 = arg_487_1.actors_["1095ui_story"]
			local var_490_10 = 0

			if var_490_10 < arg_487_1.time_ and arg_487_1.time_ <= var_490_10 + arg_490_0 and arg_487_1.var_.characterEffect1095ui_story == nil then
				arg_487_1.var_.characterEffect1095ui_story = var_490_9:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_490_11 = 0.200000002980232

			if var_490_10 <= arg_487_1.time_ and arg_487_1.time_ < var_490_10 + var_490_11 then
				local var_490_12 = (arg_487_1.time_ - var_490_10) / var_490_11

				if arg_487_1.var_.characterEffect1095ui_story then
					arg_487_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_487_1.time_ >= var_490_10 + var_490_11 and arg_487_1.time_ < var_490_10 + var_490_11 + arg_490_0 and arg_487_1.var_.characterEffect1095ui_story then
				arg_487_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_490_13 = 0

			if var_490_13 < arg_487_1.time_ and arg_487_1.time_ <= var_490_13 + arg_490_0 then
				arg_487_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/story1095/story1095action/1095action1_1")
			end

			local var_490_14 = 0

			if var_490_14 < arg_487_1.time_ and arg_487_1.time_ <= var_490_14 + arg_490_0 then
				arg_487_1:PlayTimeline("1095ui_story", "StoryTimeline/CharAction/public_expression/public_lipsync/publicface0102cva")
			end

			local var_490_15 = 0
			local var_490_16 = 0.875

			if var_490_15 < arg_487_1.time_ and arg_487_1.time_ <= var_490_15 + arg_490_0 then
				arg_487_1.talkMaxDuration = 0
				arg_487_1.dialogCg_.alpha = 1

				arg_487_1.dialog_:SetActive(true)
				SetActive(arg_487_1.leftNameGo_, true)

				local var_490_17 = arg_487_1:FormatText(StoryNameCfg[471].name)

				arg_487_1.leftNameTxt_.text = var_490_17

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_487_1.leftNameTxt_.transform)

				arg_487_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_487_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_487_1:RecordName(arg_487_1.leftNameTxt_.text)
				SetActive(arg_487_1.iconTrs_.gameObject, false)
				arg_487_1.callingController_:SetSelectedState("normal")

				local var_490_18 = arg_487_1:GetWordFromCfg(411051120)
				local var_490_19 = arg_487_1:FormatText(var_490_18.content)

				arg_487_1.text_.text = var_490_19

				LuaForUtil.ClearLinePrefixSymbol(arg_487_1.text_)

				local var_490_20 = 35
				local var_490_21 = utf8.len(var_490_19)
				local var_490_22 = var_490_20 <= 0 and var_490_16 or var_490_16 * (var_490_21 / var_490_20)

				if var_490_22 > 0 and var_490_16 < var_490_22 then
					arg_487_1.talkMaxDuration = var_490_22

					if var_490_22 + var_490_15 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_22 + var_490_15
					end
				end

				arg_487_1.text_.text = var_490_19
				arg_487_1.typewritter.percent = 0

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") ~= 0 then
					local var_490_23 = manager.audio:GetVoiceLength("story_v_out_411051", "411051120", "story_v_out_411051.awb") / 1000

					if var_490_23 + var_490_15 > arg_487_1.duration_ then
						arg_487_1.duration_ = var_490_23 + var_490_15
					end

					if var_490_18.prefab_name ~= "" and arg_487_1.actors_[var_490_18.prefab_name] ~= nil then
						local var_490_24 = LuaForUtil.PlayVoiceWithCriLipsync(arg_487_1.actors_[var_490_18.prefab_name].transform, "story_v_out_411051", "411051120", "story_v_out_411051.awb")

						arg_487_1:RecordAudio("411051120", var_490_24)
						arg_487_1:RecordAudio("411051120", var_490_24)
					else
						arg_487_1:AudioAction("play", "voice", "story_v_out_411051", "411051120", "story_v_out_411051.awb")
					end

					arg_487_1:RecordHistoryTalkVoice("story_v_out_411051", "411051120", "story_v_out_411051.awb")
				end

				arg_487_1:RecordContent(arg_487_1.text_.text)
			end

			local var_490_25 = math.max(var_490_16, arg_487_1.talkMaxDuration)

			if var_490_15 <= arg_487_1.time_ and arg_487_1.time_ < var_490_15 + var_490_25 then
				arg_487_1.typewritter.percent = (arg_487_1.time_ - var_490_15) / var_490_25

				arg_487_1.typewritter:SetDirty()
			end

			if arg_487_1.time_ >= var_490_15 + var_490_25 and arg_487_1.time_ < var_490_15 + var_490_25 + arg_490_0 then
				arg_487_1.typewritter.percent = 1

				arg_487_1.typewritter:SetDirty()
				arg_487_1:ShowNextGo(true)
			end
		end
	end,
	Play411051121 = function(arg_491_0, arg_491_1)
		arg_491_1.time_ = 0
		arg_491_1.frameCnt_ = 0
		arg_491_1.state_ = "playing"
		arg_491_1.curTalkId_ = 411051121
		arg_491_1.duration_ = 8

		local var_491_0 = {
			zh = 8,
			ja = 6.266
		}
		local var_491_1 = manager.audio:GetLocalizationFlag()

		if var_491_0[var_491_1] ~= nil then
			arg_491_1.duration_ = var_491_0[var_491_1]
		end

		SetActive(arg_491_1.tipsGo_, false)

		function arg_491_1.onSingleLineFinish_()
			arg_491_1.onSingleLineUpdate_ = nil
			arg_491_1.onSingleLineFinish_ = nil
			arg_491_1.state_ = "waiting"
		end

		function arg_491_1.playNext_(arg_493_0)
			if arg_493_0 == 1 then
				arg_491_0:Play411051122(arg_491_1)
			end
		end

		function arg_491_1.onSingleLineUpdate_(arg_494_0)
			local var_494_0 = arg_491_1.actors_["1095ui_story"]
			local var_494_1 = 0

			if var_494_1 < arg_491_1.time_ and arg_491_1.time_ <= var_494_1 + arg_494_0 and arg_491_1.var_.characterEffect1095ui_story == nil then
				arg_491_1.var_.characterEffect1095ui_story = var_494_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_494_2 = 0.200000002980232

			if var_494_1 <= arg_491_1.time_ and arg_491_1.time_ < var_494_1 + var_494_2 then
				local var_494_3 = (arg_491_1.time_ - var_494_1) / var_494_2

				if arg_491_1.var_.characterEffect1095ui_story then
					local var_494_4 = Mathf.Lerp(0, 0.5, var_494_3)

					arg_491_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_491_1.var_.characterEffect1095ui_story.fillRatio = var_494_4
				end
			end

			if arg_491_1.time_ >= var_494_1 + var_494_2 and arg_491_1.time_ < var_494_1 + var_494_2 + arg_494_0 and arg_491_1.var_.characterEffect1095ui_story then
				local var_494_5 = 0.5

				arg_491_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_491_1.var_.characterEffect1095ui_story.fillRatio = var_494_5
			end

			local var_494_6 = 0
			local var_494_7 = 0.875

			if var_494_6 < arg_491_1.time_ and arg_491_1.time_ <= var_494_6 + arg_494_0 then
				arg_491_1.talkMaxDuration = 0
				arg_491_1.dialogCg_.alpha = 1

				arg_491_1.dialog_:SetActive(true)
				SetActive(arg_491_1.leftNameGo_, true)

				local var_494_8 = arg_491_1:FormatText(StoryNameCfg[39].name)

				arg_491_1.leftNameTxt_.text = var_494_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_491_1.leftNameTxt_.transform)

				arg_491_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_491_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_491_1:RecordName(arg_491_1.leftNameTxt_.text)
				SetActive(arg_491_1.iconTrs_.gameObject, true)
				arg_491_1.iconController_:SetSelectedState("hero")

				arg_491_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_491_1.callingController_:SetSelectedState("normal")

				local var_494_9 = arg_491_1:GetWordFromCfg(411051121)
				local var_494_10 = arg_491_1:FormatText(var_494_9.content)

				arg_491_1.text_.text = var_494_10

				LuaForUtil.ClearLinePrefixSymbol(arg_491_1.text_)

				local var_494_11 = 35
				local var_494_12 = utf8.len(var_494_10)
				local var_494_13 = var_494_11 <= 0 and var_494_7 or var_494_7 * (var_494_12 / var_494_11)

				if var_494_13 > 0 and var_494_7 < var_494_13 then
					arg_491_1.talkMaxDuration = var_494_13

					if var_494_13 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_13 + var_494_6
					end
				end

				arg_491_1.text_.text = var_494_10
				arg_491_1.typewritter.percent = 0

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") ~= 0 then
					local var_494_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051121", "story_v_out_411051.awb") / 1000

					if var_494_14 + var_494_6 > arg_491_1.duration_ then
						arg_491_1.duration_ = var_494_14 + var_494_6
					end

					if var_494_9.prefab_name ~= "" and arg_491_1.actors_[var_494_9.prefab_name] ~= nil then
						local var_494_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_491_1.actors_[var_494_9.prefab_name].transform, "story_v_out_411051", "411051121", "story_v_out_411051.awb")

						arg_491_1:RecordAudio("411051121", var_494_15)
						arg_491_1:RecordAudio("411051121", var_494_15)
					else
						arg_491_1:AudioAction("play", "voice", "story_v_out_411051", "411051121", "story_v_out_411051.awb")
					end

					arg_491_1:RecordHistoryTalkVoice("story_v_out_411051", "411051121", "story_v_out_411051.awb")
				end

				arg_491_1:RecordContent(arg_491_1.text_.text)
			end

			local var_494_16 = math.max(var_494_7, arg_491_1.talkMaxDuration)

			if var_494_6 <= arg_491_1.time_ and arg_491_1.time_ < var_494_6 + var_494_16 then
				arg_491_1.typewritter.percent = (arg_491_1.time_ - var_494_6) / var_494_16

				arg_491_1.typewritter:SetDirty()
			end

			if arg_491_1.time_ >= var_494_6 + var_494_16 and arg_491_1.time_ < var_494_6 + var_494_16 + arg_494_0 then
				arg_491_1.typewritter.percent = 1

				arg_491_1.typewritter:SetDirty()
				arg_491_1:ShowNextGo(true)
			end
		end
	end,
	Play411051122 = function(arg_495_0, arg_495_1)
		arg_495_1.time_ = 0
		arg_495_1.frameCnt_ = 0
		arg_495_1.state_ = "playing"
		arg_495_1.curTalkId_ = 411051122
		arg_495_1.duration_ = 7.766

		local var_495_0 = {
			zh = 6.433,
			ja = 7.766
		}
		local var_495_1 = manager.audio:GetLocalizationFlag()

		if var_495_0[var_495_1] ~= nil then
			arg_495_1.duration_ = var_495_0[var_495_1]
		end

		SetActive(arg_495_1.tipsGo_, false)

		function arg_495_1.onSingleLineFinish_()
			arg_495_1.onSingleLineUpdate_ = nil
			arg_495_1.onSingleLineFinish_ = nil
			arg_495_1.state_ = "waiting"
		end

		function arg_495_1.playNext_(arg_497_0)
			if arg_497_0 == 1 then
				arg_495_0:Play411051123(arg_495_1)
			end
		end

		function arg_495_1.onSingleLineUpdate_(arg_498_0)
			local var_498_0 = arg_495_1.actors_["1095ui_story"]
			local var_498_1 = 0

			if var_498_1 < arg_495_1.time_ and arg_495_1.time_ <= var_498_1 + arg_498_0 and arg_495_1.var_.characterEffect1095ui_story == nil then
				arg_495_1.var_.characterEffect1095ui_story = var_498_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_498_2 = 0.200000002980232

			if var_498_1 <= arg_495_1.time_ and arg_495_1.time_ < var_498_1 + var_498_2 then
				local var_498_3 = (arg_495_1.time_ - var_498_1) / var_498_2

				if arg_495_1.var_.characterEffect1095ui_story then
					arg_495_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_495_1.time_ >= var_498_1 + var_498_2 and arg_495_1.time_ < var_498_1 + var_498_2 + arg_498_0 and arg_495_1.var_.characterEffect1095ui_story then
				arg_495_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_498_4 = 0
			local var_498_5 = 0.575

			if var_498_4 < arg_495_1.time_ and arg_495_1.time_ <= var_498_4 + arg_498_0 then
				arg_495_1.talkMaxDuration = 0
				arg_495_1.dialogCg_.alpha = 1

				arg_495_1.dialog_:SetActive(true)
				SetActive(arg_495_1.leftNameGo_, true)

				local var_498_6 = arg_495_1:FormatText(StoryNameCfg[471].name)

				arg_495_1.leftNameTxt_.text = var_498_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_495_1.leftNameTxt_.transform)

				arg_495_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_495_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_495_1:RecordName(arg_495_1.leftNameTxt_.text)
				SetActive(arg_495_1.iconTrs_.gameObject, false)
				arg_495_1.callingController_:SetSelectedState("normal")

				local var_498_7 = arg_495_1:GetWordFromCfg(411051122)
				local var_498_8 = arg_495_1:FormatText(var_498_7.content)

				arg_495_1.text_.text = var_498_8

				LuaForUtil.ClearLinePrefixSymbol(arg_495_1.text_)

				local var_498_9 = 23
				local var_498_10 = utf8.len(var_498_8)
				local var_498_11 = var_498_9 <= 0 and var_498_5 or var_498_5 * (var_498_10 / var_498_9)

				if var_498_11 > 0 and var_498_5 < var_498_11 then
					arg_495_1.talkMaxDuration = var_498_11

					if var_498_11 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_11 + var_498_4
					end
				end

				arg_495_1.text_.text = var_498_8
				arg_495_1.typewritter.percent = 0

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") ~= 0 then
					local var_498_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051122", "story_v_out_411051.awb") / 1000

					if var_498_12 + var_498_4 > arg_495_1.duration_ then
						arg_495_1.duration_ = var_498_12 + var_498_4
					end

					if var_498_7.prefab_name ~= "" and arg_495_1.actors_[var_498_7.prefab_name] ~= nil then
						local var_498_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_495_1.actors_[var_498_7.prefab_name].transform, "story_v_out_411051", "411051122", "story_v_out_411051.awb")

						arg_495_1:RecordAudio("411051122", var_498_13)
						arg_495_1:RecordAudio("411051122", var_498_13)
					else
						arg_495_1:AudioAction("play", "voice", "story_v_out_411051", "411051122", "story_v_out_411051.awb")
					end

					arg_495_1:RecordHistoryTalkVoice("story_v_out_411051", "411051122", "story_v_out_411051.awb")
				end

				arg_495_1:RecordContent(arg_495_1.text_.text)
			end

			local var_498_14 = math.max(var_498_5, arg_495_1.talkMaxDuration)

			if var_498_4 <= arg_495_1.time_ and arg_495_1.time_ < var_498_4 + var_498_14 then
				arg_495_1.typewritter.percent = (arg_495_1.time_ - var_498_4) / var_498_14

				arg_495_1.typewritter:SetDirty()
			end

			if arg_495_1.time_ >= var_498_4 + var_498_14 and arg_495_1.time_ < var_498_4 + var_498_14 + arg_498_0 then
				arg_495_1.typewritter.percent = 1

				arg_495_1.typewritter:SetDirty()
				arg_495_1:ShowNextGo(true)
			end
		end
	end,
	Play411051123 = function(arg_499_0, arg_499_1)
		arg_499_1.time_ = 0
		arg_499_1.frameCnt_ = 0
		arg_499_1.state_ = "playing"
		arg_499_1.curTalkId_ = 411051123
		arg_499_1.duration_ = 5.6

		local var_499_0 = {
			zh = 5.6,
			ja = 5.566
		}
		local var_499_1 = manager.audio:GetLocalizationFlag()

		if var_499_0[var_499_1] ~= nil then
			arg_499_1.duration_ = var_499_0[var_499_1]
		end

		SetActive(arg_499_1.tipsGo_, false)

		function arg_499_1.onSingleLineFinish_()
			arg_499_1.onSingleLineUpdate_ = nil
			arg_499_1.onSingleLineFinish_ = nil
			arg_499_1.state_ = "waiting"
		end

		function arg_499_1.playNext_(arg_501_0)
			if arg_501_0 == 1 then
				arg_499_0:Play411051124(arg_499_1)
			end
		end

		function arg_499_1.onSingleLineUpdate_(arg_502_0)
			local var_502_0 = arg_499_1.actors_["1095ui_story"]
			local var_502_1 = 0

			if var_502_1 < arg_499_1.time_ and arg_499_1.time_ <= var_502_1 + arg_502_0 and arg_499_1.var_.characterEffect1095ui_story == nil then
				arg_499_1.var_.characterEffect1095ui_story = var_502_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_502_2 = 0.200000002980232

			if var_502_1 <= arg_499_1.time_ and arg_499_1.time_ < var_502_1 + var_502_2 then
				local var_502_3 = (arg_499_1.time_ - var_502_1) / var_502_2

				if arg_499_1.var_.characterEffect1095ui_story then
					local var_502_4 = Mathf.Lerp(0, 0.5, var_502_3)

					arg_499_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_499_1.var_.characterEffect1095ui_story.fillRatio = var_502_4
				end
			end

			if arg_499_1.time_ >= var_502_1 + var_502_2 and arg_499_1.time_ < var_502_1 + var_502_2 + arg_502_0 and arg_499_1.var_.characterEffect1095ui_story then
				local var_502_5 = 0.5

				arg_499_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_499_1.var_.characterEffect1095ui_story.fillRatio = var_502_5
			end

			local var_502_6 = 0
			local var_502_7 = 0.5

			if var_502_6 < arg_499_1.time_ and arg_499_1.time_ <= var_502_6 + arg_502_0 then
				arg_499_1.talkMaxDuration = 0
				arg_499_1.dialogCg_.alpha = 1

				arg_499_1.dialog_:SetActive(true)
				SetActive(arg_499_1.leftNameGo_, true)

				local var_502_8 = arg_499_1:FormatText(StoryNameCfg[39].name)

				arg_499_1.leftNameTxt_.text = var_502_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_499_1.leftNameTxt_.transform)

				arg_499_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_499_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_499_1:RecordName(arg_499_1.leftNameTxt_.text)
				SetActive(arg_499_1.iconTrs_.gameObject, true)
				arg_499_1.iconController_:SetSelectedState("hero")

				arg_499_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_499_1.callingController_:SetSelectedState("normal")

				local var_502_9 = arg_499_1:GetWordFromCfg(411051123)
				local var_502_10 = arg_499_1:FormatText(var_502_9.content)

				arg_499_1.text_.text = var_502_10

				LuaForUtil.ClearLinePrefixSymbol(arg_499_1.text_)

				local var_502_11 = 20
				local var_502_12 = utf8.len(var_502_10)
				local var_502_13 = var_502_11 <= 0 and var_502_7 or var_502_7 * (var_502_12 / var_502_11)

				if var_502_13 > 0 and var_502_7 < var_502_13 then
					arg_499_1.talkMaxDuration = var_502_13

					if var_502_13 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_13 + var_502_6
					end
				end

				arg_499_1.text_.text = var_502_10
				arg_499_1.typewritter.percent = 0

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") ~= 0 then
					local var_502_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051123", "story_v_out_411051.awb") / 1000

					if var_502_14 + var_502_6 > arg_499_1.duration_ then
						arg_499_1.duration_ = var_502_14 + var_502_6
					end

					if var_502_9.prefab_name ~= "" and arg_499_1.actors_[var_502_9.prefab_name] ~= nil then
						local var_502_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_499_1.actors_[var_502_9.prefab_name].transform, "story_v_out_411051", "411051123", "story_v_out_411051.awb")

						arg_499_1:RecordAudio("411051123", var_502_15)
						arg_499_1:RecordAudio("411051123", var_502_15)
					else
						arg_499_1:AudioAction("play", "voice", "story_v_out_411051", "411051123", "story_v_out_411051.awb")
					end

					arg_499_1:RecordHistoryTalkVoice("story_v_out_411051", "411051123", "story_v_out_411051.awb")
				end

				arg_499_1:RecordContent(arg_499_1.text_.text)
			end

			local var_502_16 = math.max(var_502_7, arg_499_1.talkMaxDuration)

			if var_502_6 <= arg_499_1.time_ and arg_499_1.time_ < var_502_6 + var_502_16 then
				arg_499_1.typewritter.percent = (arg_499_1.time_ - var_502_6) / var_502_16

				arg_499_1.typewritter:SetDirty()
			end

			if arg_499_1.time_ >= var_502_6 + var_502_16 and arg_499_1.time_ < var_502_6 + var_502_16 + arg_502_0 then
				arg_499_1.typewritter.percent = 1

				arg_499_1.typewritter:SetDirty()
				arg_499_1:ShowNextGo(true)
			end
		end
	end,
	Play411051124 = function(arg_503_0, arg_503_1)
		arg_503_1.time_ = 0
		arg_503_1.frameCnt_ = 0
		arg_503_1.state_ = "playing"
		arg_503_1.curTalkId_ = 411051124
		arg_503_1.duration_ = 4.1

		local var_503_0 = {
			zh = 3,
			ja = 4.1
		}
		local var_503_1 = manager.audio:GetLocalizationFlag()

		if var_503_0[var_503_1] ~= nil then
			arg_503_1.duration_ = var_503_0[var_503_1]
		end

		SetActive(arg_503_1.tipsGo_, false)

		function arg_503_1.onSingleLineFinish_()
			arg_503_1.onSingleLineUpdate_ = nil
			arg_503_1.onSingleLineFinish_ = nil
			arg_503_1.state_ = "waiting"
		end

		function arg_503_1.playNext_(arg_505_0)
			if arg_505_0 == 1 then
				arg_503_0:Play411051125(arg_503_1)
			end
		end

		function arg_503_1.onSingleLineUpdate_(arg_506_0)
			local var_506_0 = arg_503_1.actors_["1095ui_story"]
			local var_506_1 = 0

			if var_506_1 < arg_503_1.time_ and arg_503_1.time_ <= var_506_1 + arg_506_0 and arg_503_1.var_.characterEffect1095ui_story == nil then
				arg_503_1.var_.characterEffect1095ui_story = var_506_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_506_2 = 0.200000002980232

			if var_506_1 <= arg_503_1.time_ and arg_503_1.time_ < var_506_1 + var_506_2 then
				local var_506_3 = (arg_503_1.time_ - var_506_1) / var_506_2

				if arg_503_1.var_.characterEffect1095ui_story then
					arg_503_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_503_1.time_ >= var_506_1 + var_506_2 and arg_503_1.time_ < var_506_1 + var_506_2 + arg_506_0 and arg_503_1.var_.characterEffect1095ui_story then
				arg_503_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_506_4 = 0
			local var_506_5 = 0.375

			if var_506_4 < arg_503_1.time_ and arg_503_1.time_ <= var_506_4 + arg_506_0 then
				arg_503_1.talkMaxDuration = 0
				arg_503_1.dialogCg_.alpha = 1

				arg_503_1.dialog_:SetActive(true)
				SetActive(arg_503_1.leftNameGo_, true)

				local var_506_6 = arg_503_1:FormatText(StoryNameCfg[471].name)

				arg_503_1.leftNameTxt_.text = var_506_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_503_1.leftNameTxt_.transform)

				arg_503_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_503_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_503_1:RecordName(arg_503_1.leftNameTxt_.text)
				SetActive(arg_503_1.iconTrs_.gameObject, false)
				arg_503_1.callingController_:SetSelectedState("normal")

				local var_506_7 = arg_503_1:GetWordFromCfg(411051124)
				local var_506_8 = arg_503_1:FormatText(var_506_7.content)

				arg_503_1.text_.text = var_506_8

				LuaForUtil.ClearLinePrefixSymbol(arg_503_1.text_)

				local var_506_9 = 15
				local var_506_10 = utf8.len(var_506_8)
				local var_506_11 = var_506_9 <= 0 and var_506_5 or var_506_5 * (var_506_10 / var_506_9)

				if var_506_11 > 0 and var_506_5 < var_506_11 then
					arg_503_1.talkMaxDuration = var_506_11

					if var_506_11 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_11 + var_506_4
					end
				end

				arg_503_1.text_.text = var_506_8
				arg_503_1.typewritter.percent = 0

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") ~= 0 then
					local var_506_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051124", "story_v_out_411051.awb") / 1000

					if var_506_12 + var_506_4 > arg_503_1.duration_ then
						arg_503_1.duration_ = var_506_12 + var_506_4
					end

					if var_506_7.prefab_name ~= "" and arg_503_1.actors_[var_506_7.prefab_name] ~= nil then
						local var_506_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_503_1.actors_[var_506_7.prefab_name].transform, "story_v_out_411051", "411051124", "story_v_out_411051.awb")

						arg_503_1:RecordAudio("411051124", var_506_13)
						arg_503_1:RecordAudio("411051124", var_506_13)
					else
						arg_503_1:AudioAction("play", "voice", "story_v_out_411051", "411051124", "story_v_out_411051.awb")
					end

					arg_503_1:RecordHistoryTalkVoice("story_v_out_411051", "411051124", "story_v_out_411051.awb")
				end

				arg_503_1:RecordContent(arg_503_1.text_.text)
			end

			local var_506_14 = math.max(var_506_5, arg_503_1.talkMaxDuration)

			if var_506_4 <= arg_503_1.time_ and arg_503_1.time_ < var_506_4 + var_506_14 then
				arg_503_1.typewritter.percent = (arg_503_1.time_ - var_506_4) / var_506_14

				arg_503_1.typewritter:SetDirty()
			end

			if arg_503_1.time_ >= var_506_4 + var_506_14 and arg_503_1.time_ < var_506_4 + var_506_14 + arg_506_0 then
				arg_503_1.typewritter.percent = 1

				arg_503_1.typewritter:SetDirty()
				arg_503_1:ShowNextGo(true)
			end
		end
	end,
	Play411051125 = function(arg_507_0, arg_507_1)
		arg_507_1.time_ = 0
		arg_507_1.frameCnt_ = 0
		arg_507_1.state_ = "playing"
		arg_507_1.curTalkId_ = 411051125
		arg_507_1.duration_ = 9.166

		local var_507_0 = {
			zh = 9.166,
			ja = 6.5
		}
		local var_507_1 = manager.audio:GetLocalizationFlag()

		if var_507_0[var_507_1] ~= nil then
			arg_507_1.duration_ = var_507_0[var_507_1]
		end

		SetActive(arg_507_1.tipsGo_, false)

		function arg_507_1.onSingleLineFinish_()
			arg_507_1.onSingleLineUpdate_ = nil
			arg_507_1.onSingleLineFinish_ = nil
			arg_507_1.state_ = "waiting"
		end

		function arg_507_1.playNext_(arg_509_0)
			if arg_509_0 == 1 then
				arg_507_0:Play411051126(arg_507_1)
			end
		end

		function arg_507_1.onSingleLineUpdate_(arg_510_0)
			local var_510_0 = arg_507_1.actors_["1095ui_story"]
			local var_510_1 = 0

			if var_510_1 < arg_507_1.time_ and arg_507_1.time_ <= var_510_1 + arg_510_0 and arg_507_1.var_.characterEffect1095ui_story == nil then
				arg_507_1.var_.characterEffect1095ui_story = var_510_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_510_2 = 0.200000002980232

			if var_510_1 <= arg_507_1.time_ and arg_507_1.time_ < var_510_1 + var_510_2 then
				local var_510_3 = (arg_507_1.time_ - var_510_1) / var_510_2

				if arg_507_1.var_.characterEffect1095ui_story then
					local var_510_4 = Mathf.Lerp(0, 0.5, var_510_3)

					arg_507_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_507_1.var_.characterEffect1095ui_story.fillRatio = var_510_4
				end
			end

			if arg_507_1.time_ >= var_510_1 + var_510_2 and arg_507_1.time_ < var_510_1 + var_510_2 + arg_510_0 and arg_507_1.var_.characterEffect1095ui_story then
				local var_510_5 = 0.5

				arg_507_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_507_1.var_.characterEffect1095ui_story.fillRatio = var_510_5
			end

			local var_510_6 = 0
			local var_510_7 = 0.95

			if var_510_6 < arg_507_1.time_ and arg_507_1.time_ <= var_510_6 + arg_510_0 then
				arg_507_1.talkMaxDuration = 0
				arg_507_1.dialogCg_.alpha = 1

				arg_507_1.dialog_:SetActive(true)
				SetActive(arg_507_1.leftNameGo_, true)

				local var_510_8 = arg_507_1:FormatText(StoryNameCfg[39].name)

				arg_507_1.leftNameTxt_.text = var_510_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_507_1.leftNameTxt_.transform)

				arg_507_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_507_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_507_1:RecordName(arg_507_1.leftNameTxt_.text)
				SetActive(arg_507_1.iconTrs_.gameObject, true)
				arg_507_1.iconController_:SetSelectedState("hero")

				arg_507_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_507_1.callingController_:SetSelectedState("normal")

				local var_510_9 = arg_507_1:GetWordFromCfg(411051125)
				local var_510_10 = arg_507_1:FormatText(var_510_9.content)

				arg_507_1.text_.text = var_510_10

				LuaForUtil.ClearLinePrefixSymbol(arg_507_1.text_)

				local var_510_11 = 38
				local var_510_12 = utf8.len(var_510_10)
				local var_510_13 = var_510_11 <= 0 and var_510_7 or var_510_7 * (var_510_12 / var_510_11)

				if var_510_13 > 0 and var_510_7 < var_510_13 then
					arg_507_1.talkMaxDuration = var_510_13

					if var_510_13 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_13 + var_510_6
					end
				end

				arg_507_1.text_.text = var_510_10
				arg_507_1.typewritter.percent = 0

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") ~= 0 then
					local var_510_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051125", "story_v_out_411051.awb") / 1000

					if var_510_14 + var_510_6 > arg_507_1.duration_ then
						arg_507_1.duration_ = var_510_14 + var_510_6
					end

					if var_510_9.prefab_name ~= "" and arg_507_1.actors_[var_510_9.prefab_name] ~= nil then
						local var_510_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_507_1.actors_[var_510_9.prefab_name].transform, "story_v_out_411051", "411051125", "story_v_out_411051.awb")

						arg_507_1:RecordAudio("411051125", var_510_15)
						arg_507_1:RecordAudio("411051125", var_510_15)
					else
						arg_507_1:AudioAction("play", "voice", "story_v_out_411051", "411051125", "story_v_out_411051.awb")
					end

					arg_507_1:RecordHistoryTalkVoice("story_v_out_411051", "411051125", "story_v_out_411051.awb")
				end

				arg_507_1:RecordContent(arg_507_1.text_.text)
			end

			local var_510_16 = math.max(var_510_7, arg_507_1.talkMaxDuration)

			if var_510_6 <= arg_507_1.time_ and arg_507_1.time_ < var_510_6 + var_510_16 then
				arg_507_1.typewritter.percent = (arg_507_1.time_ - var_510_6) / var_510_16

				arg_507_1.typewritter:SetDirty()
			end

			if arg_507_1.time_ >= var_510_6 + var_510_16 and arg_507_1.time_ < var_510_6 + var_510_16 + arg_510_0 then
				arg_507_1.typewritter.percent = 1

				arg_507_1.typewritter:SetDirty()
				arg_507_1:ShowNextGo(true)
			end
		end
	end,
	Play411051126 = function(arg_511_0, arg_511_1)
		arg_511_1.time_ = 0
		arg_511_1.frameCnt_ = 0
		arg_511_1.state_ = "playing"
		arg_511_1.curTalkId_ = 411051126
		arg_511_1.duration_ = 14.3

		local var_511_0 = {
			zh = 14.3,
			ja = 4.766
		}
		local var_511_1 = manager.audio:GetLocalizationFlag()

		if var_511_0[var_511_1] ~= nil then
			arg_511_1.duration_ = var_511_0[var_511_1]
		end

		SetActive(arg_511_1.tipsGo_, false)

		function arg_511_1.onSingleLineFinish_()
			arg_511_1.onSingleLineUpdate_ = nil
			arg_511_1.onSingleLineFinish_ = nil
			arg_511_1.state_ = "waiting"
		end

		function arg_511_1.playNext_(arg_513_0)
			if arg_513_0 == 1 then
				arg_511_0:Play411051127(arg_511_1)
			end
		end

		function arg_511_1.onSingleLineUpdate_(arg_514_0)
			local var_514_0 = 0
			local var_514_1 = 1.425

			if var_514_0 < arg_511_1.time_ and arg_511_1.time_ <= var_514_0 + arg_514_0 then
				arg_511_1.talkMaxDuration = 0
				arg_511_1.dialogCg_.alpha = 1

				arg_511_1.dialog_:SetActive(true)
				SetActive(arg_511_1.leftNameGo_, true)

				local var_514_2 = arg_511_1:FormatText(StoryNameCfg[39].name)

				arg_511_1.leftNameTxt_.text = var_514_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_511_1.leftNameTxt_.transform)

				arg_511_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_511_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_511_1:RecordName(arg_511_1.leftNameTxt_.text)
				SetActive(arg_511_1.iconTrs_.gameObject, true)
				arg_511_1.iconController_:SetSelectedState("hero")

				arg_511_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_511_1.callingController_:SetSelectedState("normal")

				local var_514_3 = arg_511_1:GetWordFromCfg(411051126)
				local var_514_4 = arg_511_1:FormatText(var_514_3.content)

				arg_511_1.text_.text = var_514_4

				LuaForUtil.ClearLinePrefixSymbol(arg_511_1.text_)

				local var_514_5 = 57
				local var_514_6 = utf8.len(var_514_4)
				local var_514_7 = var_514_5 <= 0 and var_514_1 or var_514_1 * (var_514_6 / var_514_5)

				if var_514_7 > 0 and var_514_1 < var_514_7 then
					arg_511_1.talkMaxDuration = var_514_7

					if var_514_7 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_7 + var_514_0
					end
				end

				arg_511_1.text_.text = var_514_4
				arg_511_1.typewritter.percent = 0

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") ~= 0 then
					local var_514_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051126", "story_v_out_411051.awb") / 1000

					if var_514_8 + var_514_0 > arg_511_1.duration_ then
						arg_511_1.duration_ = var_514_8 + var_514_0
					end

					if var_514_3.prefab_name ~= "" and arg_511_1.actors_[var_514_3.prefab_name] ~= nil then
						local var_514_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_511_1.actors_[var_514_3.prefab_name].transform, "story_v_out_411051", "411051126", "story_v_out_411051.awb")

						arg_511_1:RecordAudio("411051126", var_514_9)
						arg_511_1:RecordAudio("411051126", var_514_9)
					else
						arg_511_1:AudioAction("play", "voice", "story_v_out_411051", "411051126", "story_v_out_411051.awb")
					end

					arg_511_1:RecordHistoryTalkVoice("story_v_out_411051", "411051126", "story_v_out_411051.awb")
				end

				arg_511_1:RecordContent(arg_511_1.text_.text)
			end

			local var_514_10 = math.max(var_514_1, arg_511_1.talkMaxDuration)

			if var_514_0 <= arg_511_1.time_ and arg_511_1.time_ < var_514_0 + var_514_10 then
				arg_511_1.typewritter.percent = (arg_511_1.time_ - var_514_0) / var_514_10

				arg_511_1.typewritter:SetDirty()
			end

			if arg_511_1.time_ >= var_514_0 + var_514_10 and arg_511_1.time_ < var_514_0 + var_514_10 + arg_514_0 then
				arg_511_1.typewritter.percent = 1

				arg_511_1.typewritter:SetDirty()
				arg_511_1:ShowNextGo(true)
			end
		end
	end,
	Play411051127 = function(arg_515_0, arg_515_1)
		arg_515_1.time_ = 0
		arg_515_1.frameCnt_ = 0
		arg_515_1.state_ = "playing"
		arg_515_1.curTalkId_ = 411051127
		arg_515_1.duration_ = 4.4

		local var_515_0 = {
			zh = 4.4,
			ja = 3.1
		}
		local var_515_1 = manager.audio:GetLocalizationFlag()

		if var_515_0[var_515_1] ~= nil then
			arg_515_1.duration_ = var_515_0[var_515_1]
		end

		SetActive(arg_515_1.tipsGo_, false)

		function arg_515_1.onSingleLineFinish_()
			arg_515_1.onSingleLineUpdate_ = nil
			arg_515_1.onSingleLineFinish_ = nil
			arg_515_1.state_ = "waiting"
		end

		function arg_515_1.playNext_(arg_517_0)
			if arg_517_0 == 1 then
				arg_515_0:Play411051128(arg_515_1)
			end
		end

		function arg_515_1.onSingleLineUpdate_(arg_518_0)
			local var_518_0 = arg_515_1.actors_["1095ui_story"]
			local var_518_1 = 0

			if var_518_1 < arg_515_1.time_ and arg_515_1.time_ <= var_518_1 + arg_518_0 and arg_515_1.var_.characterEffect1095ui_story == nil then
				arg_515_1.var_.characterEffect1095ui_story = var_518_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_518_2 = 0.200000002980232

			if var_518_1 <= arg_515_1.time_ and arg_515_1.time_ < var_518_1 + var_518_2 then
				local var_518_3 = (arg_515_1.time_ - var_518_1) / var_518_2

				if arg_515_1.var_.characterEffect1095ui_story then
					arg_515_1.var_.characterEffect1095ui_story.fillFlat = false
				end
			end

			if arg_515_1.time_ >= var_518_1 + var_518_2 and arg_515_1.time_ < var_518_1 + var_518_2 + arg_518_0 and arg_515_1.var_.characterEffect1095ui_story then
				arg_515_1.var_.characterEffect1095ui_story.fillFlat = false
			end

			local var_518_4 = 0
			local var_518_5 = 0.525

			if var_518_4 < arg_515_1.time_ and arg_515_1.time_ <= var_518_4 + arg_518_0 then
				arg_515_1.talkMaxDuration = 0
				arg_515_1.dialogCg_.alpha = 1

				arg_515_1.dialog_:SetActive(true)
				SetActive(arg_515_1.leftNameGo_, true)

				local var_518_6 = arg_515_1:FormatText(StoryNameCfg[471].name)

				arg_515_1.leftNameTxt_.text = var_518_6

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_515_1.leftNameTxt_.transform)

				arg_515_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_515_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_515_1:RecordName(arg_515_1.leftNameTxt_.text)
				SetActive(arg_515_1.iconTrs_.gameObject, false)
				arg_515_1.callingController_:SetSelectedState("normal")

				local var_518_7 = arg_515_1:GetWordFromCfg(411051127)
				local var_518_8 = arg_515_1:FormatText(var_518_7.content)

				arg_515_1.text_.text = var_518_8

				LuaForUtil.ClearLinePrefixSymbol(arg_515_1.text_)

				local var_518_9 = 21
				local var_518_10 = utf8.len(var_518_8)
				local var_518_11 = var_518_9 <= 0 and var_518_5 or var_518_5 * (var_518_10 / var_518_9)

				if var_518_11 > 0 and var_518_5 < var_518_11 then
					arg_515_1.talkMaxDuration = var_518_11

					if var_518_11 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_11 + var_518_4
					end
				end

				arg_515_1.text_.text = var_518_8
				arg_515_1.typewritter.percent = 0

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") ~= 0 then
					local var_518_12 = manager.audio:GetVoiceLength("story_v_out_411051", "411051127", "story_v_out_411051.awb") / 1000

					if var_518_12 + var_518_4 > arg_515_1.duration_ then
						arg_515_1.duration_ = var_518_12 + var_518_4
					end

					if var_518_7.prefab_name ~= "" and arg_515_1.actors_[var_518_7.prefab_name] ~= nil then
						local var_518_13 = LuaForUtil.PlayVoiceWithCriLipsync(arg_515_1.actors_[var_518_7.prefab_name].transform, "story_v_out_411051", "411051127", "story_v_out_411051.awb")

						arg_515_1:RecordAudio("411051127", var_518_13)
						arg_515_1:RecordAudio("411051127", var_518_13)
					else
						arg_515_1:AudioAction("play", "voice", "story_v_out_411051", "411051127", "story_v_out_411051.awb")
					end

					arg_515_1:RecordHistoryTalkVoice("story_v_out_411051", "411051127", "story_v_out_411051.awb")
				end

				arg_515_1:RecordContent(arg_515_1.text_.text)
			end

			local var_518_14 = math.max(var_518_5, arg_515_1.talkMaxDuration)

			if var_518_4 <= arg_515_1.time_ and arg_515_1.time_ < var_518_4 + var_518_14 then
				arg_515_1.typewritter.percent = (arg_515_1.time_ - var_518_4) / var_518_14

				arg_515_1.typewritter:SetDirty()
			end

			if arg_515_1.time_ >= var_518_4 + var_518_14 and arg_515_1.time_ < var_518_4 + var_518_14 + arg_518_0 then
				arg_515_1.typewritter.percent = 1

				arg_515_1.typewritter:SetDirty()
				arg_515_1:ShowNextGo(true)
			end
		end
	end,
	Play411051128 = function(arg_519_0, arg_519_1)
		arg_519_1.time_ = 0
		arg_519_1.frameCnt_ = 0
		arg_519_1.state_ = "playing"
		arg_519_1.curTalkId_ = 411051128
		arg_519_1.duration_ = 4.4

		local var_519_0 = {
			zh = 4.4,
			ja = 4.3
		}
		local var_519_1 = manager.audio:GetLocalizationFlag()

		if var_519_0[var_519_1] ~= nil then
			arg_519_1.duration_ = var_519_0[var_519_1]
		end

		SetActive(arg_519_1.tipsGo_, false)

		function arg_519_1.onSingleLineFinish_()
			arg_519_1.onSingleLineUpdate_ = nil
			arg_519_1.onSingleLineFinish_ = nil
			arg_519_1.state_ = "waiting"
		end

		function arg_519_1.playNext_(arg_521_0)
			if arg_521_0 == 1 then
				arg_519_0:Play411051129(arg_519_1)
			end
		end

		function arg_519_1.onSingleLineUpdate_(arg_522_0)
			local var_522_0 = 0
			local var_522_1 = 0.55

			if var_522_0 < arg_519_1.time_ and arg_519_1.time_ <= var_522_0 + arg_522_0 then
				arg_519_1.talkMaxDuration = 0
				arg_519_1.dialogCg_.alpha = 1

				arg_519_1.dialog_:SetActive(true)
				SetActive(arg_519_1.leftNameGo_, true)

				local var_522_2 = arg_519_1:FormatText(StoryNameCfg[471].name)

				arg_519_1.leftNameTxt_.text = var_522_2

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_519_1.leftNameTxt_.transform)

				arg_519_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_519_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_519_1:RecordName(arg_519_1.leftNameTxt_.text)
				SetActive(arg_519_1.iconTrs_.gameObject, false)
				arg_519_1.callingController_:SetSelectedState("normal")

				local var_522_3 = arg_519_1:GetWordFromCfg(411051128)
				local var_522_4 = arg_519_1:FormatText(var_522_3.content)

				arg_519_1.text_.text = var_522_4

				LuaForUtil.ClearLinePrefixSymbol(arg_519_1.text_)

				local var_522_5 = 22
				local var_522_6 = utf8.len(var_522_4)
				local var_522_7 = var_522_5 <= 0 and var_522_1 or var_522_1 * (var_522_6 / var_522_5)

				if var_522_7 > 0 and var_522_1 < var_522_7 then
					arg_519_1.talkMaxDuration = var_522_7

					if var_522_7 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_7 + var_522_0
					end
				end

				arg_519_1.text_.text = var_522_4
				arg_519_1.typewritter.percent = 0

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") ~= 0 then
					local var_522_8 = manager.audio:GetVoiceLength("story_v_out_411051", "411051128", "story_v_out_411051.awb") / 1000

					if var_522_8 + var_522_0 > arg_519_1.duration_ then
						arg_519_1.duration_ = var_522_8 + var_522_0
					end

					if var_522_3.prefab_name ~= "" and arg_519_1.actors_[var_522_3.prefab_name] ~= nil then
						local var_522_9 = LuaForUtil.PlayVoiceWithCriLipsync(arg_519_1.actors_[var_522_3.prefab_name].transform, "story_v_out_411051", "411051128", "story_v_out_411051.awb")

						arg_519_1:RecordAudio("411051128", var_522_9)
						arg_519_1:RecordAudio("411051128", var_522_9)
					else
						arg_519_1:AudioAction("play", "voice", "story_v_out_411051", "411051128", "story_v_out_411051.awb")
					end

					arg_519_1:RecordHistoryTalkVoice("story_v_out_411051", "411051128", "story_v_out_411051.awb")
				end

				arg_519_1:RecordContent(arg_519_1.text_.text)
			end

			local var_522_10 = math.max(var_522_1, arg_519_1.talkMaxDuration)

			if var_522_0 <= arg_519_1.time_ and arg_519_1.time_ < var_522_0 + var_522_10 then
				arg_519_1.typewritter.percent = (arg_519_1.time_ - var_522_0) / var_522_10

				arg_519_1.typewritter:SetDirty()
			end

			if arg_519_1.time_ >= var_522_0 + var_522_10 and arg_519_1.time_ < var_522_0 + var_522_10 + arg_522_0 then
				arg_519_1.typewritter.percent = 1

				arg_519_1.typewritter:SetDirty()
				arg_519_1:ShowNextGo(true)
			end
		end
	end,
	Play411051129 = function(arg_523_0, arg_523_1)
		arg_523_1.time_ = 0
		arg_523_1.frameCnt_ = 0
		arg_523_1.state_ = "playing"
		arg_523_1.curTalkId_ = 411051129
		arg_523_1.duration_ = 2.3

		local var_523_0 = {
			zh = 2.3,
			ja = 2.133
		}
		local var_523_1 = manager.audio:GetLocalizationFlag()

		if var_523_0[var_523_1] ~= nil then
			arg_523_1.duration_ = var_523_0[var_523_1]
		end

		SetActive(arg_523_1.tipsGo_, false)

		function arg_523_1.onSingleLineFinish_()
			arg_523_1.onSingleLineUpdate_ = nil
			arg_523_1.onSingleLineFinish_ = nil
			arg_523_1.state_ = "waiting"
			arg_523_1.auto_ = false
		end

		function arg_523_1.playNext_(arg_525_0)
			arg_523_1.onStoryFinished_()
		end

		function arg_523_1.onSingleLineUpdate_(arg_526_0)
			local var_526_0 = arg_523_1.actors_["1095ui_story"]
			local var_526_1 = 0

			if var_526_1 < arg_523_1.time_ and arg_523_1.time_ <= var_526_1 + arg_526_0 and arg_523_1.var_.characterEffect1095ui_story == nil then
				arg_523_1.var_.characterEffect1095ui_story = var_526_0:GetComponentInChildren(typeof(CharacterEffect))
			end

			local var_526_2 = 0.200000002980232

			if var_526_1 <= arg_523_1.time_ and arg_523_1.time_ < var_526_1 + var_526_2 then
				local var_526_3 = (arg_523_1.time_ - var_526_1) / var_526_2

				if arg_523_1.var_.characterEffect1095ui_story then
					local var_526_4 = Mathf.Lerp(0, 0.5, var_526_3)

					arg_523_1.var_.characterEffect1095ui_story.fillFlat = true
					arg_523_1.var_.characterEffect1095ui_story.fillRatio = var_526_4
				end
			end

			if arg_523_1.time_ >= var_526_1 + var_526_2 and arg_523_1.time_ < var_526_1 + var_526_2 + arg_526_0 and arg_523_1.var_.characterEffect1095ui_story then
				local var_526_5 = 0.5

				arg_523_1.var_.characterEffect1095ui_story.fillFlat = true
				arg_523_1.var_.characterEffect1095ui_story.fillRatio = var_526_5
			end

			local var_526_6 = 0
			local var_526_7 = 0.2

			if var_526_6 < arg_523_1.time_ and arg_523_1.time_ <= var_526_6 + arg_526_0 then
				arg_523_1.talkMaxDuration = 0
				arg_523_1.dialogCg_.alpha = 1

				arg_523_1.dialog_:SetActive(true)
				SetActive(arg_523_1.leftNameGo_, true)

				local var_526_8 = arg_523_1:FormatText(StoryNameCfg[39].name)

				arg_523_1.leftNameTxt_.text = var_526_8

				UnityEngine.UI.LayoutRebuilder.ForceRebuildLayoutImmediate(arg_523_1.leftNameTxt_.transform)

				arg_523_1.contentImage_.sprite = getSpriteWithoutAtlas("TextureConfig/Common/board_dialogue_narrator")
				arg_523_1.contentRectCom_.sizeDelta = Vector2(1644, 265)

				arg_523_1:RecordName(arg_523_1.leftNameTxt_.text)
				SetActive(arg_523_1.iconTrs_.gameObject, true)
				arg_523_1.iconController_:SetSelectedState("hero")

				arg_523_1.icon_.sprite = getSpriteWithoutAtlas("TextureConfig/Story/Character/" .. "story_10002a")

				arg_523_1.callingController_:SetSelectedState("normal")

				local var_526_9 = arg_523_1:GetWordFromCfg(411051129)
				local var_526_10 = arg_523_1:FormatText(var_526_9.content)

				arg_523_1.text_.text = var_526_10

				LuaForUtil.ClearLinePrefixSymbol(arg_523_1.text_)

				local var_526_11 = 8
				local var_526_12 = utf8.len(var_526_10)
				local var_526_13 = var_526_11 <= 0 and var_526_7 or var_526_7 * (var_526_12 / var_526_11)

				if var_526_13 > 0 and var_526_7 < var_526_13 then
					arg_523_1.talkMaxDuration = var_526_13

					if var_526_13 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_13 + var_526_6
					end
				end

				arg_523_1.text_.text = var_526_10
				arg_523_1.typewritter.percent = 0

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(false)

				if manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") ~= 0 then
					local var_526_14 = manager.audio:GetVoiceLength("story_v_out_411051", "411051129", "story_v_out_411051.awb") / 1000

					if var_526_14 + var_526_6 > arg_523_1.duration_ then
						arg_523_1.duration_ = var_526_14 + var_526_6
					end

					if var_526_9.prefab_name ~= "" and arg_523_1.actors_[var_526_9.prefab_name] ~= nil then
						local var_526_15 = LuaForUtil.PlayVoiceWithCriLipsync(arg_523_1.actors_[var_526_9.prefab_name].transform, "story_v_out_411051", "411051129", "story_v_out_411051.awb")

						arg_523_1:RecordAudio("411051129", var_526_15)
						arg_523_1:RecordAudio("411051129", var_526_15)
					else
						arg_523_1:AudioAction("play", "voice", "story_v_out_411051", "411051129", "story_v_out_411051.awb")
					end

					arg_523_1:RecordHistoryTalkVoice("story_v_out_411051", "411051129", "story_v_out_411051.awb")
				end

				arg_523_1:RecordContent(arg_523_1.text_.text)
			end

			local var_526_16 = math.max(var_526_7, arg_523_1.talkMaxDuration)

			if var_526_6 <= arg_523_1.time_ and arg_523_1.time_ < var_526_6 + var_526_16 then
				arg_523_1.typewritter.percent = (arg_523_1.time_ - var_526_6) / var_526_16

				arg_523_1.typewritter:SetDirty()
			end

			if arg_523_1.time_ >= var_526_6 + var_526_16 and arg_523_1.time_ < var_526_6 + var_526_16 + arg_526_0 then
				arg_523_1.typewritter.percent = 1

				arg_523_1.typewritter:SetDirty()
				arg_523_1:ShowNextGo(true)
			end
		end
	end,
	assets = {
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST74",
		"Assets/UIResources/UI_AB/TextureConfig/Background/ST03",
		"Assets/UIResources/UI_AB/TextureConfig/Background/I07",
		"Assets/UIResources/UI_AB/TextureConfig/Background/B10a"
	},
	voices = {
		"story_v_out_411051.awb"
	}
}
